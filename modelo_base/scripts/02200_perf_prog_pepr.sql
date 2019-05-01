insert into perfiles values ( 1, 'CONFIGURADOR'                                   );
insert into perfiles values ( 2, 'ADMINISTRADOR DEL CLIENTE'                      );
insert into perfiles values ( 3, 'ADMINISTRADOR EMPRESA'                          );
insert into perfiles values ( 4, 'ADMINISTRADOR DEL CLIENTE Y EMPRESA'            );
insert into perfiles values ( 5, 'GERENTE GENERAL'                                );
insert into perfiles values ( 6, 'SECRETARIA GERENTE GENERAL'                     );
insert into perfiles values ( 7, 'GERENTE DE ADMINISTRACION Y FINANZAS'           );
insert into perfiles values ( 8, 'SECRETARIA GERENTE DE ADMINISTRACION Y FINANZAS');
insert into perfiles values ( 9, 'TESORERO'                                       );
insert into perfiles values (10, 'ASISTENTE 1 TESORERO'                           );
insert into perfiles values (11, 'ASISTENTE 2 TESORERO'                           );
insert into perfiles values (12, 'CAJERO'                                         );
insert into perfiles values (13, 'CONTADOR GENERAL'                               );
insert into perfiles values (14, 'ASISTENTE 1 CONTABILIDAD'                       );
insert into perfiles values (15, 'ASISTENTE 2 CONTABILIDAD'                       );
insert into perfiles values (16, 'JEFE DE COMPRAS'                                );
insert into perfiles values (17, 'AYUDANTE JEFE DE COMPRAS'                       );
insert into perfiles values (18, 'JEFE DE VENTAS'                                 );
insert into perfiles values (19, 'AYUDANTE JEFE DE VENTAS'                        );
insert into perfiles values (20, 'VENDEDOR'                                       );
insert into perfiles values (21, 'USUARIO'                                        );

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

insert into programas values ( 1000, null , 'Personales'                           , null                              , 'Personales'                                , 1  );
insert into programas values ( 1010,  1000, 'Mantención datos personales'          , 'personas/datos-personales'       , 'Mantención datos personales'               , 1  );
insert into programas values ( 1020,  1000, 'Cambio clave acceso'                  , 'usuarios/cambio_contrasena'      , 'Cambio clave acceso'                       , 2  );

