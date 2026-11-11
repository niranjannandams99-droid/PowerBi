use flipkart_ecommerce;
select count(*) from dbo.[SQL Server Destination] ;

select top 10 * from dbo.[SQL Server Destination];

select column_name, Data_Type from INFORMATION_SCHEMA.COLUMNS
where TABLE_SCHEMA ='dbo'
and
TABLE_NAME = 'Sql Server Destination'
order by ORDINAL_POSITION;

