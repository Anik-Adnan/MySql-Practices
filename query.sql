create database myDB;
use myDB;
create table student (
	id int,
    first_name varchar(20),
    last_name varchar(20),
    cgpa decimal(5,2),
    admission_date date
);
show tables;
rename table student to students;
-- drop table students;
alter table students
add phone_number varchar(15); -- add column

select * from students;


alter table students
add primary key (id); 	-- add primary key

alter table students 
rename column phone_number to email;	-- rename column name

alter table students 
add column phone_number varchar(20);	-- add column

alter table students 
modify column email varchar(50);	-- modify column

alter table students
modify email varchar(40) after cgpa;	-- mail colum come after cgpa column

alter table students 
drop column phone_number;	-- drop column

alter table students 
add column admitted_date date;



insert into students 
values(1,"Anik","Adnan",3.66,"anikadnanict17@gmail.com","2020-02-04");

select * from students;

insert into students 
values (2,"Asif","Adnan",3.76,"asifadnan@gmail.com","2020-02-04"),
    (3,"Farhad","Hossain",3.61,"farhadfood5@gmail.com","2020-02-04"),
    (4,"Munna","Pervez",3.55,"munnapervez@gmail.com","2020-02-04");
    
insert into students (id,first_name,last_name)
values (5,"Safayat","Hossain");

select  last_name,first_name
from students;

select first_name ,last_name,email
from students 
where id=2;

select id ,first_name
from students
where id < 3;

select * 
from students 
where admitted_date is null;

select * 
from students 
where admitted_date is not null;

update students
set email ="safayathossain123@gmail.com",
	cgpa = 3.74
where id =5;

 -- update entire column with a consistent value  "admitted_date"
update students 
set admitted_date = "2020-02-04";

delete from students 
where id =null;

select * from students;

-- auto commit 
set autocommit = off;
delete from students;

commit; 

-- commited that table data are deleted,cannot rollback to the previous data
-- need again add the data

rollback;


-- currentDate, currentTime
create table test(
	my_date date,
    my_time time,
    my_date_time datetime
);

show tables;
rename table test to test_date_time;

insert into test_date_time
values (current_date(),current_time(),now());

select * from test_date_time; 

	-- unique
 create table courses (
		course_code varchar(10),
        course_title varchar(50) unique
);
alter table courses add constraint unique(course_code);

insert into courses
values ("ICT4101","Simuation"),
	("ICT4102","Research Methodology");

insert into courses 
values ("ICT4102","Research Methodology");
select * from courses;

	-- not null constraint
alter table courses
add column course_teacher varchar(30);

UPDATE courses 
SET course_teacher = 'Unknown' 
WHERE course_teacher IS NULL;


alter table courses
modify course_teacher varchar(40) not null default "Unknown";

insert into courses 
values ("ICT4104","Signal Processing","Dr. Mst. Nargis Akter");

	-- check constarint
alter table courses
add column hourly_pay decimal(10,3) ;

select * from courses;

alter table courses 
add constraint chk_hourly_pay check(hourly_pay >200.00); -- add constraint 

alter table courses 
drop constraint chk_hourly_pay; -- drop constarint

alter table courses 
add constraint chk_hourly_pay check(hourly_pay >2000.00);

insert into courses 
values ("ICT4106","DSP","Dr. Monir Morshed",2500);

insert into courses (course_code,course_title,course_teacher,hourly_pay,min_paid_in_hour)
values ("ICT4107","WEb Development","BKP",2100,1500);

delete from courses
where hourly_pay < 2000;

-- ALTER TABLE courses DROP CONSTRAINT IF EXISTS chk_hourly_pay, ADD CONSTRAINT chk_hourly_pay CHECK (hourly_pay > 2000.00);

-- default constarint
alter table courses
add column min_paid_in_hour decimal(6,2) default 0; -- default value 0.00

alter table courses
drop column min_paid_in_hour; -- drop column

alter table courses
add column min_paid_in_hour decimal(10,2); -- create column

alter table courses 
alter min_paid_in_hour set default 2000.0; -- set default value

alter table courses 
add column assigned_date_time datetime default now();

insert into courses  (course_code,course_title,course_teacher,hourly_pay)
values ("ICT4108","Networking","Prof. Dr. Badrul Alam",2200),
		("ICT4109","latex","Md. Abir Hasan",2200);

select * from courses;

-- constraint primary key
show tables;
select *from students;

alter table students
drop primary key; -- drop primary key constraint

alter table students 
add constraint primary key(id); -- add primary key

-- auto_increment initial value = 1
create table persons (
    id int auto_increment primary key, 
    name varchar(50),
    age int
);
insert into persons (name,age)
values ('John', 30),
	('Alice', 25),
	('Bob', 35);