insert into programas values ( 2000, null , 'Adm. sistema'                         , null                              , 'Administracion sistema'                    , 2  );
insert into programas values ( 2010,  2000, 'Mantención grupos empresariales'      , 'grupos-empresariales'            , 'Mantención grupos empresariales'           , 1  );
insert into programas values ( 2020,  2000, 'Mant. estados grupos empresariales'   , 'estados-grem'                    , 'Mantención estados grupos empresariales'   , 2  );
insert into programas values ( 2030,  2000, 'Mant. estados registros'              , 'estados-registros'               , 'Mantención estados registros'              , 3  );
insert into programas values ( 2040,  2000, 'Mant. estados civiles'                , 'estados-civiles'                 , 'Mantención estados civiles'                , 4  );
insert into programas values ( 2050,  2000, 'Mant. estados solics. servs. hono.'   , 'principales/en-construccion'     , 'Mantención estados solics. servs. hono.'   , 5  );
insert into programas values ( 2060,  2000, 'Mant. estados cotizacs. servs. hono.' , 'principales/en-construccion'     , 'Mantención estados cotizacs. servs. hono.' , 6  );
insert into programas values ( 2070,  2000, 'Mant. estados órdenes servs. hono.'   , 'principales/en-construccion'     , 'Mantención estados órdenes servs. hono.'   , 7  );
insert into programas values ( 2080,  2000, 'Mant. ests. pagos órds. servs. hono.' , 'principales/en-construccion'     , 'Mantención ests. pagos órds. servs. hono.' , 8  );
insert into programas values ( 2090,  2000, 'Mant. estados cotizaciones vtas.'     , 'estados-cotizaciones-vtas'       , 'Mantención estados cotizaciones vtas.'     , 9  );
insert into programas values ( 2100,  2000, 'Mant. estados notas vtas.'            , 'estados-notas-vtas'              , 'Mantención estados notas vtas.'            , 10 );
insert into programas values ( 2110,  2000, 'Mant. impuestos'                      , 'impuestos'                       , 'Mantención impuestos'                      , 11 );
insert into programas values ( 2120,  2000, 'Mant. tipos formas pagos'             , 'tipos-formas-pagos'              , 'Mantención tipos formas pagos'             , 12 );
insert into programas values ( 2130,  2000, 'Mant. tipos clientes'                 , 'tipos-clientes'                  , 'Mantención tipos clientes'                 , 13 );
insert into programas values ( 2140,  2000, 'Mant. tipos cotizaciones vtas.'       , 'tipos-cotizaciones-vtas'         , 'Mantención tipos cotizaciones vtas.'       , 14 );
insert into programas values ( 2150,  2000, 'Mant. tipos productos'                , 'tipos-productos'                 , 'Mantención tipos productos'                , 15 );
insert into programas values ( 2160,  2000, 'Mant. tipos productos impuestos'      , 'tipos-productos-impuestos'       , 'Mantención tipos productos impuestos'      , 16 );
insert into programas values ( 2170,  2000, 'Mant. tipos servicios'                , 'tipos-servicios'                 , 'Mantención tipos servicios'                , 17 );
insert into programas values ( 2180,  2000, 'Mant. unidades territoriales 1'       , 'unidades-territoriales-1'        , 'Mantención unidades territoriales 1'       , 18 );
insert into programas values ( 2190,  2000, 'Mant. unidades territoriales 2'       , 'unidades-territoriales-2'        , 'Mantención unidades territoriales 2'       , 19 );
insert into programas values ( 2200,  2000, 'Mant. unidades territoriales 3'       , 'unidades-territoriales-3'        , 'Mantención unidades territoriales 3'       , 20 );
insert into programas values ( 2210,  2000, 'Mant. estados ventas'                 , 'estados-ventas'                  , 'Mantención estados ventas'                 , 21 );
insert into programas values ( 2220,  2000, 'Mant. origenes productos'             , 'origenes-productos'              , 'Mantención origenes productos'             , 22 );
insert into programas values ( 2230,  2000, 'Mant. tipos doctos. ventas'           , 'tipos-doctos-ventas'             , 'Mantención tipos doctos. ventas'           , 23 );
insert into programas values ( 2240,  2000, 'Mant. unidades medidas productos'     , 'unidades-medidas-productos'      , 'Mantención unidades medidas productos'     , 24 );
insert into programas values ( 2250,  2000, 'Mant. unidades medidas servicios'     , 'unidades-medidas-servicios'      , 'Mantención unidades medidas servicios'     , 25 );
insert into programas values ( 2260,  2000, 'Mant. tipos movimientos bodegas'      , 'tipos-movimientos-bodegas'       , 'Mantención tipos movimientos bodegas'      , 26 );

insert into programas values ( 3000, null , 'Adm. holding'                         , null                              , 'Administracion holding'                    , 3  );
insert into programas values ( 3010,  3000, 'Mantención empresas'                  , 'empresas'                        , 'Mantención empresas'                       , 1  );
insert into programas values ( 3020,  3000, 'Mantención personas'                  , 'personas'                        , 'Mantención personas'                       , 2  );
insert into programas values ( 3030,  3000, 'Mantención usuarios'                  , 'mant-usuarios'                   , 'Mantención usuarios'                       , 3  );
insert into programas values ( 3040,  3000, 'Mantención parámetros'                , 'parametros'                      , 'Mantención parámetros'                     , 4  );
insert into programas values ( 3050,  3000, 'Mantención plan de cuentas'           , 'principales/en-construccion'     , 'Mantención plan de cuentas'                , 5  );
insert into programas values ( 3060,  3000, 'Mantención rubros'                    , 'rubros'                          , 'Mantención rubros'                         , 6  );
insert into programas values ( 3070,  3000, 'Mantención tipos documentos legales'  , 'TiposDocumentosLegales'          , 'Mantención tipos documentos legales'       , 7  );
insert into programas values ( 3080,  3000, 'Mantención estados documentos legales', 'estados-documentos-legales'      , 'Mantención estados documentos legales'     , 8  );
insert into programas values ( 3090,  3000, 'Mantención clientes'                  , 'clientes'                        , 'Mantención rubros'                         , 9  );

