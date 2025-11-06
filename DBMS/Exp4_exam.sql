-- Solution Part A

-- Create Customer Master Table
CREATE TABLE cust_mstr (
    custno INT PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL
);


-- Create Account/FD link table
CREATE TABLE acc_fd_cust_dets (
    codeno INT PRIMARY KEY,
    acc_fd_no INT NOT NULL,
    custno INT,
    FOREIGN KEY (custno) REFERENCES cust_mstr(custno)
);


-- Create Fixed Deposit Details Table
CREATE TABLE fd_dets (
    fd_sr_no INT PRIMARY KEY,
    amt DECIMAL(10,2)
);


INSERT INTO cust_mstr VALUES
    (1, 'Ravi', 'Patil'),
    (2, 'Sneha', 'Deshmukh'),
    (3, 'Amit', 'Kumar'),
    (4, 'Neha', 'Joshi');


INSERT INTO acc_fd_cust_dets VALUES
    (101, 201, 1),
    (102, 202, 2),
    (103, 203, 3),
    (104, 204, 4);


INSERT INTO fd_dets VALUES
    (201, 4500),
    (202, 7000),
    (203, 10000),
    (204, 3000);


SELECT * FROM cust_mstr;


SELECT * FROM acc_fd_cust_dets;

SELECT * FROM fd_dets;


-- List the customer holding fixed deposit of amount more than 5000 

SELECT c.custno, c.fname, c.lname, f.amt
    FROM cust_mstr c
    JOIN acc_fd_cust_dets a ON c.custno = a.custno
    JOIN fd_dets f ON a.acc_fd_no = f.fd_sr_no
    WHERE f.amt > 5000;



-- Solution Part B

-- Create view on cust_mstr and acc_fd_cust_dets tables by selecting any one column from each table perform insert update delete operations


CREATE VIEW cust_acc_view AS
    SELECT c.fname, a.acc_fd_no
    FROM cust_mstr c
    JOIN acc_fd_cust_dets a ON c.custno = a.custno;


-- Insert into base tables first
INSERT INTO cust_mstr VALUES (5, 'Raj', 'More');


INSERT INTO acc_fd_cust_dets VALUES (105, 205, 5);


INSERT INTO fd_dets VALUES (205, 8000);


SELECT * FROM cust_acc_view;

UPDATE acc_fd_cust_dets
SET acc_fd_no = 202
WHERE codeno = 101;


DELETE FROM acc_fd_cust_dets
WHERE codeno = 104;


SELECT * FROM cust_acc_view;

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


-- Contact Details
CREATE TABLE cntc_dets (
    code_no INT PRIMARY KEY,
    emp_no INT,
    cntc_type VARCHAR(20),
    cntc_data VARCHAR(50),
    FOREIGN KEY (emp_no) REFERENCES emp_mstr(emp_no)
);


INSERT INTO emp_mstr VALUES
    (1, 'Ravi', 'Patil', 'S', 'Finance'),
    (2, 'Sneha', 'Deshmukh', 'A', 'HR'),
    (3, 'Amit', 'Kumar', 'R', 'IT'),
    (4, 'Neha', 'Joshi', 'P', 'Sales');


INSERT INTO cntc_dets VALUES
    (10, 1, 'Email', 'ravi.patil@example.com'),
    (11, 2, 'Phone', '9876543210'),
    (12, 3, 'Email', 'amit.kumar@example.com');

SELECT e.emp_no, e.f_name, e.l_name, e.dept, c.cntc_type, c.cntc_data
FROM emp_mstr e
LEFT JOIN cntc_dets c ON e.emp_no = c.emp_no;


SELECT e.emp_no, e.f_name, e.l_name, e.dept, c.cntc_type, c.cntc_data
FROM emp_mstr e
RIGHT JOIN cntc_dets c ON e.emp_no = c.emp_no;



