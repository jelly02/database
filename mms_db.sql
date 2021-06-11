-- 데이터 베이스 생성 

use mms_db;

-- 테이블 목록 조회
show tables;

-- 테이블 구조(table schema) 조회 : desc 테이블 명;
-- 부서 : dept, 직원 : emp, 급여 등급 : salgrade
desc salgrade;
desc emp;
desc salgrade;

-- 테이블 레코드 조회 : select * from 테이블명;

-- (1) 전체 부서 조회
 select * from dept;
-- (2) 전체 직원 조회
 select * from emp;
-- (3) 전체 급여 등급 조회
select * from salgrade;

-- 직원 테이블 삭제 : drop table 테이블명;

-- 06/11
-- 1. 정렬 

-- (1) 직원의 사번, 이름, 급여 정보를 제목으로 조회
select empno "사번", ename "이름", sal "급여" from emp;
-- (2) 급여가 높은 순서대로 정렬 조회
select empno "사번", ename "이름", sal "급여" from emp order by sal desc; 
-- sql의 index	 1			2		 3
select EMPNO "사번", ENAME "이름", SAL "급여" from EMP order by 3  desc;

-- 2. 조건 검색

-- (1) 직원의 모든 정보 조회  : 급여가 2000 미만인 직원의 정보 조회(급여가 낮은 순서대로)
select EMPNO "사번", ENAME "이름", SAL "급여" from EMP where SAL < 2000 order by SAL;
-- (2) 직원의 모든 정보 조회 : 급여가 2000 ~ 3000 직원의 정보 조회 (급여가 낮은 순서대로)
select EMPNO "사번", ENAME "이름", SAL "급여" from EMP 
where SAL >= 2000 AND SAL <= 3000
order by SAL;
select EMPNO "사번", ENAME "이름", SAL "급여" from EMP 
where sal between 2000 and 3000 
order by sal;
-- (3) 직원 사번, 급여, 수당(comm) 조회
select EMPNO "사번", SAL "급여", COMM(수당) from emp;
-- (4) 수당이 null인 직원의 정보 조회 
select * from emp where comm is not null; 
-- (5) 수당을 받지 않는 직원 조회
SELECT * FROM emp where comm=0 ;
SELECT * FROM EMP WHERE COMM IS NOT NULL AND COMM = 0;
-- (6) 수당을 실제로 받은 직원의 정보 조회
select * from emp where comm > 0 ;
-- (7) 직원의 급여, 수당, 급여+수당 정보 조회
select SAL, COMM, SAL + COMM "급여+수당" from emp;
-- (8) null인 경우에 지정한 값으로 대체하는 함수 만들기 / oracle은 dvl
select EMPNO "사번",ENAME "이름", SAL "급여", IFNULL(COMM, 0) 수당, (SAL + IFNULL(COMM,0)) * 0.3 "특별수당" 
from emp
ORDER BY "특별수당";

-- 3. NULL 검색 

-- (1) 직원정보 조회 : 수당이 많은 사람 순서대로 정렬 (내림차순)
-- > 내림차순 : null > 큰 것 > 작은 것 
select * FROM EMP order by comm desc;
-- (2) 직원정보 조회 : 수당이 적은 사람 순서대로 정렬 (올림차순)
-- > 올림차순 : 작은 것 > 큰 것 > null
select * FROM EMP order by comm asc;

-- 4. like 

-- (1) 직원 이름 조회
select ename from emp order by 1;
-- (2) 이름에 A가 들어간 직원 조회
select ename from emp where ename like ('%A%');
-- (2) j가 시작하는 이름이 들어간 직원 조회
select ename from emp where ename like ('j%');
-- (3) 이름이 R로 끝나는 직원 조회
select ename from emp where ename like ('%r');
-- (4) 이름에 2번째 문자가 L인 직원 조회
select ename from emp where ename like ('_l%');
-- (5) 이름의 길이가 4자리인 직원 조회
select ename from emp where ename like ('____');
-- (6) 함수를 사용해서 길이가 4자리인 직원 조회
-- length() 문자 길이 반환 / dual : 테스트용 가상 테이블
select length('가'),  length('a'),  length('1')
from dual;
-- lengthb() 문자 byte 단위 길이 반환(테이블 설계 시 도메인 데이터 분석해서 컬럼 길이 지정)
select ename 이름 from emp where length(ename) = 4  order by ename;


-- 5. in / not in
select * from emp;
-- (1) 10, 20번 부서원의 정보 조회
select * from emp where deptno = 10 or deptno = 20
order by deptno;
select * from emp where deptno in (10,20);
-- (2) 30번이 아닌 부서원의 정보 조회
select * from emp where deptno in (30);
select * from emp where deptno != 30 
order by deptno;
-- (2) 10, 20번 부서원이 아닌 부서원들의 정보 조회
select * from emp where not(deptno = 10 or deptno = 20)
order by deptno;

-- 6. trim						좌측 공백제거 		우측 공백제거 
select trim('			a'),  ltrim('		a'), rtrim('a		') 
from dual;

-- 7. concat (내용에 계속 중첩되서 들어감)
-- (1) 직원 이름, 직무(job) 정보를 조회 후 
--     000 사원 님의 직무는 000입니다. 
 select concat(concat(concat(ename,'사원님의'),concat(job,'직무는')), '입니다') from emp;
-- (2) (1)번 위치에 || 사용
select ename || ' 사원님의 직무는 ' ||  job ||  ' 입니다.' from emp;

-- 8. lpad, rpad() : 게시글 번호 할 때 유용 
-- (1) lpad : 왼쪽으로 사원의 이름의 전체 길이를 15자리로 하고 나머지 자리를 * 문자로 대체 
select lpad(ename,15,'*') from emp;
select ename,  lpad(ename,15,'*') , rpad(ename,15,'*') , empno, lpad(empno,6,'0') from emp;
-- (2) rpad : 왼쪽으로 사원의 이름의 전체 길이를 15자리로 하고 나머지 자리를 * 문자로 대체 
select rpad(ename,15,'*') from emp;

-- 9. substr() : 부분 문자열 출력
-- (1) 직원의 이름 2자리만 보여주고 남은 문자는 *로 대체
select ename,rpad(substr(ename, 1, 2), length(ename), '*') as "보안문자" from emp;

-- 10. 숫자 함수
-- (0) 1234.5678
-- (1) 소수 이하 올림 처리
select ROUND(1234.5678) from dual;
select ceil(1234.5678) from dual;
-- (2) 100 이하 버림 처리 
select TRUNCATE(1234.5678, -2) from dual;
-- (3) 소수 이하 2자리 버림 처리 
select TRUNCATE(1234.5678, 2) from dual;
-- (4) 소수 이하 1자리 올림 처리
select TRUNCATE(1234.45678, 1) from dual; 
select round(TRUNCATE(1234.45678, 3), 1 ) from dual;
-- (5) 숫자 5를 2로 나눈 나머지
select MOD(5,2);

-- <오라클>
-- 11. 날짜 함수 (데이터 타입 :  date)
-- (1) sysdate : 현재 날짜
select sysdate();
-- (2) lastday : 오늘 날짜의 월 마지막 날짜
SELECT LAST_DAY(sysdate());
-- (3) next_day : 다음주의 해당 날짜를 반환(뒷 숫자는 요일)
SELECT next_day(sysdate(),1);
-- (4) add_months : 지정한 개월 수 이후의 날짜
SELECT add_months(sysdate(),6);
SELECT add_months(sysdate(),6);
SELECT month_between(sysdate(), '2000/01/01') from dual;

