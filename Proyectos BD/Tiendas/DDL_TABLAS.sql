create schema tiendas;

commit;

create table tiendas.divisiones
								(
								div_cve_n int,
								div_desc_str varchar(40),
								ind_activo int
								);

create table tiendas.colores(col_cve_n int,
									col_desc_str varchar(40),
									ind_activo int);

update tiendas.colores set ind_activo = 1;

create table tiendas.categorias(
								cat_cve_n int,
cat_desc_str varchar(50),
ind_activo int);

commit;

alter table tiendas.categorias drop column cat_est_str;
update tiendas.categorias set ind_activo = 1;

create table tiendas.subcategoria(
sbc_cve_n int,
sbc_desc_str varchar(50),
ind_activo int);

update tiendas.subcategoria set ind_activo =1;


create table tiendas.articulos
(
id_art int,
col_cve_n int,
mar_cve_n int,
ar_estilo_str varchar(10),
div_cve_n int,
ind_activo int);

drop table tiendas.articulos;

update tiendas.articulos set ind_activo = 1;

commit;

create table tiendas.articulos_corr
(
ID_ART int,
CO_CVE_STR varchar(10),
SEC_CVE_N int,
CAT_CVE_N int,
SBC_CVE_N int);