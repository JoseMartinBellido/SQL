drop schema if exists tarea02;

create schema tarea02;
use tarea02;

create table Cliente(
CodCliente int auto_increment primary key,
DNI char(10) not null unique,
Nombre varchar(30) not null,
Direccion varchar(60),
Telefono char(9)
);

create table Coche(
Matricula varchar(9) primary key,
Marca varchar(15) not null,
Modelo varchar(15) not null,
Color varchar(10),
PrecioHora decimal(6,2)
);

create table Reserva(
Numero int auto_increment primary key,
FechaInicio date,
FechaFin date,
PrecioTotal decimal(8,2),
CodCliente int,
foreign key (CodCliente) references Cliente (CodCliente)
);

create table avala(
Avalado int primary key,
Avalador int,
foreign key (Avalado) references Cliente (CodCliente),
foreign key (Avalador) references Cliente (CodCliente)
);

create table incluye(
Numero int,
Matricula varchar(9),
litrosGas decimal(4,2),
primary key(Numero,Matricula),
foreign key (Numero) references Reserva (Numero),
foreign key (Matricula) references Coche (Matricula)
);
