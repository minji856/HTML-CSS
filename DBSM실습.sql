1. 1981년에 입사한 사람의 이름, 업무, 입사일자를 조회
SELECT ename, job, hiredate FROM emp WHERE TO_CHAR(HIREDATE,'YYYY') = '1981';

2. 사번이 7902, 7782, 7566인 사원의 이름, 업무, 급여, 입사일자 조회
SELECT empno , ename, job, sal, hiredate FROM emp WHERE empno IN ('7902', '7782', '7566');

3. 업무가 manager, clerk, anaylst가 아닌 직원의 이름, 업무, 급여, 부서번호 조회
SELECT ename, job, sal, deptno FROM emp
	WHERE job NOT IN('MANAGER', 'CLERK', 'ANALYST');

4. 업무가 president 또는 salesman이고 급여가 1500인 직원의 이름, 급여, 업무, 부서번호 조회
SELECT ename, sal, job, deptno FROM emp
	WHERE (job='PRESIDENT' OR job='SALESMAN') AND sal=1500;
	
5. 가장 최근에 입사한 직원의 이름, 부서, 업무, 입사일자 조회
SELECT ename, deptno, job, hiredate FROM emp ORDER BY hiredate desc;

6. 같은 부서내에서 같은 업무를 하는 직원의 급여가 많은 순으로 조회
SELECT deptno, job, sal from emp ORDER BY deptno,sal desc;

7. 커미션이 급여보다 10%이상 많은 직원의 급여가 많은 순으로 조회
SELECT ename FROM emp WHERE sal*1.1<=comm;

8. 이름에 L가 2개 있고 30번 부서이거나 직속상사가 7782인 직원의 이름, 부서, 직속상사 조회
SELECT ename, deptno, mgr FROM emp WHERE ename like '%L%L%' AND (deptno='30' OR mgr='7782');


**** HR 계정 활용 **** 
1. countries 테이블에서 country_id와 country_name 컬럼만 조회
SELECT country_id, country_name FROM countries;

2. countries 테이블에서 컬럼명 country_id를 국가 ID, country_name을 국가명으로 조회
SELECT country_id AS 국가ID, country_name AS 국가명 FROM countries;

3. countries 테이블에서 region_id를 중복 제외하고 조회
SELECT DISTINCT region_id FROM countries;

4. locations 테이블에서 street_address와 city 컬럼만 조회
SELECT street_address, city FROM locations;

5. jobs 테이블에서 job_id와 job_title 컬럼만 조회
SELECT job_id, job_title FROM jobs;

6. jobs 테이블에서 job_title, min_salary, max_salary 컬럼을 최소 연봉과 최대 연봉을 10% 인상된 상태로 조회
SELECT job_title, min_salary*1.1 AS "최소 연봉", max_salary*1.1 AS "최대 연봉" FROM jobs;

7. employees 테이블에서 job_id를 중복 제외하고 조회
SELECT DISTINCT job_id FROM employees;

8. employees 테이블에서 first_name이 ‘David’인 직원 조회
SELECT first_name FROM employees WHERE first_name like 'David';

9. jobs 테이블에서 최소 월급이 4000 달러인 직업 조회
SELECT job_title,min_salary from jobs WHERE min_salary=4000;

10. jobs 테이블에서 최소 월급이 4000 이상이고 최대 월급이 10000 이하인 직업 조회
SELECT job_title,min_salary,max_salary from jobs 
WHERE min_salary>=4000 AND max_salary<=10000;

11. employees 테이블에서 job_id가 ‘IT_PROG’ 이면서 salary가 5000 초과인 직원 조회
SELECT first_name,last_name,job_id,salary from employees WHERE job_id='IT_PROG' AND salary>5000;

12. jobs 테이블에서 job_title 기준으로 정렬하여 직업 조회
SELECT job_title from jobs ORDER BY job_title;

13. employees 테이블에서 salary가 10000에서 12000사이인 직원 조회
SELECT first_name,last_name,salary FROM employees
WHERE salary between 10000 AND 12000;

14. employees 테이블에서 job_id가 ‘IT_PROG’와 ‘ST_MAN’인 직원 조회
SELECT first_name,last_name,job_id FROM employees
WHERE job_id IN ('IT_PROG','ST_MAN');

