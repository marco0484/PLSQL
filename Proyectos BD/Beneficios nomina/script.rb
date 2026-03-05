select a.cod_grupo
	  ,a.desc_grupo
	  ,a.ind_activo
	  ,b.cod_clasificacion
	  ,b.desc_clafificacion
	  ,c.cod_beneficio 
	  ,c.desc_beneficio
	  ,c.desc_beneficio_largo
  from bank.cat_grupos_asistencia a
inner join bank.cat_clasificacion_beneficios b
on a.cod_grupo = b.cod_grupo
inner join bank.cat_beneficios_asistencia c
on b.cod_grupo = c.cod_grupo
and b.cod_clasificacion = c.cod_clasificacion;