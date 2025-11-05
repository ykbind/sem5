-- Create Library table

CREATE TABLE Library (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    book_name VARCHAR(100),
    author VARCHAR(100),
    price DECIMAL(8,2)
);
Query OK, 0 rows affected (0.02 sec)

-- Insert sample data into Library table

INSERT INTO Library (book_name, author, price) VALUES
    ('Python Basics', 'John Doe', 450.00),
    ('SQL Mastery', 'Jane Smith', 550.00),
    ('AI Fundamentals', 'Tom Clark', 700.00);
Query OK, 3 rows affected (0.03 sec)
Records: 3  Duplicates: 0  Warnings: 0

-- Create Library_Audit table to log updates and deletions

CREATE TABLE Library_Audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    book_name VARCHAR(100),
    author VARCHAR(100),
    price DECIMAL(8,2),
    action_type VARCHAR(20),
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
Query OK, 0 rows affected (0.03 sec)

-- Create trigger for UPDATE operation

DELIMITER $$
CREATE TRIGGER trg_Library_Update
BEFORE UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (book_id, book_name, author, price, action_type)
    VALUES (OLD.book_id, OLD.book_name, OLD.author, OLD.price, 'UPDATED');
END$$
Query OK, 0 rows affected (0.00 sec)

DELIMITER ;

-- Create trigger for DELETE operation

DELIMITER $$
CREATE TRIGGER trg_Library_Delete
BEFORE DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (book_id, book_name, author, price, action_type)
    VALUES (OLD.book_id, OLD.book_name, OLD.author, OLD.price, 'DELETED');
END$$
Query OK, 0 rows affected (0.02 sec)

DELIMITER ;

-- Test UPDATE and DELETE operations to see triggers in action

UPDATE Library
SET price = 600.00
WHERE book_id = 2;
Query OK, 1 row affected (0.03 sec)
Rows matched: 1  Changed: 1  Warnings: 0

DELETE FROM Library
WHERE book_id = 1;
Query OK, 1 row affected (0.00 sec)

SELECT * FROM Library;
+---------+-----------------+------------+--------+
| book_id | book_name       | author     | price  |
+---------+-----------------+------------+--------+
|       2 | SQL Mastery     | Jane Smith | 600.00 |
|       3 | AI Fundamentals | Tom Clark  | 700.00 |
+---------+-----------------+------------+--------+
2 rows in set (0.00 sec)

SELECT * FROM Library_Audit;
+----------+---------+---------------+------------+--------+-------------+---------------------+
| audit_id | book_id | book_name     | author     | price  | action_type | action_date         |
+----------+---------+---------------+------------+--------+-------------+---------------------+
|        1 |       2 | SQL Mastery   | Jane Smith | 550.00 | UPDATED     | 2025-11-04 19:39:32 |
|        2 |       1 | Python Basics | John Doe   | 450.00 | DELETED     | 2025-11-04 19:39:41 |
+----------+---------+---------------+------------+--------+-------------+---------------------+
2 rows in set (0.00 sec)

