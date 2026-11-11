--creating the database
create database Flipkart_Ecommerce;

USE Flipkart_Ecommerce;


SELECT DB_NAME() AS CurrentDatabase;

Create Table customers (
CustomerID Int Primary key,
CustomerName Varchar(100),
Gender Varchar(20),
City Varchar(50),
state Varchar(50),
RegistrationDate Date
);
GO

select * from Customers;

Drop table Customers;

select * from dbo.Flipkart_Raw_Orders;

--Step 1 — Data Quality Validation

--Total records
select count(*) as Total_orders from dbo.Flipkart_Raw_Orders;

--Check duplicate Order IDs
select Order_ID,count(*)as Order_count from dbo.flipkart_raw_orders Group by Order_ID having count(*)>1;

-- Check missing values
select count(*) as Total_Rows,
sum(case when Order_ID is null then 1 else 0 end) as Missing_Order_ID,
sum(case when Order_Date is null then 1 else 0 end) as Missing_Order_Date,
sum(case when City is null then 1 else 0 end) as Missing_city,
sum(case when Order_Value is null then 1 else 0 end) as Missing_Order_Value,
sum(case when Status is null then 1 else 0 end) as Missing_Status,
sum(case when Delivery_Type is null then 1 else 0 end) as Missing_Delivery_Type,
sum(case when Customer_Segment is null then 1 else 0 end) as Missing_Customer_Segment,
sum(case when Warehouse is null then 1 else 0 end) as Missing_Warehouse,
sum(case when Promised_Days is null then 1 else 0 end) as Missing_Promised_Days,
sum(case when Actual_Days is null then 1 else 0 end) as Actual_Days,
sum(case when SLA_Breached is null then 1 else 0 end) as Missing_SLA_Breached
from dbo.Flipkart_Raw_Orders;

--check business logic
select * from dbo.Flipkart_Raw_Orders where Status ='Delivered' and Actual_Days is null;
-- if the order is deliverd, we can expect an actual delivery duration

select * from dbo.Flipkart_Raw_Orders;

-- Check NULL Actual_Days by Status
select status,count(*) as Missing_Actual_Days from dbo.flipkart_Raw_Orders 
where Actual_days is Null 
group by status order by Missing_Actual_days Desc;

-- Check invalid delivery day values
select min(Promised_days) as Min_Promised_days,
max(promised_days) as Max_Promised_days,
Min(Actual_days) as Min_Actual_days,
Max(Actual_days) as Max_actual_days from dbo.Flipkart_raw_orders;

-- Validate SLA_Breached
-- Actual_Days > Promised_Days, then SLA_Breached should be Yes. Otherwise, it should be No
-- Check SLA Breach business logic
select count(*) as Incorrect_SLA_Records from dbo.Flipkart_raw_orders where
(actual_days > Promised_Days and SLA_Breached <> 'Yes')
or
(actual_days <=Promised_days and SLA_Breached <>'No');

--let's make sure there aren't unexpected values such as a typo like:Delivered, delivered, Deliverd, etc.

-- Check distinct Status values
select status, count(*) as order_count from dbo.Flipkart_raw_orders 
group by Status 
order by order_count Desc;

-- Check distinct Category values
select Category, COUNT(*) as Order_Count from dbo.Flipkart_raw_orders 
group by Category
Order by Category Desc;

-- Check distinct Delivery Type values
select Delivery_type, count(*) as order_count from flipkart_raw_orders
group by Delivery_type
Order by delivery_type Desc;

-- Check distinct Customer Segment values
select Customer_segment,count(*)as order_count from dbo.Flipkart_raw_orders
group by Customer_segment
order by Customer_segment Desc;

-- Phase 2: Business Logic / Analytical Layer
--Sales Performance Analysis - Total Orders |Total Revenue |Average Order Value |Delivered Revenue|Cancelled Orders|Returned Orders

select count(*) as Total_Order,
Sum(Order_value) as Total_Revenue,
Avg(cast(Order_Value as decimal(10,2))) as Average_Order_value,
sum(case when Status = 'delivered' then Order_value else 0 end) as Delivered_Revenue,
sum(case when status = 'Cancelled' then 1 else 0 end) as Cancelled_orders,
sum(case when status = 'Returned' then 1 else 0 end) as Returned_Orders
from dbo.Flipkart_raw_orders;


-- Step 2 — Revenue & Orders by City/Category
--Which cities are driving the most orders and revenue?

select * from dbo.Flipkart_raw_orders;

