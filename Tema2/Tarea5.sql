/* -------------------- RESTRICT --------------------

Por definición de la foreign key, los modificadores ON UPDATE y ON DELETE están establecidos en RESTRICT. 
Estos modificadores son los que determinan qué ocurre con la referencia en la otra tabla con la que está relacionada la foreign key
en caso de actualización o eliminación. 
El parámetro RESTRICT indica que no se puede eliminar o modificar una fila de la tabla categories (a la que está referida). En caso de querer hacer esto,
habría que eliminar o modificar toda referencia en products (tabla que establece la foreign key) y luego hacerlo en categories.

Creamos la database y las distintas tablas con las que vamos a realizar las pruebas.
*/ 

drop database fkdemo;

create database fkdemo;
use fkdemo;

create table Categories(
	CategoryId int auto_increment primary key,
    CategoryName varchar(100) not null
);

create table Products(
	ProductId int auto_increment primary key,
    ProductName varchar(100) not null,
    CategoryId int,
    constraint fk_category foreign key (CategoryId) references Categories(CategoryId)
    );
      

insert into Categories(CategoryName)
	values
		('Smartphone'),
		('Smartwatch');
        

-- Esta linea funciona porque el valor 1 pertenece a la tabla categories.
insert into Products(ProductName, CategoryId)
	values 
		('iPhone',1);
        
-- Esta linea provoca un error porque no existe CategoryId = 3, y por la regla de Integridad Referencial, la fk debe referenciar a un valor existente.     
insert into Products(productName, categoryId)
	values
    ('iPad',3);

-- La siguiente linea provoca otro error diferente. En este caso, hemos establecido ON UPTADE RESTRICT, por lo que no se va a ejecutar la siguiente linea.    
UPDATE categories
	set categoryId = 100
	where categoryId = 1;

/* -------------------- CASCADE --------------------

En este caso, se establece ON UPDATE y ON DELETE CASCADE. De esta forma, si se borra o modifica una fila de la tabla Categories, 
se borra o modifica automáticamente toda fila dentro de Products que incluya la referencia a la fila mencionada de Categories, actuando en cascada. 

Creamos la tabla products de nuevo e insertamos los valores para hacer pruebas.
*/

drop table products;

create table products(
    productId int auto_increment primary key,
    productName varchar(100) not null,
    categoryId int not null,
    constraint fk_category foreign key (categoryId) references categories(categoryId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

insert into products(productName, categoryId)
	values
		('iPhone', 1), 
		('Galaxy Note',1),
		('Apple Watch',2),
		('Samsung Galary Watch',2);

-- En este caso, si actualizamos la tabla categories poniendo categoryId = 100, se actualiza automáticamente toda 
-- referencia dentro de products a dicha fila.
update categories
	set categoryId = 100
	where categoryId = 1;
    
-- Al igual que con una instrucción update, si usamos delete pasa exactamente lo mismo, borrando toda fila que incluya la misma referencia
delete from categories
	where categoryId = 2;
    
-- Si hacemos una consulta a ambas tablas, podemos comprobar que al modificar y eliminar filas en categories, se actualiza automáticamente
-- todo en products.
select * from categories;
select * from products;

/* -------------------- SET NULL --------------------

En este caso, los modificadores ON UPDATE y ON DELETE se establecen SET NULL. Esto implica que, al eliminar o modificar una fila de la tabla categories, 
la referencia dentro de la tabla products se establece como Null. No elimina en cascada como anteriormente, pero tampoco evita la acción.

Creamos de nuevo ambas tablas para realizar las pruebas.

*/

drop table if exists products;
drop table if exists categories;

create table Categories(
	CategoryId int auto_increment primary key,
    CategoryName varchar(100) not null
);

create table Products(
	ProductId int auto_increment primary key,
    ProductName varchar(100) not null,
    CategoryId int,
    constraint fk_category foreign key (CategoryId) references Categories(CategoryId)
		ON UPDATE SET NULL
        ON DELETE SET NULL
    );
    
-- Insertamos de nuevo valores en ambas tablas

insert into categories(categoryName)
	values
		('Smartphone'),
		('Smartwatch');
        
insert into products(productName, categoryId)
	values
		('iPhone', 1), 
		('Galaxy Note',1),
		('Apple Watch',2),
		('Samsung Galary Watch',2);
        
-- Actualizamos la tabla categories
update categories
	set categoryId = 100
	where categoryId = 1;
    
-- Eliminamos el categoryId = 2
delete from categories 
	where categoryId = 2;
    
-- Si hacemos una consulta a ambas tablas, podemos comprobar que al modificar y eliminar los datos, tenemos NULL donde la categoría era 1 o 2.
-- Esto es así porque la categoría 1 ahora es la 100, y la 2 se ha eliminado.
select * from categories;
select * from products;