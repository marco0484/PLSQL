alter table tiendas.articulos_corr 
add constraint fk_01_cat
foreign key (cat_cve_n)
references tiendas.categorias(cat_cve_n);

alter table tiendas.articulos_corr
add constraint fk_02_cat
foreign key (sbc_cve_n)
references tiendas.subcategoria(sbc_cve_n);

alter table tiendas.articulos
add constraint fk_03_art
foreign key (col_cve_n)
references tiendas.colores(col_cve_n);

-- No se pudo hacer la referencia por que el color 3129 no existe
-- en la tabla colores

insert into tiendas.colores values (3129,'faltante',1);

-- Estamos teniendo un error a pesar de insertar el que faltaba nos
-- siguen haciendo falta algunos, por lo que ejecutaremos un select
-- para saber cuales son los ids faltante

INSERT INTO tiendas.colores (col_cve_n, col_desc_str, ind_activo)
SELECT DISTINCT a.col_cve_n AS id_faltante,
       'FALTANTE' AS col_descripcion,
       1 AS col_estatus
FROM articulos a
LEFT JOIN colores c ON a.col_cve_n = c.col_cve_n
WHERE c.col_cve_n IS NULL;


commit;