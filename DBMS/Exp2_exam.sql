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


ALTER TABLE Branch RENAME COLUMN assets TO Property;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

SELECT * FROM Branch;
+-------------+-------------+------------+
| branch_name | branch_city | Property   |
+-------------+-------------+------------+
| Akurdi      | Pune        | 5000000.00 |
| Deccan      | Pune        | 6000000.00 |
| Nigdi       | Pune        | 4000000.00 |
+-------------+-------------+------------+
3 rows in set (0.00 sec)

SELECT loan_no
FROM Loan
WHERE branch_name = 'Akurdi' AND amount > 12000;
+---------+
| loan_no |
+---------+
|     201 |
+---------+
1 row in set (0.00 sec)

SELECT branch_name, AVG(balance) AS avg_balance
FROM Account
GROUP BY branch_name;
+-------------+--------------+
| branch_name | avg_balance  |
+-------------+--------------+
| Akurdi      | 28500.000000 |
| Nigdi       | 18000.000000 |
| Deccan      | 27000.000000 |
+-------------+--------------+
3 rows in set (0.00 sec)

SELECT branch_name, AVG(balance) AS avg_balance
FROM Account
GROUP BY branch_name
HAVING AVG(balance) > 12000;
+-------------+--------------+
| branch_name | avg_balance  |
+-------------+--------------+
| Akurdi      | 28500.000000 |
| Nigdi       | 18000.000000 |
| Deccan      | 27000.000000 |
+-------------+--------------+
3 rows in set (0.00 sec)

SELECT COUNT(*) AS total_customers
FROM Customer;
+-----------------+
| total_customers |
+-----------------+
|               4 |
+-----------------+
1 row in set (0.00 sec)

SELECT SUM(amount) AS total_loan_amount
FROM Loan;
+-------------------+
| total_loan_amount |
+-------------------+
|         150000.00 |
+-------------------+
1 row in set (0.00 sec)

DELETE FROM Loan
WHERE amount BETWEEN 1300 AND 1500;
Query OK, 0 rows affected (0.00 sec)

SELECT * FROM Loan;
+---------+-------------+----------+
| loan_no | branch_name | amount   |
+---------+-------------+----------+
|     201 | Akurdi      | 50000.00 |
|     202 | Nigdi       | 40000.00 |
|     203 | Deccan      | 60000.00 |
+---------+-------------+----------+
3 rows in set (0.00 sec)

