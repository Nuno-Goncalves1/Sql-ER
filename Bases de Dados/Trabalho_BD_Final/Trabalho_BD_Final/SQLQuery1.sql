-- Codigo de criaçao das tabelas 
CREATE TABLE Municipe (
    idMunicipe INT
    CONSTRAINT PK_Minicepe PRIMARY KEY (idMunicipe) 
)
CREATE TABLE Proposta (
    idProposta INT 
    CONSTRAINT PK_Proposta PRIMARY KEY (idProposta)
)
CREATE TABLE Entidade (
    idEntidade INT 
    CONSTRAINT PK_Entidade PRIMARY KEY (idEntidade)
)
CREATE TABLE Parecer(
    idParecer INT 
    CONSTRAINT PK_Parecer PRIMARY KEY
)
CREATE TABLE Construtora(
    idConstrutora INT
    CONSTRAINT PK_Construtora PRIMARY KEY (idConstrutora)
)
CREATE TABLE Consorcio(
    idConsorcio INT
    CONSTRAINT PK_Consorcio PRIMARY KEY (idConsorcio)
)
CREATE TABLE Participa(
    CONSTRAINT PK_Participa PRIMARY KEY (idConstrutora,idConsorcio)
)
CREATE TABLE Orcamento(
    idOrcamento INT
    CONSTRAINT PK_Orcamento PRIMARY KEY (idOrcamento)
)
CREATE TABLE Materiais(
    idMateriais INT
    CONSTRAINT PK_Materiais PRIMARY KEY (idMateriais)
)
CREATE TABLE Equipamentos(
    idEquipamentos INT
    CONSTRAINT PK_Equipamentos PRIMARY KEY (idEquipamentos)
)
CREATE TABLE Precisa(
    CONSTRAINT PK_Precisa PRIMARY KEY (idOrcamento,idMateriais,idEquipamentos)
)
CREATE TABLE EstudoViabilidade(
    idEstudo INT
    CONSTRAINT PK_EstudoViabilidade PRIMARY KEY (idEstudo)
)

-- Key's

-- Consultas para verificar a estrutura das tabelas criadas
-- Verifica as tabelas criadas
SELECT *
FROM Municipe
SELECT *
FROM Entidade
SELECT *
FROM Proposta
SELECT *
FROM  Parecer
SELECT *
FROM EstudoViabilidade
SELECT *
FROM Analise
SELECT *
FROM FaseExecucao
SELECT *
FROM EmOrcamento
SELECT *
FROM AnaliseExecucao
SELECT *
FROM Construtora
SELECT *
FROM Orcamento
SELECT *
FROM Materiais
SELECT *
FROM Maquinas
SELECT *
FROM OrcamentoMateriais
SELECT *
FROM OrcamentoMaquinas


/* 1.1 B) */
Select * From Municipe As m Inner Join Proposta as p On m.idMunicipe = p.idMunicipe
Where m.nome Like '%Rita%' And p.data Between '2024-04-01' And '2024-06-30' Order By m.nome Desc;

/* 1.1 C)*/

Select m.nome, Count(p.idProp) As 'Quantidade de Propostas' 
From Municipe as m Left Join Proposta as p On m.idMunicipe = p.idMunicipe 
Group By m.nome Order By Count(p.idProp) Desc;

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

--Exclusao de tabelas
DROP TABLE  OrcamentoMaquinas
DROP TABLE  OrcamentoMateriais
DROP TABLE  Orcamento
DROP TABLE  Construtora
DROP TABLE  Materiais
DROP TABLE  Maquinas
DROP TABLE  AnaliseExecucao
DROP TABLE  EmOrcamento
DROP TABLE  FaseExecucao
DROP TABLE  Analise
DROP TABLE  EstudoViabilidade
DROP TABLE  Parecer
DROP TABLE  Proposta
DROP TABLE  Entidade
DROP TABLE  Municipe

