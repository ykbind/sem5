
-- For Area of Circle with radius 1 to 10

CREATE TABLE areas (
    radius INT PRIMARY KEY,
    area DECIMAL(10,2)
);

DELIMITER $$
CREATE PROCEDURE populate_areas()
BEGIN
    DECLARE v INT DEFAULT 1;
    DECLARE v_area DOUBLE;

    -- Optional: ensure table empty before inserting
    TRUNCATE TABLE areas;

    WHILE v <= 10 DO
        SET v_area = PI() * v * v;                       -- area = π * r^2
        INSERT INTO areas (radius, area)
          VALUES (v, ROUND(v_area, 2));                  -- round to 2 decimals
        SET v = v + 1;
    END WHILE;
END$$


DELIMITER ;
CALL populate_areas();


SELECT * FROM areas ORDER BY radius;


-- For Area of Circle with radius 5 to 9


CREATE TABLE areas (
    radius INT PRIMARY KEY,
    area DECIMAL(10,2)
);

DELIMITER $$
CREATE PROCEDURE populate_areas()
BEGIN
    DECLARE v INT DEFAULT 5;
    DECLARE v_area DOUBLE;
    TRUNCATE TABLE areas;
    WHILE v <= 9 DO
        SET v_area = PI() * v * v;             -- here if we put PI() * POW(r, 2);    it will also work  -- area = π * r^2
        INSERT INTO areas (radius, area)
        VALUES (v, ROUND(v_area, 2));
        SET v = v + 1;
    END WHILE;
END$$


DELIMITER ;
CALL populate_areas();


SELECT * FROM areas ORDER BY radius;




