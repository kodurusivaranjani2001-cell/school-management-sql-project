-- Show all students in class1_students
select student_name from class1_students;
select * from class1_students;
-- Display only female students from class3_students.
select student_name from class3_students
where gender='female';
-- for full details
select * from class3_students
where gender like '%female%';
-- List names and ages of all students in class4_students who are 10 years old.
select student_name,age from class4_students
where age=10;
-- Retrieve all staff names from teaching_staff.
 select name from teaching_staff;
-- Show all subjects taught by teaching staff.
select subject_name from  teaching_staff;
-- Find all male teachers from teaching_staff.
select name from teaching_staff 
where gender='male';
-- List all departments from nonteaching_staff.
select department from nonteaching_staff;
-- Show all non-teaching staff above 40 years old.
select name from nonteaching_staff
where age >40;
-- Display all students ordered by age (ascending).
select *
from (
select student_name,age  from class1_students
union all 
select student_name,age from class2_students
union all
select student_name,age from class3_students
union all 
select student_name,age from class4_students
union all 
select student_name, age from class5_students) as all_students
order  by age asc;
-- Show top 5 youngest students in class2_students.
select student_name
from class2_students
order by age asc 
limit 5;
-- Show all students in class5_students where age = 11.
select student_name from class5_students
where age = 11;
-- Get all teachers who teach either Maths or English.
select name from teaching_staff 
where subject_name = 'maths' or subject_name='english';

select name from teaching_staff 
 where subject_name in('english','maths');
-- Display all non-teaching staff except those in the “cleaning” department.
select name, department from nonteaching_staff
where department <> 'cleaning';
-- Find all students whose names start with ‘A’.
select student_name from  class1_students where student_name like 'A%' or student_name like 'a%'
union all
select student_name from class2_students where student_name like 'A%'
union all 
select student_name from  class3_students where student_name like 'A%'
union all
select student_name from  class4_students where student_name like 'A%'
union all 
select  student_name from  class5_students where  student_name like 'A%';
-- Find students whose names end with ‘a’.
select student_name from  class1_students where student_name like '%a' 
union all
select student_name from class2_students where student_name like '%a'
union all 
select student_name from  class3_students where student_name like '%a'
union all
select student_name from  class4_students where student_name like '%a'
union all 
select  student_name from  class5_students where  student_name like '%a';

select * from class1_students where left(student_name,2)='sh';

-- List all male students aged between 6 and 8.
select student_name from  class1_students where gender='male' and age between 6 and 8
union all
select student_name from class2_students where gender='male' and age between 6 and 8
union all 
select student_name from  class3_students where gender='male' and age between 6 and 8
union all
select student_name from  class4_students where gender='male' and age between 6 and 8
union all 
select  student_name from  class5_students where  gender='male' and age between 6 and 8;
-- Show all female students in class4 with age < 10.
select student_name from  class4_students where gender='female' and age <10;
-- Display teachers whose name length is more than 5 characters.
select name from teaching_staff where length(name)=5;
-- Find students with null or unpaid fee (paid_amount IS NULL).
select c1_students.student_name 
from s_students.class1_students c1_students
join s_fee.class1fee schoolfee
on c1_students.student_id=schoolfee.student_id
where schoolfee.paid_amount is  null or schoolfee.paid_amount = 'unpaid'
union all 
select c2_students.student_name 
from s_students.class2_students c2_students
join s_fee.class2fee schoolfee
on c2_students.student_id=schoolfee.student_id
where schoolfee.paid_amount is  null or schoolfee.paid_amount = 'unpaid'
union all 
select c3_students.student_name 
from s_students.class3_students c3_students
join s_fee.class3fee schoolfee
on c3_students.student_id=schoolfee.student_id
where schoolfee.paid_amount is  null or schoolfee.paid_amount = 'unpaid'
union all 
select c4_students.student_name 
from s_students.class4_students c4_students
join s_fee.class4fee schoolfee
on c4_students.student_id=schoolfee.student_id
where schoolfee.paid_amount is  null or schoolfee.paid_amount = 'unpaid'
union all 
select c5_students.student_name 
from s_students.class5_students c5_students
join s_fee.class5fee schoolfee
on c5_students.student_id=schoolfee.student_id
where schoolfee.paid_amount is  null or schoolfee.paid_amount = 'unpaid';
-- Get all students with full payment done (balance = 0).
select student_name from s_students.class1_students c1_students
left join s_fee.class1fee c1fee
on c1_students.student_id=c1fee.student_id
where balance=0
union all 
select student_name from s_students.class2_students c2_students
left join s_fee.class2fee c2fee
on c2_students.student_id=c2fee.student_id
where balance=0
union all
select student_name from s_students.class3_students c3_students
left join s_fee.class3fee c3fee
on c3_students.student_id=c3fee.student_id
where balance=0
union all
select student_name from s_students.class4_students c4_students
left join s_fee.class4fee c4fee
on c4_students.student_id=c4fee.student_id
where balance=0
union all
select student_name from s_students.class5_students c5_students
left join s_fee.class5fee c5fee
on c5_students.student_id=c5fee.student_id
where balance=0;
# aggregations
-- Count total number of students in class1_students.
select coalesce(student_id,'total') as student_id,
count(*) as total_students
from class1_students
group by student_id
with rollup;
-- Count number of female students in class2.
select coalesce(student_id,'total') as student_id,
count(*) as total_student
from class2_students
where gender='female'
group by student_id
with rollup;

select count(*) as total_female_students
from class2_students
where gender='female';

-- Find the average age of students in class3.
select avg(age) as average_age_allstudents
from class3_students;

select round(avg(age),2) as avg_age_allstudents
from class3_students;
-- Show the total fee collected from class4fee.
select sum(paid_amount) as Tfeecollected
from class4fee;
-- Calculate total pending balance for each class (use class1fee–class5fee).
select * from (
select sum(balance) as total_pending_balance from class1fee 
union
select sum(balance) as total_pending_balance from class2fee
union
select sum(balance) as total_pending_balance from class3fee
union
select sum(balance) as total_pending_balance from class4fee
union
select sum(balance) as total_pending_balance from class5fee)as total_pending_balance
;
select 'Class 1' as class_name, SUM(balance) as total_pending_balance from class1fee
union all
select 'Class 2', sum(balance) from class2fee
union all
select  'Class 3', sum(balance) from class3fee
union all
select  'Class 4', sum(balance) from class4fee
union all
select  'Class 5', sum(balance) from class5fee;

