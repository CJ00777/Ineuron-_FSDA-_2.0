-- self join

use joins;
create table student
(student_id int,
name varchar (20),
course_id int,
duration int
);

insert into student (student_id, name, course_id, duration) values 
(1, 'Adam', 1,3), (2, 'Peter', 2, 4), (1, 'Adam', 2,4), (3, 'Brian', 3, 2), (2, 'Shane', 3,5);

select * from student;

-- List of all the student_id and name  when the student_id of both tables is equals, 
-- and course_id are not equal

SELECT distinct s1.student_id, s1.name 
FROM student AS s1, student s2 
WHERE s1.student_id=s2.student_id 
AND s1.course_id<>s2.course_id;
---------------------------------------------------------------------------------------
create table persons1 
(PersonID int, 
Name char (10),
Contact int,
 Address varchar (20),
 City varchar (20)
 );
 alter table persons1
 drop column address;
 
 select * from persons1;
 insert into persons1 values (1, 'Anand', 899034579, 'Chennai'),                      
						   (8, 'Chetan', '908765432', 'Chandannagar'),
                           (4, 'Ram', '99876543','Chandannagar'),
						   (20, 'Satish', 90887456, 'Mumbai'),
						   (18, 'Ankita', 0998765432, 'Pune'),
                           (7, 'Abhishek', 987645780, 'Bangalore'),
                           (10, 'Shekhar', 67543200,'Mumbai'),
						   (123, 'Goeal', 765432890,'Chennai'),
						   (134, 'Dixit', 897654311, 'Hyderabad'),
					       (27, 'Bandekar', 908764532 ,'Nagpur');

-- persons that are from the same city in the table 
SELECT distinct A.Name AS Name, A.City FROM Persons1 A, Persons1
B WHERE A.PersonID <> B.PersonID AND A.City = B.City ORDER BY A.City;

------------------------------------------------------------------------------------
create table persons
(Person_Id int primary key,
Last_name varchar (20) not null,
First_name varchar (20),
ReportsTo int,
Title varchar (20)
);

insert into persons values (1, 'Jha', 'Anand', 8, 'Data Analyst'),
                           (2, 'Chaturvedi', 'Ishan', 8, 'Data Scientist'),
						   (8, 'M', 'Sangeetha', 10, 'Manager'),
                           (4, 'Mehsram', 'Vineet', 10, 'Consultant'),
						   (20, 'Kumar', 'Satish', 18, 'Data Engineer'),
						   (18, 'Gupta', 'Ankita', 10, 'Business Architect'),
                           (7, 'Yadav', 'Abhishek', 10, 'Data Analyst'),
                           (10, 'Shekhar', 'Srinu', 123, 'Tech Lead'),
						   (123, 'Goeal', 'Neha', 134, 'Manager'),
						   (134, 'Dixit', 'Nitesh', 27, 'VP'),
					       (27, 'Bandekar', 'Kalpana', 32, 'CEO');

select * from persons;
-- list of employees who report to same manager

select distinct p1.person_id, concat(p1.first_name, ' ', p1.last_name) FuLL_name, p2.reportsto
from persons P1, Persons P2
where p1.person_id <> p2.person_id
and p1.reportsto = p2.reportsto
order by 1,2,3;

-- list of all the managers and the number of employees directly reporting to them

select p1.reportsto as Manager_Id,
count(distinct p2.person_id) total_empoyees_reporting
from persons P1, Persons P2
where p1.person_id <> p2.person_id
and p1.reportsto = p2.reportsto
group by 1
order by 1,2;

-- List of all the employees and their managers

SELECT Upper(CONCAT(b.First_Name, ' ', b.Last_Name))AS 'Direct Reporting', 
Upper(CONCAT(a. First_Name,' ', a.Last_Name)) AS Manager FROM 
 persons a INNER JOIN persons b ON a.Person_ID = b.ReportsTo
ORDER BY Manager;

-- List of all the employees and their managers if it exists

SELECT Upper(CONCAT(b.First_Name, ' ', b.Last_Name)) AS 'Direct Reporting', 
upper(CONCAT(a. First_Name,' ', a.Last_Name)) AS Manager FROM 
 persons b LEFT OUTER JOIN persons a ON a.Person_ID = b.ReportsTo
ORDER BY Manager;

SELECT CONCAT (a.First_Name, ' ' , a.Last_Name) AS Manager,
COUNT(b.Person_ID) AS TOT_EMP_REPORTING
FROM Persons b
LEFT OUTER JOIN persons a ON a.Person_ID = b.ReportsTo
GROUP BY 1
-- HAVING TOT_EMP_REPORTING >=2
ORDER BY 2 DESC;

select * from persons
-------------------------------------------------------------------------------------------------------------------------------------
use sales;
-- to get who reports to whom
select concat(e.first_name,' ',e.last_name) as Emp_Name,
	   concat (m.first_name,' ',m.last_name) as Manager_name
       from sales.staffs as E inner join sales.staffs as M 
       on m.staff_id = e.manager_id;
       
-- customer located in same city

select * from sales.customers;

select concat (c1.first_name, ' ',c1.last_name) as Customer_1,
concat (c2.first_name, ' ',c2.last_name) as Customer_2, C2.city
from sales.customers C1 Inner Join sales.customers C2
on c1.customer_id > c2.customer_id
and c1.city =c2.city
order by 3