create database exp5;
use exp5;

create table Stud_Marks( Roll int primary key,StudName varchar(20), total_marks int);
create table Result(
Roll int primary key,
StudName varchar(20),
Class varchar(20)
);

insert into Stud_Marks values (1,'Kaustubh',817),(2,'Anubhav',987),(3,'Raj',992),(4,'Pratik',1023); 

delimiter $$
create procedure proc_Grade(in p_roll int)
begin 
	declare v_name varchar(20);
    declare v_marks int;
    declare v_class varchar(20);
    
    select StudName,total_marks into v_name,v_marks from Stud_Marks where Roll=p_roll;
    
    if v_marks>=990 and v_marks<=1500 then
		set v_class='Distinction';
	elseif v_marks>=900 and v_marks<=989 then
		set v_class='First Class';
	elseif v_marks>=825 and v_marks<=899 then
		set v_class='Higher Second Class';
	else
		set v_class='Pass';
	end if;
    insert into Result values (p_roll,v_name,v_class);
end $$
delimiter ;

call proc_Grade(1);
call proc_Grade(2);
call proc_Grade(3);
call proc_Grade(4);

select * from Result;