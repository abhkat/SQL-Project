
alter table [dbo].[pizza_sales]
alter column[pizza_ingredients]varchar(250)
 select * from pizza_sales
--q1 total revenue

select sum(total_price) as total_revenue from[dbo].[pizza_sales] 

--q2 avg price per piece

select sum(total_price)/count(distinct(order_id)) as avg_price from pizza_sales

--q3 total pizza sold
select sum(quantity) as total_piza_sold from pizza_sales

--q4 total order placed

select count(distinct(order_id)) as total_orders from pizza_sales

--q5 avg pizza per order

select CAST(cast(sum(quantity) AS DECIMAL(10,2))/CAST (count(distinct(order_id)) AS DECIMAL (10,2)) AS DECIMAL(10,2)) from pizza_sales

--q6  daily trend for total order

select DATENAME(DW,order_date) as week_days,count(distinct order_id) as total_order from pizza_sales group by DATENAME(DW,order_date)

--q7 months wise trend

select datename(month,order_date) as months_wise , count(distinct order_id) as total_order 
from pizza_sales group by datename(month,order_date) 
order by   total_order  

--q8 percentage of sales by piza categories

select pizza_category,sum(total_price) *100/(select sum(total_price) from pizza_sales where month(order_date) = 1
) as PCT from pizza_sales
where month(order_date) = 1
group by pizza_category

--q9 percentage of sales by pizza size

select pizza_size,cast(sum(total_price) *100/(select sum(total_price) from pizza_sales where DATEPART (quarter,order_date)=1
) as decimal(10,2)) as PCT from pizza_sales
where DATEPART (quarter,order_date)=1
group by pizza_size

--q10 top5 best perforimg pizza (quantity, order,revenue)

select * from pizza_sales

select top 5 pizza_name,sum(quantity) as total_quantity from pizza_sales 
group by pizza_name
order by total_quantity asc

select top 5 pizza_name,sum(total_price) as revenue from pizza_sales 
group by pizza_name
order by revenue desc