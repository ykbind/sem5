create database CollegeDB;


use CollegeDB;

-- Create tables: students and alumni

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT,
    marks DECIMAL(5,2),
    city VARCHAR(50)
);


CREATE TABLE alumni (
    alumni_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);


-- Insert sample data into students and alumni tables

INSERT INTO students VALUES
(1, 'Riya', 20, 85, 'Pune'),
(2, 'Aarav', 21, 72, 'Mumbai'),
(3, 'Neha', 22, 90, 'Pune'),
(4, 'Karan', 23, 65, 'Nashik'),
(5, 'Tina', 24, 45, 'Pune');


INSERT INTO alumni VALUES
(101, 'Riya', 'Pune'),
(102, 'Mehul', 'Mumbai'),
(103, 'Tina', 'Pune'),
(104, 'Rohan', 'Nashik');


-- Retrieve specific information using SELECT statements demonstrating:

-- Q1. Arithmetic, comparison, and logical operators

 SELECT name, marks + 5 AS updated_marks
    FROM students
    WHERE marks > 80 AND city = 'Pune';


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


-- Q3. Sorting and filtering of results (ORDER BY, WHERE, GROUP BY)

 SELECT * FROM students
    WHERE marks > 60
    ORDER BY marks DESC;


-- Group by city
SELECT city, COUNT(*) AS total_students, AVG(marks) AS avg_marks
FROM students
GROUP BY city;


-- Modify existing data using the UPDATE command (e.g., increase marks for students from a specific city).

 UPDATE students
    SET marks = marks + 10
    WHERE city = 'Pune';

SELECT * FROM students;


--Delete records based on a condition using the DELETE command (e.g., remove students with marks below a certain value).

 DELETE FROM students
    WHERE marks < 50;
Query OK, 0 rows affected (0.02 sec)

SELECT * FROM students;


-- Demonstrate use of SET OPERATORS (UNION, INTERSECT, EXCEPT) to compare data between students and alumni.

-- 1.Union of students and alumni names
 SELECT name FROM students
    UNION
    SELECT name FROM alumni;


-- Intersect of students and alumni names
SELECT s.name
FROM students s
INNER JOIN alumni a
ON s.name = a.name;


-- Except: Names in students but not in alumni
SELECT s.name
FROM students s
LEFT JOIN alumni a ON s.name = a.name
WHERE a.name IS NULL;


-- Use a subquery with an operator like IN to find students who are also alumni.

SELECT name, city
FROM alumni
WHERE name NOT IN (SELECT name FROM students);





