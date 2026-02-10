use world ;
### Q1: Count how many cities are there in each country 
Select * from city ;
select * from country ; 

SELECT c.Name AS Country,
COUNT(ci.ID) AS TotalCities
FROM country c
LEFT JOIN city ci
ON c.Code = ci.CountryCode
GROUP BY c.Name;

### Q2: Display all continents having more than 30 countries 
	select 
Continent, 
count(Code) as TotalCountries 
from country
group by Continent 
having TotalCountries >30;

### Q3: List regions whose total population exceeds 200 million 
select Region , 
 sum(Population) as Total_Population
from country 
group by Region 
having Total_Population >200000000;  

###Q4: Find the top 5 continents by average GNP per country 
select Continent ,
avg(GNP) as World_GNP
from country 
group by Continent 
order by World_GNP desc 
limit 5 ;  

###Q5: Find the total number of official languages spoken in each continent 
 
 SELECT c.Continent,
       COUNT(cl.Language) AS TotalOfficialLanguages
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY c.Continent;

###Q6: Find the maximum and minimum GNP for each continent  
Select Continent ,
Max(GNP) as World_Max_GNP ,
Min(GNP) as World_Min_GNP
from country 
group by Continent ;
  
  
  ####Q7: Find the country with the highest average city population 
SELECT c.Name AS Country,
AVG(ci.Population) AS Avg_City_Pop
FROM country c
JOIN city ci
ON c.Code = ci.CountryCode
GROUP BY c.Name
ORDER BY Avg_City_Pop DESC
LIMIT 1;
 
 ### Q8: List continents where the average city population is greater than 200,000 
 SELECT c.Continent,
AVG(ci.Population) AS Avg_City_Pop
FROM country c
JOIN city ci
ON c.Code = ci.CountryCode
GROUP BY c.Continent
HAVING AVG(ci.Population) > 200000;
 
 ### Q9: Find the total population and average life expectancy for each continent, ordered by average life expectancy descending 
 
 SELECT Continent,
SUM(Population) AS TotalPopulation,
AVG(LifeExpectancy) AS AvgLifeExpectancy
FROM country
GROUP BY Continent
ORDER BY AvgLifeExpectancy DESC; 
 
 
 #### Q10: Find the top 3 continents with the highest average life expectancy, but only include those where the total population is over 200 million 
 SELECT Continent,
AVG(LifeExpectancy) AS AvgLifeExpectancy,
SUM(Population) AS TotalPopulation
FROM country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY AvgLifeExpectancy DESC
LIMIT 3;
 

