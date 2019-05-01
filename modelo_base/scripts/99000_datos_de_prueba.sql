set client_min_messages to warning;

create or replace function tmp_datos_de_prueba () returns varchar(100) as
$$
declare
  Vidgrem  int;
  Vidrubr  int;
  Vidempr  int;
  Vidpers  int;
  Vidusua  int;
  Viduspe  int;
  Vidpepr  int;
begin
  select nextval('grem_seq') into Vidgrem;
  insert into grupos_empresariales values (Vidgrem, 'METALPAR'          , 'MPAR', 'hold_metalpar.jpg', 1, 1, 1, current_timestamp, null, null, null, null);
  select nextval('pers_seq') into Vidpers;
  insert into personas values (Vidpers, Vidgrem, 13047104, '8', 'JUAN', null, 'CISTERNA', 'FUENTES', null, null, null, null, null, 1, current_timestamp, null, null, null, null);
  select nextval('usua_seq') into Vidusua;
  insert into usuarios values (Vidusua, 'JCISTERNAF', '12345', Vidpers, 1, 1, current_timestamp, null, null, null, null);
  select nextval('rubr_seq') into Vidrubr;
    -- empresas
    select max(id)
    into   Vidrubr
    from   rubros
    where  idgrem = Vidgrem
    ;
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-6, 1, '96550820', '1', 'METALPAR S.A.'                     , 'METALPAR S.A.'            , 'emp_metalpar.jpg', 1, current_timestamp, null, null, null, null, '');
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA GENERAL'        , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA COMERCIAL'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA MARKETING'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA RRHH'           , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA ADM. Y FINANZAS', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'ALTO MAIPO'         , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'GRAN SANTIAGO'      , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'PARQUE INDUSTRIAL'  , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'CARCEL CONCESIONADA', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'FRUTICOLA'          , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'METRO'              , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'PERFILES DE ACERO'  , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CANALETAS'          , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'FIERROS CILINDRICOS', 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CONSTRUCCION'       , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'COMERCIALIZACION'   , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'IMPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'EXPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - PRODUCCION'    , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - ADMINISTRACION', 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - VENTAS'        , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA NORTE'                  , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA SUR'                    , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA PRINCIPAL' , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA SECUNDARIA', 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'OTRA TAREA'      , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'ULTIMA TAREA'    , 1, current_timestamp, null, null, null, null);
    select nextval('uspe_seq')+100 into Viduspe;
    insert into usuarios_perfiles values (Viduspe, Vidusua, 8, null, Vidempr, 1, 1, current_timestamp, null, null, null, null);
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-5, 1, '93576000', '3', 'INDUSTRIAS METALURGICAS PAREDES'   , 'INDUSTRIAL METALPAR S.A.' , 'emp_industrias.jpg' , 1, current_timestamp, null, null, null, null, '');
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA GENERAL'        , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA COMERCIAL'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA MARKETING'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA RRHH'           , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA ADM. Y FINANZAS', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'ALTO MAIPO'         , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'GRAN SANTIAGO'      , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'PARQUE INDUSTRIAL'  , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'CARCEL CONCESIONADA', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'FRUTICOLA'          , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'METRO'              , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'PERFILES DE ACERO'  , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CANALETAS'          , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'FIERROS CILINDRICOS', 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CONSTRUCCION'       , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'COMERCIALIZACION'   , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'IMPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'EXPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - PRODUCCION'    , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - ADMINISTRACION', 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - VENTAS'        , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA NORTE'                  , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA SUR'                    , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA PRINCIPAL' , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA SECUNDARIA', 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'OTRA TAREA'      , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'ULTIMA TAREA'    , 1, current_timestamp, null, null, null, null);
    select nextval('uspe_seq') into Viduspe;
    insert into usuarios_perfiles values (Viduspe, Vidusua, 12, null, Vidempr, 1, 1, current_timestamp, null, null, null, null);
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-4, 1, '88337800', '8', 'INVERSIONES METALPAR S.A.'         , 'INVERSIONES METALPAR S.A.', 'emp_inv_metalpar.jpg', 1, current_timestamp, null, null, null, null, '');
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA GENERAL'        , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA COMERCIAL'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA MARKETING'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA RRHH'           , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA ADM. Y FINANZAS', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'ALTO MAIPO'         , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'GRAN SANTIAGO'      , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'PARQUE INDUSTRIAL'  , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'CARCEL CONCESIONADA', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'FRUTICOLA'          , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'METRO'              , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'PERFILES DE ACERO'  , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CANALETAS'          , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'FIERROS CILINDRICOS', 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CONSTRUCCION'       , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'COMERCIALIZACION'   , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'IMPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'EXPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - PRODUCCION'    , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - ADMINISTRACION', 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - VENTAS'        , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA NORTE'                  , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA SUR'                    , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA PRINCIPAL' , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA SECUNDARIA', 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'OTRA TAREA'      , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'ULTIMA TAREA'    , 1, current_timestamp, null, null, null, null);
    select nextval('uspe_seq') into Viduspe;
    insert into usuarios_perfiles values (Viduspe, Vidusua, 15, null, Vidempr, 1, 1, current_timestamp, null, null, null, null);
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-3, 1, '78400010', '9', 'AGRICOLA Y GANADERA SANTA BARBARA' , 'STA. BARBARA'             , 'emp_sta_barbara.jpg' , 1, current_timestamp, null, null, null, null, '');
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA GENERAL'        , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA COMERCIAL'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA MARKETING'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA RRHH'           , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA ADM. Y FINANZAS', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'ALTO MAIPO'         , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'GRAN SANTIAGO'      , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'PARQUE INDUSTRIAL'  , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'CARCEL CONCESIONADA', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'FRUTICOLA'          , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'METRO'              , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'PERFILES DE ACERO'  , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CANALETAS'          , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'FIERROS CILINDRICOS', 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CONSTRUCCION'       , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'COMERCIALIZACION'   , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'IMPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'EXPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - PRODUCCION'    , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - ADMINISTRACION', 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - VENTAS'        , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA NORTE'                  , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA SUR'                    , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA PRINCIPAL' , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA SECUNDARIA', 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'OTRA TAREA'      , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'ULTIMA TAREA'    , 1, current_timestamp, null, null, null, null);
    select nextval('uspe_seq') into Viduspe;
    insert into usuarios_perfiles values (Viduspe, Vidusua, 17, null, Vidempr, 1, 1, current_timestamp, null, null, null, null);
    select nextval('pepr_seq') into Vidpepr;

  select nextval('grem_seq') into Vidgrem;
  insert into grupos_empresariales values (Vidgrem, 'CRUZ VERDE'        , 'CV'  , 'hold_cruz_verde.jpg'      , 1, 1, 1, current_timestamp, null, null, null, null);
    -- empresas
    select max(id)
    into   Vidrubr
    from   rubros
    where  idgrem = Vidgrem
    ;
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-2, 1, '89807200', '2', 'FARMACIAS CRUZ VERDE'              , 'FCV'                      , 'emp_cruz_verde.jpg'        , 1, current_timestamp, null, null, null, null, '');
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA GENERAL'        , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA COMERCIAL'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA MARKETING'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA RRHH'           , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA ADM. Y FINANZAS', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'ALTO MAIPO'         , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'GRAN SANTIAGO'      , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'PARQUE INDUSTRIAL'  , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'CARCEL CONCESIONADA', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'FRUTICOLA'          , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'METRO'              , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'PERFILES DE ACERO'  , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CANALETAS'          , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'FIERROS CILINDRICOS', 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CONSTRUCCION'       , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'COMERCIALIZACION'   , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'IMPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'EXPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - PRODUCCION'    , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - ADMINISTRACION', 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - VENTAS'        , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA NORTE'                  , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA SUR'                    , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA PRINCIPAL' , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA SECUNDARIA', 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'OTRA TAREA'      , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'ULTIMA TAREA'    , 1, current_timestamp, null, null, null, null);
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-2, 1, '89741200', '4', 'DIFARMA'                           , 'DIFARMA'                  , 'emp_difarma.jpg'    , 1, current_timestamp, null, null, null, null, '');
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA GENERAL'        , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA COMERCIAL'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA MARKETING'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA RRHH'           , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA ADM. Y FINANZAS', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'ALTO MAIPO'         , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'GRAN SANTIAGO'      , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'PARQUE INDUSTRIAL'  , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'CARCEL CONCESIONADA', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'FRUTICOLA'          , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'METRO'              , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'PERFILES DE ACERO'  , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CANALETAS'          , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'FIERROS CILINDRICOS', 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CONSTRUCCION'       , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'COMERCIALIZACION'   , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'IMPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'EXPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - PRODUCCION'    , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - ADMINISTRACION', 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - VENTAS'        , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA NORTE'                  , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA SUR'                    , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA PRINCIPAL' , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA SECUNDARIA', 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'OTRA TAREA'      , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'ULTIMA TAREA'    , 1, current_timestamp, null, null, null, null);
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-1, 1, '91575000', '1', 'SOCOFAR'                           , 'SOCOFAR'                  , 'emp_socofar.jpg'    , 1, current_timestamp, null, null, null, null, '');
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA GENERAL'        , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA COMERCIAL'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA MARKETING'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA RRHH'           , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA ADM. Y FINANZAS', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'ALTO MAIPO'         , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'GRAN SANTIAGO'      , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'PARQUE INDUSTRIAL'  , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'CARCEL CONCESIONADA', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'FRUTICOLA'          , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'METRO'              , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'PERFILES DE ACERO'  , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CANALETAS'          , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'FIERROS CILINDRICOS', 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CONSTRUCCION'       , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'COMERCIALIZACION'   , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'IMPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'EXPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - PRODUCCION'    , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - ADMINISTRACION', 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - VENTAS'        , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA NORTE'                  , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA SUR'                    , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA PRINCIPAL' , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA SECUNDARIA', 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'OTRA TAREA'      , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'ULTIMA TAREA'    , 1, current_timestamp, null, null, null, null);
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-2, 1, '71378000', '6', 'LABORATORIO MINTLAB'               , 'MINTLAB'                  , 'emp_mintlab.jpg'    , 1, current_timestamp, null, null, null, null, '');
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA GENERAL'        , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA COMERCIAL'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA MARKETING'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA RRHH'           , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA ADM. Y FINANZAS', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'ALTO MAIPO'         , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'GRAN SANTIAGO'      , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'PARQUE INDUSTRIAL'  , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'CARCEL CONCESIONADA', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'FRUTICOLA'          , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'METRO'              , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'PERFILES DE ACERO'  , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CANALETAS'          , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'FIERROS CILINDRICOS', 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CONSTRUCCION'       , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'COMERCIALIZACION'   , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'IMPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'EXPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - PRODUCCION'    , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - ADMINISTRACION', 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - VENTAS'        , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA NORTE'                  , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA SUR'                    , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA PRINCIPAL' , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA SECUNDARIA', 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'OTRA TAREA'      , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'ULTIMA TAREA'    , 1, current_timestamp, null, null, null, null);
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-2, 1, '77781470', '2', 'LABORATORIO MUNICH'                , 'MUNICH'                   , 'emp_munich.jpg'     , 1, current_timestamp, null, null, null, null, '');
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA GENERAL'        , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA COMERCIAL'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA MARKETING'      , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA RRHH'           , 1, current_timestamp, null, null, null, null);
    insert into gerencias values (nextval('gere_seq'), Vidempr, 'GERENCIA ADM. Y FINANZAS', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'ALTO MAIPO'         , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'GRAN SANTIAGO'      , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'PARQUE INDUSTRIAL'  , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'CARCEL CONCESIONADA', 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'FRUTICOLA'          , 1, current_timestamp, null, null, null, null);
    insert into proyectos values (nextval('proy_seq'), Vidempr, 'METRO'              , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'PERFILES DE ACERO'  , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CANALETAS'          , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'FIERROS CILINDRICOS', 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'CONSTRUCCION'       , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'COMERCIALIZACION'   , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'IMPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into lineas_negocios values (nextval('line_seq'), Vidempr, 'EXPORTACIONES'      , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - PRODUCCION'    , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - ADMINISTRACION', 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA CENTRO - VENTAS'        , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA NORTE'                  , 1, current_timestamp, null, null, null, null);
    insert into centros_costos values (nextval('ceco_seq'), Vidempr, 'ZONA SUR'                    , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA PRINCIPAL' , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'TAREA SECUNDARIA', 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'OTRA TAREA'      , 1, current_timestamp, null, null, null, null);
    insert into tareas values (nextval('tare_seq'), Vidempr, 'ULTIMA TAREA'    , 1, current_timestamp, null, null, null, null);

  select nextval('grem_seq') into Vidgrem;
  insert into grupos_empresariales values (Vidgrem, 'AMASANDERIA TRIGAL', 'AT'  , 'hold_trigal.jpg'      , 1, 1, 1, current_timestamp, null, null, null, null);
    -- empresas
    select max(id)
    into   Vidrubr
    from   rubros
    where  idgrem = Vidgrem
    ;
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-0, 1, '76765660', '2', 'AMASANDERIA TRIGAL'                , 'TRIGAL'                   , 'emp_trigal.jpg' , 1, current_timestamp, null, null, null, null, '')
    ;

  return('S');
end;
$$ LANGUAGE plpgsql;

select tmp_datos_de_prueba()
;

drop function tmp_datos_de_prueba()
;

-- Usuario con acceso a todo

create or replace function tmp_usuario_acc_total () returns varchar(100) as
$$
declare
  Vidpers  int;
  Vidusua  int;
  Viduspe  int;
  Vidperf  int;
  Vidpepr  int;
  Vidprog  int;
  C_programas cursor for
    select id
    from   programas
    order  by 1
    ;
begin
  select nextval('pers_seq') into Vidpers;
  --
  insert into personas values (Vidpers   , 1,     '999',         '7',           'USUARIO'  , null,         'ACCESO'      , 'TOTAL',        null, null    , null,  null,  null, 1,                 current_timestamp, null,    
          null,               null,               null);
  --
  select nextval('usua_seq') into Vidusua;
  insert into usuarios values (Vidusua, 'UAT', '12345', Vidpers, 1, 1, current_timestamp, null, null, null, null);
  select nextval('perf_seq')+250 into Vidperf;
  
  insert into perfiles values (Vidperf, 'PERFIL DE PRUEBA CON ACCESO A TODO');
  select nextval('uspe_seq')+500 into Viduspe;
  insert into usuarios_perfiles values (Viduspe, Vidusua, Vidperf, null, 1, 1, 1, current_timestamp, null, null, null, null);
  select nextval('uspe_seq')+500 into Viduspe;
  /* le doy acceso total a todos los usuarios del 2 al 10 */
  insert into usuarios_perfiles values (Viduspe, 2      , Vidperf, null, 1, 1, 1, current_timestamp, null, null, null, null);
  select nextval('uspe_seq')+500 into Viduspe;
  insert into usuarios_perfiles values (Viduspe, 3      , Vidperf, null, 1, 1, 1, current_timestamp, null, null, null, null);
  select nextval('uspe_seq')+500 into Viduspe;
  insert into usuarios_perfiles values (Viduspe, 4      , Vidperf, null, 1, 1, 1, current_timestamp, null, null, null, null);
  select nextval('uspe_seq')+500 into Viduspe;
  insert into usuarios_perfiles values (Viduspe, 5      , Vidperf, null, 1, 1, 1, current_timestamp, null, null, null, null);
  select nextval('uspe_seq')+500 into Viduspe;
  insert into usuarios_perfiles values (Viduspe, 6      , Vidperf, null, 1, 1, 1, current_timestamp, null, null, null, null);
  select nextval('uspe_seq')+500 into Viduspe;
  insert into usuarios_perfiles values (Viduspe, 7      , Vidperf, null, 1, 1, 1, current_timestamp, null, null, null, null);
  select nextval('uspe_seq')+500 into Viduspe;
  insert into usuarios_perfiles values (Viduspe, 8      , Vidperf, null, 1, 1, 1, current_timestamp, null, null, null, null);
  select nextval('uspe_seq')+500 into Viduspe;
  insert into usuarios_perfiles values (Viduspe, 9      , Vidperf, null, 1, 1, 1, current_timestamp, null, null, null, null);
  select nextval('uspe_seq')+500 into Viduspe;
  insert into usuarios_perfiles values (Viduspe, 10     , Vidperf, null, 1, 1, 1, current_timestamp, null, null, null, null);
  --
  -- le doy acceso a todos los programas al perfil PERFIL DE PRUEBA CON ACCESO A TODO
  open C_programas;
  loop
    fetch C_programas into Vidprog
                           ;
    exit when not found;
    select nextval('pepr_seq') into Vidpepr;
    insert into perfiles_programas values (Vidpepr, Vidperf, Vidprog, 1, current_timestamp, null, null, null, null);
  end loop;
  close C_programas;
  --
  insert into documentos_legales values (1 , 1, 1, 'prueba_1.txt'       , 'prueba_1.txt'       , 1, cast(current_timestamp as date) - cast('1 days' as interval), 'LA UNICA'                    , 'F1' , 'PEDRO PIEDRA'    , 'NINGUNO'          , cast(current_timestamp as date) + cast('11 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (2 , 1, 2, 'prueba_2.txt'       , 'prueba_2.txt'       , 1, cast(current_timestamp as date) - cast('2 days' as interval), 'LA CUCHUFLETA'               , '100', 'JUAN SOTO'       , 'NADA'             , cast(current_timestamp as date) + cast('12 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (3 , 1, 3, 'prueba_3.txt'       , 'prueba_3.txt'       , 1, cast(current_timestamp as date) - cast('3 days' as interval), 'PEREZ'                       , '500', 'FERNANDO ASTE'   , 'NINGUNA'          , cast(current_timestamp as date) + cast('13 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (4 , 1, 4, 'acta_const_soc.docx', 'acta_const_soc.docx', 1, cast(current_timestamp as date) - cast('4 days' as interval), 'RENÉ SANTELICES'             , '700', 'AGUSTÍN LOPEZ A.', 'ALGO QUE COMENTAR', cast(current_timestamp as date) + cast('14 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (5 , 1, 1, 'prueba_4.txt'       , 'prueba_4.txt'       , 1, cast(current_timestamp as date) - cast('5 days' as interval), 'ANTONIETA MENDOZA'           , 'F10', 'Pedro LOPEZ B.'  , 'TODO QUE COMENTAR', cast(current_timestamp as date) + cast('15 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (6 , 1, 1, 'prueba_5.txt'       , 'prueba_5.txt'       , 1, cast(current_timestamp as date) - cast('6 days' as interval), 'ANTONIETA ESCALA'            , '700', 'MARIO JOFRÉ M.'  , 'NADA QUE COMENTAR', cast(current_timestamp as date) + cast('16 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (7 , 1, 1, 'prueba_6.txt'       , 'prueba_6.txt'       , 1, cast(current_timestamp as date) - cast('7 days' as interval), 'MA. ANTONIETA ESCALA'        , '400', 'ERNESTO PINTO M.', 'NADA QUE COMENTAR', cast(current_timestamp as date) + cast('17 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (8 , 1, 3, 'prueba_7.txt'       , 'prueba_7.txt'       , 1, cast(current_timestamp as date) - cast('8 days' as interval), 'MA. ANTONIETA MENDOZA ESCALA', '300', 'AGUSTÍN LOPEZ B.', 'TODO QUE COMENTAR', cast(current_timestamp as date) + cast('18 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (9 , 1, 3, 'prueba_8.txt'       , 'prueba_8.txt'       , 1, cast(current_timestamp as date) - cast('9 days' as interval), 'RENÉ SANTELICES'             , '500', 'YULIA JOFRÉ M.'  , 'ALGO QUE COMENTAR', cast(current_timestamp as date) + cast('19 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (10, 1, 3, 'prueba_9.txt'       , 'prueba_9.txt'       , 1, cast(current_timestamp as date) - cast('1 days' as interval), 'RENÉ SANTELICES P.'          , '800', 'OTILIO JOFRÉ M.' , 'NO COMENTAR'      , cast(current_timestamp as date) + cast('11 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (11, 1, 3, 'prueba_10.txt'      , 'prueba_10.txt'      , 1, cast(current_timestamp as date) - cast('2 days' as interval), 'ANTONIETA MENDOZA'           , '100', 'CLAUDIO LOPEZ B.', 'NADA QUE COMENTAR', cast(current_timestamp as date) + cast('12 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (12, 1, 3, 'prueba_11.txt'      , 'prueba_11.txt'      , 1, cast(current_timestamp as date) - cast('3 days' as interval), 'ANTONIETA MENDOZA'           , 'F 2', 'AGUSTÍN JOFRÉ A.', 'ALGO QUE COMENTAR', cast(current_timestamp as date) + cast('13 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (13, 1, 2, 'prueba_12.txT'      , 'prueba_12.txt'      , 1, cast(current_timestamp as date) - cast('4 days' as interval), 'RENÉ SANTELICES'             , '000', 'YULIA JOFRÉ C.'  , 'TODO QUE COMENTAR', cast(current_timestamp as date) + cast('14 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (14, 1, 2, 'prueba_13.txt'      , 'prueba_13.txt'      , 1, cast(current_timestamp as date) - cast('5 days' as interval), 'RENÉ SANTELICES'             , '900', 'CLAUDIO LOPEZ M.', 'NADA QUE COMENTAR', cast(current_timestamp as date) + cast('15 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (15, 1, 2, 'prueba_14.txt'      , 'prueba_14.txt'      , 1, cast(current_timestamp as date) - cast('6 days' as interval), 'ANTONIETA MENDOZA'           , '123', 'AGUSTÍN JOFRÉ A.', 'ALGO QUE COMENTAR', cast(current_timestamp as date) + cast('16 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (16, 1, 2, 'prueba_15.txt'      , 'prueba_15.txt'      , 1, cast(current_timestamp as date) - cast('7 days' as interval), 'ANTONIETA MENDOZA C.'        , '456', 'YULIA CARMONA M.', 'NO COMENTAR'      , cast(current_timestamp as date) + cast('17 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (17, 1, 2, 'prueba_16.txt'      , 'prueba_16.txt'      , 1, cast(current_timestamp as date) - cast('8 days' as interval), 'RENÉ SANTELICES'             , '789', 'AGUSTÍN LOPEZ C.', 'TODO QUE COMENTAR', cast(current_timestamp as date) + cast('18 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (18, 1, 2, 'prueba_17.txt'      , 'prueba_17.txt'      , 1, cast(current_timestamp as date) - cast('9 days' as interval), 'RENÉ SANTELICES'             , '012', 'CLAUDIO JOFRÉ A.', 'ALGO QUE COMENTAR', cast(current_timestamp as date) + cast('19 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (19, 1, 2, 'prueba_18.txt'      , 'prueba_18.txt'      , 1, cast(current_timestamp as date) - cast('1 days' as interval), 'R. SANTELICES'               , '345', 'AGUSTÍN LOPEZ M.', 'NADA QUE COMENTAR', cast(current_timestamp as date) + cast('11 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (20, 1, 4, 'prueba_19.txt'      , 'prueba_19.txt'      , 1, cast(current_timestamp as date) - cast('2 days' as interval), 'RENÉ SANTELICES'             , '678', 'CLAUDIO PINTO M.', 'NADA QUE COMENTAR', cast(current_timestamp as date) + cast('12 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (21, 1, 1, 'const_soc.txt'      , 'const_soc.txt'      , 1, cast(current_timestamp as date) - cast('3 days' as interval), 'ANTONIETA MENDOZA ESCALA'    , '901', 'JULIA PINTO A.'  , '--'               , cast(current_timestamp as date) + cast('13 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (22, 1, 2, 'act_dir.txt'        , 'act_dir.txt'        , 1, cast(current_timestamp as date) - cast('4 days' as interval), 'ANTONIETA MENDOZA E.'        , '100', 'JULIA PINTO A.'  , '--'               , cast(current_timestamp as date) + cast('14 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (23, 1, 3, 'ses_dir.txt'        , 'ses_dir.txt'        , 1, cast(current_timestamp as date) - cast('5 days' as interval), 'ANTONIETA MENDOZA E.'        , '200', 'JULIA PINTO A.'  , '--'               , cast(current_timestamp as date) + cast('15 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);
  insert into documentos_legales values (24, 1, 4, 'cont_arr.txt'       , 'cont_arr.txt'       , 1, cast(current_timestamp as date) - cast('6 days' as interval), 'ANTONIETA MENDOZA ESCALA'    , '300', 'JULIA PINTO A.'  , '--'               , cast(current_timestamp as date) + cast('16 days' as interval), 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, current_timestamp, null, null, null, null, null);

  insert into productos values (1 , 1, 1, 4 , 9, 1, 'COCA COLA RETORNABLE 1 LT'        , '0001', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (2 , 1, 1, 4 , 9, 1, 'COCA COLA RETORNABLE 2 LT'        , '0002', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (3 , 1, 1, 4 , 9, 1, 'COCA COLA RETORNABLE 2.5 LT'      , '0003', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (4 , 1, 1, 4 , 9, 1, 'COCA COLA RETORNABLE 3 LT'        , '0004', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (5 , 1, 1, 4 , 9, 1, 'COCA COLA LIGHT RETORNABLE 1 LT'  , '0005', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (6 , 1, 1, 4 , 9, 1, 'COCA COLA LIGHT RETORNABLE 2 LT'  , '0006', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (7 , 1, 1, 4 , 9, 1, 'COCA COLA LIGHT RETORNABLE 2.5 LT', '0007', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (8 , 1, 1, 4 , 9, 1, 'COCA COLA LIGHT RETORNABLE 3 LT'  , '0008', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (9 , 1, 1, 4 , 9, 1, 'COCA COLA ZERO RETORNABLE 1 LT'   , '0009', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (10, 1, 1, 4 , 9, 1, 'COCA COLA ZERO RETORNABLE 2 LT'   , '0010', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (11, 1, 1, 4 , 9, 1, 'COCA COLA ZERO RETORNABLE 2.5 LT' , '0011', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (12, 1, 1, 4 , 9, 1, 'COCA COLA ZERO RETORNABLE 3 LT'   , '0012', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (13, 1, 1, 14, 3, 1, 'JAMÓN DE CERDO PF'                , '0013', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (14, 1, 1, 14, 3, 1, 'JAMÓN DE CERDO AHUMADO PF'        , '0014', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (15, 1, 1, 14, 3, 1, 'JAMÓN DE CERDO ACARAMELADO PF'    , '0015', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (16, 1, 1, 15, 9, 1, 'LIBRO DE RECETAS MASTER CHEF'     , '0016', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);
  insert into productos values (17, 1, 1, 5 , 9, 1, 'PISCO CAPEL 35°'                  , '0017', 'a', 'a', 'a', 1, 1, 1, current_timestamp, null, null, null, null);

  insert into servicios values (nextval('serv_seq'), 1 , 1 , 1, 'CONSULTOR JUNIOR'    , 0.5   , 501, 1, current_timestamp, null, null, null, null);
  insert into servicios values (nextval('serv_seq'), 1 , 1 , 1, 'CONSULTOR SENIOR'    , 1     , 501, 1, current_timestamp, null, null, null, null);
  insert into servicios values (nextval('serv_seq'), 1 , 1 , 1, 'JEFE DE PROYECTO'    , 1.5   , 501, 1, current_timestamp, null, null, null, null);
  insert into servicios values (nextval('serv_seq'), 1 , 1 , 1, 'GERENTE DE PROYECTO' , 3     , 501, 1, current_timestamp, null, null, null, null);
  insert into servicios values (nextval('serv_seq'), 1 , 2 , 1, 'ASEO'                , 5000  , 1  , 1, current_timestamp, null, null, null, null);
  insert into servicios values (nextval('serv_seq'), 1 , 2 , 1, 'GUARDIA DE SEGURIDAD', 10000 , 1  , 1, current_timestamp, null, null, null, null);

  -- petición JJM: usuario con perfil de "legales"
  select nextval('pers_seq') into Vidpers;
  insert into personas values (Vidpers, 1,'99', 'K', 'UBALDO', null, 'LEGALES', null, null, null, null, null, null, 1, current_timestamp, null, null, null, null);
  select nextval('usua_seq') into Vidusua;
  insert into usuarios values (Vidusua, 'ULEGALES', '12345', Vidpers, 1, 1, current_timestamp, null, null, null, null);
  select nextval('perf_seq')+2000 into Vidperf;
  insert into perfiles values (Vidperf, 'PERFIL DE PRUEBA LEGALES');
  select nextval('uspe_seq')+1000 into Viduspe;
  insert into usuarios_perfiles values (Viduspe, Vidusua, Vidperf, null, 1   , 1, 1, current_timestamp, null, null, null, null);
  insert into perfiles_programas values (nextval('pepr_seq'), Vidperf, 1000, 1, current_timestamp, null, null, null, null);
  insert into perfiles_programas values (nextval('pepr_seq'), Vidperf, 1010, 1, current_timestamp, null, null, null, null);
  insert into perfiles_programas values (nextval('pepr_seq'), Vidperf, 1020, 1, current_timestamp, null, null, null, null);
  insert into perfiles_programas values (nextval('pepr_seq'), Vidperf, 3000, 1, current_timestamp, null, null, null, null);
  insert into perfiles_programas values (nextval('pepr_seq'), Vidperf, 3070, 1, current_timestamp, null, null, null, null);
  insert into perfiles_programas values (nextval('pepr_seq'), Vidperf, 3080, 1, current_timestamp, null, null, null, null);
  insert into perfiles_programas values (nextval('pepr_seq'), Vidperf, 5000, 1, current_timestamp, null, null, null, null);
  insert into perfiles_programas values (nextval('pepr_seq'), Vidperf, 5010, 1, current_timestamp, null, null, null, null);
  insert into perfiles_programas values (nextval('pepr_seq'), Vidperf, 5020, 1, current_timestamp, null, null, null, null);
  return('S');
end;
$$ LANGUAGE plpgsql;

select tmp_usuario_acc_total()
;

drop function tmp_usuario_acc_total()
;

-- Lo sgte. le crea muchos perfiles a OS, NS y CP (adm. del sistema y en holding FCV)

delete from usuarios_perfiles
where  idusua in (8,9,10)
;

--                                                         usua perf grem  empr
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 8  , 1  , null, null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 8  , 2  , 3   , null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 8  , 4  , null, 7   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 8  , 4  , null, 9   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 8  , 4  , null, 10  , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 8  , 12 , null, 6   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 8  , 12 , null, 7   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 8  , 12 , null, 10  , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 8  , 19 , null, 6   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 8  , 19 , null, 8   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 8  , 19 , null, 9   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 8  , 19 , null, 10  , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 9  , 1  , null, null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 9  , 2  , 3   , null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 9  , 4  , null, 7   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 9  , 4  , null, 9   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 9  , 4  , null, 10  , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 9  , 12 , null, 6   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 9  , 12 , null, 7   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 9  , 12 , null, 10  , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 9  , 19 , null, 6   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 9  , 19 , null, 8   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 9  , 19 , null, 9   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 9  , 19 , null, 10  , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 10 , 1  , null, null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 10 , 2  , 3   , null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 10 , 4  , null, 7   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 10 , 4  , null, 9   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 10 , 4  , null, 10  , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 10 , 12 , null, 6   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 10 , 12 , null, 7   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 10 , 12 , null, 10  , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 10 , 19 , null, 6   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 10 , 19 , null, 8   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 10 , 19 , null, 9   , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (nextval('uspe_seq')+1000, 10 , 19 , null, 10  , 1, 1, current_timestamp, null, null, null, null);

create or replace function tmp_datos_de_prueba_vtas () returns varchar(100) as
$$
declare
  Vidcove  int;
begin
  insert into clientes values (nextval('clie_seq')            -- id                       numeric(20,0)   not null
                              ,1                              -- idgrem                   numeric(20,0)   not null
                              ,1                              -- idpais                   numeric(20,0)   not null
                              ,'10917721'                     -- identificador1           varchar(50)     not null
                              ,'0'                            -- identificador2           varchar(50)     not null
                              ,1                              -- idticl                   numeric(20,0)   not null
                              ,null                           -- razonsocial              varchar(100)        null
                              ,null                           -- nombrefantasia           varchar(100)        null
                              ,'CRISTIAN'                     -- primernombre             varchar(100)        null
                              ,null                           -- segundonombre            varchar(100)        null
                              ,'PALMA'                        -- apellidopaterno          varchar(100)        null
                              ,null                           -- apellidomaterno          varchar(100)        null
                              ,1                              -- idusuacrearegistro       numeric(20,0)   not null
                              ,current_timestamp              -- fechacrearegistro        timestamp       not null
                              ,null                           -- idusuamodifregistro      numeric(20,0)       null
                              ,null                           -- fechamodifregistro       timestamp           null
                              ,null                           -- idusuaborraregistro      numeric(20,0)       null
                              ,null                           -- fechaborraregistro       timestamp           null
                              )
  ;
  select nextval('cove_seq')
  into   Vidcove
  ;
  insert into cotizaciones_ventas values (Vidcove                    -- id                       numeric(20,0)   not null
                                         ,1                          -- idempr                   numeric(20,0)   not null
                                         ,1                          -- numero                   numeric(20,0)   not null
                                         ,1                          -- idclie                   numeric(20,0)   not null
                                         ,'PRUEBA'                   -- descripcioncotizacion    varchar(1000)   not null
                                         ,current_timestamp          -- fechacotizacion          timestamp       not null
                                         ,null                       -- idgere                   numeric(20,0)       null
                                         ,null                       -- idproy                   numeric(20,0)       null
                                         ,null                       -- idline                   numeric(20,0)       null
                                         ,null                       -- idceco                   numeric(20,0)       null
                                         ,null                       -- idtare                   numeric(20,0)       null
                                         ,0                          -- exento                   numeric(20,0)   not null
                                         ,3000                       -- afecto                   numeric(20,0)   not null
                                         ,570                        -- impuestosobligats        numeric(20,0)   not null
                                         ,0                          -- impuestosespecifs        numeric(20,0)   not null
                                         ,0                          -- porcentajedescuento      numeric(20,2)   not null
                                         ,0                          -- montodescuento           numeric(20,2)   not null
                                         ,3570                       -- total                    numeric(20,0)   not null
                                         ,5                          -- diasvalidez              numeric(20,0)   not null
                                         ,1                          -- idescv                   numeric(20,0)   not null
                                         ,3                          -- idusuavendedor           numeric(20,0)   not null
                                         ,1                          -- idusuacrearegistro       numeric(20,0)   not null
                                         ,current_timestamp          -- fechacrearegistro        timestamp       not null
                                         ,null                       -- idusuamodifregistro      numeric(20,0)       null
                                         ,null                       -- fechamodifregistro       timestamp           null
                                         ,null                       -- idusuaborraregistro      numeric(20,0)       null
                                         ,null                       -- fechaborraregistro       timestamp           null
                                         )
  ;
  insert into detalles_cotizs_vtas values (nextval('decv_seq')                       -- id                       numeric(20,0)   not null
                                          ,Vidcove                                   -- idcove                   numeric(20,0)   not null
                                          ,1                                         -- correlativo              numeric(20,0)   not null
                                          ,1                                         -- idprod                   numeric(20,0)       null
                                          ,null                                      -- idserv                   numeric(20,0)       null
                                          ,500                                       -- preciounitario           numeric(20,0)   not null
                                          ,2                                         -- cantidad                 numeric(20,2)   not null
                                          ,0                                         -- porcentajedescuento      numeric(20,2)   not null
                                          ,0                                         -- montodescuento           numeric(20,2)   not null
                                          ,0                                         -- exento                   numeric(20,0)   not null
                                          ,1000                                      -- afecto                   numeric(20,0)   not null
                                          ,190                                       -- impuestosobligats        numeric(20,2)   not null
                                          ,0                                         -- impuestosespecifs        numeric(20,2)   not null
                                          ,1190                                      -- totallinea               numeric(20,2)   not null
                                          ,1                                         -- idusuacrearegistro       numeric(20,0)   not null
                                          ,current_timestamp                         -- fechacrearegistro        timestamp       not null
                                          ,null                                      -- idusuamodifregistro      numeric(20,0)       null
                                          ,null                                      -- fechamodifregistro       timestamp           null
                                          ,null                                      -- idusuaborraregistro      numeric(20,0)       null
                                          ,null                                      -- fechaborraregistro       timestamp           null
                                          )
  ;
  insert into detalles_cotizs_vtas values (nextval('decv_seq')                       -- id                       numeric(20,0)   not null 
                                          ,Vidcove                                   -- idcove                   numeric(20,0)   not null
                                          ,2                                         -- correlativo              numeric(20,0)   not null
                                          ,2                                         -- idprod                   numeric(20,0)       null
                                          ,null                                      -- idserv                   numeric(20,0)       null
                                          ,100                                       -- preciounitario           numeric(20,0)   not null
                                          ,20                                        -- cantidad                 numeric(20,2)   not null
                                          ,0                                         -- porcentajedescuento      numeric(20,2)   not null
                                          ,0                                         -- montodescuento           numeric(20,2)   not null
                                          ,0                                         -- exento                   numeric(20,0)   not null
                                          ,2000                                      -- afecto                   numeric(20,0)   not null
                                          ,380                                       -- impuestosobligats        numeric(20,2)   not null
                                          ,0                                         -- impuestosespecifs        numeric(20,2)   not null
                                          ,2380                                      -- totallinea               numeric(20,2)   not null
                                          ,1                                         -- idusuacrearegistro       numeric(20,0)   not null
                                          ,current_timestamp                         -- fechacrearegistro        timestamp       not null
                                          ,null                                      -- idusuamodifregistro      numeric(20,0)       null
                                          ,null                                      -- fechamodifregistro       timestamp           null
                                          ,null                                      -- idusuaborraregistro      numeric(20,0)       null
                                          ,null                                      -- fechaborraregistro       timestamp           null
                                          )
  ;
  return('S');
end;
$$ LANGUAGE plpgsql;

select tmp_datos_de_prueba_vtas()
;

drop function tmp_datos_de_prueba_vtas()
;

-- bodegas_productos

insert into bodegas_productos values ( 1, 1,  1, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values ( 2, 1,  2, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values ( 3, 1,  3, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values ( 4, 1,  4, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values ( 5, 1,  5, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values ( 6, 1,  6, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values ( 7, 1,  7, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values ( 8, 1,  8, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values ( 9, 1,  9, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values (10, 1, 10, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values (11, 1, 11, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values (12, 1, 12, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values (13, 1, 13, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values (14, 1, 14, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values (15, 1, 15, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values (16, 1, 16, 100, 1, current_timestamp, null, null, null, null);
insert into bodegas_productos values (17, 1, 17, 100, 1, current_timestamp, null, null, null, null);

update cotizaciones_ventas
set    idescv = 2
;

update cotizaciones_ventas
set    idescv = 3
;

update notas_ventas
set    idesnv = 2
;

update notas_ventas
set    idesnv = 3
;

update ventas
set    idesve              = 2
      ,idusuamodifregistro = 10
      ,fechamodifregistro  = current_timestamp
;

-- listas precios

insert into listas_precios values (1, 1, 1, '01-01-2017', '31-12-2017', 'LISTA PRECIOS 2017', 2, 1, current_timestamp, 1   , current_timestamp, null, null);
insert into listas_precios values (2, 1, 2, '01-01-2018', null        , 'LISTA PRECIOS 2018', 1, 1, current_timestamp, null, null             , null, null);

insert into detalles_listas_precios values ( 1, 1,  1, 1000, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values ( 2, 1,  2, 1100, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values ( 3, 1,  3, 1200, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values ( 4, 1,  4, 1300, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values ( 5, 1,  5, 1000, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values ( 6, 1,  6, 1100, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values ( 7, 1,  7, 1200, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values ( 8, 1,  8, 1300, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values ( 9, 1,  9, 1000, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (10, 1, 10, 1100, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (11, 1, 11, 1200, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (12, 1, 12, 1300, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (13, 1, 13, 5000, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (14, 1, 14, 5100, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (15, 1, 15, 5200, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (16, 1, 16, 3000, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (17, 1, 17, 4000, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (18, 2,  1, 1100, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (19, 2,  2, 1200, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (20, 2,  3, 1300, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (21, 2,  4, 1400, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (22, 2,  5, 1100, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (23, 2,  6, 1200, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (24, 2,  7, 1300, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (25, 2,  8, 1400, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (26, 2,  9, 1100, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (27, 2, 10, 1200, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (28, 2, 11, 1300, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (29, 2, 12, 1400, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (30, 2, 13, 5100, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (31, 2, 14, 5200, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (32, 2, 15, 5300, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (33, 2, 16, 3100, 1, current_timestamp, null, null, null, null);
insert into detalles_listas_precios values (34, 2, 17, 4100, 1, current_timestamp, null, null, null, null);

-- descuentos

insert into descuentos values (1, 1   , null, null, 5  , 1, 1, current_timestamp, null, null, null, null);
insert into descuentos values (2, null, 1   , null, 10 , 1, 1, current_timestamp, null, null, null, null);
insert into descuentos values (3, null, null, 1   , 15 , 1, 1, current_timestamp, null, null, null, null);
insert into descuentos values (4, null, null, 2   , 20 , 1, 1, current_timestamp, null, null, null, null);
insert into descuentos values (5, null, null, 3   , 10 , 1, 1, current_timestamp, null, null, null, null);
insert into descuentos values (6, null, null, 4   , 15 , 1, 1, current_timestamp, null, null, null, null);
insert into descuentos values (7, null, null, 5   , 5  , 1, 1, current_timestamp, null, null, null, null);

insert into impuestos values (4, 1, 'IMPUESTO FICTICIO A LOS LIBROS (PRUEBA)', 'IFL' , 'N', 5);

insert into tipos_productos_impuestos values (nextval('tipi_seq'), 15, 4);

\q
