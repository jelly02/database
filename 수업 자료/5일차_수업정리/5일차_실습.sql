-- ���̺� ��� ��ȸ
-- ȸ�� MEMBER ���� ��ȸ
-- �Խñ� NOTICE ���� ��ȸ
-- ȸ�� ��ü ���ڵ� ��ȸ
-- �Խñ� ��ü ���ڵ� ��ȸ

select * from member;
select * from notice;

-- �Ϲ�ȸ�� ��ü ��ȸ
select * from member where grade = 'G';

-- �Ϲ�ȸ���鿡�� ���ϸ��� = ���ϸ��� + 1000 ���� 
update member set mileage = 1000;

update member set mileage = mileage + 1000
where grade = 'G';

-- user01 ȸ���� ����� ���ȸ������ ���ó��
-- ����� : ��⿵
-- ���ϸ��� : 0 
update member 
set mileage = 0, manager = '��⿵', grade = 'S' 
where member_id = 'user01';

-- ��üȸ�� ���� : �Խñ� ���� ���ڵ� ���� ���� �Ұ�
delete member;

-- �Խñ��� �ۼ����� ���� ȸ�� ���� : user02
delete member
where member_id='user02';

-- �Խñ� �ۼ��� ȸ�����̵� �ߺ������ϰ� ���̵� ������ȸ
-- �Խñ� �ۼ� ȸ�� : user01, user04, user05
select distinct member_id from notice 
order by member_id;

-- �Խñ� ��ü ����
delete notice;

-- truncate table
-- �Խñ��� �ۼ����� ���� ȸ�� ���� : user02
-- error : where ���� ���� �Ұ�
-- truncate table member where member_id='user01';

-- truncate table �Խñ� ��ü ����
-- rollback ���� �Ұ�
truncate table notice;

-- ������ ����
rollback;

-- db ���� �ݿ�
commit;

-- ����(JOIN)
-- CROSS JOIN
SELECT * 
FROM EMP, DEPT;

-- CORSS JOIN�� ����� ���� ��� ��ȸ
SELECT COUNT(*)
FROM EMP, DEPT;

SELECT (SELECT COUNT(*) FROM EMP) * (SELECT COUNT(*)FROM DEPT) 
FROM DUAL;

-- ���� �׽�Ʈ�� ���� ���Ի�� ���ڵ� �߰�
-- ��� 7777, �̸� ȫ�浿, �Ի��� ���糯¥, �޿� 4000
-- �μ� �̹���, ��� �̹���, ������ �̹���
INSERT INTO EMP(EMPNO, ENAME, HIREDATE, SAL)
VALUES(7777, 'ȫ�浿', SYSDATE, 4000);

-- DB ���� �ݿ�
commit;

DESC EMP;
select * from emp;

-- �μ����̺� ���� ��ȸ

-- ����Ŭ equi-join
-- ������ �μ���ȣ, �μ���, �μ���ġ, ���, �̸� ������ ��ȸ : ����(������ �μ���ȣ => �μ����̺� �μ���ȣ)
select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno = dept.deptno
order by emp.deptno;
-- �������ǿ� �ش���� �ʴ� ���ڵ�� ��ȸ���� ����

-- outer join
-- ������ ������ ��ȸ

-- �μ����� ���� �μ���ȣ ��ȸ : 40
SELECT DISTINCT DEPTNO FROM DEPT 
WHERE DEPTNO NOT IN (SELECT DISTINCT NVL(DEPTNO, 0) FROM EMP);

SELECT DISTINCT NVL(DEPTNO, 0) FROM EMP;

-- �μ��� �������� ���� ����� ���� ��ȸ : null
select empno, deptno from emp where deptno is null;

-- outer join : �μ��� �������� ���� ������ ������ �Բ� ��ȸ
select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno = dept.deptno(+)
order by emp.deptno;


-- �μ����� ���� �μ��� ������ �Բ� ��ȸ
select dept.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno(+) = dept.deptno
order by emp.deptno;

-- full outer join
-- �μ��� �������� ���� ����, �μ����� ���� �μ��� ������ �Բ� ��ȸ
-- error : oracle full outer join ������������
-- �ذ� : oracle ���տ��� union 
select dept.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno(+) = dept.deptno(+)
order by emp.deptno;


-- self join
-- ������ ���, �̸�, �����, ����̸� ���� ��ȸ
-- ������ ��� ���� ��ȸ
select ����.empno �������, ����.ename �����̸�, ���.empno �����, ���.ename ����̸� 
from emp ����, emp ���
where ����.mgr = ���.empno
order by ����.empno
;

-- ��簡 ���� �������� ����
-- outer join ��簡 ���� ���������� �Բ� ��ȸ
select ����.empno �������, ����.ename �����̸�, ���.empno �����, ���.ename ����̸� 
from emp ����, emp ���
where ����.mgr = ���.empno(+)
order by ����.empno
;

