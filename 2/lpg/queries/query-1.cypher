// Lenka went to buy apple. Since only Makro sells Apples, Apples are now no longer in stock

MATCH
	(p:Person)-[:LIVES_IN]->(n:Neighborhood)-[:HAS]->(s:Store)-[:SELLS]->(r:Product)

WHERE
	p.name = 'Lenka' AND r.name = 'Apple'

SET
	r += {status: 'Not Available'}

RETURN 
	r