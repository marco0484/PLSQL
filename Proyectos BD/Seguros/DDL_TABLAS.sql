/* Tabla maestra de clientes */
create table seguros.mst_socios
							  (
							   cod_socio 		smallint
							  ,fcnombre_socio   char(100)
							  ,cod_tipo_puesto  smallint  -- Hacer catalogo de puestos
							  ,cod_responsable  smallint
							  ,ind_activo		smallint
							  ,fyh_carga 		timestamp default current_timestamp
							  ,fyh_modificacion timestamp default current_timestamp
							  );

/** Tabla de puestos **/
create table seguros.cat_puestos
								(
								cod_tipo_puesto smallint
								,desc_puesto	char(50)
								,ind_activo		smallint
								,fyh_carga 		timestamp default current_timestamp
							    ,fyh_modificacion timestamp default current_timestamp
								);


/* Tabla de datos generales */
create table seguros.cat_datos_generales
							  (
							   cod_folio_c4     bigint
							  ,cod_socio 		smallint
							  ,num_edad_socio   smallint
							  ,fyh_nacimiento   timestamp
							  ,cod_ciudad		char(50)  -- catalogo de ciudades junto con municipio
							  ,cod_estado		char(50) 
							  ,num_latitud	    numeric(15, 8)
							  ,num_longitud	    numeric(15, 8)
							  ,ind_caso_activo  smallint
							  ,cod_parte_cuerpo_afectada smallint -- partes del cuerpo
							  ,bnd_lado_afectado smallint -- 1 izq, 2 derecha
							  ,fyh_carga 		timestamp default current_timestamp
							  ,fyh_modificacion timestamp default current_timestamp
							  );



/* Tabla de datos del conyuge*/
create table seguros.det_conyuge
							(
								 cod_folio_c4 bigint
								,desc_nombre  char(100)
								,num_edad	  smallint
								,num_telefono numeric(20)
								,fyh_carga 		timestamp default current_timestamp
							    ,fyh_modificacion timestamp default current_timestamp
							);



/* Tabla de diagnostico medico */
create table seguros.det_diagostico_med
									(
									  cod_folio_c4        bigint
									 ,bnd_estado_conciente smallint -- 1 si, 0 no
									 ,ind_estado_salud    smallint -- Hacer catalogo  -> Bueno, malo, descuidado etc
									 ,desc_atencion_medica char(1000)
									 ,fyh_carga 		timestamp default current_timestamp
							   		 ,fyh_modificacion timestamp default current_timestamp
									);



/* Catlogo de salud del socio*/
create table seguros.cat_estado_salud
						(
						 ind_estado_salud  smallint
						,desc_estado_socio char(100)
						,ind_activo		  smallint
						,fyh_carga 		timestamp default current_timestamp
					    ,fyh_modificacion timestamp default current_timestamp
						);



/* Tabla de eventos (Accidente,robo,agresion,fatalidad,asalto)*/	
create table seguros.det_eventos_seguros
								(
								   cod_folio_c4        bigint
								  ,cod_tipo_evento     smallint -- Catalogo de agresion,asalto,robo,accidente
								  ,desc_causa		   char(1000)
								  ,desc_lugar_evento   char(1000)
								  ,nombre_involucrado  char(100)
								  ,num_modelo_vehiculo bigint
								  ,num_serie_vehiculo  bigint
								  ,ind_tipo_vehiculo   smallint -- Catalogo moto o coche, camioneta, trailer
								  ,fyh_carga 		   timestamp default current_timestamp
								  ,fyh_modificacion    timestamp default current_timestamp
								);



--drop table cat_eventos;
create table seguros.cat_eventos
						(
						 cod_tipo_evento  smallint
						,desc_tipo_evento char(100)
						,ind_activo		  smallint
						,fyh_carga 		  timestamp default current_timestamp
					    ,fyh_modificacion timestamp default current_timestamp
						);



/**Tabla de la parte del cuerpo afectada*/
create table seguros.cat_partes_cuerpo
										(
										cod_parte_cuerpo_afectada smallint
										,desc_parte_cuerpo 		  char(30)
										,ind_activo 			  smallint
										,fyh_carga 				  timestamp default current_timestamp
					    				,fyh_modificacion 		  timestamp default current_timestamp
										);


/***/


-- Oracle


