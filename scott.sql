--DROP TABLE EMP;
--DROP TABLE DEPT;
--DROP TABLE SALGRADE;
--
--CREATE TABLE DEPT (
--    DEPTNO DECIMAL(2),
--    DNAME VARCHAR(14),
--    LOC VARCHAR(13),
--    CONSTRAINT PK_DEPT PRIMARY KEY (DEPTNO) 
--);
--
--CREATE TABLE EMP (
--    EMPNO DECIMAL(4),
--    ENAME VARCHAR(10),
--    JOB VARCHAR(9),
--    MGR DECIMAL(4),
--    HIREDATE DATE,
--    SAL DECIMAL(7,2),
--    COMM DECIMAL(7,2),
--    DEPTNO DECIMAL(2),
--    CONSTRAINT PK_EMP PRIMARY KEY (EMPNO),
--    CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO)
--);
--
--CREATE TABLE SALGRADE ( 
--    GRADE NUMBER,
--    LOSAL NUMBER,
--    HISAL NUMBER 
--);
--
--INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
--INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
--INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
--INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,TO_DATE('17-12-1980','DD/MM/YYYY'),800,NULL,20);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,TO_DATE('20-2-1981','DD/MM/YYYY'),1600,300,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,TO_DATE('22-2-1981','DD/MM/YYYY'),1250,500,30);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,TO_DATE('2-4-1981','DD/MM/YYYY'),2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,TO_DATE('28-9-1981','DD/MM/YYYY'),1250,1400,30);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,TO_DATE('1-5-1981','DD/MM/YYYY'),2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,TO_DATE('9-6-1981','DD/MM/YYYY'),2450,NULL,10);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,TO_DATE('13-7-1987','DD/MM/YYYY')-85,3000,NULL,20);
INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,TO_DATE('17-11-1981','DD/MM/YYYY'),5000,NULL,10);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,TO_DATE('8-9-1981','DD/MM/YYYY'),1500,0,30);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,TO_DATE('13-7-1987', 'DD/MM/YYYY'),1100,NULL,20);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,TO_DATE('3-12-1981','DD/MM/YYYY'),950,NULL,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,TO_DATE('3-12-1981','DD/MM/YYYY'),3000,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,TO_DATE('23-1-1982','DD/MM/YYYY'),1300,NULL,10);

--INSERT INTO SALGRADE VALUES (1,700,1200);
--INSERT INTO SALGRADE VALUES (2,1201,1400);
--INSERT INTO SALGRADE VALUES (3,1401,2000);
--INSERT INTO SALGRADE VALUES (4,2001,3000);
--INSERT INTO SALGRADE VALUES (5,3001,9999);
--
--COMMIT;
--
---- show tables;
---- desc dept;
---- select * from dept;
-- select * from emp;
---- select * from salgrade;
select * from emp;

-- =====================================================
-- 1. ��ü ������ ���� ��ȸ
select COUNT(*) from emp;

-- 2. ���� ������ �ִ� ������ ���� ��ȸ
select COUNT(comm) from emp;
select * from emp where comm is not null; --comm�� 0�� ����� ������ �ȵǴ� �� �������� ���� 

-- 3. ���������� ������ �޴� ������ ���� ��ȸ 
select COUNT(comm) from emp 
where comm > 0;

-- 4. �������� �ִ�޿�, �ּұ޿�, ��ձ޿�, �ִ�޿�-�ּұ޿��� ���� ���ϱ�
select MAX(sal) as "�ִ�޿�" , MIN(sal) as "�ּұ޿�" , 
SUM(sal) as "�޿��Ѿ�", ROUND(AVG(sal))  as "��ձ޿�" , MAX(sal)-MIN(sal) "�ִ�޿�-�ּұ޿�"
from emp ;

-- 5. õ �������� �ĸ� ǥ��, �⺻ ������ ��ȭ ��ȣ ǥ�� 
select
    TO_CHAR( MAX(sal), 'L999,999') as "�ִ�޿�" ,
    TO_CHAR(MIN(sal), 'L999,999') as "�ּұ޿�" , 
    TO_CHAR(SUM(sal), 'L999,999') as "�޿��Ѿ�", 
    TO_CHAR(ROUND(AVG(sal)), 'L999,999')  as "��ձ޿�" , 
    TO_CHAR(MAX(sal)-MIN(sal), 'L999,999') "�ִ�޿�-�ּұ޿�"
from emp ;

-- (2) GROUP �Լ��� ����ؼ� �׷��� ����� ��ȸ
--      > SELECT �׸� : GROUP BY ������ �÷���, �׷��Լ�
-- 1. �μ��� ��� �޿� ��ȸ
SELECT deptno,  TO_CHAR( ROUND(AVG(sal)), '$999,999') as "�հ�"
from emp
GROUP BY deptno
ORDER BY deptno;

-- 2. �μ��� ��� �޿��� 2,000 �ʰ��� �μ��� ��ȸ
SELECT deptno,  TO_CHAR( ROUND(AVG(sal)), '$999,999') as "�հ�"
from emp
GROUP BY deptno
HAVING AVG(sal)> 2000
ORDER BY deptno;

-- 3 . �������� ���� ��ȸ
SELECT job from emp
ORDER BY 1;

-- 4. ��ȸ�� �ߺ� �����ϰ� ��ȸ : distinct
SELECT DISTINCT job from emp
ORDER BY 1;