select 
    coalesce((select sum(balance) from class1fee), 0) +
    coalesce((select sum(balance) from class2fee), 0) +
    coalesce((select sum(balance) from class3fee), 0) +
    coalesce((select sum(balance) from class4fee), 0) +
    coalesce((select sum(balance) from class5fee), 0) as total_pending_balance;
-- Find total fee paid by student_id = 5 in class5.
select sum(c5fee.paid_amount) as totalfeepaid,c5students.student_id
from  s_fee.class5fee c5fee
join s_students.class5_students c5students
on c5fee.student_id=c5students.student_id
where c5students.student_id=5
;
-- Count how many teachers are male and female.
select gender,count(*) as gendercount
from teaching_staff
group by gender;
-- Find average age of non-teaching staff by department.
select department,avg(age) from nonteaching_staff
group by department;
-- Find the subject with the most teachers.
select subject_name,count(*) as teacher_count
from teaching_staff
group by subject_name
order by teacher_count desc
limit 1;
-- Calculate total revenue from all classes (sum of paid_amount).
select sum(paid_amount) as totalrevenue from class1fee
union all
select sum(paid_amount) from class2fee
union all 
select sum(paid_amount) from class3fee
union all 
select sum(paid_amount) from class4fee
union all
select sum(paid_amount) from class5fee
;
select 
coalesce((select sum(paid_amount) from  class1fee),0)+
coalesce((select sum(paid_amount) from class2fee),0)+
coalesce((select sum(paid_amount) from class3fee),0)+
coalesce((select sum(paid_amount) from class4fee),0)+
coalesce((select sum(paid_amount) from class5fee),0) as totalrevenue;

