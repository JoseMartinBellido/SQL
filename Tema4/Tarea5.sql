
drop user if exists adminbd, aperez_ventas, lmartin_ventas, p_cuevas_ventas, arodriguez_administracion;
drop role if exists dpto_ventas, dpto_administracion;

-- Vamos a crear los siguientes usuarios: adminbd, aperez_ventas, lmartin_ventas, p_cuevas_ventas, arodriguez_administracion

create user adminbd, aperez_ventas, lmartin_ventas, p_cuevas_ventas, arodriguez_administracion;

-- El primero deberá tener los mismos permisos que root.
-- Los que tienen el sufijo "ventas" accederán con el rol dpto_ventas.
-- Los que tienen el sufijo "administracion" accederán con el rol dpto_administracion.

grant all on *.* to adminbd;

create role dpto_ventas;
create role dpto_administracion;

grant dpto_ventas to aperez_ventas, lmartin_ventas, p_cuevas_ventas;
grant dpto_administracion to arodriguez_administracion;


-- Departamento de ventas. Únicamente accederán a la base de datos neptuno con las siguientes restricciones:

-- Podrán acceder a todas las tablas con permisos de lectura.
 
grant select on bd_neptuno2.* to dpto_ventas;

-- Podrán insertar y modificar registros de las tablas clientes, envios y pedidos.

grant insert, update on bd_neptuno2.clientes to dpto_ventas;
grant insert, update on bd_neptuno2.envios to dpto_ventas;
grant insert, update on bd_neptuno2.pedidos to dpto_ventas;

-- Podrán eliminar registros de la tabla envíos, detalles y pedidos.

grant delete on bd_neptuno2.envios to dpto_ventas;
grant delete on bd_neptuno2.detalles to dpto_ventas;
grant delete on bd_neptuno2.pedidos to dpto_ventas;

-- Muestra permisos para el usuario aperez_ventas.

show grants for aperez_ventas using dpto_ventas;

-- Departamento de administración. Accederán a la base de datos neptuno con las siguientes restricciones:

-- Tendrán todos los permisos para las tablas categorias, productos, empleados y clientes.

grant all on bd_neptuno2.categorias to dpto_administracion;
grant all on bd_neptuno2.productos to dpto_administracion;
grant all on bd_neptuno2.empleados to dpto_administracion;
grant all on bd_neptuno2.clientes to dpto_administracion;

-- Para todas las demás únicamente podrán visualizar los registros.

grant select on bd_neptuno2.detalles to dpto_administracion;
grant select on bd_neptuno2.envios to dpto_administracion;
grant select on bd_neptuno2.pedidos to dpto_administracion;
grant select on bd_neptuno2.proveedores to dpto_administracion;

show grants for arodriguez_administracion using dpto_administracion;

-- Tareas

-- Muestra todos los usuarios del sistema.

use mysql;
select user from user;

-- El usuario  arodriguez_administracion también accederá a la base de datos sakila pero sólo para realizar consultas 
-- sobre las tablas customer, category, inventory, payment, rental, staff, store, address.

grant select on sakila.customer to arodriguez_administracion;
grant select on sakila.category to arodriguez_administracion;
grant select on sakila.inventory to arodriguez_administracion;
grant select on sakila.payment to arodriguez_administracion;
grant select on sakila.rental to arodriguez_administracion;
grant select on sakila.staff to arodriguez_administracion;
grant select on sakila.store to arodriguez_administracion;
grant select on sakila.address to arodriguez_administracion;

-- Modificar la contraseña de arodriguez_administracion 

set password for arodriguez_administracion = '1234';
-- alter user arodriguez_administracion = '1234';

-- Modifica el usuario aperez_ventas por pperez_ventas.

rename user aperez_ventas to pperez_ventas;

-- Elimina el permiso de arodriguez_administracion sobre la base de datos sakila.

revoke select on sakila.customer from arodriguez_administracion;
revoke select on sakila.category from arodriguez_administracion;
revoke select on sakila.inventory from arodriguez_administracion;
revoke select on sakila.payment from arodriguez_administracion;
revoke select on sakila.rental from arodriguez_administracion;
revoke select on sakila.staff from arodriguez_administracion;
revoke select on sakila.store from arodriguez_administracion;
revoke select on sakila.address from arodriguez_administracion;

-- Elimina el permiso de eliminación del rol de ventas.

revoke delete on bd_neptuno2.envios from dpto_ventas;
revoke delete on bd_neptuno2.detalles from dpto_ventas;
revoke delete on bd_neptuno2.pedidos from dpto_ventas;

