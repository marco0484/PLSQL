/*
Proyecto: PLSQL
Objetivo: Tener una clara idea de todo lo que se puede hacer con PLSQL y todo lo que tiene por dentro
(Paquetes, cursores, excepciones, triggers, procedimientos almacenados, funciones almacenadas, etc)
Creador: Marcoantonio Matehuala Yerena
Fecha de creacion: 28 de enero del 2026
*/

/*
    INDICE
        Introduccion a PLSQL
    *1* DML, DDL, DCL, TCL
  *1.1* Prefijos para objetos
  *1.2* Buenas practicas DB
  *1.3* Formas normales
  *1.4* Permisos y seguridad
  *1.5* Tipos de alters
    *2* Cursores en PLSQL (implicito y explicito)
    *3* Cabecera y cuerpo de un paquete
    *4* Merge
    *5* Bulk Collect
  *5.1* Ciclo For 
  *5.2* While
  *5.3* IF, ELSIF, ELSE
  *5.4* CASE
    *6* Nested Type
  *6.1* VARRAY
  *6.2* CREATE TABLE + VARRAY
    *7* Trigger
    *8* Funcion
    *9* Having
  *9.1* JOBS 
  *9.2* ROWNUM & ROWNUMBER
  *9.3* OVER PARTITION
    *10* Excepciones
    *11* Excepciones personalizadas
    *12* Creacion de tablas con condiciones especiales
    *13* Vistas y vistas materializadas
    *14* Sentencias importantes
    *15* Tipos de inserts
    *16* Queries dinamicas
    
        Paquete para produccion de administracion de tablas
    *50* Paquete INS, UPD, DEL, GET

    *70* Buscar objetos en la base de datos 
    *71* EXPLAIN PLAN 
    
                                
                                    Introduccion a PLSQL 
    Antes de comenzar a trabajar con PLSQL, es importante conocer los conceptos basicos de este lenguaje,
    por ejemplo que es un dato, para que sirve, donde vamos a guardar ese dato y los usos que podemos darles.

¿Que es PLSQL (Procedural Language/Structured Query Language)? 
PLSQL es un lenguaje de programacion estructurado, el cual es la extension procedural de SQL (structured Query Language) 
la cual fue desarrollada por Oracle Corporation en 1992 con la necesidad de mejorar las capacidades de la programacion
dentro de las bases de datos Oracle.

Pero a todo esto, ¿Que es un dato?
Es cualquier pedacito de informacion, por ejemplo: un numero, una letra, una palabra, una fecha, etc, el cual vamos a guardar
dentro de una base de datos.

*/

/******************** *1* DML, DDL, DCL, TCL  ********************/

DML (Data Manipulation Language)
1.Define o modifica la estructura 
Sentencias comunes:

* CREATE
* ALTER
* DROP
* TRUNCATE
* RENAME

DDL (Data Definition Language)

1.Manipula los datos dentro de las tablas
Sentencias comunes:

* INSERT
* UPDATE
* DELETE
* MERGE

DCL (Data Control Language)
1.Controla permisos y seguridad sobre los objetos de la base de datos
Sentencias comunes:

* GRANT
* REVOKE

TCL (Transaction Control Language)
1.Controla transacciones, es decir, grupos de cambios que se confirman o deshacen.
Sentencias comunes:

* COMMIT
* ROLLBACK
SAVEPOINT

/******************** *1.1* Prefijos para objetos  ********************/

| Tipo de objeto      | Prefijo sugerido  |
| TABLAS              |       TA          |
| TABLA TEMPORAL      |       TT          |
| TABLA CATALOGO      |       TC          |
| TABLA HISTORICA     |       TH          |
| STORED PROCEDURE    |       SP          |  
| TRIGGER             |       TR          |
| FUNCION             |       FN          |
| PAQUETE             |       PKG         |
| VISTA               |       VW          |
| VISTA MATERIALIZADA |       VM          |
| SECUENCIA           |       SEQ         |
| TABLE SPACE         |       TS          |
| INDICE              |       IN          |
| LLAVE PRIMARIA      |       PK          |
| LLAVE FORANEA       |       FK          |
| SINONIMO            |       SN          |
| ESQUEMA             |       SC          |
| DB LINK             |       DL          |

/******************** *1.2* Buenas practicas DB  ********************/

1.Prohibir el uso de SELECT * en consultas, ya que esto puede afectar el rendimiento y la seguridad de la base de datos.
2.Usar nombres descriptivos para tablas, columnas, procedimientos, funciones, etc.
3.Documentar el código con comentarios claros y concisos.
4.No usar ROWNUM + ORDER BY, de lo contrario se generara FULL TABLE SCAN
5.Palabras reservadas en mayúsculas para mejorar la legibilidad del código.
6.Evitar subqueries innecesarias, usar JOINs cuando sea posible.
7.Alias de las tablas en las consultas para mejorar la legibilidad.
8.Oracle evalua las condiciones AND de abajo hacia arriba
9.Oracle evalua las condiciones OR de arriba hacia abajo
10.Usar la expresion AND menos probable al inicio de la consulta para mejorar

/******************** *1.3* Formas normales  ********************/

-- Una forma normal es un conjunto de reglas que aseguran que 
-- cada dato esté en el lugar correcto y dependa de la clave correcta.
-- Ejemplo: Los PK Y FK se deben ejectuar con alter table y no en la creacion de la tabla

CREATE TABLE clientes(
                     cliente_id           NUMBER NOT NULL,  -- PK
                     promocion_contratada NUMBER NOT NULL,  -- FK a cat_promociones.promocion_id
                     fecha_contratacion   DATE NOT NULL    
                     );

CREATE TABLE cat_promociones(
                     promocion_id NUMBER NOT NULL, -- PK
                     descripcion  VARCHAR2(100) NOT NULL,
                     ind_activo   NUMBER(1) NOT NULL
                     );

CREATE TABLE det_promociones(
                        promocion_id NUMBER NOT NULL, -- PK y FK a cat_promociones.promocion_id
                        det_promocion VARCHAR2(100) NOT NULL,
                        ind_activo NUMBER(1) NOT NULL
                            );

/******************** *1.4* Permisos y seguridad  ********************/

-- Privilegios de sistema
-- El prefijo ANY se utiliza para que pueda ejecutar la accion sobre cualquier esquema de la base de datos

