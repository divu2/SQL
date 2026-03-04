#### Q1. What is a Common Table Expression (CTE), and how does it improve SQL query readability ? 
# A Common Table Expression (CTE) is a temporary result set in SQL that is defined using the WITH clause and can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement.
##It exists only during the execution of the query and helps in breaking complex queries into smaller, more understandable parts.
### How CTE improves readability:
# Simplifies complex queries – Large queries can be divided into smaller logical sections.
#Improves clarity – Makes the query easier to read and understand.
# Reusability within query – The CTE can be referenced multiple times in the same query.
# Better alternative to subqueries – More readable than deeply nested subqueries.
# Easier debugging and maintenance – Logical separation makes modifications simple. 
# Example 
use subquery_ass;
select * from subquery_ass.employee;
WITH MaxSalary AS 
(SELECT MAX(salary) AS HighestSalary
    FROM subquery_ass.employee)
SELECT *FROM MaxSalary;

## Q2. Why are some views updatable while others are read-only? Explain with an example. 
 ## A view is a virtual table created from one or more tables using a SELECT query.
#Some views are updatable, while others are read-only, depending on how they are created.
#Updatable View
#A view is updatable when:
#It is based on a single table
#It does not use GROUP BY
#It does not use DISTINCT
#It does not use aggregate functions (SUM, AVG, COUNT, etc.)
#It does not use JOIN
#Example 
	CREATE VIEW vw_EmployeeDetails AS
	SELECT EmployeeID, Name, Salary
	FROM employee; 
    
    ## Q3.  What advantages do stored procedures offer compared to writing raw SQL queries repeatedly? 
    ## A Stored Procedure is a precompiled collection of SQL statements stored in the database that can be executed whenever required.
#Advantages of Stored Procedures:
##Reusability
#Stored procedures can be written once and executed multiple times, avoiding repetition of the same SQL code.
# Better Performance
#They are precompiled and stored in the database, so execution is faster compared to writing raw queries repeatedly.
#Improved Security
#Users can be given permission to execute the procedure without giving direct access to the underlying tables.
#Reduced Network Traffic
#Instead of sending multiple SQL statements from an application, a single procedure call is sent to the database.
#Easy Maintenance
#If business logic changes, we only need to modify the stored procedure instead of updating SQL queries everywhere in the application.

## Q4. What is the purpose of triggers in a database? Mention one use case where a trigger is essential. 
##A Trigger is a special type of stored procedure that automatically executes when a specific event occurs in a table.
#Triggers are fired automatically during:
#INSERT
#UPDATE
#DELETE
#Purpose of Triggers:
#Maintain data integrity
 #Enforce business rules
#Audit tracking (log changes)
#Automatically perform related actions
#Essential Use Case Example:
#Suppose we want to archive deleted employee records whenever someone deletes a row from the employee table.
#We can create an AFTER DELETE trigger that stores deleted data in an EmployeeArchive table.


### Q5. Explain the need for data modelling and normalization when designing a database.
 ## Data Modelling
##Data modelling is the process of designing the structure of a database before creating it.
#It defines:
#Tables
#Columns
#Data types
##Relationships between tables
##Constraints
##Need for Data Modelling:
## Provides clear database structure
##Identifies relationships between entities
##Reduces design errors
##Improves scalability
##Makes database easy to understand and maintain
 ## Example: Separating Employee and Department into different tables and linking them using a foreign key. 
 ###Normalization
##Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity.
#Need for Normalization:
#Eliminates duplicate data
#Prevents update anomalies
#Improves data consistency
# Saves storage space
#Makes database efficient
##Example:
#❌ Without Normalization:
##EmployeeID | Name | Department | DepartmentLocation
##Department details repeat for every employee.
##After Normalization:
#Employee table

#Department table

# Department information is stored only once and linked using a foreign key.
#Conclusion:

# Data modelling ensures proper structure, and normalization ensures efficient and consistent data storage.



create table Products_As (
ProductId Int Primary key,
ProductName Varchar (50), 
Category varchar(50),
price decimal(10,2)
); 

INSERT INTO Products_As VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);

select * from Products_As; 

### I'm created here sales_ass table because of Sales table already created in my databse . 
CREATE TABLE Sales_Ass (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate date,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO Sales_Ass VALUES
(1,1,4,'2024-01-05'),
(2,2,10,'2024-01-06'),
(3,3,2,'2024-01-10'),
(4,4,1,'2024-01-11');


select * from Sales_Ass ; 

### Q6. Write a CTE to calculate the total revenue for each product
 #(Revenues = Price × Quantity), and return only products where  revenue > 3000.
 
 WITH ProductRevenue AS (
    SELECT 
        p.ProductId,
        p.ProductName,
        p.Price,
        s.Quantity,
        (p.Price * s.Quantity) AS Revenue
    FROM Products_As p
    JOIN Sales_Ass s
        ON p.ProductId = s.ProductID
)
SELECT *
FROM ProductRevenue
WHERE Revenue > 3000;

### Q7. Create a view named that shows:
 ## Category, TotalProducts, AveragePrice
 CREATE VIEW vw_CategorySummary_ass AS
SELECT 
    Category,
    COUNT(ProductId) AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products_As
GROUP BY Category;

Select * from vw_CategorySummary_Ass;

## Q8. Create an updatable view containing ProductID, ProductName, and Price. 
 ## Then  update the price of ProductID = 1 using the view.
 
 CREATE VIEW vw_ProductDetails_ass AS
SELECT 
    ProductID,
    ProductName,
    Price
FROM Products_As;

UPDATE vw_ProductDetails_ass
SET Price = 55000
WHERE ProductID = 1;
select * from Products_As; 

## Q9. Create a stored procedure that accepts a category name and returns all products belonging to that category. 

DELIMITER //
CREATE PROCEDURE GetProductsByCategory(IN category_name VARCHAR(50))
BEGIN
    SELECT *
    FROM Products_As
    WHERE Category = category_name;
END //
DELIMITER ;

CALL GetProductsByCategory('Electronics');

## Q10. Create an AFTER DELETE trigger on the Products_as table that archives deleted product rows into a new
#table ProductArchive.
 #The archive should store ProductID, ProductName, Category, Price, and DeletedAttimestamp. 
 
 CREATE TABLE ProductArchive (
    ProductId INT,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt DATETIME
);

DELIMITER //
CREATE TRIGGER trg_AfterDeleteProduct
AFTER DELETE ON Products_As
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive
    (ProductId, ProductName, Category, Price, DeletedAt)
    VALUES
    (OLD.ProductId, OLD.ProductName, OLD.Category, OLD.Price, NOW());
END //
DELIMITER ;

