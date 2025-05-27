USE BD_20240620_2425_INF;


-- Codigo de criaçao das tabelas
CREATE TABLE Municipe (
    idMunicipe INT,
	nome VARCHAR(MAX),
	nif INT UNIQUE CHECK (nif BETWEEN 100000000 AND 299999999),
	cc VARCHAR(12) UNIQUE,
	dataNascimento DATE,
	genero Char(1) CHECK (genero IN ('M', 'F', 'O')),
	morada VARCHAR(MAX),
    CONSTRAINT PK_Municipe PRIMARY KEY (idMunicipe)
);
CREATE TABLE Proposta (
    idProposta INT,
	idMunicipe INT, --FK
	titulo VARCHAR(MAX),
	descricao VARCHAR(MAX),
	data DATE,
	fase VARCHAR(30),
	inicioFase DATE,
	fimFase DATE,
	montante INT,
	percentagemCoima INT CHECK (percentagemCoima >= 0 AND percentagemCoima <= 100),
    CONSTRAINT PK_Proposta PRIMARY KEY (idProposta)
);
CREATE TABLE Classifica(
	idMunicipe INT, --FK
	idProposta INT, --FK
	classificacao INT CHECK (classificacao BETWEEN 0 AND 10),
	justificacao VARCHAR(MAX),
    CONSTRAINT PK_Classifica PRIMARY KEY (idMunicipe,idProposta)
);


CREATE TABLE Entidade (
    idEntidade INT,
	nome VARCHAR(MAX),
	nif INT UNIQUE CHECK (nif BETWEEN 500000000 AND 599999999),
	morada VARCHAR(MAX),
	email VARCHAR(MAX),
	telefone VARCHAR(MAX),
    CONSTRAINT PK_Entidade PRIMARY KEY (idEntidade)
);
CREATE TABLE Parecer(
    idEntidade INT, --FK
	idProposta INT, --FK
    CONSTRAINT PK_Parecer PRIMARY KEY (idEntidade, idProposta)
);

CREATE TABLE Construtora(
    idConstrutora INT,
	nome VARCHAR(MAX),
    nif INT UNIQUE CHECK (nif BETWEEN 500000000 AND 599999999),
    morada VARCHAR(MAX),
    telefone VARCHAR(9),
    email VARCHAR(MAX),
    CONSTRAINT PK_Construtora PRIMARY KEY (idConstrutora)
);
CREATE TABLE Consorcio(
    idConsorcio INT,
	nome VARCHAR(MAX),
    nif INT UNIQUE CHECK (nif BETWEEN 500000000 AND 599999999),
    morada VARCHAR(MAX),
    telefone VARCHAR(9),
    email VARCHAR(MAX),
    CONSTRAINT PK_Consorcio PRIMARY KEY (idConsorcio)
);
CREATE TABLE Participa(
	idConstrutora INT, --FK
	idConsorcio INT, --FK
    CONSTRAINT PK_Participa PRIMARY KEY (idConstrutora,idConsorcio)
);

CREATE TABLE Orcamento(
    idOrcamento INT UNIQUE,
	idProposta INT, --FK
	designacao VARCHAR(MAX),
	valor INT CHECK (valor > 0),
	dataInicioExecucao DATE,
	dataFimExecucao DATE,
    CONSTRAINT PK_Orcamento PRIMARY KEY (idOrcamento, idProposta)
);
CREATE TABLE OrcamentoConstrutora(
	idOrcamento INT, --FK
	idConstrutora INT, --FK
	CONSTRAINT PK_OrcamentoConstrutora PRIMARY KEY (idOrcamento, idConstrutora)
);
CREATE TABLE OrcamentoConsorcio(
	idOrcamento INT, --FK
	idConsorcio INT, --FK
	CONSTRAINT PK_OrcamentoConsorcio PRIMARY KEY (idOrcamento, idConsorcio)
);

CREATE TABLE Materiais(
    idMateriais INT,
	designacao VARCHAR(MAX),
    CONSTRAINT PK_Materiais PRIMARY KEY (idMateriais)
);
CREATE TABLE PrecisaMaterial(
	idOrcamento INT, --FK
	idMateriais INT, --FK
    CONSTRAINT PK_PrecisaMaterial PRIMARY KEY (idOrcamento,idMateriais)
);

CREATE TABLE Equipamentos(
    idEquipamentos INT,
	designacao VARCHAR(MAX),
	horasUtilizacao INT CHECK( horasUtilizacao > 0 AND horasUtilizacao < 25),
	dataAquisicao DATE,
    CONSTRAINT PK_Equipamentos PRIMARY KEY (idEquipamentos)
);
CREATE TABLE PrecisaEquipamento(
	idOrcamento INT, --FK
	idEquipamentos INT, --FK
    CONSTRAINT PK_PrecisaEquipamento PRIMARY KEY (idOrcamento,idEquipamentos)
);

