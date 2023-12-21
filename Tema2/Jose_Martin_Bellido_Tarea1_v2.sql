drop schema if exists examen;

create schema examen;
use examen;

-- Primera parte del exámen. Creación de tablas. 

create table Localidad(
	Cod_Localidad int auto_increment primary key,
    Nombre varchar(20) not null
);

create table Restaurante(
	Cod_Rest char(10) primary key,
    Nombre varchar(30) not null,
    Licencia_Fiscal char(12) not null,
    Domicilio varchar(40),
    Fecha_Apertura date not null,
    Horario char(9) not null,
    Cod_Localidad int not null,
    foreign key (Cod_Localidad) references Localidad(Cod_Localidad)
);

create table Existencias(
	Cod_Articulo char(10) primary key,
    Nombre varchar(15) not null,
    Cantidad int not null,
    Precio decimal(6,2) not null,
    Cod_Rest char(10) not null,
    check (Precio > 0),
    foreign key (Cod_Rest) references Restaurante(Cod_Rest)
);

create table Titular(
	DNI_Titular char(10) primary key,
    Nombre varchar(40) not null,
    Domicilio varchar(40),
    Cod_Rest char(10) not null,
    foreign key (Cod_Rest) references Restaurante (Cod_Rest)
);

create table Empleado(
	DNI_Empleado char(10) primary key,
    Nombre varchar(40) not null,
    Domicilio varchar(40)
);

create table Rest_Empleado(
	Cod_Rest char(10) not null,
    DNI_Empleado char(10) not null,
    Funcion varchar(10) not null,
    check (Funcion in ('CAMARERO','COCINERO','LIMPIEZA')),
    primary key(Cod_Rest,DNI_Empleado,Funcion),
    foreign key (Cod_Rest) references Restaurante(Cod_Rest),
    foreign key (DNI_Empleado) references Empleado(DNI_Empleado)
);

-- Segunda parte del exámen. ALTER TABLE.

-- Eliminación del campo Horario en la tabla Restaurante
alter table Restaurante
	drop column Horario;
    
-- Añadir campo Fecha_Nacimiento en la tabla Empleado   
alter table Empleado
	add column Fecha_Nacimiento date not null;

-- Restricciones en el campo Cantidad de la tabla Existencias
alter table Existencias
	modify Cantidad int not null default 0,
    add check (Cantidad between 0 and 100);
