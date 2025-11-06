-- A Solution

-- Create Customer Master Table
CREATE TABLE cust_mstr (
    cust_no INT PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL
);


-- Create Address Details Table
CREATE TABLE add_dets (
    code_no INT PRIMARY KEY,
    add1 VARCHAR(100),
    add2 VARCHAR(100),
    state VARCHAR(50),
    city VARCHAR(50),
    pincode VARCHAR(10)
);


-- Sample Data
INSERT INTO cust_mstr VALUES
    (1, 'Ravi', 'Patil'),
    (2, 'Sneha', 'Deshmukh'),
    (3, 'Amit', 'Kumar'),
    (4, 'XYZ', 'PQR');  -- as mentioned in question


INSERT INTO add_dets VALUES
    (1, 'MG Road', 'Akurdi', 'Maharashtra', 'Pune', '411035'),
    (2, 'FC Road', 'Deccan', 'Maharashtra', 'Pune', '411004'),
    (3, 'Main Street', 'Nigdi', 'Maharashtra', 'Pimpri', '411044'),
    (4, 'Camp Road', 'Camp', 'Maharashtra', 'Pune', '411001');


SELECT * FROM cust_mstr;

SELECT * FROM add_dets;


SELECT a.add1, a.add2, a.city, a.state, a.pincode
    FROM cust_mstr c
    JOIN add_dets a ON c.cust_no = a.code_no
    WHERE LOWER(c.fname) = 'xyz' AND LOWER(c.lname) = 'pqr';


CREATE VIEW add_view AS
    SELECT city, state
    FROM add_dets;


INSERT INTO add_dets (code_no, add1, add2, state, city, pincode)
VALUES (5, 'Hill Road', 'Bandra', 'Maharashtra', 'Mumbai', '400050');


UPDATE add_view
SET city = 'Nashik'
WHERE city = 'Pune';


DELETE FROM add_view
WHERE city = 'Nigdi';


SELECT * FROM add_view;

SELECT * FROM add_dets;


SELECT * FROM cust_mstr;


-- B Solution


-- Branch Master Table
CREATE TABLE branch_mstr (
    b_no INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);



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


INSERT INTO branch_mstr VALUES
    (101, 'Akurdi'),
    (102, 'Deccan'),
    (103, 'Nigdi');


INSERT INTO emp_mstr VALUES
    (1, 'Ravi', 'Patil', 'S', 'Finance', 'Manager', 101),
    (2, 'Sneha', 'Deshmukh', 'A', 'HR', 'Executive', 102),
    (3, 'Amit', 'Kumar', 'R', 'IT', 'Developer', 103),
    (4, 'Neha', 'Joshi', 'P', 'Sales', 'Officer', 101);


Select * From branch_mstr;

Select * From emp_mstr;

SELECT e.e_mpno, e.f_name, e.l_name, e.dept, e.desg, b.name AS branch_name
FROM emp_mstr e
JOIN branch_mstr b ON e.branch_no = b.b_no;



