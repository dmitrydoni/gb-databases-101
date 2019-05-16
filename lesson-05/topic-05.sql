/*
1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
*/
 
SELECT 
	name 
FROM 
	users
WHERE 
	EXISTS (SELECT id FROM orders WHERE users.id = orders.user_id);

/*
2. Выведите список товаров products и разделов catalogs, который соответствует товару.
*/
SELECT 
	p.name, c.name 
FROM products p JOIN catalogs c 
	ON p.catalog_id = c.id