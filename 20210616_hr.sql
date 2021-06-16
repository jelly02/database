select * from employees;
select * from jobs;
select * from emp_details_view;
select * from departments;

-- 1. 
-- 성이 'King' 사용자의 정보를 출력하시오.
select * from employees  where last_name = 'King';

-- 2. 
-- 부서가 80, 90인 사용자의 부서정보를 출력하시오.
select * from departments 
from ( select * from employees where department_id in (80,90) );

-- 9. 
-- 직무별 가장 많은 급여를 받는 사원 정보 출력하라.
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
--테이블 조회 
select * from tab;

-- view 레코드 전체 조회
select * from emp_details_view;

-- view 구조 조회
desc emp_details_view;

--view 확인
select view_name, text_length, text
from user_views
where view_name = 'emp_details_view';