using AdventureWorks2019
Go
--1. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter. 
select 
	p.ProductID,
	p.Name,
	p.Color,
	p.ListPrice
from Production.Product p

--2. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, 
--   the rows that are 0 for the column ListPrice
select 
	p.ProductID,
	p.Name,
	p.Color,
	p.ListPrice
from Production.Product p
where p.ListPrice = 0

--3.Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, 
--  the rows that are rows that are NULL for the Color column.
select 
	p.ProductID,
	p.Name,
	p.Color,
	p.ListPrice
from Production.Product p
where p.Color is NULL

--4.Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, 
--  the rows that are not NULL for the Color column.
select 
	p.ProductID,
	p.Name,
	p.Color,
	p.ListPrice
from Production.Product p
where p.Color is NOT NULL

--5.Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, 
--  the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.
select 
	p.ProductID,
	p.Name,
	p.Color,
	p.ListPrice
from Production.Product p
where p.Color is NULL AND p.ListPrice > 0

--6.Generate a report that concatenates the columns Name and Color from the Production.Product table 
--  by excluding the rows that are null for color.
SELECT CONCAT(p.Name,' ', p.Color)
from Production.Product p
where p.Color is not NULL
--7.Write a query that generates the following result set from Production.Product:
--  Name And Color
SELECT CONCAT('NAME: ', p.Name,' -- COLOR: ', p.Color) as 'Name And Color'
from Production.Product p
where p.Color is not NULL

--8.Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500
select 
	p.ProductID,
	p.Name
from Production.Product p
where p.ProductID between 400 and 500 --400 and 500 are included

--9.Write a query to retrieve the to the columns  ProductID, Name and color from the Production.
--  Product table restricted to the colors black and blue
select 
	p.ProductID,
	p.Name,
	p.Color
from Production.Product p
where p.Color in ('black', 'blue');

--10.Write a query to generate a report on products that begins with the letter S. 
select 
	p.Name
from Production.Product p
where p.Name LIKE 'S%'

-- 11.	Write a query that retrieves the columns Name and ListPrice from the Production.Product table. 
-- Your result set should look something like the following. Order the result set by the Name column. 
select
	p.Name,
	p.ListPrice
from Production.Product p 
order by p.Name
-- ordered in the alphabetical ascending order

--12. Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. 
--    The products name should start with either 'A' or 'S'
select
	p.Name,
	p.ListPrice
from Production.Product p
where p.Name LIKE '[A, S]%'
order by p.Name

--13.Write a query so you retrieve rows that have a Name that begins with the letters SPO, 
--   but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column.
select
	p.Name
from Production.Product p
where p.Name LIKE '[S][P][O][^K]%'
order by p.Name
 
--14.Write a query that retrieves unique colors from the table Production.Product. Order the results in descending manner
select
	DISTINCT p.Color	
from Production.Product p
order by p.Color DESC

-- NULL is included

--15.Write a query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Production.Product table. 
--   Format and sort so the result set accordingly to the following. 
--   We do not want any rows that are NULL.in any of the two columns in the result.
select
	DISTINCT p.Color,
	p.ProductSubcategoryID
from Production.Product p
where p.Color is NOT NULL and p.ProductSubcategoryID is Not NULL
order by p.Color DESC


--16.Something is “wrong” with the WHERE clause in the following query. 
--   We do not want any Red or Black products from any SubCategory than those with the value of 1 in column ProductSubCategoryID, 
--   unless they cost between 1000 and 2000.

--17.Write the query in the editor and execute it. Take a look at the result set and then adjust the query so it delivers the following result set.
select
	p.ProductSubcategoryID,
	p.Name,
	p.Color,
	p.ListPrice
from Production.Product p
order by p.ProductSubcategoryID DESC, p.ListPrice DESC
