drop function teacher_salary;

delimiter //
create function teacher_salary(dept varchar(20))
returns numeric(12,2) deterministic
begin
	declare done boolean default false;
	declare total_salary numeric(12,2) default 0;
	declare d varchar(20);
	declare s numeric(8,2);
	declare cur cursor for
		select dept_name, salary from instructor;
	declare continue handler for not found set done = true;
	open cur;
	fetch cur into d, s;
	repeat
		if d = dept then
			set total_salary = total_salary + s;
		end if;
		fetch cur into d, s;
	until done end repeat;
	close cur;
	return total_salary;
end//

delimiter ;

select dept_name, teacher_salary(dept_name) from department;