create database exp2;
use exp2;

create table Student(
	PRN numeric(5) primary key,
    First_Name varchar(20),
    Last_Name varchar(20),
    Department varchar(30)
);
create table Professor(
	Prof_ID numeric(5) primary key,
    P_First_Name varchar(30),
    P_Last_Name varchar(30),
    Department varchar(30)
);
create table Course(
	Course_Id numeric(3) primary key,
    Course_Name varchar(50),
    Credits int
);
create table Enrollment(
	Enroll_Id numeric(3) primary key,
    PRN numeric(5),
    Course_Id numeric(3),
    foreign key (PRN) references Student(PRN),
    foreign key (Course_Id) references Course(Course_Id)
); 

insert into Student values (00001,'Kaustubh','Natu','Computer');
insert into Student values (00002,'Anubhav','Patil','ENTC');

insert into Professor values(10001,'A','a','Computer');

insert into Course values(002,'DBMS',6);

insert into Course values(001,'Operating Systems',4);

insert into Enrollment values(101,00002,001);

select * from Student;
select * from Professor;
select * from Course;
select * from Enrollment;

select * from Student where PRN=00001;

update Enrollment set Course_Id=002 where Enroll_Id=101;

delete from Course where Course_Id=001; 

create index idx_std_lastname on Student(Last_Name);

