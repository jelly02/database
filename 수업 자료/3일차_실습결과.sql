-- ��ü ������ ���� ��ȸ
select count(*) from emp;
select count(empno) from emp;

-- ���� ������ �ִ� ������ ���� ��ȸ
select count(comm) from emp;

-- ���������� ������ �޴� ������ ���� ��ȸ
select count(comm) from emp
where comm > 0;

-- ������ �ִ� ���� ���� ��ȸ
select * from emp where comm is not null;

-- �������� �ִ�޿�, �ּұ޿�, �޿��Ѿ�, ��ձ޿�, �ִ�޿�-�ּұ޿�����
-- õ�������� �ĸ�ǥ��, �⺻ ������ ��ȭ��ȣ ǥ��
SELECT 
    MIN(SAL) �ּұ޿�, 
    MAX(SAL) �ִ�޿�, 
    SUM(SAL) �޿��Ѿ�, 
    ROUND(AVG(SAL)) ��ձ޿�, 
    MAX(SAL)-MIN(SAL) "�ִ�޿�-�ּұ޿�" 
FROM EMP ;

SELECT 
    to_char(MIN(SAL), 'L999,999') �ּұ޿�, 
    to_char(MAX(SAL), 'L999,999') �ִ�޿�, 
    to_char(SUM(SAL), 'L999,999') �޿��Ѿ�, 
    to_char(ROUND(AVG(SAL)), 'L999,999') ��ձ޿�, 
    to_char(MAX(SAL)-MIN(SAL), 'L999,999') "�ִ�޿�-�ּұ޿�" 
FROM EMP ;

-- GROUP �Լ��� ����ؼ� �׷��� ����� ��ȸ
-- SELECT ~ FROM ~ WHERE ~ GROUP BY ~ HAVEING ~ ORDER BY
-- SELECT �׸� : GROUP BY ������ �÷���, �׷��Լ�

-- �μ��� ��ձ޿� ��ȸ 
-- ������� : �μ���ȣ, ��ձ޿�
-- �Ҽ����� ó��, ���� õ����ǥ��, ��ȭ��ȣ ǥ��
SELECT DEPTNO, to_char(ROUND(AVG(SAL), 2), '$999,999.99')
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- �μ��� ��ձ޿� ��ȸ
-- �μ��� ��ձ޿��� 2,000 �ʰ��� �μ��� ���ؼ��� ��ȸ
SELECT DEPTNO, to_char(ROUND(AVG(SAL), 2), '$999,999.99')
FROM EMP
GROUP BY DEPTNO
having AVG(SAL) > 2000
ORDER BY DEPTNO;

-- �������� ���� ��ȸ
select job from emp order by 1;

-- ��ȸ�ÿ� �ߺ��� �����ϰ� ��ȸ : select distinct ~~~
select distinct job from emp order by 1;

-- �μ��� ������ ������ ��ȸ
-- ��ȸ�׸� : �μ���ȣ, ����
-- ���� : �μ���ȣ, ���� ������� ��ȸ
select distinct deptno, job from emp order by deptno, job;

select distinct job, deptno from emp order by job, deptno;

-- ��ȸ�� ���� �Ϸù�ȣ(rownum), ������ġ(rowid), �μ���ȣ, ���, �̸�, �޿������� ��ȸ
select rownum, rowid, deptno, empno, ename, sal from emp;
select rownum, rowid, deptno, empno, ename, sal from emp order by deptno;

-- ��ȸ�� ���� �Ϸù�ȣ(rownum), ������ġ(rowid), ���, �̸�, �޿������� ��ȸ
-- 10�� �μ����� ���ؼ��� ��ȸ
select rownum, rowid, deptno, empno, ename, sal from emp where deptno=10;

-- ������ ���� �ߺ� �����ϰ� ��ȸ
select distinct job from emp order by 1;

-- ������ ������ �ο����� ��ȸ
-- ������� : ����, �ο���
-- �ο����� ���� ������� ������ȸ
select job, count(*) from emp group by job order by 2 desc;

-- ��ü������ ���, ���� ��ȸ
SELECT EMPNO, JOB FROM EMP;

-- sub-query
-- 7499 ������ ���� ��ȸ : SALESMAN
SELECT JOB FROM EMP WHERE EMPNO=7499;

-- 7499 ������ ���� ������ ����ϴ� ������ȸ
SELECT * FROM EMP
WHERE JOB = 'SALESMAN';

-- SUB-QUERY �̿�
SELECT * FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE EMPNO=7499);

