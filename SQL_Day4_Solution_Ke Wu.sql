USE Northwind
GO

/*
	1.	Lock tables Region, Territories, EmployeeTerritories and Employees. 
	    Insert following information into the database. In case of an error, no changes should be made to DB.
	a.	A new region called “Middle Earth”;
	b.	A new territory called “Gondor”, belongs to region “Middle Earth”;
	c.	A new employee “Aragorn King” who's territory is “Gondor”.
*/

Select *
FROM Region, Territories, EmployeeTerritories , Employees
WITH (HOLDLOCK);
SELECT * FROM Region

SELECT * FROM Territories
SELECT e.EmployeeID,e.FirstName,e.LastName FROM Employees e
SELECT * FROM EmployeeTerritories


--a.	A new region called “Middle Earth”;
--b.	A new territory called “Gondor”, belongs to region “Middle Earth”;
--c.	A new employee “Aragorn King” who's territory is “Gondor”.

Begin Transaction
   Begin
   INSERT INTO Region VALUES(5,'Middle Earth');
   INSERT INTO Territories VALUES(11234,'Gondor','5');
   INSERT INTO Employees(FirstName,LastName) Values('Aragon', 'King');
   INSERT INTO EmployeeTerritories Values(@@IDENTITY,11234);
   END 
Go

/*
	2.	Change territory “Gondor” to “Arnor”.
*/
BEGIN
   UPDATE Territories
   SET TerritoryDescription = 'Arnor'
   WHERE TerritoryID = 11234
END

/*
	3.	Delete Region “Middle Earth”. (tip: remove referenced data first) 
	    (Caution: do not forget WHERE or you will delete everything.) 
		In case of an error, no changes should be made to DB. Unlock the tables mentioned in question 1.
*/

BEGIN
	DELETE FROM EmployeeTerritories
	WHERE TerritoryID = 11234;
	DELETE FROM Territories
	WHERE TerritoryID =11234;
	DELETE FROM Region
	WHERE RegionID = 5
END
ROLLBACK Transaction;

--select   request_session_id   spid,OBJECT_NAME(resource_associated_entity_id) Territories
--from   sys.dm_tran_locks where resource_type='OBJECT'

/*
	4.Create a view named “view_product_order_[your_last_name]”, 
	  list all products and total ordered quantity for that product.
*/
Create VIEW view_product_order
as
Select 
  p.ProductID,
  SUM(od.Quantity) as Total
FROM Products p
INNER JOIN [Order Details] od on od.ProductID = p.ProductID
Group By p.ProductID

/*5.	Create a stored procedure “sp_product_order_quantity_[your_last_name]” that accept product id as an input 
    and total quantities of order as output parameter.*/
-- We cannot select columns other than the value we want to return
Create Procedure sp_product_order_quantity 
@Pid Int,
@TotalQ Int out
as
Begin
Select 
  @TotalQ = SUM(od.Quantity) 
FROM Products p
INNER JOIN [Order Details] od on od.ProductID = p.ProductID
where p.ProductID = @Pid
End

-- Use the procedure and collect the return value
declare @TotalQuantity int
exec sp_product_order_quantity 2, @TotalQuantity out
PRINT @TotalQuantity

/*
	6.	Create a stored procedure “sp_product_order_city_[your_last_name]” 
	    that accept product name as an input and top 5 cities that ordered most 
		that product combined with the total quantity of that product ordered from that city as output.
*/

Select p.ProductName
FROM Products p
where p.ProductID = 1;


Create Procedure sp_product_order_city
@PName varchar(20)
as
Begin
Select TOP 5
	c.City,
	Sum(od.Quantity) 
From 
	Products p	
INNER JOIN [Order Details] od on od.ProductID = p.ProductID
INNER JOIN Orders o on o.OrderID = od.OrderID
INNER JOIN Customers c on c.CustomerID = o.CustomerID
Where p.ProductName= @PName
Group By c.City
Order by Sum(od.Quantity) DESC
END

exec sp_product_order_city 'Chai'

/*
	7.	Lock tables Region, Territories, EmployeeTerritories and Employees. 
		Create a stored procedure “sp_move_employees_[your_last_name]” that automatically find all employees in territory “Tory”; 
	    if more than 0 found, insert a new territory “Stevens Point” of region “North” to the database, 
		and then move those employees to “Stevens Point”.
*/
Begin transaction
Create Proc sp_move_employees_wu
As
Begin
	
	declare @number int 
	set @number = 
		(select
			COUNT(e.EmployeeID)
		FROM Employees e
		INNER JOIN EmployeeTerritories et on et.EmployeeID = e.EmployeeID 
		INNER JOIN Territories t on t.TerritoryID = et.TerritoryID
		WHERE t.TerritoryDescription = 'Tory')
		
	 print(@number)
	 if(@number > 0)
		--INSERT INTO Region Values(5,'North');
		INSERT INTO Territories Values(99999,'Stevens Point',3);
		UPDATE EmployeeTerritories SET TerritoryID = 99999 where EmployeeID in
		(select
			e.EmployeeID
		FROM Employees e
		INNER JOIN EmployeeTerritories et on et.EmployeeID = e.EmployeeID 
		INNER JOIN Territories t on t.TerritoryID = et.TerritoryID
		where t.TerritoryDescription = 'Tory')	
	
