-- Question 1: What is the total amount each customer spent at the restaurant?
select s.customer_id Customer_ID, sum(m.price) total_spent
from sales s
join menu m
on s.product_id = m.product_id
group by s.customer_id
order by total_spent desc;

------------------------------------------------------------------------------------------
-- Question 2: How many days has each customer visited the restaurant?
select customer_id Customer_ID, count(distinct order_date) num_days
from sales 
group by customer_id
order by num_days desc;

------------------------------------------------------------------------------------------
-- Question 3: What was the first item from the menu purchased by each customer?
with temp3 as
	(select customer_id, order_date, product_id,
		ROW_NUMBER() over (PARTITION BY customer_id order by order_date) as order_rank
	from sales)
select t.customer_id, t.order_date, m.product_name
from temp3 t
join menu m 
on t.product_id = m.product_id
where t.order_rank =1;

------------------------------------------------------------------------------------------
-- Question 4: What is the most purchased item on the menu and how many times it was purchased by all customers?
with temp4 as
	(select product_id ID, count(product_id) freq
	 from sales
	 group by product_id)
select top 1 m.product_name, t.freq
from temp4 t
join menu m
on t.ID = m.product_id
order by t.freq desc;

------------------------------------------------------------------------------------------
-- Question 5: Which item was the most popular for each customer?
with temp5 as
	(select customer_id cus_ID, product_id prod_ID, count(product_id) freq,
		ROW_NUMBER() over (PARTITION BY product_id order by count(product_id) desc) as f
	 from sales
	 group by customer_id, product_id)
select top 3 t.cus_ID, m.product_name, t.freq
from temp5 t
join menu m
on m.product_id = t.prod_ID
order by t.freq desc;

------------------------------------------------------------------------------------------
-- Question 6: Which item was purchased first by the customer after they became a member?
with temp6 as
	(select m.customer_id cus_ID, s.product_id pod_ID, m.join_date, s.order_date,
		ROW_NUMBER() OVER (PARTITION BY m.customer_id order by s.order_date) as [rank]
	 from sales s
	 join members m
	 on s.customer_id = m.customer_id
	 where s.order_date >= m.join_date)

select distinct t.cus_ID, t.join_date, t.order_date, m.product_name
from temp6 t
join menu m
on t.pod_ID = m.product_id
where t.rank=1;

------------------------------------------------------------------------------------------
-- Question 7: Which item was purchased by the customer just before they became a member?
with temp7 as
	(select m.customer_id cus_ID, s.product_id pod_ID, m.join_date, s.order_date,
		ROW_NUMBER() OVER (PARTITION BY m.customer_id order by s.order_date) as [rank]
	 from sales s
	 join members m
	 on s.customer_id = m.customer_id
	 where s.order_date < m.join_date)
select t.cus_ID, t.join_date, t.order_date, m.product_name
from temp7 t
join menu m
on m.product_id = t.pod_ID
where t.rank =1;

------------------------------------------------------------------------------------------
-- Question 8: What is the total items and amount spent for each member before they became a member?
with temp8 as
	(select mem.customer_id customer_ID, count(s.product_id) num_products, sum(m.price) total_purchases
	 from members mem
	 join sales s
	 on s.customer_id = mem.customer_id
	 join menu m
	 on s.product_id = m.product_id
	 where s.order_date<mem.join_date
	 group by mem.customer_id)
select * from temp8;

------------------------------------------------------------------------------------------
-- Question 9: if each $1 spent equates to 10 points and sushi has a 2x points multiplier
--so how many points would each customer have?
with temp9 as
	(select s.customer_id cus_ID,
		case when m.product_id = 1 then 20*m.price
			 when m.product_id = 2 then 10*m.price
			 when m.product_id = 3 then 10*m.price end as total_purchases
	from sales s
	join menu m
	on s.product_id = m.product_id)

select t.cus_ID, sum(t.total_purchases) total_points
from temp9 t
group by t.cus_ID
order by total_points desc;

------------------------------------------------------------------------------------------
-- Question 10: in the first week after a customer joins the program(including their join date)
-- they earn 2xpoints on all items, not just sushi - how many points do customer A and B have at the end of January?
with temp10 as
	(select distinct mem.customer_id, mem.join_date, s.order_date,  20*m.price as total_purchases,
		ROW_NUMBER() over (PARTITION BY mem.customer_id order by 20*m.price desc) as [rank]
	from sales s
	join menu m
	on s.product_id = m.product_id
	join members mem
	on mem.customer_id = s.customer_id
	where (s.order_date >= mem.join_date) and (s.order_date< '2021-02-01'))

select t.customer_id, t.total_purchases
from temp10 t
where t.rank=1;

------------------------------------------------------------------------------------------
--Bonus Question 1: "Join all things"
select s.customer_id, s.order_date, m.product_name, m.price,
			case when s.order_date >=(select join_date 
									  from members 
									  where members.customer_id = s.customer_id) then 'Y'
		         else 'N' end as member
from sales s
join menu m
on m.product_id = s.product_id;

------------------------------------------------------------------------------------------
-- Bonus Question 2: "Rank all the things"
with temp12 as
	(select s.customer_id, s.order_date, m.product_name, m.price,
			case when s.order_date >=(select join_date 
									  from members 
									  where members.customer_id = s.customer_id) then 'Y'
		         else 'N' end as member
	from sales s
	join menu m
	on m.product_id = s.product_id)

select t.customer_id, t.order_date, t.product_name, t.price, t.member,
		case when t.member = 'N' then NULL
			 else RANK() over (PARTITION BY t.customer_id, t.member order by t.order_date) end as ranking
from temp12 t