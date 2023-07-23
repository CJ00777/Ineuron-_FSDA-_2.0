drop table  CJ_Employee;
drop table CJ_Payment;
drop table CJ_Employee;
CREATE TABLE if not exists CJ_Employee
( 
emp_id int Primary Key,
name varchar(40) NOT NULL, 
birthdate date NOT NULL, 
gender varchar(10) NOT NULL, 
hire_date date NOT NULL
);

INSERT INTO CJ_Employee (emp_id, name, birthdate, gender, hire_date) VALUES 
(101, 'Bryan', '1988-08-12', 'M', '2015-08-26'), 
(102, 'Joseph', '1978-05-12', 'M', '2014-10-21'), 
(103, 'Mike', '1984-10-13', 'M', '2017-10-28'), 
(104, 'Daren', '1979-04-11', 'M', '2006-11-01'), 
(105, 'Marie', '1990-02-11', 'F', '2018-10-12');

Select * from CJ_Employee;

CREATE TABLE if not exists CJ_Payment 
( 
payment_id int PRIMARY KEY NOT NULL, 
emp_id int NOT NULL, 
amount float NOT NULL, 
payment_date date NOT NULL,
Foreign key (emp_id) references CJ_Employee (emp_id) On Delete Cascade On update Cascade
);

INSERT INTO CJ_Payment (payment_id, emp_id, amount, payment_date) VALUES
(301, 101, 1200, '2015-09-15'), 
(302, 101, 1200, '2015-09-30'), 
(303, 101, 1500, '2015-10-15'), 
(304, 101, 1500, '2015-10-30'), 
(305, 102, 1800, '2015-09-15'), 
(306, 102, 1800, '2015-09-30');

use bikestores;
Select distinct * from CJ_Payment;

create table if not exists   CJ_Emp_payment_Master_Cascade  as
select distinct EMP.emp_id, name, birthdate, gender, hire_date, payment_id, amount, payment_date
from CJ_employee as EMP  Left outer join CJ_Payment as PAY on EMP.emp_id = PAY.emp_id;

drop table CJ_Emp_payment_Master_Cascade;
select * from  CJ_Emp_payment_Master_Cascade;
select count(*) from CJ_Emp_payment_Master_Cascade;

DELETE FROM CJ_Employee WHERE emp_id = 102;

-- command to find the affected table by On Delete Cascade 

USE information_schema;
SELECT table_name FROM referential_constraints
WHERE constraint_schema = 'bikestores' -- database name
AND referenced_table_name = 'CJ_Employee' -- parent_table name
AND delete_rule = 'CASCADE';


ALTER TABLE CJ_Payment ADD CONSTRAINT `payment_fk`
FOREIGN KEY(emp_id) REFERENCES CJ_Employee (emp_id) ON UPDATE CASCADE;

UPDATE CJ_Employee SET emp_id = 102 WHERE emp_id = 103;

describe table Payment;

