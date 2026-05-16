create database ctedb;
use ctedb;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT
);

INSERT INTO employees (emp_id, emp_name, manager_id) VALUES
(1, 'CEO', NULL),
(2, 'Manager A', 1),
(3, 'Manager B', 1),
(4, 'Team Lead A1', 2),
(5, 'Team Lead A2', 2),
(6, 'Developer A1', 4),
(7, 'Developer A2', 4),
(8, 'Developer B1', 3);

with recursive cte as(
select emp_id, emp_name, manager_id, emp_name as hierachy from employees where manager_id is null

union all

select e.emp_id, e.emp_name, e.manager_id, concat(c.hierachy, '->', e.emp_name)
from employees as e
join cte as c
where e.manager_id = c.emp_id)

select * from cte; 

select emp_id, emp_name, manager_id, emp_name as hierachy from employees where manager_id is null;
select * from employees;