-- �����߿��� �޿��� ���� �޴� �ֻ��� 3���� ������ ��ȸ
-- ������� : ���� ��� �̸� �޿�
-- ��Ʈ : SELECT �˻�����, ROWNUM, SUB-QUERY

-- 1.
SELECT EMPNO, ENAME, SAL FROM EMP ORDER BY SAL DESC;

-- 2.
SELECT ROWNUM, EMPNO, ENAME, SAL FROM EMP
WHERE ROWNUM <= 3
ORDER BY SAL ASC;

-- 3.
SELECT ROWNUM, EMPNO, ENAME, SAL FROM EMP ORDER BY SAL DESC;

-- ���� : �ֻ��� �޿� 3���� ������ �Ϸù�ȣ�� ���
SELECT ROWNUM, EMPNO, ENAME, SAL
FROM (SELECT EMPNO, ENAME, SAL FROM EMP ORDER BY SAL DESC)
WHERE ROWNUM <= 3;

select rownum, empno, ename, sal 
from (select empno, ename, sal from emp order by sal desc) 
where rownum < 4
;

-- ����Լ� : decode(expr, s1, r1, sx, rx, default), ����Ŭ ����

-- �������� ������ ���� ����ȸ�� ���� ���
-- ������� : ���, ����, �޿�, ����ȸ��,
-- ����ȸ�� ���� ���� ����������� ���� ��ȸ

-- ����ȸ�� ��� 
-- PRESIDENT = �޿� * 30%
-- MANAGER = �޿� * 25%
-- ANALYST, SALESMAN = �޿� 20%
-- ��Ÿ���� = �޿� * 5%

-- 1. ����, ����
select distinct job from emp order by 1;

SELECT EMPNO, JOB, ENAME, SAL, 
    DECODE(
        JOB,
        'PRESIDENT', SAL * 0.3,
        'MANAGER',   SAL * 0.25,
        'ANALYST',   SAL * 0.2,
        'SALESMAN',  SAL * 0.2,
         SAL * 0.05
    ) "����ȸ��"
FROM EMP
ORDER BY ����ȸ�� DESC
;

SELECT EMPNO, JOB, ENAME, SAL, 
    TO_CHAR(
        TRUNC(
            DECODE(
                JOB,
                'PRESIDENT', SAL * 0.3,
                'MANAGER',   SAL * 0.25,
                'ANALYST',   SAL * 0.2,
                'SALESMAN',  SAL * 0.2,
                SAL * 0.05
            ))
        , '$999,999') "����ȸ��"
FROM EMP
ORDER BY ����ȸ�� DESC
;

-- �������� ������ ���� ����ȸ�� ���� ���
-- ������� : ���, ����, �޿�, ����ȸ��,
-- ����ȸ�� ���� ���� ����������� ���� ��ȸ

-- ����ȸ�� ��� 
-- PRESIDENT = �޿� * 30%
-- MANAGER = �޿� * 25%
-- ANALYST, SALESMAN = �޿� 20%
-- ��Ÿ���� = �޿� * 5%
-- case whten ~ then ~ else ~ end ������ �̿��ؼ� ����

SELECT EMPNO, JOB, ENAME, SAL, 
    TO_CHAR(
        TRUNC(
            case
                when job = 'PRESIDENT' then SAL * 0.3
                when job = 'MANAGER' then  SAL * 0.25
                when job in ('ANALYST','SALESMAN') then SAL * 0.2
                else SAL * 0.05
            end
        )
    , '$999,999') "����ȸ��"
FROM EMP
ORDER BY ����ȸ�� DESC
;

select empno, 'aaa' from emp;

-- 15. �޿��λ����� = ��ձ޿� ����
select empno, '�����' from emp;

select avg(sal) from emp;

-- error
select empno, sal, '�����'
from emp
where sal < avg(sal)
;

select empno, sal, '�����'
from emp
where sal < (select avg(sal) from emp)
;

select empno, sal, '�����'
from emp
where sal < (select avg(sal) from emp)
;

select empno, sal, 
    case
        when sal < (select avg(sal) from emp) then '�����'
        else '�̴��'
    end "��󿩺�"
from emp
order by ��󿩺�
;



-- �л� ���� ���̺� ����
drop table student_score;


-- �л� ���� ���̺� ����
create table student_score(
    student_no number(5) primary key,
    name varchar2(30) not null,
    score number(3)
);

-- ���̺��� ��ȸ
select * from tab;

-- ���̺� ���� ��ȸ
desc student_score;











