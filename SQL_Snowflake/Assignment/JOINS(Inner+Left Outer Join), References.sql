use database practice
create or replace table cows_ones
( number integer,
 breed varchar (20)
)

insert into cows_ones values (1, 'Holstein');
insert into cows_ones values (2, 'Guernsey');
insert into cows_ones values (3, 'Angus');
insert into cows_ones values (4, 'Mou');
insert into cows_ones values (5, 'Honey');


create or replace table cows_two
( number integer,
 breed varchar (20)
)

insert into cows_two values (2, 'Jersey');
insert into cows_two values (3, 'Brown Swiss');
insert into cows_two values (4, 'Ayrshire');

select * from cows_ones
select * from cows_two

select x.number, x.breed, y.breed
from cows_ones as x inner join cows_two as y
on x.number = y.number

select x.number, x.breed, y.breed
from cows_ones as x left outer join cows_two as y
on x.number = y.number


select x.number, x.breed, y.breed
from cows_ones as x, cows_two as y
where x.number = y.number

CREATE OR REPLACE TABLE CJ_OWNER
(
   OwnerID INTEGER NOT NULL PRIMARY KEY ,
   Name VARCHAR2(20),
   Surname STRING,
   StreetAddress VARCHAR2(50),
   City STRING,
   State CHAR(4),
   StateFull STRING,
   ZipCode INTEGER
);

CREATE OR REPLACE TABLE CJ_PETS
(
 PetID VARCHAR(10) NOT NULL PRIMARY KEY,
 Name VARCHAR(20),
 Kind STRING,
 Gender CHAR(7),
 Age INTEGER,
 OwnerID INTEGER NOT NULL REFERENCES CJ_OWNER  
 );
-- This owner id is bring refered from CJ_Owner table, this is called foreign key;

select * from CJ_Owner
Select * from CJ_Pets

create or replace table CJ_Owner_pets as
select o.ownerid,o.name as Owner_name,surname, o.city,o.state, o.zipcode, p.petid, p.name as Pet_Name, p.kind, p.gender, p.age
from CJ_Pets as P Inner Join CJ_Owner as O
on P.Ownerid = O.Ownerid

select * from CJ_Owner_pets

create or replace table CJ_Owner_pets as
select o.ownerid,o.name as Owner_name,surname, o.city,o.state, o.zipcode, p.petid, p.name as Pet_Name, p.kind, p.gender, p.age
from CJ_Pets as P Inner Join CJ_Owner as O
on P.Ownerid = O.Ownerid

create or replace table CJ_Owner_pets as
select o.ownerid,o.name as Owner_name,surname,p.petid, p.name as Pet_Name,p.kind, p.gender, p.age ,o.city,o.state, o.zipcode
from CJ_Pets as P Left Outer Join CJ_Owner as O
on P.Ownerid = O.Ownerid