select * from persons;

delete from persons; -- drop table

-- after recreating table
alter table persons 
auto_increment = 100;


	-- foreign key
    
-- Create customer table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20)
);

-- Create transaction table
CREATE TABLE transaction (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Insert values into customer table
INSERT INTO customer (name, email, phone) VALUES 
('John Doe', 'john@example.com', '123-456-7890'),
('Alice Smith', 'alice@example.com', '987-654-3210'),
('Bob Johnson', 'bob@example.com', '456-789-0123'),
('Anik Adnan', 'anik@example.com', '123-456-7890');


-- Insert values into transaction table
INSERT INTO transaction (customer_id, amount, transaction_date) VALUES
(1, 100.50, '2024-02-25'),
(2, 75.25, '2024-02-26'),
(1, 200.75, '2024-02-27'),
(3, 150.00, '2024-02-28');

INSERT INTO transaction ( amount, transaction_date) VALUES
( 110.50, '2024-02-29');

-- Show values from customer table
SELECT * FROM customer;

-- Show values from transaction table
SELECT * FROM transaction;

-- drop foreign key
alter table transaction 
drop foreign key transaction_ibfk_1;

-- add foreign key
alter table transaction
add constraint fk_customer_id
foreign key (customer_id) references customer(customer_id);

	 -- join
-- Show values from both tables
SELECT c.customer_id, c.name, c.email, c.phone, t.transaction_id, t.amount, t.transaction_date
FROM customer c
JOIN transaction t ON c.customer_id = t.customer_id;

-- same as 
select c.customer_id,c.name,t.amount,t.transaction_date
from customer as c
join transaction as t 
where c.customer_id = t.customer_id;


select *
from customer as c
inner join transaction as t 
on c.customer_id = t.customer_id;	-- inner join

select *
from customer as c
left join transaction as t 
on c.customer_id = t.customer_id;	-- left join

select *
from customer as c
right join transaction as t 
on c.customer_id = t.customer_id;	-- right join


	-- functions
    
select count(amount) 
from transaction;	 -- table name count

select count(amount) as "today's transaction" 
from transaction;	 -- table name count

select max(amount) as max_amount
from transaction;	 -- table name max_amount

select avg(amount) as avg_amount
from transaction;	 -- table name avg_amount

select sum(amount) as sum_amount
from transaction;	 -- table name avg_amount

select concat(first_name," ",last_name) as full_name
from students;

	-- logical operators
select * from persons;

alter table persons add salary decimal(10,2);
alter table persons add job varchar(50);
    
update persons set salary=50000 where id=100;
update persons set salary=70000 where id=101;
update persons set salary=40000 where id=102;

update persons set job = "Student" where id=100;
update persons set job = "Teacher" where id=101;
update persons set job = "Soft. Engg." where id=102;


select * from persons where salary > 50000 and age >21;
select * from persons where salary > 50000 or age >21;
select * from persons where salary > 50000 and not age >30;
select * from persons where salary  between  45000 and  65000;
select * from persons where job in("Student","Teacher");


	-- wild cards
    
select * from students where first_name like "a%"; -- start with 'a'
select * from students where admitted_date like "%04"; -- end with '04'
select * from students where first_name like "___had"; -- first 3char skiped,matched with 'had'
select * from students where admitted_date like "____-__-04";


-- order by

select * from students;
select * from students order by cgpa asc; -- by default assending oder
select * from students order by cgpa desc;
select * from students order by first_name desc,cgpa asc;


	-- limit
select * from students limit 2; 	-- frist 2 row
select * from students order by cgpa desc limit 2;
select * from students order by cgpa desc limit 2,2;	-- skip first 2 rows, output 3-4 rows ,because offset=2

	-- union (can't allow duplicates)
    
select * from customer;
select * from transaction;

select * from customer
union 
select * from transaction; 	-- need same  no of column, otherwise union not work prop.

select customer_id,name from customer
union all
select transaction_id,amount from transaction; -- union all allow duplicates


	-- self join (compare rows within the same table.table with joined with itself)
select * from customer;

select s.id,s.first_name,s.last_name,c.customer_id,c.name 
from customer as c
inner join students as s 
where c.customer_id = s.id; -- join by default inner join

select s.id,concat(s.first_name," ",s.last_name) as "Full Name",c.customer_id,c.name 
from customer as c
join students as s 
where c.customer_id = s.id;

-- natural join (need always a common column)
select  *
from customer 
natural join transaction;

select  c.name, t.amount
from customer as c
natural join 
transaction as t;

-- views




