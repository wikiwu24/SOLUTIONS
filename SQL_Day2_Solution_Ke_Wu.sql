USE AdventureWorks2019
GO
--1.	How many products can you find in the Production.Product table?
SELECT COUNT(1)
FROM Production.Product;
/* or we can do */
SELECT COUNT(ProductID)
FROM Production.Product

/*
	2.	Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory.
	    The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
*/
SELECT ProductSubcategoryID, COUNT(1) as Count
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING ProductSubcategoryID is NOT NULL

/*
	3.	How many Products reside in each SubCategory? Write a query to display the results with the following titles.
		ProductSubcategoryID CountedProducts

*/
SELECT ProductSubcategoryID, COUNT(1) as CountedProducts
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING ProductSubcategoryID is NOT NULL

/*
	4.	How many products that do not have a product subcategory. 
*/
SELECT ProductSubcategoryID, COUNT(1) as CountedProducts
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING ProductSubcategoryID is NULL

/*
	5.	Write a query to list the summary of products quantity in the Production.ProductInventory table.
*/
SELECT SUM(p.Quantity)
FROM Production.ProductInventory p

/*
	6. Write a query to list the summary of products in the Production.ProductInventory table 
		and LocationID set to 40 and limit the result to include just summarized quantities less than 100.
              ProductID    TheSum

*/
SELECT ProductID, SUM(Quantity) as TheSum
FROM Production.ProductInventory
where LocationID = 40
group by ProductID
HAVING SUM(Quantity) < 100

/*
	7.	Write a query to list the summary of products with the shelf information in the Production.ProductInventory table and 
		LocationID set to 40 and limit the result to include just summarized quantities less than 100
        Shelf      ProductID    TheSum
*/
SELECT Shelf, ProductID, SUM(Quantity) as TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
Group By Shelf, ProductID
HAVING SUM(Quantity) < 100

/*
	8.	Write the query to list the average quantity for products where column LocationID has the value of 10 
		from the table Production.ProductInventory table.
*/
SELECT AVG(Quantity) as TheAVG
FROM Production.ProductInventory
WHERE LocationID = 10

/*
	9.	Write query to see the average quantity of products by shelf from the table Production.ProductInventory
		ProductID    Shelf      TheAvg

*/
SELECT ProductID, Shelf, AVG(Quantity) as TheAvg
FROM Production.ProductInventory
Group By Shelf, ProductID

/*
	10.	Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory
		ProductID   Shelf      TheAvg

*/
SELECT ProductID, Shelf, AVG(Quantity) as TheAvg
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
Group By Shelf, ProductID

/*
	11.	List the members (rows) and average list price in the Production.Product table. 
		This should be grouped independently over the Color and the Class column. 
		Exclude the rows where Color or Class are null.
        Color   Class 	TheCount   	AvgPrice
*/
SELECT Color
	   ,Class
	   ,COUNT(1) as TheCount
	   ,AVG(ListPrice) as AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color,Class

/*
	12.	Write a query that lists the country and province names from person. 
		CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following. 
			Country                   Province
		---------                ----------------------

*/
SELECT 
	c.Name as Country
	,s.Name as Province
FROM person.StateProvince s
INNER JOIN person.CountryRegion c on c.CountryRegionCode = s.CountryRegionCode
Order by Country

/*
	13.	Write a query that lists the country and province names from person. CountryRegion and person. 
		StateProvince tables and list the countries filter them by Germany and Canada. 
		Join them and produce a result set similar to the following.
*/
SELECT 
	c.Name as Country
	,s.Name as Province
FROM person.StateProvince s
INNER JOIN person.CountryRegion c on c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name in ('Germany', 'Canada')  -- We cannot use alias in the where clause
Go

Use Northwind
Go

/*
	14.	List all Products that has been sold at least once in last 25 years.
	-- This means we can select the products that has occur in the orders
	-- We can use inner join to achieve that.
*/
SELECT 
	 --o.OrderID
	 o.OrderDate
	,od.ProductID
	,p.ProductName
FROM Orders o
INNER JOIN [Order Details] od on o.OrderID = od.OrderID
INNER JOIN Products p on p.ProductID = od.ProductID
WHERE o.OrderDate >= '1996-01-01'

/*
	15.	List top 5 locations (Zip Code) where the products sold most.
*/
-- In my solution, I exclude the records where the Zip Code is null
SELECT TOP 5
	o.ShipPostalCode
	,COUNT(1) as numberOfProducts
FROM Orders o
INNER JOIN [Order Details] od on o.OrderID = od.OrderID
GROUP BY o.ShipPostalCode
HAVING o.ShipPostalCode IS NOT NULL
ORDER BY COUNT(1) DESC 

/*
	16.	List top 5 locations (Zip Code) where the products sold most in last 20 years.
*/
-- There is no valid records in the result set  
SELECT TOP 5
	o.ShipPostalCode
	,COUNT(1) as numberOfProducts
FROM Orders o
INNER JOIN [Order Details] od on o.OrderID = od.OrderID
WHERE o.OrderDate >= '2001-01-01'
GROUP BY o.ShipPostalCode
HAVING o.ShipPostalCode IS NOT NULL
ORDER BY COUNT(1) DESC 

