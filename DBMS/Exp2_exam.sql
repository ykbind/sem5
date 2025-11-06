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



SELECT * FROM Account;


SELECT * FROM Branch;


SELECT * FROM Customer;


SELECT * FROM Depositor;


SELECT * FROM Loan;


SELECT * FROM Borrower;



ALTER TABLE Branch RENAME COLUMN assets TO Property;


SELECT * FROM Branch;


SELECT loan_no
FROM Loan
WHERE branch_name = 'Akurdi' AND amount > 12000;


SELECT branch_name, AVG(balance) AS avg_balance
FROM Account
GROUP BY branch_name;


SELECT branch_name, AVG(balance) AS avg_balance
FROM Account
GROUP BY branch_name
HAVING AVG(balance) > 12000;


SELECT COUNT(*) AS total_customers
FROM Customer;


SELECT SUM(amount) AS total_loan_amount
FROM Loan;


DELETE FROM Loan
WHERE amount BETWEEN 1300 AND 1500;


SELECT * FROM Loan;


