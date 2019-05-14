/* Спроектируйте базу данных, которая позволяла бы организовать хранение медиа-файлов, загружаемых 
пользователем (фото, аудио, видео). Сами файлы будут храниться в файловой системе, а база данных будет хранить 
только пути к файлам, названия, описания, ключевых слов и принадлежности пользователю. */

DROP DATABASE IF EXISTS multimedia;

CREATE DATABASE multimedia;

USE multimedia;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO users VALUES
	(DEFAULT, 'Sample User', DEFAULT, DEFAULT);

DROP TABLE IF EXISTS pictures;

CREATE TABLE pictures (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	filepath VARCHAR(255),
	description TEXT,
	keywords JSON,
	user_id INT UNSIGNED
);

INSERT INTO pictures VALUES
	(DEFAULT, 'Sample Picture', '/media/pic001.png', 'This is a sample picture', '{"keyword1": "sample", "keyword2": "myphoto"}', DEFAULT);

DROP TABLE IF EXISTS audio;

CREATE TABLE audio (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	filepath VARCHAR(255),
	description TEXT,
	keywords JSON,
	user_id INT UNSIGNED
);

INSERT INTO audio VALUES
	(DEFAULT, 'Sample Audio File', '/media/track001.flac', 'This is a sample audio file', '{"keyword1": "sample", "keyword2": "mysong"}', DEFAULT);

DROP TABLE IF EXISTS video;

CREATE TABLE video (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	filepath VARCHAR(255),
	description TEXT,
	keywords JSON,
	user_id INT UNSIGNED
);

INSERT INTO video VALUES
	(DEFAULT, 'Sample Video File', '/media/clip001.mp4', 'This is a sample video file', '{"keyword1": "sample", "keyword2": "mymovie"}', DEFAULT);
