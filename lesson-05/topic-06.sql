/*
1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
*/

START TRANSACTION;

INSERT INTO sample.users (name, birthday_at)
	SELECT name, birthday_at FROM shop.users WHERE id = 1;

DELETE FROM shop.users WHERE id = 1;

COMMIT;

/*
2. Создайте представление, которое выводит название name товарной позиции из таблицы products 
и соответствующее название каталога name из таблицы catalogs.
*/

CREATE VIEW products_catalogs_view AS
	SELECT 
		p.name AS product_name, 
		c.name AS catalog_name
	FROM products p JOIN catalogs c 
		ON p.catalog_id = c.id;