--Company has diverse offices in several countries, which manage and co-ordinate the project of that country.
--Head office has a unique name, city, country, address, phone number and name of the director.
--Every head office manages a set of projects with Project code, title, project starting and end date, 
--assigned budget and name of the person in-charge. One project is formed by the set of operations that can affect to several cities.
--We want to know what actions are realized in each city storing its name, country and number of inhabitants.


CREATE TABLE Employees
(Name nvarchar(20) PRIMARY KEY, Title nvarchar(20))

CREATE TABLE Operations
(OpID INT PRIMARY KEY, Comments nvarchar(200))

CREATE TABLE Cities
(CityId INT PRIMARY KEY, CityName nvarchar(20), NumberOfInhabitants INT)

--Create Junction Table to store the relationship between cities and Operations
CREATE TABLE OperationDetails
(ID INT PRIMARY KEY, 
 OpID INT Foreign Key REFERENCES Operations(OpID),
 CityID INT Foreign Key REFERENCES Cities(CityID))


CREATE TABLE PROJECTS
(ProjectCode nvarchar(20), Title nvarchar(20), StartingDate DateTime, EndDate DateTime, Budget Decimal Check(Budget >= 0.0), 
 PersonInCharge nvarchar(20) Foreign Key REFERENCES Employees(Name),
 OpID INT Foreign Key REFERENCES Operations(OpID))

 CREATE Table Offices
 (OfficeName nvarchar(50) PRIMARY KEY, City nvarchar(20), Country nvarchar(20), PhoneNumber nvarchar(20),
  Director nvarchar(20) Foreign Key REFERENCES Employees(Name))
--  2.	Design a database for a lending company which manages lending among people (p2p lending)
--Lenders that lending money are registered with an Id, name and available amount of money for the financial operations. 
--Borrowers are identified by their id and the company registers their name and a risk value depending on their personal situation.
--When borrowers apply for a loan, a new loan code, the total amount, the refund deadline, the interest rate and its purpose are stored in database. 
--Lenders choose the amount they want to invest in each loan. A lender can contribute with different partial amounts to several loans.

USE Load
GO



CREATE TABLE Borrowers
(BorrowerID INT Primary Key, Name nvarchar(20), CompanyName nvarchar(50), RiskValue decimal(3,1))

CREATE TABLE Lenders
(LenderId INT Primary Key, Name nvarchar(20), AvailableAmount Decimal CHECK(AvailableAmount >= 0))

CREATE TABLE Loans
(Code INT Primary Key, 
 BrorowerID INT Foreign Key REFERENCES Borrowers(BorrowerID), 
 TotalAmount Decimal CHECK(TotalAmount >= 0),
 RefundDeadLine DATETIME,
 InterestRate Decimal,
 Purpose nvarchar(200))

CREATE TABLE LoansDetails
(ID INT Primary Key, 
LoansCode INT Foreign Key References Loans (Code),
LenderID INT Foreign Key REFERENCES Lenders(LenderID),
Amount Decimal)

--3.	Design a database to maintain the menu of a restaurant.
--Each course has its name, a short description, photo and final price.
--Each course has categories characterized by their names, short description, name of the employee in-charge of them.
--Besides the courses some recipes are stored. They are formed by the name of their ingredients, 
--the required amount, units of measurements and the current amount in the store.
USE Restaurant
GO


CREATE TABLE Employees
(EmployeeName nvarchar(20) Primary Key, PhoneNumber nvarchar(20));
Create TABLE Categories
(CategoryID INT Primary Key, Name nvarchar(20), Description ntext, EmployeeName nvarchar(20) Foreign Key References Employees(EmployeeName))
CREATE TABLE Courses
(CourseID INT Primary Key, Description ntext, Photo image, Price decimal,CategoryID INT Foreign Key References Categories(CategoryID));
CREATE TABLE Ingredients
(IngredientID INT Primary Key, Amount Decimal CHECK(Amount >= 0), UnitOfMeasurement nvarchar(20)); 
CREATE TABLE Recipes 
(RecipeID INT, 
IngredientID INT Foreign Key References Ingredients(IngredientID), 
Amount decimal Check(Amount >= 0), 
UnitOfMeasurement nvarchar(20),
PRIMARY KEY(RecipeID, IngredientID)) 


