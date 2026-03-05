/*
    PLSQL UTL_FILE

¿Que es UTL_FILE?
Es un paquete que permite interacturar con el sistema de archivos del servidor de la base de datos.
Algunas de sus funcionalidades son:
1. Escribir archivos (OUTPUT)
    1.1 TXT
    1.2 CSV
    1.3 Logs de ejecucion

2. Leer archivos (INPUT)
    2.1 Cargas masivas
    2.2 Interfaces externas

3. Validar archivos
    3.1 Existencia
    3.2 Formato correcto
    3.3 Contiene datos esperados

Se debe de tener en cuenta que las carpetas donde se guardaran los archivos las estara creando el DBA
y se deben de otorgar permisos a los usuarios que van a interactuar con dichas carpetas.
*/

-- Ejercicio 1: Crear un directorio en oracle y otorgar permisos al usuario actual.

CREATE OR REPLACE DIRECTORY_PRUEBA                      -- El nombre es generico
               AS '/u01/app/oracle/directorio_prueba';  -- Ruta del sistema de archivos del servidor

GRANT READ
     ,WRITE 
    ON DIRECTORY PRUEBA TO usuario_en_uso;

-- Ejercicio 2: Escribir un archivo de texto plano (TXT) con UTL_FILE.

DECLARE
    v_file UTL_FILE.FILE_TYPE;  -- Declaracion del paquete UTL_FILE y el tipo de dato FILE_TYPE

    BEGIN              

        v_file := UTL_FILE.FOPEN('DIRECTORY_PRUEBA'      -- Nombre del directorio creado
                                 ,'archivo_ejemplo.txt'  -- Nombre del archivo que se va abrir para escritura
                                 ,'W' -- W = Write (Escritura)
                                );
        
        UTL_FILE.PUT_LINE(v_file, 'Hola Mundo desde UTL_FILE'); -- Escribir una linea en el archivo

        UTL_FILE.FCLOSE(v_file); -- Cerrar el archivo
        END;

    /*

    Comparación rápida de modos:
    Modo | Descripción
    W    | Write (Escritura): Crea un nuevo archivo o sobrescribe uno existente.
    A    | Append (Agregar): Crea un archivo si no existe, agrega contenido si
    R    | Read (Lectura): Abre un archivo existente para leer su contenido, debe de existir o causa error.


    Los siguientes son sentencias para escribir, abrir o cerrar un archivo etc.
    UTL_FILE.FOPEN: Abre un archivo en el directorio especificado.
    ULT_FILE.PUT: Escribe texto sin salto de línea en el archivo abierto.
    UTL_FILE.PUT_LINE: Escribe una línea de texto en el archivo abierto.
    UTL_FILE.GET_LINE: Lee una línea de texto del archivo abierto.
    UTL_FILE.IS_OPEN: Verifica si un archivo está abierto.
    UTL_FILE.FCLOSE: Cierra el archivo abierto.

    Algunas exceptiones comunes son:
    UTL_FILE.INVALID_PATH: Ruta del archivo no válida
    UTL_FILE.INVALID_MODE: Modo de apertura no válido (w,a,r ...)
    UTL_FILE.INVALID_OPERATION: Operación no válida en el archivo
    UTL_FILE.WRITE_ERROR: Error al escribir en el archivo 
    UTL_FILE.READ_ERROR: Error al leer del archivo

    */

    -- Ejercicio 3: Crear, escribir y cerrar un archivo txt.

    DECLARE
        v_file UTL_FILE.FILE_TYPE;

    BEGIN
        v_file := UTL_FILE.FOPEN('DIRECTORY_PRUEBA', 'nuevo.txt', 'W'); -- Se crea el archivo, ya que sabemos que no existe.

        -- Escribir lineas en el archivo

        UTL_FILE.PUT_LINE(v_file, 'Primera linea del archivo.');
        UTL_FILE.PUT_LINE(v_file, 'Segunda linea del archivo.');
        UTL_FILE.PUT_LINE(v_file, 'Tercera linea del archivo.');

        UTL_FILE.FCLOSE(v_file); -- Cerrar el archivo
        END;




-- Ejercicio 4: Leer el archivo txt creado anteriormente y escribir su contenido en la consola.

DECLARE     
    v_file UTL_FILE.FILE_TYPE;
    v_line VARCHAR2(30000); -- Variable para almacenar cada linea leida del archivo

BEGIN
    v_file := UTL_FILE.FOPEN('DIRECTORY_PRUEBA', 'nuevo.txt', 'A'); -- Abrir el archivo en modo lectura

    UTL_FILE.PUT_LINE(v_file, 'Se agrega otra linea al archivo.'); -- Agregar una linea al archivo existente
    UTL_FILE.PUT_LINE(v_file, 'Otra linea mas al archivo.');         -- Se agrega otra linea al archivo existente

    UTL_FILE.FCLOSE(v_file); -- Cerrar el archivo           

