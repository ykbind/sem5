-- A Solution

-- Create Customer Master Table
CREATE TABLE cust_mstr (
    cust_no INT PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL
);
Query OK, 0 rows affected (0.04 sec)

-- Create Address Details Table
CREATE TABLE add_dets (
    code_no INT PRIMARY KEY,
    add1 VARCHAR(100),
    add2 VARCHAR(100),
    state VARCHAR(50),
    city VARCHAR(50),
    pincode VARCHAR(10)
);
Query OK, 0 rows affected (0.01 sec)

-- Sample Data
INSERT INTO cust_mstr VALUES
    (1, 'Ravi', 'Patil'),
    (2, 'Sneha', 'Deshmukh'),
    (3, 'Amit', 'Kumar'),
    (4, 'XYZ', 'PQR');  -- as mentioned in question
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

INSERT INTO add_dets VALUES
    (1, 'MG Road', 'Akurdi', 'Maharashtra', 'Pune', '411035'),
    (2, 'FC Road', 'Deccan', 'Maharashtra', 'Pune', '411004'),
    (3, 'Main Street', 'Nigdi', 'Maharashtra', 'Pimpri', '411044'),
    (4, 'Camp Road', 'Camp', 'Maharashtra', 'Pune', '411001');
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

SELECT * FROM cust_mstr;
+---------+-------+----------+
| cust_no | fname | lname    |
+---------+-------+----------+
|       1 | Ravi  | Patil    |
|       2 | Sneha | Deshmukh |
|       3 | Amit  | Kumar    |
|       4 | XYZ   | PQR      |
+---------+-------+----------+
4 rows in set (0.00 sec)

SELECT * FROM add_dets;
+---------+----------------+--------+-------------+--------+---------+
| code_no | add1           | add2   | state       | city   | pincode |
+---------+----------------+--------+-------------+--------+---------+
|       1 |    MG Road     | Akurdi | Maharashtra | Pune   | 411035  |
|       2 |    FC Road     | Deccan | Maharashtra | Pune   | 411004  |
|       3 |    Main Street | Nigdi  | Maharashtra | Pimpri | 411044  |
|       4 |    Camp Road   | Camp   | Maharashtra | Pune   | 411001  |
+---------+----------------+--------+-------------+--------+---------+
4 rows in set (0.00 sec)

SELECT a.add1, a.add2, a.city, a.state, a.pincode
    FROM cust_mstr c
    JOIN add_dets a ON c.cust_no = a.code_no
    WHERE LOWER(c.fname) = 'xyz' AND LOWER(c.lname) = 'pqr';
+--------------+------+------+-------------+---------+
| add1         | add2 | city | state       | pincode |
+--------------+------+------+-------------+---------+
|    Camp Road | Camp | Pune | Maharashtra | 411001  |
+--------------+------+------+-------------+---------+
1 row in set (0.00 sec)

CREATE VIEW add_view AS
    SELECT city, state
    FROM add_dets;
Query OK, 0 rows affected (0.03 sec)

INSERT INTO add_dets (code_no, add1, add2, state, city, pincode)
VALUES (5, 'Hill Road', 'Bandra', 'Maharashtra', 'Mumbai', '400050');
Query OK, 1 row affected (0.02 sec)

UPDATE add_view
SET city = 'Nashik'
WHERE city = 'Pune';
Query OK, 3 rows affected (0.03 sec)
Rows matched: 3  Changed: 3  Warnings: 0

DELETE FROM add_view
WHERE city = 'Nigdi';
Query OK, 0 rows affected (0.00 sec)

SELECT * FROM add_view;
+--------+-------------+
| city   | state       |
+--------+-------------+
| Nashik | Maharashtra |
| Nashik | Maharashtra |
| Pimpri | Maharashtra |
| Nashik | Maharashtra |
| Mumbai | Maharashtra |
+--------+-------------+
5 rows in set (0.00 sec)

