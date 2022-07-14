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


create table parents (
    parent_id int unsigned auto_increment primary key,
    name varchar(100),
    contact_no varchar(10),
    occupation varchar(100)
) engine=innodb; 

create table addresses (
    address_id int unsigned auto_increment primary key,
    block_number varchar(100),
    street_name varchar(100),
    postal_code varchar(100),
    parent_id int unsigned not null
) engine = innodb; 

alter table addresses add constraint fk_addresses_parents 
    foreign key (parent_id) references parents(parent_id);


create table students (
    student_id int unsigned auto_increment primary key,
    name varchar(100) not null,
    date_of_birth date not null,
    parent_id int unsigned not null,
    foreign key (parent_id) references parents(parent_id)
) engine=innodb;

insert into students (
    name, date_of_birth, parent_id
) values ('Cindy Tan', '2020-11-30', 1),
         ('Cindy Lim', '2020-12-30', 2); 

insert into parents (
    name, contact_no, occupation
) value ('Morgan', '97979790', 'Engineer'),
        ('Wei Wei', '12345567', 'Programmer');

insert into addresses (
    block_number, street_name, postal_code, parent_id
) value ('345', 'Tampines South', '738012', 2);