15. department 테이블에서 manager_id가 NULL이 아닌 부서 조회
SELECT department_name FROM departments
WHERE manager_id is not null;

16. employees 테이블에서 job_id가 ‘AD’로 시작하는 직원 조회
SELECT first_name,last_name,job_id FROM employees
WHERE job_id like 'AD%';

17. employees 테이블의 first_name에서 ‘ni’를 포함하는 직원 조회
SELECT first_name,last_name FROM employees
WHERE first_name like '%ni%';

************************* 함수 문제 ******************************
1. 오늘부터 12월 25일까지 몇일이 남았는가?
SELECT to_date('23/12/25') - to_date(sysdate) FROM dual;

2. 현재까지 근무한 직원들의 근무일수를 몇주 몇일로 조회.(단, 근무일수가 많은 사람 순으로 조회)
SELECT ename, hiredate, trunc(months_between(sysdate, hiredate)/7) AS "주",
trunc(SYSDATE - HIREDATE) AS "일" FROM emp ORDER BY sysdate-hiredate desc;

3. 10번 부서 직원들 중 현재까지의 근무월수를 계산해서 조회
SELECT ename, trunc(months_between(sysdate, hiredate)) AS 근무월수,
deptno FROM emp WHERE deptno = 10;

4. 20번 부서 직원들 중 입사일자로부터 13개월이 지난 후의 날짜를 조회
SELECT ename, hiredate, to_date(add_months(hiredate,13)) AS "13개월후" FROM emp
WHERE deptno = 20;

5. 모든 직원에 대해 입사한 달의 근무일수를 조회
SELECT ename, last_day(hiredate)-to_date(hiredate) AS 근무일수 FROM emp;

6. 현재 급여에 15%가 증가된 급여를 계산하여 사번, 이름, 급여, 증가된 급여를 조회
(단, 급여는 반올림하여 적용한다.)
SELECT empno, ename, sal AS 급여, round(sal*1.15,0) AS "증가된 급여" from emp;

7. 이름, 입사일, 입사일로부터 현재까지의 월수, 급여, 급여 총계를 조회
SELECT ename, hiredate, months_between(sysdate, hiredate) AS 근무월수,
sal, sal*(months_between(sysdate, hiredate)) AS 급여총계 FROM emp;

8. 업무가 analyst이면 급여를 10%증가시키고 clerk이면 15%, manager이면 20%증가 시켜서 이름, 업무, 급여, 증가된 급여를 조회
SELECT ename,job,sal,
decode(job,
'ANALYST',sal*1.1,
'CLERK',sal*1.15,
'MANAGER',sal*1.2) AS "증가된 급여" FROM emp; 
 
9. 이름의 첫글자가 k보다 크고 y보다 작은 직원의 이름, 부서, 업무를 조회하시오. 
SELECT ename, deptno, job FROM emp 
WHERE ename > 'L%' AND ename < 'X%';





1. Blake와 같은 부서에 있는 모든 직원의 사번, 이름, 입사일자 조회
SELECT deptno,empno,ename,hiredate FROM emp 
WHERE deptno=(SELECT deptno FROM emp WHERE ename='BLAKE');

2. SELECT empno, ename, deptno, sal, comm FROM emp
WHERE (sal, comm) IN(SELECT sal, comm FROM emp WHERE deptno=30);
이 쿼리에서 보너스가 null인 사람도 출력될 수 있도록 수정하시오.
SELECT empno, ename, deptno, sal, comm FROM emp
WHERE (sal, comm) IN(SELECT sal, comm FROM emp WHERE deptno=30)
OR (SELECT comm is null FROM emp WHERE deptno=30);

3. 평균 급여 이상을 받는 직원들의  사번, 이름을 조회. 단, 급여가 많은 순으로 정렬
SELECT empno,ename,sal FROM emp
WHERE sal >=(SELECT sal from avg(sal)) ORDER BY sal DESC;

4. 이름에 T자가 들어가는 직원이 근무하는 부서에서 근무하는 직원의 사번, 이름, 급여 조회
SELECT empno,ename,sal,deptno FROM emp
WHERE deptno IN(SELECT deptno FROM emp WHERE ename like '%T%');

