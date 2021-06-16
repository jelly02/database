desc member;

create table "test" (
	data1 varchar2(10),
	"data2" varchar2(10)
);	

select * from tab;

-- test ���̺� ���� ��ȸ
desc test;

desc "test";

-- test ���̺� ����
drop table "test";

-- ���� member ���̺� ����
drop table member;

-- ����� ȸ�����̺� ���� 
-- create table : �ĺ�Ű member_id, name �����÷�
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

-- ���̺��� �����÷������� �ĺ�Ű ���� ����
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

-- ������� data dictionary
-- user_constraints
-- user_cons_columns

desc user_constraints;
desc user_cons_columns;

-- member ���̺� ���� ���� ��ȸ
select table_name, constraint_name, constraint_type
from user_constraints
where table_name in ('MEMBER');

-- user_cons_columns ���̺� �̿��ؼ�
-- MEMBER ���̺��� PK_MEMBER_ID_NAME ���࿡ ���� �÷� ��ȸ
select table_name, constraint_name, column_name
from user_cons_columns
where table_name = 'MEMBER' AND CONSTRAINT_NAME = 'PK_MEMBER_ID_NAME';

-- ȸ���鿡 ���� �Խñ� ���̺� ����
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

-- ���� member ���̺� ����
drop table notice;
drop table member;

-- ȸ�����̺� : PK member_id
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

-- �Խñ����̺� : ȸ�����̵� ����Ű 
-- �Խñ� �÷����� ����Ű ���� 
CREATE table NOTICE (
	notice_no number(8),
    title varchar2(30) not null,
    contents varchar2(500),
    MEMBER_ID varchar2(30) REFERENCES MEMBER(MEMBER_ID),
    write_date date not null,
    hit_count number(10),
    CONSTRAINT PK_NOTICE_notice_no PRIMARY KEY (notice_no)
);
	
-- �Խñ� ���̺��� ����Ű ���� 	
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

-- member, notice ���̺��� ���� ��ȸ

-- �θ����̺� member ���̺����
-- error : �ڽ����̺��� �����ϰ� �ִ� �θ����̺��� ������ ����
drop table member;

-- �ڽ����̺� ���踦 �Բ� �����ϸ鼭 �ڽ����̺��� �����ϰ�, �θ����̺� ����
drop table member cascade constraints;

select * from tab;

desc member;
desc notice;

-- ���� : �ڽ� => �θ�
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

-- member table ���� : master
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

-- ���� �߰� ����
alter table member
add constraint pk_memberid primary key (member_id);

-- constraint add : mobile �ߺ��Ұ� 
alter table member 
add constraint UK_mobile unique (mobile);


-- notice table ���� : detail
CREATE table NOTICE (
	notice_no number(8),
    title varchar2(30) not null,
    contents varchar2(500),
    MEMBER_ID varchar2(30),
    write_date date not null,
    hit_count number(10)
);

-- ���� �߰� ����
-- constraint add : pk
alter table notice
add CONSTRAINT PK_NOTICE_notice_no PRIMARY KEY (notice_no);

-- constraint add : fk
alter table notice
add constraint fk_memberid foreign key (MEMBER_ID) references member(member_id);

-- ȸ�� ���̺� ���ڵ� �߰�
insert into member(member_id, member_pw, name, mobile, email, entry_date, grade, mileage)
values('user01', 'password01', 'ȫ�浿', '010-1234-1111', 'user01@work.com	', '2017.05.05', 'G', 7500);

-- ���̺� ��Ű�� ���� ������� : �÷��� �����Ͱ� ���� ��쿡�� �����ǰ�����, �Ǵ� null
insert into member
values('user02', 'password02', '������	', '010-1234-1112', 'user02@work.com', '2017.05.06', 'G', 95000, null);

insert into member
values('user03', 'password03', '�̼���', '010-1234-1113', 'user03@work.com', '2017.05.07', 'G', 3000, null);

insert into member
values('user04', 'password04', '������', '010-1234-1114', 'user04@work.com', '2017.05.08', 'S', null, '���߱�');

