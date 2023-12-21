drop schema practicando6;

create schema practicando6;
use practicando6;

create table Sucursal(
CodSucursal int auto_increment primary key,
Nombre varchar(20),
Direccion varchar(40),
Localidad varchar(15)
);

create table Cliente(
DNI char(10) primary key,
Nombre varchar(40),
Direccion varchar(40),
Localidad varchar(15),
FechaNac date,
Sexo boolean
);

create table cuenta (
CodSucursal int,
CodCuenta int,
primary key (CodSucursal, CodCuenta)
);

create table CliCuenta(
CodSucursal int,
CodCuenta int,
DNI char(10),
primary key (CodSucursal, CodCuenta, DNI)
);

create table Transaccion(
CodSucursal int,
CodCuenta int,
NumTransaccion char(10),
Fecha date,
Cantidad tinyint,
Tipo varchar(10)
);

alter table Sucursal
add index (Nombre);

alter table Sucursal
add index (Localidad);

alter table Sucursal
auto_increment = 1;

alter table Cuenta
add foreign key (CodSucursal) references Sucursal (CodSucursal);

alter table Cliente
add index (Nombre),
add index (Localidad);

alter table CliCuenta
add foreign key (CodSucursal, CodCuenta) references Cuenta (CodSucursal, CodCuenta),
add foreign key (DNI) references Cliente (DNI);

alter table Transaccion
add foreign key (CodSucursal, CodCuenta) references Cuenta (CodSucursal, CodCuenta);
