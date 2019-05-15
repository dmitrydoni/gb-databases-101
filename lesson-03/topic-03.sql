/* 
1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
*/

UPDATE users SET created_at = NOW() WHERE created_at IS NULL;
UPDATE users SET updated_at = NOW() WHERE updated_at IS NULL;

/* 
2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них 
долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, 
сохранив введеные ранее значения.
*/

-- create a table with incorrect data types
CREATE TABLE users2 (
  id SERIAL PRIMARY KEY,
  name varchar(255),
  birthday_at date DEFAULT NULL,
  created_at varchar(255),
  updated_at varchar(255)
) 

-- populate the table with test data
INSERT INTO users2 (created_at, updated_at) VALUES ('20.10.2017 8:10', '20.10.2017 8:10');
INSERT INTO users2 (created_at, updated_at) VALUES ('10.02.2013 4:11', '20.10.2017 8:10');
INSERT INTO users2 (created_at, updated_at) VALUES ('03.09.2000 11:58', '20.10.2017 8:10');

-- create a table with correct data types
CREATE TABLE users3 (
  id SERIAL PRIMARY KEY,
  name varchar(255),
  birthday_at date DEFAULT NULL,
  created_at datetime,
  updated_at datetime
) 

-- populate the table with converted data
INSERT INTO users3 (name, birthday_at, created_at, updated_at)
SELECT name, birthday_at, STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'), STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i') FROM users2;

/* 
3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, 
после всех записей.
*/

(SELECT value FROM storehouses_products WHERE value>0 ORDER BY value LIMIT 10)
UNION ALL
(SELECT value FROM storehouses_products WHERE value=0)