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
