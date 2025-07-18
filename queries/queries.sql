-- Encuentra el cliente que ha realizado la mayor cantidad de alquileres en los últimos 6 meses.

SELECT c.nombre, COUNT(a.id_alquiler) AS total_alquileres
FROM cliente c
JOIN alquiler a ON c.id_cliente = a.id_cliente
ORDER BY total_alquileres DESC
LIMIT 1;

-- Lista las cinco películas más alquiladas durante el último año.

SELECT p.titulo, COUNT(a.id_alquiler) AS total_alquileres
FROM pelicula p
JOIN inventario i ON p.id_pelicula = i.id_pelicula
JOIN alquiler a ON i.id_inventario = a.id_inventario
ORDER BY total_alquileres DESC
LIMIT 5;

-- Obtén el total de ingresos y la cantidad de alquileres realizados por cada categoría de película.

SELECT c.nombre AS categoria, 
       COUNT(a.id_alquiler) AS total_alquileres, 
       SUM(pal.total) AS ingresos_totales
FROM categoria c
JOIN pelicula_categoria pc ON c.id_categoria = pc.id_categoria
JOIN pelicula p ON pc.id_pelicula = p.id_pelicula
JOIN inventario i ON p.id_pelicula = i.id_pelicula
JOIN alquiler a ON i.id_inventario = a.id_inventario
JOIN pago pal ON a.id_alquiler = pal.id_alquiler
GROUP BY c.id_categoria
ORDER BY ingresos_totales DESC;

-- Calcula el número total de clientes que han realizado alquileres por cada idioma disponible en un mes específico.

SELECT i.nombre AS idioma, 
       COUNT(DISTINCT c.id_cliente) AS total_clientes
FROM idioma i
JOIN pelicula p ON i.id_idioma = p.id_idioma
JOIN inventario inv ON p.id_pelicula = inv.id_pelicula
JOIN alquiler a ON inv.id_inventario = a.id_inventario
JOIN cliente c ON a.id_cliente = c.id_cliente
WHERE MONTH(a.fecha_alquiler) = 1 AND YEAR(a.fecha_alquiler) =
2023
GROUP BY i.id_idioma
ORDER BY total_clientes DESC;

-- Encuentra a los clientes que han alquilado todas las películas de una misma categoría.

SELECT c.nombre AS cliente, 
       c.apellidos AS apellidos, 
       cat.nombre AS categoria
FROM cliente c
JOIN alquiler a ON c.id_cliente = a.id_cliente
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
JOIN pelicula_categoria pc ON p.id_pelicula = pc.id_pelicula
JOIN categoria cat ON pc.id_categoria = cat.id_categoria
GROUP BY c.id_cliente, cat.id_categoria
HAVING COUNT(DISTINCT p.id_pelicula) = (
    SELECT COUNT(*)
    FROM pelicula_categoria pc2
    WHERE pc2.id_categoria = cat.id_categoria
)
ORDER BY c.nombre, c.apellidos, cat.nombre;

-- Lista las tres ciudades con más clientes activos en el último trimestre.

SELECT ci.nombre AS ciudad, 
       COUNT(DISTINCT cl.id_cliente) AS total_clientes
FROM ciudad ci
JOIN direccion d ON ci.id_ciudad = d.id_ciudad
JOIN cliente cl ON d.id_direccion = cl.id_direccion
WHERE cl.activo = 1 AND cl.ultima_actualizacion >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY ci.id_ciudad
ORDER BY total_clientes DESC
LIMIT 3;

-- Muestra las cinco categorías con menos alquileres registrados en el último año.

SELECT c.nombre AS categoria, 
       COUNT(a.id_alquiler) AS total_alquileres
FROM categoria c
JOIN pelicula_categoria pc ON c.id_categoria = pc.id_categoria
JOIN pelicula p ON pc.id_pelicula = p.id_pelicula

-- Calcula el promedio de días que un cliente tarda en devolver las películas alquiladas.

SELECT c.nombre AS cliente, 
       AVG(DATEDIFF(a.fecha_devolucion, a.fecha_alquiler)) AS promedio_dias_devolucion
FROM cliente c
JOIN alquiler a ON c.id_cliente = a.id_cliente
WHERE a.fecha_devolucion IS NOT NULL
GROUP BY c.id_cliente
ORDER BY promedio_dias_devolucion DESC;

-- Encuentra los cinco empleados que gestionaron más alquileres en la categoría de Acción.

SELECT e.nombre AS empleado, 
       COUNT(a.id_alquiler) AS total_alquileres
FROM empleado e
JOIN alquiler a ON e.id_empleado = a.id_empleado 
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
JOIN pelicula_categoria pc ON p.id_pelicula = pc.id_pelicula
JOIN categoria c ON pc.id_categoria = c.id_categoria
WHERE c.nombre = 'Acción'
GROUP BY e.id_empleado
ORDER BY total_alquileres DESC
LIMIT 5;

