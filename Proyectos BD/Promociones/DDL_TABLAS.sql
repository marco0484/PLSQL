create table mst_clientes_promociones
									(
									cod_cliente      NUMBER NOT NULL,
									bnd_contratacion NUMBER NOT NULL,
									fyh_carga 		 DATE NOT NULL,
									fyh_modificacion DATE NOT NULL
									);

create table cat_promociones
							(
								 cod_promocion    NUMBER NOT NULL
								,titulo_promocion VARCHAR2(100) NOT NULL
								,ind_activo       NUMBER NOT NULL
                                ,fyh_carga        DATE NOT NULL
                                ,fyh_modificacion DATE NOT NULL
							);

CREATE TABLE detalle_promociones
								(
									cod_promocion    NUMBER NOT NULL,
									detalle_promocion VARCHAR2(100) NOT NULL,
									ind_activo       NUMBER NOT NULL,
									fyh_carga        DATE NOT NULL,
									fyh_modificacion DATE NOT NULL
								);

CREATE TABLE rel_exclusion_promociones
								(
									cod_cliente      NUMBER NOT NULL,
									cod_exclusion    NUMBER NOT NULL,
                                    ind_activo       NUMBER NOT NULL,   
									fyh_carga        DATE NOT NULL,
									fyh_modificacion DATE NOT NULL
								);

CREATE TABLE cat_motivo_exclusion_promo(
                                    cod_exclusion NUMBER NOT NULL
                                    ,desc_exclusion VARCHAR2(100) NOT NULL
                                    ,ind_activo NUMBER NOT NULL
                                    ,fyh_carga DATE NOT NULL
                                    ,fyh_modificacion DATE NOT NULL
                                        );
                                



