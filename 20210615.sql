desc member;
select * from emp;
select * from dept;

--�׽�Ʈ ���̺� ����
create table "test" (

    data1 varchar2(10),
    "data2" varchar2(10)
);

select * from tab;

--test ���̺� ���� 
desc test; --�� �ȳ�����

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
--���̺� ���� ��ȸ
desc user_constraints;
desc user_cons_columns;

--member ���̺� ���� ���� ��ȸ
select table_name, constraint_name, constraint_type
from user_constraints
where table_name in ('MEMBER' ); -- �˻��ϴ� �ܾ��̱� ������ ��ҹ��ڸ� �����ؼ� �빮�ڷ� ���̺� �̸��� �������

-- user_cons_columns ���̺��� �̿��ؼ� MEMBER ���̺��� PK_MEMBER_ID_NAME ���࿡ ���� �÷� ��ȸ
select PK_MEMBER_ID_NAME
from user_cons_columns
where table_name in ('MEMBER' ); 

--member table �� �ִ� ���� ���Ǹ� ��� 
select table_name, constraint_name, column_name
from user_cons_columns
where table_name = 'MEMBER' AND constraint_name = 'PK_MEMBER_ID_NAME';

--�Խñ� ���̺� �ۼ�
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

-- ȸ�����̺��� �ٽ� ������! > �����÷�����(pk�� id�� name�� 2������)
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


--�Խñ� ���̺� �ۼ�
create table notice (

    board_num varchar2(30) PRIMARY KEY,
    board_name varchar2(50) not null,
    board_text varchar2(100) ,

    --FK
     MEMBER_ID varchar2(30) REFERENCES MEMBER(MEMBER_ID),
     board_date date not null,
     board_count varchar2(5)
     
);

-- �ڽ� ���̺� ���踦 �Բ� �����ϸ鼭 �ڽ� ���̺��� �����ϰ� �θ����̺� ����
drop table member cascade CONSTRAINTS;


--�Խñ� ���̺� ���� ���� Ű ���� 
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

--ALTER ����ϱ� 

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

-- unique : �ߺ��� �ȵǴµ� null�� ��� 
alter table member 
add constraint unique_mobile unique (mobile);

--<INSERT>
-- ������ �÷� ���� ��� 
insert into member (MEMBER_ID, MEMBER_PW, NAME, MOBILE, EMAIL, ENTRY_DATE, GRADE, MILEAGE)
values ('user01',	'password01',	'ȫ�浿', '010-1234-1111',	'user01@work.com', '2017.05.05', 'G', 75000	);

--���̺� ��Ű�� ���� ������� : �÷��� �����Ͱ� ���� ��쿡�� ������ ���� ����, 
insert into member
values ('user02',	'password02',	'������', '010-1234-1112',	'user02@work.com', '2017.05.06', 'G', 95000 , null	);
insert into member
values ('user03',	'password03',	'�̼���', '010-1234-1113',	'user03@work.com', '2017.05.07', 'G', 3000	 , null	);
insert into member
values ('user04',	'password04',	'������', '010-1234-1114',	'user04@work.com', '2017.05.08', 'S' , 100000,null		);
insert into member
values ('user05',	'password05',	'������', '010-1234-1115',	'user05@work.com', '2017.05.09', 'A'	 ,120000 , null	);

select * from member;

--<sequence>
--1. ���� : ���� 1, 1�� �ڵ� ����
create SEQUENCE SEQ_NO;
-- �Ϸù�ȣ ���� : ��������.NEXTVAL
--���� �Ϸù�ȣ ��ȸ :

--������ ����
DROP SEQUENCE SEQ_NO;

--�μ����̺� �μ���ȣ �÷��� ����ϱ� ���� ������ ��ü ����
-- ������ ���۹�ȣ : 50, ������ ���� �� : 10, �ִ밪 : 90, �ݺ����� : NO?

--������ �Ӽ� ���� �� ����
CREATE SEQUENCE SEQ_DEPT_DEPTNO
    START WITH 50
    INCREMENT BY 10
    MAXVALUE 90
    NOCYCLE
;

-- �μ����̺� ���ڵ� �߰�
INSERT into dept values (SEQ_DEPT_DEPTNO.nextval, '����1��', '���ֽ�');
INSERT into dept values (SEQ_DEPT_DEPTNO.nextval, '����2��', '�λ�');

select * from dept;

--Ʈ����� : ���� ����
rollback;

--���̺� �����ؼ� ���� ���̺� 10�� �μ������� �̸�, ���� ������ ���ڵ� �߰�
create table test(
    
    USER_NAME VARCHAR2(20),
    USER_JOB VARCHAR2(15)
    
);

desc test;

select * from test;

-- �������̺� 10�� �μ����� �̸�, ���� ��ȸ
insert into test(USER_NAME, USER_JOB)
    select ename, job from emp --alias�� ����
    where deptno in (10);

-- 10�� �μ������� �μ���ȣ, ��� , �̸� , �޿� ��ȸ
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

--�÷��� �ٸ��� ���� ���
create table test_sample(NO,SID,NAME,MILEAGE)
as
select deptno, empno, ename, sal
from emp
where deptno = 10;


select * from test_sample;

--�������̺��� �������� �����ؼ� ���̺� ����
CREATE TABLE NEW_EMP
AS 
SELECT * FROM EMP
WHERE 1=2
;

DESC NEW_EMP;
SELECT * FROM NEW_EMP;



SELECT NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'01',1)),0)  "1��"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'02',1)),0)  "2��"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'03',1)),0)  "3��"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'04',1)),0)  "4��"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'05',1)),0)  "5��"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'06',1)),0)  "6��"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'07',1)),0)  "7��"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'08',1)),0)  "8��"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'09',1)),0)  "9��"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'10',1)),0)  "10��"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'11',1)),0)  "11��"
		,NVL(SUM(DECODE(TO_CHAR(HIREDATE,'MM'),'12',1)),0)  "12��"
FROM EMP;


