
-- 1. Crea la Base de Datos "Tarea_final".
drop schema if exists Tarea_final;
create schema Tarea_final;
use Tarea_final;

-- 2. Crea la tabla Partidos(siglas, denominacion, fecha_creacion, num_afiliados)

create table Partidos (
	siglas char(5) primary key,
    denominacion varchar(50) not null,
    fecha_creacion date,
    num_afiliados int
);

-- Inserta un registro para cada uno de los cinco partidos de nivel estatal más conocidos.

insert into Partidos
	values ('PP', 'Partido Popular', '1989-01-20', 700000),
			('PSOE', 'Partido Socialista Obrero Español', '1979-05-02', 400000),
            ('CS', 'Ciudadanos', '2006-07-09', 20000),
            ('UP', 'Unidas Podemos', '2016-05-13', 487000),
            ('VOX', 'Vox', '2013-12-17', 10000);



-- 3. Crea la tabla Politicos(id, apellidos, nombre, partido, cargo)
-- id: clave, autoincremental
-- apellidos, nombre: no pueden ser nulos
-- cargo: máximo 30 caracteres
-- partido: referencia a la tabla partidos, campo siglas
-- Inserta varios políticos por partido, los principales los deberías conocer y tendrán como cargo "Candidato presidencia". 
-- Invéntate algún otro político y créalo sin cargo.

create table Politicos (
	id int auto_increment primary key,
    apellidos varchar(30) not null,
    nombre varchar(30) not null,
    cargo varchar(30),
    partido char(5),
    constraint fk_partido foreign key (partido) references Partidos(siglas)
);

insert into Politicos (apellidos, nombre, cargo, partido)
	values ('Sánchez Pérez-Castejón', 'Pedro', 'Candidato presidencia', 'PSOE'),
			('Núñez Feijóo', 'Alberto', 'Candidato presidencia', 'PP'),
            ('Díaz Pérez', 'Yolanda', 'Candidato presidencia', 'UP'),
            ('Abascal Conde', 'Santiago', 'Candidato presidencia', 'VOX'),
            ('Guasp Barrero', 'Patricia', 'Candidato presidencia', 'CS'),
            ('Mellado', 'Miguel', 'Portavoz congreso', 'PP'),
            ('Mínguez García', 'Montserrat', 'Portavoz congreso', 'PSOE'),
            ('Vázquez', 'Adrián', 'Secretario general', 'CS'),
            ('Belarra Urteaga', 'Ione', 'Secretario general', 'UP'),
            ('Ortega Smith-Molina', 'Javier', 'Vicepresidente del partido', 'VOX');

-- 4. Crea la tabla Encuestas(id_encuestado, edad, ciudad, partido_a_votar, programa_leido, partido_votado_antes, fecha_encuesta)

-- id_encuestado: clave, autoincremental
-- edad, ciudad, partido_a_votar, programa_leido, fecha_encuesta: son no nulos
-- Inserta un mínimo de 20 encuestados.
-- Utiliza las ciudades: Madrid, Barcelona, Valencia, Sevilla.
-- Fecha_encuesta que sea alguna entre los meses de marzo y abril de 2019.

create table Encuestas (
	id_encuestado int auto_increment primary key,
    edad tinyint not null,
    ciudad varchar(30) not null,
    partido_a_votar char(5) not null,
    programa_leido boolean not null,
    partido_votado_antes char(5),
    fecha_encuesta date not null,
    constraint fk_partido_a_votar foreign key (partido_a_votar) references Partidos (siglas),
    constraint fk_partido_votado foreign key (partido_votado_antes) references Partidos (siglas)
);

