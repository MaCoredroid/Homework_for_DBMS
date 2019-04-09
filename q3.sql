drop function a_count;
drop function bonus_type;

delimiter //
create function a_count(sid varchar(5))
returns int deterministic
begin
	declare done boolean default false;
	declare cnt int default 0;
	declare i varchar(5);
	declare g varchar(2);
	declare cur cursor for
		select id, grade from takes
		where id = sid;
	declare continue handler for not found set done = true;
	open cur;
	fetch cur into i, g;
	repeat
		if g in ("A+", "A ") then
			set cnt = cnt + 1;
		end if;
		fetch cur into i, g;
	until done end repeat;
	close cur;
	return cnt;
end//

create function bonus_type(sid varchar(5))
returns varchar(2) deterministic
begin
	declare done boolean default false;
	declare typ varchar(2) default "N";
	declare a_cnt int default 0;
	declare has_c boolean default false;
	declare i varchar(5);
	declare g varchar(2);
	declare cur cursor for
		select id, grade from takes
		where id = sid;
	declare continue handler for not found set done = true;
	open cur;
	fetch cur into i, g;
	repeat
		if not (g like ("A%") or g like ("B%")) then
			set has_c = true;
			return "N";
		elseif g in ("A+", "A ") then
			set a_cnt = a_cnt + 1;
		end if;
		fetch cur into i, g;
	until done end repeat;
	close cur;
	if a_cnt >= 2 then
		set typ = "A";
	elseif a_cnt >= 1 and not has_c then
		set typ = "B";
	end if;
	return typ;
end//

delimiter ;

select dept_name, bonus_type(id) level, id s_id, name s_name, a_count(id) A_num
from student where bonus_type(id) in ("A", "B")
order by dept_name, level, A_num desc;