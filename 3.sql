DROP FUNCTION s_level;
DELIMITER //
CREATE FUNCTION s_level(s_id varchar(5))
RETURNS VARCHAR(1)
BEGIN
DECLARE num INT default 0;
SELECT anum into num
from s_anum
where ID=s_id;
IF num=1 THEN RETURN 'B';
ELSEIF num>1 THEN RETURN 'A';
ELSE return '0';
END IF;
END//
DELIMITER ;
	
DROP view s_anum;
CREATE view s_anum as
(SELECT student.ID,count(*) as anum
FROM student,takes
WHERE student.ID=takes.ID
			AND student.ID not in(SELECT student.ID
														from student,takes
														where student.ID=takes.ID AND takes.grade in ('C ','C+','C-','D','D+','D-'))
			AND takes.grade in ('A ','A+')
group by student.ID);

SELECT dept_name,s_level(student.ID) as level,student.id as s_id,student.name as s_name,s_anum.anum as A_num
FROM s_anum,student
where s_anum.ID=student.ID
order BY dept_name,level,A_num desc;