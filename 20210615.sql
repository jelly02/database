desc member;
select * from emp;
select * from dept;

--테스트 테이블 생성
create table "test" (

    data1 varchar2(10),
    "data2" varchar2(10)
);

select * from tab;

--test 테이블 구조 
desc test; --어 안나오네

desc "test";

drop table "test";

drop table member;

create table member(
    MEMBER_ID varchar2(30),
    MEMBER_PW varchar2(20) not null,
    NAME varchar2(20) NOT NULL,
    MOBILE varchar2(13) NOT NULL,
    EMAIL varchar2(30) NOT NULL,
    ENTRY_DATE varchar2(10) NOT NULL,
    GRADE varchar2(1) NOT NULL,
    MILEAGE varchar2(6),
    MANAGER varchar2(20),
    
    CONSTRAINT PK_MEMBER_ID_NAME PRIMARY KEY (MEMBER_ID,NAME)
);

-- <Data  dictionary>
--테이블 구조 조회
desc user_constraints;
desc user_cons_columns;

--member 테이블에 대한 제약 조회
select table_name, constraint_name, constraint_type
from user_constraints
where table_name in ('MEMBER' ); -- 검색하는 단어이기 때문에 대소문자를 구분해서 대문자로 테이블 이름을 적어야함

-- user_cons_columns 테이블을 이용해서 MEMBER 테이블의 PK_MEMBER_ID_NAME 제약에 대한 컬럼 조회
select PK_MEMBER_ID_NAME
from user_cons_columns
where table_name in ('MEMBER' ); 

--member table 에 있는 제약 조건만 출력 
select table_name, constraint_name, column_name
from user_cons_columns
where table_name = 'MEMBER' AND constraint_name = 'PK_MEMBER_ID_NAME';

--게시글 테이블 작성
create table notice (

    board_num varchar2(30) PRIMARY KEY,
    board_name varchar2(50) not null,
    board_text varchar2(100) ,

    --FK
     MEMBER_ID varchar2(30) REFERENCES MEMBER(MEMBER_ID),
     board_date date not null,
     board_count varchar2(5)
);

drop table notice;
drop table MEMBER;

select  * from tab;

-- 회원테이블을 다시 만들자! > 단일컬럼으로(pk가 id랑 name이 2개였음)
create table member(
    MEMBER_ID varchar2(30),
    MEMBER_PW varchar2(20) not null,
    NAME varchar2(20) NOT NULL,
    MOBILE varchar2(13) NOT NULL,
    EMAIL varchar2(30) NOT NULL,
    ENTRY_DATE varchar2(10) NOT NULL,
    GRADE varchar2(1) NOT NULL,
    MILEAGE varchar2(6),
    MANAGER varchar2(20),
    
    CONSTRAINT PK_MEMBER_ID PRIMARY KEY (MEMBER_ID)
);

select * from member;


--게시글 테이블 작성
create table notice (

    board_num varchar2(30) PRIMARY KEY,
    board_name varchar2(50) not null,
    board_text varchar2(100) ,

    --FK
     MEMBER_ID varchar2(30) REFERENCES MEMBER(MEMBER_ID),
     board_date date not null,
     board_count varchar2(5)
     
);

-- 자식 테이블 관계를 함께 삭제하면서 자식 테이블은 유지하고 부모테이블만 삭제
drop table member cascade CONSTRAINTS;


--게시글 테이블 레벨 참조 키 지정 
create table notice (

    board_num varchar2(30) ,
    board_name varchar2(50) not null,
    board_text varchar2(100) ,

    --FK
     MEMBER_ID varchar2(30),
     board_date date not null,
     board_count varchar2(5),
     
     CONSTRAINT FK_MEMBERID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
     
);

--ALTER 사용하기 

drop table notice;
drop table MEMBER;

create table member(
    MEMBER_ID varchar2(30),
    MEMBER_PW varchar2(20) not null,
    NAME varchar2(20) NOT NULL,
    MOBILE varchar2(13) NOT NULL,
    EMAIL varchar2(30) NOT NULL,
    ENTRY_DATE varchar2(10) NOT NULL,
    GRADE varchar2(1) NOT NULL,
    MILEAGE varchar2(6),
    MANAGER varchar2(20)
);

ALTER table member
add CONSTRAINT PK_MEMBER_ID PRIMARY KEY (MEMBER_ID);

