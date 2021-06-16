-- 전체 직원의 숫자 조회
select count(*) from emp;
select count(empno) from emp;

-- 현재 수당이 있는 직원의 숫자 조회
select count(comm) from emp;

-- 실질적으로 수당을 받는 직원의 숫자 조회
select count(comm) from emp
where comm > 0;

-- 수당이 있는 직원 정보 조회
select * from emp where comm is not null;

-- 직원들의 최대급여, 최소급여, 급여총액, 평균급여, 최대급여-최소급여차이
-- 천단위마다 컴마표기, 기본 로케일 통화기호 표시
SELECT 
    MIN(SAL) 최소급여, 
    MAX(SAL) 최대급여, 
    SUM(SAL) 급여총액, 
    ROUND(AVG(SAL)) 평균급여, 
    MAX(SAL)-MIN(SAL) "최대급여-최소급여" 
FROM EMP ;

SELECT 
    to_char(MIN(SAL), 'L999,999') 최소급여, 
    to_char(MAX(SAL), 'L999,999') 최대급여, 
    to_char(SUM(SAL), 'L999,999') 급여총액, 
    to_char(ROUND(AVG(SAL)), 'L999,999') 평균급여, 
    to_char(MAX(SAL)-MIN(SAL), 'L999,999') "최대급여-최소급여" 
FROM EMP ;

-- GROUP 함수를 사용해서 그룹핑 결과를 조회
-- SELECT ~ FROM ~ WHERE ~ GROUP BY ~ HAVEING ~ ORDER BY
-- SELECT 항목 : GROUP BY 지정한 컬럼명, 그룹함수

-- 부서별 평균급여 조회 
-- 출력형식 : 부서번호, 평균급여
-- 소수이하 처리, 숫자 천단위표기, 통화기호 표기
SELECT DEPTNO, to_char(ROUND(AVG(SAL), 2), '$999,999.99')
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- 부서별 평균급여 조회
-- 부서별 평균급여가 2,000 초과한 부서에 대해서만 조회
SELECT DEPTNO, to_char(ROUND(AVG(SAL), 2), '$999,999.99')
FROM EMP
GROUP BY DEPTNO
having AVG(SAL) > 2000
ORDER BY DEPTNO;

-- 직원들의 직무 조회
select job from emp order by 1;

-- 조회시에 중복을 제거하고 조회 : select distinct ~~~
select distinct job from emp order by 1;

-- 부서별 직무의 종류를 조회
-- 조회항목 : 부서번호, 직무
-- 정렬 : 부서번호, 직무 순서대로 조회
select distinct deptno, job from emp order by deptno, job;

select distinct job, deptno from emp order by job, deptno;

-- 조회에 대한 일련번호(rownum), 저장위치(rowid), 부서번호, 사번, 이름, 급여정보를 조회
select rownum, rowid, deptno, empno, ename, sal from emp;
select rownum, rowid, deptno, empno, ename, sal from emp order by deptno;

-- 조회에 대한 일련번호(rownum), 저장위치(rowid), 사번, 이름, 급여정보를 조회
-- 10번 부서원에 대해서만 조회
select rownum, rowid, deptno, empno, ename, sal from emp where deptno=10;

-- 직무의 종류 중복 제거하고 조회
select distinct job from emp order by 1;

-- 직무별 직원의 인원수를 조회
-- 출력형식 : 직무, 인원수
-- 인원수가 많은 순서대로 정렬조회
select job, count(*) from emp group by job order by 2 desc;

-- 전체직원의 사번, 직무 조회
SELECT EMPNO, JOB FROM EMP;

-- sub-query
-- 7499 직원의 직무 조회 : SALESMAN
SELECT JOB FROM EMP WHERE EMPNO=7499;

-- 7499 직원과 같은 직무를 담당하는 직원조회
SELECT * FROM EMP
WHERE JOB = 'SALESMAN';

-- SUB-QUERY 이용
SELECT * FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE EMPNO=7499);

-- 직원중에서 급여를 많이 받는 최상위 3명의 정보를 조회
-- 출력형식 : 순번 사번 이름 급여
-- 힌트 : SELECT 검색순서, ROWNUM, SUB-QUERY

