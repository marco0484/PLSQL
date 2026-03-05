/*
PLSQL DBMS_OUTPUT
Podemos verlo como un canal comunicación entre el motor de la base de datos y desarrollador. 
Permite enviar mensajes de depuración, información o resultados intermedios
para el analisis del código PL/SQL.

Otros usos: 
1. Ver valores
2. Seguimiento de flujo de ejecución
3. Validar lógica
4. Auditoria de procesos
5. Simular reportes

Depende del majeador que se este utilizando, puede ser necesario habilitar la salida con algun
comando especifico o en su defecto buscar la opcion en la interfaz grafica.

*/

-- Ejercicio 1: Mostrar cualquier mensaje en la salida dbms_output.

SET SERVEROUTPUT ON;

DECLARE
        v_edad NUMBER;

BEGIN
        SELECT edad
        INTO v_edad
        FROM mst_empleados
        WHERE empleado_id = 10;

    DBMS_OUTPUT.PUT_LINE('La edad del empleado es: ' || v_edad);
END;