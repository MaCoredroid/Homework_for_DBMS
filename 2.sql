drop function query_salary;
DELIMITER //
create function query_salary(thedept_name varchar(20))
returns numeric(8,2) deterministic
begin
	declare done boolean default 0;
	declare whole_salary numeric(8,2) default 0;
	declare thesalary numeric(8,2);
	declare cursor1 
	cursor for select salary from instructor where instructor.dept_name=thedept_name;
	declare continue handler for NOT FOUND set done = 1;
    open cursor1;
    repeat 
	fetch next from cursor1 into thesalary; 
		if(not done)
		then set whole_salary=whole_salary+thesalary;
		end if;
	until done end repeat;
	close cursor1;
	return whole_salary;
end//
DELIMITER ; 
select dept_name,query_salary(dept_name)
from department;
