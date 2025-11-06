-- Student Grading System using Stored Procedure and Cursor

-- Create database tables

CREATE TABLE Stud_Marks (
    name VARCHAR(50),
    total_marks INT
);


CREATE TABLE Result (
    roll INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    class VARCHAR(30)
);


-- Insert sample data into Stud_Marks table

INSERT INTO Stud_Marks VALUES
    ('Ravi', 1200),
    ('Sneha', 950),
    ('Amit', 870),
    ('Neha', 800);


-- Create stored procedure to grade students based on total marks

DELIMITER $$
CREATE PROCEDURE proc_Grade()
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE v_name VARCHAR(50);
  DECLARE v_marks INT;
  DECLARE v_class VARCHAR(30);

  DECLARE cur CURSOR FOR SELECT name, total_marks FROM Stud_Marks;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO v_name, v_marks;
    IF done THEN
      LEAVE read_loop;
    END IF;

    IF v_marks BETWEEN 990 AND 1500 THEN
      SET v_class = 'Distinction';
    ELSEIF v_marks BETWEEN 900 AND 989 THEN
      SET v_class = 'First Class';
    ELSEIF v_marks BETWEEN 825 AND 899 THEN
      SET v_class = 'Higher Second Class';
    ELSE
      SET v_class = 'Fail';
    END IF;

    INSERT INTO Result (name, class) VALUES (v_name, v_class);
  END LOOP;

  CLOSE cur;
END$$

DELIMITER ;
CALL proc_Grade();


SELECT * FROM Result;



