// Of course, all of these 3 places are connected through yellow line

MATCH 
	(n1:Neighborhood)-[:FAR_FROM]-(n2:Neighborhood)
RETURN
	*
