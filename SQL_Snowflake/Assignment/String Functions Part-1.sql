CREATE OR REPLACE TABLE AGENTS
   (	
     AGENT_CODE CHAR(6) NOT NULL PRIMARY KEY, 
	 AGENT_NAME CHAR(40) , 
	 WORKING_AREA CHAR(35), 
	 COMMISSION NUMBER(10,2) DEFAULT 0.05, 
	 PHONE_NO CHAR(15), 
	 COUNTRY VARCHAR2(25) 
	 );
     
INSERT INTO AGENTS VALUES ('A007', 'Ramasundar', 'Bangalore',0.15,'077-25814763', '');
INSERT INTO AGENTS(AGENT_CODE,AGENT_NAME,WORKING_AREA) 
VALUES ('A110', 'Anand', 'Germany');


INSERT INTO AGENTS VALUES ('A003', 'Alex ', 'London', '0.13', '075-12458969', '');
INSERT INTO AGENTS VALUES ('A008', 'Alford', 'New York', '0.12', '044-25874365', '');
INSERT INTO AGENTS VALUES ('A011', 'Ravi Kumar', 'Bangalore', '0.15', '077-45625874', '');
INSERT INTO AGENTS VALUES ('A010', 'Santakumar', 'Chennai', '0.14', '007-22388644', '');
INSERT INTO AGENTS VALUES ('A012', 'Lucida', 'San Jose', '0.12', '044-52981425', '');
INSERT INTO AGENTS VALUES ('A005', 'Anderson', 'Brisban', '0.13', '045-21447739', '');
INSERT INTO AGENTS VALUES ('A001', 'Subbarao', 'Bangalore', '0.14', '077-12346674', '');
INSERT INTO AGENTS VALUES ('A002', 'Mukesh', 'Mumbai', '0.11', '029-12358964', '');
INSERT INTO AGENTS VALUES ('A006', 'McDen', 'London', '0.15', '078-22255588', '');
INSERT INTO AGENTS VALUES ('A004', 'Ivan', 'Torento', '0.15', '008-22544166', '');
INSERT INTO AGENTS VALUES ('A009', 'Benjamin', 'Hampshair', '0.11', '008-22536178', '');

select * from agents
-------------------------------------------------------------------------------------------------------------------------
-- set the country to 'INDIA' where country is null and blank
update agents
set country ='INDIA' where country is null or country = ''
---------------------------------------------------------------------------------------------------------------------------

--The SUBSTRING () function returns the position of a string or binary value from the complete string, 
--starting with the character specified by substring_start_index. If any input is null, null is returned */

--Example 1: Get the substring from a specific string in Snowflake
select substring('ANAND KUMAR JHA', 1, 9) AS PARTIAL_NAME;
select substring('ANAND KUMAR JHA', 0, 9) AS PARTIAL_NAME;
select substring('ANAND KUMAR JHA', 4, 7);

select substring('Raja Ram',0,3);
select substring('Raja Ram',3);

select substring('ANAND KUMAR JHA',-7,6); -- START FROM INDEX -7 AND GIVE NEXT 3 CHARACTERS FROM THAT INDEX
select substring('ANAND KUMAR JHA',-7,-4); -- NO OUTPUT as the last 4 is inn negative
select substring('ANAND KUMAR JHA',NULL); 
-----------------------------------------------------------------------------------------------------------------------

select agent_code, substring (Agent_Code,-3 ) from agents -- i want only the last three digits from Agent_code

select agent_code, substring (Agent_Code,2,3) as agent_details from agents

describe table agents
-----------------------------------------------------------------------------------------------------------------------
-- lenght function used to return the length of string

select length (' Chetan Dudheria ') as My_name_length-- spaces are also counted
-------------------------------------------------------------------------------------------------------------------
select (substring ('Anand Kumar',1,1)||substring('Anand Kumar', -5,1)) as Initial_Name
select concat(substring ('Anand Kumar',1,1),substring('Anand Kumar', -5,1)) as Initial_Name

select 'Chetan' ||' '|| 'Dudheria' as full_name
  
select *,PHONE_NO ||' '|| Country as PHone_Country from agents
-----------------------------------------------------------------------------------------------------------------

select *from RJ_COnsumer_Complaints

create or replace view CJ_Consumer_Complaints_view as 
select DATE_RECEIVED,PRODUCT_NAME,SUB_PRODUCT,ISSUE,COMPANY,STATE_NAME ||'-'||ZIP_CODE as State_Details,
SUBMITTED_VIA,COMPANY_RESPONSE_TO_CONSUMER,TIMELY_RESPONSE,CONSUMER_DISPUTED,COMPLAINT_ID
from RJ_COnsumer_Complaints
where sub_product is not null

