DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;

USE vk;

-- DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  firstname VARCHAR(50),
  lastname VARCHAR(50),
  email VARCHAR(120),
  phone INT, -- INT may not be the best data type for phone numbers, but I'm not sure
  INDEX users_firstname_lastname_idx(firstname, lastname) 
);

-- DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY,
  sex ENUM('M', 'F'), -- changed data type
  birthday DATE, -- changed data type
  hometown VARCHAR(100),
  FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED NOT NULL,
  body TEXT,
  created_at DATETIME DEFAULT NOW(),
  PRIMARY KEY (from_user_id, created_at),
  INDEX messages_from_user_id_idx(from_user_id),
  INDEX messages_to_user_id_idx(to_user_id),
  FOREIGN KEY (from_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- DROP TABLE IF EXISTS friendship;
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL,
  friend_id INT UNSIGNED NOT NULL,
  status ENUM('Requested', 'Confirmed', 'Rejected'), -- changed data type
  requested_at DATETIME DEFAULT NOW(),
  confirmed_at DATETIME,
  PRIMARY KEY (user_id, friend_id),
  INDEX frienship_user_id_idx(user_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- DROP TABLE IF EXISTS communities;
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150),
  INDEX communities_name_idx(name)
);

-- DROP TABLE IF EXISTS communities_users;
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (community_id, user_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (community_id) REFERENCES communities(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- DROP TABLE IF EXISTS media;
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, -- changed data type for FK compatibility
  media_type ENUM('Picture', 'Audio', 'Video'), -- added instead of media_type_id, no need for table media_types
  -- media_type_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  filename VARCHAR(255),
  size INT,
  metadata JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX media_user_id_idx(user_id),
  INDEX media_media_type_idx(media_type), -- updated for media_type field
  FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

/*
CREATE TABLE media_types (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
*/

-- DROP TABLE IF EXISTS subject_types;
CREATE TABLE subject_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, -- changed data type for FK compatibility
  name VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  by_user_id INT UNSIGNED NOT NULL, -- changed column name
  to_subject_id INT UNSIGNED NOT NULL,
  subject_type_id INT UNSIGNED NOT NULL,
  kind ENUM('Like', 'Love', 'Haha', 'Wow', 'Sad', 'Angry'), -- added kinds of likes (the list is taken from Facebook)
  created_at DATETIME DEFAULT NOW(),
  PRIMARY KEY (by_user_id, to_subject_id, subject_type_id),
  FOREIGN KEY (by_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (to_subject_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (subject_type_id) REFERENCES subject_types(id) ON UPDATE CASCADE ON DELETE CASCADE
);
