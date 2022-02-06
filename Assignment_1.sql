CREATE TABLE BRANCH 
(
    BRANCHNO	INT CONSTRAINT PK_BRANCH_BRANCHNO PRIMARY KEY,
    BRANCHNAME  VARCHAR2(20) NOT NULL,
    LOCATION    VARCHAR2(20) NOT NULL 
);

CREATE TABLE DEPT    
(
    DEPTNO      NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
    DNAME       VARCHAR2(14) NOT NULL UNIQUE, 
    BRANCHNO    INT CONSTRAINT FK_DEPT_BRANCHNO REFERENCES BRANCH
);

CREATE TABLE EMP
(
    EMPNO 		NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
    ENAME 		VARCHAR2(10),
    JOB 		VARCHAR2(9),
    MGR 		NUMBER(4),
    HIREDATE 	DATE,
    SAL 		NUMBER(7,2),
    COMM 		NUMBER(7,2),
    DEPTNO 		NUMBER(2) CONSTRAINT FK_EMP_DEPTNO REFERENCES DEPT,
    BRANCHNO 	INT CONSTRAINT FK_EMP_BRANCHNO REFERENCES BRANCH
);  



INSERT INTO BRANCH VALUES 	(101,'Geneva','NEW YORK');
INSERT INTO BRANCH VALUES 	(102,'Geneva','NEW YORK');
INSERT INTO BRANCH VALUES 	(103,'CHICAGO','CHICAGO');
INSERT INTO BRANCH VALUES 	(104,'CHICAGO','CHICAGO');
INSERT INTO BRANCH VALUES 	(105,'Kingston','NEW YORK');
INSERT INTO BRANCH VALUES 	(106,'Kingston','NEW YORK');

INSERT INTO DEPT VALUES	(10,'ACCOUNTING',101);
INSERT INTO DEPT VALUES (20,'RESEARCH',103);
INSERT INTO DEPT VALUES	(30,'SALES',105);
INSERT INTO DEPT VALUES	(40,'OPERATIONS',106);

