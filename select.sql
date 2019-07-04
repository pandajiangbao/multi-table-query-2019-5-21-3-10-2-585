# 1.查询同时存在1课程和2课程的情况

select student.* from student,student_course
where student.id = student_course.studentId and student_course.courseId = 1 and 
exists (select 1 FROM student_course stu_course
where student_course.studentId = stu_course.studentId and stu_course.courseId = 2);

# 2.查询同时存在1课程和2课程的情况

select student.* from student,student_course
where student.id = student_course.studentId and student_course.courseId = 1 and 
exists (select 1 FROM student_course stu_course
where student_course.studentId = stu_course.studentId and stu_course.courseId = 2);

# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩

select
    t1.studentId,
    t2.name,
    avg(t1.score) as avg_score
from
    student_course t1
left join student t2 on
    t1.studentId = t2.id
group by
    t1.studentId
having
    avg(t1.score) >= 60;
	
# 4.查询在student_course表中不存在成绩的学生信息的SQL语句

select * from student 
where not exists(select 1 from student_course where student.id = student_course.studentId);

# 5.查询所有有成绩的SQL
select stu.id, stu.name, count(stuc.courseId), sum(score)
from student stu , student_course stuc
where stu.id = stuc.studentId
group by stu.id, stu.name
order by sum(score) desc

# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息

select student.* from student,student_course
where student.id = student_course.studentId and student_course.courseId = 1 and 
exists (select 1 FROM student_course stu_course
where student_course.studentId = stu_course.studentId and stu_course.courseId = 2);


# 7.检索1课程分数小于60，按分数降序排列的学生信息

select stu.* from student_course sc , student stu
where stu.id = sc.studentId and sc.courseId = 1 and sc.score <60
order by score desc;

# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列

select sc.courseId,course.name,avg(sc.score) 
from student_course sc , course
where sc.courseId = course.id
group by sc.courseId
order by avg(sc.score) desc,sc.courseId;

# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数

select stu.name,sc.score 
from student stu,student_course sc,course 
where stu.id = sc.studenId and sc.courseId = course.id and sc.score <60 and course.name = '数学';
