use actividadextra;

-- 1.- Muestra todos los campos de socio y un campo llamado clave, ignorando los registros que no tengan informado Código postal.

-- El campo clave está formado por el código de provincia (que son los dos primeros dígitos del CP) seguido de un guión, seguido de la localidad, 
-- y del CP completo entre paréntesis. Para los socios cuyo CP y localidad no estén vacíos.

-- Ejemplo: 29-Málaga(29004)

 select *, concat(left(CP,2),'-',localidad,'(',CP,')') as clave
	from socios
    where localidad is not null and CP is not null;

-- 2.- El campo contPrest, “contador de préstamos”, de cada ejemplar debería ser igual al número de registros de préstamos de cada libro / ejemplar.

-- Muestra la signatura, el título y el ejemplar de los libros que tengan el valor del campo ContPrest erróneo.

select p.signatura, l.titulo, p.ejemplar, e.ContPrest, count(p.ejemplar) as contPrestamos 
	from ejemplares as e inner join libros as l on l.signatura = e.signatura
						inner join prestamos as p on p.signatura = e.signatura and p.ejemplar = e.ejemplar
    group by p.ejemplar, p.signatura, e.ContPrest
    having contPrestamos <> e.ContPrest;
    

-- 3.- Queremos saber la media de los días de retraso de los préstamos de cada libro, así como la desviación estándar.

select idPrestamo, Signatura, ejemplar, avg(datediff(coalesce(fechaEntrada, now()), fechaSalida) - diasLimite) as MediaRetraso, 
		std(datediff(fechaEntrada, fechaSalida)) as DesviacionEstandar
	from prestamos
    group by Signatura, idPrestamo
    having MediaRetraso > 0;


-- 4.- Muestra el IdPrestamo, la FechaSalida, y el día que era de la semana (si la fechaSalida fue lunes, martes...); 
-- de todos los préstamos que se devolvieron fuera de plazo. Ordenados por FechaSalida descendente.

-- Para cada préstamo también queremos mostrar el ejemplar, el título del libro, el autor, la editorial y el año edición; 
-- así como el nombre del socio, su dirección y su código postal. Si no hay CP mostrará como valor 'Sin CP'. Y la columna se llamará 'Código Postal'

-- Y sólo me interesan los que vivan en Málaga, Sevilla o Cádiz.

select p.idprestamo, p.fechasalida, dayname(p.fechasalida) as diaSemana, datediff(p.fechaEntrada, p.fechaSalida) as difDias, 
		p.ejemplar, l.titulo, l.autor, e.editorial, e.añoedicion, s.codsocio, s.direccion, coalesce(s.cp, 'Sin CP') as 'Código Postal'
	from prestamos as p inner join ejemplares as e on e.signatura = p.signatura and e.ejemplar = p.ejemplar
						inner join libros as l on l.signatura = e.signatura
                        inner join socios as s on s.codsocio = p.codsocio
	where s.localidad in ('Málaga','Sevilla','Cádiz')
    group by p.idPrestamo, p.diaslimite
    having difDias > diaslimite
    order by fechasalida desc;
