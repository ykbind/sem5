create database Exp7;

use Exp7;

create table Library(
	RecordNo int primary key, 
	BookTitle varchar(30), 
	DOI datetime, 
	DOR datetime, 
	R_Status varchar(10)
);

create table Library_Audit(
	RecordNo int primary key, 
    BookTitle varchar(30), 
    DOI datetime, 
    DOR datetime, 
    R_Status varchar(10), 
    Last_Update datetime, 
    Operation varchar(10)
);


insert into Library values(01,"Harry Potter","2005-02-12","2005-04-11","Returned");

insert into Library values(02,"The Time Machine","2025-02-12","2025-04-11","Pending");

insert into Library values(03,"The Immortals of Meluha","2025-11-02","2026-01-01","Returned");

select * from Library;

DELIMITER $$
	create trigger insert_trig
	after
	insert on Library
	for each row
	begin
		insert into Library_Audit values(new.RecordNo, new.BookTitle, new.DOI, new.DOR, new.R_Status, now(),"Insert");
	end; 
	
	create trigger update_trig
	after
	update on Library
	for each row
	begin
		insert Library_Audit values(new.RecordNo, new.BookTitle, new.DOI, new.DOR, new.R_Status, now(),"Update");
	end;


	create trigger delete_trig
	before
	delete on Library
	for each row
	begin
		insert Library_Audit values(old.RecordNo, old.BookTitle, old.DOI, old.DOR, old.R_Status, now(),"Delete");
	end $$
Delimiter ;

insert into Library values(04,"Harry Potter Part 2","2005-05-12","2005-07-11","Pending");
update Library set R_Status="Returned" where RecordNo=2;
delete from Library where RecordNo=1;

select * from Library_Audit;