5. 부서의 위치가 dallas인 모든 직원에 대해 사번, 이름, 급여, 업무조회
SELECT empno,ename,sal,job FROM emp
WHERE deptno IN(SELECT deptno FROM dept WHERE loc='DALLAS');

6. King에게 보고하는 모든 직원의 이름과 부서, 업무, 급여를 조회
SELECT ename,deptno,job,sal FROM emp e
WHERE mgr IN(SELECT empno FROM emp WHERE ename='KING');

7. 급여가 30번 부서의 최저급여보다 높은 직원의 사번, 이름, 급여 조회
SELECT empno,ename,sal FROM emp
WHERE sal > (SELECT min(sal) FROM emp WHERE deptno='30');

8. 10번부서에서 30번 부서의 직원과 같은 업무를 하는 직원의 이름과 업무를 조회
SELECT ename,job,deptno FROM emp
WHERE job IN (SELECT job FROM emp WHERE deptno='30') 
AND deptno='10';

9. 가장 최근에 입사한 직원의 이름과 부서, 업무, 급여를 조회
SELECT ename,deptno,job,sal FROM emp
WHERE hiredate > ALL(SELECT hiredate FROM emp);   ??


************************** JOIN 문제 *********************************
1. Newyork에서 근무하는 직원의 사번, 이름, 업무, 부서명을 조회
SELECT empno,ename,job,dname,loc FROM emp e JOIN dept d
ON e.deptno=d.deptno AND loc='NEW YORK';

2. 보너스를 받는 직원에 대해 이름, 부서명, 근무지를 조회
SELECT ename,dname,loc,comm FROM emp e JOIN dept d
ON e.deptno=d.deptno	
AND comm is not null;

3. 이름 중간에 L자가 있는 직원의 이름, 업무, 부서명, 근무지를 조회
SELECT ename,job,e.deptno,loc FROM emp e JOIN dept d
ON e.deptno=d.deptno 
WHERE ename like '%L%';

4. 각 직원들에 대해 그들의 관리자보다 먼저 입사한 직원의 이름, 입사일, 
SELECT e1.ename,e1.hiredate FROM emp e1 JOIN emp e2
ON e1.hiredate=e2.hiredate WHERE e1.hiredate < e2.hiredate;

5. 말단사원의 사번, 이름, 업무, 부서번호, 근무지를 조회 - 부하직원없어야함
SELECT empno,ename,job,deptno,loc FROM emp e JOIN dept d
ON e.deptno=d.deptno WHERE empno <=(SELECT empno FROM emp min(empno));

*. 테이블을 생성한다.
CREATE TABLE tblBook(
author varchar2(20),
title varchar2(20)
);

INSERT INTO tblBook VALUES('최주현', '하늘과 땅');
INSERT INTO tblBook VALUES('최주현', '바다');
INSERT INTO tblBook VALUES('유은정', '바다');
INSERT INTO tblBook VALUES('박성우', '문');
INSERT INTO tblBook VALUES('최주현', '문');
INSERT INTO tblBook VALUES('박성우', '천국');
INSERT INTO tblBook VALUES('최지은', '천국');
INSERT INTO tblBook VALUES('최주현', '천국');
INSERT INTO tblBook VALUES('박성우', '고슴도치');
INSERT INTO tblBook VALUES('서금동', '나');

6. 한권의 책에 대해 두명 이상의 작가가 쓴 책을 검색
책이름 작가명 작가명
SELECT tb1.title,tb1.author,tb2.author 
FROM tblBook tb1 JOIN tblBook tb2
ON tb1.title=tb2.title AND tb1.author != tb2.author; 


(가)
CREATE TABLE POST(
	POST1    char(3),
	POST2    char(3),
	ADDR  varchar2(60)   not null,
	CONSTRAINT pk_post PRIMARY KEY(POST1,POST2)
);
INSERT INTO POST VALUES('100','010','경기도 성낭시 분당구 정자동');

