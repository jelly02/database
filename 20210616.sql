select * from notice;
select * from member;

-- 게시글 추가 
insert into notice
values ('1','주말과제	','회원도서관리DB설계','user05','2020.11.11','0') ; 
insert into notice
values ('2','형상관리 ','형상관리 소개','user04','2020.12.25','5') ; 
insert into notice
values ('3','주말과제','화면정의서','user05','2021.02.14','0') ; 
insert into notice
values ('4','과제제출','시간엄수','user05','2021.03.01','15') ; 
insert into notice
values ('5','WEB참고','www.w3schools.com','user01','2021.05.26','5') ; 

--일반회원 전체 조회 
select * from member where grade = 'G';

-- 일반회원 마일리지 +1000 
update member set mileage = mileage + 1000
where grade = 'G';

--원상태 복구 
ROLLBACK;

select * from member;

--DB 영속 반영
COMMIT;

-- USER01의 회원 등급을 우수 회원으로 등업 처리 후 담당자를 '김기영'으로 바꿈
--등업 후 마일리지 0으로 
UPDATE MEMBER SET MILEAGE = 0, GRADE = 'S', MANAGER = '김기영'
WHERE MEMBER_ID = 'user01';

--DB 영속 반영
COMMIT;

--게시글을 작성한 회원아이디를 중복 제거하고 아이디 정렬 조회

insert into notice
values ('6','아침에 일찍 일어나니까','신기해요','user01','2021.06.15','1') ; 

select distinct member_id from notice 
order by member_id;

--게시글을 작성하지 않은 회원 삭제 
insert into member
values ('user06',	'password02',	'강감찬', '010-1234-8484',	'user02@work.com', '2017.05.06', 'G', 95000 , null	);

delete member where member_id = 'user06';

--원상태 복구 
ROLLBACK;

--DB 영속 반영
COMMIT;

-- 게시글 전체 삭제
delete notice;

-- 회원 전체 삭제
delete member;

--truncate table 게시글 전체 삭제 : 메모리에서 아예 out되어서 rollback 해도 못 살림
select * from notice;

--<1. CROSS JOIN>
select * from emp, dept;

--(1) CROSS JOIN과 결과가  같은 행수 조회
SELECT (select count(*) from emp) * (select count(*) from dept)
from dual;
SELECT COUNT(*) FROM EMP, DEPT;

--(2) 직원테이블에 신입사원 레코드 등록
-- 사번 7777, 홍길동, 입사일 현재날짜, 급여 4000
desc emp;
INSERT INTO EMP(EMPNO, ENAME, HIREDATE, SAL) VALUES(7777, '홍길동', SYSDATE, 4000);

commit;

select * from emp;

--부서 테이블 구조 조회
select * from dept;

select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno = dept.deptno
order by emp.deptno;

--<Outer Join>
--누락된 데이터 조회
-- 부서원이 없는 부서번호 조회 
select * from dept;
select * from emp;

select * from emp
where deptno = null;

select DISTINCT deptno from dept
where deptno not in  (select DISTINCT nvl(deptno, 0) from emp);


--부서를 배정받지 못한 사원의 정보 조회 
select * from emp
where deptno IS NULL;


--부서를 배정받지 못한 사원의 정보도 함께 조회
select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno = dept.deptno (+)
order by emp.deptno;

--40번 부서원 누락됨
select dept.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno  (+) = dept.deptno
order by emp.deptno;

--부서를 배정받지 못한 직원, 부서원이 없는 부서의 정보도 함께 조회

-- <SELF JOIN>
-- 직원의 사번, 이름, 상사사번, 상사이름 정보조회
--직원의 사번 정렬 조회

SELECT 직원.empno 직원사번,  직원.ename 직원이름,  상사.empno 상사사번, 상사.ename 상사이름
from emp 직원, emp 상사
where 직원.mgr = 상사.empno
order by 직원.empno; --상사가 없는 직원 누락됨

--<Outer Join> 
--상사가 없는 직원 정보도 함께 조회
--null이 없는 쪽에다가 ++
SELECT 직원.empno 직원사번,  직원.ename 직원이름,  상사.empno 상사사번, 상사.ename 상사이름
from emp 직원, emp 상사
where 직원.mgr = 상사.empno (+)
order by 직원.empno;

