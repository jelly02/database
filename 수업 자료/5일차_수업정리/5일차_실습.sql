-- 테이블 목록 조회
-- 회원 MEMBER 구조 조회
-- 게시글 NOTICE 구조 조회
-- 회원 전체 레코드 조회
-- 게시글 전체 레코드 조회

select * from member;
select * from notice;

-- 일반회원 전체 조회
select * from member where grade = 'G';

-- 일반회원들에게 마일리지 = 마일리지 + 1000 변경 
update member set mileage = 1000;

update member set mileage = mileage + 1000
where grade = 'G';

-- user01 회원의 등급을 우수회원으로 등업처리
-- 담당자 : 김기영
-- 마일리지 : 0 
update member 
set mileage = 0, manager = '김기영', grade = 'S' 
where member_id = 'user01';

-- 전체회원 삭제 : 게시글 참조 레코드 존재 삭제 불가
delete member;

-- 게시글을 작성하지 않은 회원 삭제 : user02
delete member
where member_id='user02';

-- 게시글 작성한 회원아이디를 중복제거하고 아이디 정렬조회
-- 게시글 작성 회원 : user01, user04, user05
select distinct member_id from notice 
order by member_id;

-- 게시글 전체 삭제
delete notice;

-- truncate table
-- 게시글을 작성하지 않은 회원 삭제 : user02
-- error : where 조건 삭제 불가
-- truncate table member where member_id='user01';

-- truncate table 게시글 전체 삭제
-- rollback 복원 불가
truncate table notice;

-- 원상태 복구
rollback;

-- db 영속 반영
commit;

-- 조인(JOIN)
-- CROSS JOIN
SELECT * 
FROM EMP, DEPT;

-- CORSS JOIN의 결과와 같은 행수 조회
SELECT COUNT(*)
FROM EMP, DEPT;

SELECT (SELECT COUNT(*) FROM EMP) * (SELECT COUNT(*)FROM DEPT) 
FROM DUAL;

-- 조인 테스트를 위한 신입사원 레코드 추가
-- 사번 7777, 이름 홍길동, 입사일 현재날짜, 급여 4000
-- 부서 미배정, 상사 미배정, 담당업무 미배정
INSERT INTO EMP(EMPNO, ENAME, HIREDATE, SAL)
VALUES(7777, '홍길동', SYSDATE, 4000);

-- DB 영속 반영
commit;

DESC EMP;
select * from emp;

-- 부서테이블 구조 조회

-- 오라클 equi-join
-- 직원의 부서번호, 부서명, 부서위치, 사번, 이름 정보를 조회 : 조인(직원의 부서번호 => 부서테이블 부서번호)
select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno = dept.deptno
order by emp.deptno;
-- 조인조건에 해당되지 않는 레코드는 조회에서 제거

-- outer join
-- 누락된 데이터 조회

-- 부서원의 없는 부서번호 조회 : 40
SELECT DISTINCT DEPTNO FROM DEPT 
WHERE DEPTNO NOT IN (SELECT DISTINCT NVL(DEPTNO, 0) FROM EMP);

SELECT DISTINCT NVL(DEPTNO, 0) FROM EMP;

-- 부서를 배정받지 못한 사원의 정보 조회 : null
select empno, deptno from emp where deptno is null;

-- outer join : 부서를 배정받지 못한 직원의 정보도 함께 조회
select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno = dept.deptno(+)
order by emp.deptno;


-- 부서원이 없는 부서의 정보도 함께 조회
select dept.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno(+) = dept.deptno
order by emp.deptno;

-- full outer join
-- 부서를 배정받지 못한 직원, 부서원이 없는 부서의 정보도 함께 조회
-- error : oracle full outer join 지원하지않음
-- 해결 : oracle 집합연산 union 
select dept.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno(+) = dept.deptno(+)
order by emp.deptno;


-- self join
-- 직원의 사번, 이름, 상사사번, 상사이름 정보 조회
-- 직원의 사번 정렬 조회
select 직원.empno 직원사번, 직원.ename 직원이름, 상사.empno 상사사번, 상사.ename 상사이름 
from emp 직원, emp 상사
where 직원.mgr = 상사.empno
order by 직원.empno
;

-- 상사가 없는 직원정보 누락
-- outer join 상사가 없는 직원정보도 함께 조회
select 직원.empno 직원사번, 직원.ename 직원이름, 상사.empno 상사사번, 상사.ename 상사이름 
from emp 직원, emp 상사
where 직원.mgr = 상사.empno(+)
order by 직원.empno
;

