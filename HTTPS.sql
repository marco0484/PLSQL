/*
    PLSQL UTL_HTTP (APIs y Web)

    Es otro paquete dentro de PLSQL el cual nor permite:
    1. Hacer solicitudes HTTP(S) desde la base de datos
    2. Recibir respuestas (texto o JSON)
    3. Guardarlas en CLOB para procesarlas después

SENTENCIAS PRINCIPALES

| Función / Procedimiento       | Qué hace                                             |
| ----------------------------- | ---------------------------------------------------- |
| UTL_HTTP.BEGIN_REQUEST(url)   | Inicia la petición HTTP                              |
| UTL_HTTP.SET_HEADER           | Configura cabeceras (tipo JSON, autenticación, etc.) |
| UTL_HTTP.GET_RESPONSE         | Recibe la respuesta de la petición                   |
| UTL_HTTP.READ_TEXT            | Lee el contenido línea por línea o en bloques        |
| UTL_HTTP.END_RESPONSE         | Cierra la respuesta y libera recursos                |
*/

-- Ejercicio 1 hacer un peticion a un servicio JSON y mostrar la respuesta en la consola