GRANT CREATE SESSION TO usuario;
GRANT CREATE TABLE TO usuario;
GRANT CREATE VIEW TO usuario;
GRANT CREATE PROCEDURE TO usuario;
GRANT CREATE SEQUENCE TO usuario;
GRANT CREATE TRIGGER TO usuario;
GRANT CREATE JOB TO usuario;
GRANT CREATE ANY TABLE TO usuario;
GRANT DROP ANY TABLE TO usuario;
GRANT SELECT ANY TABLE TO usuario;
GRANT EXECUTE ANY PROCEDURE TO usuario;
GRANT UNLIMITED TABLESPACE TO usuario;

-- Privilegios sobre objetos

GRANT SELECT ON ventas TO usuario;
GRANT INSERT ON ventas TO usuario;
GRANT UPDATE ON ventas TO usuario;
GRANT DELETE ON ventas TO usuario;
GRANT EXECUTE ON mi_procedimiento TO usuario;
GRANT REFERENCES ON ventas TO usuario;

-- Tambien se pueden limitar columnas -> GRANT UPDATE (monto) ON ventas TO usuario;
-- Permite que el usuario pueda compartir el permiso a otro

GRANT CREATE TABLE TO usuario WITH ADMIN OPTION;

/******************** *1.5* Tipos de alters *********************/

-- Para agregar columnas columnas a una tabla

ALTER TABLE ventas
ADD (
    descuento NUMBER,
    usuario_creacion VARCHAR2(50)
    );

-- Modificar el tipo de dato de una columna

ALTER TABLE ventas
MODIFY (descripcion VARCHAR2(200) NOT NULL);

-- Eliminar una columna

ALTER TABLE ventas
DROP COLUMN descuento;

-- Para eliminar mas de una columna

ALTER TABLE ventas
DROP (descuento
     ,usuario_creacion);

-- Para agregar un primary key

ALTER TABLE ventas
ADD CONSTRAINT pk_ventas
    PRIMARY KEY (id_venta);

-- Para agregar un foreign key

ALTER TABLE ventas
ADD CONSTRAINT fk_cliente
FOREIGN KEY (id_cliente)
REFERENCES clientes(id_cliente);

-- Constraint de campo unico

ALTER TABLE ventas
ADD CONSTRAINT uk_codigo
UNIQUE (codigo);

-- Constraint check

ALTER TABLE ventas
ADD CONSTRAINT chk_monto
CHECK (monto > 0);

-- Para eliminar constraints

ALTER TABLE ventas
DROP CONSTRAINT pk_ventas;

-- Habilitado y deshabilitacion de constraints

ALTER TABLE ventas
DISABLE CONSTRAINT fk_cliente;

ALTER TABLE ventas
ENABLE CONSTRAINT fk_cliente;

/******************** *2* Cursores en PLSQL ********************/

1.Implícito: Cuando regresa una sola fila (SELECT INTO)

DECLARE
  v_columna1 tabla.columna1%TYPE;
  v_columna2 tabla.columna2%TYPE;

BEGIN

 SELECT columna1
       ,columna2
   INTO v_columna1
        ,v_columna2
   FROM tabla
  WHERE condicion;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
                                DBMS_OUTPUT.PUT_LINE('No se encontraron datos.');
    WHEN TOO_MANY_ROWS THEN
                                DBMS_OUTPUT.PUT_LINE('Se encontraron múltiples filas.');
END;

 -- Explícito: Cuando regresa múltiples filas (OPEN, FETCH, CLOSE)
 -- Este cursor muestra la salida en un DBMS OUTPUT
DECLARE

  CURSOR cur_articulos  -- Cursor para seleccionar las articulos mayores a 1000
    IS   
    
    SELECT id_articulo
         , des_art
         , ind_activo
    FROM articulos 
    ORDER BY id_articulo ASC;

  v_id    articulos.id_articulo%TYPE; -- Variables donde guardaremos los datos de cada fila
  v_desc articulos.des_art%TYPE;
  v_act articulos.ind_activo%TYPE;
  
BEGIN
  OPEN cur_articulos;                  -- abrir cursor
  LOOP
    FETCH cur_articulos
     INTO v_id
        , v_desc
        , v_act;  -- guardar fila en variables
    EXIT WHEN cur_articulos%NOTFOUND;  -- salir cuando no hay más filas

DBMS_OUTPUT.PUT_LINE('Articulo: ' || v_id ||' Descripcion: ' || v_desc ||' Activo: ' || v_act);
  END LOOP;

  CLOSE cur_articulos;                 -- cerrar cursor
END;

/******************** *3* Cabecera y cuerpo de un paquete ********************/

CREATE OR REPLACE PACKAGE PA_ADM_TABLA          -- Estructura de una cabecera de paquete
IS
PROCEDURE SPINSERT (
                    PA_EMPLEADO_ID IN TABLA.EMPLEADO_ID%TYPE,
                    PA_EJECUCION  OUT NUMBER
                   );

PROCEDURE SP_GET_FECHA(
                    PA_EMPLEADO_ID   IN NUMBER,
                    GET_CURSOR OUT SYS_REFCURSOR
                   );
END PA_ADM_TABLA;

/

CREATE OR REPLACE PACKAGE BODY PA_ADM_TABLA -- Estrucutura de un cuerpo de paquete
IS

CSG_NVALORUNO CONSTANT  NUMBER := 1;
VG_NCODIGOERROR         NUMBER;
VG_VDESCERROR           VARCHAR2(200);
VG_VORIGENERROR         VARCHAR2(30);
CSG_NEJECINCON CONSTANT NUMBER := -1;

PROCEDURE SPINSERT(
                    PA_EMPLEADO_ID IN TABLA.EMPLEADO_ID%TYPE,
                    PA_EJECUCION  OUT NUMBER
                   )
IS
BEGIN
    INSERT INTO TABLA (EMPLEADO_ID)
    VALUES (PA_EMPLEADO_ID);

    PA_EJECUCION := SQL%ROWCOUNT; -- Asignar el número de filas afectadas (aplica para INSERT, UPDATE, DELETE)

    COMMIT;

    EXCEPTION WHEN OTHERS THEN ROLLBACK;

    PA_EJECUCION := CSG_NEJECINCON; -- Despues del rollback asignar valor de error

 VG_VORIGENERROR := 'PA_ADM_TABLA.SPINSERT'
                    || 'PA_EMPLEADO_ID:'    
                    || PA_EMPLEADO_ID;

 VG_NCODIGOERROR := SQLCODE; -- Código del error
 VG_VDESCERROR   := SQLERRM; -- Descripción del error 
 PKGLOGRESULTADOS.SPREGISTRAERROR(VG_NCODIGOERROR, VG_VDESCERROR, VG_VORIGENERROR); -- Llamada al procedimiento de log de errores
