--DROP TABLE EMP;
--DROP TABLE DEPT;
--DROP TABLE SALGRADE;
--
--CREATE TABLE DEPT (
--    DEPTNO DECIMAL(2),
--    DNAME VARCHAR(14),
--    LOC VARCHAR(13),
--    CONSTRAINT PK_DEPT PRIMARY KEY (DEPTNO) 
--);
--
--CREATE TABLE EMP (
--    EMPNO DECIMAL(4),
--    ENAME VARCHAR(10),
--    JOB VARCHAR(9),
--    MGR DECIMAL(4),
--    HIREDATE DATE,
--    SAL DECIMAL(7,2),
--    COMM DECIMAL(7,2),
--    DEPTNO DECIMAL(2),
--    CONSTRAINT PK_EMP PRIMARY KEY (EMPNO),
--    CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO)
--);
--
--CREATE TABLE SALGRADE ( 
--    GRADE NUMBER,
--    LOSAL NUMBER,
--    HISAL NUMBER 
--);
--
--INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
--INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
--INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
--INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,TO_DATE('17-12-1980','DD/MM/YYYY'),800,NULL,20);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,TO_DATE('20-2-1981','DD/MM/YYYY'),1600,300,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,TO_DATE('22-2-1981','DD/MM/YYYY'),1250,500,30);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,TO_DATE('2-4-1981','DD/MM/YYYY'),2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,TO_DATE('28-9-1981','DD/MM/YYYY'),1250,1400,30);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,TO_DATE('1-5-1981','DD/MM/YYYY'),2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,TO_DATE('9-6-1981','DD/MM/YYYY'),2450,NULL,10);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,TO_DATE('13-7-1987','DD/MM/YYYY')-85,3000,NULL,20);
INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,TO_DATE('17-11-1981','DD/MM/YYYY'),5000,NULL,10);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,TO_DATE('8-9-1981','DD/MM/YYYY'),1500,0,30);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,TO_DATE('13-7-1987', 'DD/MM/YYYY'),1100,NULL,20);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,TO_DATE('3-12-1981','DD/MM/YYYY'),950,NULL,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,TO_DATE('3-12-1981','DD/MM/YYYY'),3000,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,TO_DATE('23-1-1982','DD/MM/YYYY'),1300,NULL,10);

--INSERT INTO SALGRADE VALUES (1,700,1200);
--INSERT INTO SALGRADE VALUES (2,1201,1400);
--INSERT INTO SALGRADE VALUES (3,1401,2000);
--INSERT INTO SALGRADE VALUES (4,2001,3000);
--INSERT INTO SALGRADE VALUES (5,3001,9999);
--
--COMMIT;
--
---- show tables;
---- desc dept;
---- select * from dept;
-- select * from emp;
---- select * from salgrade;
select * from emp;

-- =====================================================
-- 1. 전체 직원의 숫자 조회
select COUNT(*) from emp;

-- 2. 현재 수당이 있는 직원의 숫자 조회
select COUNT(comm) from emp;
select * from emp where comm is not null; --comm이 0인 사람은 나오면 안되는 게 논리적으로 맞음 

-- 3. 실질적으로 수장을 받는 직원의 숫자 조회 
select COUNT(comm) from emp 
where comm > 0;

-- 4. 직원들의 최대급여, 최소급여, 평균급여, 최대급여-최소급여의 차이 구하기
select MAX(sal) as "최대급여" , MIN(sal) as "최소급여" , 
SUM(sal) as "급여총액", ROUND(AVG(sal))  as "평균급여" , MAX(sal)-MIN(sal) "최대급여-최소급여"
from emp ;

-- 5. 천 단위마다 컴마 표시, 기본 로케일 통화 기호 표시 
select
    TO_CHAR( MAX(sal), 'L999,999') as "최대급여" ,
    TO_CHAR(MIN(sal), 'L999,999') as "최소급여" , 
    TO_CHAR(SUM(sal), 'L999,999') as "급여총액", 
    TO_CHAR(ROUND(AVG(sal)), 'L999,999')  as "평균급여" , 
    TO_CHAR(MAX(sal)-MIN(sal), 'L999,999') "최대급여-최소급여"
from emp ;

-- (2) GROUP 함수를 사용해서 그룹핑 결과를 조회
--      > SELECT 항목 : GROUP BY 지정한 컬럼명, 그룹함수
-- 1. 부서별 평균 급여 조회
SELECT deptno,  TO_CHAR( ROUND(AVG(sal)), '$999,999') as "합계"
from emp
GROUP BY deptno
ORDER BY deptno;

-- 2. 부서별 평균 급여가 2,000 초과한 부서만 조회
SELECT deptno,  TO_CHAR( ROUND(AVG(sal)), '$999,999') as "합계"
from emp
GROUP BY deptno
HAVING AVG(sal)> 2000
ORDER BY deptno;

-- 3 . 직원들의 직무 조회
SELECT job from emp
ORDER BY 1;

-- 4. 조회시 중복 제거하고 조회 : distinct
SELECT DISTINCT job from emp
ORDER BY 1;

