// =======================
// ESQUEMA SEGUROS
// =======================

Table mst_socios {
  cod_socio smallint [pk]
  fcnombre_socio char(100)
  cod_tipo_puesto smallint
  cod_responsable smallint
  ind_activo smallint
  fyh_carga timestamp
  fyh_modificacion timestamp
}

Table cat_puestos {
  cod_tipo_puesto smallint [pk]
  desc_puesto char(50)
  ind_activo smallint
  fyh_carga timestamp
  fyh_modificacion timestamp
}

Table cat_datos_generales {
  cod_folio_c4 bigint [pk]
  cod_socio smallint
  num_edad_socio smallint
  fyh_nacimiento timestamp
  cod_ciudad char(50)
  cod_estado char(50)
  num_latitud numeric(15,8)
  num_longitud numeric(15,8)
  ind_caso_activo smallint
  cod_parte_cuerpo_afectada smallint
  bnd_lado_afectado smallint
  fyh_carga timestamp
  fyh_modificacion timestamp
}

Table det_conyuge {
  cod_folio_c4 bigint [pk]
  desc_nombre char(100)
  num_edad smallint
  num_telefono numeric(20)
  fyh_carga timestamp
  fyh_modificacion timestamp
}

Table det_diagostico_med {
  cod_folio_c4 bigint [pk]
  bnd_estado_conciente smallint
  ind_estado_salud smallint
  desc_atencion_medica char(1000)
  fyh_carga timestamp
  fyh_modificacion timestamp
}

Table cat_estado_salud {
  ind_estado_salud smallint [pk]
  desc_estado_socio char(100)
  ind_activo smallint
  fyh_carga timestamp
  fyh_modificacion timestamp
}

Table det_eventos_seguros {
  cod_folio_c4 bigint [pk]
  cod_tipo_evento smallint
  desc_causa char(1000)
  desc_lugar_evento char(1000)
  nombre_involucrado char(100)
  num_modelo_vehiculo bigint
  num_serie_vehiculo bigint
  ind_tipo_vehiculo smallint
  fyh_carga timestamp
  fyh_modificacion timestamp
}

Table cat_eventos {
  cod_tipo_evento smallint [pk]
  desc_tipo_evento char(100)
  ind_activo smallint
  fyh_carga timestamp
  fyh_modificacion timestamp
}

Table cat_partes_cuerpo {
  cod_parte_cuerpo_afectada smallint [pk]
  desc_parte_cuerpo char(30)
  ind_activo smallint
  fyh_carga timestamp
  fyh_modificacion timestamp
}

// =======================
// RELACIONES (FK)
// =======================

Ref: mst_socios.cod_tipo_puesto > cat_puestos.cod_tipo_puesto

Ref: cat_datos_generales.cod_socio > mst_socios.cod_socio

Ref: det_conyuge.cod_folio_c4 > cat_datos_generales.cod_folio_c4

Ref: det_diagostico_med.cod_folio_c4 > cat_datos_generales.cod_folio_c4

Ref: det_diagostico_med.ind_estado_salud > cat_estado_salud.ind_estado_salud

Ref: det_eventos_seguros.cod_folio_c4 > cat_datos_generales.cod_folio_c4

Ref: det_eventos_seguros.cod_tipo_evento > cat_eventos.cod_tipo_evento

Ref: cat_datos_generales.cod_parte_cuerpo_afectada > cat_partes_cuerpo.cod_parte_cuerpo_afectada
