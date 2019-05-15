/* 
1. Подсчитайте средний возраст пользователей в таблице users.
 */

SELECT 
	FLOOR(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())))
FROM 
	users;

/* 
2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что 
необходимы дни недели текущего года, а не года рождения.
 */

SELECT
	CASE 
		WHEN weekday_index = 1 THEN 'Sunday'
		WHEN weekday_index = 2 THEN 'Monday'
		WHEN weekday_index = 3 THEN 'Tuesday'
		WHEN weekday_index = 4 THEN 'Wednesday'
		WHEN weekday_index = 5 THEN 'Thursday'
		WHEN weekday_index = 6 THEN 'Friday'
		WHEN weekday_index = 7 THEN 'Saturday'		
	END AS weekday_name,
	COUNT(weekday_index) AS number_of_birthdays_in_2019
FROM
	(SELECT 
		birthday_at,
		DAYOFWEEK(CONCAT('2019', '-', MONTH(birthday_at), '-', DAY(birthday_at))) weekday_index 
	FROM 
		users) AS birthdays_in_2019
GROUP BY weekday_index
	

	
	
	
	