-- Join class1_students with class1fee to show student name, total amount, paid amount, and balance.
select c1students.student_name, c1fee.totall_amount, c1fee.paid_amount,c1fee.balance
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id;
-- Do the same for class2_students and class2fee.
select c2students.student_name, c2fee.totall_amount, c2fee.paid_amount,c2fee.balance
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id;
-- Find students who haven’t paid any amount (paid_amount = 0).
select c1students.student_name,c1fee.paid_amount
from s_students.class1_students c1students
join  s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
where paid_amount=0
union all
select c2students.student_name,c2fee.paid_amount
from s_students.class2_students c2students
join  s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
where paid_amount=0
union all
select c3students.student_name,c3fee.paid_amount
from s_students.class3_students c3students
join  s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
where paid_amount=0
union all
select c4students.student_name,c4fee.paid_amount
from s_students.class4_students c4students
join  s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
where paid_amount=0
union all 
select c5students.student_name,c5fee.paid_amount
from s_students.class5_students c5students
join  s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id
where paid_amount=0;
-- Show students who have paid partial fees (balance > 0).
select c1students.student_name,c1fee.paid_amount
from s_students.class1_students c1students
join  s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
where balance>0
union all
select c2students.student_name,c2fee.paid_amount
from s_students.class2_students c2students
join  s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
where balance>0
union all
select c3students.student_name,c3fee.paid_amount
from s_students.class3_students c3students
join  s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
where balance>0
union all
select c4students.student_name,c4fee.paid_amount
from s_students.class4_students c4students
join  s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
where balance>0
union all 
select c5students.student_name,c5fee.paid_amount
from s_students.class5_students c5students
join  s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id
where balance>0;
-- Find students who paid full fees (balance = 0).
select c1students.student_name,c1fee.paid_amount
from s_students.class1_students c1students
join  s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
where balance=0
union all
select c2students.student_name,c2fee.paid_amount
from s_students.class2_students c2students
join  s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
where balance=0
union all
select c3students.student_name,c3fee.paid_amount
from s_students.class3_students c3students
join  s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
where balance=0
union all
select c4students.student_name,c4fee.paid_amount
from s_students.class4_students c4students
join  s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
where balance=0
union all 
select c5students.student_name,c5fee.paid_amount
from s_students.class5_students c5students
join  s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id
where balance=0;
-- Join across databases (s_students and s_fee) to display student name and fee status for class4.
select c4students.student_name,
case
when c4fee.balance=0 then 'paid full'
when c4fee.balance>0 then 'pending'
else 'unknown'
end as fee_status
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id;
-- Get total collected fees per class by joining all fee tables.
select
coalesce((select sum(paid_amount)from class1fee),0)+
coalesce((select sum(paid_amount)from class2fee),0)+
coalesce((select sum(paid_amount)from class3fee),0)+
coalesce((select sum(paid_amount)from class4fee),0)+
coalesce((select sum(paid_amount)from class5fee),0) as total_fee_collected;
-- Find which student in class5 has paid the most.
select c5students.student_name,max(c5fee.paid_amount) as max_paid
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id
group by c5students.student_name
order by max_paid desc 
limit 1;
-- Find which student in class3 has the highest balance.
select c3students.student_name ,max(c3fee.balance) as max_balance
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
group by c3students.student_name
order by max_balance desc
limit 1;
-- Create a combined report showing class name, total amount, total collected, and total balance.
select 'class 1' as class_name,
sum(c1fee.totall_amount) as total_amount,
sum(c1fee.paid_amount) as total_collected,
sum(c1fee.balance) as total_balance
from s_fee.class1fee c1fee
union all 
select 'class 2' as class_name,
sum(c2fee.totall_amount) as total_amount,
sum(c2fee.paid_amount) as total_collected,
sum(c2fee.balance) as total_balance
from s_fee.class2fee c2fee
union all
select 'class 3' as class_name,
sum(c3fee.totall_amount) as total_amount,
sum(c3fee.paid_amount) as total_collected,
sum(c3fee.balance) as total_balance
from s_fee.class3fee c3fee
union all
select 'class 4' as class_name,
sum(c4fee.totall_amount) as total_amount,
sum(c4fee.paid_amount) as total_collected,
sum(c4fee.balance) as total_balance
from s_fee.class4fee c4fee
union all
select 'class 5' as class_name,
sum(c5fee.totall_amount) as total_amount,
sum(c5fee.paid_amount) as total_collected,
sum(c5fee.balance) as total_balance
from s_fee.class5fee c5fee;
# advamced filters and functions
-- Find all students whose names have exactly 5 letters.
select student_name from class1_students where length(student_name)=5
union all
select student_name from class2_students where length(student_name)=5
union all
select student_name from class3_students where length(student_name)=5
union all
select student_name from class4_students where length(student_name)=5
union all
select student_name from class5_students where length(student_name)=5;
-- Get all students whose names contain ‘ya’.
select student_name from class1_students where student_name like '%ya%'
union all
select student_name from class2_students where student_name like '%ya%'
union all
select student_name from class3_students where student_name like '%ya%'
union all
select student_name from class4_students where student_name like '%ya%'
union all
select student_name from class5_students where student_name like '%ya%';
-- Find students whose fee balance is greater than half of total fee.
select c1students.student_name
from s_students.class1_students c1students
left join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
where c1fee.balance > (totall_amount/2)
union all 
select c2students.student_name
from s_students.class2_students c2students
left join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
where c2fee.balance > (totall_amount/2)
union all
select c3students.student_name
from s_students.class3_students c3students
left join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
where c3fee.balance > (totall_amount/2)
union all
select c4students.student_name
from s_students.class4_students c4students
left join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
where c4fee.balance > (totall_amount/2)
union all
select c5students.student_name
from s_students.class5_students c5students
left join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id
where c5fee.balance > (totall_amount/2);
-- Display staff names in uppercase.
select upper(name) from teaching_staff;
-- Display first 3 letters of each teacher’s name.
select left(name,3) from teaching_staff;
-- Concatenate student name and gender (e.g., "Aarav Kumar - Male").
select concat_ws(' - ',student_name,gender) as custom_name from class1_students;
-- Create a new column showing “Paid_Status” = 'Paid', 'Partial', or 'Unpaid'.
select c1students.student_name,
case
when balance=0 then 'paid'
when balance > 0 then 'partial or unpaid'
else  'not found'
end as paid_status
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
union all 
select c2students.student_name,
case
when balance=0 then 'paid'
when balance > 0 then 'partial or unpaid'
else  'not found'
end as paid_status
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
union all
select c3students.student_name,
case
when balance=0 then 'paid'
when balance > 0 then 'partial or unpaid'
else  'not found'
end as paid_status
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
union all 
select c4students.student_name,
case
when balance=0 then 'paid'
when balance > 0 then 'partial or unpaid'
else  'not found'
end as paid_status
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
union all 
select c5students.student_name,
case
when balance=0 then 'paid'
when balance > 0 then 'partial or unpaid'
else  'not found'
end as paid_status
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id;
-- Find % of total fee paid by each student (paid_amount / total_amount * 100).
select c1students.student_name,
(paid_amount/totall_amount * 100) as percentage_total_fee
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
union all 
select c2students.student_name,
(paid_amount/totall_amount * 100) as percentage_total_fee
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
union all
select c3students.student_name,
(paid_amount/totall_amount * 100) as percentage_total_fee
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
union all
select c4students.student_name,
(paid_amount/totall_amount * 100) as percentage_total_fee
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
union all 
select c5students.student_name,
(paid_amount/totall_amount * 100) as percentage_total_fee
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id;
-- Rank students in each class by paid_amount (use RANK() or DENSE_RANK()).
select c1students.student_name,
dense_rank() over(partition by 'class 1' order by c1fee.paid_amount desc) as rnk_no
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
union all 
select c2students.student_name,
dense_rank() over(partition by 'class 2' order by c2fee.paid_amount desc) as rnk_no
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
union all 
select c3students.student_name,
dense_rank() over(partition by 'class 3' order by c3fee.paid_amount desc) as rnk_no
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
union all
select c4students.student_name,
dense_rank() over(partition by 'class 4' order by c4fee.paid_amount desc) as rnk_no
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
union all 
select c5students.student_name,
dense_rank() over(partition by 'class 4' order by c5fee.paid_amount desc) as rnk_no
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id;
-- List top 3 students by paid_amount per class.
select * from (
select 'class 1' as class_name,  c1students.student_name,c1fee.paid_amount
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
order by c1fee.paid_amount desc
limit 3) as class1
union all 
select * from (
select 'class 2' as class_name, c2students.student_name,c2fee.paid_amount
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
order by c2fee.paid_amount desc
limit 3) as class2
union all 
select * from (
select 'class 3' as class_name, c3students.student_name,c3fee.paid_amount
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
order by c3fee.paid_amount desc
limit 3) as class3
union all 
select * from (
select 'class 4' as class_name,c4students.student_name,c4fee.paid_amount
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
order by c4fee.paid_amount desc
limit 3) as class4
union all 
select * from (
select 'class 5' as class_name,c5students.student_name,c5fee.paid_amount
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id
order by c5fee.paid_amount desc
limit 3)as class5;
# 🔴 DATA RELATIONSHIPS & COMPARISONS
-- Find classes where the average fee balance is more than ₹10,000.
select * from (
select 'class 1' as class_name ,avg(c1fee.balance) as avgc1balance
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id)as avgbalanceofclass1
where avgc1balance>10000
union all 
select * from (
select 'class 2' as class_name ,avg(c2fee.balance) as avgc2balance
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id)as avgbalanceofclass2
where avgc2balance>10000
union all 
select * from (
select 'class 3' as class_name ,avg(c3fee.balance) as avgc3balance
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id)as avgbalanceofclass3
where avgc3balance>10000
union all 
select * from (
select 'class 4' as class_name ,avg(c4fee.balance) as avgc4balance
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id)as avgbalanceofclass4
where avgc4balance>10000
union all 
select * from (
select 'class 5' as class_name ,avg(c5fee.balance) as avgc5balance
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id)as avgbalanceofclass5
where avgc5balance>10000;
-- Compare total collected fees between class1fee and class5fee.
select 'class 1' as class_name ,sum(paid_amount) as total_collected
from s_fee.class1fee
union all
select 'class 5' as class_name ,sum(paid_amount) as total_collected
from s_fee.class5fee;
-- Find students common in multiple classes (if any IDs reused).
select c1students.student_name
from s_students.class1_students c1students
inner join s_students.class2_students c2students
on c1students.student_id=c2students.student_id
inner join  s_students.class3_students c3students
on c1students.student_id=c3students.student_id
inner join  s_students.class4_students c4students
on c1students.student_id=c4students.student_id
inner join  s_students.class5_students c5students
on c1students.student_id=c5students.student_id;
-- Compare average age of students in class1 vs class5.
select 'class 1' as class_name, avg(age) as avg_c1student
from s_students.class1_students
union all 
select 'class 1' as class_name, avg(age) as avg_c5student
from s_students.class5_students;
-- List which gender has paid more fees on average per class.
select 'class 1' as class_name , gender, avg(c1fee.paid_amount) as avg_paid
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
group by gender
union all
select 'class 2' as class_name , gender, avg(c2fee.paid_amount) as avg_paid
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
group by gender
union all
select 'class 3' as class_name , gender, avg(c3fee.paid_amount) as avg_paid
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
group by gender
union all
select 'class 4' as class_name , gender, avg(c4fee.paid_amount) as avg_paid
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
group by gender
union all 
select 'class 5' as class_name , gender, avg(c5fee.paid_amount) as avg_paid
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id
group by gender
order by class_name, avg_paid desc;
-- Create a summary table of fee collection (Class | Collected | Pending).
select 'class 1' as class_name , sum(paid_amount) as collectecd, sum(balance) as pending
from s_fee.class1fee 
group by class_name
union all
select 'class 2' as class_name , sum(paid_amount) as collectecd, sum(balance) as pending
from s_fee.class2fee 
group by class_name
union all 
select 'class 3' as class_name , sum(paid_amount) as collectecd, sum(balance) as pending
from s_fee.class3fee 
group by class_name
union all 
select 'class 4' as class_name , sum(paid_amount) as collectecd, sum(balance) as pending
from s_fee.class4fee 
group by class_name
union all 
select 'class 5' as class_name , sum(paid_amount) as collectecd, sum(balance) as pending
from s_fee.class5fee 
group by class_name
order by class_name;
-- Find percentage of students who have fully paid vs partially paid.
select c1students.student_name,
case when c1fee.balance=0 then 'fully paid'
when c1fee.balance>0 then 'partially paid'
else 'not fount'
end as paid_status
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id;


