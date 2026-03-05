select  art.id_art
	   ,art.col_cve_n 
	   ,art.mar_cve_n 
	   ,art.ar_estilo_str 
	   ,art.div_cve_n 
	   ,art.ind_activo
	  -- ,count(1) duplicados
	from TIENDAS.ARTICULOS art   -- 3000 registros en total
inner join tiendas.colores col
on art.col_cve_n = col.col_cve_n
--group by id_art
--having count(1)>1;  -- con la union bajan los registros, eso no quiere decir que este ok, pero es una señal

select   art.id_art
		,art.co_cve_str
		,art.sec_cve_n
		,art.cat_cve_n
		,cat.cat_desc_str
		,art.sbc_cve_n
		,sbc.sbc_desc_str
from tiendas.articulos_corr art
inner join tiendas.categorias cat
on art.cat_cve_n = cat.cat_cve_n
inner join tiendas.subcategoria sbc
on art.sbc_cve_n = sbc.sbc_cve_n;