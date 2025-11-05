
-- For Area of Circle with radius 1 to 10

CREATE TABLE areas (
    radius INT PRIMARY KEY,
    area DECIMAL(10,2)
);
Query OK, 0 rows affected (0.05 sec)

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
Query OK, 0 rows affected (0.02 sec)

DELIMITER ;
CALL populate_areas();
Query OK, 1 row affected (0.09 sec)

SELECT * FROM areas ORDER BY radius;
+--------+--------+
| radius | area   |
+--------+--------+
|      1 |   3.14 |
|      2 |  12.57 |
|      3 |  28.27 |
|      4 |  50.27 |
|      5 |  78.54 |
|      6 | 113.10 |
|      7 | 153.94 |
|      8 | 201.06 |
|      9 | 254.47 |
|     10 | 314.16 |
+--------+--------+
10 rows in set (0.00 sec)




-- For Area of Circle with radius 5 to 9


CREATE TABLE areas (
    radius INT PRIMARY KEY,
    area DECIMAL(10,2)
);
Query OK, 0 rows affected (0.04 sec)

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
Query OK, 0 rows affected (0.03 sec)

DELIMITER ;
CALL populate_areas();
Query OK, 1 row affected (0.08 sec)

SELECT * FROM areas ORDER BY radius;
+--------+--------+
| radius | area   |
+--------+--------+
|      5 |  78.54 |
|      6 | 113.10 |
|      7 | 153.94 |
|      8 | 201.06 |
|      9 | 254.47 |
+--------+--------+
5 rows in set (0.00 sec)

