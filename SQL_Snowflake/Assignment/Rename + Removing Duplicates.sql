-- Command to rename table name
Alter table CJ_departments rename to CJ7_departments

-- Command to rename column name
Alter table CJ7_departments
rename column Department to Departments
------------------------------------------------------------------------------------------------------------------------------------
-- Removing Duplicates

-- using the distinct keyword
-- Distinct is used to fetch the unique records/rows present in table.
-- For duplicate whole row have to be same, not only the single value.
-- duplicate means records not columns. 

select distinct * from  CJ7_departments --24 no duplicates
select distinct count(*) from CJ7_departments --24

select * from CJ7_departments -- 24
---------------------------------------------------------------------------------------------------------------------------------------
create or replace table CJ_Data_Flair
(emp_id char (10),
name varchar (20),
location varchar (20),
experience int
);

insert into CJ_Data_Flair values ('A01','Arti','Indore', 5),
                                 ('A21','Ridhima','Pune',3),
                                 ('AF21','Rama','Pune', null),
                                 ('D03',null,'Pune', 4),
                                 ('D78','Vikas','Pune',4),
                                 ('J08','Naman','Delhi',7),
                                 ('O12','Nia',null, 9),
                                 ('P89','Siya','Indore',1),
                                 ('Q89','Siya','Indore',1),
                                 ('S23','Shyam','Pune',2),
                                 ('V03','Shiv','Pune',12),
                                 ('X02','Aman','Delhi',10),
                                 ('Z23','Aish','Indore',7),
                                  ('Z87','Rabina','Pune',3),
                                  ('B35','Raj','Indore',7),
                                  ('A01','Niya','Pune', 2),
                                  ('V03','Dev','Delhi',3);

select * from  CJ_Data_Flair -- 17 records
select distinct emp_id from   CJ_Data_Flair -- 15 records

select distinct count(distinct emp_id) from   CJ_Data_Flair -- 15 records
select distinct emp_id,name, location from   CJ_Data_Flair -- 17 records only will return as the whole records is not getting matched with others.


Delete from  CJ_Data_Flair
where name = 'Arti'

insert into CJ_Data_Flair values ('A01','Arti','Indore', 5);

----------------------------------------------------------------------------------------------------------------------------------------
select * from Cj_IPL

insert into CJ_IPL values ( 1, 'Mahi', 12, 49),
						  (2, 'Kohli', 14, 43),
                          (3, 'DK', 6.25, 33),
                          (4, 'Warner', 6.75, 35),
                          (5, 'Rahul', 16, 39),
                          (6, 'Pandya', 14, 27),
                          ( 1, 'Mahi', 12, 40),
						  (2, 'Kohli', 14, 33),
                          (3, 'DK', 6.25, 33),
                          (4, 'Warner', 6.75, 33),
                          (5, 'Rahul', 16, 29),
                          (6, 'Pandya', 14, 27);
                          
delete from CJ_IPL where name ='Mahi' and age <> 40
delete from CJ_IPL where name ='Kohli' and age <> 33;
delete from CJ_IPL where name ='Warner' and age <> 33;
delete from CJ_IPL where name ='Rahul' and age <> 29;

-- in the CJ_IPL table duplicates are also present so how to find how many duplicate entry are done
 
 -- firstly, check the duplicates by this command
select name, count(*)
from CJ_IPL
group by name
having count(*) > 1
 
select * from Cj_IPL -- 15 records (duplicates are present)
select distinct * from Cj_IPL -- 7 records


-- scondly create the another table using distinct command
create or replace table CJ7_ipl as
select distinct * from Cj_IPL

-- Thirdly, after creation of new table check the records by select * command

select * from CJ7_IPL -- 7 records
---------------------------------------------------------------------------------------------------------------------------------

Create database Duplicates;
use duplicates;

Create or replace table Agents
(
id int,
first_name char (10),
last_name char (10),
experience_years int
);

insert into Agents (id,first_name,last_name,experience_years) values (1, 'Kate', 'White',5);
insert into Agents (id,first_name,last_name,experience_years) values (2, 'Melissa', 'Brown',2),
                                                                     (3, 'Alexandar', 'McGregor',3),
                                                                     (4,'Sophia','Scott',3),
                                                                     (5,'Steven','Black',1),
                                                                     (6,'Maria','Scott',1);
select * from Agents -- 6 rows

Create or replace table Customers
(
id int,
first_name char (10),
last_name char (10),
email varchar (40) unique
);

insert into customers values (11,'Xaviera','Lopez','xaviera@111111gmail.com');
insert into customers values (12, 'Gabriel', 'Cumberly','gabriel111111@gmail.com'),
                             (13, 'Elisabeth', 'Stevens','elisabeth111111@gmail.com'),
                             (14, 'Oprah','Winfrey','oprah111111@gmail.com'),
                             (15, 'Ivan','Lee','ivan111111@gmail.com');
                             
select * from customers; -- 5 records

delete from customers where id =11;
                                                          
Create or replace table Sales
(
id int,
house_id int,
date date,
agent_fist_name varchar (15),
agent_last_name varchar (15),
customer_id int,
price number (10)
);

insert into sales values (101,1012,'2021-11-03','Kate','White',14,1200000);
insert into sales values (102,2134,'2021-12-06','Sophia','Scott',12,950000),
                         (103,1015,'2021-12-10','Mana','Scott',13,800000),
                         (104,2013,'2021-12-12','Alexandar','McGregor',15,1350000),
                         (105,2112,'2021-12-12','Alexandar','McGregor',15,1450000),
                         (106,1010,'2022-1-10','Steven','Black',11,1500000);

select * from sales; --6 rows

SELECT
    concat (a1.first_name,' ',a1.last_name) as agent1_full_name,
    a1.experience_years as agent1_experience,
    concat(a2.first_name,' ',a2.last_name) as agent2_full_name,
    a2.experience_years as agent2_experience
FROM agents a1
INNER JOIN agents a2
ON a1.id < a2.id
-- where a1.experience_years >=3 and a2.experience_years <=1
ORDER BY a1.id;

-----------------------------------------------------------------------------------------------------------















create table CJ_departments
(
 department varchar(100) primary key,
 division varchar(100)
);

insert into CJ_departments values ('Clothing','Home');
insert into CJ_departments values ('Grocery','Home');
insert into CJ_departments values ('Decor','Home');
insert into CJ_departments values ('Furniture','Home');
insert into CJ_departments values ('Computers','Electronics');
insert into CJ_departments values ('Device Repair','Electronics');
insert into CJ_departments values ('Phones & Tablets','Electronics');
insert into CJ_departments values ('Garden','Outdoors');
insert into CJ_departments values ('Camping & Fishing','Outdoors');
insert into CJ_departments values ('Sports','Outdoors');
insert into CJ_departments values ('Children Clothing','Kids');
insert into CJ_departments values ('Toys','Kids');
insert into CJ_departments values ('Vitamins','Health');
insert into CJ_departments values ('Pharmacy','Health');
insert into CJ_departments values ('First Aid','Health');
insert into CJ_departments values ('Automotive','Hardware');
insert into CJ_departments values ('Tools','Hardware');
insert into CJ_departments values ('Jewelry','Fashion');
insert into CJ_departments values ('Beauty','Fashion');
insert into CJ_departments values ('Cosmetics','Fashion');
insert into CJ_departments values ('Books','Entertainment');
insert into CJ_departments values ('Games','Entertainment');
insert into CJ_departments values ('Music','Entertainment');
insert into CJ_departments values ('Movies','Entertainment');

select * from CJ7_departments

