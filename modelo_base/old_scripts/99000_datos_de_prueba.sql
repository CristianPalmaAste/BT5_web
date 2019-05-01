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
  insert into grupos_empresariales values (Vidgrem, 'METALPAR'          , 'MPAR', 'metalpar.jpg', 1, 1, current_timestamp, null, null, null, null);
  select nextval('pers_seq') into Vidpers;
  insert into personas values (Vidpers, Vidgrem, 13047104, '8', 'JUAN', null, 'CISTERNA', 'FUENTES', null, null, null, null, null, 1, current_timestamp, null, null, null, null);
  select nextval('usua_seq') into Vidusua;
  insert into usuarios values (Vidusua, 'JCISTERNAF', '12345', Vidpers, 1, 1, current_timestamp, null, null, null, null);
  select nextval('rubr_seq') into Vidrubr;
    -- rubros
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'CONSULTORÍA' );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'AUTOMOTRIZ'  );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'INDUSTRIAL'  );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'INVERSIONES' );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'AGRICOLA'    );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'FARMACÉUTICO');
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'LOGÍSTICA'   );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'AMASANDERÍA' );
    -- empresas
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-6, '96550820', '1', 'METALPAR S.A.'                     , 'METALPAR S.A.'            , 'metalpar_sa.jpg', 1, current_timestamp, null, null, null, null, '');
    select nextval('uspe_seq') into Viduspe;
    insert into usuarios_perfiles values (Viduspe, Vidusua, 8, null, Vidempr, 1, 1, current_timestamp, null, null, null, null);
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-5, '93576000', '3', 'INDUSTRIAS METALURGICAS PAREDES'   , 'INDUSTRIAL METALPAR S.A.' , 'industrias.jpg' , 1, current_timestamp, null, null, null, null, '');
    select nextval('uspe_seq') into Viduspe;
    insert into usuarios_perfiles values (Viduspe, Vidusua, 12, null, Vidempr, 1, 1, current_timestamp, null, null, null, null);
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-4, '88337800', '8', 'INVERSIONES METALPAR S.A.'         , 'INVERSIONES METALPAR S.A.', 'inversiones.jpg', 1, current_timestamp, null, null, null, null, '');
    select nextval('uspe_seq') into Viduspe;
    insert into usuarios_perfiles values (Viduspe, Vidusua, 15, null, Vidempr, 1, 1, current_timestamp, null, null, null, null);
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-3, '78400010', '9', 'AGRICOLA Y GANADERA SANTA BARBARA' , 'STA. BARBARA'             , 'stabarbara.jpg' , 1, current_timestamp, null, null, null, null, '');
    select nextval('uspe_seq') into Viduspe;
    insert into usuarios_perfiles values (Viduspe, Vidusua, 17, null, Vidempr, 1, 1, current_timestamp, null, null, null, null);
    --
    select nextval('pepr_seq') into Vidpepr;
    insert into perfiles_programas values (Vidpepr, 8 , 1, 1, current_timestamp, null, null, null, null);
    select nextval('pepr_seq') into Vidpepr;
    insert into perfiles_programas values (Vidpepr, 8 , 2, 1, current_timestamp, null, null, null, null);
    select nextval('pepr_seq') into Vidpepr;
    insert into perfiles_programas values (Vidpepr, 8 , 3, 1, current_timestamp, null, null, null, null);
    select nextval('pepr_seq') into Vidpepr;
    insert into perfiles_programas values (Vidpepr, 12, 1, 1, current_timestamp, null, null, null, null);
    select nextval('pepr_seq') into Vidpepr;
    insert into perfiles_programas values (Vidpepr, 12, 2, 1, current_timestamp, null, null, null, null);
    select nextval('pepr_seq') into Vidpepr;
    insert into perfiles_programas values (Vidpepr, 12, 3, 1, current_timestamp, null, null, null, null);
    select nextval('pepr_seq') into Vidpepr;
    insert into perfiles_programas values (Vidpepr, 15, 1, 1, current_timestamp, null, null, null, null);
    select nextval('pepr_seq') into Vidpepr;
    insert into perfiles_programas values (Vidpepr, 15, 2, 1, current_timestamp, null, null, null, null);
    select nextval('pepr_seq') into Vidpepr;
    insert into perfiles_programas values (Vidpepr, 15, 3, 1, current_timestamp, null, null, null, null);
    select nextval('pepr_seq') into Vidpepr;
    insert into perfiles_programas values (Vidpepr, 17, 1, 1, current_timestamp, null, null, null, null);
    select nextval('pepr_seq') into Vidpepr;
    insert into perfiles_programas values (Vidpepr, 17, 2, 1, current_timestamp, null, null, null, null);
    select nextval('pepr_seq') into Vidpepr;
    insert into perfiles_programas values (Vidpepr, 17, 3, 1, current_timestamp, null, null, null, null);

  select nextval('grem_seq') into Vidgrem;
  insert into grupos_empresariales values (Vidgrem, 'CRUZ VERDE'        , 'CV'  , 'cv.jpg'      , 1, 1, current_timestamp, null, null, null, null);
    -- rubros
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'CONSULTORÍA' );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'AUTOMOTRIZ'  );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'INDUSTRIAL'  );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'INVERSIONES' );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'AGRICOLA'    );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'FARMACÉUTICO');
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'LOGÍSTICA'   );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'AMASANDERÍA' );
    -- empresas
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-2, '89807200', '2', 'FARMACIAS CRUZ VERDE'              , 'FCV'                      , 'fcv.jpg'        , 1, current_timestamp, null, null, null, null, '');
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-2, '89741200', '4', 'DIFARMA'                           , 'DIFARMA'                  , 'difarma.jpg'    , 1, current_timestamp, null, null, null, null, '');
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-1, '91575000', '1', 'SOCOFAR'                           , 'SOCOFAR'                  , 'socofar.jpg'    , 1, current_timestamp, null, null, null, null, '');
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-2, '71378000', '6', 'LABORATORIO MINTLAB'               , 'MINTLAB'                  , 'mintlab.jpg'    , 1, current_timestamp, null, null, null, null, '');
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-2, '77781470', '2', 'LABORATORIO MUNICH'                , 'MUNICH'                   , 'munich.jpg'     , 1, current_timestamp, null, null, null, null, '');

  select nextval('grem_seq') into Vidgrem;
  insert into grupos_empresariales values (Vidgrem, 'AMASANDERÍA TRIGAL', 'AT'  , 'at.jpg'      , 1, 1, current_timestamp, null, null, null, null);
    -- rubros
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'CONSULTORÍA' );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'AUTOMOTRIZ'  );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'INDUSTRIAL'  );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'INVERSIONES' );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'AGRICOLA'    );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'FARMACÉUTICO');
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'LOGÍSTICA'   );
    select nextval('rubr_seq') into Vidrubr;
    insert into rubros values (Vidrubr, Vidgrem, 'AMASANDERÍA' );
    -- empresas
    select nextval('empr_seq') into Vidempr;
    insert into empresas values (Vidempr, Vidgrem, 1, Vidrubr-0, '76765660', '2', 'AMASANDERÍA TRIGAL'                , 'TRIGAL'                   , 'trigal.jpg'     , 1, current_timestamp, null, null, null, null, '');

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
begin
  select nextval('pers_seq') into Vidpers;
  insert into personas values (Vidpers, 1, 999, '8', 'USUARIO', null, 'ACCESO', 'TOTAL', null, null, null, null, null, 1, current_timestamp, null, null, null, null);
  select nextval('usua_seq') into Vidusua;
  insert into usuarios values (Vidusua, 'UAT', '12345', Vidpers, 1, 1, current_timestamp, null, null, null, null);
  select nextval('perf_seq') into Vidperf;
  insert into perfiles values (Vidperf, 'PERFIL DE PRUEBA CON ACCESO A TODO');
  select nextval('uspe_seq') into Viduspe;
  insert into usuarios_perfiles values (Viduspe, Vidusua, Vidperf, null, 1, 1, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 1, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 2 , 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 3 , 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 4 , 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 5 , 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 6 , 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 7 , 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 8 , 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 9 , 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 10, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 11, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 12, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 13, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 14, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 15, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 16, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 17, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 18, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 19, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 20, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 21, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 22, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 23, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 24, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 25, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 26, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 27, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 28, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 29, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 30, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 31, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 32, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 33, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 34, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 35, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 36, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 37, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 38, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 39, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 40, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 41, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 42, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 43, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 44, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 45, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 46, 1, current_timestamp, null, null, null, null);
  select nextval('pepr_seq') into Vidpepr;
  insert into perfiles_programas values (Vidpepr, Vidperf, 47, 1, current_timestamp, null, null, null, null);
  return('S');
end;
$$ LANGUAGE plpgsql;

select tmp_usuario_acc_total()
;

drop function tmp_usuario_acc_total()
;

\q