(나)
CREATE TABLE MEMBER(
	ID   number(4),
	NAME  varchar2(10)  not null,
	SEX   char(1),
	JUMIN1  char(6),
	JUMIN2   char(7),
	TEL   varchar2(15),
	POST1    char(3),
	POST2    char(3),
	ADDR  varchar2(60)   not null,
	CONSTRAINT pk_id PRIMARY KEY(id,post1,post2),
	CONSTRAINT uk_JUMIN1 UNIQUE(JUMIN1),
	CONSTRAINT uk_JUMIN2 UNIQUE(JUMIN2)
);

ALTER TABLE MEMBER ADD CONSTRAINT ck_SEX CHECK(SEX IN('1','2'));

ALTER TABLE MEMBER ADD CONSTRAINT 
POST FOREIGN KEY(POST1,POST2) REFERENCES POST(POST1,POST2);

INSERT INTO MEMBER VALUES('1234','홍길동','1',
'990101','1232344','712-1234','100','010','null');


INSERT INTO MEMBER VALUES('1255','임꺽정','2',
'990101','1232344','712-1234','100','010','null');



수강생들은 학원에 과정을 수강등록을 한다.
수강생들은 [주민번호, 등록날짜, 이름, 거주지]에 대한 정보를 가진다.
한 수강생은 여러 과정을 수강할 수 있으며 등록 후에 [수강료 지불]도 가능하다.
학원에서 일하는 사람은 과정을 가르치는 [강사]와 각 강의실의 관리를 책임지는 [직원]
으로 나누어진다. 이들은 [주민번호, 이름, 거주지]에 대한 정보를 가진다.
강사는 [자격증 번호, 자격증 이름]을 포함하고 직원은 [담당 강의실]로 표시한다.
또한 강사는 학원전속 여부와 함께 [시급]을 받으며 직원은 [월급]을 받는다.
한 강사가 여러 과정을 맡을 수 있으며 한 직원은 여러 강의실을 관리한다.
각 [과정]은 [과정번호와 강의실 번호, 담당강사, 배정강의실, 교재, 수강료]가 포함된다. 
[강의실]은 [강의실번호, 컴퓨터 개수, 프로젝트기기의 설치여부]를 표시한다.
[교재]는 과정을 듣는 수강생들에게 [무료]로 나누어주고 수강등록 마감 후 바로 공급자
에게 주문하여 수강 [시작하는 날] 수강생들에게 나누어 주게 된다.
각 교재는 여러 [공급자에게 주문하되 하나의 교재는 하나의 공급자에게 배급]받는다.
주문시 [주문번호, 교재, 주문량, 주문날짜]의 정보를 가진다.
[교재]는 [교재번호, 출판사, 교재비]를 정보로 가지며 [공급자]는 [공급자번호, 상호]를 
지닌다.  [학원]은 [수강생]들로부터 [수강료를 납부]받고 [납부날짜]를 기록한다.
또한 [공급자]에게 [대금을 지불]하고 [지불날짜를 기록]한다.



CREATE TABLE tea
(
	tname        varchar(10) not null,
	tjumin1      char(6),
	tjumin2      char(7),
	addr        varchar(20),
	cer_name       char(18),
	cer_num     number,
	CONSTRAINTS pk_tjumin PRIMARY KEY (tjumin1,tjumin2),
	excys     char   
);
--존속여부 excys

INSERT INTO tea(tname,tjumin1,tjumin2,addr,cer_name,cer_num)VALUES('홍길동',);



--직원
CREATE TABLE emp
(
	ename              varchar2(10) not null,
	e_jumin1             char(6),
	e_jumin2			char(7),
	addr                varchar2(20),
	eroom            number, 
	CONSTRAINT uk_jumin UNIQUE(e_jumin1,e_jumin2)
);




CREATE TABLE stu
(
	sname                 varchar2(10) not null,
	s_jumin1            char(6),
	s_jumin2			char(7),
	addr                CHAR(18),
	regdate              CHAR(18),
	CONSTRAINT uk_s_jumin UNIQUE(s_jumin1,s_jumin2)
);

--학원
CREATE TABLE aca
(
	강사                  CHAR(18)  NULL ,
	관리직원              CHAR(18)  NULL ,
	학원전속여부          CHAR(18)  NOT NULL ,
	강의실번호            CHAR(18)  NULL ,
	당담직원              CHAR(18)  NULL 
);