END
--Drop Proc sp_move_employees_wu
exec sp_move_employees_wu
rollback transaction

/*
	9.	Create 2 new tables “people_your_last_name” “city_your_last_name”. 
		City table has two records: {Id:1, City: Seattle}, {Id:2, City: Green Bay}. 
		People has three records: {id:1, Name: Aaron Rodgers, City: 2}, {id:2, Name: Russell Wilson, City:1}, {Id: 3, Name: Jody Nelson, City:2}. 
		Remove city of Seattle. If there was anyone from Seattle, put them into a new city “Madison”. Create a view “Packers_your_name” lists all people from Green Bay. 
	    If any error occurred, no changes should be made to DB. (after test) Drop both tables and view.
*/
USE Practice
Go
Create Table City
(ID int primary key, CityName varchar(20))
Create Table People
(
	Id int Primary Key, Name varchar(20), City Int Foreign Key References City(ID)
)
INSERT INTO City Values
(1, 'Seattle'),
(2, 'Green Bay')

INSERT INTO People Values
(1, 'Aaron Rodgers', 2),
(2, 'Russell Wilson', 1),
(3, 'Jody Nelson',2)

Select * from City
Select * From People

Create View Packers 
AS 
Select 
	p.Id,p.Name
FROM People p
INNER JOIN City c on c.ID = p.City
WHERE c.CityName = 'Green Bay';

INSERT INTO City VALUES(3, 'Madision');
Create Procedure SP_Count_Seattle
@Number INT out
As
Begin
	Select @Number = COUNT(1) FROM People p INNER JOIN City c on c.ID = p.City where c.CityName = 'Seattle'
END


Begin
	Declare @Number Int
	EXEC SP_Count_Seattle @Number OUT
	PRINT @Number
	if(@Number > 0)
		UPDATE People SET CITY = 3 WHERE CITY = 1
END

DELETE FROM City  where CityName = 'Seattle'
DROP TABLE PEOPLE
DROP TABLE CITY
DROP PROCEDURE SP_Count_Seattle

/*
	10.  Create a stored procedure “sp_birthday_employees_[you_last_name]” that creates a new table “birthday_employees_your_last_name” and 
		fill it with all employees that have a birthday on Feb. 
		(Make a screen shot) drop the table. Employee table should not be affected.
*/


CREATE Procedure sp_birthday
As
Begin
	CREATE TABLE birthday_employees(ID int Primary Key, Name varchar(20), BirthDate datetime)
	INSERT INTO birthday_employees
	SELECT e.EmployeeID, CONCAT(e.FirstName,' ', e.LastName), e.BirthDate  FROM Northwind.dbo.Employees e where MONTH(e.BirthDate) = 2
	Select * FROM birthday_employees
END
EXEC sp_birthday

DROP Procedure sp_birthday
DROP TABLE birthday_employees

/*
	11.	Create a stored procedure named “sp_your_last_name_1” that returns all cites that have at least 2 customers who have bought no or only one kind of product.
	    Create a stored procedure named “sp_your_last_name_2” that returns the same but using a different approach. (sub-query and no-sub-query).
*/
use Northwind
Go
Select 
	c.CustomerID,
	COUNT(od.ProductID) as Total
FROM Customers c 
LEFT Join orders o on o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od on od.OrderID = o.OrderID
Group By c.CustomerID
HAVING COUNT(od.ProductID) < 1

-- COUNT(ColumnName can consider null as 0)
Create Procedure sp_City1
As
Begin
Select  
	c.City,COUNT(t.CustomerID) as Customer
FROM Customers c
INNER JOIN (Select 
	c.CustomerID,
	COUNT(ProductID) AS TOTAL
FROM Customers c 
LEFT Join orders o on o.CustomerID = c.CustomerID
Left JOIN [Order Details] od on od.OrderID = o.OrderID
Group By c.CustomerID
Having COUNT(ProductID) <=1) t on t.CustomerID = c.CustomerID
Group By c.City
HAVING COUNT(t.CustomerID) >= 2
END










