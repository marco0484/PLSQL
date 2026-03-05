					
									
									
	select soc.cod_socio
		   ,cdg.cod_folio_c4 
		   ,soc.fcnombre_socio
		   ,cdg.num_edad_socio 
		   ,cdg.fyh_nacimiento 
		   ,cdg.cod_ciudad 
		   ,cdg.cod_parte_cuerpo_afectada 
		   ,cpc.desc_parte_cuerpo 
		   ,cdg.bnd_lado_afectado 
		   ,case when cdg.bnd_lado_afectado = 1 then 'izquierdo'
		   else 'derecho'
		   end desc_lado_afectado
		   ,cdg.ind_caso_activo 
		   ,soc.cod_tipo_puesto
		   ,cpt.desc_puesto 
		  -- ,soc.cod_responsable
		   ,soc.ind_activo  
		   ,case when soc.ind_activo = 1 then 'activo'
		   else 'inactivo'
		   end ind_activo
		   ,dc.desc_nombre conyuge
		   ,dc.num_edad  edad_conyuge
		   ,dc.num_telefono 
		   ,des.cod_tipo_evento 
		   ,ce.desc_tipo_evento 
		   ,des.desc_causa 
		   ,des.desc_lugar_evento 
		   ,ddm.bnd_estado_conciente 
		   ,case when bnd_estado_conciente  = 1 then 'Si'
		   else 'No'
		  end desc_estado_conciente
		  ,ddm.ind_estado_salud 
		   ,ces.desc_estado_socio 
		   ,ddm.desc_atencion_medica 
	from seguros.mst_socios soc
	inner join seguros.cat_datos_generales cdg
	on soc.cod_socio = cdg.cod_socio
	inner join seguros.cat_partes_cuerpo cpc
	on cdg.cod_parte_cuerpo_afectada = cpc.cod_parte_cuerpo_afectada 
	inner join seguros.cat_puestos cpt
	on soc.cod_tipo_puesto = cpt.cod_tipo_puesto
	inner join seguros.det_conyuge dc
	on cdg.cod_folio_c4 = dc.cod_folio_c4 
	inner join seguros.det_eventos_seguros des
	on cdg.cod_folio_c4 = des.cod_folio_c4 
	inner join seguros.cat_eventos ce 
	on des.cod_tipo_evento = ce.cod_tipo_evento
	inner join seguros.det_diagostico_med ddm 
	on des.cod_folio_c4 = ddm.cod_folio_c4 
	inner join seguros.cat_estado_salud ces 
	on ddm.ind_estado_salud = ces.ind_estado_salud 
	where soc.ind_activo = 1;	
	
	

									






									