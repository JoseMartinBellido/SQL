use bd_neptuno2;

-- 1. Mostrar el nombre del producto y el nombre de la categoría de todos los productos que contengan la letra Q en el nombre.
select productos.producto, categorias.categoria
	from productos inner join categorias on productos.categoria_id = categorias.id
    where upper(productos.producto) like '%Q%';

-- 2. Mostrar el número de pedido y el país del cliente de los pedidos de mayo del año 1997.
select pedidos.id as ID_Pedido, clientes.pais as PaisCliente
	from pedidos inner join clientes on pedidos.cliente_id = clientes.id
    where monthname(pedidos.fecha_pedido) = 'May' and year(pedidos.fecha_pedido) = '1997'; 
	-- where fecha_pedido between '1997-05-01' and '1997-05-31';

-- 3. Mostrar fecha del pedido, cantidad y el nombre producto, y el código del pedido para los códigos de pedido 10285 o 10298.
select pedidos.fecha_pedido, detalles.cantidad, productos.producto, pedidos.id
	from pedidos inner join detalles on pedidos.id = detalles.pedido_id
				inner join productos on detalles.producto_id = productos.id
	where detalles.pedido_id in (10285, 10298);

-- 4. Mostrar el importe total (cantidad x precio x descuento en tanto por 1) de los pedidos 10285 y 10298 usando únicamente la tabla detalles. 
-- Verifica el resultado mostrando el detalle para cada pedido en otra consulta.
select sum(cantidad * precio_unidad * (1 - descuento)) as ImporteTotal
	from detalles 
	where pedido_id in (10285, 10298)
    group by pedido_id;
    
select pedidos.id, sum(detalles.cantidad * detalles.precio_unidad * (1 - detalles.descuento)) as ImporteTotal 
	from pedidos inner join detalles on pedidos.id = detalles.pedido_id
    group by pedidos.id
	having ImporteTotal in (1743.3600, 2645.0000);
    
-- 5. ¿Cuánto se factura cada mes? Mostrar el año, el mes y el total. ************
select monthname(fecha_pedido) as Mes, year(fecha_pedido) as Anio, sum(detalles.cantidad * detalles.precio_unidad * (1 - detalles.descuento)) as ImporteTotal
	from pedidos inner join detalles on pedidos.id = detalles.pedido_id
    group by Anio, Mes;
    
-- 6. Los pedidos que hizo la empleada Nancy.
select empleados.nombre as NombreEmpleado, clientes.id as NombreCliente, pedidos.id as ID_Pedido
	from empleados inner join pedidos on pedidos.empleado_id = empleados.id
					inner join clientes on clientes.id = pedidos.cliente_id
	where pedidos.empleado_id = pedidos.cliente_id and empleados.nombre = 'Nancy';

-- 7. Mostrar los pedidos de Anton (código cliente). 
select clientes.codigo, pedidos.* from
	pedidos inner join clientes on pedidos.cliente_id = clientes.id
    where clientes.codigo = 'Anton';

-- 8. Cuántos productos hay de cada categoría y el precio medio.
select categorias.id as IdCategoria, categorias.categoria, count(*) as NumeroProductos, avg(productos.precio_unidad) as Media
	from productos inner join categorias on productos.categoria_id  = categorias.id
    group by categorias.id;

-- 9. Mostrar los pedidos que tienen productos en la categoría 2 o 3.
select pedidos.id as IDPedido, detalles.producto_id as IDProducto
	from pedidos inner join detalles on pedidos.id = detalles.pedido_id
    where detalles.producto_id in (2,3);
    
select distinct pedidos.id as IDPedido
	from pedidos inner join detalles on pedidos.id = detalles.pedido_id
    where detalles.producto_id in (2,3);    
    
-- 10. Clientes que pidieron queso en julio de 1996.
select clientes.id
	from clientes inner join pedidos on clientes.id = pedidos.cliente_id
					inner join detalles on pedidos.id = detalles.pedido_id
                    inner join productos on productos.id = detalles.producto_id
    where monthname(fecha_pedido) = 'Julio' and year(fecha_pedido) = '1996' and productos.producto like '%queso%';
    
    select clientes.id
	from clientes inner join pedidos on clientes.id = pedidos.cliente_id
					inner join detalles on pedidos.id = detalles.pedido_id
                    inner join productos on productos.id = detalles.producto_id
    where fecha_pedido between '1996-07-01' and '1996-07-31' 
		and productos.producto like '%queso%';
