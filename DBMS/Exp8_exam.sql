-- Create two tables O_RollCall and N_RollCall

CREATE TABLE O_RollCall (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50)
);
Query OK, 0 rows affected (0.04 sec)

CREATE TABLE N_RollCall (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50)
);
Query OK, 0 rows affected (0.05 sec)

-- Insert sample data into both tables

INSERT INTO O_RollCall (roll_no, name) VALUES (1, 'Ravi'), (2, 'Sneha');
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

INSERT INTO N_RollCall (roll_no, name) VALUES (2, 'Sneha'), (3, 'Amit'), (4, 'Neha');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

-- OPTION A: Recommended fast merge (insert rows from N that are not already in O)

INSERT INTO O_RollCall (roll_no, name)
SELECT n.roll_no, n.name
FROM N_RollCall n
WHERE NOT EXISTS (SELECT 1 FROM O_RollCall o WHERE o.roll_no = n.roll_no);
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

SELECT * FROM O_RollCall ORDER BY roll_no;
+---------+-------+
| roll_no | name  |
+---------+-------+
|       1 | Ravi  |
|       2 | Sneha |
|       3 | Amit  |
|       4 | Neha  |
+---------+-------+
4 rows in set (0.00 sec)

-- OPTION B: Cursor-based procedure (if you must use a cursor)

DELIMITER $$
CREATE PROCEDURE merge_rollcalls()
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE v_roll INT;
  DECLARE v_name VARCHAR(50);

  DECLARE cur CURSOR FOR SELECT roll_no, name FROM N_RollCall;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO v_roll, v_name;
    IF done = 1 THEN
      LEAVE read_loop;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM O_RollCall WHERE roll_no = v_roll) THEN
      INSERT INTO O_RollCall (roll_no, name) VALUES (v_roll, v_name);
    END IF;
  END LOOP;
  CLOSE cur;
  END$$
Query OK, 0 rows affected (0.03 sec)

DELIMITER ;
CALL merge_rollcalls();
Query OK, 0 rows affected (0.00 sec)

SELECT * FROM O_RollCall ORDER BY roll_no;
+---------+-------+
| roll_no | name  |
+---------+-------+
|       1 | Ravi  |
|       2 | Sneha |
|       3 | Amit  |
|       4 | Neha  |
+---------+-------+
4 rows in set (0.00 sec)

