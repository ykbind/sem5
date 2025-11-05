create database CollegeDB;
Query OK, 1 row affected (0.02 sec)

use CollegeDB;
Database changed

-- Create tables: students and alumni

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT,
    marks DECIMAL(5,2),
    city VARCHAR(50)
);
Query OK, 0 rows affected (0.03 sec)

CREATE TABLE alumni (
    alumni_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);
Query OK, 0 rows affected (0.02 sec)

-- Insert sample data into students and alumni tables

INSERT INTO students VALUES
(1, 'Riya', 20, 85, 'Pune'),
(2, 'Aarav', 21, 72, 'Mumbai'),
(3, 'Neha', 22, 90, 'Pune'),
(4, 'Karan', 23, 65, 'Nashik'),
(5, 'Tina', 24, 45, 'Pune');
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

INSERT INTO alumni VALUES
(101, 'Riya', 'Pune'),
(102, 'Mehul', 'Mumbai'),
(103, 'Tina', 'Pune'),
(104, 'Rohan', 'Nashik');
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

-- Retrieve specific information using SELECT statements demonstrating:

-- Q1. Arithmetic, comparison, and logical operators

 SELECT name, marks + 5 AS updated_marks
    FROM students
    WHERE marks > 80 AND city = 'Pune';
+------+---------------+
| name | updated_marks |
+------+---------------+
| Riya |         90.00 |
| Neha |         95.00 |
+------+---------------+
2 rows in set (0.00 sec)

-- Q2. SQL functions (like AVG(), MAX(), UPPER(), LENGTH() etc.

 SELECT
    name,
    AVG(marks) AS avg_marks,
    MAX(marks) AS max_marks,
    MIN(marks) AS min_marks,
    UPPER(name) AS upper_name,
    LENGTH(name) AS name_length
FROM students
GROUP BY name;
+-------+-----------+-----------+-----------+------------+-------------+
| name  | avg_marks | max_marks | min_marks | upper_name | name_length |
+-------+-----------+-----------+-----------+------------+-------------+
| Riya  | 85.000000 |     85.00 |     85.00 | RIYA       |           4 |
| Aarav | 72.000000 |     72.00 |     72.00 | AARAV      |           5 |
| Neha  | 90.000000 |     90.00 |     90.00 | NEHA       |           4 |
| Karan | 65.000000 |     65.00 |     65.00 | KARAN      |           5 |
| Tina  | 45.000000 |     45.00 |     45.00 | TINA       |           4 |
+-------+-----------+-----------+-----------+------------+-------------+
5 rows in set (0.00 sec)

-- Q3. Sorting and filtering of results (ORDER BY, WHERE, GROUP BY)

 SELECT * FROM students
    WHERE marks > 60
    ORDER BY marks DESC;
+------------+-------+------+-------+--------+
| student_id | name  | age  | marks | city   |
+------------+-------+------+-------+--------+
|          3 | Neha  |   22 | 90.00 | Pune   |
|          1 | Riya  |   20 | 85.00 | Pune   |
|          2 | Aarav |   21 | 72.00 | Mumbai |
|          4 | Karan |   23 | 65.00 | Nashik |
+------------+-------+------+-------+--------+
4 rows in set (0.00 sec)

-- Group by city
SELECT city, COUNT(*) AS total_students, AVG(marks) AS avg_marks
FROM students
GROUP BY city;
+--------+----------------+-----------+
| city   | total_students | avg_marks |
+--------+----------------+-----------+
| Pune   |              3 | 73.333333 |
| Mumbai |              1 | 72.000000 |
| Nashik |              1 | 65.000000 |
+--------+----------------+-----------+
3 rows in set (0.00 sec)

-- Modify existing data using the UPDATE command (e.g., increase marks for students from a specific city).

 UPDATE students
    SET marks = marks + 10
    WHERE city = 'Pune';
Query OK, 3 rows affected (0.02 sec)
Rows matched: 3  Changed: 3  Warnings: 0

SELECT * FROM students;
+------------+-------+------+--------+--------+
| student_id | name  | age  | marks  | city   |
+------------+-------+------+--------+--------+
|          1 | Riya  |   20 |  95.00 | Pune   |
|          2 | Aarav |   21 |  72.00 | Mumbai |
|          3 | Neha  |   22 | 100.00 | Pune   |
|          4 | Karan |   23 |  65.00 | Nashik |
|          5 | Tina  |   24 |  55.00 | Pune   |
+------------+-------+------+--------+--------+
5 rows in set (0.00 sec)

--Delete records based on a condition using the DELETE command (e.g., remove students with marks below a certain value).

 DELETE FROM students
    WHERE marks < 50;
Query OK, 0 rows affected (0.02 sec)

SELECT * FROM students;
+------------+-------+------+--------+--------+
| student_id | name  | age  | marks  | city   |
+------------+-------+------+--------+--------+
|          1 | Riya  |   20 |  95.00 | Pune   |
|          2 | Aarav |   21 |  72.00 | Mumbai |
|          3 | Neha  |   22 | 100.00 | Pune   |
|          4 | Karan |   23 |  65.00 | Nashik |
|          5 | Tina  |   24 |  55.00 | Pune   |
+------------+-------+------+--------+--------+
5 rows in set (0.00 sec)

-- Demonstrate use of SET OPERATORS (UNION, INTERSECT, EXCEPT) to compare data between students and alumni.

-- 1.Union of students and alumni names
 SELECT name FROM students
    UNION
    SELECT name FROM alumni;
+-------+
| name  |
+-------+
| Riya  |
| Aarav |
| Neha  |
| Karan |
| Tina  |
| Mehul |
| Rohan |
+-------+
7 rows in set (0.02 sec)

-- Intersect of students and alumni names
SELECT s.name
FROM students s
INNER JOIN alumni a
ON s.name = a.name;
+------+
| name |
+------+
| Riya |
| Tina |
+------+
2 rows in set (0.02 sec)

-- Except: Names in students but not in alumni
SELECT s.name
FROM students s
LEFT JOIN alumni a ON s.name = a.name
WHERE a.name IS NULL;
+-------+
| name  |
+-------+
| Aarav |
| Neha  |
| Karan |
+-------+
3 rows in set (0.00 sec)

-- Use a subquery with an operator like IN to find students who are also alumni.

SELECT name, city
FROM alumni
WHERE name NOT IN (SELECT name FROM students);
+------+------+
| name | city |
+------+------+
| Riya | Pune |
| Tina | Pune |
+------+------+
2 rows in set (0.00 sec)


