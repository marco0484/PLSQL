alter table tiendas.articulos_corr 
add constraint pk_art_01
primary key (id_art,co_cve_str);

alter table tiendas.articulos 
add constraint pk_tiendas_01
primary key (id_art);

alter table tiendas.categorias
add constraint pk_tiendas_02
primary key (cat_cve_n);

alter table tiendas.colores 
add constraint pk_tiendas_03
primary key (col_cve_n);

alter table tiendas.divisiones 
add constraint pk_tiendas_04
primary key (div_cve_n);

alter table tiendas.subcategoria
add constraint pk_tiendas_05
primary key (sbc_cve_n);

