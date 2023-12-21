use bd_libreria;

-- 1. Modifica el precio de los libros de los autores que nacieron antes de 01-01-1980. El nuevo precio debe ser un 5% más barato.

update libros inner join autores on libros.autor = autores.codigo
	set precio = precio * 0.95
    where fecha_nacimiento < '1980-01-01';

-- 2. Inserta en la tabla Autores todos los registros de la tabla Actor de la BBDD Sakila. Usa los campos first_name y last_name. 
-- Estos nuevos autores tendrán el campo fecha_nacimiento vacío. 

insert into autores (nombre, apellidos)
select first_name, last_name from sakila.actor;

-- 3. Realiza una vista v_autores que haga una select sobre todos los campos de la tabla Autores.
-- En la columna fecha_nacimiento deberá mostrar 'Sin fecha nacimiento' en el caso de que el valor sea null.

create view v_autores as
	select codigo, nombre, apellidos, coalesce(fecha_nacimiento, 'Sin fecha nacimiento') as fecha_nacimiento from autores;


-- 4. Crea una vista v_editoriales donde se muestren todos los campos de editoriales, y un nuevo campo Ciudad que indique la Ciudad dependiendo del campo código postal. 
-- (Usa la sentencia CASE).

create view v_editoriales as
	select *, case codigo_postal
				when '29007' then 'Málaga'
                when '29008' then 'Sevilla'
                when '29009' then 'Granada'
                when '29010' then 'Córdoba'
                when '29011' then 'Almería'
                else 'No se reconoce el CP'
                end as Ciudad
		from editoriales;
	

-- 5. Crea el usuario 'invitado' que tendrá todos los permisos para la BBDD librería, y los permisos de selección y modificación para la BBDD World. 
-- Realiza pruebas que confirmen que los permisos están funcionando.

create user if not exists invitado@localhost identified by 'invitado';

grant all privileges on bd_libreria.* to invitado@localhost;

grant select, alter, update on world.* to invitado@localhost;

-- Inserto un libro nuevo desde el usuario invitado, hago una consulta general y luego lo elimino para probar que tengo privilegios

insert into libros (ISBN, titulo, autor, editorial, precio, fecha_edicion)
values ('1239871231', 'No tengo imaginación suficiente', 3, 'ED001', 29.01, '1996-01-01');

select * from autores;

delete from libros where isbn = '1239871231';
 
-- En este punto cambio de usuario a invitado
use world;
use bd_libreria;

-- Modifico la población de Málaga en la base de datos world y a hacer una consulta general
update city
	set population = 1000000
    where id = 658;
    
select * from city;

-- 6. Muestra los permisos del usuario 'invitado'. Elimina el permiso de modificación para la BBDD World. 
-- Realiza pruebas que confirmen que los permisos están funcionando.

-- En este punto vuelvo al usuario root
show grants for invitado@localhost;

revoke update, alter on world.* from invitado@localhost;

-- Vuelvo a iniciar sesión con invitado 

-- Error al intentar actualizar autores: UPDATE command denied to user 'invitado'@'localhost' for table 'autores'

update autores 
set name = 'a'
where id = 1;
