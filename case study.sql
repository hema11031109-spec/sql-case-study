create table students(student_id int primary key,student_name text,
city varchar(20),phone bigint,email varchar(20),enrollment_date date)
insert into students values(1,'hema','chennai',8122035492,'hema@gmail.com','2026-07-01'),
(2,'sharmi','pdkt',9941931843,'sharmi@gmail.com','2025-01-12'),
(3,'rajee','trichy',8098404016,'rajee@gmail.com','2026-03-11'),
(4,'pavi','chennai',8122014541,'pavi@gmail.com','2025-06-23'),
(5,'sasi','trichy',9843299740,'sasi@gmail.com','2026-07-20');

select * from  students
drop table studentsæ

create table courses(course_id int,student_id int,foreign key(student_id) references students(student_id),
course_name text,fees int)
insert into courses values(101,1,'SQL',7000),(102,2,'Data Analytics',16000),
(103,3,'Data Analytics with AI',20000),(104,4,'full stack developement',19000),
(105,5,'full stack AI',25000)
select * from courses
drop table courses

create table enrollments(enrollment_id int,course_id int,student_id int,foreign key(student_id)
references students(student_id),enrollment_date date)

insert into enrollments values(1001,101,1,'2025-03-12'),(1002,102,2,'2026-07-01'),
(1003,103,3,'2025-06-28'),(1004,104,4,'2026-07-10'),(1005,105,5,'2024-12-24')
drop table enrollments
select * from enrollments

create table payments(payment_id int,student_id int,foreign key(student_id) 
references students(student_id),payment_amount int,payment_date date)
insert into payments values(101,1,5000,'2026-07-27'),(102,2,6000,'2025-12-28'),(103,3,9000,'2026-02-11'),
(104,4,12000,'2025-04-12'),(105,5,13000,'2026-03-27');
select * from payments
drop table payments
-- question 1
select * from students where enrollment_date > '2025-01-01';
-- question 2
select distinct course_name from courses;
-- question 3
select * from students where student_name like 'A%' AND city IN('chennai','madurai');
-- question 4
select * from courses where fees between 15000 AND 40000;
-- question 5
select * from courses order by fees desc limit 5;
-- question 6
select course_id,count(student_id) from enrollments group by course_id;
-- question 7
select course_id,count(student_id) from enrollments group by course_id having count(student_id)>20;
-- question 8
select sum(payment_amount),avg(payment_amount),max(payment_amount),min(payment_amount) from payments;
-- question 9
select student_name,course_name from enrollments inner join students on 
enrollments.student_id=students.student_id inner join courses on
enrollments.course_id=courses.course_id;
-- question 10
select s.student_name,c.course_name,p.payment_amount,p.payment_date from students s join enrollments e
on s.student_id=e.student_id join courses c on e.course_id=c.course_id join payments p on 
s.student_id =p.student_id;
-- question 11 
select * from students where student_id not in (select student_id from payments);
-- question 12
select * from payments where payment_amount > (select avg(payment_amount) from payments);
-- question 13
select c.course_name,count(e.student_id) as total_enrollments from courses c join enrollments e on c.course_id=e.course_id
group by c.course_name order by total_enrollments DESC LIMIT 3;
-- question 14
select email,count(*) from students group by email having count(*)>1;
-- question 15
select * from students where phone is null OR email is null;
-- question 16
select * ,upper(student_name),length(student_name),substring(student_name,1,4) from students;

-- question 17
select course_name,fees,
case
when fees < 6000 then 'Basic'
when fees between 6000 AND 20000 then 'Intermediate'
else 'Advanced'
end
from courses;
-- question 18
select  payment_id,payment_amount,
case 
when payment_amount <=5000 then 'pending payment'
when payment_amount <=9000 then 'partialy paid'
else 'paid'
end
from payments
-- question 19
create index idx_student_id on enrollments(student_id);
create index idx_course_id on enrollments(course_id);
-- question 20
select s.student_name,
       c.course_name,
	   sum(p.payment_amount) as 
	   total_amount_paid,
	   case
          when sum(p.payment_amount)>= c.fees then 'paid'
          when sum(p.payment_amount)>0 then 'partially paid'
          else 'pending'
       end as payment_status 
from students s
join enrollments e 
on s.student_id=e.student_id 
join courses c
on e.course_id=c.course_id 
left join payments p
on s.student_id=p.student_id
group by 
  s.student_name,
  c.course_name,
  c.fees
order by total_amount_paid DESC;


 