create table notice (

    board_num varchar2(30) ,
    board_name varchar2(50) not null,
    board_text varchar2(100) ,

    --FK
     MEMBER_ID varchar2(30),
     board_date date not null,
     board_count varchar2(5)
          
);

ALTER table notice
add CONSTRAINT MEMBER_ID PRIMARY KEY (MEMBER_ID);

ALTER table notice
add CONSTRAINT FK_MEMBERID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID);

-- unique : 중복은 안되는데 null은 허용 
alter table member 
add constraint unique_mobile unique (mobile);

--<INSERT>
-- 지정한 컬럼 순서 대로 
insert into member (MEMBER_ID, MEMBER_PW, NAME, MOBILE, EMAIL, ENTRY_DATE, GRADE, MILEAGE)
values ('user01',	'password01',	'홍길동', '010-1234-1111',	'user01@work.com', '2017.05.05', 'G', 75000	);

--테이블 스키마 구조 순서대로 : 컬럼에 데이터가 없는 경우에는 임의의 값을 지정, 
insert into member
values ('user02',	'password02',	'강감찬', '010-1234-1112',	'user02@work.com', '2017.05.06', 'G', 95000 , null	);
insert into member
values ('user03',	'password03',	'이순신', '010-1234-1113',	'user03@work.com', '2017.05.07', 'G', 3000	 , null	);
insert into member
values ('user04',	'password04',	'김유신', '010-1234-1114',	'user04@work.com', '2017.05.08', 'S' , 100000,null		);
insert into member
values ('user05',	'password05',	'유관순', '010-1234-1115',	'user05@work.com', '2017.05.09', 'A'	 ,120000 , null	);

select * from member;

--<sequence>
--1. 생성 : 시작 1, 1씩 자동 증가
create SEQUENCE SEQ_NO;
-- 일련번호 추출 : 시퀀스명.NEXTVAL
--현재 일련번호 조회 :

--시퀀스 삭제
DROP SEQUENCE SEQ_NO;

--부서테이블 부서번호 컬럼에 사용하기 위한 시퀀스 객체 생성
-- 시퀀스 시작번호 : 50, 시퀀스 증감 값 : 10, 최대값 : 90, 반복여부 : NO?

--시퀀스 속성 설정 및 생성
CREATE SEQUENCE SEQ_DEPT_DEPTNO
    START WITH 50
    INCREMENT BY 10
    MAXVALUE 90
    NOCYCLE
;

-- 부서테이블 레코드 추가
INSERT into dept values (SEQ_DEPT_DEPTNO.nextval, '개발1팀', '제주시');
INSERT into dept values (SEQ_DEPT_DEPTNO.nextval, '개발2팀', '부산');

select * from dept;

--트랜잭션 : 원상 복구
rollback;

--테이블 생성해서 직원 테이블 10번 부서원들의 이름, 직무 정보를 레코드 추가
create table test(
    
    USER_NAME VARCHAR2(20),
    USER_JOB VARCHAR2(15)
    
);

desc test;

select * from test;

-- 직원테이블 10번 부서원의 이름, 직무 조회
insert into test(USER_NAME, USER_JOB)
    select ename, job from emp --alias안 쓰기
    where deptno in (10);

-- 10번 부서원들의 부서번호, 사번 , 이름 , 급여 조회
select deptno, empno, ename, sal
from emp
where deptno = 10;

--emp10
create table emp_10
as
select deptno, empno, ename, sal
from emp
where deptno = 10;

select * from emp_10;

--컬럼명 다르게 지정 사용
create table test_sample(NO,SID,NAME,MILEAGE)
as
select deptno, empno, ename, sal
from emp
where deptno = 10;


select * from test_sample;

--직원테이블의 구조만을 참조해서 테이블 생성
CREATE TABLE NEW_EMP
AS 
SELECT * FROM EMP
WHERE 1=2
;

DESC NEW_EMP;
SELECT * FROM NEW_EMP;



SELECT NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'01',1)),0)  "1월"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'02',1)),0)  "2월"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'03',1)),0)  "3월"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'04',1)),0)  "4월"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'05',1)),0)  "5월"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'06',1)),0)  "6월"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'07',1)),0)  "7월"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'08',1)),0)  "8월"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'09',1)),0)  "9월"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'10',1)),0)  "10월"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'11',1)),0)  "11월"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'12',1)),0)  "12월"
FROM EMP;


