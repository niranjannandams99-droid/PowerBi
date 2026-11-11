--Warehouse Table

use Flipkart_Ecommerce;

Create Table dbo.Fact_Flipkart_Orders
(
    Order_ID          NVARCHAR(50),
    Order_Date        DATETIME2,
    City              NVARCHAR(50),
    Category          NVARCHAR(50),
    Order_Value       INT,
    Status            NVARCHAR(50),
    Delivery_Type     NVARCHAR(50),
    Customer_Segment  NVARCHAR(50),
    Warehouse         NVARCHAR(50),
    Promised_Days     INT,
    Actual_Days       INT,
    SLA_Breached      NVARCHAR(50),
    SLA_Status        NVARCHAR(50)
);
GO
Select Count(*) from dbo.Fact_Flipkart_Orders;

--Duplicate Order IDs
SELECT 
    Order_ID,
    COUNT(*) AS Duplicate_Count
FROM dbo.Fact_Flipkart_Orders
GROUP BY Order_ID
HAVING COUNT(*) > 1;

--NULL check
SELECT
    COUNT(*) AS Total_Rows,
    COUNT(Order_ID) AS Order_ID_Count,
    COUNT(Order_Date) AS Order_Date_Count,
    COUNT(City) AS City_Count,
    COUNT(Category) AS Category_Count,
    COUNT(Order_Value) AS Order_Value_Count
FROM dbo.Fact_Flipkart_Orders;

--Basic business validation
SELECT
    COUNT(*) AS Total_Orders,
    SUM(Order_Value) AS Total_Revenue,
    AVG(Order_Value) AS Avg_Order_Value,
    SUM(CASE WHEN SLA_Breached = 'Yes' THEN 1 ELSE 0 END) AS SLA_Breaches
FROM dbo.Fact_Flipkart_Orders;