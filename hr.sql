select * from employees;
select * from departments;

select * from departments
where (select * from employees  where last_name = 'King');