insert into member
values('user05', 'password05', '������', '010-1234-1115', 'user05@work.com', '2017.05.09', 'A', null, null);

-- ȸ�� ��ü ��ȸ
select * from member;

-- �Ϲ�ȸ�� ��ü��ȸ
select * from member where grade = 'G';

-- error �׽�Ʈ : �ĺ�Ű �ߺ�, �޴��� �ߺ�, �����ʰ�, �ʼ��׸� ����(null)
insert into member 
values('test99', 'password05', '������', '010-1234-2777', 'user05@work.com', '2017.05.09', null, null, null);


-- ������ : �ڵ� �Ϸù�ȣ ���� ��ü
CREATE SEQUENCE SEQ_NO;

-- �Ϸù�ȣ ����
SELECT SEQ_NO.NEXTVAL FROM DUAL;

-- ������ ����
DROP SEQUENCE SEQ_NO;

-- ���� �μ����̺� �߰��� �μ��� ��Ͻ�ų�� ����ϱ� ���� ������ ��ü
-- �μ����̺� �μ���ȣ �÷��� ����ϱ����� ������ ��ü ����?? 
-- ������ ���۹�ȣ : 50
-- ������ ������ : 10
-- �ִ밪 ?? : 90
-- �ݺ� ���� ?? : �ݺ��Ǽ��� �ȵ�

-- ���� �ּҺμ���ȣ, �ִ�μ���ȣ ��ȸ : 10, 40 => ������ �߰��Ǵ� �μ���ȣ 50
-- ���� �μ���ȣ�� ������ȸ : 10, 20, 30, 40 => �μ���ȣ 10�� ����
-- �μ����̺� ������ȸ, �μ���ȣ ����� Ȯ�� => NUMBER(2), �ĺ�Ű
-- ������ ����
CREATE SEQUENCE SEQ_DEPT_DEPTNO
START WITH 50
INCREMENT BY 10
MAXVALUE 90
NOCYCLE
;


-- �μ����̺� ���ڵ� �߰� : 
-- �μ���ȣ �������ڵ��ο�, �μ��� ����1��, �μ���ġ ���ֵ�
-- �μ���ȣ �������ڵ��ο�, �μ��� ����2��, �μ���ġ �λ�
insert into dept values(SEQ_DEPT_DEPTNO.nextval, '����1��', '���ֽ�');
insert into dept values(SEQ_DEPT_DEPTNO.nextval, '����2��', '�λ�');

select * from dept;

-- Ʈ����� : ���� ���� : �μ����̺� ���ڵ� �߰� ���
rollback;

DESC EMP;

-- ���� ���ڵ� �߰�
CREATE TABLE TEST(
	USER_NANE VARCHAR2(20),
	USER_JOB VARCHAR2(15)
);

DESC TEST;
SELECT * FROM TEST;

SELECT ENAME, JOB FROM EMP 
WHERE DEPTNO IN (10)
;

-- ���� ���ڵ� �߰� : �����ʹ� SELECT ����� ���	
INSERT INTO TEST(USER_NANE, USER_JOB)
SELECT ENAME, JOB FROM EMP 
WHERE DEPTNO IN (10)
;

-- 10�� �μ������� �μ���ȣ, ���, �̸�, �޿� ���� ��ȸ
SELECT DEPTNO, EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO=10;

-- 10�� �μ������� ���� �� ������ ���� ���̺� ���� : EMP_10
CREATE TABLE EMP_10
AS
SELECT DEPTNO, EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO=10;

SELECT * FROM EMP_10;

-- �÷��� �ٸ��� ���� ���
CREATE TABLE TEST_SAMPLE(NO, SID, NAME, MILEAGE)
AS
SELECT DEPTNO, EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO=10;

SELECT * FROM TEST_SAMPLE;
DESC TEST_SAMPLE;

-- �������̺��� �������� �����ؼ� ���̺� ����
CREATE TABLE NEW_EMP
AS
SELECT * FROM EMP
WHERE 1=2
;

DESC NEW_EMP;

SELECT * FROM NEW_EMP;


