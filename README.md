# Examen MySQL 2 - LFDIAZDEV2209

Repositorio correspondiente al **Examen de Base de Datos MySQL 2**, centrado en el diseño, consulta y manipulación de una base de datos para un sistema de alquiler de películas.  
Contiene consultas, funciones, triggers, eventos y estructuras SQL, organizadas y documentadas.

## 📘 Descripción del Proyecto

Este proyecto tiene como propósito demostrar habilidades avanzadas en el uso de **MySQL** mediante la creación de un sistema de gestión de alquiler de películas.  
Se implementan consultas analíticas, funciones personalizadas, triggers automatizados y eventos programados para resolver distintos requerimientos de negocio.

El sistema cubre funcionalidades como:

- Consultas analíticas sobre clientes, ingresos, idiomas, películas y categorías.
- Triggers para auditoría, control y actualización de métricas clave.
- Funciones para cálculo de ingresos, descuentos, y clientes VIP.
- Eventos automatizados de mantenimiento y generación de reportes.

---

## ⚙️ Requisitos del Sistema

Para ejecutar correctamente los scripts, se recomienda el siguiente entorno:

- **MySQL Server**: versión 8.0 o superior
- **MySQL Workbench** (opcional): versión reciente
- Cliente de línea de comandos MySQL o gestor SQL compatible

---
```
examen-mysql2-lfdiaz/
│
├── ddl.sql                  # Estructura de la base de datos
├── dml.sql                  # Inserciones de datos 
├── dql_select.sql           # Consultas SQL
├── dql_funciones.sql        # Funciones definidas por el usuario
├── dql_triggers.sql         # Triggers implementados
├── dql_eventos.sql          # Eventos programados 
├── Diagrama.jpg             # Modelo entidad-relación
└── README.md                # Documentación del proyecto
```


---

## 🧪 Funcionalidades Clave

### 🔍 Consultas SQL

- 📈 Cliente con más alquileres en 6 meses  
- 🎞️ Películas más alquiladas del año  
- 💰 Ingresos y alquileres por categoría  
- 🌍 Alquileres por idioma, ciudad y fecha  
- 🎬 Clientes que alquilaron todas las películas de una categoría  
- 📊 Promedios, máximos y totales por entidad  

### 🧮 Funciones Definidas

- `TotalIngresosCliente` – Total de ingresos por cliente  
- `PromedioDuracionAlquiler` – Duración promedio de los alquileres  
- `IngresosPorCategoria` – Ingresos generados por categoría  
- `DescuentoFrecuenciaCliente` – Descuentos basados en frecuencia de alquiler  
- `EsClienteVIP` – Determina si un cliente es VIP según sus hábitos de alquiler  

### ⚙️ Triggers

- `ActualizarTotalAlquileresEmpleado` – Mantiene el total de alquileres por empleado  
- `AuditarActualizacionCliente` – Audita cambios en los datos del cliente  
- `RegistrarHistorialDeCosto` – Guarda historial de cambios en el costo de películas  
- `NotificarEliminacionAlquiler` – Registro o alerta ante eliminación de un alquiler  
- `RestringirAlquilerConSaldoPendiente` – Impide nuevos alquileres si hay deuda  

### ⏰ Eventos Programados (Opcional)

- `InformeAlquileresMensual` – Genera informe automático de alquileres cada mes  
- `ActualizarSaldoPendienteCliente` – Recalcula saldos de clientes periódicamente  
- `AlertaPeliculasNoAlquiladas` – Detecta películas sin alquileres recientes  
- `LimpiarAuditoriaCada6Meses` – Limpia tablas de auditoría antiguas  
- `ActualizarCategoriasPopulares` – Refresca estadísticas de categorías más vistas  

---

## 👨‍💻 Autor

**Luis Felipe Díaz**  
GitHub: [LFDIAZDEV2209](https://github.com/LFDIAZDEV2209)

---

## 🔐 Repositorio Público

Este repositorio es público. Asegúrate de compartir acceso con el trainer/profesor correspondiente para la revisión del examen.

---

## 📎 Consideraciones Finales

- Todos los scripts están comentados para facilitar su comprensión.  
- Las funciones y triggers fueron probados en entornos locales MySQL.  
- **Ejecutar los archivos en orden** (`ddl.sql` → `dml.sql` → demás scripts) para evitar errores de integridad referencial.  
- En caso de incluir el modelo entidad-relación, revisar el archivo `Diagrama.jpg`.

---

> 📝 **Nota:** Este proyecto fue desarrollado como parte de un examen práctico para validar conocimientos en SQL avanzado y administración de bases de datos en MySQL.

