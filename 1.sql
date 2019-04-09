SELECT
	student.name,
	course.title AS course_name,
	takes.grade
FROM
	advisor,
	course,
	instructor,
	student,
	takes,
	teaches
WHERE
	(
		advisor.i_ID = instructor.ID
		AND advisor.s_ID = student.ID
		AND instructor.ID = teaches.ID
		AND student.ID = takes.ID
		AND takes.course_id = teaches.course_id
		AND takes.course_id = course.course_id
		AND (
			takes.grade IN ('C ', 'C-', 'D', 'D+', 'D-')
		)
	);