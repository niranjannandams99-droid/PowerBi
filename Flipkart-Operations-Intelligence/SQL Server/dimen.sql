use Flipkart_Ecommerce;
CREATE TABLE Dim_Date
(   DateKey INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    Year INT,
    QuarterName VARCHAR(10),
    MonthNumber INT,
    MonthName VARCHAR(20),
    DayNumber INT,
    DayName VARCHAR(20),
    WeekNumber INT
);

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;

SELECT
    @StartDate = MIN(CAST(Order_Date AS DATE)),
    @EndDate   = MAX(CAST(Order_Date AS DATE))
FROM Fact_Flipkart_Orders;

;WITH DateSeries AS
(
    SELECT @StartDate AS FullDate

    UNION ALL

    SELECT DATEADD(DAY, 1, FullDate)
    FROM DateSeries
    WHERE FullDate < @EndDate
)
INSERT INTO Dim_Date
(
    DateKey,
    FullDate,
    Year,
    QuarterName,
    MonthNumber,
    MonthName,
    DayNumber,
    DayName,
    WeekNumber
)
SELECT
    CONVERT(INT, CONVERT(VARCHAR(8), FullDate, 112)) AS DateKey,
    FullDate,
    YEAR(FullDate),
    'Q' + CAST(DATEPART(QUARTER, FullDate) AS VARCHAR(1)),
    MONTH(FullDate),
    DATENAME(MONTH, FullDate),
    DAY(FullDate),
    DATENAME(WEEKDAY, FullDate),
    DATEPART(WEEK, FullDate)
FROM DateSeries
OPTION (MAXRECURSION 0);

SELECT * FROM Dim_Date ORDER BY FullDate;

SELECT * FROM Fact_Flipkart_Orders;

--Dim_City

CREATE TABLE Dim_City
(
    CityKey INT IDENTITY(1,1) PRIMARY KEY,
    City VARCHAR(100) NOT NULL
);

Insert into Dim_City (City)
select Distinct City from Fact_Flipkart_Orders where City is Not Null;

Select * From Dim_City;

--Dim_Category
create table Dim_Category
(
    CategoryKey Int Identity(1,1) Primary Key,
    Category Varchar(100) Not Null
    );


Insert into Dim_Category(category)
select Distinct Category from Fact_Flipkart_Orders where category is not null;


    select * from Dim_Category;



--Dim status

create table Dim_Status
(
    statuskey int identity(1,1) Primary Key,
    status varchar(50) not null
);

insert into Dim_Status(status)
select distinct status from Fact_Flipkart_Orders where status is not null;

select * from Dim_Status;

-- Fact Table changes
ALTER TABLE Fact_Flipkart_Orders
ADD DateKey INT,
    CityKey INT,
    CategoryKey INT,
    StatusKey INT;

--Join and filling the Datekey
update F set Datekey = D.Datekey from Fact_Flipkart_Orders as F Join Dim_Date as D
on Cast(F.Order_Date as date) = D.FullDate;

--CityKey.
update F set Citykey = D.Citykey from Fact_Flipkart_Orders as F join Dim_City as D
on F.City = D.City;

--CategoryKey
Update F Set CategoryKey = D.CategoryKey from Fact_Flipkart_Orders as F Join Dim_Category as D
on F.Category = D.Category;

-- StatusKey
Update F set StatusKey =D.Statuskey from Fact_Flipkart_Orders as F join Dim_Status as D 
on F.status = D.status;

select top 10 * from Fact_Flipkart_Orders;

