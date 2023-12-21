create schema practicando2;
use practicando2;

create table Alumno(
NumMatricula int auto_increment primary key,
Nombre varchar(30),
FechaNacimiento Date,
Telefono char(9)
);

create table Profesor(
IdProfesor int auto_increment primary key,
NIF_P char(10) unique,
Nombre varchar(30),
Especialidad varchar(15),
Telefono char(9)
);

create table Asignatura(
CodAsignatura int auto_increment primary key,
Nombre varchar(30),
IdProfesor int,
foreign key (IdProfesor) references Profesor(IdProfesor)
);

create table Recibe(
NumMatricula int,
CodAsignatura int,
CursoEscolar varchar(20),
primary key(NumMatricula,CodAsignatura,CursoEscolar),
foreign key (NumMatricula) references Alumno (NumMatricula),
foreign key (CodAsignatura) references Asignatura (CodAsignatura)
);