-- Percentage of students who have fully vs partially paid (Class 1)
select 
    paid_status,
    count(*) as student_count,
    round(100.0 * count(*) / (select count(*) 
                              from s_students.class1_students c1 
                              join s_fee.class1fee f 
                              on c1.student_id = f.student_id), 2) as percentage
from (
    select 
        case 
            when c1fee.balance = 0 then 'Fully Paid'
            when c1fee.balance > 0 then 'Partially Paid'
            else 'Not Found'
        end as paid_status
    from s_students.class1_students c1students
    join s_fee.class1fee c1fee
      on c1students.student_id = c1fee.student_id
) as status_summary
group by paid_status;

-- Identify top 5 high-paying students overall (across all classes).
select c1students.student_name,c1fee.paid_amount
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
union all
select c2students.student_name,c2fee.paid_amount
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
union all
select c3students.student_name,c3fee.paid_amount
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
union all
select c4students.student_name,c4fee.paid_amount
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
union all
select c5students.student_name,c5fee.paid_amount
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id
order by paid_amount desc
limit 5;
-- Find the youngest student who paid full fee.
select 
c1students.student_name,
c1students.age,
case 
when c1fee.balance = 0 then 'full paid'
else 'not fully paid'
end as payment_status
from s_students.class1_students c1students
join s_fee.class1fee c1fee 
on c1students.student_id = c1fee.student_id
order by c1students.age asc
limit 1;

select class_name, student_name, age, payment_status
from (
    select 
        'Class 1' as class_name,
        c1students.student_name,
        c1students.age,
        case 
            when c1fee.balance = 0 then 'Fully Paid'
            else 'Not Fully Paid'
        end as payment_status,
        row_number() over (partition by 'Class 1' order by c1students.age asc) as rn
    from s_students.class1_students c1students
    join s_fee.class1fee c1fee on c1students.student_id = c1fee.student_id

    union all

    select 
        'Class 2' as class_name,
        c2students.student_name,
        c2students.age,
        case 
            when c2fee.balance = 0 then 'Fully Paid'
            else 'Not Fully Paid'
        end as payment_status,
        row_number() over (partition by 'Class 2' order by c2students.age asc) as rn
    from s_students.class2_students c2students
    join s_fee.class2fee c2fee on c2students.student_id = c2fee.student_id

    union all

    select 
        'Class 3' as class_name,
        c3students.student_name,
        c3students.age,
        case 
            when c3fee.balance = 0 then 'Fully Paid'
            else 'Not Fully Paid'
        end as payment_status,
        row_number() over (partition by 'Class 3' order by c3students.age asc) as rn
    from s_students.class3_students c3students
    join s_fee.class3fee c3fee on c3students.student_id = c3fee.student_id

    union all

    select 
        'Class 4' as class_name,
        c4students.student_name,
        c4students.age,
        case 
            when c4fee.balance = 0 then 'Fully Paid'
            else 'Not Fully Paid'
        end as payment_status,
        row_number() over (partition by 'Class 4' order by c4students.age asc) as rn
    from s_students.class4_students c4students
    join s_fee.class4fee c4fee on c4students.student_id = c4fee.student_id

    union all

    select 
        'Class 5' as class_name,
        c5students.student_name,
        c5students.age,
        case 
            when c5fee.balance = 0 then 'Fully Paid'
            else 'Not Fully Paid'
        end as payment_status,
        row_number() over (partition by 'Class 5' order by c5students.age asc) as rn
    from s_students.class5_students c5students
    join s_fee.class5fee c5fee on c5students.student_id = c5fee.student_id
) ranked
where rn = 1
order by class_name;
    
-- Find the oldest unpaid student (balance = total_amount).
select c1students.student_name ,c1students.age,c1fee.balance
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
where c1fee.balance=c1fee.totall_amount
order by c1students.age desc
limit 1;


