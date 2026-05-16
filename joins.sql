create database rmd;
use rmd;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10,2)
);


INSERT INTO customers VALUES
(1, 'John', 'New York'),
(2, 'Alice', 'Los Angeles'),
(3, 'Bob', 'Chicago'),
(4, 'Emma', 'Houston'),
(5, 'Michael', 'Phoenix'),
(6, 'Sophia', 'Dallas'),
(7, 'David', 'Seattle'),
(8, 'Olivia', 'Boston'),
(9, 'James', 'Denver'),
(10, 'Isabella', 'Miami');


INSERT INTO orders VALUES
(101, 1, 250.00),
(102, 2, 300.00),
(103, 1, 150.00),
(104, 3, 400.00),
(105, 5, 500.00),
(106, 7, 700.00),
(107, 7, 200.00),
(108, 9, 350.00),
(109, 11, 600.00),  -- No matching customer
(110, 12, 800.00);  -- No matching customer

select * from customers;
select * from orders;

-- INNER JOIN 
-- it gives only the common data/element from the both the tables

select cs.customer_id, cs.name, ods.order_id, ods.order_amount from customers as cs
inner join orders as ods
on cs.customer_id=ods.customer_id;


-- (customer is left) LEFT JOIN (order is right)  
-- gives the common data and the the data of the left table
select cs.customer_id, cs.name, ods.order_id, ods.order_amount from customers as cs
left join orders as ods
on cs.customer_id=ods.customer_id;

-- finding the customer who didn't order any thing or have null data
select cs.customer_id, cs.name, ods.order_id, ods.order_amount from customers as cs
left join orders as ods
on cs.customer_id=ods.customer_id
where ods.order_id is null;

-- (customer is left) RIGHT JOIN (order is right)
-- gives the common data and the data of the right table
select cs.customer_id, cs.name, ods.order_id, ods.order_amount from customers as cs
right join orders as ods
on cs.customer_id=ods.customer_id;

-- find total amount spent for the order place by the cusotomer
select sum(ods.order_amount) from customers as cs
inner join orders as ods
on cs.customer_id=ods.customer_id;

-- get the total num of order which are not placed by the customer
select count(ods.order_id) from customers as cs
right join orders as ods
on cs.customer_id=ods.customer_id
where cs.customer_id is null;

-- get the total amount, avg spent for the orders placed by customer id 3 and more than that
select sum(ods.order_amount), avg(ods.order_amount) from customers as cs
inner join orders as ods
on cs.customer_id=ods.customer_id
where ods.customer_id >= 3 ;

-- 2 -> show customers who placed orders 
select distinct(cs.customer_id), cs.name 
from customers as cs
inner join orders as ods
on cs.customer_id=ods.customer_id;

-- 3 -> Show all customers and their orders (include customers with no orders)
select ods.customer_id, cs.name, ods.order_id, ods.order_amount
from customers as cs
right join orders as ods
on cs.customer_id=ods.customer_id;

-- 4 -> List customer name, city, and order amount for orders greater than 300.
select cs.name, cs.city, ods.order_amount 
from customers as cs
inner join orders as ods
on cs.customer_id=ods.customer_id
where order_amount > 300;

-- 5 -> Show all orders where the customer does NOT exist in the customers table. 
select ods.order_id, ods.customer_id, ods.order_amount
from customers as cs
right join orders as ods 
on cs.customer_id=ods.customer_id
where cs.customer_id is null;

-- 6 -> Find total amount spent by each customer.
select ods.customer_id, cs.name, sum(ods.order_amount) as TotalAmount
from customers as cs
right join orders as ods 
on cs.customer_id=ods.customer_id
group by ods.customer_id;

-- 7 Show customers who have not placed any orders.
select cs.customer_id, cs.name, ods.order_id, ods.order_amount from customers as cs
left join orders as ods
on cs.customer_id=ods.customer_id
where ods.order_id is null;

--  8 Find the average order amount per customer
select ods.customer_id, avg(ods.order_amount) as avgAmount
from customers as cs
right join orders as ods 
on cs.customer_id=ods.customer_id
group by ods.customer_id;

-- 9 Show the customer who placed the highest single order.
select ods.customer_id, ods.order_id, ods.order_amount
from orders as ods
order by ods.order_amount desc
limit 1;

-- 10 Count how many orders each customer placed.
select ods.customer_id, count(ods.order_id) AS total_orders
from orders as ods
group by ods.customer_id;


-- 11 Show customers who placed 2 or more orders.
select ods.customer_id, count(ods.order_id)
from orders as ods
group by ods.customer_id
having count(ods.order_id) >= 2;

-- 12 Find customers whose total spending is greater than 400.
select ods.customer_id, sum(ods.order_amount) as TotalAmount
from customers cs
right join orders ods 
on cs.customer_id = ods.customer_id
group by ods.customer_id
having sum(ods.order_amount) > 400;

-- 13 Show all customers along with total orders, total spending(Even if they placed zero orders.)
select ods.customer_id, cs.name, count(ods.order_id ) as Total_order, sum(ods.order_amount) as Total_amount
from customers as cs
right join orders as ods
on cs.customer_id=ods.customer_id
group by ods.customer_id;

-- 14. Find customers who placed orders, but their total spending is less than the average spending of all customers.
select cs.name
from customers as cs
left join orders as ods
on cs.customer_id=ods.customer_id
group by cs.name
having sum(ods.order_amount) < avg(ods.order_amount);

-- 15. Show invalid orders (orders linked to non-existent customers)
select ods.order_id
from customers as cs
right join orders as ods
on cs.customer_id = ods.customer_id
where cs.customer_id is null;

-- cross join / cartesian join
-- it shows the relation of each row of one table with each rows of the another table (combine each rows of one table with another tables rows)
-- formula of given output columns m*n means in first table 3 rows or another 5 rows it gives us 15 rows
select * from customers cross join orders;

-- natural join
-- it apply join on the common columns of table
-- natural join automatiacally combines rows from two tables based on all columns that have both 
-- the same name and compatible data types
-- natural join is applied on the same column name of the both tables(did the an example in world database)
select * from customers
natural join orders;