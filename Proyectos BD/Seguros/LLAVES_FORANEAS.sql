alter table seguros.mst_socios
add constraint rfk_01_puestos
foreign key (cod_tipo_puesto)
references seguros.cat_puestos(cod_tipo_puesto);

alter table seguros.cat_datos_generales
add constraint rfk_02_socios
foreign key (cod_socio)
references seguros.mst_socios(cod_socio);

alter table seguros.det_conyuge
add constraint rfk_03_conyuge
foreign key (cod_folio_c4)
references seguros.cat_datos_generales(cod_folio_c4);

alter table seguros.det_diagostico_med
add constraint rfk_04_diagnostico
foreign key (cod_folio_c4)
references seguros.cat_datos_generales(cod_folio_c4);

alter table seguros.det_diagostico_med
add constraint rfk_05_isalud
foreign key (ind_estado_salud)
references seguros.cat_estado_salud (ind_estado_salud);

alter table seguros.det_eventos_seguros
add constraint rfk_06_deventos
foreign key (cod_folio_c4)
references seguros.cat_datos_generales(cod_folio_c4);

alter table seguros.det_eventos_seguros
add constraint rfk_07_ceventos
foreign key (cod_tipo_evento)
references seguros.cat_eventos(cod_tipo_evento);

alter table seguros.cat_datos_generales
add constraint rfk_08_pcuerpo
foreign key (cod_parte_cuerpo_afectada)
references seguros.cat_partes_cuerpo (cod_parte_cuerpo_afectada);

