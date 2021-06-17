select * from notice;
select * from member;

-- �Խñ� �߰� 
insert into notice
values ('1','�ָ�����	','ȸ����������DB����','user05','2020.11.11','0') ; 
insert into notice
values ('2','������� ','������� �Ұ�','user04','2020.12.25','5') ; 
insert into notice
values ('3','�ָ�����','ȭ�����Ǽ�','user05','2021.02.14','0') ; 
insert into notice
values ('4','��������','�ð�����','user05','2021.03.01','15') ; 
insert into notice
values ('5','WEB����','www.w3schools.com','user01','2021.05.26','5') ; 

--�Ϲ�ȸ�� ��ü ��ȸ 
select * from member where grade = 'G';

-- �Ϲ�ȸ�� ���ϸ��� +1000 
update member set mileage = mileage + 1000
where grade = 'G';

--������ ���� 
ROLLBACK;

select * from member;

--DB ���� �ݿ�
COMMIT;

-- USER01�� ȸ�� ����� ��� ȸ������ ��� ó�� �� ����ڸ� '��⿵'���� �ٲ�
--��� �� ���ϸ��� 0���� 
UPDATE MEMBER SET MILEAGE = 0, GRADE = 'S', MANAGER = '��⿵'
WHERE MEMBER_ID = 'user01';

--DB ���� �ݿ�
COMMIT;

--�Խñ��� �ۼ��� ȸ�����̵� �ߺ� �����ϰ� ���̵� ���� ��ȸ

insert into notice
values ('6','��ħ�� ���� �Ͼ�ϱ�','�ű��ؿ�','user01','2021.06.15','1') ; 

select distinct member_id from notice 
order by member_id;

--�Խñ��� �ۼ����� ���� ȸ�� ���� 
insert into member
values ('user06',	'password02',	'������', '010-1234-8484',	'user02@work.com', '2017.05.06', 'G', 95000 , null	);

delete member where member_id = 'user06';

--������ ���� 
ROLLBACK;

--DB ���� �ݿ�
COMMIT;

-- �Խñ� ��ü ����
delete notice;

-- ȸ�� ��ü ����
delete member;

--truncate table �Խñ� ��ü ���� : �޸𸮿��� �ƿ� out�Ǿ rollback �ص� �� �츲
select * from notice;

--<1. CROSS JOIN>
select * from emp, dept;

--(1) CROSS JOIN�� �����  ���� ��� ��ȸ
SELECT (select count(*) from emp) * (select count(*) from dept)
from dual;
SELECT COUNT(*) FROM EMP, DEPT;

--(2) �������̺� ���Ի�� ���ڵ� ���
-- ��� 7777, ȫ�浿, �Ի��� ���糯¥, �޿� 4000
desc emp;
INSERT INTO EMP(EMPNO, ENAME, HIREDATE, SAL) VALUES(7777, 'ȫ�浿', SYSDATE, 4000);

commit;

select * from emp;

--�μ� ���̺� ���� ��ȸ
select * from dept;

select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno = dept.deptno
order by emp.deptno;

--<Outer Join>
--������ ������ ��ȸ
-- �μ����� ���� �μ���ȣ ��ȸ 
select * from dept;
select * from emp;

select * from emp
where deptno = null;

select DISTINCT deptno from dept
where deptno not in  (select DISTINCT nvl(deptno, 0) from emp);


--�μ��� �������� ���� ����� ���� ��ȸ 
select * from emp
where deptno IS NULL;


--�μ��� �������� ���� ����� ������ �Բ� ��ȸ
select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno = dept.deptno (+)
order by emp.deptno;

--40�� �μ��� ������
select dept.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno  (+) = dept.deptno
order by emp.deptno;

--�μ��� �������� ���� ����, �μ����� ���� �μ��� ������ �Բ� ��ȸ

-- <SELF JOIN>
-- ������ ���, �̸�, �����, ����̸� ������ȸ
--������ ��� ���� ��ȸ

SELECT ����.empno �������,  ����.ename �����̸�,  ���.empno �����, ���.ename ����̸�
from emp ����, emp ���
where ����.mgr = ���.empno
order by ����.empno; --��簡 ���� ���� ������

--<Outer Join> 
--��簡 ���� ���� ������ �Բ� ��ȸ
--null�� ���� �ʿ��ٰ� ++
SELECT ����.empno �������,  ����.ename �����̸�,  ���.empno �����, ���.ename ����̸�
from emp ����, emp ���
where ����.mgr = ���.empno (+)
order by ����.empno;

