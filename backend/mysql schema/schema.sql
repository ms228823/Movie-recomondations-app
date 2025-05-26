-- Users table: stores user account info
CREATE TABLE user_info (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

-- Categories table: stores categories like action, comedy, etc.
CREATE TABLE Category (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

-- Multimedia types table: stores types like movie, series, etc.
CREATE TABLE multimedia_type (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

-- Audience types table: stores types like kids, teens, adults
CREATE TABLE audience_type (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

-- Shows table: stores all shows/movies information
CREATE TABLE Show (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  rating INT NOT NULL,
  time VARCHAR(255) NOT NULL,
  age_limit INT NOT NULL,
  Category VARCHAR(255) NOT NULL, -- redundant if using Category_id
  image VARCHAR(255) NOT NULL,
  Category_id INT NOT NULL,
  multimedia_type_id INT,
  audience_type_id INT,
  FOREIGN KEY (Category_id) REFERENCES Category(id),
  FOREIGN KEY (multimedia_type_id) REFERENCES multimedia_type(id),
  FOREIGN KEY (audience_type_id) REFERENCES audience_type(id)
);

-- Watch later table: links users to shows they want to watch later
CREATE TABLE watch_later (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  show_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (show_id) REFERENCES Show(id)
);

-- Likes table: tracks shows that users liked
CREATE TABLE `like` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  show_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (show_id) REFERENCES Show(id)
);

-- Dislikes table: tracks shows that users disliked
CREATE TABLE dislike (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  show_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (show_id) REFERENCES Show(id)
);

-- Blocked table: tracks shows that users have blocked
CREATE TABLE blocked (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  show_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (show_id) REFERENCES Show(id)
);
