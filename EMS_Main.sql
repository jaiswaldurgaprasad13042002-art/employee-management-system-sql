-- SQL Mini Project: Employee Management System

-- CREATE DATABASE Employee;

-- USE EMPLOYEE;

CREATE TABLE departments (
department_id int primary key,
department_name varchar(50)
);

CREATE TABLE employees (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(50),
department_id INT,
salary INT,
manager_id INT,
hire_date DATE,
foreign key (department_id) references departments(department_id)
);

CREATE TABLE former_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50)
);

CREATE TABLE projects (
project_id INT PRIMARY KEY,
project_name VARCHAR(50),
employee_id int,
foreign key (employee_id) references employees(employee_id)
);

-- INSERT SAMPLE DATA
INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO employees VALUES
(101, 'Rahul', 1, 70000, NULL, '2023-01-15'),
(102, 'Priya', 2, 55000, 101, '2023-03-10'),
(103, 'Aman', 1, 85000, 101, '2022-11-20'),
(104, 'Neha', 3, 60000, 101, '2023-05-12'),
(105, 'Vikas', 4, 50000, 102, '2024-01-08'),
(106, 'Anjali', 1, 75000, 103, '2023-07-19'),
(107, 'Rohit', 3, 65000, 104, '2024-02-14'),
(108, 'Sneha', 2, 58000, 102, '2023-09-25');

INSERT INTO former_employees VALUES
(201, 'Karan'),
(202, 'Rahul'),
(203, 'Amit');

INSERT INTO projects VALUES
(201, 'Employee Portal', 101),
(202, 'Payroll System', 102),
(203, 'Inventory Tracker', 103),
(204, 'Budget Analysis', 104),
(205, 'Marketing Dashboard', 105),
(206, 'AI Chatbot', 106),
(207, 'Finance Reporting', 107),
(208, 'Recruitment App', 108);

-- Basic QUERIES
SELECT * FROM employees;

SELECT employee_name, salary from employees where salary > 60000;

-- GROUP BY & HAVING
SELECT department_id, AVG(salary) from employees group by department_id;
SELECT department_id, AVG(salary) from employees group by department_id HAVING AVG(salary) > 50000;
SELECT department_id, SUM(salary) from employees group by department_id HAVING SUM(salary) > 100000;

-- JOINs
select e.employee_name, d.department_name 
from employees as e 
join departments as d 
on e.department_id = d.department_id;

-- SELF JOIN
SELECT e.employee_name as Employee, 
m.employee_name as manager 
from employees e 
left join employees m 
on e.manager_id = m.employee_id;

-- Subquery
SELECT employee_name, salary 
FROM employees 
WHERE salary > (SELECT AVG(salary) from employees);

-- View
CREATE VIEW employee_view AS 
SELECT employee_name, salary from employees;

select * from employee_view;

-- UNION
SELECT employee_name AS name
FROM employees

UNION

SELECT department_name AS name
FROM departments;

-- ALTER
ALTER TABLE employees
ADD COLUMN Email VARCHAR(50);