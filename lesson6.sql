create database lesson6;

use lesson6;
drop procedure hello;
delimiter //
CREATE PROCEDURE hello()
begin
	case
		when curtime() BETWEEN "06:00:00" and "11:59:59" then
			select "доброе утро";
		when curtime() BETWEEN "12:00:00" and "17:59:59" then
			select "добрый день";
		when curtime() BETWEEN "18:00:00" and "23:59:59" then
			select "добрый вечер" as "время";
		else
			select "доброй ночи";
	end case;
end //
delimiter ;

call hello();


delimiter &&
create function fibonacci(n int) -- количество чисел фибоначчи для вывода.
returns varchar(50)
DETERMINISTIC
BEGIN
	declare fib1 int default 0;
    declare fib2 int default 1;
    declare fib3 int default 0;
    declare result VARCHAR(50) DEFAULT "0 1"; -- первые 2 числа фибоначчи
    if n = 1 then
    RETURN fib1;
    elseif n = 2 then
    return concat(fib1, fib2);
    else 
		while n > 2 do
			set fib3 = fib1 + fib2;
            set fib1 = fib2;
            set fib2 = fib3;
            set n = n-1;
            set result = concat(result," ", fib3);
		end while;
        return result;
	end if;
    end &&
    delimiter ;

select fibonacci(10);

drop procedure what_number;
delimiter //
CREATE PROCEDURE what_number(n int)
begin
	case
		when n BETWEEN 1 and 9 then
			select "однозначное число" as "скольки значное число?";
		when n BETWEEN 10 and 99 then
			select "двузначное число" as "скольки значное число?";
		when n BETWEEN 100 and 999 then
			select "трехзначное число" as "скольки значное число?";
		else
			select "другое";
	end case;
end //
delimiter ;

call what_number(10);

drop function n;
delimiter &&
create function n(n int, b int, c int) -- количество чисел фибоначчи для вывода.
returns int
DETERMINISTIC
BEGIN
	return n + b + c ;
    end &&
    delimiter ;

select n(10, 10, 10) as "сумма чисел";

-- ДЗ
-- 1) Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. 
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

delimiter \\
create FUNCTION numberToTimeConverter(num int)
returns VARCHAR(45)
DETERMINISTIC
BEGIN
	DECLARE days int DEFAULT 0;
    DECLARE hours int DEFAULT 0;
    DECLARE minutes int DEFAULT 0;
    DECLARE result varchar(45) DEFAULT ' ';
    
    SET days = num DIV 86400;
    IF days > 0 THEN
    SET result=CONCAT(result,days,' ','days');
    SET num=num % 86400;
    END IF;
    
	SET hours = num DIV 3600;
    IF hours > 0 THEN
    SET result=CONCAT(result,' ',hours,' ','hours');
    SET num=num % 3600;
    END IF;
    
    SET minutes = num DIV 60;
    IF minutes > 0 THEN
    SET result=CONCAT(result,' ',minutes,' ','minutes');
    SET num=num % 60;
    END IF;
    
	IF num > 0 THEN
    SET result=CONCAT(result,' ',num,' ','seconds');
    END IF;
    RETURN result;
END \\
DELIMITER ;
    
select numberToTimeConverter(864300) 'результат';

-- Создайте процедуру, которая выводит только четные числа от 1 до 10. Пример: 2,4,6,8,10
DELIMITER //
CREATE PROCEDURE even()
BEGIN

DECLARE result VARCHAR(50) DEFAULT '';
DECLARE n INT DEFAULT 1;
WHILE n <= 10 DO
	IF n%2=0 THEN
    SET result = CONCAT(result,' ', n);
    END IF;
    SET n=n+1;
END WHILE;
SELECT result AS 'четные числа';
END //
DELIMITER ;

CALL even; 
    
    