select student_name,age,balance,class_name
from(
select c1students.student_name, c1students.age,c1fee.balance,'class 1' as class_name
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
where c1fee.balance=c1fee.totall_amount
union all
select c2students.student_name, c2students.age,c2fee.balance,'class 2' as class_name
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
where c2fee.balance=c2fee.totall_amount
union all
select c3students.student_name, c3students.age,c3fee.balance,'class 3' as class_name
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
where c3fee.balance=c3fee.totall_amount
union all
select c4students.student_name, c4students.age,c4fee.balance,'class 4' as class_name
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
where c4fee.balance=c4fee.totall_amount
union all
select c5students.student_name, c5students.age,c5fee.balance,'class 5' as class_name
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id
where c5fee.balance=c5fee.totall_amount ) as un_paid_students
order by age desc 
limit 1;
# CASE, SUBQUERIES & ADVANCED JOINS
/* Use a CASE statement to classify students:

‘Full Paid’ if balance=0

‘Partial’ if paid_amount>0 and balance>0

‘Unpaid’ if paid_amount IS NULL or =0 */
select c1students.student_name,
case when c1fee.balance=0 then 'full paid'
when c1fee.paid_amount>0 and c1fee.balance>0 then 'partial paid'
when c1fee.paid_amount is null or c1fee.paid_amount=0 then 'unpaid'
else 'not found'
end as payment_status
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
union all 
select c2students.student_name,
case when c2fee.balance=0 then 'full paid'
when c2fee.paid_amount>0 and c2fee.balance>0 then 'partial paid'
when c2fee.paid_amount is null or c2fee.paid_amount=0 then 'unpaid'
else 'not found'
end as payment_status
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
union all
select c3students.student_name,
case when c3fee.balance=0 then 'full paid'
when c3fee.paid_amount>0 and c3fee.balance>0 then 'partial paid'
when c3fee.paid_amount is null or c3fee.paid_amount=0 then 'unpaid'
else 'not found'
end as payment_status
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
union all 
select c4students.student_name,
case when c4fee.balance=0 then 'full paid'
when c4fee.paid_amount>0 and c4fee.balance>0 then 'partial paid'
when c4fee.paid_amount is null or c4fee.paid_amount=0 then 'unpaid'
else 'not found'
end as payment_status
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
union all 
select c5students.student_name,
case when c5fee.balance=0 then 'full paid'
when c5fee.paid_amount>0 and c5fee.balance>0 then 'partial paid'
when c5fee.paid_amount is null or c5fee.paid_amount=0 then 'unpaid'
else 'not found'
end as payment_status
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id;
-- Use a subquery to find students who paid above average in class3.
select c3students.student_name
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
where c3fee.paid_amount>(select avg(c3fee.paid_amount) from
s_fee.class3fee c3fee);
-- Find the teacher with the maximum age using subquery.
select s_ts.name 
from school_staff.teaching_staff s_ts
where age in (select max(s_ts.age) from school_staff.teaching_staff s_ts);
-- Get all students whose balance is above the average balance of their class.
select c1students.student_name
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
where c1fee.balance>(select avg(c1fee.balance) from
s_fee.class1fee c1fee) 
union all 
select c2students.student_name
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
where c2fee.balance>(select avg(c2fee.balance) from
s_fee.class2fee c2fee) 
union all 
select c3students.student_name
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
where c3fee.balance>(select avg(c3fee.balance) from
s_fee.class3fee c3fee) 
union all 
select c4students.student_name
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
where c4fee.balance>(select avg(c4fee.balance) from
s_fee.class4fee c4fee) 
union all 
select c5students.student_name
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id
where c5fee.balance>(select avg(c5fee.balance) from
s_fee.class5fee c5fee);
-- Show the names of students who paid more than student_id=1.
select c1students.student_name
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
where c1fee.paid_amount > (
    select c1fee.paid_amount
    from  s_fee.class1fee c1fee
    where c1fee.student_id = 1)
union all 
select c2students.student_name
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
where c2fee.paid_amount > (
    select c2fee.paid_amount
    from  s_fee.class2fee c2fee
    where c2fee.student_id = 1)
union all 
select c3students.student_name
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
where c3fee.paid_amount > (
    select c3fee.paid_amount
    from  s_fee.class3fee c3fee
    where c3fee.student_id = 1)
union all 
select c4students.student_name
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
where c4fee.paid_amount > (
    select c4fee.paid_amount
    from  s_fee.class4fee c4fee
    where c4fee.student_id = 1)
union all 
select c5students.student_name
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id
where c5fee.paid_amount > (
    select c5fee.paid_amount
    from  s_fee.class5fee c5fee
    where c5fee.student_id = 1);
-- Retrieve teachers who are older than the average teacher age.
select s_ts.name from school_staff.teaching_staff s_ts
where s_ts.age>(select avg(s_ts.age) from school_staff.teaching_staff s_ts );
-- List students whose name appears in any fee table but not in the student table (if any).
select c1fee.student_id
from s_fee.class1fee c1fee
left join s_students.class1_students c1students
on c1fee.student_id = c1students.student_id
where c1students.student_id is null

union all

select c2fee.student_id
from s_fee.class2fee c2fee
left join s_students.class2_students c2students
on c2fee.student_id = c2students.student_id
where c2students.student_id is null

union all

select c3fee.student_id
from s_fee.class3fee c3fee
left join s_students.class3_students c3students
on c3fee.student_id = c3students.student_id
where c3students.student_id is null

union all

select c4fee.student_id
from s_fee.class4fee c4fee
left join s_students.class4_students c4students
on c4fee.student_id = c4students.student_id
where c4students.student_id is null

union all

select c5fee.student_id
from s_fee.class5fee c5fee
left join s_students.class5_students c5students
on c5fee.student_id = c5students.student_id
where c5students.student_id is null;
-- Find the teacher who teaches the same subject as another teacher.
select s_ts1.name, s_ts1.subject_name
from school_staff.teaching_staff s_ts1
join school_staff.teaching_staff s_ts2
on s_ts1.subject_name = s_ts2.subject_name
and s_ts1.staff_id != s_ts2.staff_id;
-- Get all students whose fees are more than 25000.
select c1students.student_name
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id = c1fee.student_id
where c1fee.paid_amount > 25000

union all

select c2students.student_name
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id = c2fee.student_id
where c2fee.paid_amount > 25000

union all

select c3students.student_name
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id = c3fee.student_id
where c3fee.paid_amount > 25000

union all

select c4students.student_name
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id = c4fee.student_id
where c4fee.paid_amount > 25000

union all

select c5students.student_name
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id = c5fee.student_id
where c5fee.paid_amount > 25000;
-- Find total unpaid amount (sum of balance) for each class.
select 'class 1' as class_name, sum(c1fee.balance) as total_unpaid
from s_fee.class1fee c1fee

