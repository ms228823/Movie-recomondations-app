CREATE TABLE 'user' (
  'id' INT AUTO_INCREMENT PRIMARY KEY,
  'name' VARCHAR(255) NOT NULL,
  'email' VARCHAR(255) NOT NULL,
  'password' VARCHAR(255) NOT NULL
);

-- ALTER TABLE users
-- RENAME TO user;

-- Insert INTO user (name, email, password) VALUES ('Mohamed', 'Mohamed',1);


CREATE TABLE 'Show' (
  'id' INT AUTO_INCREMENT PRIMARY KEY,
  'name' VARCHAR(255) NOT NULL,
  'description' VARCHAR(255) NOT NULL,
  'rating' INT NOT NULL,
  'time' VARCHAR(255) NOT NULL,
  'age_limit' INT NOT NULL,
  'Category' VARCHAR(255) NOT NULL,
  'image' VARCHAR(255) NOT NULL,
  'Category_id' INT NOT NULL,
  "multimedia_type_id" INTEGER,
  "audience_type_id" INTEGER,
  FOREIGN KEY (Category_id) REFERENCES Category(id),
  FOREIGN KEY (multimedia_type_id) REFERENCES multimedia_type(id),
  FOREIGN KEY (audience_type_id) REFERENCES audience_type(id)
);

CREATE TABLE 'Category' (
  'id' INT AUTO_INCREMENT PRIMARY KEY,
  'name' VARCHAR(255) NOT NULL
);