select * from tab;

-- �޿� ��� ���̺� ��ȸ(salgrade) : ����, ��ü ���ڵ� ��ȸ
desc salgrade;
select * from salgrade;

SELECT EMPNO, SAL, GRADE
FROM EMP, SALGRADE
WHERE SAL >= LOSAL AND SAL <= HISAL;

select empno, sal, grade
from emp, salgrade
where sal between losal and hisal;

-- ���̺� �˸��ƽ� �����ϰ�, ��������� ����
select E.empno, E.sal, S.grade
from emp E, salgrade S
where sal between losal and hisal;

select empno ���, sal �޿�, (select grade from salgrade where emp.sal between losal and hisal) ���
from emp, salgrade
order by 1;

-- ���տ�����
-- 1. ������ �μ���ȣ, �̸� ��ȸ : 10��, 20�� �μ��� ��ȸ
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 20);

-- 2. ������ �μ���ȣ, �̸� ��ȸ : 10��, 30�� �μ��� ��ȸ	
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 30);

-- 1. ������ (�ߺ� ����)
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 20)
UNION ALL
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 30);

-- 2. ������ (�ߺ� ����)
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 20)
UNION 
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 30);

-- 3. ������
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 20)
INTERSECT 
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 30);

-- 4. ������
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 20)
MINUS 
SELECT DEPTNO, ENAME FROM EMP WHERE DEPTNO IN (10, 30);

-- �μ��� �������� ���� ����, �μ����� ���� �μ��� ������ �Բ� ��ȸ
-- ERROR : ORACLE FULL OUTER JOIN �������� ����
-- �ذ� : ���տ���(UNION) ó��
select emp.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno = dept.deptno(+)
UNION
select dept.deptno, dname, loc, empno, ename
from emp, dept
where emp.deptno(+) = dept.deptno
;

-- ��(VIEW)
-- HR: ���̺� ��ü ��� ��ȸ
SELECT * FROM TAB;

-- HR VIEW : EMP_DETAILS_VIEW ��ü ���ڵ� ��ȸ
SELECT * FROM EMP_DETAILS_VIEW;

-- VIEW �����͵�ųʸ� : USER_VIEWS
-- USER_VIEWS ���� ��ȸ
DESC USER_VIEWS;

-- EMP_DETAILS_VIEW VIEW ���� SQL ���� ��ȸ
SELECT VIEW_NAME, TEXT_LENGTH, TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'EMP_DETAILS_VIEW';


-- SCOTT : ��ü ���̺� ��� ��ȸ
SELECT * FROM TAB;

-- �� ����
-- �������̺� : ���, �̸�, �޿�, 10�� �μ���
-- ���̸� : EMP10_SIMPLE_VIEW

-- 1. �並 ���� SELECT
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

-- 2. SELECT ����� VIEW ����
CREATE VIEW EMP10_SIMPLE_VIEW
AS
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

-- ���̺� �����ȸ = TABLE, VIEW
SELECT * FROM TAB;

-- �� : ��ü ���ڵ� ��ȸ
SELECT * FROM emp10_simple_view;

-- �������̺��� 10�� �μ����߿��� 7782 ������ ����
SELECT DEPTNO, EMPNO FROM EMP
WHERE EMPNO=7782;

DELETE EMP WHERE EMPNO=7782;

-- ���� ���̺��� 10�� �μ����� ���� ��ȸ
SELECT * FROM EMP WHERE DEPTNO=10;

-- 10�� �μ����� ���� �並 ��ȸ
SELECT * FROM emp10_simple_view;

-- �信�� 7934 ������ �޿��� 10000 ����
UPDATE emp10_simple_view SET SAL = 10000
WHERE EMPNO=7934;

-- �� ���� : DDL (TCL AUTO COMMIT)
DROP VIEW emp10_simple_view;

-- ���� ��Ȳ���� ROLLBACK�� �ϸ� ������ 10�� �μ����� �������ɱ��??
ROLLBACK;


-- JOIN �ؼ� VIEW ����
-- ��ȸ�׸� : �μ���ȣ, �μ���, ���, �̸�
-- �б� ���� �� ����
-- ���̸� : EMP_VIEW
-- 1. JOIN
SELECT EMP.DEPTNO, DEPT.DNAME, EMP.EMPNO, EMP.ENAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
;

-- 2. VIEW
CREATE OR REPLACE VIEW EMP_VIEW
AS
SELECT EMP.DEPTNO, DEPT.DNAME, EMP.EMPNO, EMP.ENAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
WITH READ ONLY
;

-- 3. VIEW ��ȸ
SELECT * FROM EMP_VIEW;


