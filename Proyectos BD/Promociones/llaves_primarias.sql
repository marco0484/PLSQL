alter table mst_clientes_promociones 
add constraint RPK_01_PROMOCIONES
primary key (cod_cliente);

alter table cat_promociones 
add constraint RPK_02_PROMOCIONES
primary key (cod_promocion);

alter table detalle_promociones 
add constraint RPK_03_PROMOCIONES
primary key (cod_promocion);

alter table rel_exclusion_promociones 
add constraint RPK_04_PROMOCIONES
primary key (cod_cliente,cod_exclusion);

alter table cat_motivo_exclusion_promo 
add constraint RPK_05_PROMOCIONES
primary key (cod_exclusion);