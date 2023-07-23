CREATE SCHEMA dannys_diner;
USE dannys_diner;

drop table sales;

CREATE TABLE sales (
  customer_id char(1),
  order_date DATE,
  product_id int
);

select * from sales;
select count(*) from sales; -- 15 

INSERT INTO sales VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);

INSERT INTO menu VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);

INSERT INTO members VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');

-- What is the total amount each customer spent at the restaurant?
select customer_id, sum(price) as total_amount_spent
from sales inner join menu
on sales.product_id = menu.product_id
group by customer_id;

--------------------------------------------------------------------------------------

-- How many days has each customer visited the restaurant?

select customer_id, count(distinct order_date) as Days_visited
from sales
group by 1;

-------------------------------------------------------------------------------------
-- What was the first item from the menu purchased by each customer?

select  customer_id, product_name,
first_value (product_name) over(partition by customer_id order by order_date asc) as first_item 
from sales join menu
on sales.product_id = menu.product_id;

-- or
select DD.customer_id, DD.product_name from 
(select customer_id, product_name,
dense_rank () over (partition by customer_id order by order_date asc) as Rank_by_first_item
from sales join menu
on sales.product_id = menu.product_id) as DD
where Rank_by_first_item = 1;

-- USING LEAD

-----------------------------------------------------------------------------------------
-- What is the most purchased item on the menu 
-- and how many times was it purchased by all customers?

select product_name,count(order_date) most_purchased_item
from sales join menu on sales.product_id = menu.product_id
group by 1
order by 2 desc
limit 1;

------------------------------------------------------------------------------------
-- Which item was the most popular for each customer?

select customer_id, product_name, count(order_date) as number_of_orders
from sales join menu on sales.product_id = menu.product_id
group by 1,2
order by number_of_orders desc;

-- or

with cust_pop as
(select customer_id, product_id, count(product_id) as order_count
from sales
group by 1, 2
)

select customer_id, product_name from
(select c.customer_id, m.product_name, dense_rank() over(partition by customer_id order by order_count desc) as RANKS
from cust_pop c
join menu m using(product_id)) as fav
where ranks = 1;
---------------------------------------------------------------------------------------
-- Which item was purchased first by the customer after they became a member?

select S.customer_id,product_name, order_date, join_date
from sales as s inner join menu as M on S.Product_id = M.Product_id
                inner join members as MM on S.Customer_id = MM.Customer_id
where s.order_date >= mm.join_date;

-- or 

with after_join as 
(select s.customer_id, m.product_name,
dense_rank() over (partition by s.customer_id order by s.order_date) as first_order
from sales as s join menu as m on s.product_id = m.product_id
				join members as mm on s.customer_id = mm.customer_id
                where s.order_date > mm.join_date)
                
select customer_id, product_name
from after_join
where first_order = 1;
-------------------------------------------------------------------------------------
-- Which item was purchased just before the customer became a member?

select S.customer_id,product_name, order_date, join_date
from sales as s inner join menu as M on S.Product_id = M.Product_id
                inner join members as MM on S.Customer_id = MM.Customer_id
where s.order_date < mm.join_date 
order by order_date;

-- or

with before_join as 
(select s.customer_id, m.product_name,
dense_rank() over (partition by s.customer_id order by s.order_date desc) as first_order
from sales as s join menu as m on s.product_id = m.product_id
				join members as mm on s.customer_id = mm.customer_id
                where s.order_date < mm.join_date)
                
select customer_id, product_name
from before_join
where first_order = 1;
-----------------------------------------------------------------------------------
-- What is the total items and amount spent for each member before they became a member?

select s.customer_id, count(m.product_id) as total_items, sum(price) as Amount_spent_by_each_mem
from sales as S join members as MM on S.customer_id = MM.customer_id
				join menu as M on S.product_id = M.product_id
where order_date < join_date
group by 1
order by 1 
-------------------------------------------------------------------------------------------------



