use actividadextra;

-- 1. La signatura de los libros cuya editorial sea ‘McGraw-Hill’ 

select libros.signatura
	from libros inner join ejemplares using (signatura)
    where ejemplares.editorial = 'McGraw-Hill';

-- 2. Los títulos de los libros cuya editorial sea ‘McGraw-Hill’ 

select libros.titulo
	from libros inner join ejemplares using (signatura)
    where ejemplares.editorial = 'McGraw-Hill';

-- 3. El título de los libros cuyo autor tenga como apellido ‘Date’ 

select titulo, autor
	from libros
    where autor like '%Date%';
	
-- 4. Los títulos y editoriales de los libros cuyo autor sea ‘James Martin’ 

select libros.titulo, ejemplares.editorial
	from libros inner join ejemplares using (signatura)
	where libros.autor = 'James Martin';

-- 5. Las editoriales de todos los libros de la biblioteca, sin que aparezcan duplicados. 

select distinct editorial 
	from ejemplares;

-- 6. Las editoriales de todos los libros junto con el número de ejemplares que hay de cada editorial. 

select editorial, count(distinct signatura)
	from ejemplares
    group by editorial;

-- 7. La signatura y código de los socios de los préstamos que hayan excedido el número de días límite y aún no hayan sido devueltos.  

select prestamos.signatura, socios.codsocio
	from prestamos inner join socios on prestamos.codsocio = socios.codsocio
    where fechaentrada is null and datediff(fechasalida, curdate()) > diaslimite;

-- 8. El título, el autor y el número de ejemplar de los ejemplares que no estén disponibles. 

select libros.titulo, libros.autor, ejemplares.ejemplar
	from ejemplares inner join prestamos using (ejemplar)
					inner join libros on libros.signatura = ejemplares.signatura
    where ejemplares.Disponible = false;

-- 9. El título de los libros que haya sacado alguna vez el socio 22. 

select distinct prestamos.codsocio, libros.titulo
	from ejemplares inner join prestamos using (ejemplar)
					inner join libros on libros.signatura = ejemplares.signatura
    where ejemplares.codsocio = 22;

-- 10. El título de los libros que tenga en su poder el socio 22. 

select libros.titulo
	from ejemplares inner join prestamos using (ejemplar)
					inner join libros on libros.signatura = ejemplares.signatura
    where prestamos.codsocio = 22 and isnull(fechaEntrada);

-- 11. El título de los libros que haya sacado alguna vez el socio ‘José López’. 

select libros.titulo
	from ejemplares inner join prestamos using (ejemplar)
					inner join libros on libros.signatura = ejemplares.signatura
                    inner join socios on prestamos.codsocio = socios.codsocio
    where socios.nombre = 'José López';

-- 12. Los nombres de los socios que hayan sacado algún ejemplar del libro ‘Sistemas de Bases de Datos’ del autor ‘C.J. Date’. 

select socios.nombre
	from ejemplares inner join prestamos using (ejemplar)
					inner join libros on libros.signatura = ejemplares.signatura
                    inner join socios on prestamos.codsocio = socios.codsocio
    where libros.titulo = 'Sistemas de Bases de Datos' and libros.autor = 'C.J. Date';

-- 13. El nombre del socio, el teléfono y el título del libro de los préstamos que hayan excedido el número de días límite 
-- y que aún no han sido devueltos. 
-- Ordenado en primer lugar por nombre de socio y en segundo lugar por título del libro. 

select socios.nombre, socios.tlfn, libros.titulo
	from ejemplares inner join prestamos using (ejemplar)
					inner join libros on libros.signatura = ejemplares.signatura
                    inner join socios on prestamos.codsocio = socios.codsocio
	where datediff(fechasalida, curdate()) > diaslimite and isnull(prestamos.fechaentrada)
    order by socios.nombre, libros.titulo;

-- 14. El nombre de los socios que hayan sacado al menos un ejemplar de todos los libros. 
-- Se podría expresar como: “los nombres de los socios tales que no exista un libro que no hayan sacado”. 

select socios.nombre, count(distinct prestamos.signatura) as NumeroDeLibrosSacados
	from socios inner join prestamos on prestamos.codsocio = socios.codsocio
	group by socios.nombre
    having NumeroDeLibrosSacados = ( select count(*) from libros);
    
select socios.*
	from socios
    where not exists(
				select 1
                from libros
                where not exists (
							select 1
                            from prestamos
                            where prestamos.codsocio = socios.codsocio and prestamos.signatura = libros.signatura))
	order by socios.nombre;

-- 15. El título de los libros que hayan sido sacados por todos los socios. 

select libros.titulo, count(distinct prestamos.codsocio) as NumeroDeSocios
	from prestamos  inner join ejemplares on ejemplares.signatura = prestamos.signatura
                    inner join libros on libros.signatura = ejemplares.signatura
	group by ejemplares.signatura
    having NumeroDeSocios = ( select count(*) from socios);

-- 16. El nombre de los socios que no hayan sacado el libro con signatura ‘SIS-DAT’. 
    
select socios.*
	from socios
	WHERE codsocio not in (select codsocio from prestamos WHERE prestamos.signatura = 'SIS-DAT')
	order by socios.nombre;
    
select socios.*
	from socios left join prestamos on socios.CodSocio = prestamos.CodSocio and prestamos.Signatura != 'SIS-DAT'
	where prestamos.CodSocio is null;
    
-- 17. Cuántos socios tiene la biblioteca. 

select count(codsocio)
	from socios;

-- 18. Cuál es el nombre del socio más joven de la biblioteca. 

select socios.nombre
	from socios 
    where fechanacimiento = (select max(fechanacimiento) from socios);

-- 19. El título de los dos libros más prestados junto con el acumulado de veces que se han prestado, 
-- ordenados de mayor a menor por esta cantidad. (sin distinguir entre los distintos ejemplares de un libro). 

select libros.titulo, count(prestamos.IdPrestamo) as ContPrestamos
	from prestamos inner join ejemplares on ejemplares.signatura = prestamos.signatura
					inner join libros on libros.signatura = ejemplares.signatura
	group by prestamos.signatura
    order by ContPrestamos
    limit 2;
	

-- 20. El número de veces que se ha solicitado el libro de signatura ‘SIS-DAT’ sin distinguir entre sus distintos ejemplares. 
-- Utilizando el atributo ContPrestamos. 

select count(idprestamo) as ContPrestamos
	from prestamos 
	where signatura = 'SIS-DAT';

-- 21. La signatura, el título, junto con el número de veces que se ha solicitado cada ejemplar. Ordenado por signatura. 
-- Utilizando el atributo ContPrest (contador de préstamos). 

select libros.signatura, libros.titulo, prestamos.ejemplar, count(prestamos.ejemplar) as ContPrest
	from prestamos inner join ejemplares on prestamos.signatura = ejemplares.signatura and prestamos.ejemplar = ejemplares.Ejemplar
					inner join libros on libros.signatura = ejemplares.signatura
	group by prestamos.ejemplar, libros.signatura
    order by libros.signatura;

-- 22. Igual que el anterior, pero que sólo se muestren aquellos libros que hayan sido sacados más de 50 veces.

select libros.signatura, libros.titulo, count(ejemplares.ejemplar) as ContPrest
	from prestamos inner join ejemplares on prestamos.signatura = ejemplares.signatura and prestamos.ejemplar = ejemplares.Ejemplar
					inner join libros on libros.signatura = ejemplares.signatura
    group by prestamos.ejemplar, prestamos.signatura
    having ContPrest > 50;