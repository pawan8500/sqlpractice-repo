CREATE DATABASE company_db;
USE company_db;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    join_date DATE,
    city VARCHAR(50)
);
INSERT INTO employees (emp_id, emp_name, department, salary, join_date, city) VALUES
(101, 'Alice', 'HR', 50000, '2021-01-15', 'New York'),
(102, 'Bob', 'IT', 70000, '2020-03-10', 'London'),
(103, 'Charlie', 'IT', 65000, '2019-07-23', 'London'),
(104, 'Diana', 'HR', 52000, '2021-06-01', 'New York'),
(105, 'Edward', 'Finance', 80000, '2018-11-12', 'Sydney'),
(106, 'Fiona', 'Finance', 75000, '2020-02-20', 'Sydney'),
(107, 'George', 'IT', 72000, '2022-04-18', 'New York');

select * from employees;









-- 1 
select department, max(salary) from employees group by department;

-- 2 
select department, count(emp_id) from employees group by department;

-- 3 
select upper(LEFT(emp_name,3)) from employees;

-- 4
select emp_name from employees where length(emp_name) > 6;

-- 5
SELECT *
FROM Employees
WHERE join_date > '2020-11-30';

-- 6
SELECT emp_name,
       2025 - YEAR(join_date)
FROM employees;

-- 7
 SELECT emp_name,
       ROUND(salary, -3)
FROM Employees;

-- 8 
SELECT city, COUNT(*)
FROM employees
GROUP BY city
HAVING COUNT(*) > 2;

-- 9
SELECT city, AVG(salary)
FROM employees
GROUP BY city
HAVING AVG(salary) BETWEEN 60000 AND 75000;

-- 10
SELECT department, city, AVG(salary) AS avg_salary
FROM employees
GROUP BY department, city
ORDER BY avg_salary DESC
LIMIT 1;

-- 11
SELECT department
FROM employees
GROUP BY department
HAVING COUNT(DISTINCT city) > 1;