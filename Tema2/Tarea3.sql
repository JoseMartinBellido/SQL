create schema Tarea03;
use Tarea03;

create table Director(
Nombre varchar(30) not null primary key,
Nacionalidad varchar(15)
);

create table Pelicula(
ID int auto_increment primary key,
Titulo varchar(30) not null,
Productora varchar(20),
Nacionalidad varchar(20),
Fecha date,
Director varchar(30),
foreign key (Director) references Director (Nombre)
);

create table Actores(
Nombre varchar(30) primary key,
Nacionalidad varchar(20),
Sexo char(1) check (Sexo in ('H','M'))
);

create table actua(
Actor varchar(30),
ID_Peli int, 
Prota boolean default false,
primary key (Actor, ID_Peli),
foreign key (Actor) references Actores(Nombre),
foreign key (ID_Peli) references Pelicula(ID)
);

create table Socio(
DNI char(10) primary key,
Nombre varchar(30) not null,
Direccion varchar(40),
Telefono char(9),
Avalador char(10),
foreign key (Avalador) references Socio(DNI)
);

create table Ejemplar(
ID_Peli int,
Numero tinyint,
Estado varchar(10),
primary key (ID_Peli,Numero),
foreign key (ID_Peli) references Pelicula (ID)
);

create table alquila(
DNI char(10),
ID_Peli int,
Numero tinyint,
FechaAlquiler date,
FechaDevolucion date,
primary key (DNI, ID_Peli, Numero, FechaAlquiler),
foreign key (DNI) references Socio (DNI),
foreign key (ID_Peli,Numero) references Ejemplar (ID_Peli,Numero),
check (FechaDevolucion > FechaAlquiler)
);