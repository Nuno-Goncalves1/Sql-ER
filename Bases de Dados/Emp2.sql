CREATE DATABASE BD_20240620_2425_INF;
USE BD_20240615_2425_INF;


--1) a.i ii
CREATE TABLE EMP(
empnum INT PRIMARY KEY,
nome VARCHAR(30),
funcao VARCHAR(30),
chefe INT,
data_adm DATETIME,
salario FLOAT,
comissao FLOAT,
depnum INT);

SELECT * FROM EMP;

INSERT INTO EMP VALUES (89,'Antunes','Admin',35,'2001.10.10',14000,null,10);

-- 1) a.iii


-- 1) b.i
CREATE TABLE EMP(
empnum INT,
nome VARCHAR(30),
funcao VARCHAR(30),
chefe INT,
data_adm DATETIME,
salario FLOAT,
comissao FLOAT,
depnum INT,
CONSTRAINT tb_emp_PK PRIMARY KEY(empnum));


-- 1) b.ii
CREATE TABLE EMP(
empnum INT NOT NULL,
nome VARCHAR(30),
funcao VARCHAR(30),
chefe INT,
data_adm DATETIME,
salario FLOAT,
comissao FLOAT,
depnum INT);

ALTER TABLE EMP ADD CONSTRAINT tb_emp_PK PRIMARY KEY(empnum), CONSTRAINT tb_emp_UQ UNIQUE (nome);

-- 1) b.iii
INSERT INTO EMP VALUES (89,'Antunes','Admin',35,'2001.10.10',14000,null,10);
INSERT INTO EMP VALUES (2,'Antunes','Admin',35,'2001.10.10',14000,null,10);

SELECT * FROM EMP;

-- 1) b.iv


-- 1)c
CREATE TABLE EMP(
empnum INT NOT NULL,
nome VARCHAR(30),
funcao VARCHAR(30),
chefe INT,
data_adm DATETIME,
salario FLOAT,
comissao FLOAT,
depnum INT,
CONSTRAINT tb_emp_PK PRIMARY KEY(empnum), CONSTRAINT tb_emp_ck CHECK (salario > 0) );

-- 1)c.iii
INSERT INTO EMP VALUES (89,'Antunes','Admin',35,'2001.10.10',0,null,10);
INSERT INTO EMP VALUES (2,'Antunes','Admin',35,'2001.10.10',-14000,null,10);

-- 1)c.iv


-- 1)d

CREATE TABLE EMP(
empnum INT NOT NULL,
nome VARCHAR(30),
funcao VARCHAR(30),
chefe INT,
data_adm DATETIME,
salario FLOAT DEFAULT 1000,
comissao FLOAT,
depnum INT,
CONSTRAINT tb_emp_PK PRIMARY KEY(empnum));


-- 1)d.iii

INSERT INTO EMP(empnum, nome, funcao, chefe, data_adm, comissao, depnum) VALUES (89,'Antunes','Admin',35,'2001.10.10',null,10);

SELECT * FROM EMP;


-- 1)e.

CREATE TABLE EMP(
empnum INT NOT NULL,
nome VARCHAR(30),
funcao VARCHAR(30) NOT NULL,
chefe INT,
data_adm DATETIME,
salario FLOAT DEFAULT 1000,
comissao FLOAT,
depnum INT,
CONSTRAINT tb_emp_PK PRIMARY KEY(empnum));

-- 1)e.iii
INSERT INTO EMP(empnum, nome, chefe, data_adm, comissao, depnum) VALUES (89,'Antunes',35,'2001.10.10',null,10);

-- 1)e.iv


-- 2)
CREATE TABLE EMP(
empnum INT NOT NULL,
nome VARCHAR(30),
funcao VARCHAR(30) NOT NULL,
chefe INT,
data_adm DATETIME,
salario FLOAT DEFAULT 1000,
comissao FLOAT,
depnum INT,
CONSTRAINT tb_emp_PK PRIMARY KEY(empnum));