-- Dentro del mismo bloque, vamos a mostrar leer el archivo y mostrarlo en la consola

    v_file := UTL_FILE.FOPEN('DIRECTORY_PRUEBA', 'nuevo.txt', 'R'); -- Abrir el archivo en modo lectura

    LOOP 
        BEGIN
            UTL_FILE.GET_LINE(v_file, v_line);      -- Leer una linea del archivo y almacenarla en la variable v_line
            DBMS_OUTPUT.PUT_LINE(v_line);           -- Mostrar la linea leida en la consola
            EXCEPTION 
                WHEN NO_DATA_FOUND THEN             -- Manejar la excepcion cuando no hay mas lineas para leer
                    EXIT;                           -- Salir del bucle
                END;
                END LOOP;
            UTL_FILE.FCLOSE(v_file);                 -- Cerrar el archivo
        EXCEPTION
  WHEN UTL_FILE.INVALID_PATH THEN
    DBMS_OUTPUT.PUT_LINE('Ruta inválida');
  WHEN UTL_FILE.INVALID_MODE THEN
    DBMS_OUTPUT.PUT_LINE('Modo inválido');
  WHEN UTL_FILE.INVALID_OPERATION THEN
    DBMS_OUTPUT.PUT_LINE('Operación no permitida');
  WHEN UTL_FILE.WRITE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('Error al escribir');
  WHEN UTL_FILE.READ_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('Error al leer');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
            END;

-- Ejercicio 5: Crear un archivo CSV con datos de una tabla
DECLARE
    v_file UTL_FILE.FILE_TYPE;
    CURSOR c_empleados IS
        SELECT empleado_id, nombre, salario FROM empleados; -- Suponiendo que existe una tabla empleados

    v_empleado c_empleados%ROWTYPE;
BEGIN
    v_file := UTL_FILE.FOPEN('DIRECTORY_PRUEBA', 'empleados.csv', 'W'); -- Crear el archivo CSV
    UTL_FILE.PUT_LINE(v_file, 'Empleado_ID,Nombre,Salario'); -- Escribir la cabecera del CSV

    OPEN c_empleados;
    LOOP
        FETCH c_empleados INTO v_empleado;
        EXIT WHEN c_empleados%NOTFOUND;

        -- Escribir los datos en formato CSV
        UTL_FILE.PUT_LINE(v_file, v_empleado.empleado_id || ',' || v_empleado.nombre || ',' || v_empleado.salario);
    END LOOP;
    CLOSE c_empleados;
    UTL_FILE.FCLOSE(v_file); -- Cerrar el archivo
END;


/* 
Examen 
Se tiene una tabla, con número de pólizas y montos de cada póliza, puede haber pólizas repetidas y con montos diferentes
1 .- Un bloque anónimo que haga la suma de los montos de las pólizas que se repiten */

DECLARE 
        v_no_poliza   NUMBER;   -- Numero de polizas
        v_monto_total NUMBER;   -- Monto de cada poliza
    

BEGIN
    SELECT no_poliza
           ,SUM(monto) 
      INTO v_no_poliza
          ,v_monto_total
    FROM mst_polizas
   GROUP BY no_poliza
    HAVING COUNT(*) > 1;
    
     DBMS_OUTPUT.PUT_LINE('Poliza: ' || v_no_poliza || ' Monto Total: ' || v_monto_total);
EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No hay polizas repetidas.');
END;

--2 .- Crear una secuencia

CREATE SEQUENCE seq_polizas
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- 3.- Hacer un reporte con salida txt con el resultado del bloque anónimo y utilizando la secuencia para que la inserte en el listado del reporte

 DECLARE
    v_file UTL_FILE.FILE_TYPE;
    v_secuencia   NUMBER;
BEGIN
    v_file := UTL_FILE.FOPEN('DIRECTORY_EXAMEN', 'polizas.txt', 'W');  -- Abrir archivo
   
    FOR r IN (  -- Loop para manejar múltiples pólizas
        SELECT no_poliza,
               agregar_iva(SUM(monto)) AS monto_total
          FROM mst_polizas
         GROUP BY no_poliza
        HAVING COUNT(*) > 1
    ) LOOP

        v_secuencia := seq_polizas.NEXTVAL;

        UTL_FILE.PUT_LINE(v_file,'Secuencia: ' || v_secuencia ||' Poliza: ' || r.no_poliza ||' Monto Total: ' || r.monto_total
        );

    END LOOP;
    
    UTL_FILE.FCLOSE(v_file); -- Cerrar archivo

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No hay polizas repetidas.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


-- 4.-  Crear una función para que al monto se le agregue el IVA y que esa función la agregue al bloque.
 
        CREATE OR REPLACE FUNCTION agregar_iva(p_monto NUMBER)
        RETURN NUMBER
        AS
            v_monto_con_iva NUMBER;
        BEGIN
            v_monto_con_iva := p_monto * 1.16; -- Asumiendo un IVA del 16%
            RETURN v_monto_con_iva;
        END;