INSERT INTO EMP VALUES(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20,102);
INSERT INTO EMP VALUES(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30,102);
INSERT INTO EMP VALUES(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30,103);
INSERT INTO EMP VALUES(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20,104);
INSERT INTO EMP VALUES(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30,105);
INSERT INTO EMP VALUES(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30,105);
INSERT INTO EMP VALUES(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10,102);
INSERT INTO EMP VALUES(7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87')-85,3000,NULL,20,103);
INSERT INTO EMP VALUES(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,NULL,101);
INSERT INTO EMP VALUES(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30,104);
INSERT INTO EMP VALUES(7876,'ADAMS','CLERK',7788,to_date('13-JUL-87')-51,1100,NULL,20,105);
INSERT INTO EMP VALUES(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30,103);
INSERT INTO EMP VALUES(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20,105);
INSERT INTO EMP VALUES(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10,104);
INSERT INTO EMP VALUES(7901,'JOHN_SMITH','CLERK',7698,to_date('23-1-1982','dd-mm-yyyy'),3000,NULL,30,104);



-- Display all the information of the EMP table?
select * from emp;

-- Display unique Jobs from EMP table?
SELECT DISTINCT job FROM emp;

-- List the emps in the asc order of their Salaries?
SELECT ename, sal FROM emp ORDER BY sal;

-- List the details of the emps in asc order of the Dptnos and desc of Jobs?
SELECT empno,ename,job, mgr,hiredate,sal,comm,deptno,branchno FROM emp ORDER BY deptno, job DESC;

-- Display all the unique job groups in the descending order?
SELECT DISTINCT job FROM emp ORDER BY  job DESC;

-- Display all the details of all ‘Mgrs’
SELECT empno,ename,job, mgr,hiredate,sal,comm,deptno,branchno FROM emp WHERE job = 'MANAGER';

-- List the emps who joined before 1981
SELECT empno,ename,job, mgr,hiredate,sal,comm,deptno,branchno FROM emp WHERE hiredate < ('01-01-1981');

-- Display the Empno, Ename, job, Hiredate, Exp of all Mgrs
SELECT empno, ename, job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp FROM emp WHERE job = 'MANAGER';

-- List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369
SELECT empno, ename, job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp  FROM emp WHERE  mgr = '7369';

-- Display all the details of the emps whose Comm  Is more than their Sal
SELECT empno,ename,job, mgr,hiredate,sal,comm,deptno,branchno FROM emp WHERE comm > sal;

-- List the emps along with their Exp and Daily Sal is more than Rs 100
SELECT empno, ename, job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal, ROUND (sal/26,2) as Daily_Sal FROM emp WHERE sal/26 >'100' ORDER BY empno;

-- List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order
SELECT empno, ename, job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal  FROM emp WHERE job = 'CLERK' OR job= 'ANALYST' ORDER BY job desc;

-- List the emps who joined on 1-MAY-81,3-DEC-81,17-DEC-81,19-JAN-80 in asc order of seniority
SELECT empno, ename, job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE hiredate = '1-MAY-81' OR hiredate= '3-DEC-81' or hiredate='17-DEC-81' or hiredate='19-JAN-80' ORDER BY EXP ;

-- List the emp who are working for the Deptno 10 or20
SELECT DEPTNO, empno, ename, job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE DEPTNO = '10' OR DEPTNO = '20' ORDER BY deptno;

-- List the emps who are joined in the year 81
SELECT DEPTNO, empno, ename, job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE to_char(hiredate,'yyyy') = 1981;

-- List the emps Who Annual sal ranging from 22000 and 45000
SELECT DEPTNO, empno, ename, job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE sal BETWEEN '2200' AND '45000';

-- List the Enames those are having five characters in their Names
SELECT DEPTNO, empno, ename,LENGTH(ename), job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE LENGTH(ename) = 5;

-- List the Enames those are starting with ‘S’ and with five characters
SELECT DEPTNO, empno, ename,LENGTH(ename), job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE  LENGTH(ename) = 5 AND ename like 'S%';

-- List the emps those are having four chars and third character must be ‘r’
SELECT DEPTNO, empno, ename,LENGTH(ename), job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE  LENGTH(ename) = 4 AND ename like '__R%';

-- List the Five character names starting with ‘S’ and ending with ‘H’
SELECT DEPTNO, empno, ename,LENGTH(ename), job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE  LENGTH(ename) = 5 AND ename like 'S%H%';

-- List the emps who joined in January
SELECT DEPTNO, empno, ename, job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE to_char(hiredate,'mm') = 1;

-- List the emps whose names having a character set ‘ll’ together
SELECT DEPTNO, empno, ename,LENGTH(ename), job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE  ename like '%LL%';

-- List the emps who does not belong to Deptno 20
SELECT DEPTNO, empno, ename,LENGTH(ename), job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE deptno <> 20;

-- List all the emps except ‘PRESIDENT’ & ‘MGR” in asc order of Salaries
SELECT DEPTNO, empno, ename,LENGTH(ename), job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE job NOT IN ('PRESIDENT','MANAGER') ORDER BY sal;

-- List the emps whose Empno not starting with digit 78
SELECT DEPTNO, empno, ename,LENGTH(ename), job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE empno not like '78%';

-- List the emps who are working under ‘MGR’
SELECT DEPTNO, empno, ename,LENGTH(ename), job, hiredate, MGR,sal FROM emp WHERE mgr in(select empno from emp where job='MANAGER');

-- List the emps who joined in any year but not belongs to the month of March
SELECT DEPTNO, empno, ename, job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE to_char (hiredate,'mm') not like '03' OR to_char (hiredate,'mm') not like '3';

-- List all the Clerks of Deptno 20
SELECT DEPTNO, empno, ename, job, hiredate,sal FROM emp WHERE  deptno = '20' AND job = 'CLERK';

-- List the emps of Deptno 30 or 10 joined in the year 1981
SELECT DEPTNO, empno, ename, job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2) AS exp,sal FROM emp WHERE deptno in (30,10) AND to_char(hiredate,'yyyy') = 1981;

-- Display the details of SMITH
SELECT * FROM emp WHERE ename = 'SMITH';

-- Display the location of SMITH
SELECT location FROM branch WHERE branchno= (SELECT  branchno FROM emp WHERE ename = 'SMITH');

-- List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal
SELECT empno, ename, sal,round((sal/26),2) as Daily_sal, (sal*12) as annual_Sal FROM emp ORDER BY annual_Sal;