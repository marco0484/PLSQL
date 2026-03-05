/*
PLSQL LOB
LOB = Large Object

Sirve para almacenar grandes cantidades de datos que no caben en un varchar2 o un clob normal

| Tipo     | Para qué sirve                                     |
| -------- | -------------------------------------------------- |
| **CLOB** | Texto grande (XML, JSON, HTML, logs)               |
| **BLOB** | Binario (PDF, imágenes, ZIP)                       |
| NCLOB    | Texto con juego de caracteres nacional (raro)      |
| BFILE    | Archivo externo (solo lectura, casi no se usa hoy) |

Comparación LOB vs VARCHAR2

| VARCHAR2          | CLOB                       |
| ----------------- | -------------------------- |
| Hasta 32 KB       | Hasta GB                   |
| Se maneja directo | Se maneja con **DBMS_LOB** |
| Simple            | Más control                |


Un LOB no vive en una variable como cualquier cosa, normalmente vive en una tabla.
*/

-- Ejemplo creacion de un contenido LOB

CREATE TABLE mst_documentos (
     id_documento NUMBER
    ,contenido CLOB
                            );

/*
Antes de continuar es necesario especificar que existen varias sentencias para escribir y leer LOB

| Sentencia              | Para qué sirve              |
| ---------------------- | --------------------------- |
| EMPTY_CLOB()           | Crear el contenedor vacío   |
| RETURNING ... INTO     | Obtener la referencia       | -- No es mas que una variable que apunta al LOB
| DBMS_LOB.WRITE         | Escribir en posición exacta |
| DBMS_LOB.WRITEAPPEND   | Agregar al final            |
| DBMS_LOB.GETLENGTH     | Saber tamaño                |
| DBMS_LOB.SUBSTR        | Leer                        |
| DBMS_LOB.ERASE         | Borrar parte                |

*/
-- Insertando un registro
SET SERVEROUTPUT ON;

DECLARE
    v_clob        CLOB;                 -- CLOB donde trabajaremos
    v_texto       VARCHAR2(1000);        -- Texto auxiliar
    v_longitud    NUMBER;                -- Longitud del CLOB
    v_leido       VARCHAR2(32767);       -- Para leer contenido
     v_borrar NUMBER := 7;
BEGIN
    ------------------------------------------------------------------
    -- 1️⃣ CREAR REGISTRO CON CLOB VACÍO
    ------------------------------------------------------------------
    INSERT INTO mst_documentos (id_documento, contenido)
    VALUES (1, EMPTY_CLOB())

    RETURNING contenido 
           INTO v_clob; -- RETURNING nos da la REFERENCIA al CLOB recién creado
    DBMS_OUTPUT.PUT_LINE('CLOB creado');

    ------------------------------------------------------------------
    -- 2️⃣ ESCRIBIR TEXTO INICIAL (WRITE)
    ------------------------------------------------------------------
    v_texto := 'Inicio del reporte';

    DBMS_LOB.WRITE(
        v_clob,                 -- DÓNDE escribo
        LENGTH(v_texto),        -- CUÁNTO escribo
        1,                      -- DESDE DÓNDE (inicio)
        v_texto                 -- QUÉ escribo
    );

    DBMS_OUTPUT.PUT_LINE('Texto inicial escrito');

    ------------------------------------------------------------------
    -- 3️⃣ AGREGAR TEXTO AL FINAL (WRITEAPPEND)
    ------------------------------------------------------------------
    v_texto := CHR(10) || 'Segunda línea del reporte';

    DBMS_LOB.WRITEAPPEND(
        v_clob,                 -- DÓNDE
        LENGTH(v_texto),        -- CUÁNTO
        v_texto                 -- QUÉ
    );

    DBMS_OUTPUT.PUT_LINE('Texto agregado al final');

    ------------------------------------------------------------------
    -- 4️⃣ CONSULTAR LONGITUD DEL CLOB (GETLENGTH)
    ------------------------------------------------------------------
    v_longitud := DBMS_LOB.GETLENGTH(v_clob);

    DBMS_OUTPUT.PUT_LINE('Longitud actual del CLOB: ' || v_longitud);

    ------------------------------------------------------------------
    -- 5️⃣ LEER CONTENIDO DEL CLOB (SUBSTR)
    ------------------------------------------------------------------
    v_leido := DBMS_LOB.SUBSTR(
                    v_clob,     -- DESDE QUÉ CLOB
                    32767,      -- CUÁNTOS CARACTERES
                    1           -- DESDE DÓNDE
               );

    DBMS_OUTPUT.PUT_LINE('Contenido del CLOB:');
    DBMS_OUTPUT.PUT_LINE(v_leido);

    ------------------------------------------------------------------
    -- 6️⃣ BORRAR PARTE DEL CLOB (ERASE)
    -- Borra 7 caracteres desde la posición 1
    ------------------------------------------------------------------
    DBMS_LOB.ERASE(
        v_clob,     -- CLOB
        v_borrar,          -- CUÁNTOS caracteres borrar
        1           -- DESDE DÓNDE
    );

    DBMS_OUTPUT.PUT_LINE('Se borraron los primeros caracteres');

    ------------------------------------------------------------------
    -- 7️⃣ LEER DE NUEVO PARA VER CAMBIOS
    ------------------------------------------------------------------
    v_leido := DBMS_LOB.SUBSTR(v_clob, 32767, 1);

    DBMS_OUTPUT.PUT_LINE('Contenido después del borrado:');
    DBMS_OUTPUT.PUT_LINE(v_leido);

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*
Salida DBMS del insert:
1.LOB creado
2.Texto inicial escrito
3.Texto agregado al final
4.Longitud actual del CLOB: 44
5.Contenido del CLOB:
5.1.Inicio del reporte
5.2.Segunda línea del reporte
6.Se borraron los primeros caracteres
7.Contenido después del borrado:
7.1       del reporte
7.2Segunda línea del reporte
*/