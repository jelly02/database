/* 
	SQL Script File : member_ddl.sql
	Member Sehema
*/

-- drop table
drop table member cascade constraintss;

-- create table : 식별키 member_id 단일컬럼
create table member (
	member_id varchar2(30) primary key,
	member_pw varchar2(20) not null,
	name varchar2(20) not null,
	mobile varchar2(13) not null,
	email varchar2(30) not null,
	entry_date varchar2(10) not null,
	grade varchar2(1) not null,
	mileage number(6),
	manager varchar2(20)
);


-- create table : 식별키 member_id, name 다중컬럼
-- error : 컬럼레벨로 primary key는 단일컬럼에만 적용 가능
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

-- 테이블레벨 단일컬럼 식별키 제약 지정
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