END SPINSERT;

/*************************************************************************/
PROCEDURE SP_GET_FECHA(
                        PA_EMPLEADO_ID IN NUMBER,
                        GET_CURSOR    OUT SYS_REFCURSOR
                      )   
IS
    v_fecha_ini  DATE;
    v_fecha_fin  DATE;
BEGIN                   --Obtener las fechas en variables
    SELECT fecha_inicio, 
           fecha_fin
    INTO   v_fecha_ini,
           v_fecha_fin
    FROM   tabla_fechas
    WHERE  empleado_id = PA_EMPLEADO_ID;
    
    OPEN GET_CURSOR  -- Usar esas variables en el cursor con BETWEEN
     FOR 
        SELECT fecha_ingreso
        FROM   tabla
        WHERE  empleado_id = PA_EMPLEADO_ID
        AND    fecha_ingreso BETWEEN v_fecha_ini AND v_fecha_fin;

END SP_GET_FECHA;
END PA_ADM_TABLA; -- Fin del cuerpo del paquete

/********************    *4*  MERGE           ********************/

MERGE INTO ventas_auditoria tgt
USING (
            SELECT id_venta,
                fecha_venta,
                monto
            FROM   ventas
    ) src

ON (tgt.id_venta = src.id_venta)

WHEN MATCHED THEN
    UPDATE SET
        tgt.fecha_venta   = src.fecha_venta,
        tgt.monto         = src.monto,
        tgt.fecha_copiado = SYSDATE
    DELETE WHERE src.monto <= 0

WHEN NOT MATCHED THEN
    INSERT (id_venta
        , fecha_venta
        , monto
        , fecha_copiado)
    VALUES (src.id_venta
          , src.fecha_venta
          , src.monto
          , SYSDATE);

/********************     *5*    BULK COLLECT        ********************/

DECLARE
    TYPE t_ventas IS TABLE OF ventas%ROWTYPE; -- INDEX BY PLS_INTEGER;
    v_ventas t_ventas;

BEGIN
    SELECT * -- 1️⃣ Carga masiva
    BULK COLLECT INTO v_ventas
    FROM ventas
    WHERE monto > 1000;

    -- 2️⃣ Insert masivo con control de errores, va del primero al ultimo registro
    -- FOR i IN 1 .. v_articulos.COUNT LOOP

    FORALL i IN v_ventas.FIRST .. v_ventas.LAST 
            SAVE EXCEPTIONS
        INSERT INTO ventas_auditoria (
            id_venta,
            fecha_venta,
            monto,
            fecha_copiado
        )
        VALUES (
            v_ventas(i).id_venta,
            v_ventas(i).fecha_venta,
            v_ventas(i).monto,
            SYSDATE
        );

    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' registros insertados correctamente.');

EXCEPTION WHEN OTHERS THEN
        IF SQLCODE = -24381 THEN  --  -- 3️⃣ Manejo específico de errores FORALL error de DML masivo
            FOR j IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
                INSERT INTO ventas_errores (
                    id_venta,
                    error_index,
                    error_code,
                    error_msg,
                    fecha_error
                )
                VALUES (
                    v_ventas(SQL%BULK_EXCEPTIONS(j).ERROR_INDEX).id_venta,
                    SQL%BULK_EXCEPTIONS(j).ERROR_INDEX,
                    SQL%BULK_EXCEPTIONS(j).ERROR_CODE,
                    SQLERRM(-SQL%BULK_EXCEPTIONS(j).ERROR_CODE),
                    SYSDATE
                );
            END LOOP;

            DBMS_OUTPUT.PUT_LINE(SQL%BULK_EXCEPTIONS.COUNT || ' errores guardados en ventas_errores.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
        END IF;
        ROLLBACK;
END;

/****************** Bulk Collet Basico *******************/

CREATE OR REPLACE PROCEDURE copiar_ventas_basic 
AS

    TYPE r_venta 
       IS RECORD (
        cod_venta  ventas.cod_venta%TYPE,
        fyh_venta  ventas.fyh_venta%TYPE
                );
    /*
    CREATE OR REPLACE TYPE t_venta_obj 
    AS OBJECT (
                cod_venta  NUMBER,
                fyh_venta   DATE
             );
    */

    TYPE t_ventas IS TABLE OF r_venta;

    /*
    CREATE OR REPLACE TYPE t_venta_table 
                AS TABLE OF t_venta_obj;
    */
    v_ventas t_ventas;

BEGIN

    SELECT cod_venta
          ,fyh_venta
      BULK COLLECT 
      INTO v_ventas
      FROM ventas;

    IF v_ventas.COUNT > 0 THEN

        BEGIN
            FORALL i IN 1 .. v_ventas.COUNT
                INSERT INTO ventas_auditoria (
                    id_venta,
                    fecha_venta,
                    monto,
                    fecha_copiado
                )
                VALUES (
                    v_ventas(i).cod_venta,
                    v_ventas(i).fyh_venta,
                    NULL,
                    SYSDATE
                );

            DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' registros insertados.');

        EXCEPTION
            WHEN OTHERS THEN
                DECLARE
                    v_code NUMBER := SQLCODE;
                    v_msg  VARCHAR2(4000) := SQLERRM;
                BEGIN
                    INSERT INTO ventas_errores (
                        id_venta,
                        error_index,
                        error_code,
                        error_msg,
                        fecha_error
                    )
                    VALUES (
                        NULL,
                        NULL,
                        v_code,
                        v_msg,
                        SYSDATE
                    );

                    DBMS_OUTPUT.PUT_LINE('Error capturado: ' || v_msg);
                END;
        END;

    ELSE
        DBMS_OUTPUT.PUT_LINE('No hay registros.');
    END IF;

END;

-- Para ejecutarlo 
BEGIN
   copiar_ventas_basic;
END; 

-- o tambien

EXEC copiar_ventas_basic;

/******************* *5.1* CICLO FOR  ********************/

-- El ciclo for se ejecuta un número determinado de veces, es útil cuando sabemos cuántas veces se repetirá el ciclo
-- por ejemplo la sentencia dentro del FOR se ejecutara con todos los registros que devuelva esa consulta

DECLARE 
v_monto_comision ventas.monto%TYPE;

BEGIN
   FOR r IN (
       SELECT id_venta
            , monto
       FROM ventas
       WHERE monto > 10000
   ) LOOP

      BEGIN
         UPDATE ventas
         SET comision = r.monto * v_monto_comision
         WHERE id_venta = r.id_venta;

      EXCEPTION WHEN OTHERS
                THEN DBMS_OUTPUT.PUT_LINE('Error en venta ' || r.id_venta || ' - ' || SQLERRM);
      END;

   END LOOP;
   COMMIT;

