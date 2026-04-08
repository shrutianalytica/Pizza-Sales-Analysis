-- PIZZA SALES SQL QUERIES

select * from pizza_sales;

-- A.	KPI’s
-- 1.	Total Revenue :-
select sum(total_price) as Total_Revenue from pizza_sales;
 
-- 2.	Average Order Value :-
select sum(total_price)/count(distinct(order_id)) as Avg_Order_Value from pizza_sales;
 
-- 3.	Total Pizzas Sold :-
select sum(quantity) as Total_Pizza_Sold from pizza_sales;
 
-- 4.	Total_Orders :-
select count(distinct(order_id)) as Total_Orders from pizza_sales;
 
-- 5.	Average Pizzas Per Order :-
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct(order_id)) as decimal(10,2)) as decimal(10,2)) as Avg_Pizzas_Per_Order from pizza_sales;
 

-- B.	Hourly Trend
select datepart(hour, order_time) as order_hour, 
sum(quantity) as Total_Pizza_Sold from pizza_sales 
group by datepart(hour, order_time) 
order by datepart(hour, order_time);
 
 
-- C.	Weekly Trend 
select datepart(iso_week, order_date) as Week_Number,
year(order_date) as Order_Year, 
count(distinct(order_id)) as Total_Orders from pizza_sales 
group by datepart(iso_week, order_date), year(order_date) 
order by datepart(iso_week, order_date), year(order_date);
         
          
 
-- D.	Percentage of Sales by Pizza Category
select pizza_category, 
sum(total_price) as Total_sales, 
sum(total_price)*100/(select sum(total_price) from pizza_sales where month(order_date)=1) as Percentage_Total_Sales 
from pizza_sales
where month(order_date)=1
group by pizza_category
order by pizza_category;
 
-- E.	Percentage of Sales by Pizza Size
select pizza_size, 
cast(sum(total_price) as decimal(10,2)) as Total_sales, 
cast(sum(total_price)*100/(select sum(total_price) from pizza_sales where datepart(quarter, order_date)=1) as decimal(10,2)) as Percentage_Total_Sales 
from pizza_sales
where datepart(quarter, order_date)=1
group by pizza_size
order by Percentage_Total_Sales desc;
 
-- F.	Top 5 Pizzas by Revenue
select Top 5 pizza_name, sum(total_price) as Total_Revenue from pizza_sales 
group by pizza_name
order by Total_Revenue desc;
 
-- G.	Bottom 5 Pizzas by Revenue
select Top 5 pizza_name, cast(sum(total_price) as decimal(10,2)) as Total_Revenue from pizza_sales 
group by pizza_name
order by Total_Revenue;
 
-- H.	Top 5 Pizzas by Quantity
select Top 5 pizza_name, sum(quantity) as Total_Quantity from pizza_sales 
group by pizza_name
order by Total_Quantity desc;
 
-- I.	Bottom 5 Pizzas by Quantity
select Top 5 pizza_name, sum(quantity) as Total_Quantity from pizza_sales 
group by pizza_name
order by Total_Quantity;
 


-- J.	Top 5 Pizzas by Orders
select Top 5 pizza_name, count(distinct(order_id)) as Total_Orders from pizza_sales 
group by pizza_name
order by Total_Orders desc;
 
-- K.	Bottom 5 Pizzas by Orders
select Top 5 pizza_name, count(distinct(order_id)) as Total_Orders from pizza_sales 
group by pizza_name
order by Total_Orders;
 
