union all

select 'class 2', sum(c2fee.balance)
from s_fee.class2fee c2fee

union all

select 'class 3', sum(c3fee.balance)
from s_fee.class3fee c3fee

union all

select 'class 4', sum(c4fee.balance)
from s_fee.class4fee c4fee

union all

select 'class 5', sum(c5fee.balance)
from s_fee.class5fee c5fee;
# 🧾 DATA ANALYTICS REPORTING QUERIES
-- Generate a class-wise fee summary (Total Fee, Paid, Pending).
select 
    'class 1' as class_name,
    sum(c1fee.totall_amount) as total_fee,
    sum(c1fee.paid_amount) as total_paid,
    sum(c1fee.balance) as total_pending,
    case 
        when sum(c1fee.balance) = 0 then 'paid'
        when sum(c1fee.balance) > 0 then 'pending'
        else 'not found'
    end as status
from s_fee.class1fee c1fee
union all
select 
    'class 2' as class_name,
    sum(c2fee.totall_amount) as total_fee,
    sum(c2fee.paid_amount) as total_paid,
    sum(c2fee.balance) as total_pending,
    case 
        when sum(c2fee.balance) = 0 then 'paid'
        when sum(c2fee.balance) > 0 then 'pending'
        else 'not found'
    end as status
from s_fee.class2fee c2fee
union all
select 
    'class 3' as class_name,
    sum(c3fee.totall_amount) as total_fee,
    sum(c3fee.paid_amount) as total_paid,
    sum(c3fee.balance) as total_pending,
    case 
        when sum(c3fee.balance) = 0 then 'paid'
        when sum(c3fee.balance) > 0 then 'pending'
        else 'not found'
    end as status
from s_fee.class3fee c3fee
union all
select 
    'class 4' as class_name,
    sum(c4fee.totall_amount) as total_fee,
    sum(c4fee.paid_amount) as total_paid,
    sum(c4fee.balance) as total_pending,
    case 
        when sum(c4fee.balance) = 0 then 'paid'
        when sum(c4fee.balance) > 0 then 'pending'
        else 'not found'
    end as status
from s_fee.class4fee c4fee
union all
select 
    'class 5' as class_name,
    sum(c5fee.totall_amount) as total_fee,
    sum(c5fee.paid_amount) as total_paid,
    sum(c5fee.balance) as total_pending,
    case 
        when sum(c5fee.balance) = 0 then 'paid'
        when sum(c5fee.balance) > 0 then 'pending'
        else 'not found'
    end as status
from s_fee.class5fee c5fee;
-- Create a gender distribution report for each class.
select 
    'class 1' as class_name,
    c1students.gender,
    count(*) as total_students
from s_students.class1_students c1students
group by c1students.gender
union all
select 
    'class 2' as class_name,
    c2students.gender,
    count(*) as total_students
from s_students.class2_students c2students
group by c2students.gender
union all
select 
    'class 3' as class_name,
    c3students.gender,
    count(*) as total_students
from s_students.class3_students c3students
group by c3students.gender
union all
select 
    'class 4' as class_name,
    c4students.gender,
    count(*) as total_students
from s_students.class4_students c4students
group by c4students.gender
union all
select 
    'class 5' as class_name,
    c5students.gender,
    count(*) as total_students
from s_students.class5_students c5students
group by c5students.gender;
-- Show a teacher-to-student ratio (use counts from staff and students).

select 
    ts.total_teachers,
    ss.total_students,
    round(ss.total_students / ts.total_teachers, 2) as student_per_teacher
from 
    (select count(*) as total_teachers from school_staff.teaching_staff) ts,
    (select 
        (select count(*) from s_students.class1_students) +
        (select count(*) from s_students.class2_students) +
        (select count(*) from s_students.class3_students) +
        (select count(*) from s_students.class4_students) +
        (select count(*) from s_students.class5_students) 
        as total_students
    ) ss;
-- Identify which class brings in the highest fee revenue.
select class_name, total_collected
from (
    select 'class 1' as class_name, sum(c1fee.paid_amount) as total_collected
    from s_fee.class1fee c1fee
    union all
    select 'class 2', sum(c2fee.paid_amount)
    from s_fee.class2fee c2fee
    union all
    select 'class 3', sum(c3fee.paid_amount)
    from s_fee.class3fee c3fee
    union all
    select 'class 4', sum(c4fee.paid_amount)
    from s_fee.class4fee c4fee
    union all
    select 'class 5', sum(c5fee.paid_amount)
    from s_fee.class5fee c5fee
) as class_fees
order by total_collected desc
limit 1;
-- Find the average collection rate per class (SUM(paid_amount)/SUM(total_amount)).
select 'class 1' as class_name ,
sum(c1fee.paid_amount)/sum(c1fee.totall_amount)  as avg_collection_rate
from s_fee.class1fee c1fee
union all 
select 'class 2' as class_name ,
sum(c2fee.paid_amount)/sum(c2fee.totall_amount)  as avg_collection_rate
from s_fee.class2fee c2fee
union all 
select 'class 3' as class_name ,
sum(c3fee.paid_amount)/sum(c3fee.totall_amount)  as avg_collection_rate
from s_fee.class3fee c3fee
union all 
select 'class 4' as class_name ,
sum(c4fee.paid_amount)/sum(c4fee.totall_amount)  as avg_collection_rate
from s_fee.class4fee c4fee
union all 
select 'class 5' as class_name ,
sum(c5fee.paid_amount)/sum(c5fee.totall_amount)  as avg_collection_rate
from s_fee.class5fee c5fee;
-- Determine which department (teaching or non-teaching) has older staff on average
select * from (
    select 'Teaching Staff' as department, avg(s_ts.age) as avg_age
    from school_staff.teaching_staff s_ts
    union all
    select 'Non-Teaching Staff', avg(s_nts.age)
    from school_staff.nonteaching_staff s_nts
) as dept_age
order by avg_age desc
limit 1;
-- Rank classes by total fee collected
select 
    class_name,
    total_collected,
    dense_rank() over(order by total_collected desc) as rank_by_collection
