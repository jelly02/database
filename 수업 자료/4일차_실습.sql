desc member;

create table "test" (
	data1 varchar2(10),
	"data2" varchar2(10)
);	

select * from tab;

-- test 테이블 구조 조회
desc test;

desc "test";

-- test 테이블 삭제
drop table "test";

-- 기존 member 테이블 삭제
drop table member;

-- 변경된 회원테이블 생성 
-- create table : 식별키 member_id, name 다중컬럼
create table member (
	member_id varchar2(30) primary key,
	member_pw varchar2(20) not null,
	name varchar2(20) primary key,
	mobile varchar2(13) not null,
	email varchar2(30) not null,
	entry_date varchar2(10) not null,
	grade varchar2(1) not null,
	mileage number(6),
	manager varchar2(20)
);

-- 테이블레벨 다중컬럼에대한 식별키 제약 지정
create table member (
	member_id varchar2(30),
	member_pw varchar2(20) not null,
	name varchar2(20),
	mobile varchar2(13) not null,
	email varchar2(30) not null,
	entry_date varchar2(10) not null,
	grade varchar2(1) not null,
	mileage number(6),
	manager varchar2(20),
	CONSTRAINT PK_MEMBER_ID_NAME PRIMARY KEY (MEMBER_ID, NAME)
);

DESC MEMBER;

-- 제약관련 data dictionary
-- user_constraints
-- user_cons_columns

desc user_constraints;
desc user_cons_columns;

-- member 테이블에 대한 제약 조회
select table_name, constraint_name, constraint_type
from user_constraints
where table_name in ('MEMBER');

-- user_cons_columns 테이블 이용해서
-- MEMBER 테이블의 PK_MEMBER_ID_NAME 제약에 대한 컬럼 조회
select table_name, constraint_name, column_name
from user_cons_columns
where table_name = 'MEMBER' AND CONSTRAINT_NAME = 'PK_MEMBER_ID_NAME';

-- 회원들에 대한 게시글 테이블 생성
CREATE table NOTICE (
	notice_no number(8),
    title varchar2(30) not null,
    contents varchar2(500),
    MEMBER_ID varchar2(30),
    write_date date not null,
    hit_count number(10),
    CONSTRAINT PK_NOTICE_notice_no PRIMARY KEY (notice_no)
);

desc notice;

drop table notice;

CREATE table NOTICE (
	notice_no number(8),
    title varchar2(30) not null,
    contents varchar2(500),
    MEMBER_ID varchar2(30) REFERENCES MEMBER(MEMBER_ID),
    write_date date not null,
    hit_count number(10),
    CONSTRAINT PK_NOTICE_notice_no PRIMARY KEY (notice_no)
);
	
select * from tab;
desc member;

-- 기존 member 테이블 삭제
drop table notice;
drop table member;

-- 회원테이블 : PK member_id
create table member (
	member_id varchar2(30),
	member_pw varchar2(20) not null,
	name varchar2(20),
	mobile varchar2(13) not null,
	email varchar2(30) not null,
	entry_date varchar2(10) not null,
	grade varchar2(1) not null,
	mileage number(6),
	manager varchar2(20),
	CONSTRAINT PK_MEMBER_ID PRIMARY KEY (MEMBER_ID)
);

-- 게시글테이블 : 회원아이디 참조키 
-- 게시글 컬럼레벨 참조키 지정 
CREATE table NOTICE (
	notice_no number(8),
    title varchar2(30) not null,
    contents varchar2(500),
    MEMBER_ID varchar2(30) REFERENCES MEMBER(MEMBER_ID),
    write_date date not null,
    hit_count number(10),
    CONSTRAINT PK_NOTICE_notice_no PRIMARY KEY (notice_no)
);
	
-- 게시글 테이블레벨 참조키 지정 	
CREATE table NOTICE (
	notice_no number(8),
    title varchar2(30) not null,
    contents varchar2(500),
    MEMBER_ID varchar2(30),
    write_date date not null,
    hit_count number(10),
    CONSTRAINT PK_NOTICE_notice_no PRIMARY KEY (notice_no),
	constraint fk_memberid foreign key (MEMBER_ID) references member(member_id)
);

-- member, notice 테이블의 제약 조회

-- 부모테이블 member 테이블삭제
-- error : 자식테이블이 참고하고 있는 부모테이블은 삭제시 오류
drop table member;

-- 자식테이블 관계를 함께 삭제하면서 자식테이블은 유지하고, 부모테이블만 삭제
drop table member cascade constraints;

select * from tab;

desc member;
desc notice;

-- 삭제 : 자식 => 부모
drop table notice;
drop table member;

create table member(
    MEMBER_ID varchar2(30) ,
    MEMBER_PW varchar2(20) not null,
    NAME VARCHAR2(20),
    MOBILE VARCHAR2(13) NOT NULL,
    EMAIL VARCHAR2(30) NOT NULL,
    ENTRY_DATE VARCHAR2(10) NOT NULL,
    GRADE VARCHAR2(1) NOT NULL,
    MILEAGE NUMBER(6) ,
    MANAGER VARCHAR2(20),
	constraint PK_MEMBER_ID PRIMARY KEY(MEMBER_ID)
);

create table notice(
    POST_NO NUMBER(6),
    TITLE varchar2(20) NOT NULL,
    CONTENTS varchar2(4000),
    MEMBER_ID varchar2(30) ,
    WRITE_DATE DATE NOT NULL,
    VIEWS NUMBER(10),
    CONSTRAINT PK_NOTICE_POST_NO PRIMARY KEY(POST_NO),
    CONSTRAINT FK_MEMBERID FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
 ); 

