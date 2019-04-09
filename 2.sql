DROP FUNCTION teacher_salary;
DELIMITER //
CREATE FUNCTION teacher_salary(d_name VARCHAR(20)) 
RETURNS INTEGER
BEGIN
DECLARE done INT DEFAULT 0;


DECLARE sal INTEGER;


DECLARE totsal INTEGER DEFAULT 0;


DECLARE mycurcor CURSOR FOR SELECT
	salary
FROM
	instructor
WHERE
	dept_name = d_name;


DECLARE CONTINUE HANDLER FOR NOT FOUND
SET done = 1;

OPEN mycurcor;


REPEAT
	FETCH mycurcor INTO sal;


IF NOT done THEN

SET totsal = totsal + sal;


END
IF;

UNTIL done
END
REPEAT
;

CLOSE mycurcor;

RETURN totsal;


END//
DELIMITER ; 
select dept_name, teacher_salary(dept_name) from department; 