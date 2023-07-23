select first_name, salary
from employees 
where salary > (select round(avg(salary)) from employees);

-- Above query is not correlated subquery.
-- How to make a correlated subquery?
-- Correlated subquery means subquery portion should be related with the outer query.
-- It means the the subquery part should use the value from outer query

-- Find out those employees who makes salary more than their average departmental salary.

-- select department,round(avg(salary)) as avg_salary
-- from employees
-- group by 1;

select count(*) from 
(select first_name,department,salary
from employees e1 where salary > (select round(avg(salary))
								 from employees e2
								 where e1.department = e2.department)) a
                                 ;
                                 
drop table avg_dept_salary;

-- 1st part

create temporary table avg_dept_salary as
select department,round(avg(salary)) as avg_salary
from employees
group by 1
order by 2 desc;

-- 2nd part
select e.first_name, e.department, e.salary, a.avg_salary 
from employees e
join avg_dept_salary a
on e.department = a.department
where e.salary > a.avg_salary;

-- using CTE
with avg_dept_salary as (
select department,round(avg(salary)) as avg_salary
from employees
group by 1
)
select e.first_name, e.department, e.salary, a.avg_salary 
from employees e
join avg_dept_salary a
on e.department = a.department
where e.salary > a.avg_salary;

select * from avg_dept_salary;
--------------------------------------------------------------------------------------
-- Find out those employees who makes salary more than their average regional salary.

select Region_id,First_name,Salary
from employees e1
where salary > (select round(avg(salary))
					   from employees e2
                       where e1.region_id = e2.region_id);

-- using temporary table
drop table average_regional_salary;

create temporary table average_regional_salary as 
select e.region_id, round(avg(salary)) as regional_avg_salary
from employees e join regions r on e.region_id = r.region_id
group by 1
order by 2 desc;

select * from average_regional_salary;
select * from regions;

select e.first_name, e.salary, a.regional_avg_salary, e.region_id
from employees e join average_regional_salary as a
on e.region_id = a.region_id
where e.salary > a.regional_avg_salary;

--------------------------------------------------------------------------------------
-- Write a query that returns the names of department that have more than 38 employees working

select department, count(employee_id) as total_employees_working
from employees
group by 1 
having total_employees_working >= 38
order by 1 ;



select * from employees
 