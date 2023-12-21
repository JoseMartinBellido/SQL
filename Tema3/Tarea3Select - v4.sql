use world;

-- 1. Enumera todos los idiomas que se hablan en USA
select distinct Language
	from countrylanguage
    where countrycode = 'USA';

-- 2. Obtén la superficie de cada país y el número de ciudades.
select code, SurfaceArea, count(code) as NumeroCiudades
	from country 
    inner join city on country.Code = city.CountryCode
    group by countrycode, SurfaceArea;

-- 3. Averigua la longevidad media en todos los países que hablan español.
select code, LifeExpectancy, countrylanguage.Language
	from country inner join countrylanguage on country.code = countrylanguage.CountryCode
    where countrylanguage.Language = 'Spanish';

-- 4. Cuántas ciudades tenemos en España.
select count(city.ID) as NumeroDeCiudades
	from city inner join country on city.countrycode = country.Code
    where country.name = 'Spain';
    
select count(name)
	from city 
    where countryCode = 'ESP';    

-- 5. ¿Cómo puedes averiguar el número de habitantes de cualquier país que no reside en una capital?
select sum(city.population) as HabitantesSinCapital, city.CountryCode 
	from city 
    inner join country on city.CountryCode = country.Code
    where city.ID <> country.Capital
    group by country.Code;
    
select country.population as PoblacionPais, city.population as PoblacionCiudad
	from country inner join city on city.CountryCode = country.Code
    where countryCode = 'AFG' and city.id = country.capital;

-- 6. ¿Qué países tienen por idioma oficial el inglés?
select country.name as Pais, Language as Idioma, IsOfficial as esOficial
	from country inner join countrylanguage on country.Code = countrylanguage.CountryCode
    where IsOfficial = 'T' and Language = 'English';
	
-- 7. De todas las ciudades que tenemos en un España, cuáles tienen más de 10.000 habitantes?
select name, population, countrycode
	from city
    where population > 10000 and countrycode = 'ESP';
    
select city.name as Ciudad, country.name as Pais, city.population as PoblacionCiudad
	from city inner join country on city.countrycode = country.Code
    where city.population > 10000 and country.name = 'Spain';

-- 8. Saca cada país con su nombre completo y el número de distritos.
select country.name, count(distinct district) as NumeroDistritos
	from country inner join city on country.Code = city.CountryCode
    group by country.name;

-- 9. Saca cada ciudad con el país al que corresponde, ordenado por ciudad.
select city.name as Ciudad, country.name as Pais
	from city inner join country on country.Code = city.CountryCode
    order by city.name;

-- 10. Obtén una lista con los siguientes campos: Ciudad, población, país, superficie, idioma oficial.
select city.name, city.population, country.name as Pais, surfacearea, Language, IsOfficial
	from city 
		inner join country on country.Code = city.CountryCode
        inner join countrylanguage on city.CountryCode = countrylanguage.CountryCode
	where IsOfficial = 'T';

-- 11. Obtén una lista con los siguientes campos: Ciudad, población, país, superficie, idioma oficial. Ordena por países. 
select country.name as Pais, city.name as Ciudad, city.population as PoblacionCiudad, surfacearea, Language, IsOfficial
	from city 
		inner join country on country.Code = city.CountryCode
        inner join countrylanguage on country.Code = countrylanguage.CountryCode
	where countrylanguage.IsOfficial = 'T'
    order by country.name;

-- 12. Obtén el nombre de la capital de todos los países.
select city.name as capital, country.name as Pais
	from city inner join country on country.Code = city.CountryCode
    where city.ID = country.Capital;

-- 13. Di el nombre de la capital del país más grande.
select city.name as Capital, country.name as Pais, surfaceArea
	from city inner join country on city.CountryCode = country.Code
    where country.SurfaceArea = (select max(SurfaceArea) from country)
		and city.ID = country.Capital;
        
select city.name as Capital, country.name as Pais, surfaceArea 
	from city inner join country on city.ID = country.Capital
    where country.SurfaceArea = (select max(SurfaceArea) from country);

-- 14. Di el nombre de la capital del país con más esperanza de vida.
select city.name as Capital
	from city inner join country on city.CountryCode = country.Code
	where country.LifeExpectancy = (select max(LifeExpectancy) from country)
		and city.ID = country.Capital;

-- 15. Di el nombre de la capital del país con más población.
select city.name as Capital 
	from city inner join country on city.CountryCode = country.Code
    where country.Population = (select max(Population) from country)
		and city.ID = country.Capital;

-- 16. Lista todos los países con sus capitales y la lengua oficial
select city.name as Ciudad, country.name as Pais, Language
	from city
		inner join country on city.CountryCode = country.Code
        inner join countrylanguage on city.CountryCode = countrylanguage.CountryCode
	where country.Capital = city.ID and IsOfficial = 'T';
    
select city.name as Capital, country.name as Pais, countrylanguage.Language as IdiomaOficial
	from city
		inner join country on city.ID = country.Capital
        inner join countrylanguage on country.Code = countrylanguage.CountryCode
	where countrylanguage.IsOfficial = 'T'
    order by country.Name, countrylanguage.Language;

-- 17. Lista todos los países con más de 1 millón de habitantes con sus capitales y la lengua oficial
select country.name as Pais, city.name as Ciudad, Language
	from country	
		inner join city on city.CountryCode = country.Code
        inner join countrylanguage on countrylanguage.CountryCode = country.Code
	where IsOfficial = 'T' and city.ID = country.Capital;

-- 18. Lista todos los países con más de 1 millón de habitantes con sus capitales y sus lenguas no oficiales.
select country.name as Pais, city.name as Ciudad, Language
	from country	
		inner join city on city.CountryCode = country.Code
        inner join countrylanguage on countrylanguage.CountryCode = country.Code
	where IsOfficial = 'F' and city.ID = country.Capital;

-- 19. Cuantos idiomas tiene cada país.
select  country.name, country.name as Pais, count(Language) as NumeroIdiomas
	from country inner join countrylanguage on country.code = countrylanguage.CountryCode
	group by country.name;

-- 20. ¿Tenemos algún país con dos lenguas oficiales? (hacer con having)
select CountryCode, count(IsOfficial) as numeroIdiomasOficiales
	from countrylanguage
    where IsOfficial = 'T'
	group by CountryCode
    having numeroIdiomasOficiales = 2;

select Country.name, count(IsOfficial) as numeroIdiomasOficiales
	from country inner join countrylanguage on countrylanguage.CountryCode = country.Code
    where IsOfficial = 'T'
    group by country.code
    having numeroIdiomasOficiales = 2;
    
select country.code, count(*)
	from country inner join countrylanguage on country.code = countrylanguage.countrycode
	where IsOfficial = 'T'
    group by country.code
    having count(*) = 2;

-- 21. Saca el jefe de gobierno de un país cuya capital es Madrid. 
select governmentForm 
	from country inner join city on country.Code = city.CountryCode
    where city.name = 'Madrid';
