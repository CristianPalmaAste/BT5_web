set client_min_messages to warning;

drop table if exists grupos_empresariales           cascade;
drop table if exists empresas                       cascade;
drop table if exists parametros                     cascade;
drop table if exists parametros_empresas            cascade;
drop table if exists estados_grem                   cascade;
drop table if exists rubros                         cascade;
drop table if exists estados_registros              cascade;
drop table if exists valores_paises                 cascade;
drop table if exists monedas                        cascade;
drop table if exists gerencias                      cascade;
drop table if exists proyectos                      cascade;
drop table if exists lineas_negocios                cascade;
drop table if exists centros_costos                 cascade;
drop table if exists tareas                         cascade;
drop table if exists paises                         cascade;
drop table if exists personas                       cascade;
drop table if exists perfiles                       cascade;
drop table if exists estados_civiles                cascade;
drop table if exists sexos                          cascade;
drop table if exists programas                      cascade;
drop table if exists usuarios                       cascade;
drop table if exists usuarios_perfiles              cascade;
drop table if exists perfiles_programas             cascade;
drop table if exists planes_cuentas                 cascade;
drop table if exists documentos_legales             cascade;
drop table if exists tipos_documentos_legales       cascade;
drop table if exists estados_documentos_legales     cascade;
drop table if exists solicitudes_servs_hono         cascade;
drop table if exists estados_solics_servs_hono      cascade;
drop table if exists cotizaciones_servs_hono        cascade;
drop table if exists doctos_cotizacs_servs_hono     cascade;
drop table if exists estados_cotizacs_servs_hono    cascade;
drop table if exists ordenes_servicios_hono         cascade;
drop table if exists doctos_ordenes_servs_hono      cascade;
drop table if exists estados_ordenes_servs_hono     cascade;
drop table if exists pagos_ordenes_servs_hono       cascade;
drop table if exists estados_pagos_ords_servs_hono  cascade;
drop table if exists tipos_formas_pagos             cascade;
drop table if exists formas_pagos_notas_ventas      cascade;
drop table if exists formas_pagos_ventas            cascade;
drop table if exists unidades_territoriales_1       cascade;
drop table if exists unidades_territoriales_2       cascade;
drop table if exists unidades_territoriales_3       cascade;
drop table if exists tipos_clientes                 cascade;
drop table if exists tipos_cotizaciones_vtas        cascade;
drop table if exists estados_cotizaciones_vtas      cascade;
drop table if exists estados_notas_vtas             cascade;
drop table if exists estados_ventas                 cascade;
drop table if exists origenes_productos             cascade;
drop table if exists unidades_medidas_productos     cascade;
drop table if exists unidades_medidas_servicios     cascade;
drop table if exists tipos_productos                cascade;
drop table if exists impuestos                      cascade;
drop table if exists tipos_productos_impuestos      cascade;
drop table if exists tipos_doctos_ventas            cascade;
drop table if exists tipos_servicios                cascade;
drop table if exists clientes                       cascade;
drop table if exists ventas                         cascade;
drop table if exists detalles_ventas                cascade;
drop table if exists notas_ventas                   cascade;
drop table if exists detalles_notas_vtas            cascade;
drop table if exists cotizaciones_ventas            cascade;
drop table if exists detalles_cotizs_vtas           cascade;
drop table if exists productos                      cascade;
drop table if exists servicios                      cascade;
drop table if exists dominios                       cascade;
drop table if exists valores_dominios               cascade;
drop table if exists bodegas                        cascade;
drop table if exists bodegas_productos              cascade;
drop table if exists listas_precios                 cascade;
drop table if exists detalles_listas_precios        cascade;
drop table if exists familias_productos             cascade;
drop table if exists sub_familias_productos         cascade;
drop table if exists tipos_movimientos_bodegas      cascade;
drop table if exists movimientos_bodegas            cascade;
drop table if exists detalles_movtos_bodegas        cascade;
drop table if exists descuentos                     cascade;
drop table if exists bitacoras_cambios_precios      cascade;


\q
