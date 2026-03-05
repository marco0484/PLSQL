CREATE OR REPLACE package paq_promociones_util
AS
    PROCEDURE prc_ban_promociones(
                                 p_cod_cliente   IN mst_clientes_promociones.cod_cliente%TYPE,
                                 p_codigo_error OUT NUMBER,
                                 p_bandera      OUT NUMBER,
                                 p_mensaje      OUT VARCHAR2,
                                );
END paq_promociones_util;
/
CREATE OR REPLACE package body paq_promociones_util
AS
    PROCEDURE prc_ban_promociones(
                                    p_cod_cliente   IN mst_clientes_promociones.cod_cliente%TYPE,
                                    p_codigo_error OUT NUMBER,
                                    p_bandera      OUT NUMBER,
                                    p_mensaje      OUT VARCHAR2,
                              )
    IS
        v_promociones NUMBER;
        
    BEGIN
        SELECT 1
        INTO v_promociones
        FROM mst_clientes_promociones promo
        WHERE promo.cod_cliente = p_cod_cliente
        FETCH FIRST 1 ROWS ONLY;

        EXCEPTION WHEN NO_DATA_FOUND 
                  THEN RAISE v_ex_promocion;


