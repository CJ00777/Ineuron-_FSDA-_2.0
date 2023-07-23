use database practice
use schemas public

select *from RJ_Consumer_Complaints

-- command for seeing unique values and removing duplicate values

select distinct * from  RJ_Consumer_Complaints
select distinct product_name from  RJ_Consumer_Complaints-- displaying the unique product_name
limit 5 -- top is the keyword for MYSQL for limit

--'like' keyword highly used in SQl
-- % represents zero, one or multiple character
-- _ undersore represents single one or single character
a% - any values that starts with a
%a - any values that ends with a
%word% - any values that has word in any position

_a% - any values that has a in the second position
a_% - any values that starts with "a" and are atleast 2 chracters in length
a__% - any values that starts with "a" and are atleast 3 chracters in length
a%r - any values that starts with a and ends with r
ab%cd%de%f - any values that starts with ab followed by any characters and then cd and then followed by any characters 
and then de followed by any charcaters and ending with f


select distinct * from RJ_Consumer_Complaints
where product_name like 'account%'; -- % at the end means account at the start followed by any sequence of characters but as data is case sensitive present inside the table
--it should be written in query as it is

select * from RJ_Consumer_Complaints
where product_name like '%account%' -- two percentages mean the word can be appear anywhere start, middle, end.

select * from RJ_Consumer_Complaints
where product_name like '%account' --  percentage at the start mean account at the end.

select * from RJ_Consumer_Complaints
where product_name like 'Credit%'

-- _a% any values that has a in teh second position
select distinct * from RJ_Consumer_Complaints
where company like '_a%';

-- a_% - any values that starts with "a" and are atleast 2 chracters in length
select distinct * from RJ_Consumer_Complaints
where submitted_via like 'F_%';

-- a__% - any values that starts with "a" and are atleast 3 chracters in length
select distinct * from RJ_Consumer_Complaints
where consumer_complaint_narrative like 'a__%';

-- a%r - any values that starts with a and ends with r
select distinct * from RJ_Consumer_Complaints
where sub_issue like 'A%s';

create or replace table like_ex(subject varchar(20));

insert into like_ex values
    ('John  Dddoe'),
    ('Joe   Doe'),
    ('John_down'),
    ('Joe down'),
    ('Elaine'),
    (''),    -- empty string
    (null);

SELECT * FROM like_ex;
select subject from like_ex where subject like '%Jo%oe%' ;

-- 'IN' highly used keyword

SELECT DISTINCT * FROM RJ_CONSUMER_COMPLAINTS WHERE PRODUCT_NAME IN ('Consumer Loan','Mortgage','Debt collection');

SELECT DISTINCT * FROM RJ_CONSUMER_COMPLAINTS WHERE PRODUCT_NAME = 'Consumer Loan' OR 
PRODUCT_NAME = 'Mortage' OR PRODUCT_NAME = 'Debt collection'; -- alternate code of the above one

SELECT DISTINCT * FROM RJ_CONSUMER_COMPLAINTS 
WHERE COMPANY IN ('Wells Fargo & Company','Citibank','
Bank of America');

SELECT DISTINCT * FROM RJ_CONSUMER_COMPLAINTS WHERE DATE_RECEIVED BETWEEN '29-07-2013' AND '31-07-2013'


