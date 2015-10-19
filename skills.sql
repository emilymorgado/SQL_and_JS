-- Note: Please consult the directions for this assignment 
-- for the most explanatory version of each question.

-- 1. Select all columns for all brands in the Brands table.
sqlite>.tables
sqlite>.mode columns
sqlite>.headers on
sqlite> SELECT * FROM Brands;

id          name        founded     headquarters  discontinued
----------  ----------  ----------  ------------  ------------
1           Ford        1903        Dearborn, MI              
2           Chrysler    1925        Auburn Hills              
3           Citroën    1919        Saint-Ouen,               
4           Hillman     1907        Ryton-on-Dun  1981        
5           Chevrolet   1911        Detroit, Mic              
6           Cadillac    1902        New York Cit              
7           BMW         1916        Munich, Bava              
8           Austin      1905        Longbridge,   1987        
9           Fairthorpe  1954        Chalfont St   1976        
10          Studebaker  1852        South Bend,   1967        
11          Pontiac     1926        Detroit, MI   2010        
12          Buick       1903        Detroit, MI               
13          Rambler     1901        Kenosha, Was  1969        
14          Plymouth    1928        Auburn Hills  2001        
15          Tesla       2003        Palo Alto, C   

-- 2. Select all columns for all car models made by Pontiac in the Models table.
sqlite> SELECT * FROM Models WHERE brand_name='Pontiac';

id          year        brand_name  name      
----------  ----------  ----------  ----------
25          1961        Pontiac     Tempest   
27          1962        Pontiac     Grand Prix
36          1963        Pontiac     Grand Prix
42          1964        Pontiac     GTO       
43          1964        Pontiac     LeMans    
44          1964        Pontiac     Bonneville
45          1964        Pontiac     Grand Prix

-- 3. Select the brand name and model 
--    name for all models made in 1964 from the Models table.
sqlite> SELECT brand_name, name FROM Models WHERE year=1964;

brand_name  name      
----------  ----------
Chevrolet   Corvette  
Ford        Mustang   
Ford        Galaxie   
Pontiac     GTO       
Pontiac     LeMans    
Pontiac     Bonneville
Pontiac     Grand Prix
Plymouth    Fury      
Studebaker  Avanti    
Austin      Mini Coope

-- 4. Select the model name, brand name, and headquarters for the Ford Mustang 
--    from the Models and Brands tables.
sqlite> SELECT models.name, brand_name, headquarters FROM Models JOIN Brands on (brands.name=brand_name) WHERE models.name='Mustang';

name        brand_name  headquarters
----------  ----------  ------------
Mustang     Ford        Dearborn, MI

-- 5. Select all rows for the three oldest brands 
--    from the Brands table (Hint: you can use LIMIT and ORDER BY).
sqlite> SELECT * FROM Brands JOIN Models on (brands.name=brand_name) ORDER BY year LIMIT 3;

id          name        founded     headquarters  discontinued  id          year        brand_name  name      
----------  ----------  ----------  ------------  ------------  ----------  ----------  ----------  ----------
1           Ford        1903        Dearborn, MI                1           1909        Ford        Model T   
2           Chrysler    1925        Auburn Hills                2           1926        Chrysler    Imperial  
3           Citroën    1919        Saint-Ouen,                 3           1948        Citroën    2CV       


-- 6. Count the Ford models in the database (output should be a number).
sqlite> SELECT COUNT(*) FROM Models WHERE brand_name='Ford';
6

-- 7. Select the name of any and all car brands that are not discontinued.
sqlite> SELECT name FROM Brands GROUP BY name HAVING discontinued IS NULL;

name      
----------
BMW       
Buick     
Cadillac  
Chevrolet 
Chrysler  
Citroën  
Ford      
Tesla  

-- 8. Select rows 15-25 of the DB in alphabetical order by model name.
sqlite> SELECT * FROM Models ORDER BY name LIMIT 11 OFFSET 14;

