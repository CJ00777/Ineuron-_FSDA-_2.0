Use pizza_runner;

select * from runners;

DROP TABLE IF EXISTS customer_orders;

CREATE TABLE customer_orders (
  order_id INTEGER,
  customer_id INTEGER,
  pizza_id INTEGER,
  exclusions VARCHAR(4),
  extras VARCHAR(4),
  order_time TIMESTAMP
);

INSERT INTO customer_orders
  (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');
  
  CREATE TABLE runner_orders (
  order_id INTEGER,
  runner_id INTEGER,
  pickup_time VARCHAR(19),
  distance VARCHAR(7),
  duration VARCHAR(10),
  cancellation VARCHAR(23)
);

INSERT INTO runner_orders
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');

CREATE TABLE pizza_names (
  pizza_id INTEGER,
  pizza_name TEXT
);
INSERT INTO pizza_names values   (1, 'Meatlovers'),
  (2, 'Vegetarian');


CREATE TABLE pizza_recipes (
  pizza_id INTEGER,
  toppings TEXT
);
INSERT INTO pizza_recipes

VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');
  
  CREATE TABLE pizza_toppings (
  topping_id INTEGER,
  topping_name TEXT
);
INSERT INTO pizza_toppings
 VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');


select * from runner_orders;
select * from pizza_toppings;
select * from pizza_recipes;
select * from pizza_names;
select * from customer_orders;

describe runner_orders;

-- How many pizzas were ordered?

select count(order_id)
from customer_orders;

-- How many unique customer orders were made?

select count(distinct order_id)
from customer_orders;
 	

select runner_id, count(order_id) as Orders_delivered
from runner_orders
where pickup_time !='null'
group by 1;

-- How many of each type of pizza was delivered?

select pizza_name, count(RN.order_id) as pizza_delivered
from customer_orders as CO join pizza_names as PN on CO.pizza_id = PN.pizza_id
						   join runner_orders as RN on CO.Order_id = RN.Order_id
where pickup_time != 'null'
group by 1;

--  How many Vegetarian and Meatlovers were ordered by each customer?

select customer_id, pizza_name, count(order_id)
from customer_orders CO join pizza_names as PN on CO.Pizza_id = PN.Pizza_id
group by 1,2
order by 1;

--  What was the maximum number of pizzas delivered in a single order?

select RO.order_id, count(CO.pizza_id) as Total_delivered
from runner_orders as RO join customer_orders as CO	
						  on RO.Order_ID = CO.Order_ID
where pickup_time != 'null'
group by 1
order by 2 desc;

-- For each customer, how many delivered pizzas had at least 1 change, 
-- and how many had no changes?

select CO.customer_id, 
sum(case
  when exclusions is not null or extras is not null then 1
        else 0
        end )as AtleastOneChange,
sum(case 
  when (exclusions is null and extras is null) then 1
        else 0
        end ) as NoChange
from customer_orders as CO
inner join runner_orders as RO
on CO.order_id = RO.order_id
where RO.distance != 0
group by CO.customer_id;


select * from customer_orders;
set sql_safe_updates=0;
update customer_orders set exclusions = null where (exclusions = '' or exclusions = 'null');
update customer_orders set extras = null where (extras = '' or extras = 'null');

-- How many pizzas were delivered to customers that had both exclusions and extras?

select customer_id,
sum(case when exclusions is not null and extras is not null then 1 else 0 end) as both_exclusion_extras
from customer_orders as CO
inner join runner_orders as RO
on CO.order_id = RO.order_id
where RO.distance != 0
group by CO.customer_id;

-- What was the volume of orders for each day of the week?

select dayname(order_time) as Day_wise, count(order_id) as Total_pizzas_ordered
from customer_orders
group by 1
order by 2 desc;

-- How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

select week(registration_date) as RegistrationWeek, count(runner_id) as RunnerRegistrated
from runners
group by 1;

-- What was the average distance traveled for each customer?

 select * from customer_orders;
 select * from runner_orders;

set sql_safe_updates = 0;
update runner_orders 
set distance = null where distance = '' or distance = 'null';
update runner_orders 
set duration = null where duration= '' or duration = 'null';

select customer_id, round(avg(distance),1) as avg_distance
from customer_orders as C inner join runner_orders as R 
					 on C.Order_id = R.Order_id
where distance is not null
group by 1
order by 2 desc;

--  What was the difference between the
--  longest and shortest delivery times for all orders?

with cte as(
select c.order_id, order_time, pickup_time, timestampdiff(minute, order_time,pickup_time) as TimeDiff1
from customer_orders as c
inner join runner_orders as r
on c.order_id = r.order_id
group by c.order_id, order_time, pickup_time)

select max(TimeDiff1) - min(TimeDiff1) as DifferenceTime from cte;

-- What was the average speed for each runner 
-- for each delivery and do you notice any trend for these values?

select runner_id, R.order_id, round(avg(distance*60/duration),1) as avg_speed
from customer_orders as c
inner join runner_orders as r
on c.order_id = r.order_id
group by 1, 2
order by 1;

-- What is the successful delivery percentage for each runner? (doubt)

with cte as(
select runner_id, sum(case
when distance is not null then 1
else 0
end) as percsucc, count(order_id) as TotalOrders
from runner_orders
group by runner_id)

select runner_id,round((percsucc/TotalOrders)*100) as Successfulpercentage 
from cte
order by runner_id;

-- What are the standard ingredients for each pizza? (GOOD ONE)

select * from pizza_toppings;
select * from pizza_recipes;
select * from pizza_names;

create table pizza_recipes1 
(
 pizza_id int,
    toppings int);
insert into pizza_recipes1
(pizza_id, toppings) 
values
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,8),
(1,10),
(2,4),
(2,6),
(2,7),
(2,9),
(2,11),
(2,12);

select * from pizza_recipes1;

with CTE as
(
select PR.pizza_id,PN.pizza_name, PT.Topping_name
from pizza_recipes1 as PR inner join pizza_toppings as PT on PR.Toppings = PT.Topping_id
			  inner join pizza_names as PN on PR.Pizza_Id = PN.Pizza_id
order by 1
)
                          
select pizza_name, group_concat(topping_name) as Standard_toppings
from CTE
group by 1;