from (
    select 'Class 1' as class_name, sum(c1fee.paid_amount) as total_collected
    from s_fee.class1fee c1fee
    union all
    select 'Class 2', sum(c2fee.paid_amount)
    from s_fee.class2fee c2fee
    union all
    select 'Class 3', sum(c3fee.paid_amount)
    from s_fee.class3fee c3fee
    union all
    select 'Class 4', sum(c4fee.paid_amount)
    from s_fee.class4fee c4fee
    union all
    select 'Class 5', sum(c5fee.paid_amount)
    from s_fee.class5fee c5fee
) as class_summary
order by rank_by_collection;
-- Find which gender pays more fees on average across all classes
select 
    gender,
    avg(paid_amount) as avg_paid_amount
from (
    select c1students.gender, c1fee.paid_amount
    from s_students.class1_students c1students
    join s_fee.class1fee c1fee
    on c1students.student_id = c1fee.student_id

    union all

    select c2students.gender, c2fee.paid_amount
    from s_students.class2_students c2students
    join s_fee.class2fee c2fee
    on c2students.student_id = c2fee.student_id

    union all

    select c3students.gender, c3fee.paid_amount
    from s_students.class3_students c3students
    join s_fee.class3fee c3fee
    on c3students.student_id = c3fee.student_id

    union all

    select c4students.gender, c4fee.paid_amount
    from s_students.class4_students c4students
    join s_fee.class4fee c4fee
    on c4students.student_id = c4fee.student_id

    union all

    select c5students.gender, c5fee.paid_amount
    from s_students.class5_students c5students
    join s_fee.class5fee c5fee
    on c5students.student_id = c5fee.student_id
) as all_classes
group by gender
order by avg_paid_amount desc;

-- Fee payment performance report: Full, Partial, and Unpaid percentages
select 
    payment_status,
    concat(round(count(*) * 100.0 / total_students_summary.total_students, 2), '%') as percentage
from (
    -- Combine all classes with payment status
    select 
        case 
            when c1fee.balance = 0 then 'Full Paid'
            when c1fee.paid_amount = 0 then 'Unpaid'
            else 'Partial Paid'
        end as payment_status
    from s_fee.class1fee c1fee

    union all
    select 
        case 
            when c2fee.balance = 0 then 'Full Paid'
            when c2fee.paid_amount = 0 then 'Unpaid'
            else 'Partial Paid'
        end
    from s_fee.class2fee c2fee

    union all
    select 
        case 
            when c3fee.balance = 0 then 'Full Paid'
            when c3fee.paid_amount = 0 then 'Unpaid'
            else 'Partial Paid'
        end
    from s_fee.class3fee c3fee

    union all
    select 
        case 
            when c4fee.balance = 0 then 'Full Paid'
            when c4fee.paid_amount = 0 then 'Unpaid'
            else 'Partial Paid'
        end
    from s_fee.class4fee c4fee

    union all
    select 
        case 
            when c5fee.balance = 0 then 'Full Paid'
            when c5fee.paid_amount = 0 then 'Unpaid'
            else 'Partial Paid'
        end
    from s_fee.class5fee c5fee
) as all_classes
cross join (
    select count(*) as total_students from (
        select student_id from s_fee.class1fee
        union all
        select student_id from s_fee.class2fee
        union all
        select student_id from s_fee.class3fee
        union all
        select student_id from s_fee.class4fee
        union all
        select student_id from s_fee.class5fee
    ) as all_students
) as total_students_summary
group by payment_status, total_students_summary.total_students
order by 
    case payment_status
        when 'full paid' then 1
        when 'partial paid' then 2
        when 'unpaid' then 3
    end;
