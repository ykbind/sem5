-- Create Library table

CREATE TABLE Library (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    book_name VARCHAR(100),
    author VARCHAR(100),
    price DECIMAL(8,2)
);

-- Insert sample data into Library table

INSERT INTO Library (book_name, author, price) VALUES
    ('Python Basics', 'John Doe', 450.00),
    ('SQL Mastery', 'Jane Smith', 550.00),
    ('AI Fundamentals', 'Tom Clark', 700.00);


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


-- Create trigger for UPDATE operation

DELIMITER $$
CREATE TRIGGER trg_Library_Update
BEFORE UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (book_id, book_name, author, price, action_type)
    VALUES (OLD.book_id, OLD.book_name, OLD.author, OLD.price, 'UPDATED');
END$$


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


DELIMITER ;

-- Test UPDATE and DELETE operations to see triggers in action

UPDATE Library
SET price = 600.00
WHERE book_id = 2;


DELETE FROM Library
WHERE book_id = 1;


SELECT * FROM Library;


SELECT * FROM Library_Audit;




