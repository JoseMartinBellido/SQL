create schema practicando;
use practicando;

create table Tiendas(
Nif varchar(10),
Nombre varchar(20),
Direccion varchar(20),
Poblacion varchar(20),
Provincia varchar(20),
CodPostal char(5)
);

alter table Tiendas
add primary key (Nif),
modify column Nombre varchar(30) not null;

create table Fabricantes(
Cod_Fabricante char(3),
Nombre varchar(15),
Pais varchar(20)
);

alter table Fabricantes
add primary key (Cod_Fabricante);

create table Articulos(
Articulo varchar(20),
Cod_Fabricante char(3),
Peso double,
Categoria varchar(10),
Precio_Venta decimal(6,2),
Precio_Coste decimal(6,2),
Existencias int
);

alter table Articulos
add primary key(Articulo,Cod_Fabricante,Peso,Categoria),
add foreign key(Cod_Fabricante) references Fabricantes(Cod_Fabricante),
add check (Precio_Venta >= 0 and Precio_Coste >= 0 and Peso >= 0);

alter table Articulos
add check (Categoria='Primera' or Categoria='Segunda' or Categoria='Tercera');

create table Ventas(
NIF char(10),
Articulo varchar(20),
Cod_Fabricante char(3),
Peso double,
Categoria varchar(10),
Fecha_Venta Date,
Unidades_Vendidas int
);

alter table Ventas
add primary key(NIF, Articulo, Cod_Fabricante, Peso, Categoria, Fecha_Venta),
add foreign key(NIF) references Tiendas(Nif),
add foreign key (Articulo, Cod_Fabricante,Peso,Categoria) 
references Articulos(Articulo,Cod_Fabricante,Peso,Categoria),
add check (Unidades_Vendidas >= 0),
add check (Categoria='Primera' or Categoria='Segunda' or Categoria='Tercera');

create table Pedidos(
NIF char(10),
Articulo varchar(20),
Cod_Fabricante char(3),
Peso double,
Categoria varchar(10),
Fecha_Pedido Date,
Unidades_Pedidas int,
Existencias int
);

alter table Pedidos
add primary key(NIF, Articulo, Cod_Fabricante, Peso, Categoria, Fecha_Pedido),
add foreign key (NIF) references Tiendas(Nif),
add foreign key (Articulo, Cod_Fabricante, Peso, Categoria)
references Articulos (Articulo, Cod_Fabricante, Peso, Categoria),
add check (Unidades_Pedidas >= 0),
add check (Categoria='Primera' or Categoria='Segunda' or Categoria='Tercera')
-- add check (Categoria in ('Primera','Segunda','Tercera'))
;

