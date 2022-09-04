/*What years are covered by the dataset?*/

SELECT DISTINCT year from population_years;

/*What is the largest population size for Gabon in this dataset?*/

SELECT * FROM POPULATION_YEARS;
SELECT MAX(POPULATION),COUNTRY
FROM POPULATION_YEARS
WHERE COUNTRY='Gabon';


/*What were the 10 lowest population countries in 2005?*/
/*1st method:*/

select * from
(SELECT country,population,year,
rank()over( order by population )as lowest_population
from population_years
where year=2005 )a
where a.lowest_population <=10;

/*2nd method:*/

select population,year,country from population_years
where year=2005 
order by 1
limit 10;


/*What are all the distinct countries with a population of over 100 million in the year 2010?*/
/*1st method:*/

select distinct country,year,population
from population_years
where year=2010 and population >100
order by 1;

/*2nd method:*/

select distinct country,year,population,
row_number()over(order by country)as pop
from population_years
where year=2010 and population >100;

/*How many countries in this dataset have the word “Islands” in their name?*/

select count(country) from population_years
where country like '%islands%';

/*What is the difference in population between 2000 and 2010 in Indonesia?*/
/*step1:*/
select *
from population_years
where year=2010 and country='Indonesia' or
 year=2000 and country='Indonesia';

 /*step2:*/
 select year,country,population,
 population -
 lag(population)over(partition by country) as change_in_population
 from population_years
 where year=2010 and country='Indonesia'
 or year=2000 and country='Indonesia';