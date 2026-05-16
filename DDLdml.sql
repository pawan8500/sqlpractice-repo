use windowdb;

show tables;  -- to see all table in database

-- create statement
create table test( id int);

-- insert statement (DML)
insert into test values(1000);  -- only 1 row insert
insert into test values(89),(97); -- 2 row insert

describe test;  -- will tell the structure/ column name and datatypes
select * from test; -- access all the column of test table

-- tinyint (1 byte)  2^8 => 256 ( -128 to 127)
create table test2( sno tinyint );
insert into test2  values(128); -- error
insert into test2 values(True);

create table test3(sno tinyint unsigned);  -- 0 to 255 unsingned removes the negative values and give the new range of positive numbers
insert into test3 values(255); -- allow me
select * from test3;

-- we can't go for the negative values in the sql 
-- NOTE =>  in sql calculation is performed in the BIGINT

create table test5(sno tinyint unsigned);  -- 0 to 255
insert into test5 values(4294967295);    -- allowed values are double using insigned / if we want only positive values we use unsigned
select sno, sno+10 from test5;        -- NOTE =>  in sql calculation is performed in the BIGINT

create table test6(amount float, amount2 double);  -- 0 to 255
insert into test6 values(17.54678321, 17.54678321);
select * from test6;


# M, D =>  M=> total digit , D => decimal digit
create table test7( amount2 double(5,2) );
insert into test7 values(4,7985423);
insert into test7 values(5);
insert into test7 values(100.745);
insert into test7 values(1100.745); -- error as 5-2 is the total values of value before decimal

-- char trim the white spaces 
-- char fixed the length and it waste the memory ( it is the fixed length data type )
create table test8( city char(6) );
insert into test7 values('isha');
insert into test7 values('aus');
insert into test7 values('raj         ');     -- char trim the white spaces 

-- to check and count lenght of the string/ or how many charecter are there 
select *, char_length(city) from test8;

-- varchar is the variable  lenght datatype
create table test9( city varchar(6) );
insert into test7 values('isha');
insert into test7 values('aus');
insert into test7 values('raj         '); -- varchar truncate the values upto the length of the column