CREATE TABLE EstudoViabilidade(
    idEstudo INT,
	idProposta INT UNIQUE,
	exequível BIT, -- 0 false, 1 true
	dataConsultaMunicipesInicial DATE,
	dataConsultaMunicipesFinal DATE,
	dataExecucaoPropostaInicial DATE,
	dataExecucaoPropostaFinal DATE,
	montanteGlobal INT,
	dataInicio DATE,
	dataFim DATE,
	concluida BIT NOT NULL, -- 0 false, 1 true
	relatorio VARCHAR(MAX),
	dataConclusao DATE,
    CONSTRAINT PK_EstudoViabilidade PRIMARY KEY (idEstudo,idProposta)
);
CREATE TABLE AnaliseMunipes(
    idAnalise INT,
	idProposta INT UNIQUE,
	dataInicio DATE,
	dataFim DATE,
	concluida BIT NOT NULL, -- 0 false, 1 true
	relatorio VARCHAR(MAX),
	dataConclusao DATE,
    CONSTRAINT PK_AnaliseMunipes PRIMARY KEY (idAnalise,idProposta)
);
CREATE TABLE FaseExecucao(
    idFase INT,
	idProposta INT NOT NULL,
	nomeFase VARCHAR(100) NOT NULL,
	dataInicio DATE,
	dataFim DATE,
	montanteEnvolvidoFinal VARCHAR(MAX),
	percentagemCoimaFinal INT CHECK (percentagemCoimaFinal >= 0 AND percentagemCoimaFinal <= 100),
	concluida BIT NOT NULL DEFAULT 0, -- 0 false, 1 true
	relatorio VARCHAR(MAX),
	dataConclusao DATE,
    CONSTRAINT PK_FaseExecucao PRIMARY KEY (idFase)
);
CREATE TABLE EmOrcamento(
    idEmOrcamento INT,
	idProposta INT UNIQUE,
	dataInicio DATE,
	dataFim DATE,
	concluida BIT NOT NULL, -- 0 false, 1 true
	relatorio VARCHAR(MAX),
	dataConclusao DATE,
    CONSTRAINT PK_EmOrcamento PRIMARY KEY (idEmOrcamento,idProposta)
);
CREATE TABLE AnaliseExecucao(
    idAnaliseExecucao INT,
	idProposta INT UNIQUE,
	dataInicio DATE,
	dataFim DATE,
	aprovada BIT NOT NULL DEFAULT 0,
	concluida BIT NOT NULL, -- 0 false, 1 true
	relatorio VARCHAR(MAX),
	dataConclusao DATE,
    CONSTRAINT PK_AnaliseExecucao PRIMARY KEY (idAnaliseExecucao,idProposta)
);

-- Key's
ALTER TABLE Proposta
ADD CONSTRAINT FK_Proposta_Municipe FOREIGN KEY (idMunicipe) REFERENCES Municipe (idMunicipe);

ALTER TABLE Classifica
ADD CONSTRAINT FK_Clasifica_Municipe FOREIGN KEY (idMunicipe) REFERENCES Municipe (idMunicipe),
CONSTRAINT FK_Clasifica_Proposta FOREIGN KEY (idProposta) REFERENCES Proposta (idProposta);

ALTER TABLE Parecer
ADD CONSTRAINT FK_Parecer_Entidade FOREIGN KEY (idEntidade) REFERENCES Entidade (idEntidade),
CONSTRAINT FK_Parecer_Proposta FOREIGN KEY (idProposta) REFERENCES Proposta (idProposta);

ALTER TABLE Participa
ADD CONSTRAINT FK_Participa_Construtora FOREIGN KEY (idConstrutora) REFERENCES Construtora (idConstrutora),
CONSTRAINT FK_Participa_Consorcio FOREIGN KEY (idConsorcio) REFERENCES Consorcio (idConsorcio);

ALTER TABLE Orcamento
ADD CONSTRAINT FK_Orcamento_Proposta FOREIGN KEY (idProposta) REFERENCES Proposta (idProposta);


ALTER TABLE OrcamentoConstrutora
ADD CONSTRAINT FK_OrcamentoConstrutora_Orcamento FOREIGN KEY (idOrcamento) REFERENCES Orcamento (idOrcamento),
CONSTRAINT FK_OrcamentoConstrutora_Construtora FOREIGN KEY (idConstrutora) REFERENCES Construtora (idConstrutora); 

ALTER TABLE OrcamentoConsorcio
ADD CONSTRAINT FK_OrcamentoConsorcio_Orcamento FOREIGN KEY (idOrcamento) REFERENCES Orcamento (idOrcamento),
CONSTRAINT FK_OrcamentoConsorcio_Consorcio FOREIGN KEY (idConsorcio) REFERENCES Consorcio (idConsorcio);






INSERT INTO FaseExecucao(idProposta)
    SELECT prop.idProposta
	FROM Proposta AS prop
		INNER JOIN Parecer AS parc ON prop.idProposta = parc.idProposta
		INNER JOIN Classifica AS c ON prop.idProposta = c.idProposta
	GROUP BY prop.idProposta
	HAVING COUNT(DISTINCT parc.idEntidade) >= 3
	AND COUNT(c.idProposta) >= 1000
	AND AVG(c.classificacao) >= 8



