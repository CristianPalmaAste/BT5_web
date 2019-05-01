set client_min_messages to warning;

insert into monedas values (1 , 'PESO CHILENO'   , 'CLP');
insert into monedas values (2 , 'PESO ARGENTINO' , 'ARS');
insert into monedas values (3 , 'NUEVO SOL'      , 'PEN');
insert into monedas values (4 , 'BOLIVIANO'      , 'BOB');
insert into monedas values (5 , 'GUARANÍ'        , 'PYG');
insert into monedas values (6 , 'PESO URUGUAYO'  , 'UYU');
insert into monedas values (7 , 'REAL'           , 'BRL');
insert into monedas values (8 , 'SUCRE'          , 'ECS');
insert into monedas values (9 , 'BOLÍVAR'        , 'VEB');
insert into monedas values (10, 'PESO COLOMBIANO', 'COP');

insert into paises values (1 , 'CHILE'    , 1 , 'CHILENA'    );
insert into paises values (2 , 'ARGENTINA', 2 , 'ARGENTINA'  );
insert into paises values (3 , 'PERÚ'     , 3 , 'PERUANA'    );
insert into paises values (4 , 'BOLIVIA'  , 4 , 'BOLIVIANA'  );
insert into paises values (5 , 'PARAGUAY' , 5 , 'PARAGUAYA'  );
insert into paises values (6 , 'URUGUAY'  , 6 , 'URUGUAYA'   );
insert into paises values (7 , 'BRASIL'   , 7 , 'BRASILEÑA'  );
insert into paises values (8 , 'ECUADOR'  , 8 , 'ECUATORIANA');
insert into paises values (9 , 'VENEZUELA', 9 , 'VENEZOLANA' );
insert into paises values (10, 'COLOMBIA' , 10, 'COLOMBIANA' );

/* Deshabilito algunas constraints para poder insertar datos iniciales */
alter table usuarios             disable trigger all;
alter table grupos_empresariales disable trigger all;
alter table personas             disable trigger all;

insert into estados_registros values (1, 'ACTIVO'  );
insert into estados_registros values (2, 'INACTIVO');
insert into estados_registros values (3, 'BORRADO' );

insert into estados_grem values (1, 'ACTIVO'    );
insert into estados_grem values (2, 'INACTIVO'  );
insert into estados_grem values (3, 'BORRADO'   );
insert into estados_grem values (4, 'SUSPENDIDO');

insert into estados_civiles values (1, 'S', 'SOLTERO');
insert into estados_civiles values (2, 'C', 'CASADO' );

insert into sexos values (1, 'M', 'MASCULINO');
insert into sexos values (2, 'F', 'FEMENINO' );

insert into grupos_empresariales values (1, 'BUSINESS & TECHNOLOGY 5 CONSULTING', 'BT5', 'bt5.jpg', 1, 1, current_timestamp, null, null, null, null);
insert into rubros values (1, 1, 'CONSULTORÍA' );

insert into personas values (1, 1, 1, '9', 'ADMINISTRADOR', null, 'SISTEMA', 'AS', null, null, null, null, null, 1, current_timestamp, null, null, null, null);

insert into usuarios values (1, 'ADMIN', '12345', 1, 1, 1, current_timestamp, null, null, null, null);

/* Rehabilito constraints deshabilitadas */
alter table usuarios             enable trigger all;
alter table grupos_empresariales enable trigger all;
alter table personas             enable trigger all;