-- 1.
SELECT EMPNO, ENAME, SAL FROM EMP ORDER BY SAL DESC;

-- 2.
SELECT ROWNUM, EMPNO, ENAME, SAL FROM EMP
WHERE ROWNUM <= 3
ORDER BY SAL ASC;

-- 3.
SELECT ROWNUM, EMPNO, ENAME, SAL FROM EMP ORDER BY SAL DESC;

-- 최종 : 최상위 급여 3명의 정보를 일련번호로 출력
SELECT ROWNUM, EMPNO, ENAME, SAL
FROM (SELECT EMPNO, ENAME, SAL FROM EMP ORDER BY SAL DESC)
WHERE ROWNUM <= 3;

select rownum, empno, ename, sal 
from (select empno, ename, sal from emp order by sal desc) 
where rownum < 4
;

-- 통계함수 : decode(expr, s1, r1, sx, rx, default), 오라클 전용

-- 직원들의 직무에 따라서 경조회비를 차등 계산
-- 출력형식 : 사번, 직무, 급여, 경조회비,
-- 경조회를 많이 내는 직원순서대로 정렬 조회

-- 경조회비 계산 
-- PRESIDENT = 급여 * 30%
-- MANAGER = 급여 * 25%
-- ANALYST, SALESMAN = 급여 20%
-- 기타직무 = 급여 * 5%

-- 1. 직무, 정렬
select distinct job from emp order by 1;

SELECT EMPNO, JOB, ENAME, SAL, 
    DECODE(
        JOB,
        'PRESIDENT', SAL * 0.3,
        'MANAGER',   SAL * 0.25,
        'ANALYST',   SAL * 0.2,
        'SALESMAN',  SAL * 0.2,
         SAL * 0.05
    ) "경조회비"
FROM EMP
ORDER BY 경조회비 DESC
;

SELECT EMPNO, JOB, ENAME, SAL, 
    TO_CHAR(
        TRUNC(
            DECODE(
                JOB,
                'PRESIDENT', SAL * 0.3,
                'MANAGER',   SAL * 0.25,
                'ANALYST',   SAL * 0.2,
                'SALESMAN',  SAL * 0.2,
                SAL * 0.05
            ))
        , '$999,999') "경조회비"
FROM EMP
ORDER BY 경조회비 DESC
;

-- 직원들의 직무에 따라서 경조회비를 차등 계산
-- 출력형식 : 사번, 직무, 급여, 경조회비,
-- 경조회를 많이 내는 직원순서대로 정렬 조회

-- 경조회비 계산 
-- PRESIDENT = 급여 * 30%
-- MANAGER = 급여 * 25%
-- ANALYST, SALESMAN = 급여 20%
-- 기타직무 = 급여 * 5%
-- case whten ~ then ~ else ~ end 구문을 이용해서 변경

SELECT EMPNO, JOB, ENAME, SAL, 
    TO_CHAR(
        TRUNC(
            case
                when job = 'PRESIDENT' then SAL * 0.3
                when job = 'MANAGER' then  SAL * 0.25
                when job in ('ANALYST','SALESMAN') then SAL * 0.2
                else SAL * 0.05
            end
        )
    , '$999,999') "경조회비"
FROM EMP
ORDER BY 경조회비 DESC
;

select empno, 'aaa' from emp;

-- 15. 급여인상대상자 = 평균급여 이하
select empno, '대상자' from emp;

select avg(sal) from emp;

-- error
select empno, sal, '대상자'
from emp
where sal < avg(sal)
;

select empno, sal, '대상자'
from emp
where sal < (select avg(sal) from emp)
;

select empno, sal, '대상자'
from emp
where sal < (select avg(sal) from emp)
;

select empno, sal, 
    case
        when sal < (select avg(sal) from emp) then '대상자'
        else '미대상'
    end "대상여부"
from emp
order by 대상여부
;



-- 학생 성적 테이블 삭제
drop table student_score;


-- 학생 성적 테이블 생성
create table student_score(
    student_no number(5) primary key,
    name varchar2(30) not null,
    score number(3)
);

-- 테이블목록 조회
select * from tab;

-- 테이블 구조 조회
desc student_score;











