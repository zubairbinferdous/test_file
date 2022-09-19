-- rejected
CREATE VIEW view_student_performance_with_progress AS
SELECT student_id, batch_id, course_id,
ROUND(((AVG(`attendence`)*(SELECT attendence FROM edu_student_progress AS progressTable WHERE progressTable.course_id=course_id AND progressTable.valid=1 LIMIT 1))/100), 2) AS gained_attendence, 
ROUND(((AVG(`class_mark`)*(SELECT class_mark FROM edu_student_progress AS progressTable WHERE progressTable.course_id=course_id AND progressTable.valid=1 LIMIT 1))/100), 2) AS gained_class_mark, 
ROUND(((AVG(`assignment`)*(SELECT assignment FROM edu_student_progress AS progressTable WHERE progressTable.course_id=course_id AND progressTable.valid=1 LIMIT 1))/100), 2) AS gained_assignment, 
ROUND(((AVG(`quiz`)*(SELECT quiz FROM edu_student_progress AS progressTable WHERE progressTable.course_id=course_id AND progressTable.valid=1 LIMIT 1))/100), 2) AS gained_quiz_mark, 
ROUND(((AVG(`video_watch_time`)*(SELECT video_watch_time FROM edu_student_progress AS progressTable WHERE progressTable.course_id=course_id AND progressTable.valid=1 LIMIT 1))/100), 2) AS gained_video_watch_time, 
ROUND(((AVG(`practice_time`)*(SELECT practice_time FROM edu_student_progress AS progressTable WHERE progressTable.course_id=course_id AND progressTable.valid=1 LIMIT 1))/100), 2) AS gained_practice_time
FROM `edu_student_performance_view` GROUP BY student_id, batch_id;

-- active
CREATE VIEW view_student_class_performance_with_progress AS
SELECT per.`id`, per.student_id, per.course_id, per.batch_id, per.assign_batch_classes_id, per.course_class_id, 
ROUND(((per.practice_time*prog.practice_time)/100),2) AS practice_time, 
ROUND(((per.video_watch_time*prog.video_watch_time)/100),2) AS video_watch_time, 
ROUND(((per.attendence*prog.attendence)/100),2) AS attendence, 
ROUND(((per.class_mark*prog.class_mark)/100),2) AS class_mark, 
ROUND(((per.assignment*prog.assignment)/100),2) AS assignment,
ROUND(((per.quiz*prog.quiz)/100),2) AS quiz
FROM `edu_student_performances` per INNER JOIN edu_student_progress AS prog ON prog.batch_id = per.batch_id WHERE per.valid=1;

-- active
CREATE VIEW view_student_performance_with_progress AS
SELECT student_id, batch_id, course_id,
ROUND(AVG(`attendence`), 2) AS gained_attendence, 
ROUND(AVG(`class_mark`), 2) AS gained_class_mark, 
ROUND(AVG(`assignment`), 2) AS gained_assignment, 
ROUND(AVG(`quiz`), 2) AS gained_quiz_mark, 
ROUND(AVG(`video_watch_time`), 2) AS gained_video_watch_time, 
ROUND(AVG(`practice_time`), 2) AS gained_practice_time
FROM `view_student_class_performance_with_progress` GROUP BY student_id, batch_id;