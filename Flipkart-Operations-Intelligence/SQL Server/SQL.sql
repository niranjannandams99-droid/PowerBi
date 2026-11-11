USE Flipkart_Ecommerce;
Create View dbo.vw_Flipkart_Order_Detail
as
Select
Order_ID,Order_Date,City,Category,Order_Value,Status,
Delivery_Type,Customer_Segment,Warehouse,Promised_Days,Actual_Days,SLA_Breached,

case when status <> 'Delivered' Then 'Not Applicable'
     when Actual_Days <= Promised_Days Then 'On Time'
     when Actual_Days > Promised_Days Then 'Late'
End as Delivery_Performance,

case when status = 'Delivered' and Actual_Days > Promised_Days
     then Actual_Days - Promised_Days else 0
End as Delay_Days
from dbo.Flipkart_Raw_Orders;
Go
select * from vw_Flipkart_Order_Detail;

--View 2 — SLA Summary
Create View dbo.vw_Flipkart_SLA_Summary
as 
select Count(*) as Total_Orders,
sum(Case When Status = 'Delivered' Then 1 Else 0 end) as Delivered_Orders,
sum(Case When Delivery_Performance = 'On Time' Then 1 else 0 end) as On_Time_Deliveries,
sum(case when Delivery_Performance = 'Late' Then 1 else 0 end) as Late_Deliveries,
Cast(sum(case when Delivery_Performance = 'On Time' Then 1 else 0 end)*100 /Nullif(Sum(Case when status = 'Delivered' Then 1 else 0 end),0)
as Decimal(5,2)) as On_Time_Percentage,
Cast(Sum(Case when Delivery_Performance = 'Late' Then 1 else 0 end)*100 /Nullif(Sum(case when status ='Delivered' then 1 else 0 end),0)
as Decimal(5,2)) as Late_Percentage,
Cast(Avg(Case when Status = 'Delivered' then Cast(Actual_Days as Decimal(10,2)) end)as Decimal(10,2))as Avg_Delivery_Days
from dbo.vw_Flipkart_Order_Detail;
Go
Select * from dbo.vw_Flipkart_SLA_Summary;

--Next: View 3 — City Performance
--Which cities have the highest order volume, revenue, and delivery problems?
Create View dbo.vw_Flipkart_City_Performance
as 
select city,count(*) as Total_Orders,sum(Order_Value) as Revenue,
Cast(Avg(Cast(Order_Value as decimal(10,2))) as decimal(10,2))as avg_order_value,
sum(Case when status ='Delivered' then 1 else 0 end) as Delivered_Orders,
sum(Case when Delivery_Performance = 'On Time' then 1 else 0 end) as On_Time_Deliveries,
sum(case when Delivery_Performance = 'Late' then 1 else 0 end) as Late_Deliveries,
Cast(sum(Case when delivery_Performance = 'Late' then 1 else 0 end)*100.0/nullif(sum(case when status = 'Delivered'
then 1 else 0 end),0) as Decimal(5,2)) as Late_Percentage 
from dbo.vw_flipkart_Order_Detail group by city;

select * From dbo.vw_Flipkart_City_Performance order by Late_Percentage Desc;

/*alter view dbo.vw_Flipkart_City_Performance
as
select city,count(*) as Total_Orders,sum(Order_Value) as Revenue,
Cast(Avg(Cast(Order_Value as decimal(10,2))) as decimal(10,2))as avg_order_value,
sum(Case when status ='Delivered' then 1 else 0 end) as Delivered_Orders,
sum(Case when Delivery_Performance = 'On Time' then 1 else 0 end) as On_Time_Deliveries,
sum(case when Delivery_Performance = 'Late' then 1 else 0 end) as Late_Deliveries,
Cast(sum(Case when delivery_Performance = 'Late' then 1 else 0 end)*100.0/nullif(sum(case when status = 'Delivered'
then 1 else 0 end),0) as Decimal(5,2)) as Late_Percentage 
from dbo.vw_flipkart_Order_Detail group by city; */ 


-- Which product categories generate the most revenue/orders, and how is their delivery performance?
-- View 4 - Category Performance

create view dbo.vw_Flipkart_Category_Performance
as
select category, Count(*) as Total_Orders,sum(Order_Value) as Revenue,
cast(avg(cast(order_value as decimal(10,2))) as decimal(10,2)) as Avg_order_value,
sum(case when status ='Delivered' then 1 else 0 end) as Delivered_Orders,
sum(case when delivery_performance = 'on time' then 1 else 0 end) as On_time_Deliveries,
sum(case when delivery_performance = 'late' then 1 else 0 end) as late_Deliveries,
cast(sum(case when delivery_performance = 'late' then 1 else 0 end) * 100.0 / nullif(
sum(case when status = 'Delivered' then 1 else 0 end),0) as decimal(5,2)) as Late_Percentage
from dbo.vw_Flipkart_Order_Detail
group by category;
go
select * from dbo.vw_Flipkart_Category_Performance order by Revenue desc;

--View 5 — Customer Segment Performance
--Which customer segment brings the most orders/revenue, and which segment has the biggest delivery problem?

create view dbo.vw_Flipkart_customer_segment_Performance
as 
select Customer_segment, count(*) as Total_Orders,sum(Order_value) as Revenue,
cast(avg(cast(order_value as decimal(10,2)))as decimal(10,2))  as Avg_Order_value,
sum(case when status = 'Delivered' then 1 else 0 end) as Delivered_orders,
sum(case when Delivery_performance ='On Time' then 1 else 0 end) as On_Time_Deliveries,
sum(case when Delivery_performance = 'Late' then 1 else 0 end) as late_Deliveries,
Cast(Sum(Case when Delivery_Performance ='Late' then 1 else 0 end)*100.0 / Nullif(
sum(case when status = 'Delivered' then 1 else 0 end),0) as Decimal(5,2)) as Late_Percentage
from dbo.vw_Flipkart_Order_Detail 
group by Customer_segment;
go

select * from dbo.vw_Flipkart_customer_segment_Performance;

-- View 6 - Delivery Type Performance
create view dbo.vw_Flipkart_Delivery_Type_Performance
as
select delivery_Type,count(*) as Total_Orders,sum(order_Value) as Revenue,
cast(Avg(Cast(Order_Value as decimal(10,2))) as Decimal(10,2)) as Avg_Order_Value,
sum(case when status = 'Delivered' then 1 else 0 end) as Delivered_Orders,
sum(case When Delivery_Performance = 'On Time' Then 1 else 0 end) as On_Time_Deliveries,
sum(case when Delivery_Performance = 'Late' Then 1 else 0 end) as Late_Deliveries,
cast(sum(case when delivery_performance = 'Late' Then 1 Else 0 end)*100.0 / Nullif(sum(case when status = 'Delivered' then 1 else 0 end),0)as decimal(5,2))
as Late_Percentage
from dbo.vw_Flipkart_Order_Detail
group by delivery_Type;
go

select * from dbo.vw_Flipkart_Delivery_Type_Performance;