-- Genera un informe de los clientes con alquileres más recurrentes.

SELECT c.nombre AS cliente, 
       COUNT(a.id_alquiler) AS total_alquileres
FROM cliente c
JOIN alquiler a ON c.id_cliente = a.id_cliente
GROUP BY c.id_cliente
ORDER BY total_alquileres DESC
LIMIT 10;

-- Calcula el costo promedio de alquiler por idioma de las películas.

SELECT i.nombre AS idioma, 
       AVG(p.rental_rate) AS costo_promedio_alquiler
FROM idioma i
JOIN pelicula p ON i.id_idioma = p.id_idioma
GROUP BY i.id_idioma
ORDER BY costo_promedio_alquiler DESC;

-- Lista las cinco películas con mayor duración alquiladas en el último año.

SELECT p.titulo, 
       MAX(p.duracion) AS duracion_maxima
FROM pelicula p
JOIN inventario i ON p.id_pelicula = i.id_pelicula
JOIN alquiler a ON i.id_inventario = a.id_inventario
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY p.id_pelicula
ORDER BY duracion_maxima DESC
LIMIT 5;

-- Muestra los clientes que más alquilaron películas de Comedia.

SELECT c.nombre AS cliente, 
       COUNT(a.id_alquiler) AS total_alquileres
FROM cliente c
JOIN alquiler a ON c.id_cliente = a.id_cliente
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
JOIN pelicula_categoria pc ON p.id_pelicula = pc.id_pelicula
JOIN categoria cat ON pc.id_categoria = cat.id_categoria
WHERE cat.nombre = 'Comedia'
GROUP BY c.id_cliente
ORDER BY total_alquileres DESC
LIMIT 10;

-- Encuentra la cantidad total de días alquilados por cada cliente en el último mes.

SELECT c.nombre AS cliente, 
       SUM(DATEDIFF(a.fecha_devolucion, a.fecha_alquiler)) AS total_dias_alquilados
FROM cliente c
JOIN alquiler a ON c.id_cliente = a.id_cliente
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
AND a.fecha_devolucion IS NOT NULL
GROUP BY c.id_cliente
ORDER BY total_dias_alquilados DESC;

-- Muestra el número de alquileres diarios en cada almacén durante el último trimestre.

SELECT a.id_almacen, 
       DATE(a.fecha_alquiler) AS fecha, 
       COUNT(a.id_alquiler) AS total_alquileres
FROM alquiler a
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY a.id_almacen, DATE(a.fecha_alquiler)
ORDER BY a.id_almacen, fecha;

-- Calcula los ingresos totales generados por cada almacén en el último semestre.

SELECT a.id_almacen, 
       SUM(p.total) AS ingresos_totales
FROM alquiler al
JOIN pago p ON al.id_alquiler = p.id_alquiler
WHERE al.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY a.id_almacen
ORDER BY ingresos_totales DESC;

-- Encuentra el cliente que ha realizado el alquiler más caro en el último año.

SELECT c.nombre AS cliente, 
       MAX(p.total) AS alquiler_mas_caro
FROM cliente c
JOIN alquiler a ON c.id_cliente = a.id_cliente
JOIN pago p ON a.id_alquiler = p.id_alquiler
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY c.id_cliente
ORDER BY alquiler_mas_caro DESC
LIMIT 1;

-- Lista las cinco categorías con más ingresos generados durante los últimos tres meses.

SELECT c.nombre AS categoria, 
       SUM(p.total) AS ingresos_totales
FROM categoria c
JOIN pelicula_categoria pc ON c.id_categoria = pc.id_categoria
JOIN pelicula p ON pc.id_pelicula = p.id_pelicula
JOIN inventario i ON p.id_pelicula = i.id_pelicula
JOIN alquiler a ON i.id_inventario = a.id_inventario
JOIN pago p ON a.id_alquiler = p.id_alquiler
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY c.id_categoria
ORDER BY ingresos_totales DESC
LIMIT 5;

-- Obtén la cantidad de películas alquiladas por cada idioma en el último mes.

SELECT i.nombre AS idioma, 
       COUNT(a.id_alquiler) AS total_alquileres
FROM idioma i
JOIN pelicula p ON i.id_idioma = p.id_idioma
JOIN inventario inv ON p.id_pelicula = inv.id_pelicula
JOIN alquiler a ON inv.id_inventario = a.id_inventario
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY i.id_idioma
ORDER BY total_alquileres DESC;

-- Lista los clientes que no han realizado ningún alquiler en el último año.

SELECT c.nombre AS cliente, 
       c.apellidos AS apellidos
FROM cliente c
LEFT JOIN alquiler a ON c.id_cliente = a.id_cliente
WHERE a.id_alquiler IS NULL OR a.fecha_alquiler < DATE_SUB(CURDATE(),
INTERVAL 1 YEAR)
ORDER BY c.nombre, c.apellidos;
