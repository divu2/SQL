###Q1. Create a New Database and  Table for Employees 
###Task: Create a new database named company_db and Create a table named employees  with the following columns:
-- Create Database
create Database company_db;

-- Use Database
USE company_db;	


-- Create Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE
);

### Q.2 Insert Data into Employees Table 
### Insert the following sample records into the employees table.
INSERT INTO employees 
(employee_id, first_name, last_name, department, salary, hire_date)
VALUES
(101, 'Amit', 'Sharma', 'HR', 50000, '2020-01-15'),
(102, 'Riya', 'Kapoor', 'Sales', 75000, '2019-03-22'),
(103, 'Raj', 'Mehta', 'IT', 90000, '2018-07-11'),
(104, 'Neha', 'Verma', 'IT', 85000, '2021-09-01'),
(105, 'Arjun', 'Singh', 'Finance', 60000, '2022-02-10');
 
 SELECT * FROM employees;
SELECT DATABASE();
use company_db;
SHOW TABLES;

###Q.3 Display All Employee Records Sorted by Salary (Lowest to Highest) 

SELECT *
FROM employees
ORDER BY salary ASC;

### Q.4 Show Employees Sorted by Department (A–Z) and Salary (High → Low)
select * 
from employees 
Order by department ASC, salary DESC;

###Q5. List All Employees in the IT Department, Ordered by Hire Date (Newest First) 
SELECT *
FROM employees
WHERE department = 'IT'
ORDER BY hire_date DESC;

### Q6. Create and Populate a Sales Table 
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    amount INT,
    sale_date DATE
);

INSERT INTO sales
(sale_id, customer_name, amount, sale_date)
VALUES
(1, 'Aditi', 1500, '2024-08-01'),
(2, 'Rohan', 2200, '2024-08-03'),
(3, 'Aditi', 3500, '2024-09-05'),
(4, 'Meena', 2700, '2024-09-15'),
(5, 'Rohan', 4500, '2024-09-25');


### Q7. Display All Sales Records Sorted by Amount (Highest → Lowest) 
SELECT *
FROM sales
ORDER BY amount DESC;

### Q8. Show All Sales Made by Customer “Aditi” 
SELECT *
FROM sales
WHERE customer_name = 'Aditi';


### Q.9 Difference Between Primary Key and Foreign Key 
###A Primary Key is used to uniquely identify each record in a table. It does not allow duplicate or NULL values. 
###A Foreign Key is used to establish a relationship between two tables by referring to the primary key of another table. It can contain duplicate and NULL values.

-- Primary Key example
### employee_id INT PRIMARY KEY

-- Foreign Key example
### employee_id INT,
### KEY (employee_id) REFERENCES employees(employee_id)

### Q. 10 What Are Constraints in SQL and Why Are They Used? 
####Constraints in SQL are rules applied to table columns to restrict the type of data that can be inserted into a table.
###They are used to maintain data accuracy, consistency, and integrity in the database.

###salary INT CHECK (salary > 0),
### name VARCHAR(50) NOT NULL







