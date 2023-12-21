drop schema ejer1;
create schema ejer1;
use ejer1;

-- Creación de tablas

create table Profesor(
	IdProfesor int auto_increment primary key,
    NIF_P char(10) unique,
    Nombre varchar(30),
    Especialidad varchar(20),
    Telefono char(9)
);

create table Asignatura(
	CodAsignatura int auto_increment primary key,
    Nombre varchar(30),
    IdProfesor int,
    constraint fk_Profesor foreign key (IdProfesor) references Profesor(IdProfesor)
																on delete set null
																on update cascade
);

create table Alumno(
	NumMatricula int auto_increment primary key,
    Nombre varchar(30),
    FechaNacimiento date,
    Telefono char(9)
);

create table Recibe(
	NumMatricula int,
    CodAsignatura int,
    CursoEscolar char(5),
    primary key (NumMatricula, CodAsignatura, CursoEscolar),
    constraint fk_Alumno foreign key (NumMatricula) references Alumno(NumMatricula) 
																on delete restrict
																on update cascade,
	constraint fk_Asignatura foreign key (CodAsignatura) references Asignatura(CodAsignatura)
																on delete restrict
                                                                on update cascade
);

-- Inserta 2 profesores.

insert into Profesor (NIF_P, Nombre, Especialidad, Telefono)
	values ('00000000-A','Manolo','Programación','000000000'),
		('11111111-B','Nacho','Bases de datos','111111111');
        
-- Inserta 4 asignaturas.	

insert into Asignatura (Nombre, IdProfesor)
	values ('Programación',1),
		('Bases de datos',2),
        ('Acceso a bases de datos',2),
        ('Lenguaje de marcas',null);
        
-- Inserta 10 alumnos.        

insert into Alumno (Nombre, FechaNacimiento, Telefono)
	values ('Jose', '1993-10-26', '000000001'),
		('Padiya','2000-01-01','000000010'),
        ('Tomás','1991-01-01','000000015'),
        ('Jorge','1991-10-10','111111100'),
        ('Nicolás','2001-09-09','222222222'),
        ('Aarón','2002-06-06','333333333'),
        ('Alejandro','2002-05-05','444444444'),
        ('Manuel','1982-02-02','555555555'),
        ('Rubén','2003-08-08','666666666'),
        ('Emilio','2004-11-11','777777777');
        
-- Cada alumno debe realizar al menos 2 asignaturas.
        
insert into Recibe
	values ('1','1','23-24'),
		('1','2','23-24'),
        ('2','1','23-24'),
		('2','4','23-24'),
        ('3','1','23-24'),
		('3','2','23-24'),
        ('4','1','23-24'),
		('4','3','23-24'),
        ('5','1','23-24'),
		('5','3','23-24'),
        ('6','2','23-24'),
		('6','3','23-24'),
        ('7','2','23-24'),
		('7','3','23-24'),
        ('8','1','23-24'),
		('8','4','23-24'),
        ('9','1','23-24'),
		('9','3','23-24'),
        ('10','2','23-24'),
		('10','3','23-24');
        
-- 1. Introduce tres alumnos para los cuales no conocemos el número de teléfono.

insert into Alumno (Nombre, FechaNacimiento)
	values ('Raúl','2004-12-12'),
		('Diego','1999-01-31'),
        ('Ignacio','1998-10-30');

-- 2. Modifica los datos de los tres alumnos anteriores para establecer un número de teléfono para cada uno.

update Alumno
	set Telefono = '123456789'
	where NumMatricula = 11;
    
update Alumno 
	set Telefono = '123456798'
	where NumMatricula = 12;

update Alumno
	set Telefono = '123456987'
	where NumMatricula = 13;

-- 3. Para todos los alumnos, poner 2000 como año de nacimiento.

update Alumno
	set FechaNacimiento = concat('2000-',month(FechaNacimiento),'-',day(FechaNacimiento));

update Alumno
	set FechaNacimiento = makedate('2000',dayofyear(FechaNacimiento));

-- 4. Para los profesores que tienen número de teléfono y NIF no comience por 9, poner “Informática” como especialidad.

update Profesor
	set Especialidad = 'Informática'
    where Telefono is not null and NIF_P not like '9%';

-- 5. Cambia la asignación de asignaturas para los profesores. 
-- Es decir, las asignaturas impartidas por un profesor las dará el otro profesor y viceversa.

-- Para realizar esta operación, modificamos la tabla Profesor y hacemos un campo auxiliar. Luego lo eliminamos.

alter table Asignatura
	add column IdProfesorAux int;
    
update Asignatura 
	set IdProfesorAux = IdProfesor;
    
update Asignatura 
	set IdProfesor = 1
	where IdProfesorAux = 2;
	
update Asignatura 
	set IdProfesor = 2
	where IdProfesorAux = 1;
    
alter table Asignatura
	drop column IdProfesorAux;

-- 6. En la tabla Recibe borra todos los registros que pertenecen a una de las asignaturas.

 delete from Recibe
	 where CodAsignatura = 4;
	
-- 7. En la tabla Asignatura borra dicha asignatura.

delete from Asignatura
	where CodAsignatura = 4;

-- 8. Borra el resto de asignaturas. ¿Qué sucede? ¿Cómo lo solucionarías?

-- Como he previsto el caso anteriormente, la foreign key restringe el borrado de asignaturas que siguen estando en la tabla recibe.
-- No pueden haber alumnos con una asignatura recibida y un profesor inexistente, ni tiene sentido el borrado en cascada.

delete from Asignatura;

-- 9. Borra todos los profesores. ¿Qué sucede? ¿Cómo lo solucionarías?

-- En este caso, está diseñado para que, cuando se borran todos los profesores, en las asignaturas se quede el profesor como null.
-- Esto se debe a que el profesor puede dejar de trabajar en un centro y la asignatura se quedaría sin profesor temporalmente.

delete from Profesor;

-- 10. Borra todos los alumnos. ¿Qué sucede? ¿Cómo lo solucionarías?

-- No tiene sentido borrar los datos de los alumnos en cascada, por lo que queda restringido.
-- Tampoco tiene sentido poner en null porque en Recibe no podemos tener un número de matrícula nulo.

delete from Alumno;
