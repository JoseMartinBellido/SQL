-- Trabajamos en una librería (bd_libreria) que tiene las siguientes tablas:

-- Editoriales(codigo, nombre_editorial, direccion, codigo_postal, telefono, email)
-- Libros(ISBN, titulo, autor, editorial, precio, fecha_edicion)
-- Autores(codigo, nombre, apellidos, fecha_nacimiento)
drop schema bd_libreria;
create schema bd_libreria;
use bd_libreria;

-- 1. Crea las tablas correspondientes. Especificando claves foráneas y cómo tratar las eliminaciones y actualizaciones de las mismas. 
-- (ON UPDATE | DELETE CASCADE | RESTRICT | SET NULL ...)

create table Editoriales (
	codigo char(4) primary key,
	nombre_editorial varchar(20) not null,
	direccion varchar(50),
	codigo_postal char(5),
	telefono char(9),
	email varchar(30)
);

create table Autores (
	codigo int auto_increment primary key,
    nombre varchar(20) not null,
    apellidos varchar(40) not null,
    fecha_nacimiento date
);


create table Libros (
	ISBN char(10) primary key,
    titulo varchar(40) not null unique,
    autor int,
    editorial char(4), 
    precio decimal(6,2), 
    fecha_edicion date,
    constraint fk_autor foreign key (autor) references Autores(codigo) on update cascade on delete cascade,
    constraint fk_editorial foreign key (editorial) references Editoriales(codigo) on update cascade on delete cascade
);


-- 2. Crea cinco editoriales(Santillana, McGraw Hill, Ra-Ma, Prentice-Hall, Garceta) con códigos (E001, E002, E003, E004, E005) 
-- y tres libros de cada editorial. Utiliza el mismo autor en al menos 4 libros. 

insert into Editoriales (codigo, nombre_editorial, direccion, codigo_postal, telefono, email) 
	values ('E001','Santillana', 'C/ Falsa nº123', '29007', '111111111','info@santillana.es'),
			('E002','McGraw Hill', 'C/ Verdadera nº123', '29008', '111111112','info@mcgrawhill.es'),
            ('E003','Ra-Ma', 'C/ Nose nº123', '29009', '111111113','info@rama.es'),
            ('E004','Prentice-Hall', 'C/ a nº123', '29010', '111111114','info@prenticehall.es'),
            ('E005','Garceta', 'C/ b nº123', '2901', '111111115','info@garceta.es');
            
            
insert into Autores (nombre, apellidos, fecha_nacimiento)
	values ('Brandon', 'Sanderson','1981-04-03'),
			('Joe', 'Abercrombie','1988-09-01'),
            ('Terry','Pratchett','1965-10-03'),
            ('Barbara','Hamley', '1971-04-18'),
            ('Ken','Follet','1975-11-12'),
            ('Andy','Weir','1990-11-27'),
            ('Rebecca','Yarros','1992-01-01'),
            ('Rebeca','F. Kuang','1988-02-28'),
            ('Mark','Lawrence','1981-04-03');
            
insert into Libros (ISBN, titulo, autor, editorial, precio, fecha_edicion)
values ('1234567890','El camino de los reyes',1,'E001',33.5,'2013-01-21'),
		('1234567891','Palabras radiantes',1,'E001',30.5,'2014-01-01'),
        ('1234567892','Juramentada',1,'E001',36.5,'2019-10-21'),
        ('1234567893','El ritmo de la guerra',1,'E001',33,'2020-11-21'),
        ('1234567894','La voz de las espadas',2,'E002',21,'2013-06-21'),
        ('1234567895','Antes de que los cuelguen',2,'E002',20.5,'2015-01-21'),
        ('1234567896','El último argumento de los reyes',2,'E002',22,'2016-09-21'),
        ('1234567897','El color de la magia',3,'E003',10.5,'1986-01-21'),
        ('1234567898','¡Guardias!¡Guardias!',3,'E003',12.5,'1994-01-21'),
        ('1234567899','Vencer al dragón',4,'E003',14.5,'1982-01-21'),
        ('1234567880','Los pilares de la tierra',5,'E004',28.9,'1994-01-21'),
        ('1234567881','Las tinieblas y el alba',5,'E004',32,'2020-01-21'),
        ('1234567882','Proyecto Hail Mary',6,'E004',24,'2022-01-21'),
        ('1234567883','Hermana roja',9,'E005',12.5,'1994-01-21'),
        ('1234567884','La guerra de la amapola',8,'E005',25,'2019-01-21'),
        ('1234567885','Babel',8,'E005',21,'2022-01-21');

