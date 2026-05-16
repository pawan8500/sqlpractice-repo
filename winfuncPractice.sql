use windowdb;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    category VARCHAR(50),
    order_date DATE,
    amount DECIMAL(10,2),
    city VARCHAR(50)
);


INSERT INTO orders VALUES
(1,101,201,'Electronics','2024-01-01',500,'Delhi'),
(2,102,202,'Clothing','2024-01-02',200,'Mumbai'),
(3,103,203,'Electronics','2024-01-03',800,'Delhi'),
(4,101,204,'Furniture','2024-01-05',1200,'Delhi'),
(5,104,205,'Electronics','2024-01-07',600,'Bangalore'),
(6,105,206,'Clothing','2024-01-09',150,'Mumbai'),
(7,102,207,'Electronics','2024-01-11',900,'Mumbai'),
(8,106,208,'Furniture','2024-01-12',700,'Delhi'),
(9,107,209,'Clothing','2024-01-13',300,'Chennai'),
(10,108,210,'Electronics','2024-01-14',400,'Delhi'),
(11,103,211,'Furniture','2024-01-16',1000,'Delhi'),
(12,104,212,'Electronics','2024-01-17',750,'Bangalore'),
(13,105,213,'Clothing','2024-01-18',180,'Mumbai'),
(14,106,214,'Electronics','2024-01-20',650,'Delhi'),
(15,101,215,'Furniture','2024-01-21',1400,'Delhi'),
(16,102,216,'Electronics','2024-01-22',500,'Mumbai'),
(17,103,217,'Clothing','2024-01-23',220,'Delhi'),
(18,104,218,'Electronics','2024-01-24',950,'Bangalore'),
(19,105,219,'Furniture','2024-01-25',1100,'Mumbai'),
(20,106,220,'Clothing','2024-01-26',260,'Delhi'),
(21,107,221,'Electronics','2024-01-27',700,'Chennai'),
(22,108,222,'Furniture','2024-01-28',1300,'Delhi'),
(23,101,223,'Electronics','2024-01-29',850,'Delhi'),
(24,102,224,'Clothing','2024-01-30',210,'Mumbai'),
(25,103,225,'Electronics','2024-02-01',920,'Delhi'),
(26,104,226,'Furniture','2024-02-02',1150,'Bangalore'),
(27,105,227,'Clothing','2024-02-03',190,'Mumbai'),
(28,106,228,'Electronics','2024-02-04',620,'Delhi'),
(29,107,229,'Furniture','2024-02-05',980,'Chennai'),
(30,108,230,'Electronics','2024-02-06',540,'Delhi');

select * from orders;

select *, lag(amount, 1) over(partition by customer_id order by order_id) from orders;

-- avg order amount per category
select *, avg(amount) over(partition by category) from orders;

-- first order for each customer
select * from (select *,dense_rank() over(partition by customer_id order by order_id) as rnk from orders) as t where rnk = 1;

-- top spending customer in each city