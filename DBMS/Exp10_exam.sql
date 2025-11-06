create database exp;

CREATE USER 'kaustubh'@'localhost' IDENTIFIED BY 'Strong@password';
GRANT ALL PRIVILEGES ON exp8.* TO 'kaustubh'@'localhost';

use exp;

create table Student(PRN int auto_increment primary key,Name varchar(20));

