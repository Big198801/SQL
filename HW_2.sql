CREATE DATABASE IF NOT EXISTS lesson_2_HW;
DROP DATABASE IF EXISTS lesson_2_HW;
USE lesson_2_HW; 

CREATE TABLE sales
(id INT AUTO_INCREMENT PRIMARY KEY,
order_date DATE NOT NULL,
count_product INT NOT NULL);

SELECT * FROM sales;
INSERT INTO sales (order_date, count_product)
VALUES
("2021-01-01", 156),
("2021-01-02", 180),
("2021-01-03", 21),
("2021-01-04", 124),
("2021-01-05", 341);

SELECT 
id AS "номер заказа",
IF (count_product < 100, "маленький заказ",
	IF (count_product >= 100 AND count_product < 300, "средний заказ",
		IF (count_product >= 300, "большой заказ", "неопределено"))) AS "тип заказа" 
FROM sales;

CREATE TABLE orders
(id INT AUTO_INCREMENT PRIMARY KEY,
employee VARCHAR(10) NOT NULL,
amount DOUBLE NOT NULL,
order_status VARCHAR(10) NOT NULL);

INSERT INTO orders (employee, amount, order_status)
VALUES 
("e03", 15.00, "OPEN"),
("e01", 25.50, "OPEN"),
("e05", 100.70, "CLOSED"),
("e02", 22.18, "OPEN"),
("e04", 9.50, "CANCELLED");

SELECT * FROM orders;

SELECT * ,
	CASE
		WHEN order_status = "OPEN" THEN "Order is in open state"
        WHEN order_status = "CLOSED" THEN "Order is closed"
        ELSE "Order is cancelled"
	END full_order_status
FROM orders;

-- O - это значение. в отличии от NULL, которое говорит об отсутствии какого-либо значения.
        



