-- 1. Consulta que filtre por más de dos campos.

-- Selecciona los productos que sean algún tipo de queso cuyo precio por unidad no sea mayor a 22€

create view v_quesos_baratos as 
	select * 
	from productos
    where producto like '%queso%' and precio_unidad <= 22;

-- 2. Consulta que muestre únicamente x campos de una tabla.

-- Selecciona el código de cliente, el contacto, su dirección y su número de teléfono
create view v_datos_clientes as
	select codigo, contacto, direccion, telefono
    from clientes;

-- 3. Consulta que use una subconsulta.

-- Selecciona el pedido que haya sido más caro
create view v_pedido_mas_caro as
	select * 
	from pedidos
	where cargo = (select max(cargo) from pedidos);
    
-- Selecciona el pedido que haya sido más barato que la media
create view v_pedido_mas_caro as
	select * 
	from pedidos
	where cargo < (select avg(cargo) from pedidos);

-- 4. Consulta que haga join de cuatro tablas.

-- Selecciona todos los datos de los empleados que hayan participado en ventas de Tallarines
create view v_empleados_tallarines as
select empleados.* from 
	empleados inner join pedidos on empleados.id = pedidos.empleado_id
			inner join detalles on detalles.pedido_id = pedidos.id 
            inner join productos on productos.id = detalles.producto_id
	where productos.producto like '%Tallarines%';