INSERT INTO EMP (empnum, nome, funcao, chefe, data_adm, salario, comissao, depnum) VALUES
(89, 'Antunes', 'Admin', 35, '2001-10-10', 14000, NULL, 10),
(45, 'Pascoal', 'Vendedor', 35, '2000-05-14', 15000, 4000, 10),
(69, 'Silva', 'Admin', 39, '2000-12-04', 14000, NULL, 40),
(78, 'Rato', 'Vendedor', 35, '2002-11-09', 16000, 3000, 10),
(36, 'Santos', 'Vendedor', 39, '2001-08-25', 13000, 500, 40),
(35, 'Alves', 'Chefe', 79, '2000-06-03', 23000, NULL, 10),
(39, 'Monteiro', 'Chefe', 79, '2000-09-14', 23000, NULL, 40),
(85, 'Farias', 'Analista', 35, '2002-12-12', 20000, NULL, 10),
(79, 'Xavier', 'Presidente', NULL, '2000-06-01', 40000, NULL, 10),
(30, 'Brito', 'Vendedor', 39, '2002-03-02', 14000, 6000, 40),
(12, 'Ribeiro', 'Vendedor', 98, '2000-07-16', 15000, 3000, 30),
(18, 'Barros', 'Analista', 98, '2000-03-12', 20000, NULL, 30),
(46, 'Souto', 'Vendedor', 33, '2001-05-04', 15000, 2000, 20),
(32, 'Rafael', 'Admin', 98, '2000-11-26', 13000, NULL, 30),
(98, 'Neto', 'Chefe', 79, '2001-11-28', 23000, NULL, 30),
(77, 'Moura', 'Analista', 33, '2000-08-03', 20000, NULL, 20),
(21, 'Pires', 'Admin', 33, '2000-09-18', 14000, NULL, 20),
(14, 'Lima', 'Admin', 33, '2002-05-23', 14000, NULL, 20),
(33, 'Barroso', 'Chefe', 79, '2000-02-24', 20000, NULL, 20);


-- TESTES DA AULA
SELECT * FROM EMP;

SELECT nome FROM EMP;

SELECT e.nome,e.salario FROM EMP AS e;

SELECT e.nome,e.salario, e.salario + 500 AS 'Aumento Salarial' FROM EMP AS e;

SELECT CONCAT(nome,' ', salario) FROM EMP;

SELECT * FROM EMP WHERE comissao IS NULL;

SELECT nome, ISNULL(comissao, 0) FROM EMP;

SELECT e.nome, e.salario FROM EMP AS E ORDER BY e.nome ASC;

SELECT e.nome, e.salario FROM EMP AS E ORDER BY 1;

SELECT e.nome, e.salario FROM EMP AS E ORDER BY 2 DESC;

SELECT e.nome, e.salario FROM EMP AS e WHERE e.salario BETWEEN 15000 AND 20000 ORDER BY e.salario;

SELECT e.nome, e.salario FROM EMP e WHERE e.salario <= 14000 OR e.salario >= 21000 ORDER BY e.salario DESC;

SELECT e.nome, e.salario FROM EMP e WHERE e.salario NOT BETWEEN 14000 AND 21000 ORDER BY e.salario DESC;

SELECT e.nome FROM EMP e WHERE e.nome LIKE 'm%';

SELECT e.nome FROM EMP e WHERE e.nome LIKE '[a-f]%' ORDER BY e.nome;

SELECT e.nome FROM EMP e WHERE e.nome LIKE '%s';

SELECT e.nome FROM EMP e WHERE e.nome LIKE 'a%' AND e.nome LIKE '%s';

SELECT e.nome FROM EMP e WHERE e.nome LIKE '_a%';

SELECT e.nome FROM EMP e WHERE e.comissao IS NULL;
--

