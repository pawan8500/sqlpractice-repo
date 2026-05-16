-- subquery -> query within a query/nested query
-- it have two parts first is outer query and the second is inner query 
-- outer query result depends on inner query 
-- always in parantheses () 
-- inner query is exequted first / inner sabse phale chalegi
-- Outer Query (Inner Query)
-- we use subquery when we dont know the condition value
-- there are four type of sub query
-- single row subquery -> single row and single column - we can use any type of operator in it

-- multi row subquery -> multi row - we can't use direct comparison operator in multi row subquery
-- we use (in) for multi row subquery we can also use (=any) operater both works same check for multipe amount
-- we can use comparison operator with the help of any(any mean kisi m se bhi) like <any, >any, =any 
-- (all means sab m se)(=all) don't work in multiple row subquery  >all, <all works


-- multiple row subquery -> 

-- correlated subquery

use world; 

select * from city;

-- give those city whose country code equal to Afganisthan
select name, countrycode
from city where countrycode = 'AFG';

select name, countrycode
from city where countrycode = 'AFG';

-- those city whose country code equal to silang city
select name, countrycode
from city where name = 'oran';

-- city whose population greater than oran
select name, population from city where population > 'oran';
-- subquery

-- get the city info whose distict is same as of tafuna city
select district from city where name = 'Tafuna';
select name, countrycode, district, population from city where district = 'Tutuila';

-- get the distict and its population for all the city where country code is same as of city namibe
select countrycode from city where name = 'Namibe';
select name, countrycode, district, population from city where countrycode = 'AGO';

-- get the city name, district where the district is same as of americana city
select name, district from city where district=(select district from city where name = 'Americana');

-- get the all city info where the population of city is less than the population of Barurei
select name, population from city where population<(select population from city where name= 'Barueri');

-- get the countrycode, name where the countinent is same as of Albania 
select name, code from country where continent=(select continent from country where name='Albania');

-- get those country info where independece year of the counrty is after afganisthan
select name, indepyear from country where indepyear>(select indepyear from country where name='Afghanistan');

-- get the name, continent, region and the population for all the counrtries 
-- where the region is same as of belgiun and have the independence year after 1800
select code, name, continent, region, population, indepyear from country
where indepyear>1800 and region=(select region from country where name='Belgium');

select * from country;

use sakila;

select * from payment;


select * from payment where payment_id=(select max(payment_id) from payment);

-- get all payment info for the higehest rental_id
select * from payment where rental_id=(select max(rental_id) from payment);

-- get all payment info for the earleast payment date ( min and max works on date when we want to find early or sabse new date)
select * from payment where payment_date=(select min(payment_date) from payment);

-- find the all the info where the amount is same as of amount of payment id 5
select * from payment where amount=(select amount from payment where payment_id=5);

-- find the date where the amount is gereater the average amount of payment table 
select * from payment where amount>(select avg(amount) from payment);

-- get the all the payment info where the amount is gerater than the max amount of customer id 1
select * from payment where amount>(select max(amount) from payment where customer_id = 1);

-- find payment_id, staff_id and amount only for the payment where the month is equal the month of payment id 4
select payment_id, staff_id, amount, payment_date from payment 
where month(payment_date)=(select month(payment_date) from payment where payment_id=4);

-- get the highest payment id from the table where amount is same as of payment id 11 and customer 1
select max(payment_id) from payment 
where amount=(select amount from payment where customer_id=1 and payment_id= 11);

-- multi row subquery using # in
select * from payment
where amount in(select amount from payment where payment_id=3 or payment_id=6);

-- get all payment info where the customer_id is same as the customer id of payment id 3 or 250
select * from payment
where customer_id in(select customer_id from payment where payment_id=3 or payment_id=250);

select * from payment
where customer_id =any(select customer_id from payment where payment_id=3 or payment_id=250);

select * from payment
where customer_id <any(select customer_id from payment where payment_id=3 or payment_id=250);

select * from payment
where customer_id >any(select customer_id from payment where payment_id=3 or payment_id=250);

select * from payment
where amount <any(select customer_id from payment where payment_id=3 or payment_id=6);

select * from payment
where amount >any(select customer_id from payment where payment_id=3 or payment_id=6);

-- get all payment info where the amount is greater than any amount of payment id 1 and payment id 3
select * from payment where amount >any(select amount from payment where payment_id=1 or payment_id=3);

-- get all payment info where the amount is greater amoung all the payments of customer_id 1
select * from payment where amount >all(select amount from payment where customer_id=1);


-- Correlated subquery is a type of subquery which is executed again and again for the each row of Outer query
-- lets say we have to find employee salary of employee whose salary is greater than avg salary of that particular department, we dont know the which department of employee?

-- select eid, name, from table as t1 where salary>(select avg(salary) from table where dept = t1.dept);

