1. What is a result set?

The result set is an object that represents a set of data returned from a data source, usually as the result of a query. The result set contains rows and columns to hold the requested data elements.

 

2. What is the difference between Union and Union All?

- Union: It is used to combine the result sets from two or more select statement and only return the unique values
- Union All: It is used to combine the result sets from two or more select statement and can return all the records in each statement including duplicates.

3. What are the other Set Operators SQL Server has?

There are two other Set Operators SQL Server has: INTERSECT, EXCEPT

- INTERCECT is used to fetch distinct records from all the result sets of select statements.
- EXCEPT is used to fetch distinct records only from the first table. It will exclude the records that appears in all tables from the first table.

 

4. What is the difference between Union and Join?

- Join is used to combine the result set of two or more than two tables.

- Union is used to combines the result set of two or more SELECT statements.

- Join will append columns of the result sets together while union will append the rows of the result sets together. So it requires the data type of the columns in the result sets has to be the same or can be converted by SQL implicitly, otherwise, we need to used CAST to convert the data type explicitly. And the sequence of the columns in result sets should be the same.

 

5. What is the difference between INNER JOIN and FULL JOIN?

- Inner join is used to fetch the data from left and right tables which satisfy the join condition.

- Full join is used to fetch data when there is a match in left or right table records.

 

6. What is difference between left join and outer join

- Left join is a type of outer join and it will return all the records in the left table with the data in the right table that matches the join condition.

- Besides left join, there are also right outer join and full outer in outer join.

 

7. What is cross join?

The CROSS JOIN is used to generate a paired combination of each row of the first table with each row of the second table

 

8. What is the difference between WHERE clause and HAVING clause?

- They are both used for filtering the records to display in the result set.

- Where cannot be used with aggregate functions such as SUM, AVG, MIN, MAX, etc., while having is used after group by. Having can filter the records that are calculated by aggregate functions.

 

9. Can there be multiple group by columns?

Yes. We can put two or more columns after group by. Group by will consider the all the rows with the same values in all the columns specified after group by in one group. 