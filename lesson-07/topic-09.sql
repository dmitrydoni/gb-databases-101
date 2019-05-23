/*
1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products 
в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и 
содержимое поля name.
*/

DROP TABLE IF EXISTS logs;

CREATE TABLE logs (
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	table_name TINYTEXT,
	primary_key_id INT,
	name VARCHAR(255)
) ENGINE=Archive; 

DELIMITER //

DROP TRIGGER IF EXISTS users_log_after_ins //

CREATE TRIGGER users_log_after_ins AFTER INSERT ON users
FOR EACH ROW
BEGIN
	DECLARE user_name TINYTEXT;
	SET user_name = NEW.name;
	INSERT INTO logs (table_name, primary_key_id, name) VALUES ('users', NEW.id, user_name);
END //

DROP TRIGGER IF EXISTS catalogs_log_after_ins //

CREATE TRIGGER catalogs_log_after_ins AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	DECLARE catalog_name TINYTEXT;
	SET catalog_name = NEW.name;
	INSERT INTO logs (table_name, primary_key_id, name) VALUES ('catalogs', NEW.id, catalog_name);
END //

DROP TRIGGER IF EXISTS products_log_after_ins //

CREATE TRIGGER products_log_after_ins AFTER INSERT ON products
FOR EACH ROW
BEGIN
	DECLARE product_name TINYTEXT;
	SET product_name = NEW.name;
	INSERT INTO logs (table_name, primary_key_id, name) VALUES ('products', NEW.id, product_name);
END //

DELIMITER ;
