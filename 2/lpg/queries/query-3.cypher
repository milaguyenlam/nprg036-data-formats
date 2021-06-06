// this query returns all paths of length 4 from Person to Category. Given how I consturcted the data, length 4 means direct, quickest path. This is evident as most of the resulting paths start from Lenka, who has direct access to Makro, which sells all 3 products.

MATCH p = (:Person)-[*4]-(:Category)
RETURN nodes(p)