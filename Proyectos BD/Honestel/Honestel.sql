CREATE SCHEMA HONESTEL;

commit;

CREATE TABLE HONESTEL.TASUFOLIOS_HON
										(
											 FIFOLIO_ID 	        int
											,FICASO_ID  	        int
											,FCFECHA_CREACION       varchar(50)
											,FCFECHA_ASIGNACION     varchar(50)
											,FCTICKET_TIPO          varchar(50)
											,FCDESCRIPCION 		    varchar(50)
											,FCDESCRIPCION2		    varchar(50)
											,FCAREA_ASIG			varchar(50)
											,FCESTATUS				varchar(50)
											,FCRESUL_DEN			varchar(50)
											,FCFECHA_CIERRE			varchar(50)
											,FCFECHA_RESUELTO		varchar(50)
											,FCANAL_ORIGEN			varchar(50)
											,FCANONIMATO 			varchar(50)
											,FCAGENTE_ASIG 			varchar(50)
											,FCFECHA_STANDBY 		varchar(50)
											,FCATENDEDOR			varchar(50)
											,FCORREO_ATENDEDOR 		varchar(50)
											,FCESTADO				varchar(50)
											,FCREUCPERACION			varchar(50)
											,FCONCLUCIONES			varchar(50)
											,FIHORAS_INVES			int
											,FDULTIMA_MODIFICACION  DATE
											,FCUSUARIO_MODIFICO     varchar(30)
										);
										/
		ALTER TABLE HONESTEL.TASUFOLIOS_HON ADD CONSTRAINT PK_HON_01 PRIMARY KEY (FIFOLIO_ID);
	/
	CREATE TABLE HONESTEL.TASUDENUNXFOL_HON
											(
												 FIFOLIO_ID				int
												,FIDENUN_ID 			int
												,FINUNDENUN_ID			int
												,FCNOMBRE_DENUNCIADO	varchar(100)
												,FCPUESTO_DENUNCIADO 	varchar(100)
												,FCOMPANIA_DENUNCIADO 	varchar(70)
												,FCUBICA_DENUNCIADO 	varchar(50)
												,FCESTADO_DENUNCIADO 	varchar(50)
												,FCDEPART_DENUNCIADO	varchar(50)
												,FCREPONSABLE_DENUN	 	varchar(50)
												,FDULTIMA_MODIFICACION  DATE
												,FCUSUARIO_MODIFICO		varchar(50)
											);

	ALTER TABLE HONESTEL.TASUDENUNXFOL_HON ADD CONSTRAINT PK_HON_02 PRIMARY KEY (FIFOLIO_ID,FIDENUN_ID);
	ALTER TABLE HONESTEL.TASUDENUNXFOL_HON ADD CONSTRAINT FK_HON_01 FOREIGN KEY (FIFOLIO_ID) REFERENCES HONESTEL.TASUFOLIOS_HON;
		/
		
		CREATE TABLE HONESTEL.TASUDENUNCT_HON
											(
												FIFOLIO_ID      	 	int
											   ,FISOCIO_DENUNCIANTE	 	int
											   ,FCNOMBRE_DENUNCIANTE 	varchar(50)
											   ,FCPUESTO_DENUNCIANTE	varchar(50)
											   ,FCORREO_DENUNCIANTE		varchar(50)
											   ,FCTEL_DENUNCIANTE		varchar(50)
											   ,FCDEPART_DENUNCIANTE	varchar(50)
											   ,FICONTAC_DENUNCIANTE	varchar(50)
											   ,FCMEDIOCONT_DENUNCIANTE	varchar(50)
											   ,FCHALLAZGO_DENUNCIANTE	varchar(50)
											   ,FDULTIMA_MODIFICACION	DATE
											   ,FCUSUARIO_MODIFICO		varchar(50)
											);
										/
CREATE TABLE HONESTEL.TASUINVOLU_HON (
									    FIFOLO_ID           int,
									    FINVOLUCRADO_ID     int,
									    FINVOLUCRADO_DESC   varchar(4000),
									    FDULTIMA_MODIFICACION DATE,
									    FCUSUARIO_MODIFICO  varchar(30),
									    FCNOMBRE_INVOLUCRADO varchar(80),
									    FCPUESTO_INVOLUCRADO varchar(110),
									    FCCOMPANIA_INVOLUCRADO varchar(80),
									    FCHALLAZGO_1_INVOL  varchar(80 ),
									    FCHALLAZGO_2_INVOL  varchar(80 ),
									    FCONSECUENCIA_INVOL varchar(80 ),
									    FCRESPON_EJEC_INVOL varchar(80 ),
									    FCFECHA_EJEC_INVOL  varchar(80 ),
									    FCNIVEL_MANDO_INVOL varchar(110 ));
/

CREATE TABLE HONESTEL.TASUFOLIOS2_HON (
									    FIFOLO_ID           int ,
									    FIGRAVEDAD_ID       int,
									    FIURGEN_ID          int,
									    FDULTIMA_MODIFICACION DATE,
									    FCUSUARIO_MODIFICO  varchar(30)
									);
									
								/
								
CREATE TABLE HONESTEL.TASUTMXDNXF_HON (
										    FIFOLO_ID            int,
										    FIDENUN_ID           int,
										    FITEMA_ID            int,
										    FCTEMA_DESC          varchar(500),
										    FCCOMP_DESC          varchar(500),
										    FDULTIMA_MODIFICACION DATE,
										    FCUSUARIO_MODIFICO  varchar(30)
										);