SELECT * FROM add_dets;
+---------+----------------+--------+-------------+--------+---------+
| code_no | add1           | add2   | state       | city   | pincode |
+---------+----------------+--------+-------------+--------+---------+
|       1 |     MG Road    | Akurdi | Maharashtra | Nashik | 411035  |
|       2 |    FC Road     | Deccan | Maharashtra | Nashik | 411004  |
|       3 |    Main Street | Nigdi  | Maharashtra | Pimpri | 411044  |
|       4 |    Camp Road   | Camp   | Maharashtra | Nashik | 411001  |
|       5 |    Hill Road   | Bandra | Maharashtra | Mumbai | 400050  |
+---------+----------------+--------+-------------+--------+---------+
5 rows in set (0.00 sec)

SELECT * FROM cust_mstr;
+---------+-------+----------+
| cust_no | fname | lname    |
+---------+-------+----------+
|       1 | Ravi  | Patil    |
|       2 | Sneha | Deshmukh |
|       3 | Amit  | Kumar    |
|       4 | XYZ   | PQR      |
+---------+-------+----------+
4 rows in set (0.00 sec)


-- B Solution


-- Branch Master Table
CREATE TABLE branch_mstr (
    b_no INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
Query OK, 0 rows affected (0.02 sec)


-- Employee Master Table
CREATE TABLE emp_mstr (
    e_mpno INT PRIMARY KEY,
    f_name VARCHAR(50),
    l_name VARCHAR(50),
    m_name VARCHAR(50),
    dept VARCHAR(50),
    desg VARCHAR(50),
    branch_no INT,
    FOREIGN KEY (branch_no) REFERENCES branch_mstr(b_no)
);
Query OK, 0 rows affected (0.02 sec)

INSERT INTO branch_mstr VALUES
    (101, 'Akurdi'),
    (102, 'Deccan'),
    (103, 'Nigdi');
Query OK, 3 rows affected (0.02 sec)
Records: 3  Duplicates: 0  Warnings: 0

INSERT INTO emp_mstr VALUES
    (1, 'Ravi', 'Patil', 'S', 'Finance', 'Manager', 101),
    (2, 'Sneha', 'Deshmukh', 'A', 'HR', 'Executive', 102),
    (3, 'Amit', 'Kumar', 'R', 'IT', 'Developer', 103),
    (4, 'Neha', 'Joshi', 'P', 'Sales', 'Officer', 101);
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

Select * From branch_mstr;
+------+--------+
| b_no | name   |
+------+--------+
|  101 | Akurdi |
|  102 | Deccan |
|  103 | Nigdi  |
+------+--------+
3 rows in set (0.00 sec)

Select * From emp_mstr;
+--------+--------+----------+--------+---------+-----------+-----------+
| e_mpno | f_name | l_name   | m_name | dept    | desg      | branch_no |
+--------+--------+----------+--------+---------+-----------+-----------+
|      1 | Ravi   | Patil    | S      | Finance | Manager   |       101 |
|      2 | Sneha  | Deshmukh | A      | HR      | Executive |       102 |
|      3 | Amit   | Kumar    | R      | IT      | Developer |       103 |
|      4 | Neha   | Joshi    | P      | Sales   | Officer   |       101 |
+--------+--------+----------+--------+---------+-----------+-----------+
4 rows in set (0.00 sec)

SELECT e.e_mpno, e.f_name, e.l_name, e.dept, e.desg, b.name AS branch_name
FROM emp_mstr e
JOIN branch_mstr b ON e.branch_no = b.b_no;
+--------+--------+----------+---------+-----------+-------------+
| e_mpno | f_name | l_name   | dept    | desg      | branch_name |
+--------+--------+----------+---------+-----------+-------------+
|      1 | Ravi   | Patil    | Finance | Manager   | Akurdi      |
|      4 | Neha   | Joshi    | Sales   | Officer   | Akurdi      |
|      2 | Sneha  | Deshmukh | HR      | Executive | Deccan      |
|      3 | Amit   | Kumar    | IT      | Developer | Nigdi       |
+--------+--------+----------+---------+-----------+-------------+
4 rows in set (0.00 sec)