insert into programas values ( 4000, null , 'Adm. empresa'                         , null                              , 'Administracion empresa'                    , 4  );
insert into programas values ( 4010,  4000, 'Mantención gerencias'                 , 'gerencias'                       , 'Mantención gerencias'                      , 1  );
insert into programas values ( 4020,  4000, 'Mantención proyectos'                 , 'proyectos'                       , 'Mantención proyectos'                      , 2  );
insert into programas values ( 4030,  4000, 'Mantención líneas de negocios'        , 'lineas-negocios'                 , 'Mantención líneas de negocios'             , 3  );
insert into programas values ( 4040,  4000, 'Mantención centros costos'            , 'centros-costos'                  , 'Mantención centros costos'                 , 4  );
insert into programas values ( 4050,  4000, 'Mantención tareas'                    , 'tareas'                          , 'Mantención tareas'                         , 5  );
insert into programas values ( 4060,  4000, 'Mantención productos'                 , 'productos'                       , 'Mantención productos'                      , 6  );
insert into programas values ( 4070,  4000, 'Mantención servicios'                 , 'servicios'                       , 'Mantención servicios'                      , 7  );
insert into programas values ( 4080,  4000, 'Mantención listas precios'            , 'listas-precios'                  , 'Mantención listas precios'                 , 8  );
insert into programas values ( 4090,  4000, 'Mantención detalles listas precios'   , 'detalles-listas-precios'         , 'Mantención detalles listas precios'        , 9  );
insert into programas values ( 4100,  4000, 'Mantención descuentos'                , 'descuentos'                      , 'Mantención descuentos'                     , 10 );
insert into programas values ( 4110,  4000, 'Bitácoras cambios precios'            , 'bitacoras-cambios-precios'       , 'Bitácoras cambios precios'                 , 11 );
insert into programas values ( 4120,  4000, 'Mantención parámetros empresas'       , 'parametros_empresas'             , 'Mantención parámetros empresas'            , 12 );

insert into programas values ( 5000, null , 'Legales'                              , null                              , 'Legales'                                   , 5  );
insert into programas values ( 5010,  5000, 'Documentos legales'                   , 'DocumentosLegales'               , 'Documentos legales'                        , 1  );
insert into programas values ( 5020,  5000, 'Gráfica legales'                      , 'DocumentosLegales/estadisticas'  , 'Gráfica legales'                           , 2  );

insert into programas values ( 6000, null , 'Honorarios'                           , null                              , 'Honorarios'                                , 6  );
insert into programas values ( 6010,  6000, 'Honorarios 1'                         , 'principales/en-construccion'     , 'Honorarios 1'                              , 1  );
insert into programas values ( 6020,  6000, 'Honorarios 2'                         , 'principales/en-construccion'     , 'Honorarios 2'                              , 2  );
insert into programas values ( 6030,  6000, 'Honorarios 3'                         , 'principales/en-construccion'     , 'Honorarios 3'                              , 3  );
insert into programas values ( 6040,  6000, 'Honorarios 4'                         , 'principales/en-construccion'     , 'Honorarios 4'                              , 4  );
insert into programas values ( 6050,  6000, 'Honorarios 5'                         , 'principales/en-construccion'     , 'Honorarios 5'                              , 5  );

insert into programas values ( 7000, null , 'Rendiciones'                          , null                              , 'Rendiciones'                               , 7  );
insert into programas values ( 7010,  7000, 'Rendiciones 1'                        , 'principales/en-construccion'     , 'Rendiciones 1'                             , 1  );
insert into programas values ( 7020,  7000, 'Rendiciones 2'                        , 'principales/en-construccion'     , 'Rendiciones 2'                             , 2  );
insert into programas values ( 7030,  7000, 'Rendiciones 3'                        , 'principales/en-construccion'     , 'Rendiciones 3'                             , 3  );
insert into programas values ( 7040,  7000, 'Rendiciones 4'                        , 'principales/en-construccion'     , 'Rendiciones 4'                             , 4  );
insert into programas values ( 7050,  7000, 'Rendiciones 5'                        , 'principales/en-construccion'     , 'Rendiciones 5'                             , 5  );

insert into programas values ( 8000, null , 'Compras'                              , null                              , 'Compras'                                   , 8  );
insert into programas values ( 8010,  8000, 'Compras 1'                            , 'principales/en-construccion'     , 'Compras 1'                                 , 1  );
insert into programas values ( 8020,  8000, 'Compras 2'                            , 'principales/en-construccion'     , 'Compras 2'                                 , 2  );
insert into programas values ( 8030,  8000, 'Compras 3'                            , 'principales/en-construccion'     , 'Compras 3'                                 , 3  );
insert into programas values ( 8040,  8000, 'Compras 4'                            , 'principales/en-construccion'     , 'Compras 4'                                 , 4  );
insert into programas values ( 8050,  8000, 'Compras 5'                            , 'principales/en-construccion'     , 'Compras 5'                                 , 5  );

