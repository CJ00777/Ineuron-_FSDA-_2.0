Create database LEAD
Use LEAD

Create or replace table LEAD_DATA
(
Product_ID int,
Sale_Date date,
Daily_Sales number (10,2)
);


select * from LEAD_DATA;

    select Product_Id,Sale_date,Daily_sales as Sales,
    LEAD(Daily_Sales ,1) IGNORE NULLS OVER (PARTITION BY Product_ID ORDER BY Sale_Date) as Next_DaySale,
    LEAD(Daily_Sales,2)  IGNORE NULLS OVER (PARTITION BY Product_ID ORDER BY Sale_Date) as Second_DaySale,
    LEAD(Daily_Sales,3)  IGNORE NULLS OVER (PARTITION BY Product_ID ORDER BY Sale_Date) as Third_DaySale,
    Round((Next_DaySale-Sales)/Sales*100,2) as Sale_change_next_day,
    Round((Second_DaySale-Next_DaySale)/Next_DaySale*100,2) as Sale_change_second_day,
    Round((Third_DaySale-Second_DaySale)/Second_DaySale*100,2) as Sale_change_third_day
    
from LEAD_DATA
where sale_date < '2000-10-02'
qualify Third_DaySale is not null

-- Qualify is used to filter window function named LEAD, its kind of having clause and where clause


CREATE OR REPLACE TABLE sales(emp_id INTEGER, year INTEGER, revenue DECIMAL(10,2));

INSERT INTO sales VALUES (0, 2010, 1000), (0, 2011, 1500), (0, 2012, 500), (0, 2013, 750);
INSERT INTO sales VALUES (1, 2010, 10000), (1, 2011, 12500), (1, 2012, 15000), (1, 2013, 20000);
INSERT INTO sales VALUES (2, 2012, 500), (2, 2013, 800);

Select * from Sales

SELECT emp_id, year, revenue, LEAD(revenue) OVER (PARTITION BY emp_id ORDER BY year) as Revenue_next,
(Revenue_next- revenue) AS diff_to_next 
FROM sales 
ORDER BY emp_id, year;
------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE t1 (c1 NUMBER, c2 NUMBER);
INSERT INTO t1 VALUES (1,5),(2,4),(3,NULL),(4,2),(5,NULL),(6,NULL),(7,6);

SELECT c1, c2, LEAD(c2) IGNORE NULLS OVER (ORDER BY c1) as LEAD_C2_without_nulls
FROM t1;

-----------------------------------------------------------------------------------------------
-- LAG FUNCTION
-- LEAD(DAILY_SALES, -1) = LAG(Daily_SALES,1)
-- LAG alows to see the daily_sales for today next to yesterday's value.
-- Puts the value of previous row on current line.
-- reverse process of LEAD


select Product_Id,Sale_date,Daily_sales as Today_Sales,
    LAG(Daily_Sales ,1) IGNORE NULLS OVER (PARTITION BY Product_ID ORDER BY Sale_Date) as Previous_DaySale,
    LAG(Daily_Sales,2)  IGNORE NULLS OVER (PARTITION BY Product_ID ORDER BY Sale_Date) as Prev_to_Prev_DaySale,
    LAG(Daily_Sales,3)  IGNORE NULLS OVER (PARTITION BY Product_ID ORDER BY Sale_Date) as Before_Two_DaySale,
    Round((previous_DaySale-Today_Sales)/Today_Sales*100,2) as Sale_change_prev_day,
    Round((Prev_to_Prev_DaySale-Previous_DaySale)/Previous_DaySale *100,2) as Sale_change_prev_to_prev_day,
    Round((Before_Two_DaySale- Prev_to_Prev_DaySale)/ Prev_to_Prev_DaySale *100,2) as Sale_change_before_two_day
    
from LEAD_DATA
Qualify Before_Two_DaySale is not null

----------------------------------------------------------------------------------------------------------------------------
-- LEAD AND LAG (UDEMY)

-- Find out the Closest Lower Salary as per department wise

Select first_name, department, salary, 
LEAD (Salary) Over(Partition by department order by salary desc) as Closest_Lower_Salary
from employees;


-- Find out the Closest_Higher_Salary as per department wise

