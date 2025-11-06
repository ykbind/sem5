-- Create Borrower table and Fine table

CREATE TABLE Borrower (
    Roll_no INT PRIMARY KEY,
    Name VARCHAR(50),
    DateofIssue DATE,
    NameofBook VARCHAR(100),
    Status CHAR(1)   -- I = Issued, R = Returned
);


CREATE TABLE Fine (
    Roll_no INT,
    Date DATE,
    Amt DECIMAL(10,2),
    FOREIGN KEY (Roll_no) REFERENCES Borrower(Roll_no)
);


-- Insert sample data into Borrower table

INSERT INTO Borrower VALUES
    (1, 'Ravi', '2024-10-01', 'SQL Fundamentals', 'I'),
    (2, 'Sneha', '2024-09-15', 'Python Basics', 'I'),
    (3, 'Amit', '2024-10-20', 'DBMS Concepts', 'I');


DELIMITER $$
CREATE PROCEDURE ReturnBook (
    IN p_roll_no INT,
    IN p_book_name VARCHAR(100)
)
    BEGIN
    DECLARE v_issue_date DATE;
    DECLARE v_days INT;
    DECLARE v_fine_amt DECIMAL(10,2);
    DECLARE not_found TINYINT DEFAULT 0;

    -- Exception handler for not found record
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET not_found = 1;

    -- Get issue date
    SELECT DateofIssue INTO v_issue_date
    FROM Borrower
    WHERE Roll_no = p_roll_no AND NameofBook = p_book_name AND Status = 'I';

    -- If record not found
    IF not_found = 1 OR v_issue_date IS NULL THEN
        SELECT 'No active issue found for this Roll_no and Book name' AS Message;
    ELSE
        -- Calculate number of days
        SET v_days = DATEDIFF(CURDATE(), v_issue_date);

        -- Fine calculation logic
        IF v_days BETWEEN 15 AND 30 THEN
            SET v_fine_amt = v_days * 5;
        ELSEIF v_days > 30 THEN
            SET v_fine_amt = v_days * 50;
        ELSE
            SET v_fine_amt = 0;
        END IF;

        -- Update status
        UPDATE Borrower
        SET Status = 'R'
        WHERE Roll_no = p_roll_no AND NameofBook = p_book_name;

        -- Insert fine details if applicable
        IF v_fine_amt > 0 THEN
            INSERT INTO Fine (Roll_no, Date, Amt)
            VALUES (p_roll_no, CURDATE(), v_fine_amt);
        END IF;

        -- Display message
        SELECT CONCAT('Book returned. Fine amount = Rs ', v_fine_amt) AS Message;
    END IF;
END$$


DELIMITER ;
CALL ReturnBook(2, 'Python Basics');

Query OK, 0 rows affected (0.04 sec)

-- Verify the updates

Select * From Borrower;


Select * From Fine;
