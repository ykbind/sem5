-- Create Supplier, Parts, and Catalog tables. Insert sample data and retrieve names of all parts that are green in color.

CREATE TABLE Supplier (
    Sid INT PRIMARY KEY,
    Sname VARCHAR(50),
    address VARCHAR(100)
);
Query OK, 0 rows affected (0.03 sec)

CREATE TABLE Parts (
    Pid INT PRIMARY KEY,
    Pname VARCHAR(50),
    Color VARCHAR(20)
);
Query OK, 0 rows affected (0.02 sec)

CREATE TABLE Catalog (
    Sid INT,
    Pid INT,
    cost DECIMAL(10,2),
    FOREIGN KEY (Sid) REFERENCES Supplier(Sid),
    FOREIGN KEY (Pid) REFERENCES Parts(Pid)
);
Query OK, 0 rows affected (0.03 sec)

-- Insert sample data into Supplier, Parts, and Catalog tables

INSERT INTO Supplier VALUES
    (1, 'Ramesh', 'Pune'),
    (2, 'Suresh', 'Mumbai'),
    (3, 'Mahesh', 'Delhi');
Query OK, 3 rows affected (0.03 sec)
Records: 3  Duplicates: 0  Warnings: 0

INSERT INTO Parts VALUES
    (101, 'Bolt', 'Green'),
    (102, 'Nut', 'Red'),
    (103, 'Screw', 'Blue'),
    (104, 'Washer', 'Green');
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0


INSERT INTO Catalog VALUES
    (1, 101, 20),
    (2, 102, 30),
    (3, 103, 25),
    (1, 104, 40);
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

-- Q1. Find names of all parts whose color is green.

SELECT Pname
FROM Parts
WHERE Color = 'Green';
+--------+
| Pname  |
+--------+
| Bolt   |
| Washer |
+--------+
2 rows in set (0.02 sec)

-- Q2. Find names of all suppliers who supply red colored parts.

SELECT DISTINCT S.Sname
FROM Supplier S
JOIN Catalog C ON S.Sid = C.Sid
JOIN Parts P ON C.Pid = P.Pid
WHERE P.Color = 'Red';
+--------+
| Sname  |
+--------+
| Suresh |
+--------+
1 row in set (0.02 sec)

-- Q3. Find names of all parts having cost greater than 25.
SELECT DISTINCT P.Pname
FROM Parts P
JOIN Catalog C ON P.Pid = C.Pid
WHERE C.cost > 25;
+--------+
| Pname  |
+--------+
| Nut    |
| Washer |
+--------+
2 rows in set (0.00 sec)

-- Create Person, Company, and Manages tables. Insert sample data and retrieve streets of persons managing 'Idea' company located in 'Pune' with salary greater than 3000.

CREATE TABLE Person (
    pname VARCHAR(50) PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50),
    salary DECIMAL(10,2)
    );
Query OK, 0 rows affected (0.04 sec)

CREATE TABLE Company (
    cname VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);
Query OK, 0 rows affected (0.02 sec)

CREATE TABLE Manages (
    pname VARCHAR(50),
    mname VARCHAR(50),
    FOREIGN KEY (pname) REFERENCES Person(pname)
);
Query OK, 0 rows affected (0.02 sec)

-- Insert sample data into Person, Company, and Manages tables

INSERT INTO Person VALUES
    ('Ravi', 'FC Road', 'Pune', 4000),
    ('Meena', 'JM Road', 'Pune', 2800),
    ('Sonal', 'MG Road', 'Mumbai', 3500);
Query OK, 3 rows affected (0.03 sec)
Records: 3  Duplicates: 0  Warnings: 0

INSERT INTO Company VALUES
    ('Idea', 'Pune'),
    ('Jio', 'Mumbai');
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

INSERT INTO Manages VALUES
    ('Ravi', 'Idea'),
    ('Sonal', 'Jio');
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

-- Q1. Find the street and city of all employees who work for “Idea”, live in Pune and earn more than 3000.
SELECT P.street, P.city
FROM Person P
JOIN Manages M ON P.pname = M.pname
WHERE M.mname = 'Idea'
  AND P.city = 'Pune'
  AND P.salary > 3000;
+---------+------+
| street  | city |
+---------+------+
| FC Road | Pune |
+---------+------+
1 row in set (0.00 sec)

-- Create Student, Subject, and Marks tables. Insert sample data and retrieve average marks of each student and count of students who failed in 'DBMS' subject.
CREATE TABLE Student (
    Rollno INT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)
);
Query OK, 0 rows affected (0.04 sec)

CREATE TABLE Subject (
    sub_code INT PRIMARY KEY,
    sub_name VARCHAR(50)
);
Query OK, 0 rows affected (0.02 sec)

CREATE TABLE Marks (
    Rollno INT,
    sub_code INT,
    marks INT,
    FOREIGN KEY (Rollno) REFERENCES Student(Rollno),
    FOREIGN KEY (sub_code) REFERENCES Subject(sub_code)
);
Query OK, 0 rows affected (0.02 sec)

-- Insert sample data into Student, Subject, and Marks tables

INSERT INTO Student VALUES
    (1, 'Rohit', 'Pune'),
    (2, 'Sonal', 'Mumbai'),
    (3, 'Meena', 'Delhi');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

INSERT INTO Subject VALUES
    (101, 'DBMS'),
    (102, 'CNS'),
    (103, 'OS');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

INSERT INTO Marks VALUES
    (1, 101, 78),
    (1, 102, 60),
    (2, 101, 35),
    (2, 102, 45),
    (3, 101, 28);
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

-- Q1. . Find out average marks of each student along with the name of student.

SELECT S.name, AVG(M.marks) AS Average_Marks
FROM Student S
JOIN Marks M ON S.Rollno = M.Rollno
GROUP BY S.name;
+-------+---------------+
| name  | Average_Marks |
+-------+---------------+
| Rohit |       69.0000 |
| Sonal |       40.0000 |
| Meena |       28.0000 |
+-------+---------------+
3 rows in set (0.02 sec)

-- Q2. Find how many students have failed in the subject “DBMS”

SELECT COUNT(*) AS Failed_Students
FROM Marks M
JOIN Subject S ON M.sub_code = S.sub_code
WHERE S.sub_name = 'DBMS' AND M.marks < 40;
+-----------------+
| Failed_Students |
+-----------------+
|               2 |
+-----------------+
1 row in set (0.02 sec)

