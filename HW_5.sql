create DATABASE hw_5;
use hw_5;
drop table cars;
CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов:
create view cars_below_25000 as
select * from cars
where cost < 25000;

-- 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW):

alter view cars_below_25000 as
select * from cars
where cost < 30000;

-- 3. Создайте представление, в котором будут только автомобили марки "Шкода" и "Ауди":
create view skoda_audi_cars_only as
select * from cars
where name in ("Audi", "Skoda");


