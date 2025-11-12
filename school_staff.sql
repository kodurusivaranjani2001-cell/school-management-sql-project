create database if not exists school_staff;
use school_staff;

create table teaching_staff(staff_id int auto_increment primary key,
							name varchar(100),
                            gender enum('male','female'),
                            age int,
                            subject_name varchar(50));
create table nonteaching_staff(staff_id int auto_increment primary key,
								name varchar(100),
                                gender enum('male','female'),
                                age int,
                                department varchar(60));

insert into teaching_staff(name ,gender ,age ,subject_name ) value
('ram','male',40,'maths'),('shyam','male',35,'social'),
('mahalakshmi','female',38,'telugu'),('stephini','female',45,'english'),
('david','male',40,'sports'),('venkat','male',32,'hindhi');
insert into nonteaching_staff(name,gender,age,department) values
('sithamma','female',50,'cleaning'),('raghu','male',45,'cleaning'),
('ramulu','female',49,'cleaning'),('narayana','male',39,'gardening'),('balu','male',38,'bell master');






