select distinct student.name , course.title, takes.grade 
from student , advisor, instructor, takes, teaches, course
where student.ID=advisor.s_id AND instructor.ID=advisor.i_id AND takes.ID=student.ID AND takes.semester=teaches.semester AND takes.sec_id = teaches.sec_id AND  takes.year = teaches.year AND takes.course_id=teaches.course_id AND teaches.ID=instructor.ID AND(takes.grade="C" or takes.grade="C-")