-- member table 생성 : master
create table member (
	member_id varchar2(30),
	member_pw varchar2(20) not null,
	name varchar2(20),
	mobile varchar2(13) not null,
	email varchar2(30) not null,
	entry_date varchar2(10) not null,
	grade varchar2(1) not null,
	mileage number(6),
	manager varchar2(20)
);

-- 제약 추가 변경
alter table member
add constraint pk_memberid primary key (member_id);

-- constraint add : mobile 중복불가 
alter table member 
add constraint UK_mobile unique (mobile);


-- notice table 생성 : detail
CREATE table NOTICE (
	notice_no number(8),
    title varchar2(30) not null,
    contents varchar2(500),
    MEMBER_ID varchar2(30),
    write_date date not null,
    hit_count number(10)
);

-- 제약 추가 변경
-- constraint add : pk
alter table notice
add CONSTRAINT PK_NOTICE_notice_no PRIMARY KEY (notice_no);

-- constraint add : fk
alter table notice
add constraint fk_memberid foreign key (MEMBER_ID) references member(member_id);

-- 회원 테이블 레코드 추가
insert into member(member_id, member_pw, name, mobile, email, entry_date, grade, mileage)
values('user01', 'password01', '홍길동', '010-1234-1111', 'user01@work.com	', '2017.05.05', 'G', 7500);

-- 테이블 스키마 구조 순서대로 : 컬럼에 데이터가 없는 경우에는 임의의값지정, 또는 null
insert into member
values('user02', 'password02', '강감찬	', '010-1234-1112', 'user02@work.com', '2017.05.06', 'G', 95000, null);

insert into member
values('user03', 'password03', '이순신', '010-1234-1113', 'user03@work.com', '2017.05.07', 'G', 3000, null);

insert into member
values('user04', 'password04', '김유신', '010-1234-1114', 'user04@work.com', '2017.05.08', 'S', null, '송중기');

insert into member
values('user05', 'password05', '유관순', '010-1234-1115', 'user05@work.com', '2017.05.09', 'A', null, null);

-- 회원 전체 조회
select * from member;

-- 일반회원 전체조회
select * from member where grade = 'G';

-- error 테스트 : 식별키 중복, 휴대폰 중복, 길이초과, 필수항목 누락(null)
insert into member 
values('test99', 'password05', '유관순', '010-1234-2777', 'user05@work.com', '2017.05.09', null, null, null);


-- 시퀀스 : 자동 일련번호 제공 객체
CREATE SEQUENCE SEQ_NO;

-- 일련번호 추출
SELECT SEQ_NO.NEXTVAL FROM DUAL;

-- 시퀀스 삭제
DROP SEQUENCE SEQ_NO;

-- 현재 부서테이블에 추가로 부서를 등록시킬때 사용하기 위한 시퀀스 객체
-- 부서테이블에 부서번호 컬럼에 사용하기위한 시퀀스 객체 생성?? 
-- 시퀀스 시작번호 : 50
-- 시퀀스 증감값 : 10
-- 최대값 ?? : 90
-- 반복 여부 ?? : 반복되서는 안됨

-- 현재 최소부서번호, 최대부서번호 조회 : 10, 40 => 다음에 추가되는 부서번호 50
-- 현재 부서번호만 정렬조회 : 10, 20, 30, 40 => 부서번호 10씩 증가
-- 부서테이블 구조조회, 부서번호 어떤구조 확인 => NUMBER(2), 식별키
-- 시퀀스 생성
CREATE SEQUENCE SEQ_DEPT_DEPTNO
START WITH 50
INCREMENT BY 10
MAXVALUE 90
NOCYCLE
;


-- 부서테이블 레코드 추가 : 
-- 부서번호 시퀀스자동부여, 부서명 개발1팀, 부서위치 제주도
-- 부서번호 시퀀스자동부여, 부서명 개발2팀, 부서위치 부산
insert into dept values(SEQ_DEPT_DEPTNO.nextval, '개발1팀', '제주시');
insert into dept values(SEQ_DEPT_DEPTNO.nextval, '개발2팀', '부산');

select * from dept;

-- 트랜잭션 : 원상 복구 : 부서테이블 레코드 추가 취소
rollback;

DESC EMP;

-- 다중 레코드 추가
CREATE TABLE TEST(
	USER_NANE VARCHAR2(20),
	USER_JOB VARCHAR2(15)
);

DESC TEST;
SELECT * FROM TEST;

SELECT ENAME, JOB FROM EMP 
WHERE DEPTNO IN (10)
;

-- 다중 레코드 추가 : 데이터는 SELECT 결과를 사용	
INSERT INTO TEST(USER_NANE, USER_JOB)
SELECT ENAME, JOB FROM EMP 
WHERE DEPTNO IN (10)
;

-- 10번 부서원들의 부서번호, 사번, 이름, 급여 정보 조회
SELECT DEPTNO, EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO=10;

-- 10번 부서원들의 정보 및 구조를 갖는 테이블 생성 : EMP_10
CREATE TABLE EMP_10
AS
SELECT DEPTNO, EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO=10;

SELECT * FROM EMP_10;

-- 컬럼명 다르게 지정 사용
CREATE TABLE TEST_SAMPLE(NO, SID, NAME, MILEAGE)
AS
SELECT DEPTNO, EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO=10;

SELECT * FROM TEST_SAMPLE;
DESC TEST_SAMPLE;

-- 직원테이블의 구조만을 참조해서 테이블 생성
CREATE TABLE NEW_EMP
AS
SELECT * FROM EMP
WHERE 1=2
;

DESC NEW_EMP;

SELECT * FROM NEW_EMP;