--Ficha 2
--1
SELECT empnum, nome, ISNULL(chefe, 0) FROM EMP;
--2
SELECT nome, ROUND(salario/12, 2) AS 'Salario Mensal' FROM EMP;
--3
SELECT nome, salario + ISNULL(comissao, 0) AS 'Salario + Comissoes' From EMP;
--4
SELECT DISTINCT funcao FROM EMP;
--5
SELECT nome, funcao, salario FROM EMP ORDER BY nome;
--6
SELECT empnum, nome, funcao, depnum FROM EMP WHERE funcao = 'Admin';
--7
SELECT nome, salario FROM EMP WHERE salario > 20000;
--8
SELECT nome, salario FROM EMP WHERE salario BETWEEN 15000 AND 20000;
--9
SELECT nome, chefe FROM EMP WHERE chefe = 33 OR chefe = 39;
--10
SELECT nome FROM EMP WHERE nome LIKE 's%';
--11
SELECT nome, salario, funcao FROM EMP WHERE funcao = 'Vendedor' AND salario > 16000;
--12
SELECT nome, ISNULL(chefe, 0) FROM EMP WHERE chefe IS NULL;
--13
SELECT nome, salario + ISNULL(comissao, 0) AS 'Salario + Comissão', funcao, data_adm, depnum FROM EMP WHERE salario + 
ISNULL(comissao, 0) > 17000 AND funcao='Vendedor' AND depnum=10 AND data_adm < '2000-08-01';

--EXTRA
--1
SELECT nome, ISNULL(comissao, 0) AS 'Comissão' FROM EMP WHERE comissao IS NULL;
--2
SELECT empnum, nome, salario, salario+salario*0.1 AS 'Salario+10%' FROM EMP;
--3
SELECT nome, ISNULL(comissao, 0), data_adm FROM EMP ORDER BY data_adm;
--4
SELECT e.nome FROM EMP AS e WHERE e.nome LIKE '_a%' AND e.nome LIKE '%s';
--5
SELECT TOP 1 nome, data_adm FROM EMP ORDER BY data_adm DESC;
--6
SELECT nome, data_adm FROM EMP ORDER BY data_adm DESC;
--7
SELECT e.empnum, e.nome, e.data_adm FROM EMP AS e WHERE funcao = 'Admin' AND nome LIKE '%s';
--8
SELECT e.nome, ISNULL(comissao, 0), e.chefe FROM EMP AS e WHERE e.chefe = 35 AND comissao < 4000;
--9
SELECT e.nome, e.funcao, data_adm, depnum FROM EMP AS e WHERE e.funcao = 'Vendedor' AND e.data_adm BETWEEN '2000-01-01' AND '2000-12-31' AND e.depnum = 10;
--10
SELECT e.nome, ISNULL(e.comissao, 0), e.funcao FROM EMP AS e WHERE e.funcao='Analista' AND e.comissao IS NULL AND e.nome LIKE '%r_';
--11
SELECT e.nome, e.depnum FROM EMP AS e WHERE e.depnum != 20 AND e.depnum != 30 ORDER BY e.depnum ASC, e.nome DESC; 
--12
SELECT e.nome, e.salario, e.depnum FROM EMP AS E WHERE e.salario BETWEEN 15000 AND 16000 AND (depnum=10  OR depnum=20) ORDER BY e.salario DESC;

-- DROP TABLE EMP;


-- Ficha 3

-- 1
SELECT ROUND(AVG(e.salario), 0) AS 'Media de Salario' FROM EMP AS e;

-- 2
SELECT MIN(e.salario) AS 'Salario Minimo' FROM EMP AS e WHERE e.funcao = 'Admin';

-- 3
SELECT COUNT(*) AS 'Quantidade de Empregados' FROM EMP AS e WHERE e.depnum = 20;

-- 4
SELECT e.funcao, ROUND(AVG(e.salario), 0) AS 'Media de Salario' FROM EMP AS e GROUP BY e.funcao;

