create schema employee;
create table employees_table(
emp_no      int           not null auto_increment,
birth_date  date          not null,
first_name  varchar(14)   not null,
last_name   varchar(16)   not null,
gender      enum('m','f') not null,
hire_date   date          not null,
primary key (emp_no)
);