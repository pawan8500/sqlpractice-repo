create database windowdb;
use windowdb;

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    sale_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO Sales (sale_id, customer_name, sale_date, amount) VALUES
(1, 'Alice',   '2024-01-05', 250.00),
(2, 'Bob',     '2024-01-06', 180.50),
(3, 'Charlie', '2024-01-07', 320.75),
(4, 'Alice',   '2024-01-10', 150.00),
(5, 'Bob',     '2024-01-12', 400.00),
(6, 'David',   '2024-01-15', 275.25),
(7, 'Eve',     '2024-01-18', 500.00),
(8, 'Charlie', '2024-01-20', 220.00),
(9, 'Alice',   '2024-01-22', 330.40),
(10, 'David',  '2024-01-25', 145.75),
(11, 'Eve',    '2024-02-01', 600.00),
(12, 'Bob',    '2024-02-03', 210.30),
(13, 'Charlie','2024-02-05', 390.60),
(14, 'Alice',  '2024-02-07', 120.00),
(15, 'David',  '2024-02-10', 310.00),
(16, 'Eve',    '2024-02-12', 450.00),
(17, 'Bob',    '2024-02-15', 275.00),
(18, 'Charlie','2024-02-18', 500.00),
(19, 'Alice',  '2024-02-20', 200.00),
(20, 'David',  '2024-02-22', 350.00),
(21, 'Eve',    '2024-02-25', 700.00),
(22, 'Bob',    '2024-02-27', 150.00),
(23, 'Charlie','2024-03-01', 425.50),
(24, 'Alice',  '2024-03-03', 275.75),
(25, 'David',  '2024-03-05', 500.00);


select * from sales;

-- row_number
select *, row_number() over(partition by customer_name) from sales;

-- rank() dense_rank()
select *, rank() over(order by amount),
dense_rank() over(order by amount) from sales;

select * from 
( select *, dense_rank() over(order by amount desc) as rankings from sales ) as tmp 
where rankings=3;

-- lag()  it gives us the data previous(yesterday) date
select *, lag(amount, 1) over() from sales; -- to find for all 

select *, lag(amount, 2) over(partition by customer_name) from sales; -- to find by customer name

select *, lag(sale_date, 1) over(), sale_date-lag(sale_date,1) over() from sales;

--  lead()  it gives the data of next(tommorow) date
select *, lead(amount, 1) over() from sales; -- to find for all 

 select *, lead(sale_date, 1) over(), sale_date-lead(sale_date,1) over() from sales;
 
 -- ROWS BETWEEN -- is a clause in windows func which is used to define a specific subset of rows or(a window frame)
 -- and it is used to perform calculation like running sum, moving average
 
 select *, sum(amount) over(order by amount) from sales;
 
 -- running sum of data 
 
 select *, sum(amount) over(order by amount
 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) from sales;
 
 -- average
  select *, avg(amount) over(order by amount
 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) from sales;
 
 -- avg using n PRECEDING
  select *, avg(amount) over(order by amount
 ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) from sales;
 
 -- we can create a window nearby the current row
  select *, sum(amount) over(order by amount
 ROWS BETWEEN 1 PRECEDING and 1 following) from sales;
 
select *, sum(amount) over(order by amount
 ROWS BETWEEN 1 PRECEDING and 1 following) from sales;