insert into personas values (2 , 1, 2       , '0', 'ROLANDO'    , null      , 'SILVA'    , '-'        ,  ''                            , null        , 2   , 1, 1, 1, current_timestamp, null, null, null, null);
insert into personas values (3 , 1, 3       , '0', 'SERGIO'     , null      , 'AGUIRRE'  , '-'        ,  'sergio.aguirre@bt5.cl'       , null        , 1   , 1, 1, 1, current_timestamp, null, null, null, null);
insert into personas values (4 , 1, 4       , '0', 'JUAN'       , 'JOSÉ'    , 'MONSALVE' , '-'        ,  'juan.jose.monsalve@bt5.cl'   , null        , null, 1, 1, 1, current_timestamp, null, null, null, null);
insert into personas values (5 , 1, 5       , '0', 'JUAN'       , 'ANDRÉS'  , 'BORZONE'  , '-'        ,  ''                            , null        , null, 1, 1, 1, current_timestamp, null, null, null, null);
insert into personas values (6 , 1, 6       , '0', 'RODRIGO'    , null      , 'CIFUENTES', '-'        ,  'rodrigo.cifuentes@bt5.cl'    , null        , 1   , 1, 1, 1, current_timestamp, null, null, null, null);
insert into personas values (7 , 1, 7695503 , '4', 'ROBERTO'    , 'DANIEL'  , 'QUEZADA'  , 'ASTE'     ,  'roberto.quezada@bt5.cl'      , null        , 2   , 1, 1, 1, current_timestamp, null, null, null, null);
insert into personas values (8 , 1, 8965445 , '9', 'OSCIEL'     , 'SEGUNDO' , 'SOLAR'    , 'MALDONADO',  'solar2design@gmail.com'      , null        , 2   , 1, 1, 1, current_timestamp, null, null, null, null);
insert into personas values (9 , 1, 13254825, '0', 'NILTON'     , 'PATRICIO', 'SALAZAR'  , 'GONZÁLEZ' ,  'nilton.salazar@gmail.com'    , null        , 1   , 1, 1, 1, current_timestamp, null, null, null, null);
insert into personas values (10, 1, 10917721, '0', 'G. CRISTIAN', null      , 'PALMA'    , 'ASTE'     ,  'gerardo.palma.aste@gmail.com', '12-11-1968', 1   , 1, 1, 1, current_timestamp, null, null, null, null);