-- Consultas para verificar a estrutura das tabelas criadas.
-- Verifica as tabelas criadas

SELECT * FROM Entidade;
SELECT * FROM Parecer;
SELECT * FROM Construtora;
SELECT * FROM Consorcio;
SELECT * FROM Participa;
SELECT * FROM Orcamento;
SELECT * FROM OrcamentoConstrutora;
SELECT * FROM OrcamentoConsorcio;
SELECT * FROM Materiais;
SELECT * FROM PrecisaMaterial;
SELECT * FROM Equipamentos;
SELECT * FROM PrecisaEquipamento;
SELECT * FROM EstudoViabilidade;
SELECT * FROM AnaliseMunipes;
SELECT * FROM FaseExecucao;
SELECT * FROM EmOrcamento;
SELECT * FROM AnaliseExecucao;
SELECT * FROM Municipe;
SELECT * FROM Proposta;
SELECT * FROM Classifica;



/* 1.1 B) */
Select * From Municipe As m Inner Join Proposta as p On m.idMunicipe = p.idMunicipe
Where m.nome Like '%Rita%' And p.data Between '2024-04-01' And '2024-06-30' Order By m.nome Desc;

/* 1.1 C)*/

Select m.nome, Count(p.idProposta) As 'Quantidade de Propostas' 
From Municipe as m Left Join Proposta as p On m.idMunicipe = p.idMunicipe 
Group By m.nome Order By Count(p.idProposta) Desc;

/* 1.1 D)*/

Select m.nome
From Municipe as m Left Join Proposta as p On m.idMunicipe = p.idMunicipe 
Group By m.nome
Having Count(p.idProposta) = 0 
Order By m.nome;

/* 1.1 E) */

Select p.nome, Avg(p.avaliacao) From Proposta As p
Where p.data Between '2024-01-01' And '2024-03-31' 
Group By p.nome
Having Count(p.avaliacao) > 10 And Avg(p.avaliacao) >= 8 
Order By Avg(p.avaliacao) Desc;


SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'


SELECT 
    t.name AS Tabela,
    c.name AS Coluna,
    ty.name AS Tipo,
    c.max_length AS Tamanho,
    c.is_nullable AS PodeSerNulo,
    c.is_identity AS AutoIncremento,
    c.column_id AS OrdemNaTabela
FROM sys.columns c
JOIN sys.tables t ON c.object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
JOIN sys.types ty ON c.user_type_id = ty.user_type_id
ORDER BY s.name, t.name, c.column_id

DECLARE @sql NVARCHAR(MAX) = N''
SELECT @sql += '
ALTER TABLE [' + s.name + '].[' + t.name + '] DROP CONSTRAINT [' + fk.name + '];'
FROM sys.foreign_keys fk
INNER JOIN sys.tables t ON fk.parent_object_id = t.object_id
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN sys.tables t ON fk.parent_object_id = t.object_id    
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id;

EXEC sp_executesql @sql
-- Exclui as chaves estrangeiras

ALTER TABLE nome_tabela DROP CONSTRAINT nome_da_constraint;

--Exclusao de tabelas

ALTER TABLE Proposta DROP CONSTRAINT FK_Proposta_Municipe;
ALTER TABLE Classifica DROP CONSTRAINT FK_Clasifica_Municipe;
ALTER TABLE Classifica DROP CONSTRAINT FK_Clasifica_Proposta;
ALTER TABLE Parecer DROP CONSTRAINT FK_Parecer_Entidade;
ALTER TABLE Parecer DROP CONSTRAINT FK_Parecer_Proposta;
ALTER TABLE Participa DROP CONSTRAINT FK_Participa_Construtora;
ALTER TABLE Participa DROP CONSTRAINT FK_Participa_Consorcio;
ALTER TABLE Orcamento DROP CONSTRAINT FK_Orcamento_Proposta;
ALTER TABLE OrcamentoConstrutora DROP CONSTRAINT FK_OrcamentoConstrutora_Orcamento;
ALTER TABLE OrcamentoConstrutora DROP CONSTRAINT FK_OrcamentoConstrutora_Construtora;
ALTER TABLE OrcamentoConsorcio DROP CONSTRAINT FK_OrcamentoConsorcio_Orcamento;
ALTER TABLE OrcamentoConsorcio DROP CONSTRAINT FK_OrcamentoConsorcio_Consorcio;

DROP TABLE Entidade;
DROP TABLE Parecer;
DROP TABLE Construtora;
DROP TABLE Consorcio;
DROP TABLE Participa;
DROP TABLE Orcamento;
DROP TABLE OrcamentoConstrutora;
DROP TABLE OrcamentoConsorcio;
DROP TABLE Materiais;
DROP TABLE PrecisaMaterial;
DROP TABLE Equipamentos;
DROP TABLE PrecisaEquipamento;
DROP TABLE EstudoViabilidade;
DROP TABLE AnaliseMunipes;
DROP TABLE FaseExecucao;
DROP TABLE EmOrcamento;
DROP TABLE AnaliseExecucao;
DROP TABLE Municipe;
DROP TABLE Proposta;
DROP TABLE Classifica;

