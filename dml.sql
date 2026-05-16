-- create statement
use windowdb;
create table test(sno int);

-- insert statement 
insert into test values(1000);  -- only 1 row insert
insert into test values(89),(97); -- 2 row insert

describe test;
select * from test;

-- tinyint (1 byte)      2^8 => 255 (-128 to 127)
create table test2( sno tinyint);
insert into test2 values(128);  -- error
insert into test2 values(true);


create table test3(sno tinyint unsigned); -- 0 to 255
insert into test3 values (255);  -- allow me
select * from test3;

-- small int => 2 byte 2^16
-- mediunmint => 3 byte
-- big int => 8 byte  => 2^64

create table test5(sno int unsigned);  -- 0 to 255
insert into test5  values(12344567766);  -- allow
select sno, sno+10 from test5;

create table test6(amount float, amount2 double); -- 0 to 255
insert into test6 values(17.5478321, 17.5478321);
select * from test6;

# M, D => M => total digit , decimal digit
create table test7 ( amount2 double(5,2) ); -- 0 to 255
insert into test7 values(4.7985423);
insert into test7 values(5);
insert into test7 values(100.123);
insert into test7 values(1100.789); -- error as 5-2 is the total values of values befor decimal

select * from test7;

create table test8 (city char(6)) ; -- 0 to 255
insert into test8 values('isha');
insert into test8 values('aus');
insert into test8 values('raj       ');

select * , char_length(city) from test8;

create table test9 (city varchar(6)) ; -- 0 to 255
insert into test9 values('isha');
insert into test9 values('aus');
insert into test9 values('raj       ');

select * , char_length(city) from test9 ;

create table test1000(salary int not null, age int);
insert into test1000 values(100,20),(200,30),(50,null);
insert into test1000 values(null,900); -- this will give error as salary cannot be null
select * from test1000;

create table test10001(salary int not null default 1900, age int default 18);
insert into test10001 values(null,900); -- this will give error as salary cannot be null
insert into test10001(salary) values(88);
insert into test10001(age) values(60);
select * from test10001;

create table test203(a int, b int, salary int, age int,
					constraint test_test203_salary_chk_1000_lt check(salary>1000),
                    constraint test_test203_age_uq check(age>18));
insert into test203 values(1,2,2000,18); -- error constraint rule violated

create table pictures (id int, image longblob);
insert into pictures (id, image) values(1, load_file("C:\Users\LENOVO\Downloads\Gemini_Generated_Image_95rigd95rigd95ri.png"));
select * from pictures;

-- foregiin key: used to set up relationship between table
use testdb;

create table cust(id int primary key, name varchar(20));
insert into cust values (1,'Tiger'),(2,'Yash');
select * from cust;

create table ord1(id int, cid int, price int,
foreign key (cid) references cust(id));
insert into ord1 values(100,1,1999);
insert into ord1 values(100,2,2999);
insert into ord1 values(100,6,1999); -- error because id 6 does not exists in the parent table

-- for deleting anything from the table where foregin key is established we have to first delete data from the child table and then only we can delete the data from the parent table
-- or we can use delete cascade it the time of setting up of the foregin key constraint

drop table cust;
drop table ord1;

create table cust(id int primary key, name varchar(20));
insert into cust values (1,'Tiger'),(2,'Yash');

create table ord1(id int, cid int, price int,
foreign key (cid) references cust(id) on delete cascade);
insert into ord1 values(100,1,1999);
insert into ord1 values(100,2,2999);
insert into ord1 values(201,3,6700);

-- now if i delete a data from the parent table oon which the foregin key is set up it will automatically delete it from the child table
delete from cust where id = 2; -- delete successful
select * from cust;
select * from ord1; -- data also deleted from the child table

-- if we want to preserve the data of ord1 table/ child table if the data of the parent table is deleted we can use on delete set null this will delete the data from the parent table but set that perticular data in the child table as null
insert into cust values(3,'Tanish');
drop table ord1;

create table ord1(id int, cid int, price int,
foreign key (cid) references cust(id) on delete set null);
insert into ord1 values(100,1,1999);
insert into ord1 values(100,2,2999);
insert into ord1 values(201,3,6700);

delete from cust where id = 3;
select * from cust;
select * from ord1;

-- you have to delete the second row which have same name
drop table ord1;
drop table cust;
create table cust(id int primary key, name varchar(20));
insert into cust values (1,'Tiger'),(2,'Yash'),(3,'Tiger');

-- tcl and hacker rank upto 4 what are the role of commit and rollback 
-- and and normalization
delete from cust where id in
(select id from
(select *,row_number() over(partition by name order by id) as rn from cust) as temp
where rn>1);
select * from cust;
