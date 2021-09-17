--1.List all cities that have both Employees and Customers.
-- No dupilicates and the answers are sorted
SELECT DISTINCT CITY 
FROM Customers
WHERE City IN (SELECT CITY FROM Employees)
	

--2.	List all cities that have Customers but no Employee.
--a.	Use sub-query
SET STATISTICS IO ON
SELECT DISTINCT CITY 
FROM Customers
WHERE City NOT IN (SELECT CITY FROM Employees)

--b.	Do not use sub-query
SELECT CITY
FROM Customers
INTERSECT
SELECT CITY
FROM
Employees;


--3.List all products and their total order quantities throughout all orders
SELECT c.CustomerID,
	  (SELECT 
			  COUNT(o.CustomerID) as 'Total' 
	   FROM Orders O WHERE c.CustomerID = o.CustomerID Group By o.CustomerID)
FROM Customers c

--4.List all Customer Cities and total products ordered by that city.
Select c.city, COUNT(1) as 'Total'
FROM Orders o INNER JOIN Customers c 
on c.CustomerID = o.CustomerID 
Group By c.City

--5.List all Customer Cities that have at least two customers.
--a.Use union
SELECT DISTINCT City
FROM Customers
WHERE City in
(SELECT
	City
FROM Customers 
Group by City
HAVING COUNT(1) >=2)


--b.Use sub-query and no union
SELECT DISTINCT City
FROM Customers
WHERE City in
(SELECT
	City
FROM Customers 
Group by City
HAVING COUNT(1) >=2)


-- 6.List all Customer Cities that have ordered at least two different kinds of products.
Select 
	c.City,
	COUNT(od.ProductID)
FROM Customers c
INNER JOIN Orders o 
on o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od
on od.OrderID = o.OrderID
Group By c.City
HAVING COUNT(od.ProductID) >= 2

--7.List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.
SELECT 
	DISTINCT
	c.CustomerID
	,c.CompanyName
	,c.City
	,o.ShipCity
FROM Customers c
INNER JOIN Orders o on o.CustomerID = c.CustomerID
WHERE c.City != o.ShipCity

-- 8.List 5 most popular products, their average price, and the customer city that ordered most quantity of it.

WITH MostPopular
-- productID 
as(
	SELECT TOP 5
		p.ProductID,
		COUNT(p.ProductID) as 'Total'
	FROM Products p
	INNER JOIN [Order Details] od on p.ProductID = od.ProductID
	Group By p.ProductID
	Order By COUNT(p.ProductID) DESC
),TopCity
as(
Select mp.ProductID,  c.city, SUM(od.Quantity) as Q, RANK()OVER(PARTITION BY mp.ProductID ORDER BY SUM(od.Quantity) DESC) as 'Rank' 
FROM [Order Details] od
INNER JOIN MostPopular mp on od.ProductID = mp.ProductID
INNER JOIN Orders o on o.OrderID = od.OrderID
INNER JOIN Customers c on c.CustomerID = o.CustomerID
GROUP BY mp.ProductID,c.city)
SELECT t.ProductID, t.City,t.Q as Quantity
from TopCity t
where t.Rank = 1

--  9.	List all cities that have never ordered something but we have employees there.
--  a.	Use sub-query
SELECT e.City
FROM Employees e
WHERE e.City in
	(SELECT c.City
	FROM Customers c
	LEFT JOIN Orders o on c.CustomerID = o.CustomerID 
	where o.OrderID IS NULL)

--  b.	Do not use sub-query
-- Use JOIN
SELECT e.City
FROM Employees e
INNER JOIN (SELECT c.City
	FROM Customers c
	LEFT JOIN Orders o on c.CustomerID = o.CustomerID 
	where o.OrderID IS NULL) as cs on cs.City = e.City;



/*
	10.	List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, 
	    and also the city of most total quantity of products ordered from. (tip: join  sub-query)
*/
SELECT TOP 1
	e.City,
	COUNT(OrderID) as 'Total',
	'Type'= 'Most Sold City'
FROM Orders o
INNER JOIN Employees e 
on e.EmployeeID = o. EmployeeID
GROUP BY e.city
ORDER BY COUNT(OrderID) DESC
UNION
SELECT Top 1
	c.City,
	SUM(od.Quantity) as 'Total',
	'Type' = 'Most Order City'
FROM Orders o
INNER JOIN [Order Details] od on od.OrderID = o.OrderID
INNER JOIN Customers c on c.CustomerID = o.CustomerID
Group by c.City
Order by SUM(od.Quantity) DESC







--11. How do you remove the duplicates record of a table?

/*
	12. Sample table to be used for solutions below- 
    Employee ( empid integer, mgrid integer, deptid integer, salary integer) Dept (deptid integer, deptname text)
    Find employees who do not manage anybody.
*/
--SELECT m.EmpID as Manager,e.EmpID as Employee
--FROM Employee m
--LEFT JOIN Employee e on m.EmpID = e.mrgID
--WHERE e.EmpID IS NULL

/*
	13. Find departments that have maximum number of employees. 
	    (solution should consider scenario having more than 1 departments that have maximum number of employees). 
	    Result should only have - deptname, count of employees sorted by deptname.
*/
--SELECT TOP 1
--	deptnamne,
--	COUNT(1) as 'numberOfEMp'
--FROM Dept d
--LEFT JOIN Employee e on e.deptid = d.deptid
--group by deptname
--order by COUNT(1) DESC

/*
	14. Find top 3 employees (salary based) in every department. 
	    Result should have deptname, empid, salary sorted by deptname and then employee with high to low salary.
*/
-- MAX() will only return one of the maximum value
-- We can solve this by using subquery or join
-- use sub query
--SELECT *
--FROM Employee e
--LEFT JOIN Dept d on d.depid = e.depid