--<Non-Equi Join>
-- 급여 등급 테이블 조회 : 구조 , 전체 레코드 조회
desc salgrade;
SELECT * from salgrade;

--직원의 사번, 급여, 급여등급 조회
-- 테이블 조인 : 직원, 급여등급 

select empno, sal, grade
from emp, salgrade
where sal  between losal and hisal;

--실습 : 부서번호, 부서명, 사번, 이름, 급여, 급여등급 정보 조회
--3개 테이블 조인 : 직원, 부서, 급여등급
-- losal은 최소급여 hisal은 최대 급여인거 같아요!!
-- 1 800 1200 이면 1등급은 급여가 800 ~ 1200 인 사람이여
select e.deptno, d.dname, e.empno, e.ename, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno AND e.sal between s.losal and s.hisal;

select * from salgrade;
select * from emp;

--<집합연산자>
--1. 직원의 부서번호, 이름 조회 : 10, 20
select deptno, ename from emp
where deptno in (10,20);

--2. 직원의 부서번호, 이름 조회 : 10, 30
select deptno, ename from emp
where deptno in (10,30);

--1. 합집합 (중복 포함)
select deptno, ename from emp
where deptno in (10,20)
union all
select deptno, ename from emp
where deptno in (10,30);

--2. 합집합 (중복 제외)
select deptno, ename from emp
where deptno in (10,20)
union 
select deptno, ename from emp
where deptno in (10,30);
--3. 교집합 : 10번 부서원들의 정보만 출력 됨
select deptno, ename from emp
where deptno in (10,20)
INTERSECT
select deptno, ename from emp
where deptno in (10,30);
--4.차집합 : 
select deptno, ename from emp
where deptno in (10,20)
minus
select deptno, ename from emp
where deptno in (10,30);

-- 부서를 배정받지 못한 직원, 부서원이 없는 부서의 정보도 함께 조회
select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno = dept.deptno (+)
union
select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno  (+) = dept.deptno;

-- <view>
--테이블 조회 
select * from tab;

--view 생성
-- 직원 테이블 : 사번, 이름, 급여, 10번 부서원
-- 뷰 이름 : emp10_simple_view

select empno, ename, sal, deptno
from emp
where deptno = 10;

--select 결과로 view 생성
create view emp_10_simple_view
as
select empno, ename, sal, deptno
from emp
where deptno = 10;

-- 테이블 목록 조회 = tabie, view
select * from tab;

--뷰 : 전체 레코드 조회
select * from emp_10_simple_view;

-- 직원 테이블에서 10번 부서원 중 7782 직원을 삭제
select * from emp
where empno = 7782;

delete emp where empno = 7782;

--직원테이블에서 10번 부서원의 정보 조회 
select *
from emp
where deptno = 10;

--뷰 : 전체 레코드 조회
select * from emp_10_simple_view;

--뷰 : 7934의 직원 급여를 10000 변경
update emp_10_simple_view set sal = 10000
where empno = 7934;

--뷰 : 전체 레코드 조회
select * from emp_10_simple_view;

--직원테이블에서 10번 부서원의 정보 조회 
select *
from emp
where deptno = 10;

--뷰 : 삭제
drop view emp_10_simple_view;

--join해서 view 생성하기
-- 읽기 전용 뷰 생성
create or replace view emp_view
as
select emp.deptno, dept.dname, emp.empno, emp.ename
from emp, dept
where emp.deptno = dept.deptno
with read only
;

-- <ANSI 표준 조인> 
select * from emp cross join dept;

select deptno, dname,empno,ename
from emp natural join dept;

--<outer join>
-- 부서를 배정받지 못한 직원의 정보
select dept.deptno, dname, loc, empno, ename
from emp left outer join dept
on (emp.deptno = dept.deptno)
;

-- 부서원이 없는 부서의 정보도 함께 조회
select dept.deptno, dname, loc, empno, ename
from emp right outer join dept
on (emp.deptno = dept.deptno)
;

--full outer join : 부서원이 없는 부서, 부서를 배정받지 못한 직원
select dept.deptno, dname, loc, empno, ename
from emp full outer join dept
on (emp.deptno = dept.deptno)
;

--non equi join
--직원의 사번, 급여, 급여 등급 조회
select empno, sal, grade
from emp, salgrade
where sal between losal and hisal;

--ansi join 
select empno, sal, grade
from emp  join salgrade
on (sal between losal and hisal);