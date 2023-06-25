CREATE DATABASE Phones;
USE Phones;
CREATE TABLE smartPhones (id INT PRIMARY KEY NOT NULL, productName VARCHAR(30) NOT NULL,
manufacturer VARCHAR(30) NOT NULL, productCount INT NOT NULL, price INT NOT NULL);

SELECT * FROM Phones.smartPhones;
INSERT INTO Phones.SmartPhones(id, productName, manufacturer, productCount, price) VALUES
(1001, "iPhone X", "Apple", 10, 499),
(1002, "iPhone 13", "Apple", 50, 599),
(1003, "iPhone 14", "Apple", 100, 799),
(1004, "Note 13 Pro", "Xiaomi", 70, 499),
(1005, "Note T", "Xiaomi", 100, 599),
(1006, "Fold 3", "Samsung", 10, 1099),
(1007, "Galaxy S22 Ultra", "Samsung", 50, 899),
(1008, "Galaxy S22", "Samsung", 150, 799); 

SELECT productName, manufacturer, price FROM Phones.smartPhones WHERE
productCount > 10;

SELECT * FROM Phones.smartPhones WHERE
manufacturer LIKE "Samsung";
