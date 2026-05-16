-- TCL: Transaction control Language
-- Transactions: Group of multiple SQL statements that can be executed together and to manage this we have TCL
use ctedb;
select @@autocommit; -- auto save is on
-- CTAS create table as select statement
create table ctedb.test100 as
select actor_id, first_name from sakila.actor
where actor_id between 1 and 4;

select * from test100;
update test100 set first_name = 'aman';

-- to start the transaction there are two ways/ set autocommit = 0 
-- 1
start transaction;
update test100 set first_name = 'PENELOPE' where actor_id = 1;
select * from test100; -- but these changes are isolated yet so it will ot be visible to other users or other connections

-- if i want to end the transaction and make the changes permanent for other transaction we have 4 ways:
-- commit
-- rollback : all the changes since the transaction start are undone and transaction ends
-- running a ddl statement: running a ddl statement like create table or drop will also end the transaction
-- crash: if the server crashes then all the changes are automatically undone and rollback
commit; -- now the changes will be visible to the other servers also and transaction changes are successfully done here.

-- rollback
start transaction;
update test100 set first_name = 'Rahul' where actor_id = 3;
select * from test100; -- here also currently the changes are not been saved
-- now if i write rollback here the changes are back to originalk state
rollback;
select * from test100;

-- save point
start transaction;
update test100 set first_name = 'saransh2234' where actor_id = 10;
delete from test100 where actor_id = 3;
select * from test100;
savepoint new_checkpoint;
-- now changes till here have been saved
insert into test100 values(11, 'Mihir');
select * from test100;
rollback to new_checkpoint; -- if i write rollback insed of this it will again start from the start
select * from test100;
