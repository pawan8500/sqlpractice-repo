create database windowdb;
use windowdb;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE customer_monthly_summary (
    summary_month DATE,
    customer_id INT,
    customer_name VARCHAR(100),
    total_orders INT,
    total_spent DECIMAL(12,2),
    customer_category VARCHAR(20)
);



INSERT INTO customers (customer_id, customer_name, city) VALUES
(101, 'Amit Sharma', 'Mumbai'),
(102, 'Priya Verma', 'Delhi'),
(103, 'Raj Mehta', 'Pune'),
(104, 'Sneha Iyer', 'Chennai');


INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
(1001, 101, '2026-02-05', 'Completed'),
(1002, 101, '2026-02-12', 'Completed'),
(1003, 102, '2026-02-08', 'Completed'),
(1004, 102, '2026-02-18', 'Pending'),
(1005, 103, '2026-02-10', 'Completed'),
(1006, 103, '2026-02-22', 'Completed'),
(1007, 104, '2026-02-15', 'Cancelled'),
(1008, 101, '2026-02-25', 'Completed');


INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1001, 201, 2, 5000.00),
(2, 1001, 202, 1, 7000.00),

(3, 1002, 203, 3, 4000.00),
(4, 1002, 204, 2, 3000.00),

(5, 1003, 205, 5, 2500.00),
(6, 1003, 206, 2, 3500.00),

(7, 1004, 207, 1, 10000.00),

(8, 1005, 208, 2, 2000.00),
(9, 1005, 209, 1, 1500.00),

(10, 1006, 210, 4, 1000.00),
(11, 1006, 211, 2, 1250.00),

(12, 1007, 212, 3, 5000.00),

(13, 1008, 213, 5, 6000.00),
(14, 1008, 214, 1, 8000.00);
select * from order_items;
select * from orders;

select * from orders;

with completed_orders as (
    select * 
    from orders 
    where status = 'Completed'
),

cte_join as (
    select 
        co.order_id,
        co.customer_id,
        co.order_date,
        day(co.order_date) as days,
        oi.product_id,
        oi.quantity,
        oi.unit_price,
        (oi.quantity * oi.unit_price) as total
    from completed_orders as co
    join order_items as oi
        on co.order_id = oi.order_id
)

select 
    customer_id,
    sum(total)
from cte_join
where days between 1 and 15
group by customer_id;

-- difference between count(*) and count(1) and which is faster

-- Recursive CTE : we can reuse a CTE again and again and they are mainly used to find the Hirarchial order 
with recursive cte as(
	select 10 as n
    union all
    select n+1 from cte where n<13) -- base case
select * from cte;


