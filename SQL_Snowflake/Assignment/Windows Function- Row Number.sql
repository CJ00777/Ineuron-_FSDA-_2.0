Create database CJ_Window_Functions;
USE CJ_Window_Functions;

drop table CJ_EMPLOYEE_RAW;
Create table if not exists CJ_EMPLOYEE_RAW
(Employee_ID int,
Name char (20),
Salary number (10)
);

INSERT INTO CJ_EMPLOYEE_RAW (EMPLOYEE_ID,NAME,SALARY) VALUES (100,'JENIFER',4400),
															 (100,'JENIFER',4400),
                                                             (101,'Michael',13000),
                                                             (101,'Michael',13000),
                                                             (102,'Pat',6000),
															 (102,'Pat',6000),
															(103,'Den',11000);
SELECT * FROM CJ_EMPLOYEE_RAW;

-- In case of ROW_NUMBER, Order by clause is mandatory in Snowflake.
select *,ROW_NUMBER() OVER() as R_Number FROM CJ_EMPLOYEE_RAW; -- Not Working
select *,ROW_NUMBER() OVER( Order by Salary desc) as R_Number FROM CJ_EMPLOYEE_RAW -- Now it will work.

-- HOW TO DELETE DUPLIACTES ?

DELETE FROM 
(
 SELECT *,ROW_NUMBER() OVER(ORDER BY Salary DESC) AS R_Number 
 FROM CJ_EMPLOYEE_RAW 
)
 AS INNER_QUERY
WHERE INNER_QUERY.R_Number IN (2,5,7)
-------------------------------------------------------------------------------------------------------------------------------------
use bikestores;
SELECT *, ROW_NUMBER () OVER(PARTITION BY product_id, item_id ORDER BY list_price desc) as TOP
from sales.order;


select * from sales.orders;