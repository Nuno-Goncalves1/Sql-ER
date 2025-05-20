
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

/* 1.1 F) */

Select c.Construtora, con.designacao From Construtora as c 
Inner Join Consorcio as con On c.idConsorcio = con.idConsorcio
Where con.dataConstituicao = (Select Min(con2.dataConstituicao) From Consorcio Where con2.idConsorcio = con.idConsorcio Group By con2.idConsorcio)