-- 5
SELECT e.funcao, ROUND(AVG(e.salario), 0) AS 'Media de Salario' FROM EMP AS e WHERE e.funcao != 'Presidente' GROUP BY e.funcao;
SELECT e.funcao, ROUND(AVG(e.salario), 0) AS 'Media de Salario' FROM EMP AS e GROUP BY e.funcao HAVING e.funcao != 'Presidente';

-- 6
SELECT e.depnum, e.funcao, ROUND(AVG(e.salario), 0) AS 'Media de Salario' FROM EMP AS e GROUP BY e.funcao, e.depnum;

-- 7
SELECT e.depnum, MIN(e.salario) AS 'Salario Minimo' FROM EMP AS e GROUP BY e.depnum;

-- 8
SELECT e.depnum, ROUND(AVG(e.salario), 0) AS 'Salario Minimo' FROM EMP AS e GROUP BY e.depnum HAVING COUNT(*) >=4;

-- 9
SELECT e.funcao, MAX(e.salario) AS 'Salario Maximo' FROM EMP AS e GROUP BY e.funcao HAVING MAX(e.salario) >=20000;

-- a
SELECT COUNT(*) AS 'Pessoas apos 1/1/2001' FROM EMP AS e WHERE e.data_adm > '2001-01-01';

-- b
SELECT MIN(e.nome) AS 'A', MAX(e.nome) AS 'Z', COUNT(e.empnum) AS 'Total Funcionarios' FROM EMP AS e;

-- c
SELECT e.depnum, ROUND(AVG(e.salario),0) AS 'Salario Medio' FROM EMP AS e GROUP BY e.depnum HAVING ROUND(AVG(e.salario),0) >17000 ORDER BY ROUND(AVG(e.salario),0) DESC;

-- d
SELECT COUNT(*) AS 'Funcionarios', MIN(e.salario) AS 'Salario mais baixo', MAX(e.salario) AS 'Salario mais alto' FROM EMP AS E WHERE e.data_adm > '2001-01-01';

-- e
SELECT e.funcao, COUNT(*) AS 'num_func' FROM EMP AS e GROUP BY e.funcao ORDER BY COUNT(*) DESC;

-- f
SELECT ROUND(AVG(e.salario),0) AS 'Salario Medio', e.depnum FROM EMP AS e GROUP BY e.depnum HAVING COUNT(e.nome) >3 ORDER BY ROUND(AVG(e.salario),0) DESC;

-- g
SELECT e.funcao, MAX(e.salario) AS 'Salario Maximo' FROM EMP AS e GROUP BY e.funcao HAVING MAX(e.salario) > 5000 ORDER BY MAX(e.salario) DESC; 

-- h
SELECT YEAR(e.data_adm) AS 'ano_adm', COUNT(*) AS 'num_func' FROM EMP AS e GROUP BY YEAR(e.data_adm) HAVING COUNT(*) > 5 ORDER BY YEAR(e.data_adm) ASC;

-- i 
SELECT e.depnum, COUNT(e.chefe) AS 'num_chefes' FROM EMP AS e GROUP BY e.depnum HAVING COUNT(e.chefe) > 1 ORDER BY COUNT(e.chefe) DESC;

-- j
SELECT SUM(e.comissao) AS 'Soma Comissoes', e.depnum FROM EMP AS e GROUP BY e.depnum HAVING SUM(e.comissao) > 1000 ORDER BY SUM(e.comissao) DESC;

-- k
SELECT e.funcao, MIN(e.salario) AS 'Salario minimo' FROM EMP AS e GROUP BY e.funcao ORDER BY MIN(e.salario) ASC;

