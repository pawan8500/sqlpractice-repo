create database testdb;
 use testdb;
 
 CREATE TABLE customers (
    customerid INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE orders (
    orderid INT PRIMARY KEY,
    productid INT,
    pname VARCHAR(50),
    price DECIMAL(10,2),
    customerid INT
);

INSERT INTO customers (customerid, name, city) VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'London'),
(3, 'Charlie', 'Mumbai'),
(4, 'Diana', 'Sydney'),
(5, 'Ethan', 'Toronto');

INSERT INTO orders (orderid, productid, pname, price, customerid) VALUES
(101, 201, 'Laptop', 800.00, 1),
(102, 202, 'Mouse', 25.00, 1),
(103, 203, 'Keyboard', 45.00, 2),
(104, 204, 'Monitor', 200.00, 2),
(105, 205, 'Printer', 150.00, 3),
(106, 206, 'Tablet', 300.00, 3),
(107, 207, 'Mobile', 500.00, 4),
(108, 208, 'Headphones', 75.00, 4),
(109, 209, 'Camera', 600.00, 5),
(110, 210, 'Speaker', 120.00, 5);

select * from customers;
select * from orders;

-- orders table customerId is here an foriegn key which is conecting to customer id to customer table
-- 

select o.orderid, o.pname, o.customerid from orders as o;

select c.customerid, c,name from customers as c;

-- joins based on the common column
select o.orderid, o.pname, o.customerid, c.customerid, c.name from orders as o
join customers as c
where o.customerid=c.customerid;

-- get the country id, code, name , continent for each country
-- city id, city, name country name for each city persent in table