insert into usuarios values (2 , 'ROSILVA'    , '12345', 2 , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios values (3 , 'SEAGUIRRE'  , '12345', 3 , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios values (4 , 'JJMONSALVE' , '12345', 4 , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios values (5 , 'JABORZONE'  , '12345', 5 , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios values (6 , 'ROCIFUENTES', '12345', 6 , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios values (7 , 'RQUEZADAA'  , '12345', 7 , 2, 1, current_timestamp, null, null, null, null);
insert into usuarios values (8 , 'OSOLARM'    , '12345', 8 , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios values (9 , 'NSALAZARG'  , '12345', 9 , 1, 1, current_timestamp, null, null, null, null);
insert into usuarios values (10, 'CPALMAA'    , '12345', 10, 1, 1, current_timestamp, null, null, null, null);

insert into empresas values (1 , 1, 1, 1, '1', '9', 'BUSINESS & TECHNOLOGY 5 CONSULTING', 'BT5', 'bt5.jpg', 1, current_timestamp, null, null, null, null, null);

insert into perfiles values ( 1, 'ADMINISTRADOR DEL SISTEMA'                      );
insert into perfiles values ( 2, 'ADMINISTRADOR HOLDING'                          );
insert into perfiles values ( 3, 'PRIVILEGIOS TOTALES EMPRESA'                    );
insert into perfiles values ( 4, 'GERENTE GENERAL'                                );
insert into perfiles values ( 5, 'SECRETARIA GERENTE GENERAL'                     );
insert into perfiles values ( 6, 'GERENTE DE ADMINISTRACIÓN Y FINANZAS'           );
insert into perfiles values ( 7, 'SECRETARIA GERENTE DE ADMINISTRACIÓN Y FINANZAS');
insert into perfiles values ( 8, 'TESORERO'                                       );
insert into perfiles values ( 9, 'ASISTENTE 1 TESORERO'                           );
insert into perfiles values (10, 'ASISTENTE 2 TESORERO'                           );
insert into perfiles values (11, 'CAJERO'                                         );
insert into perfiles values (12, 'CONTADOR GENERAL'                               );
insert into perfiles values (13, 'ASISTENTE 1 CONTABILIDAD'                       );
insert into perfiles values (14, 'ASISTENTE 2 CONTABILIDAD'                       );
insert into perfiles values (15, 'JEFE DE COMPRAS'                                );
insert into perfiles values (16, 'AYUDANTE JEFE DE COMPRAS'                       );
insert into perfiles values (17, 'JEFE DE VENTAS'                                 );

insert into usuarios_perfiles values (1 , 1 , 1, null, null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (2 , 2 , 1, null, null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (3 , 3 , 1, null, null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (4 , 4 , 1, null, null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (5 , 5 , 1, null, null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (6 , 6 , 1, null, null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (7 , 7 , 1, null, null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (8 , 8 , 1, null, null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (9 , 9 , 1, null, null, 1, 1, current_timestamp, null, null, null, null);
insert into usuarios_perfiles values (10, 10, 1, null, null, 1, 1, current_timestamp, null, null, null, null);

create or replace function tmp_datos_iniciales () returns varchar(100) as
$$
declare
  Vidprog       int;
  Vidprogpadre  int;
begin
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, null        , 'Personales'                     , null            , 'Personales'                     , 1 );
  Vidprogpadre := Vidprog;
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Mantención datos personales'    , 'mantdatpers'   , 'Mantención datos personales'    , 1 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Cambio clave acceso'            , 'cambioclave'   , 'Cambio clave acceso'            , 2 );
  --
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, null        , 'Adm. sistema'                   , null            , 'Administración sistema'         , 2 );
  Vidprogpadre := Vidprog;
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Mantención grupos empresariales', 'mantgrem'      , 'Mantención grupos empresariales', 1 );
  --
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, null        , 'Adm. holding'                   , null            , 'Administración holding'         , 3 );
  Vidprogpadre := Vidprog;
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Mantención empresas'            , 'mantempr'      , 'Mantención empresas'            , 1 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Mantención usuarios'            , 'mantusua'      , 'Mantención usuarios'            , 2 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Mantención plan de cuentas'     , 'mantplancta'   , 'Mantención plan de cuentas'     , 3 );
  --
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, null        , 'Legales'                        , null            , 'Legales'                        , 4 );
  Vidprogpadre := Vidprog;
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Legales 1'                      , 'legales_1'     , 'Legales 1'                      , 1 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Legales 2'                      , 'legales_2'     , 'Legales 2'                      , 2 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Legales 3'                      , 'legales_3'     , 'Legales 3'                      , 3 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Legales 4'                      , 'legales_4'     , 'Legales 4'                      , 4 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Legales 5'                      , 'legales_5'     , 'Legales 5'                      , 5 );
  --
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, null        , 'Honorarios'                     , null            , 'Honorarios'                     , 5 );
  Vidprogpadre := Vidprog;
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Honorarios 1'                   , 'honorarios_1'  , 'Honorarios 1'                   , 1 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Honorarios 2'                   , 'honorarios_2'  , 'Honorarios 2'                   , 2 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Honorarios 3'                   , 'honorarios_3'  , 'Honorarios 3'                   , 3 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Honorarios 4'                   , 'honorarios_4'  , 'Honorarios 4'                   , 4 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Honorarios 5'                   , 'honorarios_5'  , 'Honorarios 5'                   , 5 );
  --
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, null        , 'Rendiciones'                    , null            , 'Rendiciones'                    , 6 );
  Vidprogpadre := Vidprog;
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Rendiciones 1'                  , 'rendiciones_1' , 'Rendiciones 1'                  , 1 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Rendiciones 2'                  , 'rendiciones_2' , 'Rendiciones 2'                  , 2 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Rendiciones 3'                  , 'rendiciones_3' , 'Rendiciones 3'                  , 3 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Rendiciones 4'                  , 'rendiciones_4' , 'Rendiciones 4'                  , 4 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Rendiciones 5'                  , 'rendiciones_5' , 'Rendiciones 5'                  , 5 );
  --
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, null        , 'Compras'                        , null            , 'Compras'                        , 7 );
  Vidprogpadre := Vidprog;
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Compras 1'                      , 'compras_1'     , 'Compras 1'                      , 1 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Compras 2'                      , 'compras_2'     , 'Compras 2'                      , 2 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Compras 3'                      , 'compras_3'     , 'Compras 3'                      , 3 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Compras 4'                      , 'compras_4'     , 'Compras 4'                      , 4 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Compras 5'                      , 'compras_5'     , 'Compras 5'                      , 5 );
  --
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, null        , 'Ventas'                         , null            , 'Ventas'                         , 8 );
  Vidprogpadre := Vidprog;
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Ventas 1'                       , 'ventas_1'      , 'Ventas 1'                       , 1 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Ventas 2'                       , 'ventas_2'      , 'Ventas 2'                       , 2 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Ventas 3'                       , 'ventas_3'      , 'Ventas 3'                       , 3 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Ventas 4'                       , 'ventas_4'      , 'Ventas 4'                       , 4 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Ventas 5'                       , 'ventas_5'      , 'Ventas 5'                       , 5 );
  --
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, null        , 'Contabilidad'                   , null            , 'Contabilidad'                   , 9 );
  Vidprogpadre := Vidprog;
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Contabilidad 1'                 , 'contabilidad_1', 'Contabilidad 1'                 , 1 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Contabilidad 2'                 , 'contabilidad_2', 'Contabilidad 2'                 , 2 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Contabilidad 3'                 , 'contabilidad_3', 'Contabilidad 3'                 , 3 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Contabilidad 4'                 , 'contabilidad_4', 'Contabilidad 4'                 , 4 );
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, Vidprogpadre, 'Contabilidad 5'                 , 'contabilidad_5', 'Contabilidad 5'                 , 5 );
  --
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, null        , 'Cambiar emp./perf.'             , 'camb_emp_perf' , 'Cambiar empresa/perfil'         , 10);
  select nextval('prog_seq') into Vidprog;
  insert into programas values (Vidprog, null        , 'Salir'                          , 'salir'         , 'Salir'                          , 11);
  --
  return('S');
end;
$$ LANGUAGE plpgsql;

select tmp_datos_iniciales()
;

drop function tmp_datos_iniciales()
;

insert into perfiles_programas values (1 , 1, 1 , 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (2 , 1, 2 , 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (3 , 1, 3 , 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (4 , 1, 4 , 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (5 , 1, 5 , 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (6 , 1, 6 , 1, current_timestamp, null, null, null, null);


insert into valores_paises values (nextval('vapa_seq'), 1 , 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUT',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 1 , 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 1 , 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUT',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 1 , 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 1 , 'RETHON' , 'RETENCIÓN HONORARIOS'                   , '% RETENCIÓN DE HONORARIOS EN ESTE PAÍS' , '10' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 2 , 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'DNI',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 2 , 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 2 , 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUT',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 2 , 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 2 , 'RETHON' , 'RETENCIÓN HONORARIOS'                   , '% RETENCIÓN DE HONORARIOS EN ESTE PAÍS' , '10' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 3 , 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 3 , 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 3 , 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 3 , 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 3 , 'RETHON' , 'RETENCIÓN HONORARIOS'                   , '% RETENCIÓN DE HONORARIOS EN ESTE PAÍS' , '10' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 4 , 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 4 , 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 4 , 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 4 , 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 4 , 'RETHON' , 'RETENCIÓN HONORARIOS'                   , '% RETENCIÓN DE HONORARIOS EN ESTE PAÍS' , '10' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 5 , 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 5 , 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 5 , 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 5 , 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 5 , 'RETHON' , 'RETENCIÓN HONORARIOS'                   , '% RETENCIÓN DE HONORARIOS EN ESTE PAÍS' , '10' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 6 , 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 6 , 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 6 , 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 6 , 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 6 , 'RETHON' , 'RETENCIÓN HONORARIOS'                   , '% RETENCIÓN DE HONORARIOS EN ESTE PAÍS' , '10' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 7 , 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 7 , 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 7 , 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 7 , 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 7 , 'RETHON' , 'RETENCIÓN HONORARIOS'                   , '% RETENCIÓN DE HONORARIOS EN ESTE PAÍS' , '10' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 8 , 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 8 , 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 8 , 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 8 , 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 8 , 'RETHON' , 'RETENCIÓN HONORARIOS'                   , '% RETENCIÓN DE HONORARIOS EN ESTE PAÍS' , '10' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 9 , 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 9 , 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 9 , 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 9 , 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 9 , 'RETHON' , 'RETENCIÓN HONORARIOS'                   , '% RETENCIÓN DE HONORARIOS EN ESTE PAÍS' , '10' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 10, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 10, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 10, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC',  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 10, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV' ,  1, current_timestamp, null, null, null, null);
insert into valores_paises values (nextval('vapa_seq'), 10, 'RETHON' , 'RETENCIÓN HONORARIOS'                   , '% RETENCIÓN DE HONORARIOS EN ESTE PAÍS' , '10' ,  1, current_timestamp, null, null, null, null);

\q
