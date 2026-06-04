CREATE TYPE "tipo_rol" AS ENUM ( 
'Administrador', 
'Veterinario', 
'Auxiliar', 
'Dueno', 
'Personal Administrativo' 
); 
CREATE TYPE "estado_cita" AS ENUM ( 
'Programada', 
'Completada', 
'Cancelada' 
); 
CREATE TYPE "estado_chat" AS ENUM ( 
'Activo', 
'Cerrado' 
); 
CREATE TYPE "remitente_chat" AS ENUM ( 
'Dueno', 
'IA' 
); 
CREATE TYPE "tipo_producto" AS ENUM ( 
'Bien_Fisico', 
'Servicio' 
); 
CREATE TYPE "estado_sri" AS ENUM ( 
'Creada', 
'Recibida', 
'Autorizada', 
'Rechazada' 
); 
CREATE TYPE "metodo_pago" AS ENUM ( 
'Tarjeta', 
'Transferencia', 
'Efectivo' 
); 
CREATE TYPE "ambiente" AS ENUM ( 
'Pruebas', 
'Produccion' 
); 
CREATE TABLE IF NOT EXISTS "Usuario" ( 
"id_usuario" INTEGER NOT NULL, 
"cedula" VARCHAR(13) NOT NULL, 
"nombre_completo" VARCHAR(100) NOT NULL, 
"email" VARCHAR(100) NOT NULL, 
"telefono" VARCHAR(15) NOT NULL, 
"direccion" VARCHAR(200) NOT NULL, --  --  
"rol" tipo_rol NOT NULL, 
PRIMARY KEY("id_usuario") 
); 
CREATE TABLE IF NOT EXISTS "Mascota" ( 
"id_mascota" INTEGER NOT NULL, 
"id_duenio" INTEGER NOT NULL, 
"nombre" VARCHAR(50) NOT NULL, 
"especie" VARCHAR(30) NOT NULL, 
"raza" VARCHAR(50) NOT NULL, 
"fecha_nacimiento" DATE NOT NULL, 
PRIMARY KEY("id_mascota") 
); 
 
