Cursores en PLSQL
¿Que es un cursor?
R= Es el resultado de una consulta existen dos tipos, implicitos y explicitos

Cursores implicitos, para trabajar con estos debemos de guardar cada 1 de las columnas
que regresara en variables y dicha consulta no debera regresarnos mas de un registro
en cada iteracion, de lo contrario nos devolvera un error de "to many rows", una vez que tengamos
el resultado podemos hacer un insert, update o delete con esos registros o registro
--Ejemplo:

SELECT id_articulo
      ,desc_articulo
      ,ind_activo
INTO
    v_articulo
    ,v_desc_articulo
    v_ind_activo
FROM TABLE;

Cursores explicitos es cuando nosotros lo declaramos, hacemos fetch y luego lo cerramos, el 
fetch es la instruccion que extrae solo una fila del cursor ya abierto y se asigna a las
variables into declaradas con antelacion.

--Ejemplo:
BEGIN
        DECLARE
            CURSOR CURSOR_1 IS
                SELECT ID_ARTICULO, DES_ART, IND_ACTIVO
                FROM ARTICULOS;
        BEGIN
            OPEN CURSOR_1;

            LOOP
                FETCH CURSOR_1 INTO V_IDARTICULO, V_DESC_ART, V_IND_ACT;
                EXIT WHEN CURSOR_1%NOTFOUND;

                DBMS_OUTPUT.PUT_LINE(
                    'ID: ' || V_IDARTICULO ||
                    ' | DESC: ' || V_DESC_ART ||
                    ' | ACTIVO: ' || V_IND_ACT
                );
            END LOOP;
            CLOSE CURSOR_1;

Con cursores explícitos, NO_DATA_FOUND no se dispara dentro del FETCH,
 porque el cursor nunca lanza esa excepción.
En FETCH usamos EXIT WHEN cursor%NOTFOUND.

/***********************/

Funciones
Es un bloque plsql el cual puede recibir parametros de entrada, realiza operaciones como una consulta y regresa como 
salida un solo valor return, se puede utilizar dentro de un insert, update, delete o hasta en un merge

Ejemplo basico:

create or replace 
FUNCTION MATEHUALA0484_SCHEMA_H9HQH.suma(a NUMBER, b NUMBER)
RETURN NUMBER AS
BEGIN
  RETURN a + b;
END;

Una vez definida nuestra funcion, procedemos a invocarla en una consulta:

SELECT MATEHUALA0484_SCHEMA_H9HQH.suma(2, 3) AS resultado
FROM dual;

/***********************/


Para mostrar errores en objetos de la base de datos?
Utilizamos:
SHOW ERRORS FUNCTION MATEHUALA0484_SCHEMA_H9HQH.suma;

/***/

Operadores logicos = AND, NOT, OR