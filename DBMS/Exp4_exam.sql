-- Solution Part A

-- Create Customer Master Table
CREATE TABLE cust_mstr (
    custno INT PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL
);
Query OK, 0 rows affected (0.03 sec)

-- Create Account/FD link table
CREATE TABLE acc_fd_cust_dets (
    codeno INT PRIMARY KEY,
    acc_fd_no INT NOT NULL,
    custno INT,
    FOREIGN KEY (custno) REFERENCES cust_mstr(custno)
);
Query OK, 0 rows affected (0.03 sec)

-- Create Fixed Deposit Details Table
CREATE TABLE fd_dets (
    fd_sr_no INT PRIMARY KEY,
    amt DECIMAL(10,2)
);
Query OK, 0 rows affected (0.02 sec)

INSERT INTO cust_mstr VALUES
    (1, 'Ravi', 'Patil'),
    (2, 'Sneha', 'Deshmukh'),
    (3, 'Amit', 'Kumar'),
    (4, 'Neha', 'Joshi');
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

INSERT INTO acc_fd_cust_dets VALUES
    (101, 201, 1),
    (102, 202, 2),
    (103, 203, 3),
    (104, 204, 4);
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

INSERT INTO fd_dets VALUES
    (201, 4500),
    (202, 7000),
    (203, 10000),
    (204, 3000);
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

SELECT * FROM cust_mstr;
+--------+-------+----------+
| custno | fname | lname    |
+--------+-------+----------+
|      1 | Ravi  | Patil    |
|      2 | Sneha | Deshmukh |
|      3 | Amit  | Kumar    |
|      4 | Neha  | Joshi    |
+--------+-------+----------+
4 rows in set (0.00 sec)

SELECT * FROM acc_fd_cust_dets;
+--------+-----------+--------+
| codeno | acc_fd_no | custno |
+--------+-----------+--------+
|    101 |       201 |      1 |
|    102 |       202 |      2 |
|    103 |       203 |      3 |
|    104 |       204 |      4 |
+--------+-----------+--------+
4 rows in set (0.00 sec)

SELECT * FROM fd_dets;
+----------+----------+
| fd_sr_no | amt      |
+----------+----------+
|      201 |  4500.00 |
|      202 |  7000.00 |
|      203 | 10000.00 |
|      204 |  3000.00 |
+----------+----------+
4 rows in set (0.00 sec)


-- List the customer holding fixed deposit of amount more than 5000 

SELECT c.custno, c.fname, c.lname, f.amt
    FROM cust_mstr c
    JOIN acc_fd_cust_dets a ON c.custno = a.custno
    JOIN fd_dets f ON a.acc_fd_no = f.fd_sr_no
    WHERE f.amt > 5000;
+--------+-------+----------+----------+
| custno | fname | lname    | amt      |
+--------+-------+----------+----------+
|      2 | Sneha | Deshmukh |  7000.00 |
|      3 | Amit  | Kumar    | 10000.00 |
+--------+-------+----------+----------+
2 rows in set (0.00 sec)


-- Solution Part B

-- Create view on cust_mstr and acc_fd_cust_dets tables by selecting any one column from each table perform insert update delete operations


CREATE VIEW cust_acc_view AS
    SELECT c.fname, a.acc_fd_no
    FROM cust_mstr c
    JOIN acc_fd_cust_dets a ON c.custno = a.custno;
Query OK, 0 rows affected (0.00 sec)

-- Insert into base tables first
INSERT INTO cust_mstr VALUES (5, 'Raj', 'More');
Query OK, 1 row affected (0.02 sec)

INSERT INTO acc_fd_cust_dets VALUES (105, 205, 5);
Query OK, 1 row affected (0.00 sec)

INSERT INTO fd_dets VALUES (205, 8000);
Query OK, 1 row affected (0.00 sec)

