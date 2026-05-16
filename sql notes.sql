-- database is collection of similar data
-- to view all database in the DBMS
SHOW DATABASES;

-- to create your own database
CREATE DATABASE regex;

-- 
USE regex;
-- to show the tables of an databases
SHOW TABLES;

-- to create tables and columns in it
CREATE TABLE student(studentID INT, name CHAR(10) );

-- to use an specific database 
USE sakila;
SHOW TABLES;

-- to explain the table structure we can use both describe OR desc KEYWORDS
DESCRIBE actor;
-- to select( select column_name from table_name )
SELECT * FROM actor;

-- to select specific columns 
SELECT actor_id, first_name, last_name FROM actor;

-- to perform arthmatic operations / there is no impact of select on orginal data 
SELECT actor_id*10, first_name, last_name FROM actor;

-- to filter the rows( SELECT * FROM TABLE WHERE condition ) conditions applies on column and perform task on rows
SELECT * FROM actor WHERE actor_id=3;
SELECT * FROM actor WHERE actor_id>3;
SELECT * FROM actor WHERE actor_id!=3;
SELECT * FROM actor WHERE actor_id%2=0;

-- to filter string data from database
SELECT * FROM actor WHERE first_name='NICK';

-- logical operators and, or
SELECT * FROM actor WHERE actor_id>3 AND actor_id<7;



SELECT * FROM actor WHERE actor_id=3 OR actor_id=7;


-- to concat string
select first_name, concat('Mr',first_name), substr(first_name, -2) from actor;

select first_name, substr(first_name, -2), substr(first_name, -4,2) from actor;


-- Trim() function: trim removes to leading and trailing spaces but not the spaces btw characters
select char_length('   abhishek   ');
select trim('   abhishek   ');

-- removing charater from string using trim
select trim(both 'a' from 'aaaanaman');

-- repalace to removes char

-- apply on a column
select first_name, trim(both 'E' from first_name) from actor;

-- to count total character 
select char_length('abhi  ');

-- lpad / rpad (left padding / right padding)
select lpad( '10294',6,'@');

-- concat, substr, trim, char_length, lpad

-- number function => round, truncate

-- to round of the values
select 12.45, round(12.45);  -- it round of in forward
select 12.57, round(12.57);  -- it round of in downward

-- if we want to round the decimal values(value after decimal)
select 23.68, round(23.68, round(23.654,2)); -- here we trying to round second decimal value we check 
-- it if it is greater then 5 it second is now 6 but not it returns 23.65

select 89, round(89.45, -1);

-- truncate only extract the value
select round(14.685, 2), truncate(14.685,2);

-- floor gives niche vali value or ceil gives upper vali value
select floor(5.999999), ceil(6.0000000);

-- DISTINCT function will give you all unique values from the column
select distinct(amount) from payment;

-- fuction count(rows)
select count(first_name) from actor;

-- count( distinct() ) will give the unique values form columns 
select count(distinct(first_name)) from actor;

-- date functions 
-- curdate(), current_time(), current_timestamp(), now()

select now(), adddate( now(), 2); -- by adddate we can add days in current date

use sakila;
select payment_date, adddate( payment_date, 2) from payment; -- already data uspe apply kiya hai

select now(), adddate( now(), interval 2 week); -- current time ke sath
select now(), adddate( now(), interval 2 quarter);

-- subdate() it is use to minus date we can also use adddate to minus date by passing negative values

select now(), month( now() ), year( now());


-- extract function
select now(), extract( month from now());
select now(), extract( day from now());

select *, month(payment_date) from payment -- to extract payments made in 5th month
where month(payment_date)=5 ;

select *, year(payment_date) from payment -- to extract payments made in year 2006
where year(payment_date)=2006;


-- multi row functions( aggregate functions => which will be used for calculation)
-- sum(), count(), avg(), max(), min()
-- kisi bhi aggregate function ke sath hum koi or coulmn select nhi kr sakte hai
select sum(amount) from payment;
select count(amount) from payment;
select avg(amount) from payment;
select max(amount) from payment;
select min(amount) from payment;

select count(amount), count(payment_id), count(*) from payment;

-- data from the month 5th or 6th
select count(*) from payment
where month(payment_date) in (5,6);

-- find the total amount and number of transaction done for the amount greater than 5$ and after march month
-- we can say we can't select non-aggregate column with aggregate column
select sum(amount), count(amount) from payment
where month(payment_date)>3 and amount>5; 

-- need to find total customer and the total number of unique customer done the payment in the last day of the month where the amount is > $0.5
select payment_id, amount, date(payment_date), last_day(payment_date) from payment
where date(payment_date)=last_day(payment_date) and amount>0.5;

select count(customer_id), count( distinct customer_id) from payment
where date(payment_date)=last_day(payment_date) and amount>0.5;

select distinct customer_id from payment; 
-- select customer_id, distinct amount from payment;  you can't chose a column before distinct 

select distinct customer_id, amount from payment; -- it gives the unique pairs of the customer id and amount
select distinct amount, staff_id from payment; -- combination of amount and staff id should be unique

-- GROUP BY => is a statement which is used to group similar values in rows 
--             the group name is based on uniquesness of values 
--             on which column we group by we can only select that column
--             we can't select a column directly untill on that column no function is aplied
select customer_id, sum(amount) from payment group by customer_id;
select staff_id, sum(amount) from payment group by staff_id;

select payment_id, count(*), sum(amount) from payment group by payment_id;

-- find how many time each amount is visible 
select amount, count(amount) as totalCount from payment group by amount;

-- try to get the total amount, max amount, and the total transaction done by each customer
select customer_id, count(amount), max(amount) from payment group by customer_id;

-- find total amount spend by each staff along with the number of customer they have served only after the payment id 9
select staff_id, sum(amount), max(amount), count(customer_id) from payment
where payment_id>9 group by staff_id; 

-- find the total spend, average spend, and the no. of transaction done in each month 
select month(payment_date), sum(amount), avg(amount), count(payment_id) 
from payment
group by mount(payment_date);

-- get total, avg, max amount done for the first week of each mount for may, june, july
select  month(payment_date), sum(amount), avg(amount), max(amount) 
from payment 
where month(payment_date) in(5,6,7) and day(payment_date) between 1 and 7
group by month(payment_date);