CREATE TABLE room
(
	roomnum          number  NOT NULL ,
	computer          char(4),
	projectdev  char(4),
	mgr        varchar(10)  NOT NULL 
	CONSTRAINTS pk_room PRIMARY KEY (roomnum)
);
--mgr 당담직원 mgr := emp.ename

CREATE UNIQUE INDEX XPK강의실 ON 강의실
(강의실번호  ASC,당담직원  ASC);


ALTER TABLE 강의실
	ADD CONSTRAINT  XPK강의실 PRIMARY KEY (강의실번호,당담직원);
	
--공급자	
CREATE TABLE sup
(
	sup_num          number not null,
	sup_name          varcchar2(18),
	CONSTRAINTS pk_sup PRIMARY KEY (sup_num)
);

CREATE TABLE book
(
	book_num            number,
	publisher          varchar2(18),
	fee                number not null,
	CONSTRAINTS pk_booknum PRIMARY KEY(book_num)
);

--과정
CREATE TABLE cours
(
	cour_id           number not null,
	roomnum          number not null,
	tname              varchar2(10) not null,
	배정강의실            number not null,
	book        char(18) not null,
	tuition         number not null,
	CONSTRAINTS pk_cour PRIMARY KEY (cour_id,배정강의실)
);
--배정강의실,id pk


CREATE TABLE 과정_강사
(
	과정번호              CHAR(18)  NOT NULL ,
	주민번호              CHAR(18)  NOT NULL 
);

ALTER TABLE 과정_강사
	ADD CONSTRAINT  XPK과정_강사 PRIMARY KEY (과정번호);



--당담강의실
CREATE TABLE eroom
(
	ename         varchar2(10)  not null,
	eroom         number, 
	CONSTRAINT uk_room UNIQUE(eroom)
);
--당담강의실 중복 가능 unique? 한사람이 여러강의실 

CREATE TABLE 납부
(
	paydate         date,
	payys           char
);

--대금
CREATE TABLE pri
(
	paydate         date,
	price            number
	
);

CREATE TABLE stu_과정
(
	주민번호              CHAR(18),
	과정번호              CHAR(18)
);

--주문
CREATE TABLE ord
(
	ordnum            number  NOT NULL ,
	booknum             number  NOT NULL ,
	book                CHAR(18)  NULL ,
	quantity             number,
	orddate           date, 
	CONSTRAINTS pk_ordnum PRIMARY KEY (ordnum,booknum)
);





ALTER TABLE 강의실
	ADD (CONSTRAINT  R_1 FOREIGN KEY (당담직원) REFERENCES 관리직원(주민번호));



ALTER TABLE 과정_강사
	ADD (CONSTRAINT  R_18 FOREIGN KEY (과정번호) REFERENCES 과정(과정번호));



ALTER TABLE 과정_강사
	ADD (CONSTRAINT  R_20 FOREIGN KEY (주민번호) REFERENCES 강사(주민번호));



ALTER TABLE 납부
	ADD (CONSTRAINT  R_9 FOREIGN KEY (주민번호) REFERENCES 수강생(주민번호));



ALTER TABLE 대금
	ADD (CONSTRAINT  R_14 FOREIGN KEY (지불날짜) REFERENCES 공급자(공급자번호));



ALTER TABLE 수강생_과정
	ADD (CONSTRAINT  R_15 FOREIGN KEY (주민번호) REFERENCES 수강생(주민번호));



ALTER TABLE 수강생_과정
	ADD (CONSTRAINT  R_17 FOREIGN KEY (과정번호) REFERENCES 과정(과정번호));



ALTER TABLE 주문
	ADD (CONSTRAINT  R_6 FOREIGN KEY (주문번호) REFERENCES 공급자(공급자번호));



ALTER TABLE 주문
	ADD (CONSTRAINT  R_8 FOREIGN KEY (교재번호) REFERENCES 교재(교재번호));



ALTER TABLE 학원
	ADD (CONSTRAINT  R_4 FOREIGN KEY (학원전속여부) REFERENCES 강사(주민번호));



ALTER TABLE 학원
	ADD (CONSTRAINT  R_21 FOREIGN KEY (강의실번호,당담직원) REFERENCES 강의실(강의실번호,당담직원) ON DELETE SET NULL);
