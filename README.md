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

examen-mysql2-lfdiaz/
│
├── ddl.sql                  # Estructura de la base de datos
├── dml.sql                  # Inserciones de datos (si aplica)
├── dql_select.sql           # Consultas SQL
├── dql_funciones.sql        # Funciones definidas por el usuario
├── dql_triggers.sql         # Triggers implementados
├── dql_eventos.sql          # Eventos programados (opcional)
├── Diagrama.jpg             # Modelo entidad-relación (opcional)
└── README.md                # Documentación del proyecto

🧪 Funcionalidades Clave
Consultas SQL
Cliente con más alquileres en 6 meses

Películas más alquiladas del año

Ingresos y alquileres por categoría

Alquileres por idioma, ciudad, fecha

Clientes que alquilaron todas las películas de una categoría

Promedios, máximos, y totales por entidad

Funciones
TotalIngresosCliente

PromedioDuracionAlquiler

IngresosPorCategoria

DescuentoFrecuenciaCliente

EsClienteVIP

Triggers
ActualizarTotalAlquileresEmpleado

AuditarActualizacionCliente

RegistrarHistorialDeCosto

NotificarEliminacionAlquiler

RestringirAlquilerConSaldoPendiente

Eventos
InformeAlquileresMensual

ActualizarSaldoPendienteCliente

AlertaPeliculasNoAlquiladas

LimpiarAuditoriaCada6Meses

ActualizarCategoriasPopulares

👨‍💻 Autor
Luis Felipe Díaz
GitHub: LFDIAZDEV2209

🔐 Repositorio Publico
Este repositorio es publico. Asegúrate de compartir acceso con el trainer/profesor correspondiente para revisión del examen.

📎 Consideraciones Finales
Todos los scripts están comentados para facilitar su comprensión.

Las funciones y triggers fueron probados en entornos locales MySQL.

Asegúrate de ejecutar los archivos en orden para evitar errores de integridad referencial.