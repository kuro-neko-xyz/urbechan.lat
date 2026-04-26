INSERT INTO boards(uri, title) VALUES('b', 'Random');

INSERT INTO threads(id, board_uri, subject) VALUES('31f65135-d6e6-410d-b66c-dbffa3b9f9e6', 'b', 'First Thread!');

INSERT INTO posts(thread_id, body, ip_address) VALUES ('31f65135-d6e6-410d-b66c-dbffa3b9f9e6', 'First Post!', '192.168.0.1');
INSERT INTO posts(thread_id, body, ip_address) VALUES ('31f65135-d6e6-410d-b66c-dbffa3b9f9e6', 'Second Post!!', '192.168.0.1');
INSERT INTO posts(thread_id, body, image_url, ip_address) VALUES ('31f65135-d6e6-410d-b66c-dbffa3b9f9e6', 'Third Post with an Image!!', 'https:localhost/', '192.168.0.1');