/*
	17. List all city names and number of customers in that city.     
*/

SELECT 
	City
	, COUNT(1) as numberOFCustomers
FROM Customers
GROUP BY City

/*
	18.	List city names which have more than 10 customers, and number of customers in that city 
*/
SELECT 
	City
	, COUNT(1) as numberOFCustomers
FROM Customers
GROUP BY City
HAVING COUNT(1) > 10

/*
	19.	List the names of customers who placed orders after 1/1/98 with order date.
*/
SELECT 
	 c.ContactName,
	 o.OrderDate
FROM Customers c
INNER JOIN Orders o on o.CustomerID = c.CustomerID
WHERE OrderDate > '1998-01-01'

/*
	20.	List the names of all customers with most recent order dates 
*/

SELECT 
	 c.ContactName,
	 MIN(o.OrderDate)
FROM Customers c
INNER JOIN Orders o on o.CustomerID = c.CustomerID
GROUP BY c.ContactName
Order by c.ContactName


/*
	21.	Display the names of all customers along with the count of products they bought 
*/
SELECT 
	 c.ContactName,
	 COUNT(1) as numberOfProducts
FROM Customers c
INNER JOIN Orders o on o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od on od.OrderID = o.OrderID
GROUP BY ContactName
Order by ContactName

/*
	22.	Display the customer ids who bought more than 100 Products with count of products.
*/
SELECT 
	 c.CustomerID,
	 COUNT(1) as numberOFOrders
FROM Customers c
INNER JOIN Orders o on o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od on od.OrderID = o.OrderID
GROUP BY c.CustomerID
HAVING COUNT(1) > 100
Order by c.CustomerID


/*
	23.	List all the possible ways that suppliers can ship their products. Display the results as below
			Supplier Company Name   	                   Shipping Company Name
		---------------------------------            ----------------------------------
		Solution: We can find the possible ways by searching the shipper used by suppliers in the orders
*/
SELECT 
    DISTINCT
	s.CompanyName as 'Supplier Company Name',
	/*p.SupplierID,
	od.OrderID,
	o.ShipVia,*/
	sh.CompanyName as 'Shipping Company Name'
FROM Products p
INNER JOIN Suppliers s on s.SupplierID = p.SupplierID
INNER JOIN [Order Details] od on od.ProductID = p.ProductID
INNER JOIN Orders o on o.OrderID = od.OrderID
INNER JOIN Shippers sh on sh.ShipperID = o.ShipVia

/*
	24.	Display the products order each day. Show Order date and Product Name.
*/
SELECT 
	 o.OrderDate
	,p.ProductName
	
FROM Products p
INNER JOIN [Order Details] od on od.ProductID = p.ProductID
INNER JOIN Orders o on o.OrderID = od.OrderID
ORDER BY OrderDate

/*
	25.	Displays pairs of employees who have the same job title.

*/
SELECT 
	 DISTINCT
	 e.FirstName
	 ,m.FirstName
	 ,e.Title
FROM Employees e
INNER JOIN Employees m on m.Title = e.title
WHERE e.EmployeeID != m.EmployeeID

SELECT Em1.LastName, Em1.FirstName, Em2.LastName, Em2.FirstName, Em1.Title
FROM Employees Em1, Employees Em2
WHERE Em1.Title = Em2.Title
	AND Em1.EmployeeID < Em2.EmployeeID

select Distinct em1.FirstName as 'EmPair1' , em2.FirstName AS 'EmPair2'
From Employees em1 Inner Join Employees em2
on em1.Title=em2.Title and
 em1.EmployeeID < em2.EmployeeID

/*
	26.	Display all the Managers who have more than 2 employees reporting to them.
*/
SELECT 
	 m.FirstName as Manager
	 ,COUNT(1)
FROM Employees e
Left JOIN Employees m on m.EmployeeID = e.ReportsTo
Group by m.FirstName
HAVING m.FirstName IS NOT NULL AND COUNT(1) > 2

/*
	27.	Display the customers and suppliers by city. The results should have the following columns
		City 
		Name 
		Contact Name,
		Type (Customer or Supplier)
*/

SELECT 
	City
	,CompanyName as Name
	,ContactName
	,Type = 'Customer'
FROM Customers 
UNION
SELECT 
	City
	,CompanyName as Name
	,ContactName
	,Type = 'Supplier'
FROM Suppliers 
order by City

-- 28. Have two tables T1 and T2
--F1.T1	F2.T2
--1	2
--2	3
--3	4

--Please write a query to inner join these two tables and write down the result of this query.
-- 29. Based on above two table, Please write a query to left outer join these two tables and write down the result of this query.
/*
Inner Join Query
Select F1.T1
FROM T1 t
INNER JOIN T2 m on t.F1.T1 = m.F2.T2

Result should be:
F1.T1	
 2	
 3	

Left Outer Join:
Select F1.T1
FROM T1 t
Left Outer JOIN T2 m on t.F1.T1 = m.F2.T2

result should be:
F1.T1  F2.T2	
 1	    NULL
 2	     2
 3       3
*/


