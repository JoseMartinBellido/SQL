
-- CONSULTAS SOBRE LA BASE DE DATOS WORLD, TABLA CITY
use world;

-- 1. Ver estructura de la tabla
describe city;

-- 2. Ver todas las tuplas de la tabla
select * 
	from city;

-- 3. Ver todos los nombres y distritos de las ciudades
select Name, District 
	from city;

-- 4. Ver todas las ciudades que tienen el código ESP
select * 
	from city
    where CountryCode = 'ESP';

-- 5. Ver todas las ciudades y sus códigos de pais, ordenados por código de país
select Name, CountryCode
	from city
    order by CountryCode;

-- 6. Ver cuántas ciudades tiene cada país
select CountryCode, count(*)
	from city
    group by CountryCode;
	
-- 7. Sacar la población menor
select min(population)
	from city;

-- 8. Sacar el nombre de la ciudad con más habitantes
select name
	from city
    where population = (select max(population) from city);

-- 9. Averigua la suma de todas los habitantes
select sum(population)
	from city;

-- 10. Saca la suma de habitantes agrupadas por países
select countrycode, sum(population)
	from city
    group by countrycode;

-- 11. Saca los distintos códigos de país
select distinct countrycode
	from city;

-- 12. Cuenta los distintos códigos de país
select count(distinct countrycode)
	from city;

-- 13. Saca las ciudades del país usa, que su población sea mayor de 10000
select name, countrycode, population 
	from city
    where countrycode = 'USA' and population > 10000;

-- 14. Cuenta todos los códigos de países
select count(countrycode)
	from city;

-- 15. Suma todas las poblaciones distintas
select sum(distinct population) 
	from city;

-- 16. Saca el nombre de la ciudad con menos habitantes
select name, population
	from city
    where population = (select min(population) from city);

-- 17. Saca la media de habitantes
select avg(population)
	from city;

-- 18. Saca la ciudad que tenga exactamente la media de habitantes
select name, countrycode, population
	from city
    where population = (select avg(population) from city);

-- 19. Saca todas las provincias (Distritos) de España
select district
	from city
    where countrycode = 'ESP';

-- 20. Saca sólo las provincias distintas de España
select distinct district
	from city
    where countrycode = 'ESP';

-- 21. Saca el número de ciudades por provincia
select district, count(name) as NumeroCiudades
	from city
    group by district;

-- 22. Saca todas las ciudades de Extremadura.
select name
	from city
    where district = 'Extremadura';

-- 23. Saca la cuenta de las ciudades agrupadas por provincias y por países.
select district, countrycode, count(name)
	from city
    group by district, countrycode;

-- 24. Saca la suma de la población de todos los distritos de España
select district, sum(population)
	from city
    where countrycode = 'ESP'
    group by district;

-- 25. Cual es el distrito español con más habitantes.
select district, sum(population) as poblacion
	from city
    where countrycode = 'ESP' 
    group by district
    order by poblacion desc
    limit 1;

-- CONSULTAS SOBRE LA TABLA COUNTRY

-- 1. ¿Cuál es la esperanza de vida máxima?
select max(lifeexpectancy)
	from country;

-- 2. Saca la lista de las capitales de todos los paises
select name, capital
	from country;

-- 3. Saca la lista de las capitales europeas
select name,capital 
	from country
    where continent = 'europe';

-- 4. Saca las lista de las capitales africanas y norteamericanas
select name, continent, capital
	from country
    where continent in ('africa','north america');

-- 5. Halla la población media
select avg(population) 
	from country;

-- 6. Saca los países con mayor y menor esperanza de vida
select name, lifeexpectancy
	from country
    where lifeexpectancy = (select max(lifeexpectancy) from country) or lifeexpectancy = (select min(lifeexpectancy) from country);

-- 7. Saca una lista de continentes ordenadas por la esperanza de vida media de forma descendente.
select continent, avg(lifeexpectancy) as media
	from country
    group by continent
    order by media desc;

-- 8. Cuál es la mayor esperanza de vida (Dos formas de hacerlo, con una variable y de una forma nueva, usar una select como tabla)
select max(lifeexpectancy)
	from country;

-- 9. Sacar el país con mayor extensión de terreno
select name, surfacearea
	from country
    where surfacearea = (select max(surfacearea) from country);

-- 10. Cuántas regiones distintas tenemos
select count(distinct region)
	from country;

-- 11. Saca el nombre local de todos los países
select localname
	from country;

-- 12. Saca el nombre local de todos los países Europeos y asiáticos
select localname, continent
	from country
    where continent in ('europe','asia');

-- 13. Saca las distintas formas de gobierno.
select distinct governmentform
	from country;

-- 14. ¿Qué forma de gobierno tienen, España, Francia, China? Saca los países ordenados por forma de gobierno.
select name, governmentform
	from country
    where name in ('spain', 'france', 'china')
    order by governmentform;

-- 15. Saca todos los países islámicos.
-- select name 
-- 	  from country
--    where governmentform = 'islamic emirate';

SELECT Name, GovernmentForm
FROM country
WHERE GovernmentForm LIKE '%Islam%' 
						OR GovernmentForm LIKE '%Sultanate%' 
                        OR GovernmentForm LIKE '%Emirate%';

-- 16. Saca el país que antes se independizó.
select name, indepyear
	from country
    where indepyear = (select min(indepyear) from country);

-- 17. Cuál es el país con menor extensión.
select name, surfacearea
	from country
    where surfacearea = (select min(surfacearea) from country);

-- 18. Cuál es el país con mayor población
select name, population
	from country
    where population = (select max(population) from country);
