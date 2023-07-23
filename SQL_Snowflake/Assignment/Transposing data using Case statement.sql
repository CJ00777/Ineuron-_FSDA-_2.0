create database CASES;
USE Cases;

select first_name, salary,
case when salary < 100000 then 'Under Paid' 
when salary between 100000 and 150000 then 'Paid well'
when salary > 150000 then 'Executive'
else 'Unpaid'
end as category
from employees
order by salary desc;

select a.category, count(*)
from 
(select first_name, salary,
case when salary < 100000 then 'Under Paid' 
     when salary between 100000 and 150000 then 'Paid well'
     when salary > 150000 then 'Executive'
          else 'Unpaid'
end as category
from employees
order by salary desc) a
group by 1
order by 2 desc;
---------------------------------------------------------------------------------------
-- Using case statement to transpose the data

select sum(case when salary < 100000 then 1 else 0 end) as 'Under Paid',
sum(case when salary between 100000 and 150000 then 1 else 0 end) as 'Paid well',
sum(case when salary > 150000 then 1 else 0 end) as 'Executive'
from employees;

select department, count(*)
from employees
where department in ( 'Sports', 'Tools', 'Clothing', 'Computers')
group by 1
order by 2 desc;

-- Transposing the above data 

select sum(case when department = 'Sports' then 1 else 0 end) as Sports_department,
	   sum(case when department = 'Tools' then 1 else 0 end) as Tools_department,
       sum(case when department = 'Clothing' then 1 else 0 end) as Clothing_department,
       sum(case when department = 'Computers' then 1 else 0 end) as Computers_department
from employees
order by 2 desc;

select * from regions;

select first_name, 
case when region_id = 1 then (select country from regions where region_id = 1) end region_1,
case when region_id = 2 then (select country from regions where region_id = 2) end region_2,
case when region_id = 3 then (select country from regions where region_id = 3) end region_3,
case when region_id = 4 then (select country from regions where region_id = 4) end region_4,
case when region_id = 5 then (select country from regions where region_id = 5) end region_5,
case when region_id = 6 then (select country from regions where region_id = 6) end region_6,
case when region_id = 7 then (select country from regions where region_id = 7) end region_7
from employees;
 

select sum(United_States + Asia + Canada) from 
(select count(a.region_1) + count(a.region_2) + count(a.region_3) as United_States,
		count(a.region_4) + count(a.region_5)  as Asia,
		count(a.region_6) + count(a.region_7)  as Canada
from
(select first_name, 
case when region_id = 1 then (select country from regions where region_id = 1) end region_1,
case when region_id = 2 then (select country from regions where region_id = 2) end region_2,
case when region_id = 3 then (select country from regions where region_id = 3) end region_3,
case when region_id = 4 then (select country from regions where region_id = 4) end region_4,
case when region_id = 5 then (select country from regions where region_id = 5) end region_5,
case when region_id = 6 then (select country from regions where region_id = 6) end region_6,
case when region_id = 7 then (select country from regions where region_id = 7) end region_7
from employees)a
)b
--------------------------------------------------------------------------------------
drop table fruit_imports;
CREATE TABLE fruit_imports
(
	id integer,
	name varchar(20),
	season varchar(10),
	state varchar(20),
	supply integer,
	cost_per_unit decimal (3,2)
);

select * from fruit_imports;

-- Write a query that displays 3 columns. 
-- The query should display the fruit and it's total supply along with a category of 
-- either LOW, ENOUGH or FULL. 
-- Low category means that the total supply of the fruit is less than 20,000. 
-- The enough category means that the total supply is between 20,000 and 50,000. 
-- If the total supply is greater than 50,000 then that fruit falls in the full category.


select name, a.total_supply, case
					 when total_supply < 20000 then 'LOW'
                     when total_supply between 20000 and 50000 then 'ENOUGH'
                     else 'FULL'
                     end as CATEGORY
from
(select name, sum(supply) total_supply
from fruit_imports
group by 1)a
order by total_supply desc;




insert into fruit_imports values(1, 'Apple', 'All Year', 'Kansas', 32900, 0.22);
insert into fruit_imports values(2, 'Avocado', 'All Year', 'Nebraska', 27000, 0.15);
insert into fruit_imports values(3, 'Coconut', 'All Year', 'California', 15200, 0.75);
insert into fruit_imports values(4, 'Orange', 'Winter', 'California', 17000, 0.22);
insert into fruit_imports values(5, 'Pear', 'Winter', 'Iowa', 37250, 0.17);
insert into fruit_imports values(6, 'Lime', 'Spring', 'Indiana', 40400, 0.15);
insert into fruit_imports values(7, 'Mango', 'Spring', 'Texas', 13650, 0.60);
insert into fruit_imports values(8, 'Orange', 'Spring', 'Iowa', 18000, 0.26);
insert into fruit_imports values(9, 'Apricot', 'Spring', 'Indiana', 55000, 0.20);
insert into fruit_imports values(10, 'Cherry', 'Summer', 'Texas', 62150, 0.02);
insert into fruit_imports values(11, 'Cantaloupe', 'Summer', 'Texas', 8000, 0.49);
insert into fruit_imports values(12, 'Apricot', 'Summer', 'Kansas', 14500, 0.20);
insert into fruit_imports values(13, 'Mango', 'Summer', 'Texas', 17000, 0.68);
insert into fruit_imports values(14, 'Pear', 'Fall', 'Nebraska', 30500, 0.12);
insert into fruit_imports values(15, 'Grape', 'Fall', 'Illinois', 72500, 0.35);




