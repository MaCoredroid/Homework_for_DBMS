select s.name, c.title, t1.grade
from student s, instructor i, advisor a, takes t1, teaches t2, section sec, course c
where s.id=a.s_id and i.id=a.i_id
	and s.id=t1.id and i.id=t2.id
	and t1.course_id=sec.course_id and t1.sec_id=sec.sec_id and t1.semester=sec.semester and t1.year=sec.year
	and t2.course_id=sec.course_id and t2.sec_id=sec.sec_id and t2.semester=sec.semester and t2.year=sec.year
	and sec.course_id=c.course_id
	and not (t1.grade like ("A%") or t1.grade like ("B%") or t1.grade="C+");