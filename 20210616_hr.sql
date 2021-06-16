select * from employees;
select * from jobs;
select * from emp_details_view;
select * from departments;

-- 1. 
-- ���� 'King' ������� ������ ����Ͻÿ�.
select * from employees  where last_name = 'King';

-- 2. 
-- �μ��� 80, 90�� ������� �μ������� ����Ͻÿ�.
select * from departments 
from ( select * from employees where department_id in (80,90) );

-- 9. 
-- ������ ���� ���� �޿��� �޴� ��� ���� ����϶�.
select * from employees 
order by salary desc;
select * from departments;

select MAX(department_id) from employees;


select * 
from(select * from employees 
order by salary desc);

select department_name , max(salary)
from employees;

select job_id, max(salary)
from employees
group by job_id;

select e.employee_id, e.job_id, e.salary
from employees e , (select job_id, max(salary) max_salary from employees group by job_id) m
where e.salary = m.max_salary and e.job_id = m.job_id;


-- <view>
--���̺� ��ȸ 
select * from tab;

-- view ���ڵ� ��ü ��ȸ
select * from emp_details_view;

-- view ���� ��ȸ
desc emp_details_view;

--view Ȯ��
select view_name, text_length, text
from user_views
where view_name = 'emp_details_view';