select city,count(*) as Total_orders,
sum(Order_Value) as Revenue,
Avg(cast(Order_value as Decimal(10,2))) as Avg_Order_Value
from dbo.Flipkart_raw_Orders
group by City 
Order by Revenue Desc;

--Which product categories generate the most orders and revenue?
-- Step 3 - Category Performance
select Category, count(*) as Total_Orders, sum(Order_Value) as Revenue, 
Avg(Cast(Order_value as Decimal(10,2))) as Avg_Order_Value 
from dbo.Flipkart_raw_Orders
group by Category
order by Revenue desc;

--Which combination of city and category generates the most revenue?
-- Step 4 - City + Category Performance
select City,Category, count(*)as Total_Orders,sum(Order_Value) as Revenue,
Avg(cast(Order_Value as Decimal(10,2))) as Avg_Order_Value
from dbo.Flipkart_raw_Orders
Group by city,Category
Order By Revenue desc;

--Step 5 → Customer Segment Performance
--Which customer segment contributes the most orders and revenue?
select Customer_Segment,Count(*) as Total_orders,
sum(Order_Value) as Revenue,
AVG(cast(Order_value as decimal(10,2))) as AVG_Order
from dbo.Flipkart_raw_Orders
Group by Customer_Segment
order by Revenue Desc;

-- Step 6 - Delivery & SLA Performance
select count(*) as Total_Orders,
sum(Case when status = 'Delivered' then 1 else 0 end) as Delivered_orders,
sum(case when status = 'Delivered' and Actual_Days <= Promised_Days Then 1 else 0 end) as on_time_Deliveries,
sum(Case when Status = 'Delivered' and Actual_Days > Promised_Days Then 1 else 0 end) as late_deliveries,
AVG(case when status = 'Delivered' then cast(actual_days as Decimal(10,2)) end) as AVG_Actual_Delivery_Days
from dbo.Flipkart_raw_Orders;

--Calculate On-Time & Late %
-- Step 6.1 - Delivery Performance %
select count(*) as Delivered_Orders,
sum(Case when Actual_days <= Promised_days then 1 else 0 end) as On_Time_Deliveries,
sum(Case when Actual_days > Promised_days then 1 else 0 end) as Late_Deliveries,
cast(sum(Case when Actual_days <= Promised_days then 1 else 0 end) * 100.0 / Count(*) as Decimal(5,2)) as On_Time_Percentage,
cast(sum(case when Actual_days > Promised_days then 1 else 0 end) * 100.0 / Count(*) as Decimal(5,2)) as Late_Percentage
from dbo.flipkart_raw_orders
where status = 'Delivered';

-- Step 6.2 - SLA Performance by City
select city, count(*) as Delivered_Orders,
sum(case when Actual_days <= Promised_days then 1 else 0 end) as On_time_Deliveries,
sum(case when Actual_days > Promised_days then 1 else 0 end) as Late_Deliveries,
Cast(sum(case when Actual_days <= Promised_days then 1 else 0 end)*100.0/count(*) as decimal(5,2)) as on_time_percentage,
Cast(sum(case when Actual_days > Promised_days then 1 else 0 end)*100.0/count(*)as decimal(5,2))as late_Percentage
from dbo.flipkart_raw_orders
where status ='Delivered'
group by city
order by Late_Percentage desc;

-- Step 6.3 - SLA Performance by Delivery Type
select Delivery_type,count(*) as Delivered_orders,
sum(case when Actual_days <= Promised_days then 1 else 0 end) as on_time_deliveries,
sum(case when Actual_days > promised_days then 1 else 0 end) as Late_deliveries,
cast(sum(case when Actual_days <= Promised_days then 1 else 0 end)*100.0/count(*)as decimal(5,2)) as on_time_percentage,
cast(sum(case when Actual_days > promised_days then 1 else 0 end)*100.0/count(*)as decimal(5,2)) as late_percentage
from dbo.flipkart_raw_orders
where status = 'Delivered'
Group by Delivery_type
order by late_percentage desc;

-- Step 6.4 - SLA Performance by Customer Segment
select Customer_Segment,count(*) as Delivered_orders, 
sum(case when Actual_days <= Promised_days then 1 else 0 end) as on_time_deliveries,
sum(case when Actual_days > Promised_days then 1 else 0 end) as Late_deliveries,
cast(sum(case when Actual_days <= Promised_days then 1 else 0 end)*100.0/count(*)as decimal(5,2)) as On_time_percentage,
cast(sum(case when Actual_days > Promised_days then 1 else 0 end)*100.0/count(*)as decimal(5,2)) as Late_Percentage
from dbo.flipkart_raw_orders
group by Customer_segment
order by Late_percentage desc;