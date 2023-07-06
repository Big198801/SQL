create database if not exists Lesson_3;
drop database if exists Lesson_3;
use Lesson_3;
create table if not exists staff
(
id int primary key AUTO_INCREMENT,
firstname varchar(45),
lastname varchar(45),
post varchar(45),
seniority int,
salary int,
age int);

drop table if exists staff;
select * from staff;
insert into staff (firstname, lastname, post, seniority, salary, age)
values
("Вася", "Васькин", "Начальник", 40, 100000, 60),
("Петя", "Власов", "Начальник", 8, 70000, 30),
("Катя", "Катина", "Инженер", 12, 50000, 35),
("Саша", "Сасин", "Инженер", 40, 30000, 59),
("Игорь", "Васькин", "Рабочий", 40, 30000, 59),
("Поли", "Власов", "Рабочий", 8, 55000, 51),
("Катя", "Катика", "Рабочий", 12, 11000, 23),
("Саша", "Сенин", "Уборщик", 40, 10000, 49);

drop table if exists activity_staff;
create table if not exists activity_staff
(
id int primary key AUTO_INCREMENT,
staff_id int,  
date_activity date,
count_pages int,
FOREIGN key(staff_id) REFERENCES staff(id));

INSERT into activity_staff (`staff_id`, `date_activity`, `count_pages`)
VALUES
(1,'2022-01-01',250),
(2,'2022-01-01',220),
(3,'2022-01-01',170),
(1,'2022-01-02',100),
(2,'2022-01-01',220),
(3,'2022-01-01',300),
(7,'2022-01-01',350),
(1,'2022-01-03',168),
(2,'2022-01-03',62),
(3,'2022-01-03',84);

select * from activity_staff;

-- посчитаем среднюю зарплатуALTER
select * from staff
where salary > (select avg(salary) from staff);

-- получим информацию о ЗП от меньшего к большему у которых стаж > 5 и должность = начальник;

select * from staff
where seniority > 5 and post = "Начальник"
order by salary; -- ASC исходный параметр возрастания / DESС исходный параметр убывания

-- Выведите все записи, отсортированные по полю "agе" по возрастанию
select * from staff
order by age;

-- Выведите все записи, отсортированные по полю "firstname"
select * from staff
ORDER BY firstname;

-- Выведите записи полей "firstname ", "lastname", "age", отсортированные по полю "firstname" в алфавитном порядке по убыванию
select firstname, lastname, age from staff
ORDER BY firstname DESC;

-- Выполните сортировку по полям "firstname " и "age" по убыванию
select * from staff
ORDER BY firstname desc, age desc;

-- сколько всего фамилий
select count(lastname) from staff;


select DISTINCT lastname from staff -- DISTINCT уникальное значение
order by lastname;

-- количество уникальных фамилий
select count(DISTINCT lastname) from staff;

-- вывести первые 5 строк
select id, lastname
from staff
limit 5;

-- вывести НАЧИНАЯ с 3 строки СЛЕДУЮЩИЕ 6 строк, 
select id, lastname
from staff
limit 3, 6;

-- вывести c конца с 3 строки СЛЕДУЮЩИЕ 6 строк, 
select id, lastname 
from staff
ORDER BY id desc
limit 2, 6;

-- Выведите уникальные (неповторяющиеся) значения полей "firstname"

select DISTINCT firstname from staff;

-- Отсортируйте записи по убыванию значений поля "id".
-- Выведите первые две записи данной выборки

select * from staff
order by id desc
limit 2;

-- Отсортируйте записи по возрастанию значений поля "id"
-- Пропустите первые 4 строки данной выборки и извлеките следующие 3

select * from staff
order by id
limit 4, 3;

-- Отсортируйте записи по убыванию поля "id". 
-- Пропустите две строки данной выборки и извлеките следующие за ними 3 строки

select * from staff
order by id desc
limit 2, 3;

-- для работы таблицы, иначе ошибка
SET sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

-- максимальную и минимальную зп по каждой должности
SELECT sum(salary) "сумма по должности", 
GROUP_CONCAT(lastname) "фамилии сотрудников", 
post,
MAX(salary) "Макс ЗП",
MIN(salary) "макс ЗП",
MAX(salary) - MIN(salary) "разница зп"
from staff
group by post;

select concat(firstname, " ", lastname) from staff;

select * from activity_staff;
-- общее количество напечатанных страниц каждым сотрудником
select staff_id, sum(count_pages) from activity_staff
group by staff_id;

-- посчитать  количество страниц за каждый день
select date_activity, SUM(count_pages) " общее количество страниц за день" from activity_staff
GROUP BY date_activity;

-- 3. Найдите среднее арифметическое по количеству ежедневных страниц
select sum(count_pages)/count(Distinct(date_activity)) "среднее в день" from activity_staff;


    
SELECT SUM(salary), name_age
FROM
(SELECT salary,
	CASE 
		WHEN age < 20 THEN 'младше 20 лет'
        WHEN age BETWEEN 20 AND 40 THEN 'от 20 до 40 лет'
        WHEN age > 40 THEN 'старше  40 лет '
        ELSE 'Не определено'
	END AS name_age 
FROM staff) AS `lists`
GROUP BY name_age;

SELECT AVG(sum_pages)
FROM
(SELECT date_activity, SUM(count_pages) AS 'sum_pages'
FROM activity_staff
GROUP BY date_activity) AS `lists`;


SELECT salary, COUNT(id)
FROM staff
GROUP BY salary
HAVING salary > 50000;

SELECT salary
FROM staff
WHERE salary > 50000;


SELECT salary
FROM staff
HAVING AVG(salary) > 10000;

SELECT salary, COUNT(id) AS 'Колво'
FROM staff
WHERE post !="Начальник"
GROUP BY salary
HAVING salary > 50000;



-- ДЗ 
-- Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; 
select * from staff
order by salary desc;
-- возрастания 
select * from staff
order by salary asc;

-- Выведите 5 максимальных заработных плат (salary)
select firstname "имя", salary "зарплата" from staff
order by salary
limit 5;

-- Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
select sum(salary), post from staff
group by post;

-- Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
select COUNT(post)"Количество", age from staff
WHERE post = "Рабочий" and age BETWEEN 23 and 50;

-- Найдите количество специальностей
select count(DISTINCT(post))"количество специальностей" from staff;

-- Выведите специальности, у которых средний возраст сотрудников меньше 30 лет включительно
select post from
(select post, AVG(age) "average_Age" from staff GROUP BY post) as list
where average_Age<= 30; 

select * from activity_staff;
-- Выведите id сотрудников, которые напечатали более 500 страниц за всех дни
select staff_id, sum(count_pages) from activity_staff
GROUP BY staff_id
having sum(count_pages) > 500;

-- Выведите дни, когда работало более 3 сотрудников Также укажите кол-во сотрудников, которые работали в выбранные дни.

select date_activity, count(staff_id) from activity_staff
GROUP BY date_activity
HAVING count(staff_id) > 3;

-- Выведите среднюю заработную плату по должностям, которая составляет более 30000
select avg(salary), post from staff
GROUP BY post
having avg(salary) > 30000;







