/*
1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу 
"Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/

DELIMITER //

DROP FUNCTION IF EXISTS hello //

CREATE FUNCTION hello ()
RETURNS TINYTEXT DETERMINISTIC

BEGIN
	DECLARE greeting TINYTEXT;
	DECLARE time_now TIME DEFAULT CURTIME();
	
	IF time_now BETWEEN '06:00:00' AND '12:00:00' THEN SET greeting = 'Good morning!';
	ELSEIF time_now BETWEEN '12:00:00' AND '18:00:00' THEN SET greeting = 'Good afternoon!';
	ELSEIF time_now BETWEEN '18:00:00' AND '00:00:00' THEN SET greeting = 'Good evening!';
	ELSEIF time_now BETWEEN '00:00:00' AND '06:00:00' THEN SET greeting = 'Good night!';
	END IF;
	
	RETURN greeting;
END //

DELIMITER ;

/*
2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL 
неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/

DELIMITER //

DROP TRIGGER IF EXISTS products_name_desc_not_null_before_upd //

CREATE TRIGGER products_name_desc_not_null_before_upd BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	IF NEW.name is NULL AND NEW.description IS NULL 
		THEN SET NEW.name = OLD.name AND NEW.description = OLD.description;
	END IF;
END //

DROP TRIGGER IF EXISTS products_name_desc_not_null_before_ins //

CREATE TRIGGER products_name_desc_not_null_before_ins BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF NEW.name is NULL AND NEW.description IS NULL 
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Either name or description should be not null';
	END IF;
END //

DELIMITER ;

