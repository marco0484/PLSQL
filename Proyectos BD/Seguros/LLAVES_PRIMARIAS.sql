alter table seguros.mst_socios
add constraint rpk_01_seguros
primary key (cod_socio);

alter table seguros.cat_puestos
add constraint rpk_02_puestos
primary key (cod_tipo_puesto);

alter table seguros.cat_datos_generales
add constraint rpk_03_dgenerales
primary key(cod_folio_c4);

alter table seguros.det_conyuge
add constraint rpk_04_dconyuge
primary key (cod_folio_c4);

alter table seguros.det_diagostico_med
add constraint rpk_05_diagnostico
primary key (cod_folio_c4);

alter table seguros.cat_estado_salud
add constraint rpk_06_estsalud
primary key (ind_estado_salud);

alter table seguros.det_eventos_seguros
add constraint rpk_07_deventos
primary key (cod_folio_c4);

alter table seguros.cat_eventos
add constraint rpk_08_ceventos
primary key (cod_tipo_evento);

alter table seguros.cat_partes_cuerpo
add constraint rpk_09_pcuerpo
primary key (cod_parte_cuerpo_afectada);