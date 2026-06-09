USE Employee;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM projects;
-- SQL QUESTIONS

-- 1. Show employee name and department name

SELECT e.employee_name, d.department_name FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id;

-- 2. Show employee name and project name

SELECT e.employee_name, p.project_name FROM employees AS e
JOIN projects AS p ON e.employee_id = p.employee_id;

-- 3. Show each employee and their manager's name
SELECT e.employee_name, m.employee_name AS manager_name
FROM employees AS e
LEFT JOIN employees AS m on e.manager_id = m.employee_id;

-- 4. Show employees who do not have a manager
SELECT employee_name FROM employees WHERE manager_id IS NULL;

-- 5. Find the average salary of each department
SELECT department_id, AVG(salary) FROM employees GROUP BY department_id;

-- 6. Find the number of employees in each department
SELECT d.department_name, count(employee_name) 
FROM employees AS e
JOIN departments AS d 
ON d.department_id = e.department_id 
GROUP BY department_name;

-- 7. Show departments whose average salary is greater than 65000
SELECT d.department_name, AVG(salary) FROM employees AS e JOIN departments AS d
ON e.department_id = d.department_id GROUP BY department_name 
HAVING AVG(salary) > 65000;

-- 8. Show departments having more than 2 employees
SELECT d.department_name, count(e.employee_id) AS No_of_Employees FROM employees AS e 
JOIN departments
AS d ON d.department_id = e.department_id 
GROUP BY department_name HAVING count(e.employee_id) > 2;

SELECT department_id, COUNT(*) FROM employees GROUP BY department_id HAVING
COUNT(*)>2;

-- 9. Find employees earning more than the company average salary
SELECT employee_name, salary FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 10. Find employees working in the same department as Rahul
SELECT employee_name FROM employees WHERE department_id = 
(SELECT department_id from employees where employee_name = 'Rahul');

-- 11. Create a view showing employee name, department name, and salary.
CREATE VIEW employees_view AS SELECT e.employee_name, d.department_name, e.salary
FROM employees as e JOIN departments as d ON e.department_id = d.department_id;

-- 12. Display all records from the view.
SELECT * FROM employees_view;

-- 13. Show all unique employee names from employees and former_employees.
SELECT employee_name FROM employees
UNION
SELECT employee_name FROM former_employees;

-- 14. Show all employee names including duplicates.
SELECT employee_name FROM employees
UNION ALL
SELECT employee_name FROM former_employees;

-- 15. Add an email column to employees.
ALTER TABLE employees
ADD COLUMN Email VARCHAR(50);

-- 16. Modify email to VARCHAR(150).
ALTER TABLE employees
MODIFY Email VARCHAR(150);

-- 17. Increase Rahul's salary to 80000.
UPDATE employees SET salary = 80000 WHERE employee_name = 'Rahul';

-- 18. Give all IT employees a 5000 raise.
UPDATE employees SET salary = salary+5000 WHERE department_id = 
(SELECT department_id FROM departments WHERE department_name = 'IT');

-- 19. Delete employee_id 108.
DELETE FROM projects
WHERE employee_id = 108;

DELETE FROM employees
WHERE employee_id = 108;

-- Employee cannot be deleted directly because
-- projects.employee_id has a foreign key reference
-- Delete child records first
/*You can use ON DELETE CASCADE when creating the table 
it will automatically deletes related project rows. */

-- 20. Delete projects assigned to employee_id 105.
DELETE FROM projects WHERE employee_id = 105;

-- 21. Show employee, department, project for employees above average salary.
SELECT e.employee_name, d.department_name, p.project_name FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id 
JOIN projects AS p ON e.employee_id = p.employee_id 
WHERE e.salary > (SELECT AVG(salary) from employees);

-- 22. Show employee, manager, department, salary for every employee.
SELECT e.employee_name, m.employee_name AS manager, d.department_name, e.salary
FROM employees AS e LEFT JOIN employees AS m on e.manager_id = m.employee_id
JOIN departments AS d ON e.department_id = d.department_id;