-- 5. �μ� �� ������ ������ ��ȸ
-- ��ȸ�׸� : �μ���ȣ, ����
-- ���� : �μ���ȣ, ���� ������� ��ȸ

SELECT DISTINCT deptno, job from emp
ORDER BY deptno, job;

-- 1. ��ȸ�� ���� �Ϸù�ȣ(rownum), ������ġ(rowId) �� �μ���ȣ, ���, �̸�, �޿� ������ ��ȸ
SELECT  ROWNUM, ROWID deptno, empno, ename, sal
FROM EMP;

-- 2. 10�� �μ����� ������ ��ȸ
SELECT  ROWNUM, ROWID deptno, empno, ename, sal
FROM EMP
where deptno = 10;

-- 3. ������ ���� �ߺ� �����ϰ� ��ȸ 
select DISTINCT job from emp 
order by 1;

-- 4. ���� �� ������ �ο� ���� ��ȸ 
-- ��� ���� : ����, �ο� ��
-- �ο� ���� ���� ������� ���� ��ȸ
select job, count(*)
from emp
group by job
order by 2 desc; --count �Ǿ��°� ����


-- subquery
-- 1. 7499 ������ ���� ��ȸ
select job from emp
where empno = 7499;

-- 2. 1�� ���� ������ ����ϴ� ������ ��ȸ
select job from emp
where job = 'SALESMAN' ;

-- 3. ��ġ�� 
select * from emp
where job = (select job from emp
where empno = 7499) ;

-- Q. ���� �߿��� �޿��� ���� �޴� �ֻ��� 3��  (rownum ���� ���� ����) ������ ��ȸ
--  ��� ���� : ����, ���, �̸�, �޿�
SELECT rownum, empno, ename, sal 
from (select empno, ename, sal  from emp order by sal desc)
where rownum <= 3;

-- <����Լ� > : decode (����Ŭ ����)

-- Q. �������� ������ ���� ����ȸ�� ���� ���
-- ����ȸ�� ��� 
-- (1) PRESIDENT  = �޿� * 30%
-- (2) MANAGER =  �޿� * 25%
-- (3) ANALIST, SALESMAN  =  �޿� * 20%
-- (4) ������ = �޿� * 5%

-- ��� ���� : ���, ����, �޿�, ����ȸ��
-- ����ȸ�� ���� ���� ���� ������� ���� ��ȸ 

-- ��������
select DISTINCT job from emp order by 1;

select empno, ename, sal,
    decode(
        --���� JOB��
        job,
        --�̰Ŷ�� 
        'PRESICDENT' , 
        --�̷���
            SAL * 0.3,
        'MANAGER',
            SAL * 0.25,
         'ANALIST',
            SAL * 0.25,  
          'SALESMAN',
            SAL * 0.25, 
    -- defalut
            SAL * 0.05
    ) "����ȸ��"
from emp
order by ����ȸ�� desc;

select empno, ename, sal,
TO_CHAR(
        trunc(
                    decode(
                        --���� JOB��
                        job,
                        --�̰Ŷ�� 
                        'PRESICDENT' , 
                        --�̷���
                            SAL * 0.3,
                        'MANAGER',
                            SAL * 0.25,
                         'ANALIST',
                            SAL * 0.25,  
                          'SALESMAN',
                            SAL * 0.25, 
                    -- defalut
                            SAL * 0.05
                    )
                ) , '$999,999 ') "����ȸ��"
from emp
order by ����ȸ�� desc;

-- ===============�̼� 1_select ===================
select * from emp;
-- 1. 
select empno, ename, to_date(hiredate, 'YYYY/MM/DD') from emp;
-- 2.
select DISTINCT job from emp
order by job;
-- 3
select * from emp
where sal >= 3000;
-- 4
select * from emp
where ename = 'SMITH';
-- 5
select * from emp where deptno = 10;
select * from (select * from emp where deptno = 10)
where job = 'MANAGER';
-- 6
select * from (select * from emp where deptno != 10)
where job = 'MANAGER' OR job = 'CLARK';
-- 7
select * from emp where sal > 1000 and sal <3000;
select * from (select * from emp where sal > 1000 and sal <3000)
where job = 'SALESMAN' ;
--8 
select * from emp
where job = 'CLERK'  or  job = 'MANAGER' or   job ='SALESMAN';
--9
select * from emp
where job != 'CLERK'  and  job != 'MANAGER' and   job !='SALESMAN';
-- 10
select * from (select * from emp where sal > 2000)
where ename like '%A%';
-- 11
select to_char(sysdate, 'YYYY/MM/DD') as "���� ��¥" from dual;
--12
select TO_CHAR(SYSDATE, 'AM HH:MI') as "���� �ð�" FROM dual;
--13
select deptno as "�μ���ȣ" , count(*) as "�ο� ��", sum(sal) as "�� �޿�" , 
ROUND(avg(sal)) as "��ձ޿�" , max(sal) as "�ִ�޿�", min(sal) as "�ּұ޿�" , max(sal) -min(sal) as "�޿�����"
from emp
group by deptno;
--14
--15
select empno, sal,
case
          when sal < (select avg(sal) from emp) then '�����'
                    else '�̴��'
          end "��󿩺�"
from emp
order by ��󿩺�;