SELECT * FROM cust_acc_view;
+-------+-----------+
| fname | acc_fd_no |
+-------+-----------+
| Ravi  |       201 |
| Sneha |       202 |
| Amit  |       203 |
| Neha  |       204 |
| Raj   |       205 |
+-------+-----------+
5 rows in set (0.00 sec)

UPDATE acc_fd_cust_dets
SET acc_fd_no = 202
WHERE codeno = 101;
Query OK, 1 row affected (0.02 sec)
Rows matched: 1  Changed: 1  Warnings: 0

DELETE FROM acc_fd_cust_dets
WHERE codeno = 104;
Query OK, 1 row affected (0.02 sec)

SELECT * FROM cust_acc_view;
+-------+-----------+
| fname | acc_fd_no |
+-------+-----------+
| Ravi  |       202 |
| Sneha |       202 |
| Amit  |       203 |
| Raj   |       205 |
+-------+-----------+
4 rows in set (0.00 sec)

-- Solution Part C

-- List the employee details along with contact details using left outer join & right join 


-- Employee Master
CREATE TABLE emp_mstr (
    emp_no INT PRIMARY KEY,
    f_name VARCHAR(50),
    l_name VARCHAR(50),
    m_name VARCHAR(50),
    dept VARCHAR(50)
);
Query OK, 0 rows affected (0.04 sec)

-- Contact Details
CREATE TABLE cntc_dets (
    code_no INT PRIMARY KEY,
    emp_no INT,
    cntc_type VARCHAR(20),
    cntc_data VARCHAR(50),
    FOREIGN KEY (emp_no) REFERENCES emp_mstr(emp_no)
);
Query OK, 0 rows affected (0.02 sec)

INSERT INTO emp_mstr VALUES
    (1, 'Ravi', 'Patil', 'S', 'Finance'),
    (2, 'Sneha', 'Deshmukh', 'A', 'HR'),
    (3, 'Amit', 'Kumar', 'R', 'IT'),
    (4, 'Neha', 'Joshi', 'P', 'Sales');
Query OK, 4 rows affected (0.02 sec)
Records: 4  Duplicates: 0  Warnings: 0

INSERT INTO cntc_dets VALUES
    (10, 1, 'Email', 'ravi.patil@example.com'),
    (11, 2, 'Phone', '9876543210'),
    (12, 3, 'Email', 'amit.kumar@example.com');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

SELECT e.emp_no, e.f_name, e.l_name, e.dept, c.cntc_type, c.cntc_data
FROM emp_mstr e
LEFT JOIN cntc_dets c ON e.emp_no = c.emp_no;
+--------+--------+----------+---------+-----------+------------------------+
| emp_no | f_name | l_name   | dept    | cntc_type | cntc_data              |
+--------+--------+----------+---------+-----------+------------------------+
|      1 | Ravi   | Patil    | Finance | Email     | ravi.patil@example.com |
|      2 | Sneha  | Deshmukh | HR      | Phone     | 9876543210             |
|      3 | Amit   | Kumar    | IT      | Email     | amit.kumar@example.com |
|      4 | Neha   | Joshi    | Sales   | NULL      | NULL                   |
+--------+--------+----------+---------+-----------+------------------------+
4 rows in set (0.00 sec)

SELECT e.emp_no, e.f_name, e.l_name, e.dept, c.cntc_type, c.cntc_data
FROM emp_mstr e
RIGHT JOIN cntc_dets c ON e.emp_no = c.emp_no;
+--------+--------+----------+---------+-----------+------------------------+
| emp_no | f_name | l_name   | dept    | cntc_type | cntc_data              |
+--------+--------+----------+---------+-----------+------------------------+
|      1 | Ravi   | Patil    | Finance | Email     | ravi.patil@example.com |
|      2 | Sneha  | Deshmukh | HR      | Phone     | 9876543210             |
|      3 | Amit   | Kumar    | IT      | Email     | amit.kumar@example.com |
+--------+--------+----------+---------+-----------+------------------------+
3 rows in set (0.00 sec)

