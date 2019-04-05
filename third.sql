drop function countA;
drop function variety;
DELIMITER //
create function countA(theID varchar(5))
returns int
begin
	declare done boolean default 0;
	declare Anum int default 0;
	declare thegrade varchar(2);
	declare cursor2 
    cursor for select grade from takes,student where takes.ID=student.ID and student.ID=theID;
	declare continue handler for NOT FOUND set done = 1;
    open cursor2;
    repeat
		fetch next from cursor2 into thegrade; 
		if ((thegrade='A+' or thegrade='A ')AND not done)
        then set Anum=Anum+1;
        end if;
	until done end repeat;
    close cursor2;
    return Anum;
end//
create function variety(theID varchar(5))
returns varchar(1)
begin 
    declare done boolean default 0;
    declare thegrade varchar(2);
	declare anum int default 0;
	declare cursor1 
    cursor for select grade from takes,student where takes.ID=student.ID and student.ID=theID;
    declare continue handler for NOT FOUND set done = 1;
   
	set anum=countA(theID);
	if(anum=0)
	then
    return 'C';
	end if;
	if(countA(theID)>1)
    then
    return 'A';
	end if;
	if(countA(theID)=1)
    then
	   open cursor1;
       repeat 
	   fetch next from cursor1 into thegrade; 
       if ((thegrade='C+' or thegrade='C ' or thegrade='C-') AND not done)
       then return 'C';
       end if;
	until done end repeat;
    close cursor1;
	return 'B';
	end if;
    
end//
DELIMITER ;
select dept_name, variety(ID) level,ID s_id, name s_name,countA(ID) A_num
from student
where variety(ID)!='C'
order by dept_name,variety(ID),A_num desc; 