EXCEPTION WHEN OTHERS THEN ROLLBACK;
DBMS_OUTPUT.PUT_LINE('Error general: ' || SQLERRM);
END;

/******************* *5.2* CICLO WHILE  ********************/
-- Un ciclo WHILE se ejecuta mientras una condición sea verdadera, es útil cuando no sabemos cuántas veces se repetirá 
-- el ciclo, por ejemplo, para calcular el tiempo que tardará en liquidar una deuda con pagos mensuales fijos.
-- la sentencia while siempre va acompañada de la sentencia LOOP

DECLARE
   v_deuda        NUMBER := 5000;
   v_pago_mensual NUMBER := 1200;
   v_mes          NUMBER := 1;
BEGIN

   WHILE v_deuda > 0 LOOP

      v_deuda := v_deuda - v_pago_mensual;

      IF v_deuda < 0 THEN  v_deuda := 0;
      END IF;

      DBMS_OUTPUT.PUT_LINE('Mes ' || v_mes || ' - Deuda restante: ' || v_deuda);

      v_mes := v_mes + 1;

   END LOOP;

   DBMS_OUTPUT.PUT_LINE('Deuda liquidada.');

EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/******************** *5.3* IF, ELSIF, ELSE ********************/
-- La estructura IF permite ejecutar bloques de código según una condición.
-- Se utiliza cuando el sistema debe tomar decisiones basadas en validaciones 
-- o reglas de negocio.
-- Es útil para controlar el flujo del programa, validar datos o manejar escenarios alternativos.

DECLARE
    v_salario NUMBER := 15000;

BEGIN
    IF v_salario < 10000 THEN
        DBMS_OUTPUT.PUT_LINE('Salario bajo');
    ELSIF v_salario BETWEEN 10000 AND 20000 THEN
        DBMS_OUTPUT.PUT_LINE('Salario medio');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Salario alto');
    END IF;
END;

/******************** *5.4* CASE ********************/
-- Se utiliza cuando una misma variable puede tener varios posibles valores
-- y se desea asignar un resultado según cada caso.
-- Es más legible que múltiples IF cuando hay varias alternativas definidas.

DECLARE
    v_calificacion NUMBER := 85;

BEGIN
    CASE 
        WHEN v_calificacion >= 90 THEN
            DBMS_OUTPUT.PUT_LINE('Excelente');
        WHEN v_calificacion >= 70 THEN
            DBMS_OUTPUT.PUT_LINE('Aprobado');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Reprobado');
    END CASE;
END;

-- Otro ejemplo

SELECT ID_VENTA,
        VENDEDOR,
        CASE WHEN VENDEDOR = 'Ana' THEN 'Mancha'
            ELSE 'Sin asignar'
        END ejemplo,
        CASE WHEN ID_VENTA IN (1,2,3) THEN 1000
        ELSE 0
        END caso_2,
        REGION,
        FECHA
FROM VENTAS_OVER;

/********************  *6* NESTED TYPE  ********************/
-- Se utiliza para crear tipos de datos personalizados que pueden ser utilizados en tablas, procedimientos, funciones, etc.

CREATE OR REPLACE TYPE t_ventas_obj 
             AS OBJECT (
                            id_venta    NUMBER,
                            fecha_venta DATE,
                            monto       NUMBER
                        );

CREATE OR REPLACE TYPE t_ventas_table 
                    AS TABLE OF t_ventas_obj;

-- Ejemplo de uso:

CREATE OR REPLACE PROCEDURE procesar_ventas_impuesto
IS
    v_ventas        t_ventas_table := t_ventas_table();
    v_impuesto      NUMBER;
    v_total         NUMBER;

BEGIN
    v_ventas.EXTEND(3); -- Simulamos lote recibido

    v_ventas(1) := t_ventas_obj(1, SYSDATE, 1000);
    v_ventas(2) := t_ventas_obj(2, SYSDATE, 2500);
    v_ventas(3) := t_ventas_obj(3, SYSDATE, 500);

    
    FOR i IN 1 .. v_ventas.COUNT LOOP -- Procesamos en memoria

        v_impuesto := v_ventas(i).monto * 0.16;
        v_total    := v_ventas(i).monto + v_impuesto;

        INSERT INTO ventas_procesadas
        VALUES (
            v_ventas(i).id_venta,
            v_ventas(i).fecha_venta,
            v_ventas(i).monto,
            v_impuesto,
            v_total
        );

    END LOOP;
    COMMIT;
END;

/********************  *6.1* VARRAY  ********************/

-- Uso cuando sabemos el número máximo de elementos que tendrá la colección, por ejemplo, para guardar los colores favoritos de una persona.
DECLARE
    TYPE t_colores IS VARRAY(5)  -- Definicion de un VARRAY de 5 elementos
                OF VARCHAR2(20); -- Tipo de dato de los elementos

    v_colores t_colores := t_colores('Rojo','Azul','Verde'); -- Inicializacion del VARRAY con 3 colores (Sin tabla base, se maneja como una variable)
BEGIN
    FOR i IN 1 .. v_colores.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_colores(i));
    END LOOP;
END;

/******************** *6.2* CREATE TABLE + VARRAY ****************/

CREATE OR REPLACE TYPE dato 
                    AS OBJECT (
                                numero       NUMBER,
                                descripcion  VARCHAR2(50)
                                );

CREATE TABLE prueba (
                        c1 NUMBER,
                        c2 dato, -- Ojo aqui 
                        c3 VARCHAR2(60)
                        );

INSERT INTO prueba
VALUES (1, dato(100, 'Producto A'), 'extra 1');

INSERT INTO prueba
VALUES (2, dato(200, 'Producto B'), 'extra 2');

SELECT * FROM prueba;

/********************    *7*  TRIGGER         ********************/
-- Un trigger es un evento que se ejecuta automáticamente en respuesta a ciertas acciones 
-- por ejemplo cuando se inserta, actualiza o elimina un registro en una tabla.
-- Tablas a utilizar en el proceso SELECT * FROM ventas_demo; SELECT * FROM ventas_demo_auditoria;

CREATE OR REPLACE TRIGGER trg_ventas_demo_audit
            AFTER INSERT 
               OR UPDATE OR DELETE
               ON ventas_demo
              FOR EACH ROW
