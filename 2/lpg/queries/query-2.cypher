// Who has to take a detour to buy milk?

MATCH
	(p:Person)-[:LIVES_IN]->(n:Neighborhood)-[:FAR_FROM]->
(m:Neighborhood)-[:HAS]->(s:Store)-[:SELLS]->(r:Product)

WHERE
	r.name = 'Milk'	

RETURN 
	p