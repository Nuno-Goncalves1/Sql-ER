/*1. Observe a estrutura apresentada e recorrendo a comandos DDL: 
a. Crie a tabela, definindo como chave primária o atributo ‘empnum’. 
i. Insira a primeira linha (Considere que o formato da data pode variar, ex: ‘2001.10.10’; 
e que a comissão não tem valor, ex: NULL); 
ii. Teste o mecanismo de chave primária, repetindo a inserção da mesma linha; 
iii. Remova a tabela (DROP TABLE emp). */
--Opcao 1 - definir a PK junto do atributo
CREATE TABLE emp(
empnum INT PRIMARY KEY,
nome VARCHAR(30),
funcao VARCHAR(30),
chefe INT,
data_adm DATETIME,
salario FLOAT,
comissao FLOAT,
deptnum INT
);

--listar todo o conteudo da tabela 
SELECT*
FROM emp;

--Inserir a primeira linha
INSERT INTO emp(empnum,nome,funcao,chefe,data_adm,salario,comissao,deptnum)
VALUES (89,'Antunes','Admin',35,'2001.10.10',14000,NULL,10);

DROP TABLE emp;

--Opeçao 2 
CREATE TABLE emp(
empnum INT ,
nome VARCHAR(30),
funcao VARCHAR(30),
chefe INT,
data_adm DATETIME,
salario FLOAT,
comissao FLOAT,
deptnum INT
CONSTRAINT tb_emp_pk PRIMARY KEY (empnum)
);
--Opeçao 3- defenir a PK depois de criar a tabela
CREATE TABLE emp(
empnum INT NOT NULL,
nome VARCHAR(30),
funcao VARCHAR(30),
chefe INT,
data_adm DATETIME,
salario FLOAT,
comissao FLOAT,
deptnum INT
);
ALTER TABLE emp
ADD CONSTRAINT tb_emp_pk PRIMARY KEY(empnum);
/*b. Crie de novo a tabela com as seguintes restrições:
i. Definindo como chave primária o atributo ‘empnum’;
ii. O nome o empregado não se pode repetir (UNIQUE);
iii. Teste o mecanismo, repetindo a inserção de uma mesma linha (alterando o empnum, mas repetindo o nome do empregado);
iv. Remova a tabela (DROP TABLE emp).*/ 
CREATE TABLE emp(
empnum INT NOT NULL,
nome VARCHAR(30),
funcao VARCHAR(30),
chefe INT,
data_adm DATETIME,
salario FLOAT,
comissao FLOAT,
deptnum INT
);
ALTER TABLE emp
ADD CONSTRAINT tb_emp_pk PRIMARY KEY(empnum), CONSTRAINT tb_emp_uq UNIQUE(nome);

INSERT INTO emp(empnum,nome,funcao,chefe,data_adm,salario,comissao,deptnum)
VALUES (89,'Antunes','Admin',35,'2001.10.10',14000,NULL,10);

INSERT INTO emp(empnum,nome,funcao,chefe,data_adm,salario,comissao,deptnum)
VALUES (5,'Antunes','Admin',35,'2001.10.10',14000,NULL,10);

SELECT*
FROM emp;

DROP TABLE emp;

--c)

CREATE TABLE emp(
empnum INT NOT NULL,
nome VARCHAR(30),
funcao VARCHAR(30),
chefe INT,
data_adm DATETIME,
salario FLOAT,
comissao FLOAT,
deptnum INT
);
ALTER TABLE emp
ADD CONSTRAINT tb_emp_pk PRIMARY KEY(empnum), CONSTRAINT tb_emp_ck CHECK(salario>0);
INSERT INTO emp(empnum,nome,funcao,chefe,data_adm,salario,comissao,deptnum)
VALUES (5,'Antunes',NULL,35,'2001.10.10',10000,NULL,10);
SELECT*
FROM emp;
DROP TABLE emp;

--d)
CREATE TABLE emp(
empnum INT NOT NULL,
nome VARCHAR(30),
funcao VARCHAR(30),
chefe INT,
data_adm DATETIME,
salario FLOAT DEFAULT 100,
comissao FLOAT,
deptnum INT
);
ALTER TABLE emp
ADD CONSTRAINT tb_emp_pk PRIMARY KEY(empnum);
INSERT INTO emp(empnum,nome,funcao,chefe,data_adm,comissao,deptnum)
VALUES (5,'Antunes','Admin',35,'2001.10.10',NULL,10);
--e)
CREATE TABLE emp(
empnum INT NOT NULL,
nome VARCHAR(30),
funcao VARCHAR(30)NOT NULL,
chefe INT,
data_adm DATETIME,
salario FLOAT,
comissao FLOAT,
deptnum INT
);
ALTER TABLE emp
ADD CONSTRAINT tb_emp_pk PRIMARY KEY(empnum);

INSERT INTO emp (empnum,nome,funcao,chefe,data_adm,salario,comissao,deptnum) 
VALUES (89, 'Antunes', 'Admin', 35, '2001.10.10', 14000, NULL, 10),
(45, 'Pascoal', 'Vendedor', 35, '2000.05.14', 15000, 4000, 10),
(69, 'Silva', 'Admin', 39, '2000.12.04', 14000, NULL, 40),
(78, 'Rato', 'Vendedor', 35, '2002.11.09', 16000, 3000, 10),
(36, 'Santos', 'Vendedor', 39, '2001.08.25', 13000, 500, 40),
(35, 'Alves', 'Chefe', 79, '2000.06.03', 23000, NULL, 10),
(39, 'Monteiro', 'Chefe', 79, '2000.09.14', 23000, NULL, 40),
(85, 'Farias', 'Analista', 35, '2002.12.12', 20000, NULL, 10),
(79, 'Xavier', 'Presidente', NULL, '2000.06.01', 40000, NULL, 10),
(30, 'Brito', 'Vendedor', 39, '2002.03.02', 14000, 6000, 40),
(12, 'Ribeiro', 'Vendedor', 98, '2000.07.16', 15000, 3000, 30),
(18, 'Barros', 'Analista', 98, '2000.03.12', 20000, NULL, 30),
(46, 'Souto', 'Vendedor', 33, '2001.05.04', 15000, 2000, 20),
(32, 'Rafael', 'Admin', 98, '2000.11.26', 13000, NULL, 30),
(98, 'Neto', 'Chefe', 79, '2001.11.28', 23000, NULL, 30),
(77, 'Moura', 'Analista', 33, '2000.08.03', 20000, NULL, 20),
(21, 'Pires', 'Admin', 33, '2000.09.18', 14000, NULL, 20),
(14, 'Lima', 'Admin', 33, '2002.05.23', 14000, NULL, 20),
(33, 'Barroso', 'Chefe', 79, '2000.02.24', 20000, NULL, 20);