BEGIN

   IF INSERTING THEN
      INSERT INTO ventas_demo_auditoria
      (id_venta
     , fecha_venta
     , monto
     , accion
     , fecha_evento
     , usuario_bd)

      VALUES
      (:NEW.id_venta
      , :NEW.fecha_venta
      , :NEW.monto
      ,'INSERT'
      , SYSTIMESTAMP
      , SYS_CONTEXT('USERENV','SESSION_USER'));

   ELSIF UPDATING THEN
      INSERT INTO ventas_demo_auditoria
      (id_venta
     , fecha_venta
     , monto
     , accion
     , fecha_evento
     , usuario_bd)
      VALUES
      (:NEW.id_venta,
       :NEW.fecha_venta,
        :NEW.monto,
       'UPDATE',
        SYSTIMESTAMP,
       SYS_CONTEXT('USERENV','SESSION_USER'));

   ELSIF DELETING THEN
      INSERT INTO ventas_demo_auditoria
      (id_venta, fecha_venta, monto, accion, fecha_evento, usuario_bd)
      VALUES
      (:OLD.id_venta, :OLD.fecha_venta, :OLD.monto,
       'DELETE', SYSTIMESTAMP,
       SYS_CONTEXT('USERENV','SESSION_USER'));
   END IF;

EXCEPTION
   WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20099,
         'Error en trigger de auditoria: ' || SQLERRM);
END;

/********************  *8* FUNCION        ********************/

CREATE OR REPLACE FUNCTION nombre_funcion (
                                                p_param1 IN NUMBER,       -- parámetro de entrada
                                                p_param2 IN VARCHAR2      -- otro parámetro de entrada
                                          ) 
RETURN NUMBER             -- tipo de dato de salida
IS
  v_result NUMBER;

BEGIN
  v_result := p_param1 * 2;  

  RETURN v_result;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error en función: ' || SQLERRM);
    RETURN NULL;  -- se puede retornar un valor por defecto si hay error
END;

/*********************   HAVING   *********************/
-- Agrupa los registros que tengan la misma combinación de col1 y col2.

SELECT col1,
       col2, 
       COUNT(*) AS cantidad
FROM mi_tabla
GROUP BY col1, col2
HAVING COUNT(*) > 1;


/*********************   *9* EXCEPTIONES     *********************/
-- Una exception es un error que ocurre durante la ejecución del programa.

1. EXCEPTION es donde se manejan errores.
2. DUP_VAL_ON_INDEX es un ejemplo de error predefinido (clave duplicada).
    NO_DATA_FOUND la consulta no tiene datos que devolver.
    TO_MANY_ROWS la consulta devuelve más de una fila cuando se esperaba una sola.
    ZERO_DIVIDE intento de dividir por cero.
3. OTHERS captura cualquier otro error que no hayas listado.
4. SQLERRM te devuelve el mensaje del error ocurrido.
    SQLCODE te devuelve el código numérico del error ocurrido.
5. Puedes usar RAISE para volver a lanzar una excepción (entre el rango -20000  a  -20999)

BEGIN
   IF v_salario > 100000 THEN
      RAISE_APPLICATION_ERROR(
         -20001,
         'El salario excede el máximo permitido'
      );
   END IF;
END;

/******************** *9.1* JOBS  ********************/
-- El rownum sirve para enumerar columna
SELECT *
FROM (
    SELECT  cod_venta
           ,desc_venta
           , rownum rn
    FROM ventas
    )
WHERE rn = 3;

-- El row_number sirve para enumerar columnas dependiendo de un ordenamiento

select cod_venta, desc_venta
from (
    select cod_venta
          , desc_venta,
           row_number() over (order by cod_venta) rn
    from ventas
    )
where rn = 3;


-- Un JOB es una tarea programada que se ejecuta automáticamente en un momento específico o de forma recurrente.
BEGIN
   DBMS_SCHEDULER.create_job (
      job_name        => 'JOB_REPORTE_DIARIO',                -- Nombre del job
      job_type        => 'PLSQL_BLOCK',                       -- Tipo de job, en este caso un bloque PL/SQL
      job_action      => 'BEGIN reporte_pkg.generar(); END;', -- Acción a ejecutar
      start_date      => SYSTIMESTAMP,                        -- Fecha y hora de inicio del job (ahora mismo)
      repeat_interval => 'FREQ=DAILY;BYHOUR=3;BYMINUTE=0;BYSECOND=0', -- Repetir diariamente a las 3:00 AM
      enabled         => TRUE                                         -- Habilitar el job inmediatamente
   );
END;

/******************** *9.2* ROWNUM & ROWNUMBER  ********************/
-- ROWNUM es una pseudocolumna que Oracle asigna según va leyendo las filas.

select * from 
(select id_venta,
        vendedor,
        region,
         rownum rn
 from ventas_over)
 where rn = 4;

-- ROW_NUMBER() es una función analítica que numera filas después de ordenar.

 SELECT
    vendedor,
    monto,
    ROW_NUMBER() OVER (ORDER BY monto DESC) numero
FROM ventas_over;

/******************* *9.3* OVER PARTITION **************************/
SELECT
    vendedor,
    region,
    monto,
    SUM(monto) OVER (PARTITION BY vendedor ) total_vendedor
FROM ventas_over;

/******************** *10* EXCEPTIONES PERSONALIZADAS   ********************/
-- Es una excepción que tú defines manualmente para controlar reglas de negocio.
DECLARE
   e_monto_invalido EXCEPTION;
   v_monto          NUMBER:= 1;
   v_fecha          DATE;

BEGIN
        SELECT SYSDATE 
        INTO v_fecha
        FROM DUAL;

   IF v_monto <= 2 THEN
      RAISE e_monto_invalido;
   END IF;

EXCEPTION
   WHEN e_monto_invalido THEN
      DBMS_OUTPUT.PUT_LINE('El monto no es válido' || '  ' || v_fecha);
END;

/*********************   *11* SECUENCIAS   *********************/
-- Una secuencia (SEQUENCE) es un objeto de base de datos que genera números únicos de manera automática.

CREATE SEQUENCE seq_usuarios_id
    START WITH 1
    INCREMENT BY 1
    CACHE 100 -- Almacena en memoria los próximos 100 valores para mejorar rendimiento
    NOCYCLE -- No reinicia la secuencia cuando llega al máximo valor
    NOORDER; -- No garantiza que los números se generen en orden si hay múltiples instancias de la base de datos
    
