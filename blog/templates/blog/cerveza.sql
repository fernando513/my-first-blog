/*
Empresa        :  Cervecita.cl
Software       :  Sistema de Ventas
DBMS           :  MySQL
Esquema        :  ventas
Sitio Web      :  www.cervecita.cl
*/



-- =============================================
-- Creación de la Base de Datos
-- =============================================

DROP DATABASE IF EXISTS VENTAS;

CREATE DATABASE VENTAS;


-- =============================================
-- Seleccionar la Base de Datos
-- =============================================

USE VENTAS;
SET NAMES 'utf8';


-- =============================================
-- CREACION DE TABLAS DE EMPLEADOS
-- =============================================

CREATE TABLE EMPLEADO
(
       idemp                INTEGER AUTO_INCREMENT COMMENT 'Identificador del empleado.',
       nombre               VARCHAR(50) NOT NULL COMMENT 'Nombre del empleado.',
       apellido             VARCHAR(50) NOT NULL COMMENT 'Apellido del empleado.',
       email                VARCHAR(50) NOT NULL COMMENT 'Email del empleado.',
       telefono             VARCHAR(20) NULL COMMENT 'Teléfono del empleado.',
       PRIMARY KEY (idemp)
) COMMENT='Tabla de empleados.';


INSERT INTO EMPLEADO(IDEMP,NOMBRE,APELLIDO,EMAIL,TELEFONO) 
VALUES(1001,'FERNANDO','GALARCE','fernando@gmail.com',NULL);

INSERT INTO EMPLEADO(IDEMP,NOMBRE,APELLIDO,EMAIL,TELEFONO)  
VALUES(1002,'SEBASTIAN','OLAVE','sebatian@gmail.com','967345634');


-- =============================================
-- CREACION DE TABLAS DEL USUARIOS
-- =============================================

CREATE TABLE USUARIO
(
       idemp                INTEGER NOT NULL COMMENT 'Identificador del empleado.',
       usuario              VARCHAR(20) NOT NULL COMMENT 'Cuenta de usuario asociado al empleado.',
       clave                VARCHAR(40) NOT NULL COMMENT 'Clave del usuario.',
       estado               NUMERIC(2,0) NOT NULL COMMENT 'Estado del usuario: 1 - Activo 0 - Inactivo',
       PRIMARY KEY (idemp),
  CONSTRAINT CHK_USUARIO_ESTADO CHECK ( estado IN (1, 0) ),
       FOREIGN KEY fk_usuario_empleado (idemp) REFERENCES EMPLEADO (idemp)
) COMMENT='Tabla de usuarios.';

INSERT INTO USUARIO(IDEMP, USUARIO, CLAVE, ESTADO)
VALUES(1002,'atorres',SHA('suerte'),1);

INSERT INTO USUARIO(IDEMP, USUARIO, CLAVE, ESTADO)
VALUES(1003,'kgutierrez',SHA('alegria'),1);

INSERT INTO USUARIO(IDEMP, USUARIO, CLAVE, ESTADO)
VALUES(1004,'lcarrasco',SHA('felicidad'),0);


-- =============================================
-- CREACION DE TABLAS DEL CATALOGO
-- =============================================


CREATE TABLE CATEGORIA
(
       idcat                INTEGER NOT NULL     COMMENT 'Identificador de categoría.',
       nombre               VARCHAR(50) NOT NULL COMMENT 'Nombre de categoría.',
       PRIMARY KEY (idcat)
) COMMENT='Tabla de categorías.';

INSERT INTO CATEGORIA(IDCAT,NOMBRE) VALUES(1,'ALE');
INSERT INTO CATEGORIA(IDCAT,NOMBRE) VALUES(2,'BOCK');
INSERT INTO CATEGORIA(IDCAT,NOMBRE) VALUES(3,'CALAFATE');
INSERT INTO CATEGORIA(IDCAT,NOMBRE) VALUES(4,'IPA');
INSERT INTO CATEGORIA(IDCAT,NOMBRE) VALUES(5,'LAYER');
INSERT INTO CATEGORIA(IDCAT,NOMBRE) VALUES(6,'MALTA');
INSERT INTO CATEGORIA(IDCAT,NOMBRE) VALUES(7,'NEGRA');
INSERT INTO CATEGORIA(IDCAT,NOMBRE) VALUES(8,'TRIGO');
INSERT INTO CATEGORIA(IDCAT,NOMBRE) VALUES(9,'STOUT');
INSERT INTO CATEGORIA(IDCAT,NOMBRE) VALUES(10,'MIX');
INSERT INTO CATEGORIA(IDCAT,NOMBRE) VALUES(11,'OTRAS');



CREATE TABLE PRODUCTO
(
       idprod               INTEGER AUTO_INCREMENT COMMENT 'Identificador de producto.',
       idcat                INTEGER NOT NULL COMMENT 'Identificador de categoría.',
       nombre               VARCHAR(100) NOT NULL COMMENT 'Nombre de producto.',
       precio               NUMERIC(10,2) NOT NULL COMMENT 'Precio del producto.',
       stock                INTEGER NOT NULL COMMENT 'Stock del producto.',
       PRIMARY KEY (idprod),
       FOREIGN KEY FK_PRODUCTO_CATEGORIA (idcat) REFERENCES CATEGORIA (idcat)
) COMMENT='Tabla de productos.';


INSERT INTO PRODUCTO(IDPROD,IDCAT,NOMBRE,PRECIO,STOCK)
VALUES(1,1,'BECKER',900.0,456);

INSERT INTO PRODUCTO(IDPROD,IDCAT,NOMBRE,PRECIO,STOCK)
VALUES(2,7,'CRISTAL',150.0,4567);

