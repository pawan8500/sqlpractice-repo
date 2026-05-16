create database regex2;
use regex2;
CREATE TABLE employee (
    eid INT PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(50),
    salary DECIMAL(10,2)
);


INSERT INTO employee (eid, name, dept, salary) VALUES
(101, 'Amit', 'HR', 40000),
(102, 'Neha', 'HR', 45000),
(103, 'Raj', 'IT', 60000),
(104, 'Priya', 'IT', 75000),
(105, 'Suresh', 'IT', 50000),
(106, 'Anita', 'Finance', 55000),
(107, 'Vikram', 'Finance', 65000),
(108, 'Kavita', 'Finance', 48000),
(109, 'Rohit', 'Marketing', 52000),
(110, 'Sneha', 'Marketing', 58000);

select * from employee;
select avg(salary) from employee;

select * from employee as e1 where salary>(select avg(salary) from employee where dept = e1.dept);
select * from employee as e1 where salary=(select max(salary) from employee where dept = e1.dept);
select * from employee as e1 where salary=(select min(salary) from employee where dept = e1.dept);
select * from employee as e1 where salary>any(select salary from employee where dept = e1.dept);
select * from employee as e1 where salary=(select max(salary) from employee where dept = e1.dept);


use world;
select * from city;
select * from country;

-- show the cities whose population is higher
-- than the avg city popu of their own country

-- find cities whose population is greater than the avg population of cities in the same country
select * from city as c
where population = (select max(population) from city where countrycode=c.countrycode);

-- find all cities and country name whose population is greater than the avg population of cities in the same country
select * from 
(select name, population, countrycode from city as c 
where population > 
				(select avg(population) from city where countrycode=c.countrycode ) 
                ) as t;

-- get the countinent name who have the total number of countries grater than the number of countries in south america


select continent,  count(name) from country group by continent 
having count(name)> (select count(name) from country where continent='South America');