/*******         CICLO FOR  *******/
/* Un ciclo FOR es una estructura de control que repite un bloque de código un número determinado de veces.

        Mejores practicas para elegir para un FOR:

| Caso                 | Mejor opción  |
| -------------------- | ------------- |
| 10–100 registros     | Cursor FOR    |
| Lectura simple       | Cursor FOR    |
| Lógica compleja      | Cursor FOR    |
| +10,000 registros    | BULK COLLECT  |
| Insert/Update masivo | BULK + FORALL |

    Tipos de recorrido para un FOR

| Tipo de recorrido                             |    Descripción                                            |       
| FOR i IN 1 .. 10 LOOP                         | Recorre un rango numérico fijo                            |
| FOR i IN 1 .. v_tabla.COUNT LOOP              | Recorre un rango basado en el tamaño de una colección     |
| FOR i IN REVERSE 1 .. v_tabla.COUNT LOOP      | Recorre un rango en orden inverso                         |
| FOR i IN v_tabla.FIRST .. v_tabla.LAST LOOP   | Recorre un rango basado en los índices de una colección   |

*/

DECLARE

    TYPE t_ventas IS TABLE OF ventas%ROWTYPE;
    v_ventas t_ventas;

    CURSOR c_ventas IS
        SELECT *
        FROM ventas
        WHERE monto > 1000;
BEGIN
    OPEN c_ventas;

    LOOP
        FETCH c_ventas 
        BULK COLLECT 
        INTO v_ventas 
        LIMIT 100;  -- FETCH FIRST 100 ROWS ONLY (No le importa el performance, a LIMIT si) 

        EXIT WHEN v_ventas.COUNT = 0;

        FOR i IN v_ventas.FIRST .. v_ventas.LAST LOOP
            DBMS_OUTPUT.PUT_LINE(
                'Venta ' || v_ventas(i).id_venta ||
                ' Monto ' || v_ventas(i).monto
            );
        END LOOP;

    END LOOP;

    CLOSE c_ventas;
END;

/*********************   *12* CREACION DE TABLAS CON CONDICIONES ESPECIALES   *********************/
-- Las particiones se generan para que la base de datos administre mejor los datos, ya que si se tiene una tabla con millones
-- de registros, la base de datos puede tener problemas para manejar tantos datos en una sola tabla, por lo que se crean
-- particiones para dividir los datos en partes más pequeñas y manejables.

/*
| Tipo     | ¿Automático?  | ¿Para fechas?  | Uso típico |
| -------- | ------------  | -------------  | ---------- |
| RANGE    | x             | ok             | históricos |
| LIST     | x             | x              | catálogos  |
| HASH     | x             | x              | balanceo   | Muchos inserts recurrentes, no importa el orden
| INTERVAL | ok            | ok             | logs       |
*/
-- Ejemplo con range e interval
    CREATE TABLE empleados 
                            (
                                cod_empleado     NUMBER(10,2) NOT NULL,
                                nombre_empleado  VARCHAR2(100) NOT NULL,
                                salario          NUMBER(10,2) CHECK (salario > 0),
                                fecha_ingreso    DATE DEFAULT SYSDATE,
                                tyc              VARCHAR2(1) CHECK (tyc IN ('S', 'N')),
                            )
                            PARTITION BY RANGE (fecha_ingreso)
                            INTERVAL (NUMTOYMINTERVAL(1, 'MONTH')) -- Inicializa particiones mensuales automáticas
                                    --NUMTOYMINTERVAL(1, 'DAY')    -- 1 día
                                    --NUMTOYMINTERVAL(6, 'MONTH')  -- 6 meses
                            (
                                PARTITION p_2023 VALUES LESS THAN (TO_DATE('01-01-2024', 'DD-MM-YYYY')) -- Partición para empleados ingresados antes de 2024
                            );
-- Despues de cerar cualquier tabla particionada, se pueden crear indices locales
-- para evitatar que el indice se vuelva corrupto

CREATE INDEX idx_empleados
ON empleados(fecha_ingreso)
LOCAL;

-- En caso de que se vuelva corrupto, se puede reconstruir con:
    ALTER INDEX idx_empleados REBUILD;
                                                       
-- Ejemplo con hash:

        CREATE TABLE sesiones_usuario (
                                        sesion_id   NUMBER,
                                        usuario_id  NUMBER NOT NULL,
                                        fecha_login DATE DEFAULT SYSDATE
                                        )
            PARTITION BY HASH (usuario_id)
            PARTITIONS 8; -- Crea 8 particiones basadas en el hash del usuario_id para balancear la carga de inserciones

-- Ejemplo de partición con list:
        CREATE TABLE pedidos (
                                pedido_id NUMBER,
                                cliente_id NUMBER,
                                estatus CHAR(1),
                                fecha_pedido DATE
                            )
        PARTITION BY LIST (estatus)
        (
        PARTITION p_pendiente VALUES ('P'),
        PARTITION p_enviado   VALUES ('E'),
        PARTITION p_cancelado VALUES ('C'),
        PARTITION p_otros    VALUES (DEFAULT) -- Si alguien inserta un estatus diferente a P, E o C, se guardará en esta partición
        );

/*********************   *13* VISTAS Y VISTAS MATERIALIZADAS   *********************/

/* Las vistas son objetos de la base de datos que se comportan como tablas virtuales,
es decir, no almacenan datos físicamente, sino que muestran los datos de una o más tablas 
a través de una consulta SQL definida en la vista. Las vistas se utilizan para simplificar consultas complejas
o para proporcionar una capa de seguridad al ocultar ciertas columnas o filas de las tablas subyacentes.

 Las vistas no guardan datos, pero si es una ventana de las tablas base, por lo que cada vez que se consulta una vista, 
 la base de datos ejecuta la consulta definida en la vista para obtener los datos actuales */

CREATE VIEW vw_visualizaciones 
AS
SELECT p.pedido_id,
       c.nombre,
       p.fecha_pedido,
       p.total
FROM pedidos p
JOIN clientes c 
ON c.cliente_id = p.cliente_id
WHERE p.estatus = 'E'
WITH CHECK OPTION; -- Evita que se inserten o actualicen filas a través de la vista que no cumplan con la condición
                   -- OJO solo funciona con vistas simples (que solo tengan una tabla base)

-- Las vistas materializadas son similares a las vistas normales, pero a diferencia de estas, las vistas materializadas
-- sí almacenan físicamente los datos en la base de datos. Esto significa que cuando se consulta una vista materializada,
-- la base de datos no tiene que ejecutar la consulta subyacente cada vez, sino que simplemente devuelve los datos almacenados
-- en la vista materializada.