--<Non-Equi Join>
-- �޿� ��� ���̺� ��ȸ : ���� , ��ü ���ڵ� ��ȸ
desc salgrade;
SELECT * from salgrade;

--������ ���, �޿�, �޿���� ��ȸ
-- ���̺� ���� : ����, �޿���� 

select empno, sal, grade
from emp, salgrade
where sal  between losal and hisal;

--�ǽ� : �μ���ȣ, �μ���, ���, �̸�, �޿�, �޿���� ���� ��ȸ
--3�� ���̺� ���� : ����, �μ�, �޿����
-- losal�� �ּұ޿� hisal�� �ִ� �޿��ΰ� ���ƿ�!!
-- 1 800 1200 �̸� 1����� �޿��� 800 ~ 1200 �� ����̿�
select e.deptno, d.dname, e.empno, e.ename, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno AND e.sal between s.losal and s.hisal;

select * from salgrade;
select * from emp;

--<���տ�����>
--1. ������ �μ���ȣ, �̸� ��ȸ : 10, 20
select deptno, ename from emp
where deptno in (10,20);

--2. ������ �μ���ȣ, �̸� ��ȸ : 10, 30
select deptno, ename from emp
where deptno in (10,30);

--1. ������ (�ߺ� ����)
select deptno, ename from emp
where deptno in (10,20)
union all
select deptno, ename from emp
where deptno in (10,30);

--2. ������ (�ߺ� ����)
select deptno, ename from emp
where deptno in (10,20)
union 
select deptno, ename from emp
where deptno in (10,30);
--3. ������ : 10�� �μ������� ������ ��� ��
select deptno, ename from emp
where deptno in (10,20)
INTERSECT
select deptno, ename from emp
where deptno in (10,30);
--4.������ : 
select deptno, ename from emp
where deptno in (10,20)
minus
select deptno, ename from emp
where deptno in (10,30);

-- �μ��� �������� ���� ����, �μ����� ���� �μ��� ������ �Բ� ��ȸ
select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno = dept.deptno (+)
union
select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno  (+) = dept.deptno;

-- <view>
--���̺� ��ȸ 
select * from tab;

--view ����
-- ���� ���̺� : ���, �̸�, �޿�, 10�� �μ���
-- �� �̸� : emp10_simple_view

select empno, ename, sal, deptno
from emp
where deptno = 10;

--select ����� view ����
create view emp_10_simple_view
as
select empno, ename, sal, deptno
from emp
where deptno = 10;

-- ���̺� ��� ��ȸ = tabie, view
select * from tab;

--�� : ��ü ���ڵ� ��ȸ
select * from emp_10_simple_view;

-- ���� ���̺��� 10�� �μ��� �� 7782 ������ ����
select * from emp
where empno = 7782;

delete emp where empno = 7782;

--�������̺��� 10�� �μ����� ���� ��ȸ 
select *
from emp
where deptno = 10;

--�� : ��ü ���ڵ� ��ȸ
select * from emp_10_simple_view;

--�� : 7934�� ���� �޿��� 10000 ����
update emp_10_simple_view set sal = 10000
where empno = 7934;

--�� : ��ü ���ڵ� ��ȸ
select * from emp_10_simple_view;

--�������̺��� 10�� �μ����� ���� ��ȸ 
select *
from emp
where deptno = 10;

--�� : ����
drop view emp_10_simple_view;

--join�ؼ� view �����ϱ�
-- �б� ���� �� ����
create or replace view emp_view
as
select emp.deptno, dept.dname, emp.empno, emp.ename
from emp, dept
where emp.deptno = dept.deptno
with read only
;

-- <ANSI ǥ�� ����> 
select * from emp cross join dept;

select deptno, dname,empno,ename
from emp natural join dept;

--<outer join>
-- �μ��� �������� ���� ������ ����
select dept.deptno, dname, loc, empno, ename
from emp left outer join dept
on (emp.deptno = dept.deptno)
;

-- �μ����� ���� �μ��� ������ �Բ� ��ȸ
select dept.deptno, dname, loc, empno, ename
from emp right outer join dept
on (emp.deptno = dept.deptno)
;

--full outer join : �μ����� ���� �μ�, �μ��� �������� ���� ����
select dept.deptno, dname, loc, empno, ename
from emp full outer join dept
on (emp.deptno = dept.deptno)
;

--non equi join
--������ ���, �޿�, �޿� ��� ��ȸ
select empno, sal, grade
from emp, salgrade
where sal between losal and hisal;

--ansi join 
select empno, sal, grade
from emp  join salgrade
on (sal between losal and hisal);