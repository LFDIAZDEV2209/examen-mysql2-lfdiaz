-- TotalIngresosCliente(ClienteID, Año): Calcula los ingresos generados por un cliente en un año específico.

DELIMITER // 

CREATE FUNCTION TotalIngresosCliente(ClienteID SMALLINT UNSIGNED, Año YEAR)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(p.total) INTO total
    FROM pago p
    JOIN alquiler a ON p.id_alquiler = a.id_alquiler
    WHERE p.id_cliente = ClienteID AND YEAR(a.fecha_alquiler) = Año;
    
    RETURN IFNULL(total, 0);
END //

DELIMITER ;

-- PromedioDuracionAlquiler(PeliculaID): Retorna la duración promedio de alquiler de una película específica.

DELIMITER //

CREATE FUNCTION PromedioDuracionAlquiler(PeliculaID SMALLINT UNSIGNED)
RETURNS DECIMAL(5,2)
BEGIN
    DECLARE promedio DECIMAL(5,2);
    SELECT AVG(i.duracion_alquiler) INTO promedio
    FROM inventario i
    WHERE i.id_pelicula = PeliculaID;
    RETURN IFNULL(promedio, 0);
END //

DELIMITER ;

-- IngresosPorCategoria(CategoriaID): Calcula los ingresos totales generados por una categoría específica de películas.

DELIMITER //

CREATE FUNCTION IngresosPorCategoria(CategoriaID TINYINT UNSIGNED)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(pal.total) INTO total
    FROM pago pal
    JOIN alquiler a ON pal.id_alquiler = a.id_alquiler
    JOIN inventario i ON a.id_inventario = i.id_inventario
    JOIN pelicula p ON i.id_pelicula = p.id_pelicula
    JOIN pelicula_categoria pc ON p.id_pelicula = pc.id_pelicula
    WHERE pc.id_categoria = CategoriaID;
    RETURN IFNULL(total, 0);
END //

DELIMITER ;

-- DescuentoFrecuenciaCliente(ClienteID): Calcula un descuento basado en la frecuencia de alquiler del cliente.

DELIMITER //

CREATE FUNCTION DescuentoFrecuenciaCliente(ClienteID SMALLINT UNSIGNED)
RETURNS DECIMAL(5,2)
BEGIN
    DECLARE descuento DECIMAL(5,2);
    DECLARE total_alquileres INT;
    SELECT COUNT(*) INTO total_alquileres
    FROM alquiler a
    WHERE a.id_cliente = ClienteID;
    IF total_alquileres >= 10 THEN
        SET descuento = 0.10; 
    ELSEIF total_alquileres >= 5 THEN
        SET descuento = 0.05;
    ELSE
        SET descuento = 0.00;
    END IF;
    RETURN descuento;
END //

DELIMITER ;

-- EsClienteVIP(ClienteID): Verifica si un cliente es "VIP" basándose en la cantidad de alquileres realizados y los ingresos generados.

DELIMITER //

CREATE FUNCTION EsClienteVIP(ClienteID SMALLINT UNSIGNED)
RETURNS BOOLEAN
BEGIN
    DECLARE total_alquileres INT;
    DECLARE total_ingresos DECIMAL(10,2);
    SELECT COUNT(*) INTO total_alquileres
    FROM alquiler a
    WHERE a.id_cliente = ClienteID;
    SELECT SUM(p.total) INTO total_ingresos
    FROM pago p
    WHERE p.id_cliente = ClienteID;
    RETURN (total_alquileres >= 20 AND total_ingresos >= 500.
END //

DELIMITER ;