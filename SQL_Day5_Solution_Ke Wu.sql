--1.	Write an sql statement that will display the name of each customer and the sum of order totals placed by that customer during the year 2002
Use Practice
Go


Create table customer (cust_id int,  iname varchar (50)); 
Create table orders (order_id int,cust_id int,amount money,order_date smalldatetime);

Select 
	c.iname,
	SUM(o.amount) as Total
From Customer c
inner Join orders o on c.cust_id = o.cust_id
where o.Order_Date between '1998-01-01' and '1998-12-31'
Group by c.iname

--2. The following table is used to store information about company’s personnel:
-- write a query that returns all employees whose last names  start with “A”.
Create table person (id int, firstname varchar(100), lastname varchar(100)) 
Select *
From person
where lastname LIKE 'A%';

/*
	3.  The information about company’s personnel is stored in the following table:
	The filed managed_id contains the person_id of the employee’s manager.
	Please write a query that would return the names of all top managers
	(an employee who does not have a manger, and the number of people that report directly to this manager).

*/
Create table persons(person_id int primary key, manager_id int null, name varchar(100)not null) 

Select  
	p2.name as [Top Manager],
	t.Total
FROM persons p2
INNER JOIN (Select m.person_id, COUNT(p.person_id) as Total
FROM persons m
INNER JOIN persons p on m.person_id = p.manager_id
Where m.manager_id IS NULL
Group by m.person_id) t on t.person_id= p2.person_id

-- 4.  List all events that can cause a trigger to be executed.
-- Triggers are automatically fired  on a event (DML Statements like Insert , Delete or Update)
-- Trigger can happen for before or after these statement

/*
	5. Generate a destination schema in 3rd Normal Form.  Include all necessary fact, join, and dictionary tables, 
	   and all Primary and Foreign Key relationships.  The following assumptions can be made:
a. Each Company can have one or more Divisions.
b. Each record in the Company table represents a unique combination 
c. Physical locations are associated with Divisions.
d. Some Company Divisions are collocated at the same physical of Company Name and Division Name.
e. Contacts can be associated with one or more divisions and the address, but are differentiated by suite/mail drop records.status of each association 
   should be separately maintained and audited.
*/



Create Table Divisions
(DivisionID Int primary Key, DivisionName varchar(20), DivisionLocation varchar(20))
Create Table Company 
(CompanyID Int primary key, ComanyName varchar(20), DivisionID int foreign key references Divisions(DivisionID))

Create Table Addresses
(AddressID int Primary Key identity(1,1), 
Create Table Contacts
(ContactID Int primary key identity(1,1), DivisionID int foreign key references Divisions(DivisionID), AddressID int 
