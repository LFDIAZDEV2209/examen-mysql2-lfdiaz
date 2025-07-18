-- ActualizarTotalAlquileresEmpleado: Al registrar un alquiler, actualiza el total de alquileres gestionados por el empleado correspondiente.

DELIMITER //

CREATE TRIGGER ActualizarTotalAlquileresEmpleado
AFTER INSERT ON alquiler
FOR EACH ROW
BEGIN
    UPDATE empleado
    SET total_alquileres = total_alquileres + 1
    WHERE id_empleado = NEW.id_empleado;
END //

DELIMITER ;

-- AuditarActualizacionCliente: Cada vez que se modifica un cliente, registra el cambio en una tabla de auditoría.

CREATE TABLE auditoria_cliente (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente SMALLINT UNSIGNED,
    accion VARCHAR(50),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

DELIMITER //

CREATE TRIGGER AuditarActualizacionCliente
AFTER UPDATE ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_cliente (id_cliente, accion)
    VALUES (NEW.id_cliente, CONCAT('Actualizado: ', OLD.nombre, ' a ',
    NEW.nombre));
END //

DELIMITER ;

-- RegistrarHistorialDeCosto: Guarda el historial de cambios en los costos de alquiler de las películas.

CREATE TABLE historial_costo (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_pelicula SMALLINT UNSIGNED,
    costo_anterior DECIMAL(5,2),
    costo_nuevo DECIMAL(5,2),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula)
);

DELIMITER //

CREATE TRIGGER RegistrarHistorialDeCosto
AFTER UPDATE ON pelicula
FOR EACH ROW
BEGIN
    IF OLD.rental_rate <> NEW.rental_rate THEN
        INSERT INTO historial_costo (id_pelicula, costo_anterior, costo_nuevo
        )
        VALUES (NEW.id_pelicula, OLD.rental_rate, NEW.rental_rate);
    END IF;
END //

DELIMITER ;

-- NotificarEliminacionAlquiler: Registra una notificación cuando se elimina un registro de alquiler.

CREATE TABLE notificacion_eliminacion (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_alquiler INT,
    mensaje VARCHAR(255),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_alquiler) REFERENCES alquiler(id_alquiler)
);

DELIMITER //

CREATE TRIGGER NotificarEliminacionAlquiler
AFTER DELETE ON alquiler
FOR EACH ROW
BEGIN
    INSERT INTO notificacion_eliminacion (id_alquiler, mensaje)
    VALUES (OLD.id_alquiler, CONCAT('Alquiler con ID ', OLD.id_alquiler
    , ' eliminado.'));
END //

DELIMITER ;

-- RestringirAlquilerConSaldoPendiente: Evita que un cliente con saldo pendiente pueda realizar nuevos alquileres.

DELIMITER //

CREATE TRIGGER RestringirAlquilerConSaldoPendiente
BEFORE INSERT ON alquiler
FOR EACH ROW
BEGIN
    DECLARE saldo_pendiente DECIMAL(5,2);
    SELECT SUM(total) INTO saldo_pendiente
    FROM pago
    WHERE id_cliente = NEW.id_cliente
    AND fecha_pago IS NULL;
    IF saldo_pendiente > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente tiene saldo pendiente y no puede realizar nuevos alquileres.';
    END IF;
END //

DELIMITER ;