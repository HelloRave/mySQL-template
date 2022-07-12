-- Data Definition Language

create table employees (
    employee_id int unsigned auto_increment primary key,
    email varchar(320),
    gender varchar(1),
    notes text,
    employment_date date,
    designation varchar(100)
) engine = innodb; 

insert into employees (
    email, gender, notes, employment_date, designation
) values ('asd@asd.com','M','Newbie', curdate(),'Intern');

update employees set email='asd@gmail.com' where employee_id = 1; 

delete from employees where employee_id = 1; 

create table departments (
    department_id int unsigned auto_increment primary key,
    name varchar(100)
) engine=innodb;

insert into departments (
    name
) value ('Accounting'), ('Human Resources');

alter table employees add column name varchar(100); 

alter table employees rename column name to first_name; 

insert into employees (
    first_name, email, gender, notes, employment_date, designation
) values ('Tan Ah Kow', 'asd@asd.com','M','Newbie', curdate(),'Intern');

alter table employees add column department_id int unsigned not null; 

alter table employees add constraint fk_employees_departments 
    foreign key (department_id) references departments(department_id);

insert into employees (
    first_name, department_id,email, gender, notes, employment_date, designation
) values ('Tan Ah Kow', 2,'asd@asd.com','M','Newbie', curdate(),'Intern');