CREATE MATERIALIZED VIEW mv_pedidos_enviados
BUILD IMMEDIATE            -- Construye la vista materializada inmediatamente al crearla
REFRESH COMPLETE ON DEMAND -- Se refresca manualmente con EXEC DBMS_MVIEW.REFRESH('mv_pedidos_enviados')
-- BUILD DEFERRED          -- Se llena hasta el primer refresh
AS
SELECT pedido_id,
       fecha_pedido,
       total
FROM pedidos
WHERE estatus = 'E';

/*
        TIPOS DE REFRESH PARA VISTAS MATERIALIZADAS

| Tipo      | Qué hace        | Uso típico     |
| --------- | --------------- | -------------- |
| COMPLETE  | Recalcula todo  | Datos pequeños |
| FAST      | Solo cambios    | Datos grandes  |
| FORCE     | FAST o COMPLETE | Mixto          |
| ON COMMIT | En cada commit  | Tiempo real    |
| ON DEMAND | Manual / job    | Reporting      |
*/


/*********************   *14* SENTENCIAS IMPORTANTES   *********************/

-- GREATEST: Devuelve el valor máximo de una lista de expresiones, ojo si existe valor NULL en la lista, el resultado será NULL
SELECT GREATEST(col1, col2, col3) AS max_col 
FROM DUAL;

-- --LEAST: Devuelven el valor mínimo de una lista de expresiones, ojo si existe valor NULL en la lista, el resultado será NULL
SELECT LEAST(col1, col2, col3) AS min_col 
FROM DUAL;


FLOOR: Redondea hacia abajo--
SELECT FLOOR(3.7) 
ROM DUAL; -- Devuelve 3

--CEIL: Redondea hacia arriba
SELECT CEIL(3.2) 
FROM DUAL; -- Devuelve 4

SUBSTR: Extrae una subcadena de una cadena dada, especificando la posición inicial y la longitud
        SELECT SUBSTR(cadena, posición_inicial, longitud) FROM DUAL;
               SUBSTR('2024-02-15', 1, 4); -- '2024'

INSTR: Devuelve la posición de una subcadena dentro de una cadena, si no encuentra la subcadena devuelve 0
        SELECT INSTR('computadora', 'comput')    FROM dual; -- Devuelve 1
        SELECT INSTR('mi computadora', 'comput') FROM dual; -- Devuelve 4

DECODE: Devuelve el valor de la expresión si coincide con el valor de búsqueda, de lo contrario devuelve el valor predeterminado
        SELECT DECODE(rol, 'A', 'ADMIN', 'U', 'USUARIO', 'DESCONOCIDO') FROM usuarios;

/*********************   *15* TIPOS DE INSERTS   *********************/
 
-- INSERT ALL: Ejecuta un solo INSERT por todas las filas 

INSERT ALL
  INTO ventas VALUES (1,  'Venta de laptop',     DATE '2024-01-05', DATE '2024-01-06')
  INTO ventas VALUES (2,  'Venta de monitor',    DATE '2024-01-10', DATE '2024-01-10')
  INTO ventas VALUES (3,  'Venta de teclado',    DATE '2024-02-01', DATE '2024-02-02')
SELECT 1 FROM dual;

/*************** *16* QUERIES DINAMICAS  *****************/

-- Creando una tabla 
CREATE OR REPLACE PROCEDURE test_dinamic
(
   nombre_tabla VARCHAR2,
   columnas     VARCHAR2
)
AUTHID CURRENT_USER 
IS
BEGIN
   EXECUTE IMMEDIATE 
      'CREATE TABLE ' || nombre_tabla || ' (' || columnas || ')'; -- ojo en el espacio despues del create
END;

--  DML DINAMICO
CREATE OR REPLACE PROCEDURE proceso_dinamico (
    p_operacion IN VARCHAR2,   -- INSERT / UPDATE / DELETE
    p_tabla     IN VARCHAR2,
    p_codigo    IN NUMBER,
    p_datos     IN VARCHAR2 DEFAULT NULL
)
IS
    v_sql VARCHAR2(1000);
BEGIN

    IF UPPER(p_operacion) = 'INSERT' THEN
        
        v_sql := 'INSERT INTO ' || p_tabla ||
                 ' (codigo, datos) VALUES (:1, :2)';
        
        EXECUTE IMMEDIATE v_sql
        USING p_codigo, p_datos;

    ELSIF UPPER(p_operacion) = 'UPDATE' THEN
        
        v_sql := 'UPDATE ' || p_tabla ||
                 ' SET datos = :1 WHERE codigo = :2';
        
        EXECUTE IMMEDIATE v_sql
        USING p_datos, p_codigo;

    ELSIF UPPER(p_operacion) = 'DELETE' THEN
        
        v_sql := 'DELETE FROM ' || p_tabla ||
                 ' WHERE codigo = :1';
        
        EXECUTE IMMEDIATE v_sql
        USING p_codigo;

    ELSE RAISE_APPLICATION_ERROR(-20001, 'Operación no válida');
    END IF;
END;

-- Para ejecutarlo:
BEGIN
   proceso_dinamico('UPDATE', 'dinamic', 1, 'Nuevo valor');
   -- proceso_dinamico('DELETE', 'dinamic', 1);
END;


-- TRUNCATE dinámico
EXECUTE IMMEDIATE ('TRUNCATE TABLE ESQUEMA.dinamic');

-- Eliminar todas las tablas de la base de datos 
BEGIN
   FOR t IN (SELECT table_name 
               FROM user_tables) LOOP
      EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
   END LOOP;
END;

-- Eliminar todos los registros de las tablas

BEGIN
   FOR t IN (SELECT table_name 
               FROM user_tables) LOOP
      EXECUTE IMMEDIATE 'TRUNCATE TABLE ' || t.table_name;
   END LOOP;
END;

-- Eliminar todas las vistas 
BEGIN
   FOR v IN (SELECT view_name FROM user_views) LOOP
      EXECUTE IMMEDIATE 'DROP VIEW ' || v.view_name;
   END LOOP;
END;


/********** *50* PAQUETE DE ADMINISTRACION DE TABLAS  ********************/
CREATE OR REPALCE PACKAGE PADM
AS
PROCEDURE SPINSERT(
                    PA_EMPLEADO_ID IN TABLA.EMPLEADO_ID%TYPE,
                    PA_EJECUCION  OUT NUMBER
                  );
                  
PROCEDURE SPUPDATE(
                    PA_EMPLEADO_ID IN TABLA.EMPLEADO_ID%TYPE,
                    PA_NUEVO_SALARIO IN TABLA.SALARIO%TYPE,
                    PA_EJECUCION  OUT NUMBER
                  );

