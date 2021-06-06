CREATE (Apple:Product {name:'Apple', description:'Sweet and tasty apple'})
CREATE (Milk:Product {name:'Milk', description: 'Fresh milk from an organic farm'})
CREATE (Pilsner:Product {name:'Pilsner beer', description: 'Authentic Czech beer', alcoholic:'Yes'})

CREATE (Dairy:Category {category_name:'Dairy'})
CREATE (Drinks:Category {category_name:'Drinks'})
CREATE (Fruits:Category {category_name:'Fruits'})

CREATE (Albert:Store {description: 'Albert branch in Prague', location: 'Zlicin'})
CREATE (Makro:Store {description: 'Makro branch in Prague', location: 'Cerny Most'})
CREATE (Tesco:Store {description: 'Tesco branch in Prague', location: 'Andel'})

CREATE (Jan:Person {name: 'Jan', description: 'Average Czech male living in Andel'})
CREATE (Lenka:Person {name: 'Lenka', description: 'Average Czech female living in Cerny Most'})
CREATE (Pavel:Person {name: 'Pavel', description: 'Average Czech male living in Zlicin'})

CREATE (Andel:Neighborhood {municipality: 'Praha 5'})
CREATE (Cerny_Most:Neighborhood {municipality: 'Praha 14'})
CREATE (Zlicin:Neighborhood {municipality: 'Praha 5'})

CREATE (Apple)-[:BELONGS_TO]->(Fruits)
CREATE (Milk)-[:BELONGS_TO]->(Dairy)
CREATE (Pilsner)-[:BELONGS_TO]->(Drinks)

// Of course, this data does not model real life!

CREATE (Tesco)-[:SELLS]->(Milk)
CREATE (Makro)-[:SELLS]->(Milk)
CREATE (Makro)-[:SELLS]->(Apple)
CREATE (Makro)-[:SELLS]->(Pilsner)
CREATE (Albert)-[:SELLS]->(Pilsner)

CREATE (Jan)-[:LIVES_IN]->(Andel)
CREATE (Lenka)-[:LIVES_IN]->(Cerny_Most)
CREATE (Pavel)-[:LIVES_IN]->(Zlicin)

CREATE (Andel)-[:FAR_FROM]->(Cerny_Most)
CREATE (Cerny_Most)-[:FAR_FROM]->(Zlicin)

CREATE (Andel)-[:HAS]->(Tesco)
CREATE (Cerny_Most)-[:HAS]->(Makro)
CREATE (Zlcin)-[:HAS]->(Albert)