-- multimedia_type
CREATE TABLE multimedia_type (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

-- audience_type
CREATE TABLE audience_type (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);


CREATE TABLE 'watch_later' (
  'id' INT AUTO_INCREMENT PRIMARY KEY,
  'user_id' INT NOT NULL,
  'show_id' INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (show_id) REFERENCES Show(id)
);

CREATE Table dislike (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  show_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (show_id) REFERENCES Show(id)
);

CREATE TABLE like (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  show_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (show_id) REFERENCES Show(id)
);

CREATE TABLE blocked (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  show_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (show_id) REFERENCES Show(id)
);

CREATE INDEX idx_watch_later_user_id ON watch_later(user_id);
CREATE INDEX idx_like_user_id ON like(user_id);
CREATE INDEX idx_dislike_user_id ON dislike(user_id);
CREATE INDEX idx_blocked_user_id ON blocked(user_id);

SELECT * FROM user;
SELECT * FROM Category;
SELECT * FROM Show;
SELECT * FROM like;
SELECT * FROM dislike;
SELECT * FROM watch_later;
SELECT * FROM multimedia_type;
SELECT * FROM audience_type;
SELECT * FROM blocked;
-- SELECT * FROM Comments;


-- delete all data from the tables
-- DELETE FROM user;
-- DELETE FROM Category;
-- DELETE FROM Show;
-- DELETE FROM like;
-- DELETE FROM dislike;
-- DELETE FROM watch_later;
-- DELETE FROM multimedia_type;
-- DELETE FROM audience_type;
-- DELETE FROM Comments;
-- DELETE FROM blocked;

-- drop table user;
-- drop table Category;
-- drop table Show;
-- drop table like;
-- drop table dislike;
-- drop table watch_later;
-- drop table multimedia_type;
-- drop table audience_type;
-- drop table Comments;
-- drop table blocked;
-- test
  SELECT 
      u.id AS user_id, 
      u.name AS user_name, 
      u.email AS user_email, 
      s.id AS show_id, 
      s.name AS show_name, 
      s.description AS show_description, 
      s.rating AS show_rating, 
      s.time AS show_time, 
      s.age_limit AS show_age_limit, 
      s.Category AS show_category, 
      c.id AS category_id, 
      c.name AS category_name,
      CASE WHEN l.show_id IS NOT NULL THEN 1 ELSE 0 END AS is_liked, 
      CASE WHEN d.show_id IS NOT NULL THEN 1 ELSE 0 END AS is_disliked
  FROM 
      user u
  JOIN 
      Show s ON s.Category_id = c.id
  JOIN 
      Category c ON c.id = s.Category_id
  LEFT JOIN 
      like l ON l.user_id = u.id AND l.show_id = s.id
  LEFT JOIN 
      dislike d ON d.user_id = u.id AND d.show_id = s.id
  WHERE 
      u.id = 2;

SELECT 
    u.id AS user_id, 
    u.name AS user_name, 
    u.email AS user_email, 
    s.id AS show_id, 
    s.name AS show_name, 
    s.description AS show_description, 
    s.rating AS show_rating, 
    s.time AS show_time, 
    s.age_limit AS show_age_limit, 
    s.Category AS show_category, 
    s.image AS show_image,
    c.id AS category_id, 
    c.name AS category_name,
    at.id AS audience_type_id,
    at.name AS audience_type_name,
    mt.id AS multimedia_type_id,
    mt.name AS multimedia_type_name,
    CASE WHEN l.show_id IS NOT NULL THEN 1 ELSE 0 END AS is_liked, 
    CASE WHEN d.show_id IS NOT NULL THEN 1 ELSE 0 END AS is_disliked,
    CASE WHEN b.show_id IS NOT NULL THEN 1 ELSE 0 END AS is_blocked,
    CASE WHEN wl.show_id IS NOT NULL THEN 1 ELSE 0 END AS is_watch_later
FROM 
    user u
JOIN 
    Show s ON s.Category_id = c.id
JOIN 
    Category c ON c.id = s.Category_id
LEFT JOIN 
    like l ON l.user_id = u.id AND l.show_id = s.id
LEFT JOIN 
    dislike d ON d.user_id = u.id AND d.show_id = s.id
LEFT JOIN 
    blocked b ON b.user_id = u.id AND b.show_id = s.id
LEFT JOIN 
    watch_later wl ON wl.user_id = u.id AND wl.show_id = s.id
LEFT JOIN 
    audience_type at ON at.id = s.audience_type_id
LEFT JOIN 
    multimedia_type mt ON mt.id = s.multimedia_type_id
WHERE 
    u.id = 2;




-- 
INSERT INTO watch_later (id, user_id, show_id)
VALUES
(1, 2, 3),  -- Bob will watch The Dark Knight later
(2, 2, 9),  -- Bob will watch It later (even though he dislikes it — maybe he's curious)
(3, 2, 7);  -- Bob will watch Brooklyn Nine-Nine later

-- drop table watch_later;
-- drop table user;
-- drop table Show;
-- drop table Category;
-- drop table like;
-- drop table dislike;


-- CREATE TABLE 'Comments' (
--   'id' INT AUTO_INCREMENT PRIMARY KEY,
--   'comment' VARCHAR(255) NOT NULL,
--   'user_id' INT NOT NULL,
--   'show_id' INT NOT NULL,
--   FOREIGN KEY (user_id) REFERENCES users(id),
--   FOREIGN KEY (show_id) REFERENCES Shows(id)
-- );


-- CREATE TABLE 

-- ALTER TABLE table_name
--   RENAME TO new_table_name;


-- fake
-- fake
-- fake
-- fake
-- fake
-- fake
-- fake
-- fake
-- fake


-- INSERT INTO user (name, email, password)
-- VALUES
--     ('Alice Johnson', 'alice.johnson@example.com', 'password123'),
--     ('Bob Smith', 'bob.smith@example.com', 'password456'),
--     ('Charlie Brown', 'charlie.brown@example.com', 'password789');

-- INSERT INTO Category (name)
-- VALUES
--     ('Drama'),
--     ('Comedy'),
--     ('Action'),
--     ('Horror'),
--     ('Sci-Fi');

-- INSERT INTO Show (name, description, rating, time, age_limit, Category, image, Category_id)
-- VALUES
--     ('Breaking Bad', 'A high school chemistry teacher turned methamphetamine producer.', 9, '9:00 PM', 18, 'Drama', 'breaking_bad.jpg', 1),
--     ('The Office', 'A mockumentary on a group of typical office workers.', 8, '8:00 PM', 13, 'Comedy', 'the_office.jpg', 2),
--     ('The Dark Knight', 'Batman faces off against the Joker in Gotham City.', 9, '10:00 PM', 16, 'Action', 'dark_knight.jpg', 3),
--     ('The Conjuring', 'Paranormal investigators work to help a family plagued by dark forces.', 7, '11:00 PM', 18, 'Horror', 'conjuring.jpg', 4),
--     ('Interstellar', 'A team of explorers travels through a wormhole in space to ensure humanity’s survival.', 8, '7:00 PM', 13, 'Sci-Fi', 'interstellar.jpg', 5);

-- INSERT INTO like (user_id, show_id)
-- VALUES
--     (1, 1),  -- Alice likes Breaking Bad
--     (1, 2),  -- Alice likes The Office
--     (2, 3),  -- Bob likes The Dark Knight
--     (2, 5),  -- Bob likes Interstellar
--     (3, 4);  -- Charlie likes The Conjuring


-- INSERT INTO dislike (user_id, show_id)
-- VALUES
--     (1, 3),  -- Alice dislikes The Dark Knight
--     (2, 4),  -- Bob dislikes The Conjuring
--     (3, 1);  -- Charlie dislikes Breaking Bad


INSERT INTO user (id, name, email, password)
VALUES
    (1, 'Alice Johnson', 'alice.johnson@example.com', 'password123'),
    (2, 'Bob Smith', 'bob.smith@example.com', 'password456'),
    (3, 'Charlie Brown', 'charlie.brown@example.com', 'password789');

INSERT INTO Category (id, name)
VALUES
    (1, 'Drama'),
    (2, 'Comedy'),
    (3, 'Action'),
    (4, 'Horror'),
    (5, 'Sci-Fi');

INSERT INTO Show (id, name, description, rating, time, age_limit, Category, image, Category_id)
VALUES
    (1, 'Breaking Bad', 'A high school chemistry teacher turned methamphetamine producer.', 9, '9:00 PM', 18, 'Drama', 'breaking_bad.jpg', 1),
    (2, 'The Office', 'A mockumentary on a group of typical office workers.', 8, '8:00 PM', 13, 'Comedy', 'the_office.jpg', 2),
    (3, 'The Dark Knight', 'Batman faces off against the Joker in Gotham City.', 9, '10:00 PM', 16, 'Action', 'dark_knight.jpg', 3),
    (4, 'The Conjuring', 'Paranormal investigators work to help a family plagued by dark forces.', 7, '11:00 PM', 18, 'Horror', 'conjuring.jpg', 4),
    (5, 'Interstellar', 'A team of explorers travels through a wormhole in space to ensure humanity’s survival.', 8, '7:00 PM', 13, 'Sci-Fi', 'interstellar.jpg', 5);

INSERT INTO like (id, user_id, show_id)
VALUES
    (1, 1, 1),  -- Alice likes Breaking Bad
    (2, 1, 2),  -- Alice likes The Office
    (3, 2, 3),  -- Bob likes The Dark Knight
    (4, 2, 5),  -- Bob likes Interstellar
    (5, 3, 4);  -- Charlie likes The Conjuring

INSERT INTO dislike (id, user_id, show_id)
VALUES
    (1, 1, 3),  -- Alice dislikes The Dark Knight
    (2, 2, 4),  -- Bob dislikes The Conjuring
    (3, 3, 1);  -- Charlie dislikes Breaking Bad


-- -- Bob likes one show from each category
-- INSERT INTO like (id, user_id, show_id)
-- VALUES
--     (6, 2, 1),  -- Drama: Breaking Bad
--     (7, 2, 2),  -- Comedy: The Office
--     (8, 2, 3),  -- Action: The Dark Knight (already liked earlier, so skip if needed)
--     (9, 2, 4),  -- Horror: The Conjuring
--     (10, 2, 5); -- Sci-Fi: Interstellar (already liked earlier, so skip if needed)

-- -- DELETE FROM like
-- WHERE id IN (6, 7, 8, 9, 10);


-- -- Bob dislikes different shows for variety
-- INSERT INTO dislike (id, user_id, show_id)
-- VALUES
--     (4, 2, 1),  -- Drama: Breaking Bad
--     (5, 2, 2),  -- Comedy: The Office
--     (6, 2, 4);  -- Horror: The Conjuring (already disliked earlier, so skip if needed)

-- DELETE FROM dislike
-- WHERE id IN (4, 5, 6);

-- Extra Drama
INSERT INTO Show (id, name, description, rating, time, age_limit, Category, image, Category_id)
VALUES
(6, 'Better Call Saul', 'The story of lawyer Jimmy McGill before Breaking Bad.', 8, '8:30 PM', 16, 'Drama', 'saul.jpg', 1),

-- Extra Comedy
(7, 'Brooklyn Nine-Nine', 'A funny police sitcom in Brooklyn.', 8, '9:30 PM', 13, 'Comedy', 'b99.jpg', 2),

-- Extra Action
(8, 'John Wick', 'A retired hitman seeks revenge.', 9, '10:30 PM', 18, 'Action', 'john_wick.jpg', 3),

-- Extra Horror
(9, 'It', 'A shape-shifting clown haunts children in a small town.', 7, '11:30 PM', 18, 'Horror', 'it.jpg', 4),

-- Extra Sci-Fi
(10, 'Stranger Things', 'Kids uncover supernatural mysteries in their town.', 9, '7:30 PM', 13, 'Sci-Fi', 'stranger_things.jpg', 5);


-- Bob likes 3 of the new shows
INSERT INTO like (id, user_id, show_id)
VALUES
(11, 2, 6),  -- Likes Better Call Saul (Drama)
(12, 2, 7),  -- Likes Brooklyn Nine-Nine (Comedy)
(13, 2, 10); -- Likes Stranger Things (Sci-Fi)

-- Bob dislikes the other 2 new shows
INSERT INTO dislike (id, user_id, show_id)
VALUES
(7, 2, 8),  -- Dislikes John Wick (Action)
(8, 2, 9);  -- Dislikes It (Horror)





-- In Show table
ALTER TABLE Show ADD COLUMN multimedia_type_id INTEGER;
ALTER TABLE Show ADD COLUMN audience_type_id INTEGER;

-- Add Foreign Keys in the recreated Show table if needed
FOREIGN KEY (multimedia_type_id) REFERENCES multimedia_type(id),
FOREIGN KEY (audience_type_id) REFERENCES audience_type(id)


-- add shows to show table
INSERT INTO `Show` 
(id, name, description, rating, time, age_limit, Category, image, Category_id, multimedia_type_id, audience_type_id) 
VALUES 
(1, 'Show 1', 'Description for show 1', 6, '1h 31min', 11, 'Drama', 'https://m.media-amazon.com/images/M/MV5BMjI1MzM2ODEyMV5BMl5BanBnXkFtZTgwNTIzODAwMzE@._V1_SX300.jpg', 1, 1, 1);

INSERT INTO `Show` 
(id, name, description, rating, time, age_limit, Category, image, Category_id, multimedia_type_id, audience_type_id) 
VALUES 
(2, 'Show 2', 'Description for show 2', 7, '1h 32min', 12, 'Drama', 'https://m.media-amazon.com/images/M/MV5BYjVmZWZkMTktODNiYS00YTYzLWE4NDAtYTgwOGFhYjc4ZGQ4XkEyXkFqcGc@._V1_SX300.jpg', 1, 1, 1);

INSERT INTO `Show` 
(id, name, description, rating, time, age_limit, Category, image, Category_id, multimedia_type_id, audience_type_id) 
VALUES 
(3, 'Show 3', 'Description for show 3', 8, '1h 33min', 13, 'Drama', 'https://m.media-amazon.com/images/M/MV5BMTcyNzk5NDg1Nl5BMl5BanBnXkFtZTgwNTM5MDQxNDM@._V1_SX300.jpg', 1, 1, 1);

INSERT INTO `Show` 
(id, name, description, rating, time, age_limit, Category, image, Category_id, multimedia_type_id, audience_type_id) 
VALUES 
(4, 'Show 4', 'Description for show 4', 9, '1h 34min', 14, 'Drama', 'https://m.media-amazon.com/images/M/MV5BOWVhYzY1ODItOTU0Ni00MDQwLTk3ZDYtOTc0YTAwMmM4NzAxXkEyXkFqcGc@._V1_SX300.jpg', 1, 1, 1);

INSERT INTO `Show` 
(id, name, description, rating, time, age_limit, Category, image, Category_id, multimedia_type_id, audience_type_id) 
VALUES 
(5, 'Show 5', 'Description for show 5', 10, '1h 35min', 15, 'Drama', 'https://m.media-amazon.com/images/M/MV5BMTg0NjEwNDgxNF5BMl5BanBnXkFtZTcwMjkyOTM3Mg@@._V1_SX300.jpg', 1, 1, 1);

INSERT INTO `Show` 
(id, name, description, rating, time, age_limit, Category, image, Category_id, multimedia_type_id, audience_type_id) 
VALUES 
(6, 'Show 6', 'Description for show 6', 6.5, '1h 36min', 16, 'Action', 'https://m.media-amazon.com/images/M/MV5BMTU1MzAxMDQ3MV5BMl5BanBnXkFtZTcwNzY0ODI4NA@@._V1_SX300.jpg', 2, 1, 2);

INSERT INTO `Show` 
(id, name, description, rating, time, age_limit, Category, image, Category_id, multimedia_type_id, audience_type_id) 
VALUES 
(7, 'Show 7', 'Description for show 7', 7.3, '1h 37min', 17, 'Comedy', 'https://m.media-amazon.com/images/M/MV5BMTc5MTU3NjYxOF5BMl5BanBnXkFtZTcwNzQ2Mzg2Mw@@._V1_SX300.jpg', 3, 1, 2);

INSERT INTO `Show` 
(id, name, description, rating, time, age_limit, Category, image, Category_id, multimedia_type_id, audience_type_id) 
VALUES 
(8, 'Show 8', 'Description for show 8', 8.1, '1h 38min', 18, 'Thriller', 'https://m.media-amazon.com/images/M/MV5BMTY4MDQzMTM5OV5BMl5BanBnXkFtZTcwNzYzNzU3Mw@@._V1_SX300.jpg', 4, 1, 3);

INSERT INTO `Show` 
(id, name, description, rating, time, age_limit, Category, image, Category_id, multimedia_type_id, audience_type_id) 
VALUES 
(9, 'Show 9', 'Description for show 9', 7.9, '1h 39min', 19, 'Adventure', 'https://m.media-amazon.com/images/M/MV5BMTczNzYyNjczNl5BMl5BanBnXkFtZTcwNzMzMjQ0Mw@@._V1_SX300.jpg', 5, 1, 3);

INSERT INTO `Show` 
(id, name, description, rating, time, age_limit, Category, image, Category_id, multimedia_type_id, audience_type_id) 
VALUES 
(10, 'Show 10', 'Description for show 10', 9.0, '1h 40min', 20, 'Fantasy', 'https://m.media-amazon.com/images/M/MV5BMjA3MDg3MTIxMF5BMl5BanBnXkFtZTcwODk5MDM4NA@@._V1_SX300.jpg', 6, 1, 1);


INSERT INTO `Show` VALUES 
(11, 'Show 11', 'Description for show 11', 7.1, '1h 41min', 13, 'Crime', 'https://m.media-amazon.com/images/M/MV5BMjExNzI0MzM5MV5BMl5BanBnXkFtZTcwNTE4MDU2NA@@._V1_SX300.jpg', 7, 1, 1),
(12, 'Show 12', 'Description for show 12', 6.8, '1h 42min', 15, 'Animation', 'https://m.media-amazon.com/images/M/MV5BNzQzZjQ3ZDgtMjAwOS00Zjk3LTkwNzItNDc0ZjMwOGQwYjljXkEyXkFqcGdeQXVyODc0OTEyNDU@._V1_SX300.jpg', 8, 1, 1),
(13, 'Show 13', 'Description for show 13', 8.2, '1h 43min', 18, 'Sci-Fi', 'https://m.media-amazon.com/images/M/MV5BZGVlZWY1YTgtZWYxNS00YzY2LWFiYWItMzVmZTBiYTZhMDcyXkEyXkFqcGdeQXVyMjQwMDg0Ng@@._V1_SX300.jpg', 9, 1, 3),
(14, 'Show 14', 'Description for show 14', 7.6, '1h 44min', 14, 'Drama', 'https://m.media-amazon.com/images/M/MV5BMjI5NzE4NTMxNl5BMl5BanBnXkFtZTcwNjg1NjE1Mg@@._V1_SX300.jpg', 1, 1, 2),
(15, 'Show 15', 'Description for show 15', 6.4, '1h 45min', 16, 'Horror', 'https://m.media-amazon.com/images/M/MV5BYzliMTMzZDgtNmFkYS00ZDg3LTk5YjQtNjI1YjY3NTNkNDlkXkEyXkFqcGdeQXVyMTk5MjAxOA@@._V1_SX300.jpg', 10, 1, 3),
(16, 'Show 16', 'Description for show 16', 7.9, '1h 46min', 12, 'Romance', 'https://m.media-amazon.com/images/M/MV5BMjI0ODQ0NzE1Ml5BMl5BanBnXkFtZTcwNDcwNTQ1Mg@@._V1_SX300.jpg', 11, 1, 2),
(17, 'Show 17', 'Description for show 17', 8.5, '1h 47min', 17, 'Mystery', 'https://m.media-amazon.com/images/M/MV5BZmZkNDcwMDYtZmMxOC00NDY3LWFmMzEtMGRlOWE0ZTM0OGI4XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg', 12, 1, 3),
(18, 'Show 18', 'Description for show 18', 7.4, '1h 48min', 15, 'Western', 'https://m.media-amazon.com/images/M/MV5BMjEyMzU0ODgzNF5BMl5BanBnXkFtZTcwNTUzNTIzMQ@@._V1_SX300.jpg', 13, 1, 2),
(19, 'Show 19', 'Description for show 19', 6.9, '1h 49min', 13, 'Biography', 'https://m.media-amazon.com/images/M/MV5BMTc0MDUwMzA1Ml5BMl5BanBnXkFtZTcwNTM1MTg3Mg@@._V1_SX300.jpg', 14, 1, 1),
(20, 'Show 20', 'Description for show 20', 7.3, '1h 50min', 18, 'War', 'https://m.media-amazon.com/images/M/MV5BY2JhZTMyZTUtYjQ2ZC00NzYwLThmYzktZmJhNzU2YzUwZWE2XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg', 15, 1, 3),
(21, 'Show 21', 'Description for show 21', 8.0, '1h 51min', 12, 'Musical', 'https://m.media-amazon.com/images/M/MV5BMTg1NjMwNjEzNF5BMl5BanBnXkFtZTcwNDI3NzAzMQ@@._V1_SX300.jpg', 16, 1, 1),
(22, 'Show 22', 'Description for show 22', 7.2, '1h 52min', 14, 'History', 'https://m.media-amazon.com/images/M/MV5BM2E0NzJlNDItMWE2Yy00ZTg2LTliYmUtYTlmZDE3NzJmNDU1XkEyXkFqcGdeQXVyNjUwNzk3NDc@._V1_SX300.jpg', 17, 1, 2),
(23, 'Show 23', 'Description for show 23', 6.7, '1h 53min', 16, 'Sport', 'https://m.media-amazon.com/images/M/MV5BYTJiNTJlZDMtYmRiZi00ZWE3LWJlNzEtNzM0NjU3M2QxODUzXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg', 18, 1, 2),
(24, 'Show 24', 'Description for show 24', 8.3, '1h 54min', 13, 'Documentary', 'https://m.media-amazon.com/images/M/MV5BZjZiMjZlNjQtNmZmZi00NzMzLTkxNjAtMGRlYWI2YTRjZmViXkEyXkFqcGdeQXVyNzE3ODQ4ODU@._V1_SX300.jpg', 19, 1, 1),
(25, 'Show 25', 'Description for show 25', 7.5, '1h 55min', 17, 'Family', 'https://m.media-amazon.com/images/M/MV5BNzUyNjIyMTgxNF5BMl5BanBnXkFtZTcwNjU2NzYxNA@@._V1_SX300.jpg', 20, 1, 2),
(26, 'Show 26', 'Description for show 26', 6.6, '1h 56min', 15, 'Fantasy', 'https://m.media-amazon.com/images/M/MV5BMTQ5ODU1ODkwNF5BMl5BanBnXkFtZTcwNDg2NTMyMw@@._V1_SX300.jpg', 6, 1, 2),
(27, 'Show 27', 'Description for show 27', 7.7, '1h 57min', 18, 'Thriller', 'https://m.media-amazon.com/images/M/MV5BYTg4MTlkNzQtMjE2My00NmQ0LTk1NDItNzYzMzBiMDkwNjk5XkEyXkFqcGdeQXVyNjUxMjc1OTM@._V1_SX300.jpg', 4, 1, 3),
(28, 'Show 28', 'Description for show 28', 7.0, '1h 58min', 14, 'Adventure', 'https://m.media-amazon.com/images/M/MV5BMTU4NTM2NDU2OV5BMl5BanBnXkFtZTgwMDU3NTg4NjE@._V1_SX300.jpg', 5, 1, 2),
(29, 'Show 29', 'Description for show 29', 8.4, '1h 59min', 13, 'Comedy', 'https://m.media-amazon.com/images/M/MV5BMTgxMDQ2NzAwNF5BMl5BanBnXkFtZTcwODAxMTgxNA@@._V1_SX300.jpg', 3, 1, 1),
(30, 'Show 30', 'Description for show 30', 6.3, '2h 00min', 16, 'Action', 'https://m.media-amazon.com/images/M/MV5BMTQ2OTk0MzE5Ml5BMl5BanBnXkFtZTgwNTYxMzE1MDE@._V1_SX300.jpg', 2, 1, 3);


INSERT INTO `Show` VALUES 
(31, 'Show 31', 'Description for show 31', 7.6, '2h 01min', 13, 'Drama', 'https://m.media-amazon.com/images/M/MV5BMjExNjYzMDAxMF5BMl5BanBnXkFtZTcwOTk1NzUzNw@@._V1_SX300.jpg', 1, 1, 1),
(32, 'Show 32', 'Description for show 32', 6.9, '2h 02min', 15, 'Horror', 'https://m.media-amazon.com/images/M/MV5BMTQxNTMyNjY3OF5BMl5BanBnXkFtZTcwMTYzMjA2Mg@@._V1_SX300.jpg', 10, 1, 3),
(33, 'Show 33', 'Description for show 33', 8.2, '2h 03min', 18, 'Thriller', 'https://m.media-amazon.com/images/M/MV5BZTY4NzAxNWEtNDRjYi00ZjJhLTkzYjMtMzYzNDJhMjc4OWRhXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg', 4, 1, 2),
(34, 'Show 34', 'Description for show 34', 7.3, '2h 04min', 14, 'Fantasy', 'https://m.media-amazon.com/images/M/MV5BZjdkNzE1NDYtMWFlYy00YjE5LTkzMzAtYTZiNmRhNjE0MTU4XkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg', 6, 1, 1),
(35, 'Show 35', 'Description for show 35', 6.7, '2h 05min', 12, 'Romance', 'https://m.media-amazon.com/images/M/MV5BYzViZDA4NjUtMjA0MC00YWI1LThmYjgtYmZkMjM4NDJhYjQyXkEyXkFqcGdeQXVyNDU4MDQ0MTY@._V1_SX300.jpg', 11, 1, 2),
(36, 'Show 36', 'Description for show 36', 8.1, '2h 06min', 13, 'Mystery', 'https://m.media-amazon.com/images/M/MV5BNDc0NTU4OTg2Ml5BMl5BanBnXkFtZTcwOTQ0MzAzMw@@._V1_SX300.jpg', 12, 1, 3),
(37, 'Show 37', 'Description for show 37', 7.0, '2h 07min', 15, 'Sci-Fi', 'https://m.media-amazon.com/images/M/MV5BODJjN2M5ZDktNDYxZC00MWU1LWFlYmUtODczYzZlYjczMDg1XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg', 9, 1, 2),
(38, 'Show 38', 'Description for show 38', 6.8, '2h 08min', 17, 'Crime', 'https://m.media-amazon.com/images/M/MV5BZjI0NzE3NmYtMTk3My00NzNiLWJjZGYtMGM3NWMzYWE4YzViXkEyXkFqcGdeQXVyNTAzNzgwNTg@._V1_SX300.jpg', 7, 1, 3),
(39, 'Show 39', 'Description for show 39', 8.4, '2h 09min', 16, 'Adventure', 'https://m.media-amazon.com/images/M/MV5BMjA4OTAxNzkxNV5BMl5BanBnXkFtZTcwNzI2Njg2NA@@._V1_SX300.jpg', 5, 1, 2),
(40, 'Show 40', 'Description for show 40', 7.2, '2h 10min', 14, 'Animation', 'https://m.media-amazon.com/images/M/MV5BMTU5ODkyMjM0Nl5BMl5BanBnXkFtZTcwODg3MTMzMw@@._V1_SX300.jpg', 8, 1, 1),
(41, 'Show 41', 'Description for show 41', 7.9, '2h 11min', 13, 'Comedy', 'https://m.media-amazon.com/images/M/MV5BZjk1ODBiZDctY2Q5OS00NDNlLTgzNDAtZjEyYjY2MzhlOGY2XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg', 3, 1, 1),
(42, 'Show 42', 'Description for show 42', 6.5, '2h 12min', 15, 'Biography', 'https://m.media-amazon.com/images/M/MV5BZjI0MTUzNzEtYjVhNi00OTg0LThlZTktMTc4MjJhZTg2NjlkXkEyXkFqcGdeQXVyNzA5NzQ2Mzk@._V1_SX300.jpg', 14, 1, 1),
(43, 'Show 43', 'Description for show 43', 8.3, '2h 13min', 12, 'War', 'https://m.media-amazon.com/images/M/MV5BNDY5MzFiNzYtZDQ4ZC00NzNlLTk2ZWEtZTY0ZTFmYTk5MWY2XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg', 15, 1, 3),
(44, 'Show 44', 'Description for show 44', 7.1, '2h 14min', 18, 'History', 'https://m.media-amazon.com/images/M/MV5BMjI2NjczNzAxNF5BMl5BanBnXkFtZTgwNDUyNDA1MjE@._V1_SX300.jpg', 17, 1, 2),
(45, 'Show 45', 'Description for show 45', 6.6, '2h 15min', 14, 'Family', 'https://m.media-amazon.com/images/M/MV5BYWI3MDI5ZTAtMzMzMi00ZmFjLWJjZDMtZTczYTRkYjA3NzJjXkEyXkFqcGdeQXVyNDIzMzcwNjc@._V1_SX300.jpg', 20, 1, 1),
(46, 'Show 46', 'Description for show 46', 7.8, '2h 16min', 13, 'Sport', 'https://m.media-amazon.com/images/M/MV5BM2E2ZjUzNzktNTExNi00NzA1LTgyNzItN2FkZjM1YTZmZDQxXkEyXkFqcGdeQXVyNjc3MjQzNTI@._V1_SX300.jpg', 18, 1, 2),
(47, 'Show 47', 'Description for show 47', 7.4, '2h 17min', 16, 'Musical', 'https://m.media-amazon.com/images/M/MV5BYWY5YzRmYjctZDFjMi00ZWMxLWFhZTMtNTA3ZDJkOWM4OGNmXkEyXkFqcGdeQXVyNDg4NjY5OTQ@._V1_SX300.jpg', 16, 1, 2),
(48, 'Show 48', 'Description for show 48', 6.9, '2h 18min', 15, 'Documentary', 'https://m.media-amazon.com/images/M/MV5BNjNkN2RjODctMTMzMC00ZDM4LTk1YTgtODljNTc0NjVjMzA2XkEyXkFqcGdeQXVyMjI3NzIzNzY@._V1_SX300.jpg', 19, 1, 1),
(49, 'Show 49', 'Description for show 49', 8.0, '2h 19min', 17, 'Western', 'https://m.media-amazon.com/images/M/MV5BNTAzZGEzN2YtZDQ3My00YmExLTg0YTgtNTlmY2EyMmI0MzJlXkEyXkFqcGdeQXVyMTEzNjYyNDI4._V1_SX300.jpg', 13, 1, 3),
(50, 'Show 50', 'Description for show 50', 7.7, '2h 20min', 13, 'Drama', 'https://m.media-amazon.com/images/M/MV5BMTY0NzQxMzExNF5BMl5BanBnXkFtZTcwNzUzMDYyMg@@._V1_SX300.jpg', 1, 1, 2);

INSERT INTO `Show` VALUES 
(51, 'Show 51', 'Description for show 51', 6.9, '2h 21min', 14, 'Mystery', 'https://m.media-amazon.com/images/M/MV5BODAxNzVjYTgtZTc3Ny00ZTY0LWE2YmItMjg0Njk0ZjhkYTRkXkEyXkFqcGdeQXVyNjEwNTM2Mzc@._V1_SX300.jpg', 2, 1, 3),
(52, 'Show 52', 'Description for show 52', 8.1, '2h 22min', 16, 'Drama', 'https://m.media-amazon.com/images/M/MV5BN2U2MzM0ZDItNTUwOC00NzFkLWI1NmQtYTVmY2ZkM2UwNDRjXkEyXkFqcGdeQXVyNDYyMDk5MTU@._V1_SX300.jpg', 4, 1, 1),
(53, 'Show 53', 'Description for show 53', 7.0, '2h 23min', 12, 'Comedy', 'https://m.media-amazon.com/images/M/MV5BYTJiNTVmY2UtNzA0NC00MjBlLWFhMzAtN2RmOTFkNzA0ZDdhXkEyXkFqcGdeQXVyNTEwNDcxNDM@._V1_SX300.jpg', 7, 1, 2),
(54, 'Show 54', 'Description for show 54', 6.7, '2h 24min', 15, 'Sci-Fi', 'https://m.media-amazon.com/images/M/MV5BYWE4M2EyMTYtYTUxNC00Njk0LTg2MTktNDc0YjgzNmU1NDc0XkEyXkFqcGdeQXVyMTI4MzU1NzYz._V1_SX300.jpg', 5, 1, 3),
(55, 'Show 55', 'Description for show 55', 8.3, '2h 25min', 13, 'Thriller', 'https://m.media-amazon.com/images/M/MV5BYjBhOWZjMmItMzM5NS00ZDI3LWFkNzYtNWI2NGRmZWI4MTk3XkEyXkFqcGdeQXVyNzQ3NDExODI@._V1_SX300.jpg', 3, 1, 2),
(56, 'Show 56', 'Description for show 56', 7.5, '2h 26min', 14, 'Fantasy', 'https://m.media-amazon.com/images/M/MV5BZTgxMjM0NmQtOGI0Ni00NGY2LWFhZTEtZTI3MmU4ZTIzM2E2XkEyXkFqcGdeQXVyMTQ4Mjg2NzE@._V1_SX300.jpg', 6, 1, 1),
(57, 'Show 57', 'Description for show 57', 6.8, '2h 27min', 12, 'Adventure', 'https://m.media-amazon.com/images/M/MV5BMTY3MzAxOTI0Ml5BMl5BanBnXkFtZTgwODIxNTM0OTE@._V1_SX300.jpg', 10, 1, 3),
(58, 'Show 58', 'Description for show 58', 8.0, '2h 28min', 18, 'Biography', 'https://m.media-amazon.com/images/M/MV5BYzY2MmFkZTktODk3My00ZDczLWFkODItY2I5ZmY1NGZkMjZhXkEyXkFqcGdeQXVyNjY1MTg4Mzk@._V1_SX300.jpg', 13, 1, 2),
(59, 'Show 59', 'Description for show 59', 7.2, '2h 29min', 17, 'Horror', 'https://m.media-amazon.com/images/M/MV5BZTcyOWU3NDctOGU3Yy00M2Q2LThmZWItZGY0NjVjYzAwOWRiXkEyXkFqcGdeQXVyNDAzNzgwNDE@._V1_SX300.jpg', 12, 1, 1),
(60, 'Show 60', 'Description for show 60', 7.7, '2h 30min', 16, 'Crime', 'https://m.media-amazon.com/images/M/MV5BYjMzNzU2ODMtMWI4OC00Njg0LWJkZjgtYjhjYzI4ZDJmZjU3XkEyXkFqcGdeQXVyNDkzNTM2ODg@._V1_SX300.jpg', 9, 1, 2),
(61, 'Show 61', 'Description for show 61', 7.1, '2h 31min', 13, 'Romance', 'https://m.media-amazon.com/images/M/MV5BN2E0ZjU3Y2MtN2YwYy00M2I3LTg3YzktZGI5YjNlYzUwNzUwXkEyXkFqcGdeQXVyNjUwNzk3NDc@._V1_SX300.jpg', 14, 1, 3),
(62, 'Show 62', 'Description for show 62', 8.2, '2h 32min', 15, 'Animation', 'https://m.media-amazon.com/images/M/MV5BODIzZjY5ZTUtMTI5Zi00YTYzLTkyNjgtNDQ4NzM1ZjM2NTM4XkEyXkFqcGdeQXVyNjc2NTQ3NTM@._V1_SX300.jpg', 11, 1, 1),
(63, 'Show 63', 'Description for show 63', 6.6, '2h 33min', 12, 'Family', 'https://m.media-amazon.com/images/M/MV5BMjAxNzgyODQ0MF5BMl5BanBnXkFtZTcwMDY2NTU1Nw@@._V1_SX300.jpg', 16, 1, 1),
(64, 'Show 64', 'Description for show 64', 7.9, '2h 34min', 17, 'Musical', 'https://m.media-amazon.com/images/M/MV5BMTU0MDYxMDk1OF5BMl5BanBnXkFtZTcwNjAxNzE3Mw@@._V1_SX300.jpg', 18, 1, 2),
(65, 'Show 65', 'Description for show 65', 8.0, '2h 35min', 13, 'War', 'https://m.media-amazon.com/images/M/MV5BN2RlOWI5ZjEtODJhYi00MDY1LWJmZTUtMmM5ZmEzYTYxZTJlXkEyXkFqcGdeQXVyMTAzMDM4MjM0._V1_SX300.jpg', 17, 1, 3),
(66, 'Show 66', 'Description for show 66', 7.3, '2h 36min', 18, 'Western', 'https://m.media-amazon.com/images/M/MV5BMjE3NDQ5NTY2NV5BMl5BanBnXkFtZTgwMzU3MjcwNzE@._V1_SX300.jpg', 15, 1, 1),
(67, 'Show 67', 'Description for show 67', 6.5, '2h 37min', 14, 'History', 'https://m.media-amazon.com/images/M/MV5BMjIzNzAyMjgyNl5BMl5BanBnXkFtZTgwMzAxODQzMzE@._V1_SX300.jpg', 19, 1, 2),
(68, 'Show 68', 'Description for show 68', 7.6, '2h 38min', 13, 'Sport', 'https://m.media-amazon.com/images/M/MV5BMjA2MTg4NzYwMV5BMl5BanBnXkFtZTgwNTg2ODQxMzE@._V1_SX300.jpg', 20, 1, 3),
(69, 'Show 69', 'Description for show 69', 8.4, '2h 39min', 16, 'Documentary', 'https://m.media-amazon.com/images/M/MV5BMTUyNTg5NTAzNV5BMl5BanBnXkFtZTcwNTM4NzYwMw@@._V1_SX300.jpg', 8, 1, 2),
(70, 'Show 70', 'Description for show 70', 7.4, '2h 40min', 15, 'Animation', 'https://m.media-amazon.com/images/M/MV5BMTc5ODkzNDYwMV5BMl5BanBnXkFtZTcwODg2MzAyMw@@._V1_SX300.jpg', 1, 1, 1);


INSERT INTO `Show` VALUES 
(71, 'Show 71', 'Description for show 71', 6.8, '2h 41min', 14, 'Mystery', 'https://m.media-amazon.com/images/M/MV5BMzEzNDM5NTYtOTBhZC00N2MwLThkN2UtYTg0NjYwMjEwZmNmXkEyXkFqcGdeQXVyMTI5NjY2NjE@._V1_SX300.jpg', 5, 1, 3),
(72, 'Show 72', 'Description for show 72', 7.9, '2h 42min', 12, 'Drama', 'https://m.media-amazon.com/images/M/MV5BODFmMTJmYmUtYjNhZC00MjI2LTk4ZDAtNDI5N2I0OGMwYWEzXkEyXkFqcGdeQXVyNzQ4NjI1Nzc@._V1_SX300.jpg', 6, 1, 2),
(73, 'Show 73', 'Description for show 73', 6.7, '2h 43min', 13, 'Comedy', 'https://m.media-amazon.com/images/M/MV5BYzJhNzJlMmUtMzg1YS00NGRlLTg3ODctYmMyZTgxNTdmMjMwXkEyXkFqcGdeQXVyNDEyMzg5NTM@._V1_SX300.jpg', 9, 1, 1),
(74, 'Show 74', 'Description for show 74', 7.2, '2h 44min', 14, 'Sci-Fi', 'https://m.media-amazon.com/images/M/MV5BMzNjM2YyNjctM2MzMS00YjYwLTg1MjgtNmIzZjQ5ZGMzZDkxXkEyXkFqcGdeQXVyNzcxNjg0NDM@._V1_SX300.jpg', 7, 1, 3),
(75, 'Show 75', 'Description for show 75', 8.3, '2h 45min', 15, 'Thriller', 'https://m.media-amazon.com/images/M/MV5BZGJkZDE5NjgtYzBkYi00OGEyLTkwZjAtYTgwZjc1MTQwZjNkXkEyXkFqcGdeQXVyNzYyNTYwNjQ@._V1_SX300.jpg', 3, 1, 2),
(76, 'Show 76', 'Description for show 76', 7.4, '2h 46min', 12, 'Fantasy', 'https://m.media-amazon.com/images/M/MV5BMjQ0YzYwYjMtMjMwMC00NjAzLWI5NjktZTJlYjdiNmVkZmNlXkEyXkFqcGdeQXVyMTEwNzA2OTc@._V1_SX300.jpg', 6, 1, 1),
(77, 'Show 77', 'Description for show 77', 6.9, '2h 47min', 13, 'Adventure', 'https://m.media-amazon.com/images/M/MV5BZDMyY2RmZDMtNTZkYy00NjFjLTlmZTAtYTVmMjBhYTgxMTMzXkEyXkFqcGdeQXVyNjg0NjA2MzA@._V1_SX300.jpg', 10, 1, 3),
(78, 'Show 78', 'Description for show 78', 7.7, '2h 48min', 16, 'Biography', 'https://m.media-amazon.com/images/M/MV5BZTgzYTVkY2MtZTlmOC00ZDZlLWI5ZDgtNTg1MGZjYTFlZTBiXkEyXkFqcGdeQXVyNzQ5MDEwMjk@._V1_SX300.jpg', 13, 1, 2),
(79, 'Show 79', 'Description for show 79', 8.1, '2h 49min', 18, 'Horror', 'https://m.media-amazon.com/images/M/MV5BYWY1YzkzOGYtNzMyMC00NzVhLTkwZjQtYzViOGYwM2NjZTgwXkEyXkFqcGdeQXVyMzMwODQwNjM@._V1_SX300.jpg', 12, 1, 1),
(80, 'Show 80', 'Description for show 80', 6.5, '2h 50min', 15, 'Crime', 'https://m.media-amazon.com/images/M/MV5BZDhhZDg2NzgtZmQ4OC00NjY2LTgwYjItNmEzNjEyMTMwMzBhXkEyXkFqcGdeQXVyNjE0NTU1MTI@._V1_SX300.jpg', 9, 1, 2),
(81, 'Show 81', 'Description for show 81', 7.8, '2h 51min', 14, 'Romance', 'https://m.media-amazon.com/images/M/MV5BNzQzZGZmNzMtZjM5Ny00ZjY5LTliZGItZTI5OGQ2YmQ1MGY2XkEyXkFqcGdeQXVyNjMwMzA3Mzg@._V1_SX300.jpg', 14, 1, 3),
(82, 'Show 82', 'Description for show 82', 6.6, '2h 52min', 16, 'Animation', 'https://m.media-amazon.com/images/M/MV5BMTQyZTc0ZmQtMmVkZC00NzEwLWIxN2QtNzZkMjExNzUyNzI4XkEyXkFqcGdeQXVyMTAwOTQ5ODg@._V1_SX300.jpg', 11, 1, 1),
(83, 'Show 83', 'Description for show 83', 7.5, '2h 53min', 13, 'Family', 'https://m.media-amazon.com/images/M/MV5BMTg1ZDJmN2MtZTczNy00N2JjLTg2ZDUtNDZkZDU3ZGVlZWI1XkEyXkFqcGdeQXVyNzU3NzAwNzg@._V1_SX300.jpg', 16, 1, 2),
(84, 'Show 84', 'Description for show 84', 6.8, '2h 54min', 17, 'Musical', 'https://m.media-amazon.com/images/M/MV5BYzM3NzMwMjEtMTc1MS00M2FhLWI3NzgtMzVhZmZlYjZkMmM4XkEyXkFqcGdeQXVyNjQzNjY4NjY@._V1_SX300.jpg', 18, 1, 3),
(85, 'Show 85', 'Description for show 85', 7.1, '2h 55min', 12, 'War', 'https://m.media-amazon.com/images/M/MV5BMjU2NzNjMzktYWRiNi00NzdlLWIyYzQtNzc1YzFhZDhhOGQ2XkEyXkFqcGdeQXVyMTAzNzMwNjU@._V1_SX300.jpg', 17, 1, 1),
(86, 'Show 86', 'Description for show 86', 7.4, '2h 56min', 15, 'Western', 'https://m.media-amazon.com/images/M/MV5BMGU4YjMzZjAtODc5My00ZWE3LWI1MGMtYzJmNzk0ZDhlNTlhXkEyXkFqcGdeQXVyMjY4MzUyNzY@._V1_SX300.jpg', 15, 1, 2),
(87, 'Show 87', 'Description for show 87', 6.9, '2h 57min', 13, 'History', 'https://m.media-amazon.com/images/M/MV5BYzNmNjc2ZmItZDcyOS00MmJjLThjY2QtM2Y1ZDhhMmRmMjM0XkEyXkFqcGdeQXVyNTI0NjM5NzA@._V1_SX300.jpg', 19, 1, 3),
(88, 'Show 88', 'Description for show 88', 8.0, '2h 58min', 16, 'Sport', 'https://m.media-amazon.com/images/M/MV5BY2E2NzExNzktOTcxYS00NzRjLTk5ZDItNTk3M2JjZTg0YWIxXkEyXkFqcGdeQXVyMjg4MTQ2NTI@._V1_SX300.jpg', 20, 1, 1),
(89, 'Show 89', 'Description for show 89', 7.3, '2h 59min', 14, 'Documentary', 'https://m.media-amazon.com/images/M/MV5BMTc5MTU4NjY2OF5BMl5BanBnXkFtZTcwMDQ0MzE0NzA@._V1_SX300.jpg', 8, 1, 2),
(90, 'Show 90', 'Description for show 90', 6.5, '3h 00min', 13, 'Animation', 'https://m.media-amazon.com/images/M/MV5BYzc1NzRhMzUtZGRhOC00ZGFjLTk0YmUtZDFlYjI2ZTQ3NTM2XkEyXkFqcGdeQXVyMTE1NzM2NzY@._V1_SX300.jpg', 1, 1, 3),
(91, 'Show 91', 'Description for show 91', 7.9, '3h 01min', 16, 'Family', 'https://m.media-amazon.com/images/M/MV5BMjA1YjJjYzAtMTJlYy00ZDExLTg5ZTQtNjg4ZTgzZjQ5MjMwXkEyXkFqcGdeQXVyMzMwMzA5NzE@._V1_SX300.jpg', 16, 1, 1),
(92, 'Show 92', 'Description for show 92', 6.7, '3h 02min', 15, 'Musical', 'https://m.media-amazon.com/images/M/MV5BMTMxMzYwYzYtZDI1ZC00N2JlLWIyZDQtZGRjZDFkNmFkZTU5XkEyXkFqcGdeQXVyNjQzNjM2Nzc@._V1_SX300.jpg', 18, 1, 2),
(93, 'Show 93', 'Description for show 93', 7.6, '3h 03min', 12, 'War', 'https://m.media-amazon.com/images/M/MV5BODkwOGY3NjQtYzdkYy00M2YwLWFhZGMtMTM3N2UwNzI5MjI0XkEyXkFqcGdeQXVyMTAzNzg1NzM@._V1_SX300.jpg', 17, 1, 3),
(94, 'Show 94', 'Description for show 94', 7.4, '3h 04min', 16, 'Western', 'https://m.media-amazon.com/images/M/MV5BMTk5M2NiODQtY2Y5Ny00ZDZjLWI2NDYtOGJmYzEyY2M4NzNkXkEyXkFqcGdeQXVyMTEwNzA2NzQ@._V1_SX300.jpg', 15, 1, 1),
(95, 'Show 95', 'Description for show 95', 6.9, '3h 05min', 13, 'History', 'https://m.media-amazon.com/images/M/MV5BMjMwYjY1N2ItYmI0MS00YjgyLTgwY2YtNzgyODczNDAyNTgzXkEyXkFqcGdeQXVyNjQzNjE5MzY@._V1_SX300.jpg', 19, 1, 2),
(96, 'Show 96', 'Description for show 96', 8.2, '3h 06min', 14, 'Sport', 'https://m.media-amazon.com/images/M/MV5BMTcwMzc3N2ItODkzYi00ZDdiLWE0ZTEtZDZjZmY1ZDk3ODVjXkEyXkFqcGdeQXVyMjg5MTEwOTI@._V1_SX300.jpg', 20, 1, 3),
(97, 'Show 97', 'Description for show 97', 7.1, '3h 07min', 12, 'Documentary', 'https://m.media-amazon.com/images/M/MV5BMTk1ZGZmZGMtYzM2Yi00MGNmLTgxZGItZGRkYzVjODI3ZTlhXkEyXkFqcGdeQXVyMzMwNjQzMzk@._V1_SX300.jpg', 8, 1, 1),
(98, 'Show 98', 'Description for show 98', 7.3, '3h 08min', 15, 'Animation', 'https://m.media-amazon.com/images/M/MV5BMTMwOTQ0NTMwNl5BMl5BanBnXkFtZTcwODExODczNA@@._V1_SX300.jpg', 11, 1, 2),
(99, 'Show 99', 'Description for show 99', 7.8, '3h 09min', 16, 'Family', 'https://m.media-amazon.com/images/M/MV5BMTg1ZDJmN2MtZTczNy00N2JjLTg2ZDUtNDZkZDU3ZGVlZWI1XkEyXkFqcGdeQXVyNzU3NzAwNzg@._V1_SX300.jpg', 16, 1, 3),
(100, 'Show 100', 'Description for show 100', 6.5, '3h 10min', 13, 'Musical', 'https://m.media-amazon.com/images/M/MV5BYzM3NzMwMjEtMTc1MS00M2FhLWI3NzgtMzVhZmZlYjZkMmM4XkEyXkFqcGdeQXVyNjQzNjY4NjY@._V1_SX300.jpg', 18, 1, 1);

-- insert categories
INSERT INTO `Category` (`id`, `name`) VALUES
(1, 'Mystery'),
(2, 'Drama'),
(3, 'Comedy'),
(4, 'Sci-Fi'),
(5, 'Thriller'),
(6, 'Fantasy'),
(7, 'Adventure'),
(8, 'Biography'),
(9, 'Horror'),
(10, 'Crime'),
(11, 'Romance'),
(12, 'Animation'),
(13, 'Family'),
(14, 'Musical'),
(15, 'War'),
(16, 'Western'),
(17, 'History'),
(18, 'Sport'),
(19, 'Documentary');

INSERT INTO `watch_later` (`id`, `user_id`, `show_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 2, 11),
(12, 2, 12),
(13, 2, 13),
(14, 2, 14),
(15, 2, 15),
(16, 2, 16),
(17, 2, 17),
(18, 2, 18),
(19, 2, 19),
(20, 2, 20),
(21, 3, 21),
(22, 3, 22),
(23, 3, 23),
(24, 3, 24),
(25, 3, 25),
(26, 3, 26),
(27, 3, 27),
(28, 3, 28),
(29, 3, 29),
(30, 3, 30);

-- INSERT INTO multimedia_type (id, name) VALUES
-- (1, 'Video'),
-- (2, 'Audio'),
-- (3, 'Image'),
-- (4, 'Document'),
-- (5, 'Podcast'),
-- (6, 'Live Stream');

INSERT INTO multimedia_type (id, name) VALUES
  (1, 'Movie'),
  (2, 'TV Show'),
  (3, 'Theater'),
  (4, 'Documentary'),
  (5, 'Short Film'),
  (6, 'Web Series'),
  (7, 'Animation'),
  (8, 'Live Performance');


INSERT INTO audience_type (id, name) VALUES
(1, 'General'),
(2, 'Children'),
(3, 'Teens'),
(4, 'Adults'),
(5, 'Senior Citizens'),
(6, 'Family'),
(7, 'Students'),
(8, 'Professionals');


INSERT INTO dislike (id, user_id, show_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 2, 1),
(12, 2, 2),
(13, 2, 3),
(14, 2, 4),
(15, 2, 5),
(16, 2, 6),
(17, 2, 7),
(18, 2, 8),
(19, 2, 9),
(20, 2, 10),
(21, 3, 1),
(22, 3, 2),
(23, 3, 3),
(24, 3, 4),
(25, 3, 5),
(26, 3, 6),
(27, 3, 7),
(28, 3, 8),
(29, 3, 9),
(30, 3, 10);

INSERT INTO like (id, user_id, show_id) VALUES
(1, 1, 11),
(2, 1, 12),
(3, 1, 13),
(4, 1, 14),
(5, 1, 15),
(6, 1, 16),
(7, 1, 17),
(8, 1, 18),
(9, 1, 19),
(10, 1, 20),
(11, 2, 11),
(12, 2, 12),
(13, 2, 13),
(14, 2, 14),
(15, 2, 15),
(16, 2, 16),
(17, 2, 17),
(18, 2, 18),
(19, 2, 19),
(20, 2, 20),
(21, 3, 11),
(22, 3, 12),
(23, 3, 13),
(24, 3, 14),
(25, 3, 15),
(26, 3, 16),
(27, 3, 17),
(28, 3, 18),
(29, 3, 19),
(30, 3, 20);

INSERT INTO blocked (id, user_id, show_id) VALUES
(1, 1, 70),
(2, 1, 71),
(3, 1, 72),
(4, 1, 73),
(5, 1, 74),
(6, 1, 75),
(7, 1, 76),
(8, 1, 77),
(9, 1, 78),
(10, 1, 79),
(11, 2, 70),
(12, 2, 71),
(13, 2, 72),
(14, 2, 73),
(15, 2, 74);



-- update urls of shows
UPDATE Show
SET image = CASE
    WHEN id = 1 THEN 'https://m.media-amazon.com/images/M/MV5BMjI1MzM2ODEyMV5BMl5BanBnXkFtZTgwNTIzODAwMzE@._V1_SX300.jpg'
    WHEN id = 2 THEN 'https://m.media-amazon.com/images/M/MV5BYjVmZWZkMTktODNiYS00YTYzLWE4NDAtYTgwOGFhYjc4ZGQ4XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 3 THEN 'https://m.media-amazon.com/images/M/MV5BMTcyNzk5NDg1Nl5BMl5BanBnXkFtZTgwNTM5MDQxNDM@._V1_SX300.jpg'
    WHEN id = 4 THEN 'https://m.media-amazon.com/images/M/MV5BOWVhYzY1ODItOTU0Ni00MDQwLTk3ZDYtOTc0YTAwMmM4NzAxXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 5 THEN 'https://m.media-amazon.com/images/M/MV5BMTg0NjEwNDgxNF5BMl5BanBnXkFtZTcwMjkyOTM3Mg@@._V1_SX300.jpg'
    WHEN id = 6 THEN 'https://m.media-amazon.com/images/M/MV5BMTU0NzI3MDExNl5BMl5BanBnXkFtZTcwNzU3NDcyNA@@._V1_SX300.jpg'
    WHEN id = 7 THEN 'https://m.media-amazon.com/images/M/MV5BNDE2NTM1MWMtNGYxNS00ZmE2LWFjMWMtMTY5MjI3NGQxMmNmXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 8 THEN 'https://m.media-amazon.com/images/M/MV5BMjE2ODg4MDUzOF5BMl5BanBnXkFtZTgwMzk5MjkxMDE@._V1_SX300.jpg'
    WHEN id = 9 THEN 'https://m.media-amazon.com/images/M/MV5BOTBjZGFmZmYtMzVmMi00YjkwLWEyYWMtMmVlOGYzODczYWE4XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 10 THEN 'https://m.media-amazon.com/images/M/MV5BNWNkYzBiOGItZjM4Yi00ZWVlLWJkNDEtYTkzZjJlNmFhNTZlXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 11 THEN 'https://m.media-amazon.com/images/M/MV5BMzkzOTk4NTUwOV5BMl5BanBnXkFtZTcwMDQ5NjcyMQ@@._V1_SX300.jpg'
    WHEN id = 12 THEN 'https://m.media-amazon.com/images/M/MV5BN2NlZjhkYTQtODg4Yy00NTU2LTkwM2YtZWY0OTBkNWQ3MjZjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 13 THEN 'https://m.media-amazon.com/images/M/MV5BYzhiNTY2Mj…WI1YWYtYWYwNDFmOTZiN2NkXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 14 THEN 'https://m.media-amazon.com/images/M/MV5BNDJmNDY3MD…Tg4MWUtMDJjZjM2YjA4NWY1XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 15 THEN 'https://m.media-amazon.com/images/M/MV5BMTg0ZWZjOG…zA0YzA5XkEyXkFqcGdeQXVyODIyNjM1OTk@._V1_SX300.jpg'
    WHEN id = 16 THEN 'https://m.media-amazon.com/images/M/MV5BODAwYjU0Mz…GU4NGU0XkEyXkFqcGdeQXVyMjk1NzAxNg@@._V1_SX300.jpg'
    WHEN id = 17 THEN 'https://m.media-amazon.com/images/M/MV5BOTBlNTliNTItY2VhNS00MjA5LTllYzItMmQyNGRjYTAyZWQxXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 18 THEN 'https://m.media-amazon.com/images/M/MV5BYzI4MzRlMGYtYWUwMC00M2FkLTliN2ItNDA1MDJhOTgwMzY5XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 19 THEN 'https://m.media-amazon.com/images/M/MV5BNWQwYmJjNDgtOGU2MS00MzRmLTgyZmMtMTRjNWQ4ODFjMTBiXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 20 THEN 'https://m.media-amazon.com/images/M/MV5BZjViZjY5NzQtZjVjNS00ZjE2LThiYzItNjY5NjhhOTlhZTVmXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 21 THEN 'https://m.media-amazon.com/images/M/MV5BZDg1NGJlNWMtYmFiOS00MWY1LWFkMjQtMmQxNGEwODFmMzBhXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 22 THEN 'https://m.media-amazon.com/images/M/MV5BNDU4MmU2MjAtYjI3ZC00MDhkLThhZTMtMmFkZWJmMTU2YjFhXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 23 THEN 'https://m.media-amazon.com/images/M/MV5BMjI2NDQ5Mzg0NF5BMl5BanBnXkFtZTgwMDM3NjI2MDE@._V1_SX300.jpg'
    WHEN id = 24 THEN 'https://m.media-amazon.com/images/M/MV5BNmQwNWM0OWEtOGRlMy00ZjQxLWE1MzktMmE4MWNmNTUyMWZjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 25 THEN 'https://m.media-amazon.com/images/M/MV5BMmMzYjQ3YTEtZmZlMi00YTcwLWJmZDYtOGQ1NDVjOWYxMzVhXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 26 THEN 'https://m.media-amazon.com/images/M/MV5BZTY0ZDFjMjktOTkxMS00ZDcxLWIxOTQtYjFjYzMwODA5NTk5XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 27 THEN 'https://m.media-amazon.com/images/M/MV5BOTNiYzQyOWMtM2JhMy00ODc3LTg1ZjItMmZmNmY3NDE1NDg5XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 28 THEN 'https://m.media-amazon.com/images/M/MV5BZWE1MDFhNjctMWU4Yi00Njk3LTlkMWEtNzdjYzQ0MGFlNGYyXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 29 THEN 'https://m.media-amazon.com/images/M/MV5BNjM1NTY4ZmEtZWQ4Yy00ODU3LWEzZjgtZGFkYmRlMDU1M2VjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 30 THEN 'https://m.media-amazon.com/images/M/MV5BMjAxMTA2MDMyNl5BMl5BanBnXkFtZTgwNzU0OTI5NDE@._V1_SX300.jpg'
    WHEN id = 31 THEN 'https://m.media-amazon.com/images/M/MV5BMWRlYjNjNjItODY2Yi00M2M3LWFkMjAtZjMwNGU0NWM2NTRlXkEyXkFqcGdeQXVyMjIyMDk1Nzg@._V1_SX300.jpg'
    WHEN id = 32 THEN 'https://m.media-amazon.com/images/M/MV5BOGQ2YTdhMWEtNmEwZC00YmMwLTkwNDUtZjAzMDVkNzY0ZjliXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 33 THEN 'https://m.media-amazon.com/images/M/MV5BMmM2MzEzZGItODFkMC00ODQ2LTg4ZjYtOWM5OTgwNjE5YzRjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 34 THEN 'https://m.media-amazon.com/images/M/MV5BYjk1YjA2NzgtYTg2YS00NTQ5LTkwMjktNGQ1OTYzZjJiMzUwXkEyXkFqcGdeQXVyMzM4MjM0Nzg@._V1_SX300.jpg'
    WHEN id = 35 THEN 'https://m.media-amazon.com/images/M/MV5BZjMyZmY2YjMtZTEzZC00N2U4LWE5OWQtZmNiYTRlZTUxMTllXkEyXkFqcGdeQXVyMTUyNjc3NDQ4._V1_SX300.jpg'
    WHEN id = 36 THEN 'https://m.media-amazon.com/images/M/MV5BOTcyMTY3YmYtZWQ2NC00ZWMyLWE4MWMtN2U3ODhhYTk4M2ZkXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 37 THEN 'https://m.media-amazon.com/images/M/MV5BZWE1MDFhNjctMWU4Yi00Njk3LTlkMWEtNzdjYzQ0MGFlNGYyXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 38 THEN 'https://m.media-amazon.com/images/M/MV5BNjM1NTY4ZmEtZWQ4Yy00ODU3LWEzZjgtZGFkYmRlMDU1M2VjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 39 THEN 'https://m.media-amazon.com/images/M/MV5BMjAxMTA2MDMyNl5BMl5BanBnXkFtZTgwNzU0OTI5NDE@._V1_SX300.jpg'
    WHEN id = 40 THEN 'https://m.media-amazon.com/images/M/MV5BMWRlYjNjNjItODY2Yi00M2M3LWFkMjAtZjMwNGU0NWM2NTRlXkEyXkFqcGdeQXVyMjIyMDk1Nzg@._V1_SX300.jpg'
    WHEN id = 41 THEN 'https://m.media-amazon.com/images/M/MV5BOGQ2YTdhMWEtNmEwZC00YmMwLTkwNDUtZjAzMDVkNzY0ZjliXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 42 THEN 'https://m.media-amazon.com/images/M/MV5BMmM2MzEzZGItODFkMC00ODQ2LTg4ZjYtOWM5OTgwNjE5YzRjXkEyXkFqcGc@._V1_SX300.jpg'
END
WHERE id BETWEEN 1 AND 42;


UPDATE Show
SET image = CASE
    WHEN id = 1 THEN 'https://m.media-amazon.com/images/M/MV5BMjI1MzM2ODEyMV5BMl5BanBnXkFtZTgwNTIzODAwMzE@._V1_SX300.jpg'
    WHEN id = 2 THEN 'https://m.media-amazon.com/images/M/MV5BYjVmZWZkMTktODNiYS00YTYzLWE4NDAtYTgwOGFhYjc4ZGQ4XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 3 THEN 'https://m.media-amazon.com/images/M/MV5BMTcyNzk5NDg1Nl5BMl5BanBnXkFtZTgwNTM5MDQxNDM@._V1_SX300.jpg'
    WHEN id = 4 THEN 'https://m.media-amazon.com/images/M/MV5BOWVhYzY1ODItOTU0Ni00MDQwLTk3ZDYtOTc0YTAwMmM4NzAxXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 5 THEN 'https://m.media-amazon.com/images/M/MV5BMTg0NjEwNDgxNF5BMl5BanBnXkFtZTcwMjkyOTM3Mg@@._V1_SX300.jpg'
    WHEN id = 6 THEN 'https://m.media-amazon.com/images/M/MV5BMTU0NzI3MDExNl5BMl5BanBnXkFtZTcwNzU3NDcyNA@@._V1_SX300.jpg'
    WHEN id = 7 THEN 'https://m.media-amazon.com/images/M/MV5BNDE2NTM1MWMtNGYxNS00ZmE2LWFjMWMtMTY5MjI3NGQxMmNmXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 8 THEN 'https://m.media-amazon.com/images/M/MV5BMjE2ODg4MDUzOF5BMl5BanBnXkFtZTgwMzk5MjkxMDE@._V1_SX300.jpg'
    WHEN id = 9 THEN 'https://m.media-amazon.com/images/M/MV5BOTBjZGFmZmYtMzVmMi00YjkwLWEyYWMtMmVlOGYzODczYWE4XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 10 THEN 'https://m.media-amazon.com/images/M/MV5BNWNkYzBiOGItZjM4Yi00ZWVlLWJkNDEtYTkzZjJlNmFhNTZlXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 11 THEN 'https://m.media-amazon.com/images/M/MV5BMzkzOTk4NTUwOV5BMl5BanBnXkFtZTcwMDQ5NjcyMQ@@._V1_SX300.jpg'
    WHEN id = 12 THEN 'https://m.media-amazon.com/images/M/MV5BN2NlZjhkYTQtODg4Yy00NTU2LTkwM2YtZWY0OTBkNWQ3MjZjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 13 THEN 'https://m.media-amazon.com/images/M/MV5BYzhiNTY2Mj…WI1YWYtYWYwNDFmOTZiN2NkXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 14 THEN 'https://m.media-amazon.com/images/M/MV5BNDJmNDY3MD…Tg4MWUtMDJjZjM2YjA4NWY1XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 15 THEN 'https://m.media-amazon.com/images/M/MV5BMTg0ZWZjOG…zA0YzA5XkEyXkFqcGdeQXVyODIyNjM1OTk@._V1_SX300.jpg'
    WHEN id = 16 THEN 'https://m.media-amazon.com/images/M/MV5BODAwYjU0Mz…GU4NGU0XkEyXkFqcGdeQXVyMjk1NzAxNg@@._V1_SX300.jpg'
    WHEN id = 17 THEN 'https://m.media-amazon.com/images/M/MV5BOTBlNTliNTItY2VhNS00MjA5LTllYzItMmQyNGRjYTAyZWQxXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 18 THEN 'https://m.media-amazon.com/images/M/MV5BYzI4MzRlMGYtYWUwMC00M2FkLTliN2ItNDA1MDJhOTgwMzY5XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 19 THEN 'https://m.media-amazon.com/images/M/MV5BNWQwYmJjNDgtOGU2MS00MzRmLTgyZmMtMTRjNWQ4ODFjMTBiXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 20 THEN 'https://m.media-amazon.com/images/M/MV5BZjViZjY5NzQtZjVjNS00ZjE2LThiYzItNjY5NjhhOTlhZTVmXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 21 THEN 'https://m.media-amazon.com/images/M/MV5BZDg1NGJlNWMtYmFiOS00MWY1LWFkMjQtMmQxNGEwODFmMzBhXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 22 THEN 'https://m.media-amazon.com/images/M/MV5BNDU4MmU2MjAtYjI3ZC00MDhkLThhZTMtMmFkZWJmMTU2YjFhXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 23 THEN 'https://m.media-amazon.com/images/M/MV5BMjI2NDQ5Mzg0NF5BMl5BanBnXkFtZTgwMDM3NjI2MDE@._V1_SX300.jpg'
    WHEN id = 24 THEN 'https://m.media-amazon.com/images/M/MV5BNmQwNWM0OWEtOGRlMy00ZjQxLWE1MzktMmE4MWNmNTUyMWZjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 25 THEN 'https://m.media-amazon.com/images/M/MV5BMmMzYjQ3YTEtZmZlMi00YTcwLWJmZDYtOGQ1NDVjOWYxMzVhXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 26 THEN 'https://m.media-amazon.com/images/M/MV5BZTY0ZDFjMjktOTkxMS00ZDcxLWIxOTQtYjFjYzMwODA5NTk5XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 27 THEN 'https://m.media-amazon.com/images/M/MV5BOTNiYzQyOWMtM2JhMy00ODc3LTg1ZjItMmZmNmY3NDE1NDg5XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 28 THEN 'https://m.media-amazon.com/images/M/MV5BZWE1MDFhNjctMWU4Yi00Njk3LTlkMWEtNzdjYzQ0MGFlNGYyXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 29 THEN 'https://m.media-amazon.com/images/M/MV5BNjM1NTY4ZmEtZWQ4Yy00ODU3LWEzZjgtZGFkYmRlMDU1M2VjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 30 THEN 'https://m.media-amazon.com/images/M/MV5BMjAxMTA2MDMyNl5BMl5BanBnXkFtZTgwNzU0OTI5NDE@._V1_SX300.jpg'
    WHEN id = 31 THEN 'https://m.media-amazon.com/images/M/MV5BMWRlYjNjNjItODY2Yi00M2M3LWFkMjAtZjMwNGU0NWM2NTRlXkEyXkFqcGdeQXVyMjIyMDk1Nzg@._V1_SX300.jpg'
    WHEN id = 32 THEN 'https://m.media-amazon.com/images/M/MV5BOGQ2YTdhMWEtNmEwZC00YmMwLTkwNDUtZjAzMDVkNzY0ZjliXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 33 THEN 'https://m.media-amazon.com/images/M/MV5BMmM2MzEzZGItODFkMC00ODQ2LTg4ZjYtOWM5OTgwNjE5YzRjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 34 THEN 'https://m.media-amazon.com/images/M/MV5BYjk1YjA2NzgtYTg2YS00NTQ5LTkwMjktNGQ1OTYzZjJiMzUwXkEyXkFqcGdeQXVyMzM4MjM0Nzg@._V1_SX300.jpg'
    WHEN id = 35 THEN 'https://m.media-amazon.com/images/M/MV5BZjMyZmY2YjMtZTEzZC00N2U4LWE5OWQtZmNiYTRlZTUxMTllXkEyXkFqcGdeQXVyMTUyNjc3NDQ4._V1_SX300.jpg'
    WHEN id = 36 THEN 'https://m.media-amazon.com/images/M/MV5BOTcyMTY3YmYtZWQ2NC00ZWMyLWE4MWMtN2U3ODhhYTk4M2ZkXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 37 THEN 'https://m.media-amazon.com/images/M/MV5BZWE1MDFhNjctMWU4Yi00Njk3LTlkMWEtNzdjYzQ0MGFlNGYyXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 38 THEN 'https://m.media-amazon.com/images/M/MV5BNjM1NTY4ZmEtZWQ4Yy00ODU3LWEzZjgtZGFkYmRlMDU1M2VjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 39 THEN 'https://m.media-amazon.com/images/M/MV5BMjAxMTA2MDMyNl5BMl5BanBnXkFtZTgwNzU0OTI5NDE@._V1_SX300.jpg'
    WHEN id = 40 THEN 'https://m.media-amazon.com/images/M/MV5BMWRlYjNjNjItODY2Yi00M2M3LWFkMjAtZjMwNGU0NWM2NTRlXkEyXkFqcGdeQXVyMjIyMDk1Nzg@._V1_SX300.jpg'
    WHEN id = 41 THEN 'https://m.media-amazon.com/images/M/MV5BOGQ2YTdhMWEtNmEwZC00YmMwLTkwNDUtZjAzMDVkNzY0ZjliXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 42 THEN 'https://m.media-amazon.com/images/M/MV5BMmM2MzEzZGItODFkMC00ODQ2LTg4ZjYtOWM5OTgwNjE5YzRjXkEyXkFqcGc@._V1_SX300.jpg'
END
WHERE id BETWEEN 43 AND 85;

UPDATE Show
SET image = CASE
    WHEN id = 43 THEN 'https://m.media-amazon.com/images/M/MV5BMjI1MzM2ODEyMV5BMl5BanBnXkFtZTgwNTIzODAwMzE@._V1_SX300.jpg'
    WHEN id = 44 THEN 'https://m.media-amazon.com/images/M/MV5BYjVmZWZkMTktODNiYS00YTYzLWE4NDAtYTgwOGFhYjc4ZGQ4XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 45 THEN 'https://m.media-amazon.com/images/M/MV5BMTcyNzk5NDg1Nl5BMl5BanBnXkFtZTgwNTM5MDQxNDM@._V1_SX300.jpg'
    WHEN id = 46 THEN 'https://m.media-amazon.com/images/M/MV5BOWVhYzY1ODItOTU0Ni00MDQwLTk3ZDYtOTc0YTAwMmM4NzAxXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 47 THEN 'https://m.media-amazon.com/images/M/MV5BMTg0NjEwNDgxNF5BMl5BanBnXkFtZTcwMjkyOTM3Mg@@._V1_SX300.jpg'
    WHEN id = 48 THEN 'https://m.media-amazon.com/images/M/MV5BMTU0NzI3MDExNl5BMl5BanBnXkFtZTcwNzU3NDcyNA@@._V1_SX300.jpg'
    WHEN id = 49 THEN 'https://m.media-amazon.com/images/M/MV5BNDE2NTM1MWMtNGYxNS00ZmE2LWFjMWMtMTY5MjI3NGQxMmNmXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 50 THEN 'https://m.media-amazon.com/images/M/MV5BMjE2ODg4MDUzOF5BMl5BanBnXkFtZTgwMzk5MjkxMDE@._V1_SX300.jpg'
    WHEN id = 51 THEN 'https://m.media-amazon.com/images/M/MV5BOTBjZGFmZmYtMzVmMi00YjkwLWEyYWMtMmVlOGYzODczYWE4XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 52 THEN 'https://m.media-amazon.com/images/M/MV5BNWNkYzBiOGItZjM4Yi00ZWVlLWJkNDEtYTkzZjJlNmFhNTZlXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 53 THEN 'https://m.media-amazon.com/images/M/MV5BMzkzOTk4NTUwOV5BMl5BanBnXkFtZTcwMDQ5NjcyMQ@@._V1_SX300.jpg'
    WHEN id = 54 THEN 'https://m.media-amazon.com/images/M/MV5BN2NlZjhkYTQtODg4Yy00NTU2LTkwM2YtZWY0OTBkNWQ3MjZjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 55 THEN 'https://m.media-amazon.com/images/M/MV5BYzhiNTY2Mj…WI1YWYtYWYwNDFmOTZiN2NkXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 56 THEN 'https://m.media-amazon.com/images/M/MV5BNDJmNDY3MD…Tg4MWUtMDJjZjM2YjA4NWY1XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 57 THEN 'https://m.media-amazon.com/images/M/MV5BMTg0ZWZjOG…zA0YzA5XkEyXkFqcGdeQXVyODIyNjM1OTk@._V1_SX300.jpg'
    WHEN id = 58 THEN 'https://m.media-amazon.com/images/M/MV5BODAwYjU0Mz…GU4NGU0XkEyXkFqcGdeQXVyMjk1NzAxNg@@._V1_SX300.jpg'
    WHEN id = 59 THEN 'https://m.media-amazon.com/images/M/MV5BOTBlNTliNTItY2VhNS00MjA5LTllYzItMmQyNGRjYTAyZWQxXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 60 THEN 'https://m.media-amazon.com/images/M/MV5BYzI4MzRlMGYtYWUwMC00M2FkLTliN2ItNDA1MDJhOTgwMzY5XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 61 THEN 'https://m.media-amazon.com/images/M/MV5BNWQwYmJjNDgtOGU2MS00MzRmLTgyZmMtMTRjNWQ4ODFjMTBiXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 62 THEN 'https://m.media-amazon.com/images/M/MV5BZjViZjY5NzQtZjVjNS00ZjE2LThiYzItNjY5NjhhOTlhZTVmXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 63 THEN 'https://m.media-amazon.com/images/M/MV5BZDg1NGJlNWMtYmFiOS00MWY1LWFkMjQtMmQxNGEwODFmMzBhXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 64 THEN 'https://m.media-amazon.com/images/M/MV5BNDU4MmU2MjAtYjI3ZC00MDhkLThhZTMtMmFkZWJmMTU2YjFhXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 65 THEN 'https://m.media-amazon.com/images/M/MV5BMjI2NDQ5Mzg0NF5BMl5BanBnXkFtZTgwMDM3NjI2MDE@._V1_SX300.jpg'
    WHEN id = 66 THEN 'https://m.media-amazon.com/images/M/MV5BNmQwNWM0OWEtOGRlMy00ZjQxLWE1MzktMmE4MWNmNTUyMWZjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 67 THEN 'https://m.media-amazon.com/images/M/MV5BMmMzYjQ3YTEtZmZlMi00YTcwLWJmZDYtOGQ1NDVjOWYxMzVhXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 68 THEN 'https://m.media-amazon.com/images/M/MV5BZTY0ZDFjMjktOTkxMS00ZDcxLWIxOTQtYjFjYzMwODA5NTk5XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 69 THEN 'https://m.media-amazon.com/images/M/MV5BOTNiYzQyOWMtM2JhMy00ODc3LTg1ZjItMmZmNmY3NDE1NDg5XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 70 THEN 'https://m.media-amazon.com/images/M/MV5BZWE1MDFhNjctMWU4Yi00Njk3LTlkMWEtNzdjYzQ0MGFlNGYyXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 71 THEN 'https://m.media-amazon.com/images/M/MV5BNjM1NTY4ZmEtZWQ4Yy00ODU3LWEzZjgtZGFkYmRlMDU1M2VjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 72 THEN 'https://m.media-amazon.com/images/M/MV5BMjAxMTA2MDMyNl5BMl5BanBnXkFtZTgwNzU0OTI5NDE@._V1_SX300.jpg'
    WHEN id = 73 THEN 'https://m.media-amazon.com/images/M/MV5BMWRlYjNjNjItODY2Yi00M2M3LWFkMjAtZjMwNGU0NWM2NTRlXkEyXkFqcGdeQXVyMjIyMDk1Nzg@._V1_SX300.jpg'
    WHEN id = 74 THEN 'https://m.media-amazon.com/images/M/MV5BOGQ2YTdhMWEtNmEwZC00YmMwLTkwNDUtZjAzMDVkNzY0ZjliXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 75 THEN 'https://m.media-amazon.com/images/M/MV5BMmM2MzEzZGItODFkMC00ODQ2LTg4ZjYtOWM5OTgwNjE5YzRjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 76 THEN 'https://m.media-amazon.com/images/M/MV5BYjk1YjA2NzgtYTg2YS00NTQ5LTkwMjktNGQ1OTYzZjJiMzUwXkEyXkFqcGdeQXVyMzM4MjM0Nzg@._V1_SX300.jpg'
    WHEN id = 77 THEN 'https://m.media-amazon.com/images/M/MV5BZjMyZmY2YjMtZTEzZC00N2U4LWE5OWQtZmNiYTRlZTUxMTllXkEyXkFqcGdeQXVyMTUyNjc3NDQ4._V1_SX300.jpg'
    WHEN id = 78 THEN 'https://m.media-amazon.com/images/M/MV5BOTcyMTY3YmYtZWQ2NC00ZWMyLWE4MWMtN2U3ODhhYTk4M2ZkXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 79 THEN 'https://m.media-amazon.com/images/M/MV5BZWE1MDFhNjctMWU4Yi00Njk3LTlkMWEtNzdjYzQ0MGFlNGYyXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 80 THEN 'https://m.media-amazon.com/images/M/MV5BNjM1NTY4ZmEtZWQ4Yy00ODU3LWEzZjgtZGFkYmRlMDU1M2VjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 81 THEN 'https://m.media-amazon.com/images/M/MV5BMjAxMTA2MDMyNl5BMl5BanBnXkFtZTgwNzU0OTI5NDE@._V1_SX300.jpg'
    WHEN id = 82 THEN 'https://m.media-amazon.com/images/M/MV5BMWRlYjNjNjItODY2Yi00M2M3LWFkMjAtZjMwNGU0NWM2NTRlXkEyXkFqcGdeQXVyMjIyMDk1Nzg@._V1_SX300.jpg'
    WHEN id = 83 THEN 'https://m.media-amazon.com/images/M/MV5BOGQ2YTdhMWEtNmEwZC00YmMwLTkwNDUtZjAzMDVkNzY0ZjliXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 84 THEN 'https://m.media-amazon.com/images/M/MV5BMmM2MzEzZGItODFkMC00ODQ2LTg4ZjYtOWM5OTgwNjE5YzRjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 85 THEN 'https://m.media-amazon.com/images/M/MV5BYjk1YjA2NzgtYTg2YS00NTQ5LTkwMjktNGQ1OTYzZjJiMzUwXkEyXkFqcGdeQXVyMzM4MjM0Nzg@._V1_SX300.jpg'
END
WHERE id BETWEEN 43 AND 85;


UPDATE Show
SET image = CASE
    WHEN id = 86 THEN 'https://m.media-amazon.com/images/M/MV5BOWVhYzY1ODItOTU0Ni00MDQwLTk3ZDYtOTc0YTAwMmM4NzAxXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 87 THEN 'https://m.media-amazon.com/images/M/MV5BMTg0NjEwNDgxNF5BMl5BanBnXkFtZTcwMjkyOTM3Mg@@._V1_SX300.jpg'
    WHEN id = 88 THEN 'https://m.media-amazon.com/images/M/MV5BMTU0NzI3MDExNl5BMl5BanBnXkFtZTcwNzU3NDcyNA@@._V1_SX300.jpg'
    WHEN id = 89 THEN 'https://m.media-amazon.com/images/M/MV5BNDE2NTM1MWMtNGYxNS00ZmE2LWFjMWMtMTY5MjI3NGQxMmNmXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 90 THEN 'https://m.media-amazon.com/images/M/MV5BMjE2ODg4MDUzOF5BMl5BanBnXkFtZTgwMzk5MjkxMDE@._V1_SX300.jpg'
    WHEN id = 91 THEN 'https://m.media-amazon.com/images/M/MV5BOTBjZGFmZmYtMzVmMi00YjkwLWEyYWMtMmVlOGYzODczYWE4XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 92 THEN 'https://m.media-amazon.com/images/M/MV5BNWNkYzBiOGItZjM4Yi00ZWVlLWJkNDEtYTkzZjJlNmFhNTZlXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 93 THEN 'https://m.media-amazon.com/images/M/MV5BMzkzOTk4NTUwOV5BMl5BanBnXkFtZTcwMDQ5NjcyMQ@@._V1_SX300.jpg'
    WHEN id = 94 THEN 'https://m.media-amazon.com/images/M/MV5BN2NlZjhkYTQtODg4Yy00NTU2LTkwM2YtZWY0OTBkNWQ3MjZjXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 95 THEN 'https://m.media-amazon.com/images/M/MV5BYzhiNTY2Mj…WI1YWYtYWYwNDFmOTZiN2NkXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 96 THEN 'https://m.media-amazon.com/images/M/MV5BNDJmNDY3MD…Tg4MWUtMDJjZjM2YjA4NWY1XkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 97 THEN 'https://m.media-amazon.com/images/M/MV5BMTg0ZWZjOG…zA0YzA5XkEyXkFqcGdeQXVyODIyNjM1OTk@._V1_SX300.jpg'
    WHEN id = 98 THEN 'https://m.media-amazon.com/images/M/MV5BODAwYjU0Mz…GU4NGU0XkEyXkFqcGdeQXVyMjk1NzAxNg@@._V1_SX300.jpg'
    WHEN id = 99 THEN 'https://m.media-amazon.com/images/M/MV5BOTBlNTliNTItY2VhNS00MjA5LTllYzItMmQyNGRjYTAyZWQxXkEyXkFqcGc@._V1_SX300.jpg'
    WHEN id = 100 THEN 'https://m.media-amazon.com/images/M/MV5BYzI4MzRlMGYtYWUwMC00M2FkLTliN2ItNDA1MDJhOTgwMzY5XkEyXkFqcGc@._V1_SX300.jpg'
END
WHERE id BETWEEN 86 AND 100;