INSERT INTO Encuestas (edad, ciudad, partido_a_votar, programa_leido, partido_votado_antes, fecha_encuesta) VALUES
(17, 'Sevilla', 'PP', true, 'PP', '2019-04-10'),
(17, 'Sevilla', 'PP', true, 'PP', '2019-04-10'),
(17, 'Sevilla', 'PP', true, 'PP', '2019-04-10'),
(20, 'Sevilla', 'PP', true, 'PP', '2019-04-10'),
(20, 'Sevilla', 'PSOE', true, 'PSOE', '2019-04-10'),
(20, 'Sevilla', 'PSOE', true, 'PSOE', '2019-04-10'),
(20, 'Sevilla', 'PP', true, 'PP', '2019-04-10'),
(20, 'Sevilla', 'PP', true, 'PP', '2019-04-10'),
(20, 'Sevilla', 'CS', true, 'CS', '2019-04-10'),
(20, 'Sevilla', 'CS', true, 'CS', '2019-04-10'),
(20, 'Sevilla', 'PP', true, 'PP', '2019-04-20'),
(20, 'Sevilla', 'CS', true, 'CS', '2019-04-20'),
(20, 'Sevilla', 'CS', true, 'CS', '2019-04-20'),
(20, 'Sevilla', 'CS', true, 'PP', '2019-04-20'),
(20, 'Sevilla', 'PSOE', true, 'PSOE', '2019-04-20'),
(20, 'Sevilla', 'PP', true, 'PP', '2019-04-20'),
(20, 'Sevilla', 'PP', true, 'UP', '2019-04-20'),
(20, 'Sevilla', 'PSOE', true, 'PSOE', '2019-04-20'),
(20, 'Sevilla', 'PSOE', true, 'PSOE', '2019-04-20'),
(20, 'Sevilla', 'PSOE', true, 'PSOE', '2019-04-20'),
(20, 'Sevilla', 'PSOE', true, 'PSOE', '2019-04-20'),
(20, 'Malaga', 'PSOE', true, 'PSOE', '2019-04-20'),
(20, 'Sevilla', 'PSOE', true, 'PSOE', '2019-04-20'),
(20, 'Sevilla', 'PSOE', true, 'PSOE', '2019-04-20'),
(20, 'Malaga', 'PP', true, 'PP', '2019-04-20'),
(20, 'Sevilla', 'UP', true, 'UP', '2019-04-20'),
(20, 'Sevilla', 'PP', true, 'VOX', '2019-04-20'),
(20, 'Sevilla', 'PP', true, 'VOX', '2019-04-20'),
(20, 'Malaga', 'CS', true, 'PP', '2019-04-20'),
(20, 'Sevilla', 'PSOE', true, 'PSOE', '2019-04-20'),
(20, 'Sevilla', 'UP', true, 'UP', '2019-04-20'),
(20, 'Malaga', 'PP', true, 'PP', '2019-04-20'),
(20, 'Sevilla', 'VOX', true, 'VOX', '2019-04-20'),
(20, 'Sevilla', 'VOX', true, 'VOX', '2019-04-20'),
(20, 'Sevilla', 'PP', true, 'PP', '2019-04-20'),
(20, 'Sevilla', 'VOX', true, 'VOX', '2019-04-20'),
(20, 'Malaga', 'PP', true, 'PP', '2019-04-20'),
(20, 'Sevilla', 'PP', true, 'PP', '2019-04-20'),
(20, 'Malaga', 'PP', true, 'PP', '2019-04-20'),
(20, 'Sevilla', 'PP', true, 'PP', '2019-04-20');

-- 5. Crea la vista v_resultados, donde aparezca el total de votos estimados por partido.

drop view if exists v_resultados;

create view v_resultados as
	select partido_a_votar, count(*) as VotosEstimados
		from encuestas 
        group by partido_a_votar;

-- 6. Elimina los registros de la tabla encuestas cuando la fecha de la encuesta esté entre el 1 y el 15 de abril de 2019, 
-- y la edad del encuestado sea menor de 18.

delete from encuestas
	where fecha_encuesta between '2019-04-01' and '2019-04-15'
		and edad < 18;

-- 7. Incrementa en un 10% los afiliados del partido que tenga una estimación de voto mayor. Usando la vista v_resultados.

update partidos 
	set num_afiliados = round(num_afiliados * 1.1)
    where siglas = (select partido_a_votar
						from v_resultados 
						where VotosEstimados = (select max(VotosEstimados) 
													from v_resultados));

-- 8. Crea los siguientes usuarios. Y realiza las pruebas que corroboran que los permisos son correctos.

-- Usuario 'simple'@'localhost' que únicamente podrá insertar y consultar la tabla Encuestas.

create user 'simple'@'localhost';
grant insert, select on tarea_final.encuestas to 'simple'@'localhost';
show grants for 'simple'@'localhost';

-- Usuario 'gestor'@'localhost' que podrá crear y modificar tablas, así como consultar, 
-- añadir y modificar registros de todas las tablas de la BBDD "Tarea_final", 
-- excepto de la tabla Partidos, que sólo podrá consultar y modificar registros.
drop user 'gestor'@'localhost';
create user 'gestor'@'localhost';
grant create, alter, select, insert, update on Tarea_final.encuestas to 'gestor'@'localhost';
grant create, alter, select, insert, update on Tarea_final.politicos to 'gestor'@'localhost';
grant select, update on Tarea_final.Partidos to 'gestor'@'localhost';

-- Muestra los permisos del usuario 'gestor'.

show grants for 'gestor'@'localhost';

-- Elimina el permiso de consulta para el usuario 'simple'@'localhost'

revoke select on Tarea_final.encuestas from 'simple'@'localhost';

-- 9. Crea una tabla Ciudades(id_ciudad, nombre_ciudad, prefijo_ccaa, ccaa, poblacion).

-- id_ciudad es autoincremental.
-- Inserta en Ciudades los registros de la tabla City de la base de datos World que sean de España. 
-- El campo ccaa se corresponde con el campo District. El campo prefijo_ccaa serán las tres primeras letras de la ccaa.

create table Ciudades (
	id_ciudad int auto_increment primary key,
    nombre_ciudad varchar(35),
    prefijo_ccaa char(3),
    ccaa varchar(20),
    poblacion int
);

insert into Ciudades (nombre_ciudad, ccaa, poblacion)
	select name, district, population from world.city;
    
update Ciudades 
	set prefijo_ccaa = left(ccaa,3);


-- 10. Modifica los valores del campo Ciudad, de la tabla Encuestas.
-- El valor que debe aparecer es el id_ciudad de la tabla Ciudades, para cada campo Encuestas.Ciudad.

update encuestas inner join ciudades on encuestas.ciudad = ciudades.nombre_ciudad
	set encuestas.ciudad = id_ciudad;
    
alter table encuestas
	modify ciudad int,
	add constraint fk_ciudades foreign key (ciudad) references ciudades(id_ciudad);


