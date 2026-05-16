use world;

select * from country;

-- sum of population based on two rows continent and region
select continent, region, sum(population) from country group by continent, region;

-- count 
select continent, count(name) from country group by continent;

-- count countries got there indeendence
select IndepYear, count(name) from country group by IndepYear;

-- find out how many countries got independence for each year in each continent
select continent, IndepYear, count(name) from country group by continent, IndepYear;

-- where caluse only filters that row/columns are physicaly exists on our table
-- where caluse generally not used on  aggregate gunctions

-- having caluse is used to filter the rows based on aggregate functions
-- having caluse can't be used without group by function
-- having is always applied after group by

-- continent in which country count 30
select continent, count(name) as totalCountry 
from country
group by continent
having totalCountry>30;

-- find the continent name and the avg pupulation where the avg population greater than 0.5 million
select continent, avg(population) as avgPopu from country group by continent having avgPopu>500000;

-- get the avg population, total no. of countries for each govt form only for countries got independent after 1890 and have atleast for countries
select governmentform, avg(population) as avgPopulation, count(name) as totalCountries 
from country
where IndepYear>1890
group by governmentform
having totalCountries>=4;

