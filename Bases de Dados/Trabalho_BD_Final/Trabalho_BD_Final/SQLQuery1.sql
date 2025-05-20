CREATE TABLE Municipe (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Entidade (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Proposta (
    id INT IDENTITY(1,1) PRIMARY KEY,
    descricao TEXT,
    id_ INT,
    FOREIGN KEY (id_) REFERENCES(id)
);

CREATE TABLE Parecer (
    id_entidade INT,
    id_proposta INT,
    CONSTRAINT PK_Parecer PRIMARY KEY (id_entidade, id_proposta),
    FOREIGN KEY (id_entidade) REFERENCES Entidade(id),
    FOREIGN KEY (id_proposta) REFERENCES Proposta(id)
);

CREATE TABLE EstudoViabilidade (
    id INT PRIMARY KEY,
    detalhes TEXT,
    FOREIGN KEY (id) REFERENCES Proposta(id)
);

CREATE TABLE Analise (
    id INT PRIMARY KEY,
    detalhes TEXT,
    FOREIGN KEY (id) REFERENCES Proposta(id)
);

CREATE TABLE FaseExecucao (
    id INT PRIMARY KEY,
    detalhes TEXT,
    FOREIGN KEY (id) REFERENCES Proposta(id)
);

CREATE TABLE EmOrcamento (
    id INT PRIMARY KEY,
    detalhes TEXT,
    FOREIGN KEY (id) REFERENCES Proposta(id)
);

CREATE TABLE AnaliseExecucao (
    id INT PRIMARY KEY,
    detalhes TEXT,
    FOREIGN KEY (id) REFERENCES Proposta(id)
);

CREATE TABLE Construtora (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Orcamento (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_proposta INT,
    id_construtora INT,
    FOREIGN KEY (id_proposta) REFERENCES Proposta(id),
    FOREIGN KEY (id_construtora) REFERENCES Construtora(id)
);

CREATE TABLE Materiais (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Maquinas (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE OrcamentoMateriais (
    id_orcamento INT,
    id_material INT,
    PRIMARY KEY (id_orcamento, id_material),
    FOREIGN KEY (id_orcamento) REFERENCES Orcamento(id),
    FOREIGN KEY (id_material) REFERENCES Materiais(id)
);

CREATE TABLE OrcamentoMaquinas (
    id_orcamento INT,
    id_maquina INT,
    PRIMARY KEY (id_orcamento, id_maquina),
    FOREIGN KEY (id_orcamento) REFERENCES Orcamento(id),
    FOREIGN KEY (id_maquina) REFERENCES Maquinas(id)
);
-- Key's

-- Consultas para verificar a estrutura das tabelas criadas
-- Verifica as tabelas criadas
SELECT *
FROM Municipe;
SELECT *
FROM Entidade;
SELECT *
FROM Proposta;
SELECT *
FROM  Parecer;
SELECT *
FROM EstudoViabilidade;
SELECT *
FROM Analise;
SELECT *
FROM FaseExecucao;
SELECT *
FROM EmOrcamento;
SELECT *
FROM AnaliseExecucao;
SELECT *
FROM Construtora;
SELECT *
FROM Orcamento;
SELECT *
FROM Materiais;
SELECT *
FROM Maquinas;
SELECT *
FROM OrcamentoMateriais;
SELECT *
FROM OrcamentoMaquinas;


SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';


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
ORDER BY s.name, t.name, c.column_id;

DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += '
ALTER TABLE [' + s.name + '].[' + t.name + '] DROP CONSTRAINT [' + fk.name + '];'
FROM sys.foreign_keys fk
INNER JOIN sys.tables t ON fk.parent_object_id = t.object_id
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id;

EXEC sp_executesql @sql;


DROP TABLE  OrcamentoMaquinas;
DROP TABLE  OrcamentoMateriais;
DROP TABLE  Orcamento;
DROP TABLE  Construtora;
DROP TABLE  Materiais;
DROP TABLE  Maquinas;
DROP TABLE  AnaliseExecucao;
DROP TABLE  EmOrcamento;
DROP TABLE  FaseExecucao;
DROP TABLE  Analise;
DROP TABLE  EstudoViabilidade;
DROP TABLE  Parecer;
DROP TABLE  Proposta;
DROP TABLE  Entidade;
DROP TABLE  Municipe;

