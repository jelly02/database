-- �л�  ���� ���̺� ����
create table student_score (
     student_no number(5) PRIMARY KEY,
     name varchar2(30) not null,
     score number(3)
);

--���̺� ��� ��ȸ
select * from tab;

--���̺� ���� ��ȸ
desc student_score;

--ȸ�� ���̺� �����

create table member 
(
    member_id varchar2(30) PRIMARY KEY,
    member_pw varchar2(20) not null,
    name  varchar2(20) not null,
    mobile  varchar2(13) not null,
    email varchar2(30) not null,
    entry_date  varchar2(10) not null,
    grade  varchar2(3) not null,
    mileage number(6),
    manager varchar2 (30)
);

select * from member;