Select first_name, department, salary, 
LAG(Salary) Over(Partition by department order by salary desc) as Closest_Lower_Salary
from employees;

------------------------------------------------------------------------------------------------------------------------------------
-- First Value
-- Returns the value_expression for the first row in the current window frame

-- Last Value
-- Returns the value_expression for the last row in the current window frame


SELECT
        column1,
        column2,
        FIRST_VALUE(column2) OVER (PARTITION BY column1 ORDER BY column2 NULLS LAST) AS column2_first,
        FIRST_VALUE(column2) IGNORE NULLS OVER (PARTITION BY column1 ORDER BY column2 NULLS LAST) AS column2_first_ignore_nulls,
        LAST_VALUE(column2)  OVER (PARTITION BY column1 ORDER BY column2 NULLS LAST) AS column2_last,
        LAST_VALUE(column2) IGNORE NULLS OVER (PARTITION BY column1 ORDER BY column2 NULLS LAST) AS column2_last_ignore_nulls
    FROM VALUES
       (1, 10), (1, 11), (1, null), (1, 12),
       (2, 20), (2, 21), (2, 22)
    ORDER BY column1, column2;
    
-- nth value 
-- This specifies which value of N to use when looking for the Nth value.

SELECT
    column1,
    column2,
    nth_value(column2, 3) OVER (PARTITION BY column1 ORDER BY column2) AS column2_2nd
FROM VALUES
    (1, 10), (1, 11), (1, 12),
    (2, 20), (2, 21), (2, 22);
	
---------------------------------------------------------------------------------------------------------------------------
-- UDEMY
-- First_value : Returns the 1st value from the column we mentioned on syntax.

Select first_Name, department, salary,
first_value (Salary) over (partition by department order by salary desc) as 1st_value
from employees;
-- nth_value

Select first_Name, department, salary,
nth_value (Salary, 5) over (partition by department order by salary desc) as value_nth
from employees;
-------------------------------------------------------------------------------------
-- UDEMY
-- Ntile function
-- Splits the column into groups. For example, i want to each departemnt into 5 groups

Select first_Name, department, salary,
ntile (5) over (partition by department order by salary desc) as Salary_bracket
from employees;

-- In the above result first seven records are rank 1st because there are total 32 employees in
-- Automotive department and we are dividing the total group by 5 so 32/5 = 6.4 so its taking nearby approx value 7.

select department, count(*)
from employees
group by 1
order by 2 desc;
----------------------------------------------------------------------------------------------------------------------------    
CREATE OR REPLACE TABLE example_cumulative (p INT, o INT, i INT);

INSERT INTO example_cumulative VALUES
    (  0, 1, 10), (0, 2, 20), (0, 3, 30),
    (100, 1, 10),(100, 2, 30),(100, 2, 5),(100, 3, 11),(100, 3, 120),
    (200, 1, 10000),(200, 1, 200),(200, 1, 808080),(200, 2, 33333),(200, 3, null), (200, 3, 4),
    (300, 1, null), (300, 1, null);

SELECT
    p, o, i,
    COUNT(i) OVER (PARTITION BY p ORDER BY o ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) count_i_Rows_Pre,
    SUM(i)   OVER (PARTITION BY p ORDER BY o ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sum_i_Rows_Pre,
    AVG(i)   OVER (PARTITION BY p ORDER BY o ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) avg_i_Rows_Pre,
    MIN(i)   OVER (PARTITION BY p ORDER BY o ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) min_i_Rows_Pre,
    MAX(i)   OVER (PARTITION BY p ORDER BY o ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) max_i_Rows_Pre
  FROM example_cumulative
  ORDER BY p,o;








Insert into LEAD_DATA Values 
(1000, '2000-09-28', 48850.40),(1000, '2000-09-29', 54500.22),(1000, '2000-09-30', 36000.07),(1000, '2000-10-01',40200.43);

Insert into LEAD_DATA Values 
(2000, '2000-09-28', 41888.88),(2000, '2000-09-29', 48000.00),(2000, '2000-09-30', 49850.03),(2000,'2000-10-01',54850.29);


Insert into LEAD_DATA Values 
(3000, '2000-09-28', 61301.77),(3000, '2000-09-29', 34509.13),(3000, '2000-09-30', 43868.86),(3000,'2000-10-01',28000.00);
