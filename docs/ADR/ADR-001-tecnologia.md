# ADR-001: Selección del lenguaje de programación del servidor

**Estado:** Aceptado  
**Fecha:** Junio 2026  
**Proyecto:** BIOPET - Sistema Integral de Gestión Veterinaria  

---

## Contexto

El equipo necesita elegir el lenguaje del lado del servidor para implementar BIOPET. Las restricciones consideradas son:

- Tiempo limitado a un semestre académico
- Conocimiento previo del equipo en C#/.NET
- Integración con base de datos PostgreSQL
- Soporte para alta concurrencia requerida por telemetría IoT
- Soporte para contenedores (Docker)

---

## Opciones consideradas

| Opción | Descripción |
|---|---|
| Opción A | PHP 8.2 con Laravel 11 |
| Opción B | ASP.NET Core 8 |
| Opción C | PHP 8.2 sin framework |

---

## Decisión

Se selecciona **ASP.NET Core 8**.

Ofrece rendimiento superior para APIs REST, manejo asíncrono nativo (`async/await`) y tipado estático. A diferencia de Laravel, el equipo posee conocimiento previo en C#, lo que reduce la curva de aprendizaje. PHP sin framework fue descartado por carecer de estructura mantenible.

---

## Consecuencias positivas

- Alto rendimiento en operaciones concurrentes
- Tipado estático que facilita detección temprana de errores
- Integración nativa con Entity Framework Core
- Soporte incorporado para autenticación JWT

## Consecuencias negativas

- Requiere entorno de despliegue compatible (.NET 8 runtime), lo que puede limitar opciones de hosting gratuito
- La curva de aprendizaje se mitigará con revisión de código entre el equipo y consulta de documentación oficial de Microsoft
