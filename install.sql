CREATE TABLE IF NOT EXISTS boards (
  -- Internal Identifiers
  uri VARCHAR(255) NOT NULL PRIMARY KEY,

  -- User Content
  title VARCHAR(255) NOT NULL,
  subtitle VARCHAR(255),

  -- Timestamps
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS threads (
  -- Internal Identifiers
  id UUID NOT NULL PRIMARY KEY,
  board_uri VARCHAR(255) NOT NULL REFERENCES boards(uri) ON DELETE CASCADE,

  -- User Content
  subject VARCHAR(255),

  -- Moderation & Security
  is_sticky BOOLEAN NOT NULL DEFAULT FALSE,
  is_locked BOOLEAN NOT NULL DEFAULT FALSE,

  -- Metadata
  reply_count INTEGER NOT NULL DEFAULT 0,
  image_count INTEGER NOT NULL DEFAULT 0,

  -- Timestamps
  bump_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS posts(
  -- Internal Identifiers
  id BIGSERIAL PRIMARY KEY,
  thread_id UUID NOT NULL REFERENCES threads(id) ON DELETE CASCADE,
  post_number INTEGER NOT NULL,

  -- User Content
  body TEXT,
  image_url VARCHAR(255), -- May update to support multiple images or different media types in the future
  thumbnail_url VARCHAR(255),
  file_hash VARCHAR(64),
  file_size INTEGER,
  image_width INTEGER,
  image_height INTEGER,

  -- Moderation & Security
  is_op BOOLEAN NOT NULL DEFAULT FALSE,
  ip_address INET NOT NULL,

  -- Timestamps
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION assign_post_number()
RETURNS TRIGGER AS $$
DECLARE
  parent_board VARCHAR(255);
  previous_post_number INTEGER;
BEGIN
  -- 1. Find the board_uri of the thread this post belongs to
  SELECT board_uri INTO parent_board FROM threads where id = NEW.thread_id;

  --2. Select the maximum post_number for the thread and increment it by 1 for the new post
  SELECT MAX(post_number) INTO previous_post_number FROM posts
  WHERE thread_id = NEW.thread_id;

  IF previous_post_number IS NULL THEN
    previous_post_number := 0;
  END IF;

  NEW.post_number := previous_post_number + 1;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS assign_post_number_trigger ON posts;

CREATE TRIGGER assign_post_number_trigger
BEFORE INSERT ON posts
FOR EACH ROW
EXECUTE FUNCTION assign_post_number();

-- TODO: Automatically update reply_count, image_count, and bump_time in threads when posts are added or removed.