/*

/* Tabla maestra de clientes */
CREATE TABLE seguros.mst_socios (
  cod_socio            NUMBER(5),
  fcnombre_socio       VARCHAR2(100),
  cod_tipo_puesto      NUMBER(5),
  cod_responsable      NUMBER(5),
  ind_activo           NUMBER(1),
  fyh_carga            TIMESTAMP DEFAULT SYSTIMESTAMP,
  fyh_modificacion     TIMESTAMP DEFAULT SYSTIMESTAMP
);

/* Tabla de puestos */
CREATE TABLE seguros.cat_puestos (
  cod_tipo_puesto      NUMBER(5),
  desc_puesto          VARCHAR2(50),
  ind_activo           NUMBER(1),
  fyh_carga            TIMESTAMP DEFAULT SYSTIMESTAMP,
  fyh_modificacion     TIMESTAMP DEFAULT SYSTIMESTAMP
);

/* Tabla de datos generales */
CREATE TABLE seguros.cat_datos_generales (
  cod_folio_c4               NUMBER(19),
  cod_socio                  NUMBER(5),
  num_edad_socio             NUMBER(3),
  fyh_nacimiento             TIMESTAMP,
  cod_ciudad                 VARCHAR2(50),
  cod_estado                 VARCHAR2(50),
  num_latitud                NUMBER(15,8),
  num_longitud               NUMBER(15,8),
  ind_caso_activo             NUMBER(1),
  cod_parte_cuerpo_afectada  NUMBER(5),
  bnd_lado_afectado           NUMBER(1),
  fyh_carga                  TIMESTAMP DEFAULT SYSTIMESTAMP,
  fyh_modificacion           TIMESTAMP DEFAULT SYSTIMESTAMP
);

/* Tabla de datos del conyuge */
CREATE TABLE seguros.det_conyuge (
  cod_folio_c4        NUMBER(19),
  desc_nombre         VARCHAR2(100),
  num_edad            NUMBER(3),
  num_telefono        NUMBER(20),
  fyh_carga           TIMESTAMP DEFAULT SYSTIMESTAMP,
  fyh_modificacion    TIMESTAMP DEFAULT SYSTIMESTAMP
);

/* Tabla de diagnostico medico */
CREATE TABLE seguros.det_diagostico_med (
  cod_folio_c4            NUMBER(19),
  bnd_estado_conciente    NUMBER(1),
  ind_estado_salud        NUMBER(5),
  desc_atencion_medica    VARCHAR2(1000),
  fyh_carga               TIMESTAMP DEFAULT SYSTIMESTAMP,
  fyh_modificacion        TIMESTAMP DEFAULT SYSTIMESTAMP
);

/* Catalogo de salud del socio */
CREATE TABLE seguros.cat_estado_salud (
  ind_estado_salud     NUMBER(5),
  desc_estado_socio    VARCHAR2(100),
  ind_activo           NUMBER(1),
  fyh_carga            TIMESTAMP DEFAULT SYSTIMESTAMP,
  fyh_modificacion     TIMESTAMP DEFAULT SYSTIMESTAMP
);

/* Tabla de eventos */
CREATE TABLE seguros.det_eventos_seguros (
  cod_folio_c4          NUMBER(19),
  cod_tipo_evento       NUMBER(5),
  desc_causa            VARCHAR2(1000),
  desc_lugar_evento     VARCHAR2(1000),
  nombre_involucrado    VARCHAR2(100),
  num_modelo_vehiculo   NUMBER(19),
  num_serie_vehiculo    NUMBER(19),
  ind_tipo_vehiculo     NUMBER(1),
  fyh_carga             TIMESTAMP DEFAULT SYSTIMESTAMP,
  fyh_modificacion      TIMESTAMP DEFAULT SYSTIMESTAMP
);

/* Catalogo de eventos */
CREATE TABLE seguros.cat_eventos (
  cod_tipo_evento      NUMBER(5),
  desc_tipo_evento     VARCHAR2(100),
  ind_activo           NUMBER(1),
  fyh_carga            TIMESTAMP DEFAULT SYSTIMESTAMP,
  fyh_modificacion     TIMESTAMP DEFAULT SYSTIMESTAMP
);

/* Tabla de partes del cuerpo */
CREATE TABLE seguros.cat_partes_cuerpo (
  cod_parte_cuerpo_afectada NUMBER(5),
  desc_parte_cuerpo         VARCHAR2(30),
  ind_activo                NUMBER(1),
  fyh_carga                 TIMESTAMP DEFAULT SYSTIMESTAMP,
  fyh_modificacion          TIMESTAMP DEFAULT SYSTIMESTAMP
);

*/