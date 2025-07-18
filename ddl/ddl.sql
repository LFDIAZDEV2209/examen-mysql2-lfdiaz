CREATE DATABASE examen_mysql2;
USE examen_mysql2;

CREATE TABLE idioma (
    id_idioma TINYINT UNSIGNED PRIMARY KEY,
    nombre CHAR(20),
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE film_text (
    film_id SMALLINT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT
);

CREATE TABLE actor (
    id_actor SMALLINT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE categoria (
    id_categoria TINYINT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(25),
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE pais (
    id_pais SMALLINT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(50),
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ciudad (
    id_ciudad SMALLINT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(50),
    id_pais SMALLINT UNSIGNED,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

CREATE TABLE direccion (
    id_direccion SMALLINT UNSIGNED PRIMARY KEY,
    direccion VARCHAR(50),
    direccion2 VARCHAR(50),
    distrito VARCHAR(20),
    id_pais SMALLINT UNSIGNED,
    codigo_postal VARCHAR(10),
    telefono VARCHAR(20),
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

CREATE TABLE almacen (
    id_almacen TINYINT UNSIGNED PRIMARY KEY,
    id_direccion SMALLINT UNSIGNED,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE empleado (
    id_empleado TINYINT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    id_direccion SMALLINT UNSIGNED,
    imagen blob,
    email VARCHAR(50),
    activo TINYINT(1),
    username VARCHAR(16),
    password VARCHAR(40),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE empleado_almacen (
    id_empleado TINYINT UNSIGNED,
    id_almacen TINYINT UNSIGNED,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_empleado, id_almacen),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

CREATE TABLE cliente (
    id_cliente SMALLINT UNSIGNED PRIMARY KEY,
    id_almacen TINYINT UNSIGNED,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    email VARCHAR(50),
    id_direccion SMALLINT UNSIGNED,
    activo TINYINT(1),
    fecha_creacion DATETIME,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE inventario (
    id_inventario MEDIUMINT UNSIGNED PRIMARY KEY,
    id_pelicula SMALLINT UNSIGNED,
    id_almacen TINYINT UNSIGNED,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

CREATE TABLE alquiler (
    id_alquiler INT PRIMARY KEY,
    fecha_alquiler DATETIME,
    id_inventario MEDIUMINT UNSIGNED,
    id_cliente SMALLINT UNSIGNED,
    fecha_devolucion DATETIME,
    id_empleado TINYINT UNSIGNED,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE pago (
    id_pago SMALLINT UNSIGNED PRIMARY KEY,
    id_cliente SMALLINT UNSIGNED,
    id_empleado TINYINT UNSIGNED,
    id_alquiler INT,
    fecha_pago DATETIME,
    total DECIMAL(5,2),
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_alquiler) REFERENCES alquiler(id_alquiler)
);

CREATE TABLE pelicula (
    id_pelicula SMALLINT UNSIGNED PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion TEXT,
    anyo_lanzamiento YEAR,
    id_idioma TINYINT UNSIGNED,
    id_idioma_original TINYINT UNSIGNED,
    duracion_alquiler TINYINT UNSIGNED,
    rental_rate DECIMAL(4,2),
    duracion SMALLINT UNSIGNED,
    replacement_cost DECIMAL(5,2),
    classificacion ENUM('G', 'PG', 'PG-13', 'R', 'NC-17'),
    caracteristicas_especiales set('Trailers', 'Commentaries', 'Deleted Scenes', 'Behind the Scenes'),
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_idioma) REFERENCES idioma(id_idioma),
    FOREIGN KEY (id_idioma_original) REFERENCES idioma(id_idioma)
);

CREATE TABLE pelicula_categoria (
    id_pelicula SMALLINT UNSIGNED,
    id_categoria TINYINT UNSIGNED,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_pelicula, id_categoria),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE pelicula_actor (
    id_actor SMALLINT UNSIGNED,
    id_pelicula SMALLINT UNSIGNED,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_actor, id_pelicula),
    FOREIGN KEY (id_actor) REFERENCES actor(id_actor),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula)
);







