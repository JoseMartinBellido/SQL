create schema tarea01;
use tarea01;

create table cliente(
nif char(10) primary key,
nombre varchar(30),
direccion varchar(50),
telefono char(9)
);

create table modelodormitorio(
cod char(5) primary key
);

create table montador(
nif char(10) primary key,
nombre varchar(30),
direccion varchar(50),
telefono char(9)
);

create table compra(
nif_c char(10),
modelo char(5),
fechacompra date,
primary key(nif_c,modelo,fechacompra)
);

create table monta(
modelo char(5),
nif_m char(10),
fechamontaje date,
primary key(modelo,nif_m,fechamontaje)
);

-- Restricciones de Foreign Keys
alter table compra
add foreign key compra (nif_c) references cliente(nif),
add foreign key compra (modelo) references modelodormitorio(cod);

alter table monta
add foreign key monta (modelo) references modelodormitorio(cod),
add foreign key monta (nif_m) references montador(nif);

-- Modificaciones de la tabla cliente
alter table cliente
add column edad tinyint check (edad>= 18 and edad <=99);
							-- edad between 18 and 99

alter table cliente
modify column direccion varchar(150);

-- Creación del índice
create index indice on cliente(nombre);



