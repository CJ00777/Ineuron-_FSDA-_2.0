use database practice

-- this command will help to create the structure of the existing table only but the data of table wont get copied.
create or replace table RJ_Consumer_Complaints_2 like RJ_Consumer_Complaints
----------------------------------------------------------------------------------------------------------------------------------
select * from RJ_Consumer_Complaints_2 

--if you want to create the table along with data and if you want some specific coloumns just mention the coloumn name on the select statement
create or replace table RJ_Consumer_Complaints_2 as
select * from RJ_Consumer_Complaints; 
---------------------------------------------------------------------------------------------------------------------------------------
--default function

create or replace table CJ_sales
(
 customer_id varchar(1) primary key,
  order_date date default to_date ('2022-05-01'),
  product_id int not null
);

describe table CJ_sales -- this table is empty no data on it
select * from CJ_sales

alter table CJ_sales 
add column pan_card varchar(10)

alter table CJ_sales
drop primary key  -- function for dropping primary key
---------------------------------------------------------------------------------------------------------------
-- command for entering primary key when table is empty 
alter table CJ_sales 
add column voter_card varchar(10) primary key

alter table CJ_sales
add column Destination varchar (20) default 'Kolkata'

alter table CJ_sales
add column Amount number (10) not null

alter table CJ_sales 
add column aadhar_card varchar(10) not null

-- existing table having data 
alter table RJ_Consumer_Complaints
add column ration varchar (20) default 'yes'
---------------------------------------------------------------------------------------------------------------
-- adding primary key to an existing coloumn present in table with data on it
alter table RJ_consumer_complaints 
add primary key (date_received)

-----------------------------------------------------------------------------------------------------------------
-- droping a primary key on existing table having data on it and adding a new column with primary key on it
alter table car_sales2
drop primary key -- dropped
 
alter table car_sales2
add column age number (2) -- column added first 

alter table car_sales2
add primary key (age) -- secondly constraint added
 
describe table car_sales2

select * from car_sales2

---------------------------------------------------------------------------------------------------------------

describe table RJ_consumer_complaints

alter table RJ_consumer_complaints
drop primary key

alter table RJ_consumer_complaints
add primary key (Complaint_Id)

select *from RJ_consumer_complaints


------------------------------------------------------------------------------------------------------------------
--Get DDL function to retrieve a DDL statement that could be executed to recreate the specified table
-- this statement includes the constraints currently set on a table
select get_ddl ('table', 'RJ_Consumer_complaints')
---------------------------------------------------------------------------------------------------------------------

-- Update function helps to update the data 
--For example, i want to update the color as yellow in car_sales2 table

update Car_sales2
set is_dealer = 'XXXX_XX_XX' where is_dealer is null
-----------------------------------------------------------------------------------------------------------------------
-- Alter command is used to modify the structure of table whereas Update command is used to modify the content(row) of the table
---------------------------------------------------------------------------------------------------------------------
 