create database DECODE;
use DECODE;

create table CJ_IPL
(Id int,
name varchar(10),
salary float (10,2),
age int (10)
);

insert into CJ_IPL values ( 1, 'Mahi', 12, 40),
						  (2, 'Kohli', 14, 33),
                          (3, 'DK', 6.25, 33),
                          (4, 'Warner', 6.75, 33),
                          (5, 'Rahul', 16, 29),
                          (6, 'Pandya', 14, 27);
select * from  CJ_IPL;

-- DECODE is not woeking in MYSQL, working in SNOWFLAKE.
-----------------------------------------------------------------------------------
-- UPSERT FUNCTION

CREATE TABLE CJ_Student ( 
Stud_ID int AUTO_INCREMENT PRIMARY KEY, 
Name varchar(45) DEFAULT NULL, 
Email varchar(45) NOT NULL UNIQUE, 
City varchar(25) DEFAULT NULL 
);

INSERT INTO CJ_Student(Stud_ID, Name, Email, City) 
VALUES (1,'Stephen', 'stephen@javatpoint.com', 'Texas'), 
(2, 'Joseph', 'Joseph@javatpoint.com', 'Alaska'), 
(3, 'Peter', 'Peter@javatpoint.com', 'California');

Select * from CJ_student;

-- Records will not get added as one of the record is duplicate thus its showing error.
INSERT INTO CJ_Student(Stud_ID, Name, Email, City) 
VALUES (4,'Donald', 'donald@javatpoint.com', 'New York'), 
(5, 'Joseph', 'Joseph@javatpoint.com', 'Chicago'); 

-- Insert ignore function: Helps to add the unique record and throws the warning for duplicate 
-- records rather than showing error.

INSERT IGNORE INTO CJ_Student(Stud_ID, Name, Email, City) 
VALUES (4,'Donald', 'donald@javatpoint.com', 'New York'), 
(5, 'Joseph', 'Joseph@javatpoint.com', 'Chicago'); 
-----------------------------------------------------------------------------------
-- Traditional method of updating records
Update CJ_student 
set city = 'New York' where stud_id = 4;
-- New Mthod  
Replace INTO CJ_Student(Stud_ID, Name, Email, City) 
VALUES (2, 'Joseph', 'Joseph@javatpoint.com', 'Canada');
-------------------------------------------------------------------------------------
-- UPSERT using INSERT ON DUPLICATE KEY UPDATE

INSERT INTO CJ_Student(Stud_ID, Name, Email, City) 
VALUES (5,'John', 'john@javatpoint.com', 'New York');-- This record will get added

INSERT INTO CJ_Student(Stud_ID, Name, Email, City) 
VALUES (5, 'John', 'john@javatpoint.com', 'New York') 
ON DUPLICATE KEY UPDATE City = 'California'; -- This will update the city as California;

---------------------------------------------------------------------------------------





