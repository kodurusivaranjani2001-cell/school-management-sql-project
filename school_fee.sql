create database if not exists s_fee;
use s_fee;
create table class1fee(s_no int auto_increment primary key,
						totall_amount bigint,
                        paid_amount bigint,
                        balance bigint,
                        student_id int ,
                        foreign key(student_id) references s_students.class1_students(student_id)
                        );
create table class2fee(s_no int auto_increment primary key,
						totall_amount bigint,
                        paid_amount bigint,
                        balance bigint,
                        student_id int,
						foreign key(student_id) references s_students.class2_students(student_id)
                        );
 create table class3fee(s_no int auto_increment primary key,
						totall_amount bigint,
                        paid_amount bigint,
                        balance bigint,
                        student_id int,
                        foreign key(student_id) references s_students.class3_students(student_id)
                        ) ;
 create table class4fee(s_no int auto_increment primary key,
						totall_amount bigint,
                        paid_amount bigint,
                        balance bigint,
                        student_id int,
                        foreign key(student_id) references s_students.class4_students(student_id)
                        );
create table class5fee(s_no int auto_increment primary key,
						totall_amount bigint,
                        paid_amount bigint,
                        balance bigint,
                        student_id int,
                        foreign key(student_id) references s_students.class5_students(student_id)
                        );
                        

insert into class1fee(totall_amount,
						paid_amount ,
                        balance ,
                        student_id) values 
(20000,10000,10000,3),(20000,15000,5000,8),(20000,9000,11000,2),
(20000,10000,10000,1),(20000,10000,10000,15),(20000,0,20000,11),
(20000,null,20000,10);
insert into class2fee(	totall_amount,
						paid_amount ,
                        balance ,
                        student_id) values 
(22000,10000,12000,6),(22000,15000,7000,4),(22000,9000,13000,2),
(22000,12000,10000,1),(22000,10000,12000,15),(22000,0,22000,17),
(22000,null,22000,9) ,(22000,12000,10000,5),(22000,10000,12000,14);
insert into class3fee(totall_amount,
						paid_amount ,
                        balance ,
                        student_id) values 
(24000,10000,14000,3),(24000,15000,9000,6),(24000,9000,15000,1),
(24000,10000,14000,9),(24000,12000,12000,15),(24000,20000,4000,11),
(24000,null,24000,10) ,(22000,10000,12000,19);
insert into class4fee(totall_amount,
						paid_amount ,
                        balance ,
                        student_id) values 
(26000, 10000, 16000, 1),
    (26000, 12000, 14000, 2),
    (26000, 8000, 18000, 13),
    (26000, 15000, 11000, 14),
    (26000, 20000, 6000, 5),
    (26000, 5000, 21000, 6),
    (26000, 0, 26000, 17),
    (26000, 18000, 8000, 8),
    (26000, 9000, 17000, 9),
    (26000, 13000, 13000, 10);
insert into class5fee (
    totall_amount,
    paid_amount,
    balance,
    student_id
) values
    (30000, 10000, 20000, 1),
    (30000, 15000, 15000, 2),
    (30000, 5000, 25000, 3),
    (30000, 18000, 12000, 4),
    (30000, 30000, 0, 5),
    (30000, 9000, 21000, 6),
    (30000, 12000, 18000, 7),
    (30000, 0, 30000, 8),
    (30000, 25000, 5000, 9),
    (30000, 16000, 14000, 10),
    (30000, 7000, 23000, 11),
    (30000, 13000, 17000, 12),
    (30000, 20000, 10000, 13),
    (30000, 15000, 15000, 14),
    (30000, 8000, 22000, 15),
    (30000, 30000, 0, 16),
    (30000, 11000, 19000, 17),
    (30000, 5000, 25000, 18),
    (30000, 0, 30000, 19),
    (30000, 17000, 13000, 20);


                        