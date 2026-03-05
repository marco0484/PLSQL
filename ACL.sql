/*
Pasos para crear un ACL y poder usarlo en oracle local
*/

-- Estar como sys o sysdba y ejecutar el siguiente scipt

BEGIN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(
    acl         => 'acl_utl_http.xml',
    description => 'Permisos para UTL_HTTP en local',
    principal   => 'TU_USUARIO',
    is_grant    => TRUE,
    privilege   => 'connect'
  );
END;

-- Dar permisos de resolucion de nombres DNS

BEGIN
  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(
    acl       => 'acl_utl_http.xml',
    principal => 'TU_USUARIO',
    is_grant  => TRUE,
    privilege => 'resolve'
  );
END;

-- Asignar el ACL a la direccion local

BEGIN
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(
    acl  => 'acl_utl_http.xml',
    host => 'localhost'
  );
END;

-- O si se va trabajar con una IP local:

BEGIN
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(
    acl  => 'acl_utl_http.xml',
    host => '127.0.0.1'
  );
END;

COMMIT;

/
-- Verificar permisos:

SELECT * FROM dba_network_acls;
SELECT * FROM dba_network_acl_privileges;

-- Realizar la sigueinte prueba:

SET SERVEROUTPUT ON

DECLARE
  v_req  UTL_HTTP.req;
  v_resp UTL_HTTP.resp;
  v_text VARCHAR2(32767);
BEGIN
  v_req := UTL_HTTP.begin_request('http://localhost', 'GET');
  v_resp := UTL_HTTP.get_response(v_req);

  LOOP
    UTL_HTTP.read_text(v_resp, v_text);
    DBMS_OUTPUT.put_line(v_text);
  END LOOP;

  UTL_HTTP.end_response(v_resp);
END;
/

