-- declare tables

CREATE TABLE Account (
    Acc_no INT PRIMARY KEY,
    branch_name VARCHAR(50) NOT NULL,
    balance DECIMAL(12,2) CHECK (balance >= 0)
    );


CREATE TABLE Branch (
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_city VARCHAR(50),
    assets DECIMAL(15,2)
    );


CREATE TABLE Customer (
    cust_name VARCHAR(50) PRIMARY KEY,
    cust_street VARCHAR(100),
    cust_city VARCHAR(50)
    );


CREATE TABLE Depositor (
    cust_name VARCHAR(50),
    acc_no INT,
    PRIMARY KEY (cust_name, acc_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (acc_no) REFERENCES Account(Acc_no)
    );


CREATE TABLE Loan (
    loan_no INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount DECIMAL(12,2) CHECK (amount > 0),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);


CREATE TABLE Borrower (
    cust_name VARCHAR(50),
    loan_no INT,
    PRIMARY KEY (cust_name, loan_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (loan_no) REFERENCES Loan(loan_no)
);

-- insert values

INSERT INTO Branch VALUES
    ('Akurdi', 'Pune', 5000000),
    ('Nigdi', 'Pune', 4000000),
    ('Deccan', 'Pune', 6000000);

 INSERT INTO Account VALUES
    (101, 'Akurdi', 25000),
    (102, 'Nigdi', 18000),
    (103, 'Akurdi', 32000),
    (104, 'Deccan', 27000);

INSERT INTO Customer VALUES
    ('Ravi', 'MG Road', 'Pune'),
    ('Sneha', 'FC Road', 'Pune'),
    ('Amit', 'Akurdi', 'Pune'),
    ('Neha', 'Nigdi', 'Pune');


INSERT INTO Depositor VALUES
    ('Ravi', 101),
    ('Sneha', 103),
    ('Amit', 104);


INSERT INTO Loan VALUES
    (201, 'Akurdi', 50000),
    (202, 'Nigdi', 40000),
    (203, 'Deccan', 60000);


INSERT INTO Borrower VALUES
    ('Ravi', 201),
    ('Neha', 202),
    ('Amit', 203);

--Create above tables with appropriate constraints like primary key, foreign key, not null etc. with suitable data

SELECT * FROM Account;


SELECT * FROM Branch;


SELECT * FROM Customer;


SELECT * FROM Depositor;


SELECT * FROM Loan;


SELECT * FROM Borrower;

--Q.2. Create view/alias for customer table as cust.
CREATE VIEW cust AS SELECT * FROM Customer;


SELECT * FROM cust;

--Q.3 Add customer phone number in Customer table.
ALTER TABLE Customer ADD phone_no VARCHAR(15);


SELECT * FROM Customer;

--Q.4 Delete phone number attribute from Customer table.
ALTER TABLE Customer DROP COLUMN phone_no;


SELECT * FROM Customer;

--Q.5. Find the names of all branches in loan relation.
SELECT DISTINCT branch_name
FROM Loan;

--Q.6. Find all customers who have a loan from bank. Find their names,loan_no and loan amount.      
SELECT B.cust_name, L.loan_no, L.amount
    FROM Borrower B
    JOIN Loan L ON B.loan_no = L.loan_no;

--Q.7. List all customers in alphabetical order who have loan from Akurdi branch.
SELECT C.cust_name
    FROM Customer C
    JOIN Borrower B ON C.cust_name = B.cust_name
    JOIN Loan L ON B.loan_no = L.loan_no
    WHERE L.branch_name = 'Akurdi'
    ORDER BY C.cust_name ASC;

--Q.8. Find average account balance at Akurdi branch.
SELECT branch_name, AVG(balance) AS avg_balance
FROM Account
WHERE branch_name = 'Akurdi'
GROUP BY branch_name;

--Q.9. Find no. of depositors at each branch.
SELECT A.branch_name, COUNT(DISTINCT D.cust_name) AS no_of_depositors
FROM Account A
JOIN Depositor D ON A.Acc_no = D.acc_no
GROUP BY A.branch_name;






