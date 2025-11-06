
CREATE TABLE Account (
    Acc_no INT PRIMARY KEY,
    branch_name VARCHAR(50) NOT NULL,
    balance DECIMAL(12,2) CHECK (balance >= 0)
    );
Query OK, 0 rows affected (0.06 sec)

CREATE TABLE Branch (
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_city VARCHAR(50),
    assets DECIMAL(15,2)
    );
Query OK, 0 rows affected (0.05 sec)

CREATE TABLE Customer (
    cust_name VARCHAR(50) PRIMARY KEY,
    cust_street VARCHAR(100),
    cust_city VARCHAR(50)
    );
Query OK, 0 rows affected (0.03 sec)

CREATE TABLE Depositor (
    cust_name VARCHAR(50),
    acc_no INT,
    PRIMARY KEY (cust_name, acc_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (acc_no) REFERENCES Account(Acc_no)
    );
Query OK, 0 rows affected (0.04 sec)

CREATE TABLE Loan (
    loan_no INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount DECIMAL(12,2) CHECK (amount > 0),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);
Query OK, 0 rows affected (0.06 sec)

CREATE TABLE Borrower (
    cust_name VARCHAR(50),
    loan_no INT,
    PRIMARY KEY (cust_name, loan_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (loan_no) REFERENCES Loan(loan_no)
);
Query OK, 0 rows affected (0.06 sec)

INSERT INTO Branch VALUES
    ('Akurdi', 'Pune', 5000000),
    ('Nigdi', 'Pune', 4000000),
    ('Deccan', 'Pune', 6000000);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

 INSERT INTO Account VALUES
    (101, 'Akurdi', 25000),
    (102, 'Nigdi', 18000),
    (103, 'Akurdi', 32000),
    (104, 'Deccan', 27000);
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

INSERT INTO Customer VALUES
    ('Ravi', 'MG Road', 'Pune'),
    ('Sneha', 'FC Road', 'Pune'),
    ('Amit', 'Akurdi', 'Pune'),
    ('Neha', 'Nigdi', 'Pune');
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

INSERT INTO Depositor VALUES
    ('Ravi', 101),
    ('Sneha', 103),
    ('Amit', 104);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

INSERT INTO Loan VALUES
    (201, 'Akurdi', 50000),
    (202, 'Nigdi', 40000),
    (203, 'Deccan', 60000);
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

INSERT INTO Borrower VALUES
    ('Ravi', 201),
    ('Neha', 202),
    ('Amit', 203);
Query OK, 3 rows affected (0.02 sec)
Records: 3  Duplicates: 0  Warnings: 0


SELECT * FROM Account;
+--------+-------------+----------+
| Acc_no | branch_name | balance  |
+--------+-------------+----------+
|    101 | Akurdi      | 25000.00 |
|    102 | Nigdi       | 18000.00 |
|    103 | Akurdi      | 32000.00 |
|    104 | Deccan      | 27000.00 |
+--------+-------------+----------+
4 rows in set (0.00 sec)

SELECT * FROM Branch;
+-------------+-------------+------------+
| branch_name | branch_city | assets     |
+-------------+-------------+------------+
| Akurdi      | Pune        | 5000000.00 |
| Deccan      | Pune        | 6000000.00 |
| Nigdi       | Pune        | 4000000.00 |
+-------------+-------------+------------+
3 rows in set (0.00 sec)

SELECT * FROM Customer;
+-----------+-------------+-----------+
| cust_name | cust_street | cust_city |
+-----------+-------------+-----------+
| Amit      | Akurdi      | Pune      |
| Neha      | Nigdi       | Pune      |
| Ravi      | MG Road     | Pune      |
| Sneha     | FC Road     | Pune      |
+-----------+-------------+-----------+
4 rows in set (0.00 sec)

SELECT * FROM Depositor;
+-----------+--------+
| cust_name | acc_no |
+-----------+--------+
| Ravi      |    101 |
| Sneha     |    103 |
| Amit      |    104 |
+-----------+--------+
3 rows in set (0.00 sec)

SELECT * FROM Loan;
+---------+-------------+----------+
| loan_no | branch_name | amount   |
+---------+-------------+----------+
|     201 | Akurdi      | 50000.00 |
|     202 | Nigdi       | 40000.00 |
|     203 | Deccan      | 60000.00 |
+---------+-------------+----------+
3 rows in set (0.00 sec)

SELECT * FROM Borrower;
+-----------+---------+
| cust_name | loan_no |
+-----------+---------+
| Ravi      |     201 |
| Neha      |     202 |
| Amit      |     203 |
+-----------+---------+
3 rows in set (0.00 sec)

CREATE VIEW cust AS SELECT * FROM Customer;
Query OK, 0 rows affected (0.01 sec)

SELECT * FROM cust;
+-----------+-------------+-----------+
| cust_name | cust_street | cust_city |
+-----------+-------------+-----------+
| Amit      | Akurdi      | Pune      |
| Neha      | Nigdi       | Pune      |
| Ravi      | MG Road     | Pune      |
| Sneha     | FC Road     | Pune      |
+-----------+-------------+-----------+
4 rows in set (0.00 sec)

ALTER TABLE Customer ADD phone_no VARCHAR(15);
Query OK, 0 rows affected (0.08 sec)
Records: 0  Duplicates: 0  Warnings: 0

SELECT * FROM Customer;
+-----------+-------------+-----------+----------+
| cust_name | cust_street | cust_city | phone_no |
+-----------+-------------+-----------+----------+
| Amit      | Akurdi      | Pune      | NULL     |
| Neha      | Nigdi       | Pune      | NULL     |
| Ravi      | MG Road     | Pune      | NULL     |
| Sneha     | FC Road     | Pune      | NULL     |
+-----------+-------------+-----------+----------+
4 rows in set (0.00 sec)

ALTER TABLE Customer DROP COLUMN phone_no;
Query OK, 0 rows affected (0.09 sec)
Records: 0  Duplicates: 0  Warnings: 0

SELECT * FROM Customer;
+-----------+-------------+-----------+
| cust_name | cust_street | cust_city |
+-----------+-------------+-----------+
| Amit      | Akurdi      | Pune      |
| Neha      | Nigdi       | Pune      |
| Ravi      | MG Road     | Pune      |
| Sneha     | FC Road     | Pune      |
+-----------+-------------+-----------+
4 rows in set (0.00 sec)

SELECT DISTINCT branch_name
FROM Loan;
+-------------+
| branch_name |
+-------------+
| Akurdi      |
| Deccan      |
| Nigdi       |
+-------------+
3 rows in set (0.00 sec)

SELECT B.cust_name, L.loan_no, L.amount
    FROM Borrower B
    JOIN Loan L ON B.loan_no = L.loan_no;
+-----------+---------+----------+
| cust_name | loan_no | amount   |
+-----------+---------+----------+
| Ravi      |     201 | 50000.00 |
| Neha      |     202 | 40000.00 |
| Amit      |     203 | 60000.00 |
+-----------+---------+----------+
3 rows in set (0.00 sec)

SELECT C.cust_name
    FROM Customer C
    JOIN Borrower B ON C.cust_name = B.cust_name
    JOIN Loan L ON B.loan_no = L.loan_no
    WHERE L.branch_name = 'Akurdi'
    ORDER BY C.cust_name ASC;
+-----------+
| cust_name |
+-----------+
| Ravi      |
+-----------+
1 row in set (0.00 sec)

SELECT branch_name, AVG(balance) AS avg_balance
FROM Account
WHERE branch_name = 'Akurdi'
GROUP BY branch_name;
+-------------+--------------+
| branch_name | avg_balance  |
+-------------+--------------+
| Akurdi      | 28500.000000 |
+-------------+--------------+
1 row in set (0.00 sec)

SELECT A.branch_name, COUNT(DISTINCT D.cust_name) AS no_of_depositors
FROM Account A
JOIN Depositor D ON A.Acc_no = D.acc_no
GROUP BY A.branch_name;
+-------------+------------------+
| branch_name | no_of_depositors |
+-------------+------------------+
| Akurdi      |                2 |
| Deccan      |                1 |
+-------------+------------------+
2 rows in set (0.00 sec)