-- -- Find how many students per class are completely unpaid
select 
'class 1' as class_name,count(*) as unpaid_students
from s_fee.class1fee
where paid_amount = 0
union all
select 
'class 2',count(*)
from s_fee.class2fee
where paid_amount = 0
union all
select 
'class 3',count(*)
from s_fee.class3fee
where paid_amount = 0
union all
select 
'class 4',count(*)
from s_fee.class4fee
where paid_amount = 0
union all
select 'class 5',count(*)
from s_fee.class5fee
where paid_amount = 0;
# 🧮 CROSS-CLASS ANALYTICS (UNION, VIEWS, ETC.)
-- Combine all student tables into one result using UNION.
select 'class 1' as class_name,c1students.student_name,
c1students.student_id,c1students.gender,c1students.age
from s_students.class1_students c1students
union 
select 'class 2' as class_name,c2students.student_name,
c2students.student_id,c2students.gender,c2students.age
from s_students.class2_students c2students
union 
select 'class 3' as class_name,c3students.student_name,
c3students.student_id,c3students.gender,c3students.age
from s_students.class3_students c3students
union 
select 'class 4' as class_name,c4students.student_name,
c4students.student_id,c4students.gender,c4students.age
from s_students.class4_students c4students
union 
select 'class 5' as class_name,c5students.student_name,
c5students.student_id,c5students.gender,c5students.age
from s_students.class5_students c5students;
-- Combine all fee tables using UNION.
select 'class 1' as class_name,c1fee.s_no,c1fee.totall_amount,
c1fee.paid_amount,c1fee.balance,c1fee.student_id
from s_fee.class1fee c1fee
join s_students.class1_students c1students
on c1fee.student_id=c1students.student_id
union all 
select 'class 2' as class_name,c2fee.s_no,c2fee.totall_amount,
c2fee.paid_amount,c2fee.balance,c2fee.student_id
from s_fee.class2fee c2fee
join s_students.class2_students c2students
on c2fee.student_id=c2students.student_id
union all 
select 'class 3' as class_name,c3fee.s_no,c3fee.totall_amount,
c3fee.paid_amount,c3fee.balance,c3fee.student_id
from s_fee.class3fee c3fee
join s_students.class3_students c3students
on c3fee.student_id=c3students.student_id
union all 
select 'class 4' as class_name,c4fee.s_no,c4fee.totall_amount,
c4fee.paid_amount,c4fee.balance,c4fee.student_id
from s_fee.class4fee c4fee
join s_students.class4_students c4students
on c4fee.student_id=c4students.student_id
union all 
select 'class 5' as class_name,c5fee.s_no,c5fee.totall_amount,
c5fee.paid_amount,c5fee.balance,c5fee.student_id
from s_fee.class5fee c5fee
join s_students.class5_students c5students
on c5fee.student_id=c5students.student_id;
-- Create a VIEW called all_students combining all student data.
create view all_students as 
select 'class 1' as class_name,c1students.student_name,
c1students.student_id,c1students.gender,c1students.age
from s_students.class1_students c1students
union all
select 'class 2' as class_name,c2students.student_name,
c2students.student_id,c2students.gender,c2students.age
from s_students.class2_students c2students
union all
select 'class 3' as class_name,c3students.student_name,
c3students.student_id,c3students.gender,c3students.age
from s_students.class3_students c3students
union all
select 'class 4' as class_name,c4students.student_name,
c4students.student_id,c4students.gender,c4students.age
from s_students.class4_students c4students
union all
select 'class 5' as class_name,c5students.student_name,
c5students.student_id,c5students.gender,c5students.age
from s_students.class5_students c5students;
-- Create a VIEW called all_fees combining all fee data.
create view all_fees as 
select 'class 1' as class_name,c1fee.s_no,c1fee.totall_amount,
c1fee.paid_amount,c1fee.balance,c1fee.student_id
from s_fee.class1fee c1fee
join s_students.class1_students c1students
on c1fee.student_id=c1students.student_id
union all 
select 'class 2' as class_name,c2fee.s_no,c2fee.totall_amount,
c2fee.paid_amount,c2fee.balance,c2fee.student_id
from s_fee.class2fee c2fee
join s_students.class2_students c2students
on c2fee.student_id=c2students.student_id
union all 
select 'class 3' as class_name,c3fee.s_no,c3fee.totall_amount,
c3fee.paid_amount,c3fee.balance,c3fee.student_id
from s_fee.class3fee c3fee
join s_students.class3_students c3students
on c3fee.student_id=c3students.student_id
union all 
select 'class 4' as class_name,c4fee.s_no,c4fee.totall_amount,
c4fee.paid_amount,c4fee.balance,c4fee.student_id
from s_fee.class4fee c4fee
join s_students.class4_students c4students
on c4fee.student_id=c4students.student_id
union all 
select 'class 5' as class_name,c5fee.s_no,c5fee.totall_amount,
c5fee.paid_amount,c5fee.balance,c5fee.student_id
from s_fee.class5fee c5fee
join s_students.class5_students c5students
on c5fee.student_id=c5students.student_id;
select * from all_fees;
-- Create a master report combining student and fee details
select s.student_name,s.class_name,
f.paid_amount,f.balance
from all_students s
join all_fees f
on s.student_id = f.student_id
and s.class_name = f.class_name;
-- Find total fee summary across all classes
select 'class 1' as class_name,
sum(c1fee.paid_amount) as total_paid,sum(c1fee.balance) as total_balance,
sum(c1fee.totall_amount) as total_fee
from s_fee.class1fee c1fee
union all
select 'class 2' as class_name,sum(c2fee.paid_amount),
sum(c2fee.balance),sum(c2fee.totall_amount)
from s_fee.class2fee c2fee
union all
select 'class 3' as class_name,sum(c3fee.paid_amount),
sum(c3fee.balance),sum(c3fee.totall_amount)
from s_fee.class3fee c3fee
union all
select 'class 4' as class_name,sum(c4fee.paid_amount),
sum(c4fee.balance),sum(c4fee.totall_amount)
from s_fee.class4fee c4fee
union all
select 'class 5' as class_name,sum(c5fee.paid_amount),
sum(c5fee.balance),sum(c5fee.totall_amount)
from s_fee.class5fee c5fee;
-- Find average paid amount per age group (6–8, 9–10, 11+).
select 
    case 
        when s.age between 6 and 8 then '6-8'
        when s.age between 9 and 10 then '9-10'
        when s.age >= 11 then '11+'
    end as age_group,
    round(avg(f.paid_amount), 2) as avg_paid_amount
from all_students s
join all_fees f
    on s.student_id = f.student_id
    and s.class_name = f.class_name
group by 
    case 
        when s.age between 6 and 8 then '6-8'
        when s.age between 9 and 10 then '9-10'
        when s.age >= 11 then '11+'
    end
order by age_group;
-- List top 10 paying students across the entire school.
select student_name,paid_amount 
from (
select c1students.student_name,c1fee.paid_amount 
from s_students.class1_students c1students
join s_fee.class1fee c1fee
on c1students.student_id=c1fee.student_id
union all 
select c2students.student_name,c2fee.paid_amount
from s_students.class2_students c2students
join s_fee.class2fee c2fee
on c2students.student_id=c2fee.student_id
union all 
select c3students.student_name,c3fee.paid_amount
from s_students.class3_students c3students
join s_fee.class3fee c3fee
on c3students.student_id=c3fee.student_id
union all 
select c4students.student_name,c4fee.paid_amount
from s_students.class4_students c4students
join s_fee.class4fee c4fee
on c4students.student_id=c4fee.student_id
union all 
select c5students.student_name,c5fee.paid_amount
from s_students.class5_students c5students
join s_fee.class5fee c5fee
on c5students.student_id=c5fee.student_id) as all_student_fee
order by paid_amount desc
limit 10;
-- Compare total collected fees (paid_amount) per class
select 'class 1' as class_name, sum(c1fee.paid_amount) as total_collected
from s_fee.class1fee c1fee
union all
select 'class 2', sum(c2fee.paid_amount)
from s_fee.class2fee c2fee
union all
select 'class 3', sum(c3fee.paid_amount)
from s_fee.class3fee c3fee
union all
select 'class 4', sum(c4fee.paid_amount)
from s_fee.class4fee c4fee
union all
select 'class 5', sum(c5fee.paid_amount)
from s_fee.class5fee c5fee
order by class_name;

-- Compare fee structure progression using all_fees view
select 
    class_name,
    round(avg(paid_amount + balance), 2) as avg_total_fee,
    round(avg(paid_amount), 2) as avg_paid,
    round(avg(balance), 2) as avg_balance
from all_fees
group by class_name
order by class_name;
-- -- Group by age category for clearer trend analysis
select 
    case 
        when s.age between 6 and 8 then '6–8 yrs'
        when s.age between 9 and 10 then '9–10 yrs'
        else '11+ yrs'
    end as age_group,
    round(avg(f.paid_amount + f.balance), 2) as avg_total_fee
from all_students s
join all_fees f
on s.student_id = f.student_id
group by age_group
order by age_group;




