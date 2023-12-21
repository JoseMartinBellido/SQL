create schema practicando3;
use practicando3;

create table Departamento(
Id int auto_increment primary key,
Nombre varchar(30) not null,
Ubicacion varchar(50)
);

create table Jefe(
Id int auto_increment primary key,
DNI char(10) not null unique,
Nombre varchar(30) not null,
Salario decimal(10,2),
Telefono char(9),
IdDep int unique,
foreign key (IdDep) references Departamento(Id)
);

create table Empleado(
Id int auto_increment primary key,
DNI char(10) not null unique,
Nombre varchar(30) not null,
Salario decimal(10,2),
Telefono char(9),
IdDep int,
foreign key (IdDep) references Departamento(Id)
);