-- ficha 4
CREATE TABLE EMP2(
empnum INT NOT NULL,
nome VARCHAR(30),
funcao VARCHAR(30) NOT NULL,
chefe INT,
data_adm DATETIME,
salario FLOAT DEFAULT 1000,
comissao FLOAT,
depnum INT);
--b/C
SELECT * INTO EMP2 FROM EMP;
SELECT * FROM EMP2;
--DROP TABLE EMP;


--2
CREATE TABLE DEP(
numdept INT NOT NULL,
nomedept VARCHAR(50) NOT NULL,
Localidade VARCHAR(50) NOT NULL
CONSTRAINT tb_dept_PK PRIMARY KEY (numdept));

INSERT INTO DEP VALUES
(10, 'Consultoria','Lisboa'),
(20, 'CRM´s', 'Porto'), 
(30, 'ERP´s', 'Coimbra'),
(40, 'Integração', 'Aveiro');
--DROP TABLE DEP;

--3
CREATE TABLE EMP(
empnum INT NOT NULL,
nome VARCHAR(30),
funcao VARCHAR(30) NOT NULL,
chefe INT,
data_adm DATETIME,
salario FLOAT DEFAULT 1000,
comissao FLOAT,
depnum INT,
CONSTRAINT tb_emp_PK PRIMARY KEY(empnum));

ALTER TABLE EMP ADD CONSTRAINT tb_emp_fk FOREIGN KEY (depnum) REFERENCES DEP(numdept);

INSERT INTO EMP 
SELECT * FROM EMP2;

SELECT * FROM EMP;

SELECT e.nome, e.funcao,d.numdept FROM EMP AS e INNER JOIN DEP d
ON e.depnum = d.numdept ORDER BY e.depnum;

SELECT e.nome'Nome Empregado',e.salario'Salário Empregado',e.chefe'NumChefeDoEmpregado',e2.empnum'NumEmpregadoDoChefe',e2.nome 'NomeDoChefe',e2.salario'SalarioDoChefe' 
FROM EMP e CROSS JOIN EMP e2 
WHERE e.chefe= e2.empnum
AND e.salario< e2.salario;

SELECT D.nomedept,COUNT(E.nome) FROM DEP D INNER JOIN EMP E 
ON E.depnum = D.numdept
GROUP BY D.nomedept;

SELECT D.nomedept,COUNT(E.nome) FROM DEP D INNER JOIN EMP E 
ON E.depnum = D.numdept
GROUP BY D.nomedept 
HAVING COUNT(E.nome)>=5;

SELECT D.nomedept,SUM(E.salario) / COUNT(E.nome) FROM EMP AS E INNER JOIN DEP AS D
ON E.depnum=D.numdept
GROUP BY D.nomedept
HAVING D.nomedept NOT LIKE 'C%'
ORDER BY AVG(E.salario) ASC;

SELECT E.nome, D.nomedept,E.data_adm FROM EMP AS E INNER JOIN DEP AS D
ON E.depnum=D.numdept
WHERE D.nomedept ='Integração' AND MONTH(E.data_adm) < 6;

SELECT E.nome, E.funcao, E.salario FROM EMP AS E INNER JOIN DEP AS D 
ON E.depnum=D.numdept
WHERE D.nomedept='Consultoria' AND E.salario BETWEEN 15000 AND 16000 AND E.funcao='Vendedor'
ORDER BY E.nome DESC;

SELECT E.nome, E.data_adm, D.nomedept FROM EMP AS E INNER JOIN DEP AS D
ON E.depnum=D.numdept
WHERE YEAR(E.data_adm) = 2001 AND MONTH(E.data_adm) >= 9  
ORDER BY D.	nomedept;

SELECT E.nome, E.funcao,D.nomedept FROM EMP AS E INNER JOIN DEP AS D
ON E.depnum = D.numdept 
WHERE D.nomedept LIKE '_____'
ORDER BY D.nomedept ASC, E.funcao ASC;

