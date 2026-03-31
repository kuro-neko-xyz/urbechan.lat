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
  id BIGSERIAL PRIMARY KEY
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
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
);