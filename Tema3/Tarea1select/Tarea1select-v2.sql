drop schema if exists tarea1select;

create schema tarea1select;
use tarea1select;

-- Creación de tablas

create table Depart(
	dept_no int primary key,
    dnombre varchar(15) not null,
    loc varchar(20)
);

create table Emple(
	emp_no int auto_increment primary key,
    apellido varchar(15) not null,
    oficio varchar(15),
    dir int,
    fecha_alt date,
    salario decimal(10,2),
    comision decimal(10,2),
    dept_no int,
    foreign key (dept_no) references Depart(dept_no)
);

-- Inserción de datos

insert into Depart (dept_no, dnombre, loc)
	values (10,'Contabilidad', 'Sevilla'),
		(20,'Investigacion', 'Madrid'),
        (30,'Ventas', 'Barcelona'),
        (40,'Produccion', 'Bilbao'),
        (50,'Transporte', 'Malaga');
        
insert into Emple (apellido, oficio, dir, fecha_alt, salario, comision, dept_no)
	values ('Sanchez','empleado', 7902, '1980-12-17', 104000, null, 10),
		('Arroyo', 'vendedor', 7682, '1980-02-20', 208000, 39000, 30),
        ('Sala', 'vendedor', 7698, '1981-02-22', 162500, 162500, 30),
        ('Jimenez', 'director', 7839, '1981-02-02', 386720, null, 40),
        ('Gil', 'analista', 7566, '1981-11-09', 390000, null, 20),
        ('Alonso', 'transportista', 7511, '1982-01-30', 160000, null, 50);
        
-- 1. Mostrar el apellido, oficio y número de departamento de cada empleado.
select apellido, oficio, dept_no 
	from Emple;

-- 2. Mostrar el número, nombre y localización de cada departamento.
select dept_no, dnombre, loc 
	from Depart;

-- 3. Mostrar todos los datos de todos los empleados.
select * 
	from Emple;

-- 4. Datos de los empleados ordenados por apellidos.
select * 
	from Emple 
    order by apellido;

-- 5. Datos de los empleados ordenados por número de departamento descendentemente.
select * 
	from Emple 
	order by dept_no desc;

-- 6. Datos de los empleados ordenados por número de departamento descendentemente y
--  dentro de cada departamento ordenados por apellido ascendentemente.
select * 
	from Emple 
	order by dept_no desc, 
		apellido asc;

-- 8. Mostrar los datos de los empleados cuyo salario sea mayor que 2000000.
select * 
	from Emple
    where salario > 2000000;

-- 9. Mostrar los datos de los empleados cuyo oficio sea ‘ANALISTA’.
select * 
	from Emple
    where oficio = 'analista';

-- 10. Seleccionar el apellido y oficio de los empleados del departamento número 20.
select apellido, oficio 
	from Emple
    where dept_no = 20;
    
-- 11. Mostrar todos los datos de los empleados ordenados por apellido.
select *
	from Emple
    order by apellido;
    
-- 12. Seleccionar los empleados cuyo oficio sea ‘VENDEDOR’. Mostrar los datos ordenados por apellido.
select * 
	from Emple
    where upper(oficio) = 'VENDEDOR'
    order by apellido;

-- 13. Mostrar los empleados cuyo departamento sea 10 y cuyo oficio sea ‘ANALISTA’. Ordenar el resultado por apellido.
select *
	from Emple
    where dept_no = 10 and upper(oficio) = 'ANALISTA'
    order by apellido;

-- 14. Mostrar los empleados que tengan un salario mayor que 200000 o que pertenezcan al departamento número 20.
select *
	from Emple
    where salario > 200000 or dept_no = 20;

-- 15. Ordenar los empleados por oficio, y dentro de oficio por nombre. *************************************
select *
	from Emple
    order by oficio, apellido;

-- 16. Seleccionar de la tabla EMPLE los empleados cuyo apellido empiece por ‘A’.
select * 
	from Emple
    where apellido like 'A%';

-- 17. Seleccionar de la tabla EMPLE los empleados cuyo apellido termine por ‘Z’.
select *
	from Emple
    where apellido like '%Z';

