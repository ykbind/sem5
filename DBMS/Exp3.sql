create database exp3;
use exp3;

create table Department(
Dep_ID int primary key,
Dep_Name varchar(20)
);

create table Employee(
empID int primary key,
FirstName varchar(20),
LastName varchar(20),
Salary int,
MobNo varchar(15),
Dep_ID int,
foreign key (Dep_ID) references Department(Dep_ID)
);

insert into Department values (01,'IT'),(02,'Maintainance'),(03,'Sales');
insert into Department values (04,'Operations');
insert into Employee values (101,'Kaustubh','Natu',70000,'8459590023',01);
insert into Employee values (102,'abc','ABC',100000,'2318795567',03),(103,'pqr','PQR',80000,'7832857375',02);
insert into Employee values (104,'xyz','XYZ',50000,'887325473',null);

-- Inner Join
select FirstName,Dep_Name
from Employee
inner join Department on Employee.Dep_ID=Department.Dep_ID;

-- Left Join
select d.Dep_Name,e.FirstName
from Department d
left join employee e on d.Dep_ID=e.Dep_ID; 

-- Right Join
select d.Dep_Name,e.FirstName
from Department d
right join Employee e on e.Dep_ID=d.Dep_ID;

-- Full Outer Join
select d.Dep_Name,e.FirstName
from Department d
left join employee e on d.Dep_ID=e.Dep_ID
union
select d.Dep_Name,e.FirstName
from Department d
right join Employee e on e.Dep_ID=d.Dep_ID;

-- Subqueries
select * from employee
where Dep_ID in ( select Dep_ID from Department where Dep_Name in ('IT','Sales'));

-- Views
create view ListofEmployees as
select empId, FirstName, LastName from Employee;

create view Emp_Dep_Info as
select e.FirstName, d.Dep_Name from 
Employee e inner join Department d on e.Dep_ID=d.Dep_ID;