select * from CJ_Consumer_Complaints_view
-----------------------------------------------------------------------------------------------------------------------------

/*
Snowflake CAST is a data-type conversion command. 
Snowflake CAST works similar to the TO_ datatype conversion functions. 
If a particular data type conversion is not possible,
it raises an error. Let’s understand the Snowflake CAST in detail via the syntax and a few examples.
*/

select cast('1.6845' as decimal(4,2));

-- When the provided precision is insufficient 
-- to hold the input value, the Snowflake CAST command raises an error as follows:
select cast('123.12' as number(4,2));
--Here, precision is set as 4 but the input value has a total of 5 digits, thereby raising the error.
select cast('123.12' as number(5,2));

--TRY_CAST( <source_string_expr> AS <target_data_type> )
select try_cast('05-Mar-2016' as timestamp);

--The Snowflake TRY_CAST command returns NULL as the input value 
--has more characters than the provided precision in the target data type.
select try_cast('ANAND' as char(4));

---select cast ('27-09-2012' as timestamp) why is it not taking

select TRY_cast('23-09-1990' as timestamp);-- will not work, date should be in YYYY-MM_DD format
select TRY_cast('1990-09-23' as timestamp);

select '1.6845'::decimal(2,1);

select cast('10-Sep-2021' as timestamp);
------------------------------------------------------------------------------------------------------------------------------------------
--trim function remove leading and trailing characters from string (at the start at the end character)

select trim('❄-❄ABC-❄-', '❄-') as trimmed_string;
select trim('❄-❄ABC-❄-', '❄') as trimmed_string;
select trim('❄-❄ABC-❄-', '-') as trimmed_string;
SELECT TRIM('********T E S T I N G 1 2 3 4********','*') AS TRIMMED_SPACE; select substring ('********T E S T I N G 1 2 3 4********', 9,21);
SELECT TRIM('********T E S T I*N*G 1 2 3 4********','*') AS TRIMMED_SPACE;

--ltrim
select ltrim('#000000123', '0#');
select ltrim('#0000AISHWARYA', '0#'); select substring ('#0000AISHWARYA',-9,9),  select substring ('#0000AISHWARYA',6,9)
select ltrim('      ANAND JHA', '');

--RTRIM
select rtrim('$125.25', '.0');
select rtrim('ANAND JHA*****', '*');

--To remove the white spaces or the blank spaces from the string TRIM function can be used. 
--It can remove the whitespaces from the start and end both.
select TRIM('  Snwoflake Space Remove  ', ' ');

--To remove the first character from the string you can pass the string in the RTRIM function.
select LTRIM('Snowflake Remove  ', 'S'); --EXCEL U WILL FIND LEFT
--To remove the last character from the string you can pass the string in the RTRIM function.
select RTRIM('Snwoflake Remove  ', 'e'); --IN EXCEL U WILL FIND RIGHT

select BTRIM('  Snwoflake Space Remove  ', ' '); -- THERE IS NOTHING CALLED BTGRIM

--LENGTH FUNCTION
SELECT LEN(trim('  Snowflake Space Remove  ')) as length_EXCUDING_SPACE_string;
SELECT LENGTH(trim('  Snowflake Space Remove  ')) as length_string;
--------------------------------------------------------------------------------------------------------------------------------------
-- REVERSE IN STRING
select reverse('aNAND!');

-- SPLIT
select split('127.0.0.1', '.');
SELECT SPLIT('ANAND-KUMAR-JHA','-');

select  0, split_part('11.22.33', '.',  0);

select split_part('aaa--bbb-BBB--ccc', '--',1);
select split_part('aaa--bbb-BBB--ccc', '--',2);
select split_part('aaa--bbb-BBB--ccc', '--',3);
select split_part('aaa--bbb-BBB--ccc', '--',4);

SELECT split(AGENT_DETAILS, '-')
FROM (
SELECT *,concat(AGENT_CODE, '-', AGENT_NAME) AS agent_details 
  from agents );
  

SELECT lower('India Is My Country') as lwr_strng;
SELECT UPPER('India Is My Country') as upr_strng;

--REPLACE COMMAND
-- REPLACE( <subject> , <pattern> [ , <replacement> ] )

select REPLACE( '   ANAND KUMAR JHA   ' ,' ','*');
select REPLACE( '   ANAND KUMAR JHA   ' ,' '); -- 

SELECT REPLACE('   T  E S T I N G 1 2 3 4   ',' ')


select cast (125.35 as number (3,0))--125 ,total 3 digits i want and no decimal 
select substring (125.35, 1,3)--125 here, i want to extract 125 so 1 is on 1st position and 5 is on 3rd so 1,3




