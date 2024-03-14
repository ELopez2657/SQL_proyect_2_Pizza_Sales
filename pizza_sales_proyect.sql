use pizza_sales;
select * from order_details;
select * from pizzas;
select * from orders;
select * from pizza_types;

--------------------------------------------------------------------------------------------
select 
*
from 
	order_details od
	left join pizzas p on od.pizza_id = p.pizza_id
	left join orders o  on o.order_id = od.order_id  
	left join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
	
--------------------------------------------------------------------------------------------
-- Total revenue 
select 
	round(sum(od.quantity*p.price),2) as TOTAL_REVENUE 
from 
	order_details od
	left join pizzas p on od.pizza_id = p.pizza_id

--------------------------------------------------------------------------------------------
-- Average order value 
select 
	round(sum(od.quantity*p.price)/count(distinct order_id),2) as AVG_REVENUE 
from 
	order_details od
	left join pizzas p on od.pizza_id = p.pizza_id;

--------------------------------------------------------------------------------------------
-- Pizzas Sold
select 
	sum(quantity) 
from 
	order_details;

--------------------------------------------------------------------------------------------
-- Total Orders 
select 
	count(distinct order_id) 
from 
	order_details;

--------------------------------------------------------------------------------------------
--Average pizzas per orden 
select 
	cast(sum(quantity) as decimal(10,2))/count(distinct order_id) as Average_pizza_order
from 
	order_details;

--------------------------------------------------------------------------------------------
--Daily Trend for Total Orders
select 
	datename(dw,o.date) as order_day,
	count(distinct od.order_id) as Total_order
from 
	order_details od
	left join orders o on od.order_id = o.order_id
group by 
	datename(dw,o.date)
order by 
	Total_order desc;

--------------------------------------------------------------------------------------------
--Monthly Trend for Total Orders
select 
	datename(month,o.date) as order_month,
	count(distinct od.order_id) as Total_order
from 
	order_details od
	left join orders o on od.order_id = o.order_id
group by 
	datename(month,o.date)
order by 
	Total_order desc;

--------------------------------------------------------------------------------------------
--Percent sales by category
select 
	category, 
	sum(quantity) Sold, 
	round(sum(quantity * p.price),2) Revenue,
	round(sum(quantity * p.price)/(select sum(od.quantity*p.price) from order_details od left join pizzas p on od.pizza_id = p.pizza_id ) * 100,2) as Perc
from 
	order_details od
	left join pizzas p on od.pizza_id = p.pizza_id
	left join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by
	category
order by 
	perc desc

--------------------------------------------------------------------------------------------
--Percent sales by pizza
select 
	name, 
	sum(quantity) Sold, 
	round(sum(quantity * p.price),2) Revenue,
	round(sum(quantity * p.price)/(select sum(od.quantity*p.price) from order_details od left join pizzas p on od.pizza_id = p.pizza_id ) * 100,2) as Perc
from 
	order_details od
	left join pizzas p on od.pizza_id = p.pizza_id
	left join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by
	name
order by 
	perc desc

--------------------------------------------------------------------------------------------
-- Percent sales by size
select 
	size, 
	sum(quantity) Sold, 
	round(sum(quantity * p.price),2) Revenue,
	round(sum(quantity * p.price)/(select sum(od.quantity*p.price) from order_details od left join pizzas p on od.pizza_id = p.pizza_id ) * 100,2) as Perc
from 
	order_details od
	left join pizzas p on od.pizza_id = p.pizza_id
	left join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by
	size
order by 
	perc desc

--------------------------------------------------------------------------------------------
--Top 10 by revenue 
select top 10
	name, 
	sum(quantity) Sold, 
	round(sum(quantity * p.price),2) Revenue,
	round(sum(quantity * p.price)/(select sum(od.quantity*p.price) from order_details od left join pizzas p on od.pizza_id = p.pizza_id ) * 100,2) as Perc
from 
	order_details od
	left join pizzas p on od.pizza_id = p.pizza_id
	left join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by
	name
order by 
	Revenue desc

--------------------------------------------------------------------------------------------
--Bottom 5 by revenue
select top 10
	name, 
	sum(quantity) Sold, 
	round(sum(quantity * p.price),2) Revenue,
	round(sum(quantity * p.price)/(select sum(od.quantity*p.price) from order_details od left join pizzas p on od.pizza_id = p.pizza_id ) * 100,2) as Perc
from 
	order_details od
	left join pizzas p on od.pizza_id = p.pizza_id
	left join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by
	name
order by 
	Revenue asc

--------------------------------------------------------------------------------------------
--Top 10 by	Quantity 
select top 10
	name, 
	sum(quantity) Sold, 
	round(sum(quantity * p.price),2) Revenue
from 
	order_details od
	left join pizzas p on od.pizza_id = p.pizza_id
	left join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by
	name
order by 
	Sold desc

--------------------------------------------------------------------------------------------
--Bottom 5 by revenue
select top 10
	name, 
	sum(quantity) Sold, 
	round(sum(quantity * p.price),2) Revenue
from 
	order_details od
	left join pizzas p on od.pizza_id = p.pizza_id
	left join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by
	name
order by 
	sold asc

--------------------------------------------------------------------------------------------
--Top 10 by	Orders 
select top 10
	name, 
	sum(quantity) Sold, 
	round(sum(quantity * p.price),2) Revenue,
	COUNT(distinct order_id) Total_orders
from 
	order_details od
	left join pizzas p on od.pizza_id = p.pizza_id
	left join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by
	name
order by 
	sold desc

--------------------------------------------------------------------------------------------
--Bottom 5 by Orders 
select top 10
	name, 
	sum(quantity) Sold, 
	round(sum(quantity * p.price),2) Revenue,
	COUNT(distinct order_id) Total_orders
from 
	order_details od
	left join pizzas p on od.pizza_id = p.pizza_id
	left join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by
	name
order by 
	sold asc