SELECT E.nome, E.funcao,D.nomedept FROM EMP AS E INNER JOIN DEP AS D
ON E.depnum = D.numdept 
WHERE E.funcao!='admin' AND E.funcao!='Vendedor' AND E.nome LIKE '%o' AND D.nomedept = 'Integração';

SELECT E.*, D.nomedept FROM EMP AS E INNER JOIN DEP AS D 
ON E.depnum =D.numdept
WHERE E.data_adm BETWEEN '2002-11-9' AND '2002-12-12' AND E.comissao IS NOT NULL AND D.nomedept!='ERP´S' AND D.nomedept!='CRM´S';

SELECT e.* FROM EMP AS e INNER JOIN DEP AS d 
ON e.depnum=d.numdept
WHERE e.nome LIKE '[a,e,i,o,u]%' AND e.nome NOT LIKE '%n%' AND d.Localidade='Lisboa';

ALTER TABLE DEP ADD sup INT;
ALTER TABLE DEP ADD CONSTRAINT sup FOREIGN KEY (sup) REFERENCES EMP(empnum);

UPDATE DEP SET sup =89 WHERE DEP.numdept='10';
UPDATE DEP SET sup =77 WHERE DEP.numdept='20';
UPDATE DEP SET sup =98 WHERE DEP.numdept='30';
UPDATE DEP SET sup =30 WHERE DEP.numdept='40';
SELECT * FROM DEP;

SELECT D.nomedept, E.nome, E.data_adm FROM EMP AS E INNER JOIN DEP AS D 
ON E.depnum=D.sup
WHERE MONTH(data_adm) %2 =1 AND YEAR(data_adm)=2001;

SELECT E.nome, E.salario, E.comissao, E.data_adm, E.funcao FROM EMP AS E INNER JOIN DEP AS D 
ON E.empnum=D.sup
WHERE E.comissao IS NULL AND E.salario < 25000 AND E.funcao!='Chefe'
ORDER BY E.data_adm DESC;

SELECT
    E1.nome
FROM EMP AS E1 CROSS JOIN EMP AS E2
WHERE YEAR(E1.data_adm) = YEAR(E2.data_adm) AND MONTH(E1.data_adm) = MONTH(E2.data_adm) AND E1.empnum <> E2.empnum
ORDER BY E1.nome;

--Ficha 5
--1

SELECT * FROM EMP AS E
WHERE E.salario = (SELECT MIN(E1.salario) FROM EMP AS E1)
ORDER BY E.nome ASC;

--2

SELECT * FROM EMP AS E 
WHERE E.funcao =(SELECT E1.funcao FROM EMP AS E1 WHERE E1.nome='Barros');

--3

SELECT * FROM EMP AS E 
WHERE E.salario > (SELECT MIN(E1.salario) FROM EMP AS E1 WHERE E1.depnum=10);

--4
SELECT * FROM EMP AS E 
WHERE E.salario > (SELECT MIN(E1.salario) FROM EMP AS E1 WHERE E1.depnum=10);

--ficha6
--1
ALTER TABLE EMP ADD dependentes INT;

--2
INSERT INTO DEP VALUES(50, 'Marketing', 'Lisboa',NULL);

SELECT * FROM DEP;

--3
UPDATE EMP SET funcao = 'Analista', salario = salario * 1.10 WHERE nome = 'Silva';
SELECT * FROM EMP WHERE nome = 'Silva';
UPDATE EMP SET funcao = 'Admin', salario = salario / 1.10 WHERE nome = 'Silva';

--4
SELECT * FROM DEP;
DELETE FROM DEP WHERE numdept = 50;

--5
CREATE VIEW EMP_DEPT10 AS 
SELECT * 
FROM EMP E INNER JOIN DEP D ON E.depnum = D.numdepT;

SELECT * FROM EMP_DEPT10;
DROP VIEW EMP_DEPT10;

--6
CREATE VIEW SUMARIODEPT AS 
SELECT * 
FROM EMP AS E INNER JOIN DEP AS ON;