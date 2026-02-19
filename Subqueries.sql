Create Database Subquery_ass; 
use Subquery_ass; 
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id VARCHAR(10),
    salary INT
);
INSERT INTO Employee VALUES
(101, 'Abhishek', 'D01', 62000),
(102, 'Shubham', 'D01', 58000),
(103, 'Priya', 'D02', 67000),
(104, 'Rohit', 'D02', 64000),
(105, 'Neha', 'D03', 72000),
(106, 'Aman', 'D03', 55000),
(107, 'Ravi', 'D04', 60000),
(108, 'Sneha', 'D04', 75000),
(109, 'Kiran', 'D05', 70000),
(110, 'Tanuja', 'D05', 65000);

select * from Employee; 

create table Department 
( department_id varchar(10) Primary KEy ,
department_name varchar(50),
location varchar(50)
);

INSERT INTO Department VALUES
('D01', 'Sales', 'Mumbai'),
('D02', 'Marketing', 'Delhi'),
('D03', 'Finance', 'Pune'),
('D04', 'HR', 'Bengaluru'),
('D05', 'IT', 'Hyderabad');

select * from Department ; 

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_amount INT,
    sale_date DATE
);

INSERT INTO Sales VALUES
(201, 101, 4500, '2025-01-05'),
(202, 102, 7800, '2025-01-10'),
(203, 103, 6700, '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105, 9800, '2025-02-02'),
(206, 106, 10500, '2025-02-05'),
(207, 107, 3200, '2025-02-09'),
(208, 108, 5100, '2025-02-15'),
(209, 109, 3900, '2025-02-20'),
(210, 110, 7200, '2025-03-01');

select  * from Sales ; 

### 15 Daily Practice Problems (DPP) on Subqueries 
#### Basic Level
##Q1Retrieve the names of employees who earn more than the average salary of all employees.

select Avg(salary) from employee; 

select name from employee 
where salary >(select avg(salary ) from employee) ;
 
 ##Q2Find the employees who belong to the department with the highest average salary.
 
 SELECT department_id, AVG(salary)
FROM Employee
GROUP BY department_id;

SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id
    FROM Employee
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

SELECT department_id
FROM Employee
GROUP BY department_id
ORDER BY AVG(salary) DESC
LIMIT 1 ;

### Q3: Retrieve employees who have made at least one sale. 

SELECT emp_id FROM Sales; 
select name 
from employee 
where emp_id in (select emp_id from sales ) ;


### Q4: Find the employee who made the highest sale amount. 
select max( sale_amount) from sales; 

select name from employee 
where emp_id = (select emp_id from sales where sale_amount =(select max(sale_amount) from sales ) ); 


### Q5: Retrieve employees who earn more than Shubham.
SELECT name
FROM Employee
WHERE salary > (
    SELECT salary
    FROM Employee
    WHERE name = 'Shubham'
); 

### Intermediate Level
### Q1. Find employees who work in the same department as Abhishek. 
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id
    FROM Employee
    WHERE name = 'Abhishek'
);

### Q2. List departments that have at least one employee earning more than ₹60,000.
select * from department ; 
select * from employee; 
select * from sales ; 
select department_name 
from department 
where department_id in(select  department_id from employee where salary > 60000 ); 

### Q3. Find the department name of the employee who made the highest sale. 
select department_name 
From department d
join employee e 
on d.department_id = e.department_id 
join sales s on e. emp_id = s.emp_id 
where s. sale_amount =(select Max(sale_amount) From sales ); 


### Q4. Retrieve employees who have made sales greater than the average sale amount. 

SELECT DISTINCT e.name
FROM Employee e
JOIN Sales s ON e.emp_id = s.emp_id
WHERE s.sale_amount > (SELECT AVG(sale_amount) FROM Sales);


### Q5. Find the total sales made by employees who earn more than the average salary. 
SELECT SUM(s.sale_amount) AS TotalSales
FROM Employee e
JOIN Sales s ON e.emp_id = s.emp_id
WHERE e.salary > (SELECT AVG(salary) FROM Employee);


### Advanced Level
###Q1Find employees who have not made any sales
SELECT e.name AS Employee_Name
FROM Employee e
LEFT JOIN Sales s ON e.emp_id = s.emp_id
WHERE s.emp_id IS NULL;


### Q2.List departments where the average salary is above ₹55,000 
select d. department_name 
from department d 
join employee e on d.department_id= e.department_id 
group by d.department_id , d.department_name 
having avg(e.salary)>55000; 
 
 
 ### Q3 Retrieve department names where the total sales exceed ₹10,000. 
 select d.department_name 
 from department d 
 join employee e on d.department_id = e.department_id 
 join sales s on e.emp_id = s.emp_id 
 group by d.department_id ,d.department_name 
 having avg(s.sale_amount) >10000 ; 

### Q4 Find the employee who has made the second-highest sale. 
SELECT e.name
FROM Employee e
JOIN Sales s ON e.emp_id = s.emp_id
ORDER BY s.sale_amount DESC 
LIMIT 1 OFFSET 1; 

### Q5 .Retrieve the names of employees whose salary is greater than the highest sale amount recorded. 
SELECT name
FROM Employee
WHERE salary > (SELECT MAX(sale_amount) FROM Sales);
 