-- 5. 부서 별 직무의 종류를 조회
-- 조회항목 : 부서번호, 직무
-- 정렬 : 부서번호, 직무 순서대로 조회

SELECT DISTINCT deptno, job from emp
ORDER BY deptno, job;

-- 1. 조회에 대한 일련번호(rownum), 저장위치(rowId) 의 부서번호, 사번, 이름, 급여 정보를 조회
SELECT  ROWNUM, ROWID deptno, empno, ename, sal
FROM EMP;

-- 2. 10번 부서원의 정보만 조회
SELECT  ROWNUM, ROWID deptno, empno, ename, sal
FROM EMP
where deptno = 10;

-- 3. 직무의 종류 중복 제거하고 조회 
select DISTINCT job from emp 
order by 1;

-- 4. 직무 별 직원의 인원 수를 조회 
-- 출력 형식 : 직무, 인원 수
-- 인원 수가 많은 순서대로 정렬 조회
select job, count(*)
from emp
group by job
order by 2 desc; --count 또쓰는거 방지


-- subquery
-- 1. 7499 직원의 직무 조회
select job from emp
where empno = 7499;

-- 2. 1과 같은 직무를 담당하는 직원을 조회
select job from emp
where job = 'SALESMAN' ;

-- 3. 합치기 
select * from emp
where job = (select job from emp
where empno = 7499) ;

-- Q. 직원 중에서 급여를 많이 받는 최상위 3명  (rownum 으로 갯수 지정) 정보를 조회
--  출력 형식 : 순번, 사번, 이름, 급여
SELECT rownum, empno, ename, sal 
from (select empno, ename, sal  from emp order by sal desc)
where rownum <= 3;

-- <통계함수 > : decode (오라클 전용)

-- Q. 직원들의 직무에 따라서 경조회비를 차등 계산
-- 경조회비 계산 
-- (1) PRESIDENT  = 급여 * 30%
-- (2) MANAGER =  급여 * 25%
-- (3) ANALIST, SALESMAN  =  급여 * 20%
-- (4) 나머지 = 급여 * 5%

-- 출력 형식 : 사번, 직무, 급여, 경조회비
-- 경조회비를 많이 내는 직원 순서대로 정렬 조회 

-- 직무정렬
select DISTINCT job from emp order by 1;

select empno, ename, sal,
    decode(
        --만약 JOB이
        job,
        --이거라면 
        'PRESICDENT' , 
        --이렇게
            SAL * 0.3,
        'MANAGER',
            SAL * 0.25,
         'ANALIST',
            SAL * 0.25,  
          'SALESMAN',
            SAL * 0.25, 
    -- defalut
            SAL * 0.05
    ) "경조회비"
from emp
order by 경조회비 desc;

select empno, ename, sal,
TO_CHAR(
        trunc(
                    decode(
                        --만약 JOB이
                        job,
                        --이거라면 
                        'PRESICDENT' , 
                        --이렇게
                            SAL * 0.3,
                        'MANAGER',
                            SAL * 0.25,
                         'ANALIST',
                            SAL * 0.25,  
                          'SALESMAN',
                            SAL * 0.25, 
                    -- defalut
                            SAL * 0.05
                    )
                ) , '$999,999 ') "경조회비"
from emp
order by 경조회비 desc;

-- ===============미션 1_select ===================
select * from emp;
-- 1. 
select empno, ename, to_date(hiredate, 'YYYY/MM/DD') from emp;
-- 2.
select DISTINCT job from emp
order by job;
-- 3
select * from emp
where sal >= 3000;
-- 4
select * from emp
where ename = 'SMITH';
-- 5
select * from emp where deptno = 10;
select * from (select * from emp where deptno = 10)
where job = 'MANAGER';
-- 6
select * from (select * from emp where deptno != 10)
where job = 'MANAGER' OR job = 'CLARK';
-- 7
select * from emp where sal > 1000 and sal <3000;
select * from (select * from emp where sal > 1000 and sal <3000)
where job = 'SALESMAN' ;
--8 
select * from emp
where job = 'CLERK'  or  job = 'MANAGER' or   job ='SALESMAN';
--9
select * from emp
where job != 'CLERK'  and  job != 'MANAGER' and   job !='SALESMAN';
-- 10
select * from (select * from emp where sal > 2000)
where ename like '%A%';
-- 11
select to_char(sysdate, 'YYYY/MM/DD') as "오늘 날짜" from dual;
--12
select TO_CHAR(SYSDATE, 'AM HH:MI') as "현재 시간" FROM dual;
--13
select deptno as "부서번호" , count(*) as "인원 수", sum(sal) as "총 급여" , 
ROUND(avg(sal)) as "평균급여" , max(sal) as "최대급여", min(sal) as "최소급여" , max(sal) -min(sal) as "급여차이"
from emp
group by deptno;
--14
--15
select empno, sal,
case
          when sal < (select avg(sal) from emp) then '대상자'
                    else '미대상'
          end "대상여부"
from emp
order by 대상여부;