select * from tab;

-- 급여 등급 테이블 조회(salgrade) : 구조, 전체 레코드 조회
desc salgrade;
select * from salgrade;

SELECT EMPNO, SAL, GRADE
FROM EMP, SALGRADE
WHERE SAL >= LOSAL AND SAL <= HISAL;

select empno, sal, grade
from emp, salgrade
where sal between losal and hisal;

-- 테이블 알리아스 선언하고, 사용하지는 않음
select E.empno, E.sal, S.grade
from emp E, salgrade S
where sal between losal and hisal;

select empno 사번, sal 급여, (select grade from salgrade where emp.sal between losal and hisal) 등급
from emp, salgrade
order by 1;

-- 집합연산자
-- 1. 직원의 부서번호, 이름 조회 : 10번, 20번 부서원 조회
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 20);

-- 2. 직원의 부서번호, 이름 조회 : 10번, 30번 부서원 조회	
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 30);

-- 1. 합집합 (중복 포함)
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 20)
UNION ALL
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 30);

-- 2. 합집합 (중복 제외)
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 20)
UNION 
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 30);

-- 3. 교집합
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 20)
INTERSECT 
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 30);

-- 4. 차집합
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 20)
MINUS 
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 30);

-- 부서를 배정받지 못한 직원, 부서원이 없는 부서의 정보도 함께 조회
-- ERROR : ORACLE FULL OUTER JOIN 지원하지 않음
-- 해결 : 집합연산(UNION) 처리
select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno = dept.deptno(+)
UNION
select dept.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno(+) = dept.deptno
;

-- 뷰(VIEW)
-- HR: 테이블 전체 목록 조회
SELECT * FROM TAB;

-- HR VIEW : EMP_DETAILS_VIEW 전체 레코드 조회
SELECT * FROM EMP_DETAILS_VIEW;

-- VIEW 데이터딕셔너리 : USER_VIEWS
-- USER_VIEWS 구조 조회
DESC USER_VIEWS;

-- EMP_DETAILS_VIEW VIEW 생성 SQL 구문 조회
SELECT VIEW_NAME, TEXT_LENGTH, TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'EMP_DETAILS_VIEW';


-- SCOTT : 전체 테이블 목록 조회
SELECT * FROM TAB;

-- 뷰 생성
-- 직원테이블 : 사번, 이름, 급여, 10번 부서원
-- 뷰이름 : EMP10_SIMPLE_VIEW

-- 1. 뷰를 만들 SELECT
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

-- 2. SELECT 결과로 VIEW 생성
CREATE VIEW EMP10_SIMPLE_VIEW
AS
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

-- 테이블 목록조회 = TABLE, VIEW
SELECT * FROM TAB;

-- 뷰 : 전체 레코드 조회
SELECT * FROM emp10_simple_view;

-- 직원테이블에서 10번 부서원중에서 7782 직원을 삭제
SELECT DEPTNO, EMPNO FROM EMP
WHERE EMPNO=7782;

DELETE EMP WHERE EMPNO=7782;

-- 직원 테이블에서 10번 부서원의 정보 조회
SELECT * FROM EMP WHERE DEPTNO=10;

-- 10번 부서원의 정보 뷰를 조회
SELECT * FROM emp10_simple_view;

-- 뷰에서 7934 직원의 급여를 10000 변경
UPDATE emp10_simple_view SET SAL = 10000
WHERE EMPNO=7934;

-- 뷰 삭제 : DDL (TCL AUTO COMMIT)
DROP VIEW emp10_simple_view;

-- 현재 상황에서 ROLLBACK을 하면 삭제한 10번 부서원은 복구가될까요??
ROLLBACK;


-- JOIN 해서 VIEW 생성
-- 조회항목 : 부서번호, 부서명, 사번, 이름
-- 읽기 전용 뷰 생성
-- 뷰이름 : EMP_VIEW
-- 1. JOIN
SELECT EMP.DEPTNO, DEPT.DNAME, EMP.EMPNO, EMP.ENAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
;

-- 2. VIEW
CREATE OR REPLACE VIEW EMP_VIEW
AS
SELECT EMP.DEPTNO, DEPT.DNAME, EMP.EMPNO, EMP.ENAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
WITH READ ONLY
;

-- 3. VIEW 조회
SELECT * FROM EMP_VIEW;


