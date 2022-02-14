-- Modifying tables
/*
1. I changed the data type of column "order_time" in table customer_orders from timestamp to varchar
to be equivalent to the "pickup_date" column in runner_orders table

-- I am thinking of changing the datatypes or the missing values in the table manually !?
*/
----------------------------------------------------------------------------
-- A. Pizza Metrics:
--Question 1: How many pizzas were ordered?
select COUNT(pizza_id) as num_pizzas_ordered from customer_orders

----------------------------------------------------------------------------
--Question 2: How many unique customers orders were made?
select COUNT(distinct customer_id) unique_num_of_customer_orders from customer_orders

-- We can also calculate the number of orders every unique customer made
select customer_id, COUNT(distinct order_id) num_orders 
from customer_orders
group by customer_id;

----------------------------------------------------------------------------
--Question 3: How many successful orders were delivered by each runner?
select * from runner_orders
-- There is 1 restaurant cancellation and 1 customer cancellation, and we want to exclude both.

select COUNT(order_id) as delivered_orders
from runner_orders
where pickup_time != 'null' and distance != 'null' and duration != 'null'

----------------------------------------------------------------------------
--Question 4: How many of each type of pizza was delivered?
select pn.pizza_name PizzaName, COUNT(co.pizza_id) freq
from customer_orders co
join pizza_names pn
on pn.pizza_id = co.pizza_id
join runner_orders ro
on ro.order_id = co.order_id
where (pickup_time != 'null') and (distance != 'null') and (duration != 'null')
group by pn.pizza_name

----------------------------------------------------------------------------
--Question 5: How many Vegetarian and Meatlovers were ordered by each customer?
select co.customer_id Customer_id,  pn.pizza_name PizzaName, COUNT(co.pizza_id) freq
from customer_orders co
join pizza_names pn
on pn.pizza_id = co.pizza_id
join runner_orders ro
on ro.order_id = co.order_id
where (pickup_time != 'null') and (distance != 'null') and (duration != 'null')
group by co.customer_id, pn.pizza_name;

----------------------------------------------------------------------------
--Question 6: What is the maximum number of pizzas delivered in a single order?
select order_id, max(num_pizzas) max_num_pizzas
from (select co.order_id, count(co.pizza_id) num_pizzas
	  from customer_orders co
	  group by co.order_id) s
group by order_id
order by max_num_pizzas desc;
----------------------------------------------------------------------------
--Question 7: For each customer, how many delivered pizzas had at least 1 change and how many had no changes
-- with changes
select co.customer_id, COUNT(co.pizza_id) num_orders_with_changes
from customer_orders co
join runner_orders ro
on ro.order_id = co.order_id
where ((len(co.exclusions)>0 or len(co.extras)>0) and
(co.exclusions != 'null' or co.extras != 'null')) and 
(ro.pickup_time != 'null') and (ro.distance != 'null') and (ro.duration != 'null')
group by customer_ID

--Without changes
select co.customer_id, count(co.pizza_id) num_orders_without_changes
from customer_orders co
join runner_orders ro
on co.order_id = ro.order_id
where ((len(exclusions)=0 and len(extras)=0) or
(exclusions = 'null' and extras = 'null')) and
(ro.pickup_time != 'null') and (ro.distance != 'null') and (ro.duration != 'null')
group by customer_id

----------------------------------------------------------------------------
--Question 8: How many pizzas were delivered that had both exclusion and extras?
select co.customer_id, count(*) num_pizzas
from customer_orders co
join runner_orders ro
on co.order_id = ro.order_id
where (len(exclusions)>0 and len(extras)>0)
	and (exclusions != 'null' and extras != 'null') 
	  and ((ro.pickup_time != 'null') and (ro.distance != 'null') and (ro.duration != 'null'))
group by co.customer_id

----------------------------------------------------------------------------
--Question 9: What was the total volume of pizza ordered for each hour of the day?
select DATEPART(hour, co.order_time) as [hour], count(*) freq
from customer_orders co
join runner_orders ro
on co.order_id = ro.order_id
where (ro.pickup_time != 'null') and (ro.distance != 'null') and (ro.duration != 'null')
group by DATEPART(hour, co.order_time)
order by freq desc;
----------------------------------------------------------------------------
--Question 10: What was the volume of orders for each day of the week?
select Weekdays, sum(freq) pizzas_ordered
from (select case when DATEPART(WEEKDAY, co.order_time) = 1 then 'Monday' 
				  when DATEPART(WEEKDAY, co.order_time) = 2 then 'Tuesday'
				  when DATEPART(WEEKDAY, co.order_time) = 3 then 'Wednesday'
				  when DATEPART(WEEKDAY, co.order_time) = 4 then 'Thursday'
				  when DATEPART(WEEKDAY, co.order_time) = 5 then 'Friday'
				  when DATEPART(WEEKDAY, co.order_time) = 6 then 'Saturday'
				  when DATEPART(WEEKDAY, co.order_time) = 7 then 'Sunday' end as Weekdays, 
		count(*) freq
		from customer_orders co
		join runner_orders ro
		on co.order_id = ro.order_id
		where (ro.pickup_time != 'null') and (ro.distance != 'null') and (ro.duration != 'null')
		group by order_time)s
group by Weekdays
order by pizzas_ordered desc;
----------------------------------------------------------------------------