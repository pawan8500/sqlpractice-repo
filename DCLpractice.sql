-- DCL(Data Control Language) practice in class

-- Check existing users
SELECT * FROM mysql.user;

-- Create user
CREATE USER 'ishan'@'localhost' IDENTIFIED BY '123';

-- Check current logged-in user
SELECT CURRENT_USER();

-- Create database
CREATE DATABASE testdb4;

-- Use database
USE testdb4;

-- Create table
CREATE TABLE emp(
    id INT,
    name VARCHAR(20)
);

-- Insert records
INSERT INTO emp VALUES
(20,'abhi'),
(21,'naina');

-- Display table data
SELECT * FROM emp;

-- Show grants for user
SHOW GRANTS FOR 'ishan'@'localhost';

-- Give SELECT permission only on emp table
GRANT SELECT ON testdb4.emp TO 'ishan'@'localhost';

-- Give DELETE permission on all tables of testdb4
GRANT DELETE ON testdb4.* TO 'ishan'@'localhost';



/* =========================================================
   TASK 1:
   Create new table and revoke DELETE privilege
   ========================================================= */

-- Create new table
CREATE TABLE dept(
    dept_id INT,
    dept_name VARCHAR(30)
);

-- Revoke DELETE privilege
REVOKE DELETE ON testdb4.* FROM 'ishan'@'localhost';



/* =========================================================
   TASK 2:
   Give SELECT and INSERT privilege on particular table
   ========================================================= */

GRANT SELECT, INSERT ON testdb4.dept TO 'ishan'@'localhost';



/* =========================================================
   TASK 3:
   Create database with 3 columns and insert at least 2 rows
   ========================================================= */

CREATE DATABASE companydb;

USE companydb;

CREATE TABLE employee(
    emp_id INT,
    emp_name VARCHAR(30),
    salary INT
);

INSERT INTO employee VALUES
(1,'Rahul',50000),
(2,'Sneha',60000);



/* =========================================================
   TASK 4:
   Give access to only one column in SELECT statement
   ========================================================= */

-- Give permission only on emp_name column
GRANT SELECT(emp_name)
ON companydb.employee
TO 'ishan'@'localhost';



/* =========================================================
   TASK 5:
   Give UPDATE privilege on 2 or 3 columns
   ========================================================= */

GRANT UPDATE(emp_name, salary)
ON companydb.employee
TO 'ishan'@'localhost';



/* =========================================================
   TASK 6:
   Remove all privileges from ishan user
   ========================================================= */

REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'ishan'@'localhost';



/* =========================================================
   TASK 7:
   Create 3 users and a role/group called sales
   ========================================================= */

-- Create users
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'pass1';
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'pass2';
CREATE USER 'user3'@'localhost' IDENTIFIED BY 'pass3';

-- Create role
CREATE ROLE 'sales';

-- Give permissions to role
GRANT SELECT, INSERT, UPDATE
ON companydb.employee
TO 'sales';

-- Assign role to users
GRANT 'sales' TO 'user1'@'localhost';
GRANT 'sales' TO 'user2'@'localhost';
GRANT 'sales' TO 'user3'@'localhost';

-- Set default role
SET DEFAULT ROLE 'sales'
TO 'user1'@'localhost',
   'user2'@'localhost',
   'user3'@'localhost';



/* =========================================================
   TASK 8:
   Check permissions after login
   ========================================================= */

-- Login as user1 and check
SHOW GRANTS FOR CURRENT_USER();

-- Test permissions
SELECT * FROM companydb.employee;

UPDATE companydb.employee
SET salary = 70000
WHERE emp_id = 1;

INSERT INTO companydb.employee
VALUES (3,'Aman',45000);