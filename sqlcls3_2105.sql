-- Create the Employee database
CREATE DATABASE Employee;

-- Use the Employee database
USE Employee;

-- Create the employees table
CREATE TABLE employees (
    emp_no INT NOT NULL AUTO_INCREMENT,
    birth_date DATE NOT NULL,
    first_name VARCHAR(14) NOT NULL,
    last_name VARCHAR(16) NOT NULL,
    gender ENUM('M', 'F') NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_no)
);

-- Create the salaries table
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    PRIMARY KEY (emp_no, from_date),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- Create the departments table
CREATE TABLE departments (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE KEY (dept_name)
);

-- Create the dept_emp table
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

-- Create the dept_manager table
CREATE TABLE dept_manager (
    dept_no CHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- Create the titles table
CREATE TABLE titles (
    emp_no INT NOT NULL,
    title VARCHAR(50) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE,
    PRIMARY KEY (emp_no, title, from_date),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);


-------------------------------------------------------------------------

-- Insert values into the employees table
INSERT INTO employees (birth_date, first_name, last_name, gender, hire_date)
VALUES ('1980-03-19', 'Naveen', 'Karthik', 'M', '2013-12-23');

-- Insert values into the departments table
INSERT INTO departments (dept_no, dept_name) 
VALUES ('d001', 'Civil department');

-- Insert values into the dept_emp table
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
VALUES (1, 'd001', '2013-12-23', '2013-12-25');

-- Insert values into the dept_manager table
INSERT INTO dept_manager (dept_no, emp_no, from_date, to_date)
VALUES ('d001', 1, '2013-12-23', '2013-12-25');

-- Insert values into the titles table
INSERT INTO titles (emp_no, title, from_date, to_date)
VALUES (1, 'Manager', '2013-12-23', '2013-12-25');

-- Insert values into the salaries table
INSERT INTO salaries (emp_no, salary, from_date, to_date)
VALUES (1, 50000, '2013-12-23', '2013-12-25');

------------------------------------------------------------------------
-- Update a row in the employees table
UPDATE employees SET first_name='Kavin' WHERE emp_no=1;

-- Delete a row from the employees table
DELETE FROM employees WHERE emp_no=1;

-- Delete all records from the employees table
DELETE FROM employees;

-- Drop the employees table
DROP TABLE employees;
------------------------------------------------------------------------
-- Select all employees from the employees table
SELECT * FROM employees;

-- Select specific columns from the employees table
SELECT first_name, hire_date, gender FROM employees;

-- Select distinct values from a column
SELECT DISTINCT first_name FROM employees;
SELECT DISTINCT title FROM titles;
SELECT DISTINCT dept_name FROM departments;

-- Select employees with a condition
SELECT * FROM employees WHERE gender = 'M';

-- Order employees by hire_date
SELECT * FROM employees ORDER BY hire_date;

-- Order salaries in descending order
SELECT * FROM salaries ORDER BY salary DESC;

-- Add multiple conditions using AND keyword
SELECT * FROM employees WHERE first_name = 'fname' AND last_name = 'lname';

-- Sort the table with conditions using OR keyword
SELECT * FROM employees WHERE gender = 'M' OR hire_date = 'date';

-- Use NOT keyword
SELECT * FROM salaries WHERE NOT salary = 10000;

-- Limit the number of records
SELECT * FROM employees LIMIT 5;

-- Use MAX() and MIN() functions
SELECT MAX(salary) FROM salaries;
SELECT MIN(salary) FROM salaries;
SELECT MIN(salary) AS lower_salary FROM salaries;

-- Use COUNT() function
SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM employees WHERE gender = 'M';

-- Use SUM() function
SELECT SUM(salary) FROM salaries;
SELECT SUM(salary) FROM salaries WHERE from_date = '2022-06-21';

-- Use AVG() function
SELECT AVG(salary) FROM salaries;
SELECT AVG(salary) FROM salaries WHERE from_date = '2022-06-21';

-- Use LIKE operator
SELECT * FROM employees WHERE first_name LIKE 'a%';

-- Use IN operator
SELECT * FROM salaries WHERE salary IN (10000, 20000, 30000);
SELECT * FROM salaries WHERE salary NOT IN (10000, 20000, 30000);

-- Use BETWEEN operator
SELECT * FROM salaries WHERE salary BETWEEN 10000 AND 30000;
SELECT * FROM salaries WHERE salary NOT BETWEEN 10000 AND 30000;

-- Use AS keyword
SELECT first_name AS name FROM employees;
--------------------------------------------------------------------
-- Inner join
SELECT * FROM employees INNER JOIN salaries ON employees.emp_no = salaries.emp_no;

-- Left join
SELECT employees.first_name, salaries.salary 
FROM employees LEFT JOIN salaries ON employees.emp_no = salaries.emp_no;

-- Right join
SELECT employees.first_name, salaries.salary 
FROM employees RIGHT JOIN salaries ON employees.emp_no = salaries.emp_no;

-- Cross join
SELECT employees.first_name, salaries.salary 
FROM employees CROSS JOIN salaries ON employees.emp_no = salaries.emp_no;

-- Self join
SELECT e1.first_name, e2.salary 
FROM employees e1, salaries e2 WHERE e1.emp_no = e2.emp_no;

----------------------------------------------------------------------
-- Group by keyword
SELECT COUNT(emp_no), title FROM titles GROUP BY title;

-- Having keyword
SELECT COUNT(emp_no), title FROM titles GROUP BY title HAVING title = 'Manager';

-------------------------------------------------------------------------
-- Exists keyword
SELECT first_name, salary 
FROM employees, salaries 
WHERE EXISTS (SELECT salary FROM salaries WHERE salaries.emp_no = employees.emp_no AND salary > 200000);

-- Any keyword
SELECT first_name FROM employees 
WHERE emp_no = ANY (SELECT emp_no FROM titles WHERE title = 'Manager');

-- All keyword
SELECT first_name FROM employees 
WHERE emp_no = ALL (SELECT emp_no FROM titles WHERE title = 'Manager');

-------------------------------------------------------------------------------
-- Insert into table from another table
INSERT INTO employees SELECT * FROM employees_old;

-- Case statements
SELECT emp_no, gender,
CASE 
    WHEN gender = 'M' THEN 'Work from home'
    WHEN gender = 'F' THEN 'Work from office'
    ELSE 'There is no employee'
END AS type_of_work
FROM employees;

-- Alter table
ALTER TABLE employees ADD address VARCHAR(255);
ALTER TABLE employees DROP address;
ALTER TABLE employees MODIFY emp_no VARCHAR(10);

-- Using CHECK and DEFAULT
CREATE TABLE employee_details (
    emp_no INT PRIMARY KEY,
    mobile_num INT(15) NOT NULL DEFAULT 0000000000,
    age INT,
    CHECK (age > 18)
);

---------------------------------------------------------------------------------
-- Select records based on date
SELECT * FROM employees WHERE hire_date = '2023-11-16';
SELECT * FROM employees WHERE hire_date > '2023-11-16';
SELECT * FROM employees WHERE hire_date < '2023-12-10';
SELECT * FROM employees WHERE hire_date BETWEEN '1997-01-01' AND '1997-01-31';

-- Select records based on month and year
SELECT * FROM employees WHERE MONTH(hire_date) = '02';
SELECT * FROM employees WHERE MONTH(hire_date) = '02' AND YEAR(hire_date) = '2023';
SELECT * FROM employees WHERE YEAR(hire_date) = '2020';

-- Select records based on current date
SELECT * FROM employees WHERE hire_date BETWEEN CURDATE() - INTERVAL 1 DAY AND CURDATE();

-- Select records based on time
SELECT * FROM employees WHERE TIME(hire_date) = '20:00:00';
SELECT * FROM employees WHERE TIME(hire_date) > '20:00:00';
SELECT * FROM employees WHERE TIME(hire_date) < '20:00:00';
SELECT * FROM employees WHERE TIME(hire_date) BETWEEN '18:00:00' AND '20:00:00';

----------------------------------------------------------------------------------
-- Drop a column from a table
ALTER TABLE table_name DROP COLUMN column_name;

-- Truncate a table
TRUNCATE table_name;

-----------------------------------------------------------------------------------

-- Nested query
SELECT * FROM employees WHERE hire_date IN (SELECT