-- 3. Modifica el código de la editorial Garceta a E007. Verifica que se ha modificado en la tabla libros.

update Editoriales
	set codigo = 'E007' 
	where nombre_editorial = 'Garceta';

-- 4. Inserta una nueva Editorial con código E006 y los mismos campos que la editorial E001. Sólo cambiará el nombre_editorial que será "Santillana - iberoamericana".

alter table Editoriales
	modify column nombre_editorial varchar(40) not null;

insert into Editoriales (codigo,nombre_editorial, direccion, codigo_postal, telefono, email)
        select 'E006', 'Santillana - iberoamericana', direccion, codigo_postal, telefono, email  
        from Editoriales 
        where codigo = 'E001';

-- 5. Modifica todos los códigos de la tabla Editoriales, cambia "E" por "ED".

-- alter table Libros
-- 	drop foreign key fk_editorial;
   
set foreign_key_checks = 0;   
   
alter table Editoriales
	modify column codigo char(5);

alter table Libros
	modify column editorial char(5);
    
set foreign_key_checks = 1;
    
update Editoriales
	set codigo = replace(codigo,'E','ED');
 
-- alter table Libros
	-- add constraint fk_editorial foreign key (editorial) references Editoriales(codigo) on update cascade on delete cascade;

-- 6. Modifica el precio de todos los libros de la editorial Garceta, incrementándolos en un 10%

update Libros
	set precio = precio * 1.1
    where nombre_editorial = 'Garceta';

-- 7. Elige el ISBN de uno de tus libros y modifica la fecha de edición, añadiendo un año a la fecha_edicion original.

update Libros
	set fecha_edicion = date_add(fecha_edicion, interval 1 year) 
    where ISBN = '1234567894';

-- 8. Elimina todos los libros de un autor.

delete from Libros
	where autor = 8;

-- 9. Elimina a los autores que tenga un único libro.

delete from autores
    where codigo in (select autor 
						from libros 
                        group by autor 
                        having count(*) = 1);

-- 10. Crea una vista (Vista_1) con todos los campos de libros y un campo NombreCompleto donde aparezca el nombre completo del autor con el formato "Apellidos, Nombre"

create view Vista_1 as
	select libros.*, concat(autores.apellidos,', ',autores.nombre) as NombreCompleto
		from autores inner join libros on libros.autor = autores.codigo;

-- 11. Crea una vista (Vista_2) con todos los campos de libros y un campo NombreConIniciales donde aparezca el nombre completo del autor 
-- con el formato "Inicial_Nombre. Apellidos".

create view Vista_2 as
	select libros.*, concat(left(autores.nombre,1),'. ',autores.apellidos) as NombreConIniciales
		from autores inner join libros on libros.autor = autores.codigo;

-- 12. Renombra la vista Vista_1 a V_libros_nombrecompleto.

rename table Vista_1 to V_libros_nombrecompleto;

-- 13. Renombra la vista Vista_2 a V_libros_nombreconiniciales.

rename table Vista_2 to V_libros_nombreconiniciales;

-- 14. Muestra las vistas que haya creadas en bd_libreria.

show full tables
	where table_type = 'VIEW';

-- 15. Elimina las dos vistas anteriores.

drop view V_libros_nombrecompleto;
drop view V_libros_nombreconiniciales;

-- 16. Muestra las vistas que haya creadas en la base de datos classicmodels

show full tables
	from classicmodels
    where table_type = 'VIEW';