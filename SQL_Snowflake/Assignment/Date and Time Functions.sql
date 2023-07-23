use database practice

select current_date
select current_timestamp
select current_time

 select convert_timezone ('GMT',Current_timestamp)as GMT_timezone -- use the timezone which you want to convert i.e GMT, UTC
 select convert_timezone ('America/Los_Angeles', Current_timestamp)as America_Los_Angeles_timezone
 
 -- Date Trunc is only used when you have one year data
 
Select date_trunc ('Year', Current_date) as year_from_date -- this function will show Year but in (YYYY-MM-DD) format
Select date_trunc ('Month', Current_date) as month_from_date
Select date_trunc ('Day', Current_date) as day_from_date
 
select date_trunc ( 'Year',to_date ('2021-05-19')) as year_from_date -- to_date function helps to convert string format into date format
select date_trunc ( 'Week',to_date ('2021-05-19')) as weekdate_from_date -- Week starts from Monday so 19th is Wednesday i.e it will take 
-- Monday of that week which is 17th May 2021
 
select date_trunc ( 'Week',to_date ('2022-11-27')) as weekdate_from_date
 
select
 day (current_timestamp),
 month (current_timestamp) ,
 Year(current_timestamp), 
 hour(current_timestamp), 
 minute(current_timestamp),
 second(current_timestamp);

select week (current_date) as week_from_start_of_the_year -- this function will only show the week number from start of the year
select month (current_date) as month_from_start_of_the_year
select day (current_date) as day_from_start_of_the_year
 
 select day(to_date('2023-04-12')- Interval '12 days') as days_12days_back_from_given_date; -- will show the 12 days back result
 select month (to_date('2023-04-12')- Interval '8 weeks') as month_8weeks_before_from_given_date
 
 --Interval works on days, month and week
 
select last_day(current_date) as last_day_curr_month;
select last_day (to_date('1998-01-21')) 
 
SELECT LAST_DAY(CURRENT_DATE - INTERVAl '1 MONTH') AS LAST_DAY_PREV_MNTH; -- ths function will show the last day of previous month

SELECT LAST_DAY(CURRENT_DATE - INTERVAL '2 MONTH') + INTERVAL '1 DAY' AS FIRST_DAY;

select quarter (current_date) as qtr
select quarter (date('2022-05-12')) as qtr_given_date

select  extract (year from current_date) as year
select  extract (week from current_date) as week

select to_date (('23-05-2022'), 'DD-MM-YYYY') -- Snowflake by default will set the data in 'YYYY-MM-DD' format.

select to_varchar(to_date('2022-05-18'),'DD-MM-YYYY')-- highly used function if client wants the data in his format
select to_varchar(to_date('2022-05-18'),'MM-YYYY') -- 2nd client requirement
select to_varchar (to_date('2022-05-18'),'Mon-YYYY')--3rd client requirement
select to_varchar (to_date('2022-05-18'),'Mon-YY')-- 4th cleint requirement
select to_varchar (to_date('2022-05-18'),'DY')-- 5th client requirement
select to_varchar (to_date('2022-05-18'),'DY-DD-MM-YYYY')-- 6th client requirement

select dayname ('1998-01-31')
select to_varchar (to_date('1998-01-31'), 'DY') as Day -- same result as dayname function

select datediff ('Month', '2022-05-21','2025-05-21') -- the date format for both the dates should be same (YYYY-MM-DD as well as YYYY-MM-DD)

select datediff ('Year', '2022-05-21','2025-05-21')

select datediff ('Day', '2022-05-21','2025-05-21')