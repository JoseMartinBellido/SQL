create schema practicando4;
use practicando4;

create table Periodista(
DNI char(10) primary key,
Nombre varchar(30) not null,
Direccion varchar(60),
Telefono char(9),
Especialista varchar(20)
);

create table Sucursal(
Codigo int auto_increment primary key,
Direccion varchar(60),
Telefono char(9)
);

create table Empleado(
DNI char(10) primary key,
Nombre varchar(30) not null,
Direccion varchar(60),
Telefono char(9),
Sucursal int,
foreign key (Sucursal) references Sucursal (Codigo)
);

create table Revista(
NumReg int auto_increment primary key,
Titulo varchar(20) not null,
Periodicidad varchar(10) default 'Mensual',
Tipo varchar(20),
Sucursal int,
check (Periodicidad in ('Semanal', 'Quincenal', 'Mensual', 'Trimestral', 'Anual')),
foreign key (Sucursal) references Sucursal(Codigo)
);

create table escribe(
NumReg int,
DNI_Per char(9),
primary key(NumReg,DNI_Per),
foreign key (NumReg) references Revista(NumReg),
foreign key (DNI_Per) references Periodista(DNI)
);

create table NumRevista(
NumReg int,
Numero int not null,
NumPaginas int,
Fecha date,
CantVendidas int,
primary key(NumReg,Numero),
foreign key (NumReg) references Revista(NumReg),
check (NumPaginas > 0)
);