-- 18. Seleccionar de la tabla EMPLE aquellas filas cuyo APELLIDO empiece por ‘A’ y el OFICIO tenga una ‘E’ en cualquier posición. ********************
select *
	from Emple
    where apellido like 'A%' and oficio like '%$E%';

-- 19. Seleccionar los empleados cuyo salario esté entre 100000 y 200000. Utilizar el operador BETWEEN.
select * 
	from Emple
    where salario between 100000 and 200000;

-- 20. Obtener los empleados cuyo oficio sea ‘VENDEDOR’ y tengan una comisión superior a 100000.
select *
	from Emple
    where upper(oficio) = 'VENDEDOR' and comision > 100000;

-- 21. Seleccionar los datos de los empleados ordenados por número de departamento, y dentro de cada departamento ordenados por apellido.
select * 
	from Emple
	order by dept_no, apellido;

-- 22. Número y apellidos de los empleados cuyo apellido termine por ‘Z’ y tengan un salario superior a 300000.
select emp_no, apellido
	from Emple
    where apellido like '%Z' and salario > 300000;

-- 23. Datos de los departamentos cuya localización empiece por ‘B’.
select * 
	from Depart
    where loc like 'B%';

-- 24. Datos de los empleados cuyo oficio sea ‘EMPLEADO’, tengan un salario superior a 100000 y pertenezcan al departamento número 10.
select *
	from  Emple
    where upper(oficio) = 'EMPLEADO' and salario > 100000 and dept_no = 10;

-- 25. Mostrar los apellidos de los empleados que no tengan comisión.
select apellido
	from Emple
    where comision is null;

-- 26. Mostrar los apellidos de los empleados que no tengan comisión y cuyo apellido empiece por ‘J’.
select apellido
	from Emple
	where comision is null and apellido like 'J%';

-- 27. Mostrar los apellidos de los empleados cuyo oficio sea ‘VENDEDOR’, ‘ANALISTA’ o ‘EMPLEADO’.
select apellido
	from Emple
    where upper(oficio) in ('VENDEDOR','ANALISTA','EMPLEADO');

-- 28. Mostrar los apellidos de los empleados cuyo oficio no sea ni ‘ANALISTA’ ni ‘EMPLEADO’, y además tengan un salario mayor de 200000.
select apellido
	from Emple
    where upper(oficio) not in ('ANALISTA','EMPLEADO') and salario > 200000;

-- 29 Seleccionar de la tabla EMPLE los empleados cuyo salario esté entre 2000000 y 3000000 (utilizar BETWEEN).
select *
	from Emple
    where salario between 200000 and 300000;

-- 30 Seleccionar el apellido, salario y número de departamento de los empleados cuyo salario sea mayor que 200000 en los departamentos 10 ó 30.
select apellido, salario, dept_no
	from Emple
    where salario > 200000 and dept_no in (10,30);

-- 31. Mostrar el apellido y número de los empleados cuyo salario no esté entre 100000 y 200000 (utilizar BETWEEN).
select apellido, dept_no
	from Emple
    where salario not between 100000 and 200000;

-- 32. Obtener el apellido de todos los empleados en minúscula.
select lower(apellido)
	from Emple;

-- 33. En una consulta concatena el apellido de cada empleado con su oficio. 
select concat(apellido,oficio)
	from Emple;

-- 34. Mostrar el apellido y la longitud del apellido (función LENGTH) de todos los empleados, ordenados por la longitud de los apellidos de los empleados
-- descendentemente.
select apellido, length(apellido)
	from Emple
    order by length(apellido);

-- 35. Obtener el año de contratación de todos los empleados (función YEAR).
select year(fecha_alt)
	from Emple;

-- 36. Mostrar los datos de los empleados que hayan sido contratados en el año 1992. 
select *
	from Emple
    where year(fecha_alt) = '1980';

-- 37. Mostrar los datos de los empleados que hayan sido contratados en el mes de febrero de cualquier año (función MONTHNAME).
select *
	from Emple
    where month(fecha_alt) = '02';

select * 
	from Emple
    where monthname(fecha_alt) = 'February';