id          year        brand_name  name      
----------  ----------  ----------  ----------
8           1955        Chevrolet   Corvette  
10          1956        Chevrolet   Corvette  
11          1957        Chevrolet   Corvette  
13          1958        Chevrolet   Corvette  
17          1959        Chevrolet   Corvette  
20          1960        Chevrolet   Corvette  
26          1961        Chevrolet   Corvette  
28          1962        Chevrolet   Corvette  
38          1963        Chevrolet   Corvette  
39          1964        Chevrolet   Corvette  
34          1963        Ford        E-Series 

-- 9. Select the brand, name, and year the model's brand was 
--    founded for all of the models from 1960. Include row(s)
--    for model(s) even if its brand is not in the Brands table.
--    (The year the brand was founded should be NULL if 
--    the brand is not in the Brands table.)
sqlite> SELECT brands.name, models.name, year, founded FROM Models LEFT JOIN Brands ON (models.brand_name=brands.name) WHERE year=1960;

name        name        year        founded   
----------  ----------  ----------  ----------
Chevrolet   Corvair     1960        1911      
Chevrolet   Corvette    1960        1911      
            Fillmore    1960                  
Fairthorpe  Rockette    1960        1954  

-- Part 2: Change the following queries according to the specifications. 
-- Include the answers to the follow up questions in a comment below your
-- query.

-- 1. Modify this query so it shows all brands that are not discontinued
-- regardless of whether they have any models in the models table.
-- before:
    -- SELECT b.name,
    --        b.founded,
    --        m.name
    -- FROM Model AS m
    --   LEFT JOIN brands AS b
    --     ON b.name = m.brand_name
    -- WHERE b.discontinued IS NULL;
sqlite> SELECT brands.name, founded, models.name FROM Brands LEFT JOIN Models ON (models.brand_name=brands.name) WHERE discontinued IS NULL;

name        founded     name      
----------  ----------  ----------
Ford        1903        E-Series  
Ford        1903        Galaxie   
Ford        1903        Model T   
Ford        1903        Mustang   
Ford        1903        Thunderbir
Ford        1903        Thunderbir
Chrysler    1925        Imperial  
Citroën    1919        2CV       
Chevrolet   1911        Corvair   
Chevrolet   1911        Corvair 50
Chevrolet   1911        Corvette  
Chevrolet   1911        Corvette  
Chevrolet   1911        Corvette  
Chevrolet   1911        Corvette  
Chevrolet   1911        Corvette  
Chevrolet   1911        Corvette  
Chevrolet   1911        Corvette  
Chevrolet   1911        Corvette  
Chevrolet   1911        Corvette  
Chevrolet   1911        Corvette  
Chevrolet   1911        Corvette  
Chevrolet   1911        Corvette  
Cadillac    1902        Fleetwood 
BMW         1916        600       
BMW         1916        600       
BMW         1916        600       
Buick       1903        Special   
Tesla       2003                  



-- 2. Modify this left join so it only selects models that have brands in the Brands table.
-- before: 
    -- SELECT m.name,
    --        m.brand_name,
    --        b.founded
    -- FROM Models AS m
    --   LEFT JOIN Brands AS b
    --     ON b.name = m.brand_name;

-- followup question: In your own words, describe the difference between 
-- left joins and inner joins.
sqlite>
SELECT models.name, brand_name, founded
FROM Brands LEFT JOIN
Models ON Brands.name=Models.brand_name;

name        brand_name  founded   
----------  ----------  ----------
E-Series    Ford        1903      
Galaxie     Ford        1903      
Model T     Ford        1903      
Mustang     Ford        1903      
Thunderbir  Ford        1903      
Thunderbir  Ford        1903      
Imperial    Chrysler    1925      
2CV         Citroën    1919      
Minx Magni  Hillman     1907      
Corvair     Chevrolet   1911      
Corvair 50  Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Fleetwood   Cadillac    1902      
600         BMW         1916      
600         BMW         1916      
600         BMW         1916      
Mini        Austin      1905      
Mini        Austin      1905      
Mini Coope  Austin      1905      
Mini Coope  Austin      1905      
Mini Coope  Austin      1905      
Rockette    Fairthorpe  1954      
Avanti      Studebaker  1852      
Avanti      Studebaker  1852      
Avanti      Studebaker  1852      
Avanti      Studebaker  1852      
Bonneville  Pontiac     1926      
GTO         Pontiac     1926      
Grand Prix  Pontiac     1926      
Grand Prix  Pontiac     1926      
Grand Prix  Pontiac     1926      
LeMans      Pontiac     1926      
Tempest     Pontiac     1926      
Special     Buick       1903      
Classic     Rambler     1901      
Fury        Plymouth    1928      
                        2003