insert into programas values ( 9000, null , 'Ventas'                               , null                              , 'Ventas'                                    , 9  );
insert into programas values ( 9010,  9000, 'Cotizaciones ventas'                  , 'CotizacionesVentas'              , 'Cotizaciones ventas'                       , 1  );
insert into programas values ( 9020,  9000, 'Notas ventas'                         , 'NotasVentas'                     , 'Notas ventas'                              , 2  );
insert into programas values ( 9030,  9000, 'Ventas'                               , 'Ventas'                          , 'Ventas'                                    , 3  );
insert into programas values ( 9040,  9000, 'Ventas 4'                             , 'principales/en-construccion'     , 'Ventas 4'                                  , 4  );
insert into programas values ( 9050,  9000, 'Ventas 5'                             , 'principales/en-construccion'     , 'Ventas 5'                                  , 5  );

insert into programas values (10000, null , 'Contabilidad'                         , null                              , 'Contabilidad'                              , 10 );
insert into programas values (10010, 10000, 'Contabilidad 1'                       , 'principales/en-construccion'     , 'Contabilidad 1'                            , 1  );
insert into programas values (10020, 10000, 'Contabilidad 2'                       , 'principales/en-construccion'     , 'Contabilidad 2'                            , 2  );
insert into programas values (10030, 10000, 'Contabilidad 3'                       , 'principales/en-construccion'     , 'Contabilidad 3'                            , 3  );
insert into programas values (10040, 10000, 'Contabilidad 4'                       , 'principales/en-construccion'     , 'Contabilidad 4'                            , 4  );
insert into programas values (10050, 10000, 'Contabilidad 5'                       , 'principales/en-construccion'     , 'Contabilidad 5'                            , 5  );

insert into programas values (11000, null , 'Existencias'                          , null                              , 'Existencias'                               , 11 );
insert into programas values (11010, 11000, 'Mantención bodegas'                   , 'bodegas'                         , 'Mantención bodegas'                        , 1  );
insert into programas values (11020, 11000, 'Mantención familias productos'        , 'familias-productos'              , 'Mantención familias productos'             , 2  );
insert into programas values (11030, 11000, 'Mantención sub familias productos'    , 'sub-familias-productos'          , 'Mantención sub familias productos'         , 3  );
insert into programas values (11040, 11000, 'Productos por bodega'                 , 'bodegas-productos'               , 'Productos por bodega'                      , 4  );
insert into programas values (11050, 11000, 'Movimientos bodegas'                  , 'movimientos-bodegas'             , 'Movimientos bodegas'                       , 5  );
insert into programas values (11060, 11000, 'Detalles movtos. bodegas'             , 'detalles-movtos-bodegas'         , 'Detalles movtos. bodegas'                  , 6  );

insert into programas values (99000, null , 'Cambiar emp./perf.'                   , 'sel-perfil'                      , 'Cambiar empresa/perfil'                    , 999);

insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  1020, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2020, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2030, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2040, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2050, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2060, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2070, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2080, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2090, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2100, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2110, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2120, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2130, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2140, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2150, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2160, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2170, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2180, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2190, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2200, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2210, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2220, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2230, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2240, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2250, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 1 ,  2260, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 2 ,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 2 ,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 2 ,  1020, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 2 ,  3000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 2 ,  3010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 2 ,  3020, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 2 ,  3030, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 2 ,  3040, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 2 ,  3050, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 2 ,  3060, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 2 ,  3070, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 2 ,  3080, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 2 ,  3090, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  1020, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  4000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  4010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  4020, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  4030, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  4040, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  4050, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  4060, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  4070, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  4080, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  4090, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  4100, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  4110, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 3 ,  4120, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  1020, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  3000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  3010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  3020, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  3030, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  3040, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  3060, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  3070, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  3080, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  3090, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  4000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  4010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  4020, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  4030, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  4040, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  4050, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  4060, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  4070, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  4080, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  4090, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  4100, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  4110, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  4120, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  5000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  5010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 ,  5020, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 , 11000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 , 11010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 , 11020, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 , 11030, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 , 11040, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 , 11050, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 4 , 11060, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 5 ,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 5 ,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 5 ,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 6 ,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 6 ,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 6 ,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 7 ,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 7 ,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 7 ,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 8 ,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 8 ,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 8 ,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 9 ,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 9 ,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 9 ,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 10,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 10,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 10,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 11,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 11,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 11,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 12,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 12,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 12,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 13,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 13,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 13,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 14,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 14,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 14,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 15,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 15,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 15,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 16,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 16,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 16,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 17,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 17,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 17,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 18,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 18,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 18,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 19,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 19,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 19,  1020, 1, current_timestamp, null, null, null, null);

insert into perfiles_programas values (nextval('pepr_seq'), 21,  1000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 21,  1010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 21,  1020, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 21,  5000, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 21,  5010, 1, current_timestamp, null, null, null, null);
insert into perfiles_programas values (nextval('pepr_seq'), 21,  5020, 1, current_timestamp, null, null, null, null);

\q