CREATE TABLE IF NOT EXISTS "Cita" ( 
 "id_cita" INTEGER NOT NULL, 
 "id_mascota" INTEGER NOT NULL, 
 "id_veterinario" INTEGER NOT NULL, 
 "fecha_hora" TIMESTAMP NOT NULL, 
 "motivo" VARCHAR(200) NOT NULL, 
 "estado" estado_cita NOT NULL, 
 PRIMARY KEY("id_cita") 
); 
 
 
 
 
CREATE TABLE IF NOT EXISTS "Historial_Clinico" ( 
 "id_historial" INTEGER NOT NULL, 
 "id_mascota" INTEGER NOT NULL, 
 "id_cita" INTEGER NOT NULL, 
 "fecha_registro" TIMESTAMP NOT NULL, 
 "diagnostico_manual" TEXT NOT NULL, 
 "tratamiento" TEXT NOT NULL, 
 PRIMARY KEY("id_historial") 
); 
 
 
 
 
CREATE TABLE IF NOT EXISTS "Dispositivo_IoT" ( 
 "id_dispositivo" INTEGER NOT NULL, 
 "id_mascota" INTEGER NOT NULL UNIQUE, 
 "codigo_mac" VARCHAR(50) NOT NULL, 
 "ultima_latitud" NUMERIC(10,8) NOT NULL, 
 "ultima_longitud" NUMERIC(10,8) NOT NULL, 
 "fecha_ultima_ubicacion" TIMESTAMP NOT NULL, 
 PRIMARY KEY("id_dispositivo") 
); 
 
 
 
 
CREATE TABLE IF NOT EXISTS "Chat_Triage" ( 
 "id_chat" INTEGER NOT NULL, 
 "id_mascota" INTEGER NOT NULL UNIQUE, 
 "fecha_inicio" TIMESTAMP NOT NULL, 
 "estado" estado_chat NOT NULL, 
 "id_veterinario" INTEGER NOT NULL, 
 PRIMARY KEY("id_chat") 
); 
 
 
 
 
CREATE TABLE IF NOT EXISTS "Mensaje_Chat" ( 
 "id_mensaje" INTEGER NOT NULL, 
 "id_chat" INTEGER NOT NULL, 
 "remitente" remitente_chat NOT NULL, 
 "contenido" TEXT NOT NULL, 
 "url_imagen" VARCHAR(255) NOT NULL, 
 "contiene_advertencia" BOOLEAN NOT NULL, 
 "fecha_hora" TIMESTAMP NOT NULL, 
 PRIMARY KEY("id_mensaje") 
); 
 
 
 
 
CREATE TABLE IF NOT EXISTS "Producto_Servicio" ( 
 "id_producto" INTEGER NOT NULL, 
 "codigo_principal" VARCHAR(25) NOT NULL, 
 "nombre" VARCHAR(100) NOT NULL, 
 "tipo" tipo_producto NOT NULL, 
 "precio_unitario" NUMERIC(10,2) NOT NULL, 
 "grava_iva" BOOLEAN NOT NULL, 
 "stock" INTEGER NOT NULL, 
 PRIMARY KEY("id_producto") 
); 
 
 
 
 
CREATE TABLE IF NOT EXISTS "Factura" ( 
 "id_factura" INTEGER NOT NULL, 
 "id_cliente" INTEGER NOT NULL, 
 "secuencial_factura" VARCHAR(17) NOT NULL, 
 "clave_acceso_sri" VARCHAR(49) NOT NULL, 
 "estado_sri" estado_sri NOT NULL, 
 "fecha_emision" TIMESTAMP NOT NULL, 
 "subtotal" NUMERIC(10,2) NOT NULL, 
 "total_iva" NUMERIC(10,2) NOT NULL, 
 "total" NUMERIC(10,2) NOT NULL, 
 "metodo_pago" metodo_pago NOT NULL, 
 "id_transaccion_pasarela" VARCHAR(100) NOT NULL, 
 "numero_autorizacion" VARCHAR(49) NOT NULL, 
 "fecha_autorizacion" TIMESTAMP NOT NULL, 
 "ambiente" AMBIENTE NOT NULL, 
 "ruc_cliente" VARCHAR(13) NOT NULL, 
 "razon_social" VARCHAR(100) NOT NULL, 
 "direccion_cliente" VARCHAR(200) NOT NULL, 
 "ruc_emisor" VARCHAR(100) NOT NULL, 
 PRIMARY KEY("id_factura") 
); 
 
 
 
 
CREATE TABLE IF NOT EXISTS "Detalle_Factura" ( 
 "id_detalle" INTEGER NOT NULL, 
 "id_factura" INTEGER NOT NULL, 
 "id_producto" INTEGER NOT NULL, 
 "id_cita" INTEGER NOT NULL, 
 "cantidad" INTEGER NOT NULL, 
 "precio_unitario" NUMERIC(10,2) NOT NULL, 
 "subtotal_linea" NUMERIC(10,2) NOT NULL, 
 PRIMARY KEY("id_detalle") 
); 
 
 
 
 
CREATE TABLE IF NOT EXISTS "Proveedor" ( 
 "id_proveedor" INTEGER NOT NULL, 
 "ruc" VARCHAR(13) NOT NULL, 
 "razon_social" VARCHAR(100) NOT NULL, 
 "telefono" VARCHAR(15) NOT NULL, 
"correo" VARCHAR(100) NOT NULL, 
PRIMARY KEY("id_proveedor") 
); 
CREATE TABLE IF NOT EXISTS "Mercaderia" ( 
"id_ingreso" INTEGER NOT NULL, 
"id_proveedor" INTEGER NOT NULL, 
"numero_comprobante" VARCHAR(50) NOT NULL, 
"fecha_ingreso" TIMESTAMP NOT NULL, 
"total_pagado" NUMERIC(10,2) NOT NULL, 
PRIMARY KEY("id_ingreso") 
); 
CREATE TABLE IF NOT EXISTS "Detalle_Ingreso" ( 
"id_detalle_ingreso" INTEGER NOT NULL, 
"id_ingreso" INTEGER NOT NULL, 
"id_producto" INTEGER NOT NULL, 
"cantidad" INTEGER NOT NULL, 
"costo_unitario" NUMERIC(10,2) NOT NULL, 
"subtotal" NUMERIC(10,2) NOT NULL, 
PRIMARY KEY("id_detalle_ingreso") 
); 
ALTER TABLE "Mascota" 
ADD FOREIGN KEY("id_duenio") REFERENCES "Usuario"("id_usuario") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Cita" 
ADD FOREIGN KEY("id_mascota") REFERENCES "Mascota"("id_mascota") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Cita" 
ADD FOREIGN KEY("id_veterinario") REFERENCES "Usuario"("id_usuario") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Historial_Clinico" 
ADD FOREIGN KEY("id_mascota") REFERENCES "Mascota"("id_mascota") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Historial_Clinico" 
ADD FOREIGN KEY("id_cita") REFERENCES "Cita"("id_cita") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Dispositivo_IoT" 
ADD FOREIGN KEY("id_mascota") REFERENCES "Mascota"("id_mascota") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Chat_Triage" 
ADD FOREIGN KEY("id_mascota") REFERENCES "Mascota"("id_mascota") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Mensaje_Chat" 
ADD FOREIGN KEY("id_chat") REFERENCES "Chat_Triage"("id_chat") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Factura" 
ADD FOREIGN KEY("id_cliente") REFERENCES "Usuario"("id_usuario") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Detalle_Factura" 
ADD FOREIGN KEY("id_factura") REFERENCES "Factura"("id_factura") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Detalle_Factura" 
ADD FOREIGN KEY("id_producto") REFERENCES "Producto_Servicio"("id_producto") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Detalle_Factura" 
ADD FOREIGN KEY("id_cita") REFERENCES "Cita"("id_cita") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Mercaderia" 
ADD FOREIGN KEY("id_proveedor") REFERENCES "Proveedor"("id_proveedor") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Detalle_Ingreso" 
ADD FOREIGN KEY("id_ingreso") REFERENCES "Mercaderia"("id_ingreso") 
ON UPDATE NO ACTION ON DELETE NO ACTION; 
ALTER TABLE "Detalle_Ingreso" 
ADD FOREIGN KEY("id_producto") REFERENCES "Producto_Servicio"("id_producto") 
ON UPDATE NO ACTION ON DELETE NO ACTION;
