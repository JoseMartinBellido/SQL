use bd_neptuno2;

-- 1. Obtener la región a la que pertenecen los proveedores y el id del proveedor de los productos cuya categoría es 5 o 6. 
-- Si es null, debe indicarse: 'No informado'

select coalesce(proveedores.region, 'No informado') as RegionProveedor, proveedores.id, 
		productos.producto as Producto, productos.categoria_id as IDCategoria
	from proveedores inner join productos on proveedores.id = productos.proveedor_id
    where productos.categoria_id in (5,6);
    
    
-- 2. Obtener la región a la que pertenecen los proveedores y el id del proveedor de los productos cuya categoría es 5 o 6. 
-- Si es null, no debe salir en la consulta

select proveedores.region as RegionProveedor, proveedores.id, 
		productos.producto as Producto, productos.categoria_id as IDCategoria
	from proveedores inner join productos on proveedores.id = productos.proveedor_id
    where productos.categoria_id in (5,6) and !isnull(proveedores.region);

-- 3. Obtener los envíos y las empresas del envío de los productos cuyo nombre no tenga más de 10 letras

select pedidos.id as IDEnvio, productos.id as IDProducto, productos.producto
	from productos inner join detalles on productos.id = detalles.producto_id
					inner join pedidos on detalles.pedido_id = pedidos.id
    where length(productos.producto) <= 10;
    
-- 4. Si quisieras realizar un pedido de 1 artículo de cada producto y de la misma categoría, ¿cuál sería el precio final?
-- Indica el nombre de la categoría y el importe total del pedido por cada categoría redondeado a la baja.

select categorias.categoria, floor(sum(productos.precio_unidad)) as ImporteTotal
	from categorias inner join productos on categorias.id = productos.categoria_id
    group by productos.categoria_id;
    
-- 5. Si quisieras realizar un pedido de 1 artículo de cada producto y de la misma categoría, ¿cuál sería el precio final?
-- Indica el nombre de la categoría y el importe total del pedido por cada categoría con la moneda correspondiente (€).

select categorias.categoria, concat(sum(productos.precio_unidad),'€') as ImporteTotal
	from categorias inner join productos on categorias.id = productos.categoria_id
    group by productos.categoria_id;
    
-- 6. Indica el id de los pedidos, y el nombre y apellidos del empleado que lo realizó, cuya fecha de pedido 
-- no se encuentre a más de 1 mes de diferencia desde el 30 de Julio de 1996

select pedidos.id, empleados.nombre, empleados.apellidos, pedidos.fecha_pedido
	from empleados inner join pedidos on empleados.id = pedidos.empleado_id
	where pedidos.fecha_pedido between '1996-06-30' and '1996-08-30';
    
    
-- -----------------

use classicmodels;

select orderNumber, date_format('%a &d/%m/%Y') as fechaPedidos
	from orders;
    