PROCEDURE SPDELETE(
                    PA_EMPLEADO_ID IN TABLA.EMPLEADO_ID%TYPE,
                    PA_EJECUCION  OUT NUMBER
                  );

PROCEDURE SPGET(
                    PA_EMPLEADO_ID IN TABLA.EMPLEADO_ID%TYPE,
                    GET_CURSOR OUT SYS_REFCURSOR
               );
END PADM;

CREATE OR REPLACE PACKAGE BODY PADM
AS
CSG_NVALORUNO CONSTANT  NUMBER := 1;    -- Variable constante para indicar ejecución exitosa
VG_NCODIGOERROR         NUMBER;         -- Variable para almacenar código de error
VG_VDESCERROR           VARCHAR2(200);  -- Variable para almacenar descripción del error
VG_VORIGENERROR         VARCHAR2(30);   -- Variable para almacenar el origen del error
CSG_NEJECINCON CONSTANT NUMBER := -1;   -- Variable constante para indicar ejecución con error

PROCEDURE SPINSERT(
                    PA_EMPLEADO_ID IN TABLA.EMPLEADO_ID%TYPE,
                    PA_EJECUCION  OUT NUMBER
                  )
IS
BEGIN
    INSERT INTO TABLA (EMPLEADO_ID)
    VALUES (PA_EMPLEADO_ID);
    PA_EJECUCION := CSG_NVALORUNO;
    COMMIT;
EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
    PA_EJECUCION := CSG_NEJECINCON;
    VG_VORIGENERROR := 'PADM.SPINSERT' || 'PA_EMPLEADO_ID:' || PA_EMPLEADO_ID;
    VG_NCODIGOERROR := SQLCODE;
    VG_VDESCERROR   := SQLERRM;
    PKGLOGRESULTADOS.SPREGISTRAERROR(VG_NCODIGOERROR, VG_VDESCERROR, VG_VORIGENERROR);
END SPINSERT;
/***************************************************************/
PROCEDURE SPUPDATE(
                    PA_EMPLEADO_ID   IN TABLA.EMPLEADO_ID%TYPE,
                    PA_NUEVO_SALARIO IN TABLA.SALARIO%TYPE,
                    PA_EJECUCION    OUT NUMBER
                  )
        IS
BEGIN
    UPDATE TABLA
    SET SALARIO = PA_NUEVO_SALARIO
    WHERE EMPLEADO_ID = NVL(PA_EMPLEADO_ID, EMPLEADO_ID); -- Si PA_EMPLEADO_ID es NULL, no se actualizará ningún registro
    PA_EJECUCION := CSG_NVALORUNO;

    COMMIT;

EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
    PA_EJECUCION := CSG_NEJECINCON;
    VG_VORIGENERROR := 'PADM.SPUPDATE' || 'PA_EMPLEADO_ID:' || PA_EMPLEADO_ID 
                                       || 'PA_NUEVO_SALARIO:' || PA_NUEVO_SALARIO;
    VG_NCODIGOERROR := SQLCODE;
    VG_VDESCERROR   := SQLERRM;
    PKGLOGRESULTADOS.SPREGISTRAERROR(VG_NCODIGOERROR, VG_VDESCERROR, VG_VORIGENERROR);
END SPUPDATE;
/***************************************************************/

PROCEDURE SPDELETE(PA_EMPLEADO_ID IN TABLA.EMPLEADO_ID%TYPE
                  ,PA_EJECUCION  OUT NUMBER)
IS
BEGIN
    DELETE FROM TABLA
          WHERE EMPLEADO_ID = PA_EMPLEADO_ID;

    PA_EJECUCION := CSG_NVALORUNO;

    COMMIT;

EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
    PA_EJECUCION := CSG_NEJECINCON;
    VG_VORIGENERROR := 'PADM.SPDELETE' || 'PA_EMPLEADO_ID:' || PA_EMPLEADO_ID;
    VG_NCODIGOERROR := SQLCODE;
    VG_VDESCERROR   := SQLERRM;
    PKGLOGRESULTADOS.SPREGISTRAERROR(VG_NCODIGOERROR, VG_VDESCERROR, VG_VORIGENERROR);
END SPDELETE;

/***************************************************************/

PROCEDURE SPGET(PA_EMPLEADO_ID IN TABLA.EMPLEADO_ID%TYPE
                ,GET_CURSOR OUT SYS_REFCURSOR)
IS
BEGIN
OPEN                
    GET_CURSOR FOR
    SELECT EMPLEADO_ID
          ,SALARIO
    FROM TABLA
    WHERE EMPLEADO_ID = PA_EMPLEADO_ID;

EXCEPTION WHEN OTHERS THEN ROLLBACK;
    VG_VORIGENERROR := 'PADM.SPGET' || 'PA_EMPLEADO_ID:' || PA_EMPLEADO_ID;
    VG_NCODIGOERROR := SQLCODE;
    VG_VDESCERROR   := SQLERRM;
    PKGLOGRESULTADOS.SPREGISTRAERROR(VG_NCODIGOERROR, VG_VDESCERROR, VG_VORIGENERROR);
END SPGET;
END PADM;
/
SHOW ERRORS;

/******************** *70* BUSQUEDA DE OBJETOS EN LA BASE DE DATOS   ********************/

-- Validacion de objetos invalidos en la base de datos
SELECT object_name
    , object_type
    , status
FROM user_objects
WHERE status = 'INVALID';

-- Buscar dependencias de los objetos para identificar qué objetos se ven afectados por un cambio o eliminación

SELECT * FROM USER_DEPENDENCIES
WHERE referenced_name = 'NOMBRE_OBJETO'; -- Reemplazar con el nombre del objeto que quieres revisar

-- Validacion en compilacion al final del package body para verificar que no existan errores de sintaxis o semánticos
SHOW ERRORS;

-- Compilar mediante script
ALTER PACKAGE mi_paquete COMPILE;
ALTER PACKAGE mi_paquete COMPILE BODY;

-- Ver jobs creados en la base de datos
SELECT job_name
     , state
FROM user_scheduler_jobs;

/******************** EXPLAIN PLAN ********************/
/*
Es la estrategia que el motor de la base de datos decide usar para ejecutar tu query.
Antes de ejecutar un SELECT, Oracle analiza varias cosas:
índices
tamaño de tablas
estadísticas
joins
filtros

Con eso decide cuál es la forma más eficiente de obtener los datos.
*/

EXPLAIN plan 
FOR
SELECT * FROM  ventas_over;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
