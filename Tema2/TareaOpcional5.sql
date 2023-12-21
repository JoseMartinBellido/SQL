create schema practicando5;
use practicando5;

create table Municipio(
ID int auto_increment primary key,
Nombre varchar(40) not null,
CodPostal char(5),
Provincia varchar(20)
);

create table Vivienda(
ID int auto_increment primary key,
TipoVia varchar(10) default 'Calle',
NombreVia varchar(30) not null,
Numero varchar(3) not null,
IDMunicipio int,
foreign key (IDMunicipio) references Municipio (ID)
);

create table Persona(
DNI char(10) primary key,
Nombre varchar(40) not null,
FechaNac date,
Sexo char(1),
IDVivienda int,
check (upper(Sexo) in ('H','M')),
foreign key (IDVivienda) references Vivienda (ID)
);

create table cabezaFamilia(
DNI char(10) primary key,
IDVivienda int unique,
foreign key (DNI) references Persona (DNI),
foreign key (IDVivienda) references Vivienda (ID)
);

create table posee(
DNI char(10),
IDVivienda int,
primary key (DNI,IDVivienda),
foreign key (DNI) references Persona(DNI),
foreign key (IDVivienda) references Vivienda (ID)
);