INSERT INTO PRODUCTO(IDPROD,IDCAT,NOMBRE,PRECIO,STOCK)
VALUES(3,1,'KUDELL',1300.0,690);

INSERT INTO PRODUCTO(IDPROD,IDCAT,NOMBRE,PRECIO,STOCK)
VALUES(4,7,'NIEBLA',95.00,150);

INSERT INTO PRODUCTO(IDPROD,IDCAT,NOMBRE,PRECIO,STOCK)
VALUES(5,6,'BALTICA',140.00,250);

INSERT INTO PRODUCTO(IDPROD,IDCAT,NOMBRE,PRECIO,STOCK)
VALUES(6,6,'ESCUDO',140.00,350);

INSERT INTO PRODUCTO(IDPROD,IDCAT,NOMBRE,PRECIO,STOCK)
VALUES(7,6,'ANTILLANCA',1180.00,450);


-- =============================================
-- CREACION DE TABLAS DE VENTAS
-- =============================================

CREATE TABLE VENTA
(
       idventa              INTEGER AUTO_INCREMENT COMMENT 'Identificador de venta.',
       idemp                INTEGER NOT NULL COMMENT 'Identificador del empleado.', 
       cliente              VARCHAR(100) NOT NULL COMMENT 'Nombre del cliente.',
       fecha                DATE NOT NULL COMMENT 'Fecha de venta.',
       importe              NUMERIC(10,2) NOT NULL COMMENT 'Importe de la venta.',
       PRIMARY KEY (idventa),
       FOREIGN KEY FK_VENTA_USUARIO (idemp) REFERENCES USUARIO (idemp)
) COMMENT='Tabla de ventas.';

CREATE TABLE DETALLE
(
       iddetalle            INTEGER AUTO_INCREMENT COMMENT 'Identificador del detalle.',
       idventa              INTEGER NOT NULL COMMENT 'Identificador de venta.',
       idprod               INTEGER NOT NULL COMMENT 'Identificador de producto.',
       cant                 NUMERIC NOT NULL COMMENT 'Cantidad vendida.',
       precio               NUMERIC(10,2) NOT NULL COMMENT 'Precio de venta.',
       subtotal             NUMERIC(10,2) NULL COMMENT 'Subtotal de la venta.',
       PRIMARY KEY (iddetalle),
       FOREIGN KEY FK_DETALLE_PRODUCTO (idprod) REFERENCES PRODUCTO (idprod),
       FOREIGN KEY FK_DETALLE_VENTA (idventa) REFERENCES VENTA (idventa)
) COMMENT='Tabla de detalle de ventas.';

CREATE UNIQUE INDEX U_DETALLE ON DETALLE
(
       idventa,
       idprod
);


-- =============================================
-- CREACION DE TABLAS DE PAGOS
-- =============================================

CREATE TABLE TIPO_PAGO
(
       idtipo               INTEGER NOT NULL     COMMENT 'Identificador del tipo de pago.',
       nombre               VARCHAR(50) NOT NULL COMMENT 'Nombre del tipo de pago.',
       PRIMARY KEY (idtipo)
) COMMENT='Tabla de tipos de pago.';


INSERT INTO TIPO_PAGO(IDTIPO,NOMBRE) VALUES(1,'EFECTIVO');
INSERT INTO TIPO_PAGO(IDTIPO,NOMBRE) VALUES(2,'TARJETA CREDITO');
INSERT INTO TIPO_PAGO(IDTIPO,NOMBRE) VALUES(3,'TARJETA DE DEBITO');
INSERT INTO TIPO_PAGO(IDTIPO,NOMBRE) VALUES(4,'CHEQUE');
INSERT INTO TIPO_PAGO(IDTIPO,NOMBRE) VALUES(5,'NOTA DE CREDITO');
INSERT INTO TIPO_PAGO(IDTIPO,NOMBRE) VALUES(6,'BONO EFECTIVO');


CREATE TABLE PAGO
(
       idpago               INTEGER AUTO_INCREMENT COMMENT 'Identificador del pago.',
       idventa              INTEGER NOT NULL COMMENT 'Identificador de venta.',
       idtipo               INTEGER NOT NULL COMMENT 'Identificador del tipo de pago.',
       detalle              VARCHAR(100) NOT NULL COMMENT 'Descripción del pago.',
       importe              NUMERIC(10,2) NOT NULL COMMENT 'Importe del pago.',
       obs                  VARCHAR(1000) NOT NULL COMMENT 'Campo para comentarios adicionales.',
       PRIMARY KEY (idpago),
       FOREIGN KEY FK_PAGO_VENTA (idventa) REFERENCES VENTA (idventa),
       FOREIGN KEY FK_PAGO_TIPO_PAGO (idtipo) REFERENCES TIPO_PAGO (idtipo)
) COMMENT='Tabla de pagos.';

CREATE UNIQUE INDEX U_PAGO_UNIQUE ON PAGO
(
       idventa,
       idtipo
);


-- =============================================
-- CREAR EL USUARIO
-- =============================================

USE MYSQL;
GRANT ALL PRIVILEGES ON *.* TO 'ventas'@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION;
FLUSH PRIVILEGES;
USE VENTAS;

USE MYSQL;
GRANT ALL PRIVILEGES ON *.* TO 'ventas'@'localhost' IDENTIFIED BY 'admin' WITH GRANT OPTION;
FLUSH PRIVILEGES;
USE VENTAS;


-- =============================================
-- HABILITAR SALIDAS
-- =============================================

SELECT DATABASE();
SHOW TABLES;