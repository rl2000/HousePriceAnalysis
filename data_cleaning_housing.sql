

/****Dataset: 
This dataset was downloaded from Office for National Statistics, UK . 
This dataset is about Understanding towns in England and Wales: house price analysis.
It is available on Table_1a: Median price of all residential properties in towns and cities. England and Wales 1995 -2020.

Excel Cleaning: Top few rows were deleted in excel.

Initial Imports:
This dataset was imported using SQL Server Import and Export interface and loaded into a newly created database 
called Housepriceanalysis on SQL Server.

****/

CREATE DATABASE Housepriceanalysis;
USE Housepriceanalysis;



SELECT * FROM dbo.MedianPrice; --View table.

/****Data Cleaning : Dropping columns not required, changing column names, finding nulls and deleting nulls, seperating Codes from town names. ****/

/****Dropping columns not required.****/

ALTER TABLE dbo.MedianPrice
DROP COLUMN [1995], [1996], [1997], [1998], [1999], [2000], [2001], 
			[2002], [2003], [2004], [2005], [2006], [2007], [2008], [2009], [2010], 
			[2011],[2012],[2013],[2014];

ALTER TABLE dbo.MedianPrice
DROP COLUMN [Percentage Change from 2000 to 2010],[Percentage Change from 2010 to 2020] ;


/****Changing column names.****/

EXEC sp_rename 'dbo.MedianPrice.TOWN11CD', 'Town_Id', 'COLUMN';
EXEC sp_rename 'dbo.MedianPrice.TOWN11NM', 'Town_name', 'COLUMN';
EXEC sp_rename 'dbo.MedianPrice.Settlement Type', 'Settlement_type', 'COLUMN';
EXEC sp_rename 'dbo.MedianPrice.Region / Country', 'Region_County', 'COLUMN';

/****Finding Null Values****/

SELECT  [Town_Id]
FROM dbo.MedianPrice
WHERE [Town_Id] IS NULL; --12 towns_ids are null

SELECT  [2016] -- --12 items are null
FROM dbo.MedianPrice
WHERE [2016] IS NULL;

/****DROPPING NULLS****/

DELETE FROM dbo.MedianPrice
where [Town_Id] IS NULL; --12 rows deleted

/****Checking for any NULLS again***/

SELECT [Town_Id]
      ,[Town_name]
      ,[Settlement_type]
      ,[Region_County]
      ,[2015]
      ,[2016]
      ,[2017]
      ,[2018]
      ,[2019]
      ,[2020]
  FROM dbo.MedianPrice
  WHERE [2015] IS NULL; --there are no null values.


/****Seperate Codes from town names.****/

UPDATE dbo.MedianPrice
SET Town_name = REPLACE(Town_name, 'BUASD','') ;

UPDATE dbo.MedianPrice
SET Town_name = REPLACE(Town_name, 'BUA','') ;



/****Data Exploration****/

/****How many regions are available.****/

SELECT Region_County, COUNT(*) AS Numberofregions
FROM dbo.MedianPrice
GROUP BY Region_County; ----10 regions



/****Using regions: North East (71), find the average median house price.****/

SELECT 
      CAST(AVG([2020])AS INT) AS AverageMedianHousePrice
FROM dbo.MedianPrice
Where Region_County = 'North East' ; 

/****Using regions: North West (171), find the average median house price.****/

SELECT 
      CAST(AVG([2020])AS INT) AS AverageMedianHousePrice
FROM dbo.MedianPrice
Where Region_County = 'North West' ; 


/****Using regions: South East (215), find the average median house price.****/
SELECT 
      CAST(AVG([2020])AS INT) AS AverageMedianHousePrice
FROM dbo.MedianPrice
Where Region_County = 'South East'; 

/****Using regions: Wales (105), find the average median house price.****/

SELECT 
      CAST(AVG([2020])AS INT) AS AverageMedianHousePrice
FROM dbo.MedianPrice
Where Region_County = 'Wales' ; 

/****Using regions: London(33), find the average median house price.****/

SELECT 
      CAST(AVG([2020])AS INT) AS AverageMedianHousePrice
FROM dbo.MedianPrice
Where Region_County = 'London' ; 

/****Using regions: South West (138), find the average median house price.****/

SELECT 
      CAST(AVG([2020])AS INT) AS AverageMedianHousePrice
FROM dbo.MedianPrice
Where Region_County = 'South West' ;

/****Using regions: West Midlands(92), find the average median house price.****/

SELECT 
      CAST(AVG([2020])AS INT) AS AverageMedianHousePrice
FROM dbo.MedianPrice
Where Region_County = 'West Midlands' ; 

/****Using regions: East of England(150), find the average median house price.****/

SELECT 
      CAST(AVG([2020])AS INT) AS AverageMedianHousePrice
FROM dbo.MedianPrice
Where Region_County = 'East of England' ; 

/****Using regions: East Midlands(132), find the average median house price.****/

SELECT 
      CAST(AVG([2020])AS INT) AS AverageMedianHousePrice
FROM dbo.MedianPrice
Where Region_County = 'East Midlands' ; 

/****Using regions: Yorkshire and the Humber (121), find the average median house price.****/

SELECT 
      CAST(AVG([2020])AS INT) AS AverageMedianHousePrice
FROM dbo.MedianPrice
Where Region_County = 'Yorkshire and the Humber' ; 

-------------THE END-----------------------------------------------------------------------------





