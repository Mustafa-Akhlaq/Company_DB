SELECT * FROM departments;

SELECT * FROM employees;

SELECT * FROM projects;

SELECT * FROM employee_projects;

CREATE TABLE departments (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(100),
location VARCHAR(100)
);

CREATE TABLE employees (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(100),
salary INT,
dept_id INT,
hire_date DATE,
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE projects (
project_id INT PRIMARY KEY,
project_name VARCHAR(100),
budget VARCHAR(100),
start_date DATE,
end_date DATE
);

CREATE TABLE employee_projects (
emp_id INT,
project_id INT,
hours_worked INT,
FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO departments(dept_id,dept_name,location) VALUES
(1, 'HR', 'New York'),
(2, 'IT', 'San Francisco'),
(3, 'Finance', 'Chicago');

INSERT INTO employees (emp_id, emp_name, salary, dept_id, hire_date) VALUES
(101, 'Alice Johnson', 60000, 1, '2020-05-15'),
(102, 'Bob Smith', 75000, 2, '2019-03-20'),
(103, 'Charlie Brown', 82000, 2, '2021-07-10'),
(104, 'Diana Miller', 90000, 3, '2018-11-05'),
(105, 'Ethan Davis', 55000, 1, '2022-01-12');

INSERT INTO projects (project_id, project_name, budget, start_date, end_date) VALUES
(201, 'Payroll System', 150000, '2021-01-01', '2021-12-31'),
(202, 'Website Revamp', 100000, '2022-02-15', '2022-09-30'),
(203, 'AI Chatbot', 200000, '2023-03-01', '2023-12-31');

INSERT INTO employee_projects (emp_id, project_id, hours_worked) VALUES
(101, 201, 120),
(102, 201, 150),
(102, 202, 200),
(103, 202, 180),
(103, 203, 220),
(104, 201, 100),
(104, 203, 160),
(105, 202, 90);

INSERT INTO employees (emp_id, emp_name, salary, dept_id, hire_date) VALUES
(106, 'Frank Wilson', 50000, NULL, '2023-06-20');

INSERT INTO employees (emp_id, emp_name, salary, dept_id, hire_date) VALUES
(107, 'William More', 59000, NULL, '2024-08-20');

INSERT INTO departments (dept_id, dept_name, location) 
VALUES (4, 'Marketing', 'Los Angeles');

INSERT INTO projects (project_id, project_name, budget, start_date, end_date)
VALUES (204, 'CRM Tool', 120000, '2024-01-01', '2024-12-31'),
(205, 'Mobile App Upgrade', 180000, '2024-06-01', '2025-05-31');


SELECT e.emp_name,d.dept_name
FROM employees AS e
LEFT JOIN departments AS d
ON e.dept_id = d.dept_id;

SELECT d.dept_name,e.emp_name 
FROM departments AS d
LEFT JOIN employees AS e
ON d.dept_id = e.dept_id;

SELECT e.emp_name , e.emp_id
FROM employees AS e
LEFT JOIN departments AS d
ON e.dept_id = d.dept_id 
WHERE d.dept_id IS NULL;

SELECT p.project_name,e.emp_name
FROM projects AS p
LEFT JOIN employee_projects AS ep
ON p.project_id = ep.project_id
LEFT JOIN employees AS e
ON ep.emp_id = e.emp_id;

SELECT d.dept_name, COALESCE(SUM(ep.hours_worked), 0) AS total_hours
FROM departments d
LEFT JOIN employees e 
    ON d.dept_id = e.dept_id
LEFT JOIN employee_projects ep 
    ON e.emp_id = ep.emp_id
GROUP BY d.dept_name;

SELECT e.emp_name
FROM employees e
LEFT JOIN employee_projects ep 
    ON e.emp_id = ep.emp_id
WHERE ep.project_id IS NULL;
