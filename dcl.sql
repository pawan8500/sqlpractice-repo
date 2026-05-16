-- DCL stands for data control language it is used to give the control or permission on the database.
use ctedb;
create table test101 as 
select actor_id, first_name from sakila.actor
where actor_id between 1 and 4;
drop table test101;
select * from test101;
select current_user();

-- query to see the permissions
-- to create user
create user tanish1 identified by 'tanishp'; -- tanishp is the password for the user
show grants for tanish1;
-- grant privilege_type on database.table_name to user
grant select on ctedb.test101 to tanish1;
grant update, delete on ctedb.test101 to tanish1;
show grants for tanish1;

revoke delete on ctedb.test101 from tanish1;
show grants for tanish1;

create user tanish2 identified by 'tanishpa';

-- create a role in mysql
-- create 2 user name as naman and aadarsh
-- check the permissions for naman and aadarsh
-- assign the role to the user aadarsh
-- check the grants for aadarsh
-- assign a select privilage to the role
-- login to aadarsh user and verify the privilages
-- go to ain  user and assign the select privilage to naman
-- login to naman user and verify the privilage

create role salerole;
grant delete on ctedb.test101 to salerole;
grant salerole to tanish1;

show grants for tanish1;
show grants for salerole;