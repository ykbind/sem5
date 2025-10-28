CREATE database exp6;
USE exp6;

CREATE TABLE N_RollCall (
    id INT PRIMARY KEY,
    student_name VARCHAR(100),
    course VARCHAR(100)
);

CREATE TABLE O_RollCall (
    id INT PRIMARY KEY,
    student_name VARCHAR(100),
    course VARCHAR(100)
);

INSERT INTO N_RollCall VALUES 
(1, 'A', 'M1'),
(2, 'B', 'DBMS'),
(3, 'C', 'AI');


DELIMITER $$

CREATE PROCEDURE merge_rollcall(IN roll_id INT)
BEGIN
    DECLARE v_id INT;
    DECLARE v_name VARCHAR(100);
    DECLARE v_course VARCHAR(100);
    DECLARE v_done INT DEFAULT 0;

    DECLARE cur_roll CURSOR FOR
        SELECT id, student_name, course
        FROM N_RollCall
        WHERE id >= roll_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

    OPEN cur_roll;

    read_loop: LOOP
        FETCH cur_roll INTO v_id, v_name, v_course;

        IF v_done = 1 THEN
            LEAVE read_loop;
        END IF;

        IF NOT EXISTS (SELECT 1 FROM O_RollCall WHERE id = v_id) THEN
            INSERT INTO O_RollCall (id, student_name, course)
            VALUES (v_id, v_name, v_course);
        END IF;
    END LOOP;

    CLOSE cur_roll;
END$$

DELIMITER ;

CALL merge_rollcall(1);
SELECT * FROM O_RollCall;