Inner Joins show information shared by both tables
Left Joins show information shared by both tables AND all information from the first table too.
When people refer to Outer Joins, they are probably talking about Left Joins (unless they use very fancy programs)

-- 3. Modify the query so that it only selects brands that don't have any models in the models table. 
-- (Hint: it should only show Tesla's row.)
-- before: 
    -- SELECT name,
    --        founded
    -- FROM Brands
    --   LEFT JOIN Models
    --     ON brands.name = Models.brand_name
    -- WHERE Models.year > 1940;
sqlite> SELECT brands.name, founded FROM Brands LEFT JOIN Models ON brands.name=brand_name WHERE brand_name IS NULL GROUP BY brands.name;

name        founded   
----------  ----------
Tesla       2003   

-- 4. Modify the query to add another column to the results to show 
-- the number of years from the year of the model until the brand becomes discontinued
-- Display this column with the name years_until_brand_discontinued.
-- before: 
    -- SELECT b.name,
    --        m.name,
    --        m.year,
    --        b.discontinued
    -- FROM Models AS m
    --   LEFT JOIN brands AS b
    --     ON m.brand_name = b.name
    -- WHERE b.discontinued NOT NULL;

SELECT brands.name, models.name, year, discontinued, discontinued-year AS years_until_brand_discontinued
FROM Models LEFT JOIN
Brands ON brands.name=brand_name
WHERE discontinued NOT NULL;

name        name              year        discontinued  years_until_brand_discontinued
----------  ----------------  ----------  ------------  ------------------------------
Hillman     Minx Magnificent  1950        1981          31                            
Austin      Mini              1959        1987          28                            
Fairthorpe  Rockette          1960        1976          16                            
Austin      Mini Cooper       1961        1987          26                            
Studebaker  Avanti            1961        1967          6                             
Pontiac     Tempest           1961        2010          49                            
Pontiac     Grand Prix        1962        2010          48                            
Studebaker  Avanti            1962        1967          5                             
Austin      Mini              1963        1987          24                            
Austin      Mini Cooper S     1963        1987          24                            
Rambler     Classic           1963        1969          6                             
Studebaker  Avanti            1963        1967          4                             
Pontiac     Grand Prix        1963        2010          47                            
Pontiac     GTO               1964        2010          46                            
Pontiac     LeMans            1964        2010          46                            
Pontiac     Bonneville        1964        2010          46                            
Pontiac     Grand Prix        1964        2010          46                            
Plymouth    Fury              1964        2001          37                            
Studebaker  Avanti            1964        1967          3                             
Austin      Mini Cooper       1964        1987          23                      


-- Part 3: Further Study

-- 1. Select the name of any brand with more than 5 models in the database.

-- 2. Add the following rows to the Models table.

-- year    name       brand_name
-- ----    ----       ----------
-- 2015    Chevrolet  Malibu
-- 2015    Subaru     Outback

-- 3. Write a SQL statement to crate a table called `Awards`
--    with columns `name`, `year`, and `winner`. Choose
--    an appropriate datatype and nullability for each column
--   (no need to do subqueries here).

-- 4. Write a SQL statement that adds the following rows to the Awards table:

--   name                 year      winner_model_id
--   ----                 ----      ---------------
--   IIHS Safety Award    2015      the id for the 2015 Chevrolet Malibu
--   IIHS Safety Award    2015      the id for the 2015 Subaru Outback

-- 5. Using a subquery, select only the *name* of any model whose 
-- year is the same year that *any* brand was founded.





