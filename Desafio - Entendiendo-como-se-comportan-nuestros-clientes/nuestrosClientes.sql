-- 1. Cargar el respaldo de la base de datos unidad2.sql.
-- Ejecutar este comando en consola de Windows:
psql -U postgres EmpresaInternacional < unidad2.sql

-----------------------------------------------------------------------------------------

-- 2. El cliente usuario01 ha realizado la siguiente compra:
-- ● producto: producto9
-- ● cantidad: 5
-- ● fecha: fecha del sistema
-- Mediante el uso de transacciones, realiza las consultas correspondientes para este
-- requerimiento y luego consulta la tabla producto para validar si fue efectivamente
-- descontado en el stock.

BEGIN TRANSACTION;
INSERT INTO compra (id,cliente_id,fecha) VALUES (33,1,current_date);
INSERT INTO detalle_compra (id,producto_id,compra_id,cantidad) VALUES (43,9,33,5);
UPDATE producto SET stock = stock - 5 WHERE id = 9;
ROLLBACK;

-----------------------------------------------------------------------------------------

-- 3. El cliente usuario02 ha realizado la siguiente compra:
-- ● producto: producto1, producto 2, producto 8
-- ● cantidad: 3 de cada producto
-- ● fecha: fecha del sistema
-- Mediante el uso de transacciones, realiza las consultas correspondientes para este
-- requerimiento y luego consulta la tabla producto para validar que si alguno de ellos
-- se queda sin stock, no se realice la compra.

BEGIN TRANSACTION;
-- Producto 1
INSERT INTO compra (id,cliente_id,fecha) VALUES (33,2,current_date);
INSERT INTO detalle_compra (id,producto_id,compra_id,cantidad) VALUES (43,1,33,3);
UPDATE producto SET stock = stock - 3 WHERE id = 1;
-- Producto 2
INSERT INTO compra (id,cliente_id,fecha) VALUES (34,2,current_date);
INSERT INTO detalle_compra (id,producto_id,compra_id,cantidad) VALUES (44,2,34,3);
UPDATE producto SET stock = stock - 3 WHERE id = 2;
-- Producto 8
INSERT INTO compra (id,cliente_id,fecha) VALUES (35,2,current_date);
INSERT INTO detalle_compra (id,producto_id,compra_id,cantidad) VALUES (45,8,35,3);
UPDATE producto SET stock = stock - 3 WHERE id = 8;

ROLLBACK;

SELECT * FROM producto;

-----------------------------------------------------------------------------------------

-- 4. Realizar las siguientes consultas:

-- Las siguientes operaciones se realizan en la consola psql (SQL Shell)

-- a. Deshabilitar el AUTOCOMMIT

-- Consultar estado del AUTOCOMMIT
\echo :AUTOCOMMIT
-- Desabilitar AUTOCOMMIT
\set AUTOCOMMIT off

-- b. Insertar un nuevo cliente
INSERT INTO cliente (id,nombre,email) VALUES (11,'usuario11','usuario11@gmail.com');

-- c. Confirmar que fue agregado en la tabla cliente
SELECT * FROM cliente WHERE id = 11;

-- d. Realizar un ROLLBACK
ROLLBACK;

-- e. Confirmar que se restauró la información, sin considerar la inserción del
-- punto b
SELECT * FROM cliente WHERE id = 11;

-- f. Habilitar de nuevo el AUTOCOMMIT
\set AUTOCOMMIT on