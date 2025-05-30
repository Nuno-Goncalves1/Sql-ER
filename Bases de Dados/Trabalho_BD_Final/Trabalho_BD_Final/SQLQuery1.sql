USE BD_20240620_2425_INF;


-- Codigo de criaçao das tabelas
CREATE TABLE Municipe (
    idMunicipe INT,
	nome VARCHAR(MAX),
	nif INT UNIQUE CHECK (nif BETWEEN 100000000 AND 399999999),
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
	nipc INT UNIQUE CHECK (nipc BETWEEN 500000000 AND 999999999),
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

CREATE TABLE EstudoViabilidade(
    idEstudo INT,
	idProposta INT UNIQUE, --FK
	exequível BIT, -- 0 false, 1 true
	dataConsultaMunicipesInicial DATE,
	dataConsultaMunicipesFinal DATE,
	dataExecucaoPropostaInicial DATE,
	dataExecucaoPropostaFinal DATE,
	montanteGlobal INT,
	dataInicio DATE,
	dataFim DATE,
	concluida BIT NOT NULL DEFAULT 0, -- 0 false, 1 true
	relatorio VARCHAR(MAX),
	dataConclusao DATE,
    CONSTRAINT PK_EstudoViabilidade PRIMARY KEY (idEstudo,idProposta)
);
CREATE TABLE AnaliseMunipes(
    idAnalise INT,
	idProposta INT UNIQUE,
	dataInicio DATE,
	dataFim DATE,
	concluida BIT NOT NULL DEFAULT 0, -- 0 false, 1 true
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
    CONSTRAINT PK_FaseExecucao PRIMARY KEY (idFase, idProposta)
);
CREATE TABLE EmOrcamento(
    idEmOrcamento INT,
	idProposta INT UNIQUE,
	dataInicio DATE,
	dataFim DATE,
	concluida BIT NOT NULL DEFAULT 0, -- 0 false, 1 true
	relatorio VARCHAR(MAX),
	dataConclusao DATE,
    CONSTRAINT PK_EmOrcamento PRIMARY KEY (idEmOrcamento,idProposta)
);
CREATE TABLE AnaliseExecucao(
    idAnaliseExecucao INT,
	idProposta INT UNIQUE,
	dataInicio DATE,
	dataFim DATE,
	aprovada BIT NOT NULL,
	concluida BIT NOT NULL DEFAULT 0, -- 0 false, 1 true
	relatorio VARCHAR(MAX),
	dataConclusao DATE,
    CONSTRAINT PK_AnaliseExecucao PRIMARY KEY (idAnaliseExecucao,idProposta)
);


CREATE TABLE Orcamento(
    idOrcamento INT,
	idFaseExecucao INT, --FK
	idProposta INT,
	valor DECIMAL(10,2) CHECK (valor > 0),
	dataInicioExecucao DATE,
	dataFimExecucao DATE,
    CONSTRAINT PK_Orcamento PRIMARY KEY (idOrcamento, idFaseExecucao)
);

CREATE TABLE OrdensDeTrabalho(
	idOrdemDeTrabalho INT,
	idOrcamento INT, --FK
	idFaseExecucao INT, --FK
	designacao VARCHAR(MAX),
	dataInicio DATE,
	dataFim DATE,
	CONSTRAINT PK_OrdemDeTrabalho PRIMARY KEY (idOrdemDeTrabalho, idFaseExecucao)
);

CREATE TABLE OrcamentoConstrutora(
	idOrcamento INT, --FK
	idConstrutora INT, --FK
	idFaseExecucao INT, --FK
	CONSTRAINT PK_OrcamentoConstrutora PRIMARY KEY (idOrcamento, idConstrutora)
);
CREATE TABLE OrcamentoConsorcio(
	idOrcamento INT, --FK
	idConsorcio INT, --FK
	idFaseExecucao INT, --FK
	CONSTRAINT PK_OrcamentoConsorcio PRIMARY KEY (idOrcamento, idConsorcio)
);

CREATE TABLE Materiais(
    idMateriais INT,
	designacao VARCHAR(MAX),
    CONSTRAINT PK_Materiais PRIMARY KEY (idMateriais)
);
CREATE TABLE PrecisaMaterial(
	idOrdemDeTrabalho INT, --FK
	idFaseExecucao INT, --FK
	idMateriais INT, --FK
    CONSTRAINT PK_PrecisaMaterial PRIMARY KEY (idOrdemDeTrabalho, idFaseExecucao, idMateriais)
);

CREATE TABLE Equipamentos(
    idEquipamentos INT,
	designacao VARCHAR(MAX),
	horasUtilizacao INT CHECK( horasUtilizacao > 0 AND horasUtilizacao <= 24),
	dataAquisicao DATE,
    CONSTRAINT PK_Equipamentos PRIMARY KEY (idEquipamentos)
);
CREATE TABLE PrecisaEquipamento(
	idOrdemDeTrabalho INT, --FK
	idFaseExecucao INT, --FK
	idEquipamentos INT, --FK
    CONSTRAINT PK_PrecisaEquipamento PRIMARY KEY (idOrdemDeTrabalho,idEquipamentos)
);


-- Foreign Key's
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

ALTER TABLE EstudoViabilidade
ADD CONSTRAINT FK_EstudoViabilidade_Proposta FOREIGN KEY (idProposta) REFERENCES Proposta (idProposta);

ALTER TABLE AnaliseMunipes
ADD CONSTRAINT FK_AnaliseMunipes_Proposta FOREIGN KEY (idProposta) REFERENCES Proposta (idProposta);

ALTER TABLE FaseExecucao
ADD CONSTRAINT FK_FaseExecucao_Proposta FOREIGN KEY (idProposta) REFERENCES Proposta (idProposta);

ALTER TABLE EmOrcamento
ADD CONSTRAINT FK_EmOrcamento_Proposta FOREIGN KEY (idProposta) REFERENCES Proposta (idProposta);

ALTER TABLE AnaliseExecucao
ADD CONSTRAINT FK_AnaliseExecucao_Proposta FOREIGN KEY (idProposta) REFERENCES Proposta (idProposta);

ALTER TABLE Orcamento
ADD CONSTRAINT FK_Orcamento_FaseExecucao FOREIGN KEY (idFaseExecucao, idProposta) REFERENCES FaseExecucao (idFase, idProposta);

ALTER TABLE OrcamentoConstrutora
ADD CONSTRAINT FK_OrcamentoConstrutora_Orcamento FOREIGN KEY (idOrcamento, idFaseExecucao) REFERENCES Orcamento (idOrcamento, idFaseExecucao),
CONSTRAINT FK_OrcamentoConstrutora_Construtora FOREIGN KEY (idConstrutora) REFERENCES Construtora (idConstrutora); 

ALTER TABLE OrcamentoConsorcio
ADD CONSTRAINT FK_OrcamentoConsorcio_Orcamento FOREIGN KEY (idOrcamento, idFaseExecucao) REFERENCES Orcamento (idOrcamento, idFaseExecucao),
CONSTRAINT FK_OrcamentoConsorcio_Consorcio FOREIGN KEY (idConsorcio) REFERENCES Consorcio (idConsorcio);

ALTER TABLE OrdensDeTrabalho
ADD CONSTRAINT FK_OrdemDeTrabalho_Orcamento FOREIGN KEY (idOrcamento, idFaseExecucao) REFERENCES Orcamento (idOrcamento, idFaseExecucao);

ALTER TABLE PrecisaMaterial
ADD CONSTRAINT FK_PrecisaMateriais_OrdemDeTrabalho FOREIGN KEY (idOrdemDeTrabalho, idFaseExecucao) REFERENCES OrdensDeTrabalho (idOrdemDeTrabalho, idFaseExecucao),
CONSTRAINT FK_PrecisaMateriais_Materiais FOREIGN KEY (idMateriais) REFERENCES Materiais (idMateriais);

ALTER TABLE PrecisaEquipamento
ADD CONSTRAINT FK_PrecisaEquipamento_OrdemDeTrabalho FOREIGN KEY (idOrdemDeTrabalho, idFaseExecucao) REFERENCES OrdensDeTrabalho (idOrdemDeTrabalho, idFaseExecucao),
CONSTRAINT FK_PrecisaEquipamento_Equipamento FOREIGN KEY (idEquipamentos) REFERENCES Equipamentos (idEquipamentos);



-- Inserir os dados
INSERT INTO Municipe VALUES 
(1, 'Afonso Baptista', 193284761, '123456789ZZ9', '1990-04-15', 'M', 'Rua das Flores, Lisboa'),
(2, 'Dilan Pereira', 256743829, '987654321AA1', '1985-11-30', 'M', 'Avenida Central, Porto'),
(3, 'Nuno Gonçalves', 312567984, '192837465BC2', '1978-06-22', 'M', 'Travessa do Norte, Coimbra'),
(4, 'Rita Lopes', 134859267, '564738291DC3', '1995-08-09', 'F', 'Rua do Carmo, Braga'),
(5, 'Inês Martins', 276198435, '918273645XY4', '1988-03-25', 'F', 'Estrada Velha, Faro'),
(6, 'Rita Silva', 987654321, '123456789AB1', '1996-03-15', 'F', 'Avenida Central, Braga');


INSERT INTO Entidade(idEntidade,nome,nipc,morada,email,telefone) VALUES
(1,'Água',507123456,'Rua do Oceano','geral@aguas.pt',913456789),
(2,'Animais',509274631,'Rua do Leão','animais@natureza.pt',938724560),
(3,'Natureza',508392714,'Rua da Natureza','geral@natureza.pt',961234567),
(4,'Tráfego',509482376,'Avenida dos Transportes','geral@transportes.pt',939876543);

INSERT INTO Proposta(idProposta, idMunicipe, titulo, descricao, data, fase, inicioFase, fimFase, montante, percentagemCoima) VALUES
(1, 4, 'Requalificação de Parque Urbano', 'Proposta para renovar e modernizar o parque urbano do centro da cidade, incluindo novas zonas verdes e iluminação pública.', 
'2025-05-28', NULL, NULL, NULL, 50000.00, 5.0);

-- Acréscimos tendo em conta a ‘Proporcionalidade de Grupo (a)

INSERT INTO Entidade(idEntidade,nome,nipc,morada,email,telefone) VALUES
(5, 'Ordenamento Territorial', 501234567, 'Rua de Santo André', 'ordenamento@territorial.pt', 965645231),
(6, 'Logística', 507836129, 'Rua do Comércio', 'contacto@logistica.pt', 961584567);
ALTER TABLE Entidade ADD website VARCHAR(100) NULL;


-- Passa para Fase de Execucao

INSERT INTO FaseExecucao(idProposta)
    SELECT prop.idProposta
	FROM Proposta AS prop
		INNER JOIN Parecer AS parc ON prop.idProposta = parc.idProposta
		INNER JOIN Classifica AS c ON prop.idProposta = c.idProposta
	GROUP BY prop.idProposta
	HAVING COUNT(DISTINCT parc.idEntidade) >= 3
	AND COUNT(c.idProposta) >= 1000
	AND AVG(c.classificacao) >= 8


-- Acréscimos tendo em conta a ‘Proporcionalidade de Grupo (b)
GO
CREATE VIEW PropostasMunicipes AS
SELECT 
    p.titulo,
    m.nome AS nomeMunicipe,
    m.nif AS nifMunicipe,
    p.data AS dataSubmissao
FROM Proposta AS p INNER JOIN Municipe AS m ON p.idMunicipe = m.idMunicipe;
GO
SELECT * FROM PropostasMunicipes;

GO
	CREATE VIEW OrcamentosDetalhados AS
	SELECT 
		o.designacao,
		o.valor,
		o.dataInicioExecucao,
		o.dataFimExecucao,
		ct.nome AS nomeConstrutora,
		cs.nome AS nomeConsorcio
	FROM Orcamento AS o
	LEFT JOIN OrcamentoConstrutora AS oct ON o.idOrcamento = oct.idOrcamento
	LEFT JOIN Construtora AS ct ON oct.idConstrutora = ct.idConstrutora
	LEFT JOIN OrcamentoConsorcio AS ocs ON o.idOrcamento = ocs.idOrcamento
	LEFT JOIN Consorcio AS cs ON ocs.idConsorcio = cs.idConsorcio
	WHERE ct.nome IS NOT NULL OR cs.nome IS NOT NULL;
GO
SELECT * FROM OrcamentosDetalhados;

GO
	CREATE VIEW EstadoExecucaoPropostas AS
	SELECT 
		p.titulo,
		f.nomeFase,
		f.dataInicio,
		f.dataFim,
		f.concluida,
		f.percentagemCoimaFinal,
		f.montanteEnvolvidoFinal
	FROM Proposta AS p
	INNER JOIN FaseExecucao AS f ON p.idProposta = f.idProposta;
GO
SELECT * FROM EstadoExecucaoPropostas;



-- Consultas para verificar a estrutura das tabelas criadas.
-- Verifica as tabelas criadas 

/* 1.1 A) */

SELECT * FROM Municipe;
SELECT * FROM Proposta;
SELECT * FROM Classifica;
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



/* 1.1 B) */
SELECT * FROM Municipe AS m INNER JOIN Proposta AS p ON m.idMunicipe = p.idMunicipe
WHERE m.nome LIKE '%Rita%' AND p.data BETWEEN '2024-04-01' AND '2024-06-30' ORDER BY m.nome DESC;

/* 1.1 C)*/

SELECT m.nome, COUNT(p.idProposta) AS 'Quantidade de Propostas' 
FROM Municipe AS m INNER JOIN Proposta AS p ON m.idMunicipe = p.idMunicipe 
GROUP BY m.nome ORDER BY COUNT(p.idProposta) DESC;

/* 1.1 D)*/

SELECT m.nome
FROM Municipe AS m INNER JOIN Proposta AS p ON m.idMunicipe = p.idMunicipe 
GROUP BY m.nome
HAVING COUNT(p.idProposta) = 0 
ORDER BY m.nome;

/* 1.1 E) */

SELECT p.titulo, AVG(c.classificacao) AS Media_Avaliacao
FROM Proposta AS p
INNER JOIN Classifica AS c ON p.idProposta = c.idProposta
WHERE p.data BETWEEN '2024-01-01' AND '2024-06-30'
AND c.classificacao >= 8
AND (SELECT COUNT(*) FROM Classifica WHERE idProposta = p.idProposta) >= 10
ORDER BY Media_Avaliacao DESC;  


/* 1.1 H) */
GO
CREATE VIEW TotalPropostasMunicipe_PorSemestre AS
SELECT 
    p.idMunicipe,
    1 + ROUND(MONTH(p.data) / 12.5, 0) AS semestre,
    COUNT(*) AS total_propostas
FROM Proposta AS p
INNER JOIN (
    SELECT idMunicipe
    FROM Proposta
    GROUP BY idMunicipe
    HAVING COUNT(DISTINCT 1 + ROUND(MONTH(data) / 12.5, 0)) = 2
) AS m ON p.idMunicipe = m.idMunicipe
GROUP BY p.idMunicipe, 1 + ROUND(MONTH(p.data) / 12.5, 0);
GO
SELECT * FROM TotalPropostasMunicipe_PorSemestre;


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
ALTER TABLE EstudoViabilidade DROP CONSTRAINT FK_EstudoViabilidade_Proposta;
ALTER TABLE AnaliseMunipes DROP CONSTRAINT FK_AnaliseMunipes_Proposta;
ALTER TABLE FaseExecucao DROP CONSTRAINT FK_FaseExecucao_Proposta;
ALTER TABLE EmOrcamento DROP CONSTRAINT FK_EmOrcamento_Proposta;
ALTER TABLE AnaliseExecucao DROP CONSTRAINT FK_AnaliseExecucao_Proposta;
ALTER TABLE Orcamento DROP CONSTRAINT FK_Orcamento_FaseExecucao;
ALTER TABLE OrcamentoConstrutora DROP CONSTRAINT FK_OrcamentoConstrutora_Orcamento;
ALTER TABLE OrcamentoConstrutora DROP CONSTRAINT FK_OrcamentoConstrutora_Construtora;
ALTER TABLE OrcamentoConsorcio DROP CONSTRAINT FK_OrcamentoConsorcio_Orcamento;
ALTER TABLE OrcamentoConsorcio DROP CONSTRAINT FK_OrcamentoConsorcio_Consorcio;
ALTER TABLE OrdensDeTrabalho DROP CONSTRAINT FK_OrdemDeTrabalho_Orcamento;
ALTER TABLE PrecisaMaterial DROP CONSTRAINT FK_PrecisaMateriais_OrdemDeTrabalho;
ALTER TABLE PrecisaMaterial DROP CONSTRAINT FK_PrecisaMateriais_Materiais;
ALTER TABLE PrecisaEquipamento DROP CONSTRAINT FK_PrecisaEquipamento_OrdemDeTrabalho;
ALTER TABLE PrecisaEquipamento DROP CONSTRAINT FK_PrecisaEquipamento_Equipamento;


DROP TABLE Municipe;
DROP TABLE Proposta;
DROP TABLE Classifica;
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
DROP TABLE OrdensDeTrabalho;

DROP VIEW EstadoExecucaoPropostas;
DROP VIEW PropostasMunicipes;
DROP VIEW OrcamentosDetalhados;

DROP VIEW TotalPropostasMunicipe_PorSemestre;
