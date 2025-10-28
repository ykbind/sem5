create database exp4;
use exp4;

create table Circle_Area(
Radius numeric primary key,
Area numeric 
);

delimiter $$ 
create procedure AreaOfCircle()
begin
	declare v_area double;
    declare v_radius numeric default 5;
    
    declare exit handler for sqlstate '23000'
	begin 
    select 'Duplicate Entry for radius. Skipping.';
	end;

	while v_radius<=9 do
		set v_area=3.14159*v_radius*v_radius;
        insert into Circle_Area values (v_radius,v_area);
        set v_radius=v_radius+1;
    end while;
end;
$$
delimiter ;

call AreaOfCircle;

select * from Circle_Area;