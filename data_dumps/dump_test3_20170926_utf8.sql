--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: admin
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO admin;

SET search_path = public, pg_catalog;

--
-- Name: f_crear_datos_holding(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_crear_datos_holding() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
  insert into parametros values (nextval('para_seq'), new.id, 'LARGOMINCLAVE', 'LARGO MINIMO CLAVE USUARIOS'              , 'LARGO MINIMO EXIGIDO PARA LAS CLAVE DE LOS USUARIOS'                , '5', 1, current_timestamp, null, null, null, null);
  insert into parametros values (nextval('para_seq'), new.id, 'NROSEGMSPLCU' , 'NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS', 'NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING', '4', 1, current_timestamp, null, null, null, null);

  insert into rubros values (nextval('rubr_seq'), new.id, 'CONSULTORIA' );
  insert into rubros values (nextval('rubr_seq'), new.id, 'AUTOMOTRIZ'  );
  insert into rubros values (nextval('rubr_seq'), new.id, 'INDUSTRIAL'  );
  insert into rubros values (nextval('rubr_seq'), new.id, 'INVERSIONES' );
  insert into rubros values (nextval('rubr_seq'), new.id, 'AGRICOLA'    );
  insert into rubros values (nextval('rubr_seq'), new.id, 'FARMACEUTICO');
  insert into rubros values (nextval('rubr_seq'), new.id, 'LOGISTICA'   );
  insert into rubros values (nextval('rubr_seq'), new.id, 'AMASANDERIA' );

  insert into tipos_documentos_legales values (nextval('tidl_seq'), new.id, 'CONSTITUCION DE SOCIEDAD', 1, current_timestamp, null, null, null, null);
  insert into tipos_documentos_legales values (nextval('tidl_seq'), new.id, 'ACTA DE DIRECTORIO'      , 1, current_timestamp, null, null, null, null);
  insert into tipos_documentos_legales values (nextval('tidl_seq'), new.id, 'SESION DE DIRECTORIO'    , 1, current_timestamp, null, null, null, null);
  insert into tipos_documentos_legales values (nextval('tidl_seq'), new.id, 'CONTRATO DE ARRIENDO'    , 1, current_timestamp, null, null, null, null);

  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '00', '00', '0000', null, null, null, null, 'ACTIVOS'                                                           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '00', '0000', null, null, null, null, 'ACTIVOS CORRIENTES'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '0000', null, null, null, null, 'EFECTIVO Y EQUIVALENTE AL EFECTIVO'                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '1001', null, null, null, null, 'CAJA'                                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '1002', null, null, null, null, 'FONDO FIJO'                                                        , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '2001', null, null, null, null, 'BANCO SANTANDER'                                                   , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '2002', null, null, null, null, 'BANCO DE CHILE'                                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '2003', null, null, null, null, 'BANCO BBVA'                                                        , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '2004', null, null, null, null, 'BANCO BCI'                                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '2005', null, null, null, null, 'BANCO ITAU'                                                        , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '2006', null, null, null, null, 'BANCO SECURITY'                                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '2007', null, null, null, null, 'BANCO SANTANDER DOLAR'                                             , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '2008', null, null, null, null, 'BANCO DE CHILE DOLAR'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '2009', null, null, null, null, 'BANCO BBVA DOLAR'                                                  , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '2010', null, null, null, null, 'BANCO BCI DOLAR'                                                   , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '2011', null, null, null, null, 'BANCO ITAU DOLAR'                                                  , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '10', '2012', null, null, null, null, 'BANCO SECURITY DOLAR'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '11', '0000', null, null, null, null, 'OTROS ACTIVOS FINANCIEROS'                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '11', '0001', null, null, null, null, 'DEPOSITOS A PLAZO'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '11', '1002', null, null, null, null, 'FONDOS MUTUOS'                                                     , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '11', '1003', null, null, null, null, 'PACTOS RETROVENTA'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '12', '0000', null, null, null, null, 'OTROS ACTIVOS NO FINANCIEROS'                                      , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '0000', null, null, null, null, 'DEUDORES COMERCIALES Y OTRAS CUENTAS POR COBRAR'                   , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '1001', null, null, null, null, 'CLIENTES NACIONALES'                                               , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '1002', null, null, null, null, 'CLIENTES EXTRANJEROS'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '1003', null, null, null, null, 'CHEQUES EN CARTERA'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '1004', null, null, null, null, 'TARJETA DE DEBITO'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '1005', null, null, null, null, 'TARJETA DE CREDITO'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '1006', null, null, null, null, 'CHEQUES PROTESTADOS'                                               , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '1007', null, null, null, null, 'DOCUMENTOS PROTESTADOS'                                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '2001', null, null, null, null, 'ESTIMACION DEUDORES INCOBRABLES'                                   , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '3001', null, null, null, null, 'FONDOS POR RENDIR'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '4001', null, null, null, null, 'PRESTAMOS AL PERSONAL'                                             , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '5001', null, null, null, null, 'ANTICIPO DE SUELDO'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '5002', null, null, null, null, 'ANTICIPO DE HONORARIOS'                                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '13', '5003', null, null, null, null, 'ANTICIPO A PROVEEDORES'                                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '14', '0000', null, null, null, null, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS'                       , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '14', '1001', null, null, null, null, 'CUENTAS POR COBRAR EMPRESA RELACIONADA NACIONAL'                   , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '14', '1002', null, null, null, null, 'CUENTAS POR COBRAR EMPRESA RELACIONADA EXTRANJERA'                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '15', '0000', null, null, null, null, 'INVENTARIOS'                                                       , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '15', '1001', null, null, null, null, 'EXISTENCIA EN TRANSITO'                                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '15', '1002', null, null, null, null, 'EXISTENCIAS EN PROCESO'                                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '15', '2001', null, null, null, null, 'EXISTENCIAS'                                                       , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '16', '0000', null, null, null, null, 'ACTIVOS BIOLOGICOS'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '17', '0000', null, null, null, null, 'ACTIVOS POR IMPUESTOS'                                             , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '17', '1001', null, null, null, null, 'PAGOS PROVISIONALES MENSUALES'                                     , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '17', '1002', null, null, null, null, 'IVA CREDITO FISCAL'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '17', '2001', null, null, null, null, 'OTROS IMPUESTOS POR RECUPERAR'                                     , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '19', '0000', null, null, null, null, 'ACTIVOS MANTENIDOS PARA LA VENTA'                                  , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '19', '1001', null, null, null, null, 'ACTIVOS DISPONIBLES MANTENIDOS PARA LA VENTA'                      , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '20', '0000', null, null, null, null, 'ACTIVOS MANTENIDOS PARA DISTRIBUIR A PROPIETARIOS'                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '10', '21', '0000', null, null, null, null, 'ACTIVOS MANTENIDOS PARA LA VENTA O A DISTRIBUIR A LOS PROPIETARIOS', 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '00', '0000', null, null, null, null, 'ACTIVOS NO CORRIENTES'                                             , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '10', '0000', null, null, null, null, 'OTROS ACTIVOS FINANCIEROS'                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '10', '1001', null, null, null, null, 'SEGUROS PAGADOS POR ANTICIPADO'                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '10', '1002', null, null, null, null, 'ARRIENDOS PAGADOS POR ANTICIPADO'                                  , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '10', '1003', null, null, null, null, 'OTROS GASTOS PAGADOS POR ANTICIPADO'                               , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '10', '1004', null, null, null, null, 'GARANTIAS'                                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '10', '2001', null, null, null, null, 'INTERESES DIFERIDOS'                                               , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '11', '0000', null, null, null, null, 'OTROS ACTIVOS NO FINANCIEROS'                                      , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '12', '0000', null, null, null, null, 'DERECHOS POR COBRAR'                                               , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '13', '0000', null, null, null, null, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS'                       , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '14', '0000', null, null, null, null, 'INVERSIONES POR METODO DE PARTICIPACION'                           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '15', '0000', null, null, null, null, 'ACTIVOS INTANGIBLES DISTINTO A LA PLUSVALIA'                       , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '16', '0000', null, null, null, null, 'PLUSVALIA'                                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '17', '0000', null, null, null, null, 'PROPIEDADES, PLANTAS Y EQUIPOS'                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '17', '1001', null, null, null, null, 'TERRENOS'                                                          , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '17', '2001', null, null, null, null, 'CONSTRUCCIONES E INTALACIONES'                                     , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '17', '3001', null, null, null, null, 'MUEBLES E UTILES'                                                  , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '17', '4001', null, null, null, null, 'VEHICULOS'                                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '17', '5001', null, null, null, null, 'EQUIPOS COMPUTACIONALES'                                           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '17', '6001', null, null, null, null, 'ACTIVOS EN LEASING'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '17', '7001', null, null, null, null, 'PROGRAMAS Y SOFTWARES'                                             , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '17', '8001', null, null, null, null, 'DEPRECIACIÓN ACUMULADA'                                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '18', '0000', null, null, null, null, 'ACTIVOS BIOLOGICOS'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '19', '0000', null, null, null, null, 'PROPIEDADES DE INVERSION'                                          , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '20', '0000', null, null, null, null, 'ACTIVOS POR IMPUESTO DIFERIDO'                                     , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '00', '00', '0000', null, null, null, null, 'PASIVOS'                                                           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '00', '0000', null, null, null, null, 'PASIVOS CORRIENTES'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '10', '0000', null, null, null, null, 'OTROS PASIVOS FINANCIEROS'                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '10', '1001', null, null, null, null, 'OBLIGACIONES CON BANCOS'                                           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '10', '1002', null, null, null, null, 'LÍNEAS DE CREDITO'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '10', '1003', null, null, null, null, 'OBLIGACIONES CON LEASING'                                          , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '11', '0000', null, null, null, null, 'CUENTAS COMERCIALES Y OTRAS CUENTAS POR PAGAR'                     , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '11', '1001', null, null, null, null, 'PROVEEDORES NACIONALES'                                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '11', '1002', null, null, null, null, 'PROVEEDORES EXTRANJEROS'                                           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '11', '1003', null, null, null, null, 'CHEQUES POR PAGAR'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '11', '1004', null, null, null, null, 'HONORARIOS POR PAGAR'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '11', '1005', null, null, null, null, 'ANTICIPOS DE CLIENTES'                                             , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '12', '0000', null, null, null, null, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS'                        , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '12', '1001', null, null, null, null, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA NACIONAL'                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '12', '1002', null, null, null, null, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA EXTRANJERA'                  , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '13', '0000', null, null, null, null, 'OTRAS PROVISIONES'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '13', '1001', null, null, null, null, 'PROVISIONES POR PAGAR'                                             , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '13', '2001', null, null, null, null, 'PROVISION DE VACACIONES'                                           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '13', '2002', null, null, null, null, 'PROVISIONES VARIAS'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '14', '0000', null, null, null, null, 'PASIVOS POR IMPUESTOS'                                             , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '14', '1001', null, null, null, null, 'IVA DEBITO FISCAL'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '14', '1002', null, null, null, null, 'IVA POR PAGAR'                                                     , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '14', '1003', null, null, null, null, 'RETENCION 1° CATEGORIA'                                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '14', '1004', null, null, null, null, 'RETENCION 2° CATEGORIA'                                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '14', '1005', null, null, null, null, 'PPM POR PAGAR'                                                     , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '14', '2001', null, null, null, null, 'PROVISION IMPUESTO A LA RENTA'                                     , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '15', '0000', null, null, null, null, 'PROVISIONES POR BENEFICIOS A EMPLEADOS'                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '16', '0000', null, null, null, null, 'OTROS PASIVOS NO FINANCIEROS'                                      , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '18', '0000', null, null, null, null, 'PASIVOS CLASIFICADOS COMO MANTENIDOS PARA LA VENTA'                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '20', '00', '0000', null, null, null, null, 'PASIVOS NO CORRIENTES'                                             , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '20', '10', '0000', null, null, null, null, 'OTROS PASIVOS FINANCIEROS'                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '20', '11', '0000', null, null, null, null, 'OTRAS CUENTAS POR PAGAR'                                           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '20', '12', '0000', null, null, null, null, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS'                        , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '20', '13', '0000', null, null, null, null, 'OTRAS PROVISIONES'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '20', '14', '0000', null, null, null, null, 'PASIVOS POR IMPUESTOS DIFERIDOS'                                   , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '20', '15', '0000', null, null, null, null, 'PROVISIONES POR BENEFICIOS A LOS EMPLEADOS'                        , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '20', '16', '0000', null, null, null, null, 'OTROS PASIVOS NO FINANCIEROS'                                      , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '30', '00', '0000', null, null, null, null, 'PATRIMONIO  '                                                      , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '30', '10', '0000', null, null, null, null, 'CAPITAL EMITIDO'                                                   , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '30', '10', '0001', null, null, null, null, 'CAPITAL'                                                           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '30', '11', '0000', null, null, null, null, 'GANANCIAS (PERDIDAS) ACUMULADAS'                                   , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '30', '11', '0001', null, null, null, null, 'RESULTADO ACUMULADO'                                               , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '30', '12', '0000', null, null, null, null, 'PRIMAS DE EMISION'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '30', '13', '0000', null, null, null, null, 'ACCIONES PROPIAS EN CARTERA'                                       , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '30', '14', '0000', null, null, null, null, 'OTRAS PARTICIPACIONES EN EL PATRIMONIO'                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '30', '15', '0000', null, null, null, null, 'OTRAS RESERVAS'                                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '30', '16', '0000', null, null, null, null, 'PATRIMONIO ATRIBUIBLE A PROPIETARIOS DE LA CONTROLADORA'           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '30', '17', '0000', null, null, null, null, 'PARTICIPACIONES NO CONTROLADORAS'                                  , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '3', '00', '00', '0000', null, null, null, null, 'RESULTADO GANANCIA'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '3', '10', '10', '0000', null, null, null, null, 'INGRESOS DE ACTIVIDADES ORDINARIAS'                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '3', '10', '10', '1001', null, null, null, null, 'VENTA DE GRUAS'                                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '3', '10', '10', '1002', null, null, null, null, 'VENTA DE ACCESORIAS DE GRUAS'                                      , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '3', '10', '10', '1003', null, null, null, null, 'VENTA DE PLATAFORMAS'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '3', '10', '10', '1004', null, null, null, null, 'VENTA DE REPUESTOS'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '3', '10', '10', '1005', null, null, null, null, 'VENTA DE SERVICIO TECNICO'                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '3', '10', '10', '1006', null, null, null, null, 'VENTA DE LEASING'                                                  , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '3', '10', '10', '2001', null, null, null, null, 'ARRIENDOS'                                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '3', '20', '10', '0000', null, null, null, null, 'OTROS INGRESOS'                                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '3', '20', '10', '1001', null, null, null, null, 'GARANTIAS'                                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '3', '20', '11', '0000', null, null, null, null, 'OTRAS GANANCIAS'                                                   , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '3', '20', '12', '0000', null, null, null, null, 'INGRESOS FINANCIEROS'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '00', '00', '0000', null, null, null, null, 'RESULTADO PERDIDA'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '10', '00', '0000', null, null, null, null, 'COSTO DE VENTA'                                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '10', '10', '1001', null, null, null, null, 'COSTO DE GRUAS'                                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '10', '10', '1002', null, null, null, null, 'COSTO DE ACCESORIAS DE GRUAS'                                      , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '10', '10', '1003', null, null, null, null, 'COSTO DE PLATAFORMAS'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '10', '10', '1004', null, null, null, null, 'COSTO DE REPUESTOS'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '10', '10', '1005', null, null, null, null, 'COSTO DE SERVICIO TECNICO'                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '10', '10', '1006', null, null, null, null, 'COSTO DE LEASING'                                                  , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '10', '10', '2001', null, null, null, null, 'COSTO DE ARRIENDO'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '10', '0000', null, null, null, null, 'OTROS COSTOS DE EXPLOTACION'                                       , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '0000', null, null, null, null, 'GASTOS DE ADMINISTRACION Y VENTA'                                  , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '1001', null, null, null, null, 'REMUNERACIONES'                                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '1002', null, null, null, null, 'COMISIONES POR VENTA'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '1003', null, null, null, null, 'FINIQUITOS'                                                        , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '2001', null, null, null, null, 'ASESORIA INFORMATICA'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '2002', null, null, null, null, 'ASESORIA COMEX'                                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '2003', null, null, null, null, 'ASESORIA DE MARKETING'                                             , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '2004', null, null, null, null, 'ASESORIA LEGAL'                                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '2005', null, null, null, null, 'ASESORIA CONTABLE'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '2006', null, null, null, null, 'ASESORIA TECNICA'                                                  , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '3001', null, null, null, null, 'GASTOS DE PUBLICIDAD'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '3002', null, null, null, null, 'GASTOS DE REPRESENTACION'                                          , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '3003', null, null, null, null, 'VIAJES Y ESTADIAS'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '3004', null, null, null, null, 'FERIAS Y STAND'                                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '4001', null, null, null, null, 'ARRIENDO DE OFICINAS'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '4002', null, null, null, null, 'COMBUSTIBLE'                                                       , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '4003', null, null, null, null, 'GASTOS DE OFICINA'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '4004', null, null, null, null, 'MANTENCION DE VEHICULOS'                                           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '4005', null, null, null, null, 'TELEFONOS'                                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '4006', null, null, null, null, 'AGUA'                                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '4007', null, null, null, null, 'ELECTRICIDAD'                                                      , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '4008', null, null, null, null, 'GASTOS DE IMPRENTA'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '5001', null, null, null, null, 'SERVICIO DE ASEO'                                                  , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '5002', null, null, null, null, 'SERVICIO DE VIGILANCIA'                                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '6001', null, null, null, null, 'SEGUROS DE CHEQUES'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '6002', null, null, null, null, 'SEGUROS'                                                           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '7001', null, null, null, null, 'COLACIÓN'                                                          , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '7002', null, null, null, null, 'CORRESPONDENCIA'                                                   , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '7003', null, null, null, null, 'ALARMA DE SEGURIDAD'                                               , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '7004', null, null, null, null, 'TAG'                                                               , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '7005', null, null, null, null, 'ROPA DE TRABAJO'                                                   , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '7006', null, null, null, null, 'GASTOS DE TV CABLE'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '7007', null, null, null, null, 'GASTOS DE DICOM'                                                   , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '7008', null, null, null, null, 'GASTOS DE DOMINIO'                                                 , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '7009', null, null, null, null, 'FLETES'                                                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '7010', null, null, null, null, 'GPS'                                                               , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '12', '0000', null, null, null, null, 'OTROS GASTOS'                                                      , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '13', '0000', null, null, null, null, 'COSTOS FINANCIEROS'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '13', '1001', null, null, null, null, 'GASTOS POR LEASING'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '13', '1002', null, null, null, null, 'GASTOS BANCARIOS'                                                  , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '13', '1003', null, null, null, null, 'GASTOS POR PROTESTOS'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '13', '2001', null, null, null, null, 'INTERESES BANCARIOS'                                               , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '14', '0000', null, null, null, null, 'PARTICIPACION EN RESULTADO POR INVERSIONES'                        , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '15', '0000', null, null, null, null, 'DIFERENCIA DE CAMBIO'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '15', '1001', null, null, null, null, 'DIFERENCIA DE CAMBIO'                                              , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '16', '0000', null, null, null, null, 'RESULTADO POR UNIDADES DE REAJUSTES'                               , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '16', '1001', null, null, null, null, 'REAJUSTES'                                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '17', '0000', null, null, null, null, 'GASTOS POR IMPUESTO A LA RENTA'                                    , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '17', '1001', null, null, null, null, 'IMPUESTO A LA RENTA'                                               , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '5', '00', '00', '0000', null, null, null, null, 'CUENTAS DE ORDEN Y TRASPASOS'                                      , 1, current_timestamp, null, null, null, null);

  return null;
end;
$$;


ALTER FUNCTION public.f_crear_datos_holding() OWNER TO admin;

--
-- Name: f_dv_rut_cl(character varying); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_dv_rut_cl(character varying) RETURNS character
    LANGUAGE plpgsql
    AS $_$
declare
  suma    int := 0;
  factor  int := 2;
  rut_aux int := $1;
  dig     int;
  dv      int;
begin
  while(rut_aux > 0) loop
    dig := rut_aux % 10;
    if (factor = 8) then
      factor := 2;
    end if;
    suma    := suma + (dig * factor);
    rut_aux := rut_aux / 10;
    factor  := factor + 1;
  end loop;
  dv := 11 - (suma % 11);
  if    (dv = 10) then
    return 'K';
  elsif (dv = 11) then
    return 0;
  else
    return dv;
  end if;
end;
$_$;


ALTER FUNCTION public.f_dv_rut_cl(character varying) OWNER TO admin;

--
-- Name: f_mandar_aviso_por_dole(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_mandar_aviso_por_dole() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
  C_doles_por_avisar cursor for
    select dole.emailaviso
          ,dole.nombreoriginal
          ,to_char(dole.fechaaviso,'dd-mm-yyyy') 
          ,tidl.descripcion
          ,dole.id
    from   documentos_legales       dole
          ,tipos_documentos_legales tidl
    where  dole.idtidl     = tidl.id
    and    dole.fechaaviso is not null
    and    dole.avisodado  = 'N'
    and    dole.fechaaviso <= current_timestamp
    ;
  Vemailaviso              varchar(100);
  Vnombreoriginal          varchar(100);
  Vfechaaviso              varchar(100);
  Vtidl_descripcion        varchar(100);
  Vlinea                   varchar(1000);
  Viddole                  numeric;
begin
   open C_doles_por_avisar;
   loop
     fetch C_doles_por_avisar into Vemailaviso
                                  ,Vnombreoriginal
                                  ,Vfechaaviso
                                  ,Vtidl_descripcion
                                  ,Viddole
                                  ;
     exit when not found;
     Vlinea :=    chr(10)
               || 'YYYYY_10' || 'Aviso documento legal'
               || chr(10)
               || 'YYYYY_20' || Vemailaviso
               || chr(10)
               || 'YYYYY_30' || 'El documento ' || Vnombreoriginal || ' de tipo ' || Vtidl_descripcion || ', tenia fecha de aviso ' || Vfechaaviso
               ;
     raise notice 'XXXXX'
     using hint = Vlinea;
     update documentos_legales
     set    avisodado  = 'S'
     where  id         = Viddole
     ;
  end loop;
  close C_doles_por_avisar;
  return('S');
end;
$$;


ALTER FUNCTION public.f_mandar_aviso_por_dole() OWNER TO admin;

--
-- Name: f_valida_usuario(character varying, character varying); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_valida_usuario(pusername character varying, ppassword character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
  aux  int;
  aux1 int;
  aux2 int;
  aux3 int;
begin
  -- Veo si existe el username
  select count(*)
  into   aux
  from   usuarios
  where  upper(username) = upper(Pusername)
  ;
  if aux = 0 then
    return('N:Usuario no existe');
  end if;
  --
  -- Veo si existe la combinacion username/password
  select count(*)
  into   aux
  from   usuarios
  where  upper(username) = upper(Pusername)
  and    password        = Ppassword
  ;
  if aux = 0 then
    return('N:Password invalida');
  end if;
  --
  -- Veo si el usuario esta activo
  select count(*)
  into   aux
  from   usuarios
  where  upper(username) = upper(Pusername)
  and    idesre          = 1
  ;
  if aux = 0 then
    return('N:Usuario no esta activo');
  end if;
  --
  -- Veo si, entre las empresas o holding en las que tiene perfil, alguno esta activo
  select count(*)
  into   aux1
  from   usuarios          usua
        ,usuarios_perfiles uspe
        ,empresas          empr
  where  usua.id              = uspe.idusua
  and    uspe.idempr          = empr.id
  and    upper(usua.username) = upper(Pusername)
  and    empr.idesre          = 1
  and    uspe.idesre          = 1
  ;
  select count(*)
  into   aux2
  from   usuarios             usua
        ,usuarios_perfiles    uspe
        ,grupos_empresariales empr
  where  usua.id              = uspe.idusua
  and    uspe.idgrem          = grem.id
  and    upper(usua.username) = upper(Pusername)
  and    grem.idesre          = 1
  and    uspe.idesre          = 1
  ;
  select count(*)
  into   aux3
  from   usuarios             usua
        ,usuarios_perfiles    uspe
  where  usua.id              = uspe.idusua
  and    upper(usua.username) = upper(Pusername)
  and    uspe.idesre          = 1
  and    uspe.idperf          = 1                   -- usuario es administrador del sistema (ROSILVA, SEAGUIRRE, JJMONSALVE, etc.)
  ;
  if aux1 = 0 and aux2 = 0 and aux3 = 0 then
    return('N:Usuario no está asociado a ninguna empresa o holding activo');
  end if;
  --
  -- Si ha pasado todos los filtros anteriores, entonces quiere decir que es un usuario valido con clave valida
  -- en alguna empresa o holding activo
  return('S');
end;
$$;


ALTER FUNCTION public.f_valida_usuario(pusername character varying, ppassword character varying) OWNER TO admin;

--
-- Name: f_validar_dv_pers(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_validar_dv_pers() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  Vidpais         numeric;
  Vdv_correcto    varchar(100);
begin
  select idpais
  into   Vidpais
  from   grupos_empresariales
  where  id = new.idgrem
  ;
  if Vidpais = 1 then
    select f_dv_rut_cl(new.identificador1)
    into   Vdv_correcto
    ;
    if Vdv_correcto != new.identificador2 then
      raise exception 'DV incorrecto'
      using hint = 'Reingrese DV';
    end if;
  end if;
  return null;
end;
$$;


ALTER FUNCTION public.f_validar_dv_pers() OWNER TO admin;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: centros_costos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE centros_costos (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    nombre character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.centros_costos OWNER TO admin;

--
-- Name: ceco; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW ceco AS
    SELECT centros_costos.id, centros_costos.idempr, centros_costos.nombre, centros_costos.idusuacrearegistro, centros_costos.fechacrearegistro, centros_costos.idusuamodifregistro, centros_costos.fechamodifregistro, centros_costos.idusuaborraregistro, centros_costos.fechaborraregistro FROM centros_costos;


ALTER TABLE public.ceco OWNER TO admin;

--
-- Name: ceco_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE ceco_seq
    START WITH 46
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.ceco_seq OWNER TO admin;

--
-- Name: ceco_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('ceco_seq', 46, false);


--
-- Name: cotizaciones_servs_hono; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE cotizaciones_servs_hono (
    id numeric(20,0) NOT NULL,
    idsosh numeric(20,0) NOT NULL,
    idpers numeric(20,0) NOT NULL,
    monto numeric(20,0) NOT NULL,
    descservofrecido character varying(1000) NOT NULL,
    informeevaluaccotiz character varying(1000),
    idecsh numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone,
    CONSTRAINT cosh_chk_01 CHECK ((((informeevaluaccotiz IS NULL) AND (idecsh = (1)::numeric)) OR ((informeevaluaccotiz IS NOT NULL) AND (idecsh = ANY (ARRAY[(2)::numeric, (3)::numeric])))))
);


ALTER TABLE public.cotizaciones_servs_hono OWNER TO admin;

--
-- Name: cosh; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW cosh AS
    SELECT cotizaciones_servs_hono.id, cotizaciones_servs_hono.idsosh, cotizaciones_servs_hono.idpers, cotizaciones_servs_hono.monto, cotizaciones_servs_hono.descservofrecido, cotizaciones_servs_hono.informeevaluaccotiz, cotizaciones_servs_hono.idecsh, cotizaciones_servs_hono.idusuacrearegistro, cotizaciones_servs_hono.fechacrearegistro, cotizaciones_servs_hono.idusuamodifregistro, cotizaciones_servs_hono.fechamodifregistro, cotizaciones_servs_hono.idusuaborraregistro, cotizaciones_servs_hono.fechaborraregistro FROM cotizaciones_servs_hono;


ALTER TABLE public.cosh OWNER TO admin;

--
-- Name: cosh_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE cosh_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.cosh_seq OWNER TO admin;

--
-- Name: cosh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('cosh_seq', 1, false);


--
-- Name: doctos_cotizacs_servs_hono; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE doctos_cotizacs_servs_hono (
    id numeric(20,0) NOT NULL,
    idcosh numeric(20,0) NOT NULL,
    nombrearchivoorig character varying(100) NOT NULL,
    nombrearchivomodif character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.doctos_cotizacs_servs_hono OWNER TO admin;

--
-- Name: dcsh; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW dcsh AS
    SELECT doctos_cotizacs_servs_hono.id, doctos_cotizacs_servs_hono.idcosh, doctos_cotizacs_servs_hono.nombrearchivoorig, doctos_cotizacs_servs_hono.nombrearchivomodif, doctos_cotizacs_servs_hono.idusuacrearegistro, doctos_cotizacs_servs_hono.fechacrearegistro, doctos_cotizacs_servs_hono.idusuamodifregistro, doctos_cotizacs_servs_hono.fechamodifregistro, doctos_cotizacs_servs_hono.idusuaborraregistro, doctos_cotizacs_servs_hono.fechaborraregistro FROM doctos_cotizacs_servs_hono;


ALTER TABLE public.dcsh OWNER TO admin;

--
-- Name: dcsh_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE dcsh_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.dcsh_seq OWNER TO admin;

--
-- Name: dcsh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('dcsh_seq', 1, false);


--
-- Name: doctos_ordenes_servs_hono; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE doctos_ordenes_servs_hono (
    id numeric(20,0) NOT NULL,
    idorsh numeric(20,0) NOT NULL,
    nombrearchivoorig character varying(100) NOT NULL,
    nombrearchivomodif character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.doctos_ordenes_servs_hono OWNER TO admin;

--
-- Name: documentos_legales; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE documentos_legales (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    idtidl numeric(20,0) NOT NULL,
    nombreoriginal character varying(100) NOT NULL,
    nombresistema character varying(100) NOT NULL,
    idesdl numeric(20,0) NOT NULL,
    fecha date NOT NULL,
    notaria character varying(100),
    foja character varying(100),
    responsable character varying(100) NOT NULL,
    comentario character varying(1000) NOT NULL,
    fechaaviso date,
    emailaviso character varying(100),
    avisodado character varying(1),
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone,
    xfld character varying(250),
    CONSTRAINT dole_chk_01 CHECK (((avisodado)::text = ANY ((ARRAY['S'::character varying, 'N'::character varying])::text[]))),
    CONSTRAINT dole_chk_02 CHECK (((((fechaaviso IS NULL) AND (emailaviso IS NULL)) AND (avisodado IS NULL)) OR (((fechaaviso IS NOT NULL) AND (emailaviso IS NOT NULL)) AND (avisodado IS NOT NULL))))
);


ALTER TABLE public.documentos_legales OWNER TO admin;

--
-- Name: dole; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW dole AS
    SELECT documentos_legales.id, documentos_legales.idempr, documentos_legales.idtidl, documentos_legales.nombreoriginal, documentos_legales.nombresistema, documentos_legales.idesdl, documentos_legales.fecha, documentos_legales.notaria, documentos_legales.foja, documentos_legales.responsable, documentos_legales.comentario, documentos_legales.fechaaviso, documentos_legales.emailaviso, documentos_legales.avisodado, documentos_legales.idusuacrearegistro, documentos_legales.fechacrearegistro, documentos_legales.idusuamodifregistro, documentos_legales.fechamodifregistro, documentos_legales.idusuaborraregistro, documentos_legales.fechaborraregistro, documentos_legales.xfld FROM documentos_legales;


ALTER TABLE public.dole OWNER TO admin;

--
-- Name: dole_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE dole_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.dole_seq OWNER TO admin;

--
-- Name: dole_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('dole_seq', 1, false);


--
-- Name: dosh; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW dosh AS
    SELECT doctos_ordenes_servs_hono.id, doctos_ordenes_servs_hono.idorsh, doctos_ordenes_servs_hono.nombrearchivoorig, doctos_ordenes_servs_hono.nombrearchivomodif, doctos_ordenes_servs_hono.idusuacrearegistro, doctos_ordenes_servs_hono.fechacrearegistro, doctos_ordenes_servs_hono.idusuamodifregistro, doctos_ordenes_servs_hono.fechamodifregistro, doctos_ordenes_servs_hono.idusuaborraregistro, doctos_ordenes_servs_hono.fechaborraregistro FROM doctos_ordenes_servs_hono;


ALTER TABLE public.dosh OWNER TO admin;

--
-- Name: dosh_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE dosh_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.dosh_seq OWNER TO admin;

--
-- Name: dosh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('dosh_seq', 1, false);


--
-- Name: estados_cotizacs_servs_hono; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estados_cotizacs_servs_hono (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_cotizacs_servs_hono OWNER TO admin;

--
-- Name: ecsh; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW ecsh AS
    SELECT estados_cotizacs_servs_hono.id, estados_cotizacs_servs_hono.descripcion FROM estados_cotizacs_servs_hono;


ALTER TABLE public.ecsh OWNER TO admin;

--
-- Name: ecsh_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE ecsh_seq
    START WITH 4
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.ecsh_seq OWNER TO admin;

--
-- Name: ecsh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('ecsh_seq', 4, false);


--
-- Name: empresas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE empresas (
    id numeric(20,0) NOT NULL,
    idgrem numeric(20,0) NOT NULL,
    idpais numeric(20,0) NOT NULL,
    idrubr numeric(20,0) NOT NULL,
    identificador1 character varying(50) NOT NULL,
    identificador2 character varying(50) NOT NULL,
    razonsocial character varying(100) NOT NULL,
    nombrefantasia character varying(100) NOT NULL,
    icono character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone,
    xfld character varying(250)
);


ALTER TABLE public.empresas OWNER TO admin;

--
-- Name: empr; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW empr AS
    SELECT empresas.id, empresas.idgrem, empresas.idpais, empresas.idrubr, empresas.identificador1, empresas.identificador2, empresas.razonsocial, empresas.nombrefantasia, empresas.icono, empresas.idusuacrearegistro, empresas.fechacrearegistro, empresas.idusuamodifregistro, empresas.fechamodifregistro, empresas.idusuaborraregistro, empresas.fechaborraregistro, empresas.xfld FROM empresas;


ALTER TABLE public.empr OWNER TO admin;

--
-- Name: empr_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE empr_seq
    START WITH 12
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.empr_seq OWNER TO admin;

--
-- Name: empr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('empr_seq', 12, false);


--
-- Name: estados_ordenes_servs_hono; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estados_ordenes_servs_hono (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_ordenes_servs_hono OWNER TO admin;

--
-- Name: eosh; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW eosh AS
    SELECT estados_ordenes_servs_hono.id, estados_ordenes_servs_hono.descripcion FROM estados_ordenes_servs_hono;


ALTER TABLE public.eosh OWNER TO admin;

--
-- Name: eosh_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE eosh_seq
    START WITH 5
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.eosh_seq OWNER TO admin;

--
-- Name: eosh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('eosh_seq', 5, false);


--
-- Name: estados_pagos_ords_servs_hono; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estados_pagos_ords_servs_hono (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_pagos_ords_servs_hono OWNER TO admin;

--
-- Name: epos; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW epos AS
    SELECT estados_pagos_ords_servs_hono.id, estados_pagos_ords_servs_hono.descripcion FROM estados_pagos_ords_servs_hono;


ALTER TABLE public.epos OWNER TO admin;

--
-- Name: epos_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE epos_seq
    START WITH 3
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.epos_seq OWNER TO admin;

--
-- Name: epos_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('epos_seq', 3, false);


--
-- Name: estados_civiles; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estados_civiles (
    id numeric(20,0) NOT NULL,
    alias character varying(1) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_civiles OWNER TO admin;

--
-- Name: esci; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW esci AS
    SELECT estados_civiles.id, estados_civiles.alias, estados_civiles.descripcion FROM estados_civiles;


ALTER TABLE public.esci OWNER TO admin;

--
-- Name: esci_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE esci_seq
    START WITH 3
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.esci_seq OWNER TO admin;

--
-- Name: esci_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esci_seq', 3, false);


--
-- Name: estados_documentos_legales; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estados_documentos_legales (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_documentos_legales OWNER TO admin;

--
-- Name: esdl; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW esdl AS
    SELECT estados_documentos_legales.id, estados_documentos_legales.descripcion FROM estados_documentos_legales;


ALTER TABLE public.esdl OWNER TO admin;

--
-- Name: esdl_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE esdl_seq
    START WITH 4
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.esdl_seq OWNER TO admin;

--
-- Name: esdl_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esdl_seq', 4, false);


--
-- Name: estados_grem; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estados_grem (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_grem OWNER TO admin;

--
-- Name: esge; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW esge AS
    SELECT estados_grem.id, estados_grem.descripcion FROM estados_grem;


ALTER TABLE public.esge OWNER TO admin;

--
-- Name: esge_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE esge_seq
    START WITH 5
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.esge_seq OWNER TO admin;

--
-- Name: esge_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esge_seq', 5, false);


--
-- Name: estados_registros; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estados_registros (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_registros OWNER TO admin;

--
-- Name: esre; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW esre AS
    SELECT estados_registros.id, estados_registros.descripcion FROM estados_registros;


ALTER TABLE public.esre OWNER TO admin;

--
-- Name: esre_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE esre_seq
    START WITH 4
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.esre_seq OWNER TO admin;

--
-- Name: esre_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esre_seq', 4, false);


--
-- Name: estados_solics_servs_hono; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estados_solics_servs_hono (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_solics_servs_hono OWNER TO admin;

--
-- Name: essh; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW essh AS
    SELECT estados_solics_servs_hono.id, estados_solics_servs_hono.descripcion FROM estados_solics_servs_hono;


ALTER TABLE public.essh OWNER TO admin;

--
-- Name: essh_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE essh_seq
    START WITH 6
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.essh_seq OWNER TO admin;

--
-- Name: essh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('essh_seq', 6, false);


--
-- Name: gerencias; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE gerencias (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    nombre character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.gerencias OWNER TO admin;

--
-- Name: gere; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW gere AS
    SELECT gerencias.id, gerencias.idempr, gerencias.nombre, gerencias.idusuacrearegistro, gerencias.fechacrearegistro, gerencias.idusuamodifregistro, gerencias.fechamodifregistro, gerencias.idusuaborraregistro, gerencias.fechaborraregistro FROM gerencias;


ALTER TABLE public.gere OWNER TO admin;

--
-- Name: gere_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE gere_seq
    START WITH 46
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.gere_seq OWNER TO admin;

--
-- Name: gere_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('gere_seq', 46, false);


--
-- Name: grupos_empresariales; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE grupos_empresariales (
    id numeric(20,0) NOT NULL,
    nombre character varying(100) NOT NULL,
    alias character varying(10) NOT NULL,
    icono character varying(100) NOT NULL,
    idpais numeric(20,0) NOT NULL,
    idesge numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.grupos_empresariales OWNER TO admin;

--
-- Name: grem; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW grem AS
    SELECT grupos_empresariales.id, grupos_empresariales.nombre, grupos_empresariales.alias, grupos_empresariales.icono, grupos_empresariales.idpais, grupos_empresariales.idesge, grupos_empresariales.idusuacrearegistro, grupos_empresariales.fechacrearegistro, grupos_empresariales.idusuamodifregistro, grupos_empresariales.fechamodifregistro, grupos_empresariales.idusuaborraregistro, grupos_empresariales.fechaborraregistro FROM grupos_empresariales;


ALTER TABLE public.grem OWNER TO admin;

--
-- Name: grem_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE grem_seq
    START WITH 5
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.grem_seq OWNER TO admin;

--
-- Name: grem_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('grem_seq', 5, false);


--
-- Name: lineas_negocios; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE lineas_negocios (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    nombre character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.lineas_negocios OWNER TO admin;

--
-- Name: line; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW line AS
    SELECT lineas_negocios.id, lineas_negocios.idempr, lineas_negocios.nombre, lineas_negocios.idusuacrearegistro, lineas_negocios.fechacrearegistro, lineas_negocios.idusuamodifregistro, lineas_negocios.fechamodifregistro, lineas_negocios.idusuaborraregistro, lineas_negocios.fechaborraregistro FROM lineas_negocios;


ALTER TABLE public.line OWNER TO admin;

--
-- Name: line_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE line_seq
    START WITH 64
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.line_seq OWNER TO admin;

--
-- Name: line_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('line_seq', 64, false);


--
-- Name: monedas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE monedas (
    id numeric(20,0) NOT NULL,
    nombre character varying(100) NOT NULL,
    nombrecorto character varying(10) NOT NULL
);


ALTER TABLE public.monedas OWNER TO admin;

--
-- Name: mone; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW mone AS
    SELECT monedas.id, monedas.nombre, monedas.nombrecorto FROM monedas;


ALTER TABLE public.mone OWNER TO admin;

--
-- Name: mone_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE mone_seq
    START WITH 11
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.mone_seq OWNER TO admin;

--
-- Name: mone_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('mone_seq', 11, false);


--
-- Name: ordenes_servicios_hono; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE ordenes_servicios_hono (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    idsosh numeric(20,0),
    correlativo numeric(20,0) NOT NULL,
    codigocompra character varying(100) NOT NULL,
    idpers numeric(20,0) NOT NULL,
    descripcionordenserv character varying(1000) NOT NULL,
    resultadofinal character varying(1000),
    ideosh numeric(20,0) NOT NULL,
    idgere numeric(20,0),
    idproy numeric(20,0),
    idline numeric(20,0),
    idceco numeric(20,0),
    idtare numeric(20,0),
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone,
    CONSTRAINT orsh_chk_01 CHECK ((((resultadofinal IS NULL) AND (ideosh = ANY (ARRAY[(1)::numeric, (2)::numeric]))) OR ((resultadofinal IS NOT NULL) AND (ideosh = ANY (ARRAY[(3)::numeric, (4)::numeric])))))
);


ALTER TABLE public.ordenes_servicios_hono OWNER TO admin;

--
-- Name: orsh; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW orsh AS
    SELECT ordenes_servicios_hono.id, ordenes_servicios_hono.idempr, ordenes_servicios_hono.idsosh, ordenes_servicios_hono.correlativo, ordenes_servicios_hono.codigocompra, ordenes_servicios_hono.idpers, ordenes_servicios_hono.descripcionordenserv, ordenes_servicios_hono.resultadofinal, ordenes_servicios_hono.ideosh, ordenes_servicios_hono.idgere, ordenes_servicios_hono.idproy, ordenes_servicios_hono.idline, ordenes_servicios_hono.idceco, ordenes_servicios_hono.idtare, ordenes_servicios_hono.idusuacrearegistro, ordenes_servicios_hono.fechacrearegistro, ordenes_servicios_hono.idusuamodifregistro, ordenes_servicios_hono.fechamodifregistro, ordenes_servicios_hono.idusuaborraregistro, ordenes_servicios_hono.fechaborraregistro FROM ordenes_servicios_hono;


ALTER TABLE public.orsh OWNER TO admin;

--
-- Name: orsh_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE orsh_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.orsh_seq OWNER TO admin;

--
-- Name: orsh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('orsh_seq', 1, false);


--
-- Name: pagos_ordenes_servs_hono; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE pagos_ordenes_servs_hono (
    id numeric(20,0) NOT NULL,
    idorsh numeric(20,0) NOT NULL,
    fechapago date NOT NULL,
    monto numeric(20,0) NOT NULL,
    idtifp numeric(20,0) NOT NULL,
    idepos numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.pagos_ordenes_servs_hono OWNER TO admin;

--
-- Name: paises; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE paises (
    id numeric(20,0) NOT NULL,
    nombre character varying(100) NOT NULL,
    idmone numeric(20,0) NOT NULL,
    nacionalidad character varying(100) NOT NULL
);


ALTER TABLE public.paises OWNER TO admin;

--
-- Name: pais; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW pais AS
    SELECT paises.id, paises.nombre, paises.idmone, paises.nacionalidad FROM paises;


ALTER TABLE public.pais OWNER TO admin;

--
-- Name: pais_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE pais_seq
    START WITH 11
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pais_seq OWNER TO admin;

--
-- Name: pais_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('pais_seq', 11, false);


--
-- Name: parametros; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE parametros (
    id numeric(20,0) NOT NULL,
    idgrem numeric(20,0) NOT NULL,
    nombrecorto character varying(50) NOT NULL,
    nombrelargo character varying(500) NOT NULL,
    descripcion character varying(1000) NOT NULL,
    valor character varying(500) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.parametros OWNER TO admin;

--
-- Name: para; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW para AS
    SELECT parametros.id, parametros.idgrem, parametros.nombrecorto, parametros.nombrelargo, parametros.descripcion, parametros.valor, parametros.idusuacrearegistro, parametros.fechacrearegistro, parametros.idusuamodifregistro, parametros.fechamodifregistro, parametros.idusuaborraregistro, parametros.fechaborraregistro FROM parametros;


ALTER TABLE public.para OWNER TO admin;

--
-- Name: para_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE para_seq
    START WITH 7
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.para_seq OWNER TO admin;

--
-- Name: para_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('para_seq', 7, false);


--
-- Name: perfiles_programas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE perfiles_programas (
    id numeric(20,0) NOT NULL,
    idperf numeric(20,0) NOT NULL,
    idprog numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.perfiles_programas OWNER TO admin;

--
-- Name: pepr; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW pepr AS
    SELECT perfiles_programas.id, perfiles_programas.idperf, perfiles_programas.idprog, perfiles_programas.idusuacrearegistro, perfiles_programas.fechacrearegistro, perfiles_programas.idusuamodifregistro, perfiles_programas.fechamodifregistro, perfiles_programas.idusuaborraregistro, perfiles_programas.fechaborraregistro FROM perfiles_programas;


ALTER TABLE public.pepr OWNER TO admin;

--
-- Name: pepr_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE pepr_seq
    START WITH 65
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pepr_seq OWNER TO admin;

--
-- Name: pepr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('pepr_seq', 65, false);


--
-- Name: perfiles; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE perfiles (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.perfiles OWNER TO admin;

--
-- Name: perf; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW perf AS
    SELECT perfiles.id, perfiles.descripcion FROM perfiles;


ALTER TABLE public.perf OWNER TO admin;

--
-- Name: perf_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE perf_seq
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.perf_seq OWNER TO admin;

--
-- Name: perf_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('perf_seq', 20, false);


--
-- Name: personas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE personas (
    id numeric(20,0) NOT NULL,
    idgrem numeric(20,0) NOT NULL,
    identificador1 character varying(50) NOT NULL,
    identificador2 character varying(50) NOT NULL,
    primernombre character varying(100) NOT NULL,
    segundonombre character varying(100),
    apellidopaterno character varying(100) NOT NULL,
    apellidomaterno character varying(100) NOT NULL,
    email character varying(100),
    fechanac date,
    idesci numeric(20,0),
    idsexo numeric(20,0),
    idpais numeric(20,0),
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.personas OWNER TO admin;

--
-- Name: pers; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW pers AS
    SELECT personas.id, personas.idgrem, personas.identificador1, personas.identificador2, personas.primernombre, personas.segundonombre, personas.apellidopaterno, personas.apellidomaterno, personas.email, personas.fechanac, personas.idesci, personas.idsexo, personas.idpais, personas.idusuacrearegistro, personas.fechacrearegistro, personas.idusuamodifregistro, personas.fechamodifregistro, personas.idusuaborraregistro, personas.fechaborraregistro FROM personas;


ALTER TABLE public.pers OWNER TO admin;

--
-- Name: pers_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE pers_seq
    START WITH 11
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pers_seq OWNER TO admin;

--
-- Name: pers_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('pers_seq', 11, false);


--
-- Name: planes_cuentas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE planes_cuentas (
    id numeric(20,0) NOT NULL,
    idgrem numeric(20,0) NOT NULL,
    segmento1 character varying(100) NOT NULL,
    segmento2 character varying(100),
    segmento3 character varying(100),
    segmento4 character varying(100),
    segmento5 character varying(100),
    segmento6 character varying(100),
    segmento7 character varying(100),
    segmento8 character varying(100),
    descripcion character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.planes_cuentas OWNER TO admin;

--
-- Name: plcu; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW plcu AS
    SELECT planes_cuentas.id, planes_cuentas.idgrem, planes_cuentas.segmento1, planes_cuentas.segmento2, planes_cuentas.segmento3, planes_cuentas.segmento4, planes_cuentas.segmento5, planes_cuentas.segmento6, planes_cuentas.segmento7, planes_cuentas.segmento8, planes_cuentas.descripcion, planes_cuentas.idusuacrearegistro, planes_cuentas.fechacrearegistro, planes_cuentas.idusuamodifregistro, planes_cuentas.fechamodifregistro, planes_cuentas.idusuaborraregistro, planes_cuentas.fechaborraregistro FROM planes_cuentas;


ALTER TABLE public.plcu OWNER TO admin;

--
-- Name: plcu_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE plcu_seq
    START WITH 595
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.plcu_seq OWNER TO admin;

--
-- Name: plcu_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('plcu_seq', 595, false);


--
-- Name: posh; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW posh AS
    SELECT pagos_ordenes_servs_hono.id, pagos_ordenes_servs_hono.idorsh, pagos_ordenes_servs_hono.fechapago, pagos_ordenes_servs_hono.monto, pagos_ordenes_servs_hono.idtifp, pagos_ordenes_servs_hono.idepos, pagos_ordenes_servs_hono.idusuacrearegistro, pagos_ordenes_servs_hono.fechacrearegistro, pagos_ordenes_servs_hono.idusuamodifregistro, pagos_ordenes_servs_hono.fechamodifregistro, pagos_ordenes_servs_hono.idusuaborraregistro, pagos_ordenes_servs_hono.fechaborraregistro FROM pagos_ordenes_servs_hono;


ALTER TABLE public.posh OWNER TO admin;

--
-- Name: posh_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE posh_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.posh_seq OWNER TO admin;

--
-- Name: posh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('posh_seq', 1, false);


--
-- Name: programas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE programas (
    id numeric(20,0) NOT NULL,
    idprogpadre numeric(20,0),
    titulo character varying(100) NOT NULL,
    link character varying(100),
    etiqueta character varying(100) NOT NULL,
    peso numeric(20,0) NOT NULL
);


ALTER TABLE public.programas OWNER TO admin;

--
-- Name: prog; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW prog AS
    SELECT programas.id, programas.idprogpadre, programas.titulo, programas.link, programas.etiqueta, programas.peso FROM programas;


ALTER TABLE public.prog OWNER TO admin;

--
-- Name: prog_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE prog_seq
    START WITH 52
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.prog_seq OWNER TO admin;

--
-- Name: prog_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('prog_seq', 52, false);


--
-- Name: proyectos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE proyectos (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    nombre character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.proyectos OWNER TO admin;

--
-- Name: proy; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW proy AS
    SELECT proyectos.id, proyectos.idempr, proyectos.nombre, proyectos.idusuacrearegistro, proyectos.fechacrearegistro, proyectos.idusuamodifregistro, proyectos.fechamodifregistro, proyectos.idusuaborraregistro, proyectos.fechaborraregistro FROM proyectos;


ALTER TABLE public.proy OWNER TO admin;

--
-- Name: proy_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE proy_seq
    START WITH 55
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.proy_seq OWNER TO admin;

--
-- Name: proy_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('proy_seq', 55, false);


--
-- Name: rubros; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE rubros (
    id numeric(20,0) NOT NULL,
    idgrem numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.rubros OWNER TO admin;

--
-- Name: rubr; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW rubr AS
    SELECT rubros.id, rubros.idgrem, rubros.descripcion FROM rubros;


ALTER TABLE public.rubr OWNER TO admin;

--
-- Name: rubr_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE rubr_seq
    START WITH 27
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.rubr_seq OWNER TO admin;

--
-- Name: rubr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('rubr_seq', 27, false);


--
-- Name: sexos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE sexos (
    id numeric(20,0) NOT NULL,
    alias character varying(1) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.sexos OWNER TO admin;

--
-- Name: sexo; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW sexo AS
    SELECT sexos.id, sexos.alias, sexos.descripcion FROM sexos;


ALTER TABLE public.sexo OWNER TO admin;

--
-- Name: sexo_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE sexo_seq
    START WITH 3
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sexo_seq OWNER TO admin;

--
-- Name: sexo_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('sexo_seq', 3, false);


--
-- Name: solicitudes_servs_hono; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE solicitudes_servs_hono (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    correlativo numeric(20,0) NOT NULL,
    idpers numeric(20,0) NOT NULL,
    descripcionsolicserv character varying(1000) NOT NULL,
    idgere numeric(20,0),
    idproy numeric(20,0),
    idline numeric(20,0),
    idceco numeric(20,0),
    idtare numeric(20,0),
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.solicitudes_servs_hono OWNER TO admin;

--
-- Name: sosh; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW sosh AS
    SELECT solicitudes_servs_hono.id, solicitudes_servs_hono.idempr, solicitudes_servs_hono.correlativo, solicitudes_servs_hono.idpers, solicitudes_servs_hono.descripcionsolicserv, solicitudes_servs_hono.idgere, solicitudes_servs_hono.idproy, solicitudes_servs_hono.idline, solicitudes_servs_hono.idceco, solicitudes_servs_hono.idtare, solicitudes_servs_hono.idusuacrearegistro, solicitudes_servs_hono.fechacrearegistro, solicitudes_servs_hono.idusuamodifregistro, solicitudes_servs_hono.fechamodifregistro, solicitudes_servs_hono.idusuaborraregistro, solicitudes_servs_hono.fechaborraregistro FROM solicitudes_servs_hono;


ALTER TABLE public.sosh OWNER TO admin;

--
-- Name: sosh_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE sosh_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sosh_seq OWNER TO admin;

--
-- Name: sosh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('sosh_seq', 1, false);


--
-- Name: tareas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE tareas (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    nombre character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.tareas OWNER TO admin;

--
-- Name: tare; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW tare AS
    SELECT tareas.id, tareas.idempr, tareas.nombre, tareas.idusuacrearegistro, tareas.fechacrearegistro, tareas.idusuamodifregistro, tareas.fechamodifregistro, tareas.idusuaborraregistro, tareas.fechaborraregistro FROM tareas;


ALTER TABLE public.tare OWNER TO admin;

--
-- Name: tare_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE tare_seq
    START WITH 37
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tare_seq OWNER TO admin;

--
-- Name: tare_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tare_seq', 37, false);


--
-- Name: tipos_documentos_legales; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE tipos_documentos_legales (
    id numeric(20,0) NOT NULL,
    idgrem numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.tipos_documentos_legales OWNER TO admin;

--
-- Name: tidl; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW tidl AS
    SELECT tipos_documentos_legales.id, tipos_documentos_legales.idgrem, tipos_documentos_legales.descripcion, tipos_documentos_legales.idusuacrearegistro, tipos_documentos_legales.fechacrearegistro, tipos_documentos_legales.idusuamodifregistro, tipos_documentos_legales.fechamodifregistro, tipos_documentos_legales.idusuaborraregistro, tipos_documentos_legales.fechaborraregistro FROM tipos_documentos_legales;


ALTER TABLE public.tidl OWNER TO admin;

--
-- Name: tidl_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE tidl_seq
    START WITH 13
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tidl_seq OWNER TO admin;

--
-- Name: tidl_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tidl_seq', 13, false);


--
-- Name: tipos_formas_pagos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE tipos_formas_pagos (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.tipos_formas_pagos OWNER TO admin;

--
-- Name: tifp; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW tifp AS
    SELECT tipos_formas_pagos.id, tipos_formas_pagos.descripcion FROM tipos_formas_pagos;


ALTER TABLE public.tifp OWNER TO admin;

--
-- Name: tifp_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE tifp_seq
    START WITH 5
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tifp_seq OWNER TO admin;

--
-- Name: tifp_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tifp_seq', 5, false);


--
-- Name: usuarios_perfiles; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE usuarios_perfiles (
    id numeric(20,0) NOT NULL,
    idusua numeric(20,0) NOT NULL,
    idperf numeric(20,0) NOT NULL,
    idgrem numeric(20,0),
    idempr numeric(20,0),
    idesre numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone,
    CONSTRAINT uspe_chk_01 CHECK ((((((idperf = (1)::numeric) AND (idgrem IS NULL)) AND (idempr IS NULL)) OR (((idperf = (2)::numeric) AND (idgrem IS NOT NULL)) AND (idempr IS NULL))) OR (((idperf <> ALL (ARRAY[(1)::numeric, (2)::numeric])) AND (idgrem IS NULL)) AND (idempr IS NOT NULL))))
);


ALTER TABLE public.usuarios_perfiles OWNER TO admin;

--
-- Name: uspe; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW uspe AS
    SELECT usuarios_perfiles.id, usuarios_perfiles.idusua, usuarios_perfiles.idperf, usuarios_perfiles.idgrem, usuarios_perfiles.idempr, usuarios_perfiles.idesre, usuarios_perfiles.idusuacrearegistro, usuarios_perfiles.fechacrearegistro, usuarios_perfiles.idusuamodifregistro, usuarios_perfiles.fechamodifregistro, usuarios_perfiles.idusuaborraregistro, usuarios_perfiles.fechaborraregistro FROM usuarios_perfiles;


ALTER TABLE public.uspe OWNER TO admin;

--
-- Name: uspe_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE uspe_seq
    START WITH 25
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.uspe_seq OWNER TO admin;

--
-- Name: uspe_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('uspe_seq', 25, false);


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE usuarios (
    id numeric(20,0) NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    idpers numeric(20,0) NOT NULL,
    idesre numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.usuarios OWNER TO admin;

--
-- Name: usua; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW usua AS
    SELECT usuarios.id, usuarios.username, usuarios.password, usuarios.idpers, usuarios.idesre, usuarios.idusuacrearegistro, usuarios.fechacrearegistro, usuarios.idusuamodifregistro, usuarios.fechamodifregistro, usuarios.idusuaborraregistro, usuarios.fechaborraregistro FROM usuarios;


ALTER TABLE public.usua OWNER TO admin;

--
-- Name: usua_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE usua_seq
    START WITH 13
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.usua_seq OWNER TO admin;

--
-- Name: usua_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('usua_seq', 13, false);


--
-- Name: valores_paises; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE valores_paises (
    id numeric(20,0) NOT NULL,
    idpais numeric(20,0) NOT NULL,
    nombrecorto character varying(10) NOT NULL,
    nombrelargo character varying(500) NOT NULL,
    descripcion character varying(1000) NOT NULL,
    valor character varying(1000) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.valores_paises OWNER TO admin;

--
-- Name: vapa; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW vapa AS
    SELECT valores_paises.id, valores_paises.idpais, valores_paises.nombrecorto, valores_paises.nombrelargo, valores_paises.descripcion, valores_paises.valor, valores_paises.idusuacrearegistro, valores_paises.fechacrearegistro, valores_paises.idusuamodifregistro, valores_paises.fechamodifregistro, valores_paises.idusuaborraregistro, valores_paises.fechaborraregistro FROM valores_paises;


ALTER TABLE public.vapa OWNER TO admin;

--
-- Name: vapa_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE vapa_seq
    START WITH 55
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.vapa_seq OWNER TO admin;

--
-- Name: vapa_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('vapa_seq', 55, false);


--
-- Data for Name: centros_costos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO centros_costos VALUES (1, 2, 'ZONA CENTRO - PRODUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (2, 2, 'ZONA CENTRO - ADMINISTRACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (3, 2, 'ZONA CENTRO - VENTAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (4, 2, 'ZONA NORTE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (5, 2, 'ZONA SUR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (6, 3, 'ZONA CENTRO - PRODUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (7, 3, 'ZONA CENTRO - ADMINISTRACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (8, 3, 'ZONA CENTRO - VENTAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (9, 3, 'ZONA NORTE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (10, 3, 'ZONA SUR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (11, 4, 'ZONA CENTRO - PRODUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (12, 4, 'ZONA CENTRO - ADMINISTRACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (13, 4, 'ZONA CENTRO - VENTAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (14, 4, 'ZONA NORTE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (15, 4, 'ZONA SUR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (16, 5, 'ZONA CENTRO - PRODUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (17, 5, 'ZONA CENTRO - ADMINISTRACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (18, 5, 'ZONA CENTRO - VENTAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (19, 5, 'ZONA NORTE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (20, 5, 'ZONA SUR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (21, 6, 'ZONA CENTRO - PRODUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (22, 6, 'ZONA CENTRO - ADMINISTRACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (23, 6, 'ZONA CENTRO - VENTAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (24, 6, 'ZONA NORTE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (25, 6, 'ZONA SUR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (26, 7, 'ZONA CENTRO - PRODUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (27, 7, 'ZONA CENTRO - ADMINISTRACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (28, 7, 'ZONA CENTRO - VENTAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (29, 7, 'ZONA NORTE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (30, 7, 'ZONA SUR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (31, 8, 'ZONA CENTRO - PRODUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (32, 8, 'ZONA CENTRO - ADMINISTRACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (33, 8, 'ZONA CENTRO - VENTAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (34, 8, 'ZONA NORTE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (35, 8, 'ZONA SUR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (36, 9, 'ZONA CENTRO - PRODUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (37, 9, 'ZONA CENTRO - ADMINISTRACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (38, 9, 'ZONA CENTRO - VENTAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (39, 9, 'ZONA NORTE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (40, 9, 'ZONA SUR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (41, 10, 'ZONA CENTRO - PRODUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (42, 10, 'ZONA CENTRO - ADMINISTRACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (43, 10, 'ZONA CENTRO - VENTAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (44, 10, 'ZONA NORTE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (45, 10, 'ZONA SUR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);


--
-- Data for Name: cotizaciones_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: doctos_cotizacs_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: doctos_ordenes_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: documentos_legales; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO documentos_legales VALUES (1, 1, 1, 'Prueba_1.TXT', 'prueba_1.txt', 1, '2017-09-24', 'LA UNICA', 'F1', 'PEDRO PARAMO', 'NINGUNO', '2017-01-01', 'GCPA68@HOTMAIL.COM', 'S', 1, '2017-09-24 19:13:05.393573', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (2, 1, 2, 'Prueba_2.TXT', 'prueba_2.txt', 1, '2017-09-24', 'LA CUCHUFLETA', '100', 'JUAN SOTO', 'NADA', '2017-01-01', 'GCPA68@HOTMAIL.COM', 'S', 1, '2017-09-24 19:28:14.976243', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (3, 1, 3, 'Prueba_3.TXT', 'prueba_3.txt', 1, '2017-09-24', 'PEREZ', '500', 'FERNANDO ASTE', 'NINGUNA', '2017-01-01', 'GCPA68@HOTMAIL.COM', 'S', 1, '2017-09-24 19:28:15.004232', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: empresas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO empresas VALUES (1, 1, 1, 1, '1', '9', 'BUSINESS & TECHNOLOGY 5 CONSULTING', 'BT5', 'bt5.jpg', 1, '2017-09-23 22:33:59.895793', NULL, NULL, NULL, NULL, NULL);
INSERT INTO empresas VALUES (2, 2, 1, 3, '96550820', '1', 'METALPAR S.A.', 'METALPAR S.A.', 'emp_metalpar.jpg', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (3, 2, 1, 4, '93576000', '3', 'INDUSTRIAS METALURGICAS PAREDES', 'INDUSTRIAL METALPAR S.A.', 'emp_industrias.jpg', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (4, 2, 1, 5, '88337800', '8', 'INVERSIONES METALPAR S.A.', 'INVERSIONES METALPAR S.A.', 'emp_inv_metalpar.jpg', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (5, 2, 1, 6, '78400010', '9', 'AGRICOLA Y GANADERA SANTA BARBARA', 'STA. BARBARA', 'emp_sta_barbara.jpg', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (6, 3, 1, 16, '89807200', '2', 'FARMACIAS CRUZ VERDE', 'FCV', 'emp_cruz_verde.jpg', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (7, 3, 1, 16, '89741200', '4', 'DIFARMA', 'DIFARMA', 'emp_difarma.jpg', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (8, 3, 1, 17, '91575000', '1', 'SOCOFAR', 'SOCOFAR', 'emp_socofar.jpg', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (9, 3, 1, 16, '71378000', '6', 'LABORATORIO MINTLAB', 'MINTLAB', 'emp_mintlab.jpg', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (10, 3, 1, 16, '77781470', '2', 'LABORATORIO MUNICH', 'MUNICH', 'emp_munich.jpg', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (11, 4, 1, 26, '76765660', '2', 'AMASANDERIA TRIGAL', 'TRIGAL', 'emp_trigal.jpg', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL, '');


--
-- Data for Name: estados_civiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_civiles VALUES (1, 'S', 'SOLTERO');
INSERT INTO estados_civiles VALUES (2, 'C', 'CASADO');


--
-- Data for Name: estados_cotizacs_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_cotizacs_servs_hono VALUES (1, 'RECIBIDA');
INSERT INTO estados_cotizacs_servs_hono VALUES (2, 'ACEPTADA');
INSERT INTO estados_cotizacs_servs_hono VALUES (3, 'RECHAZADA');


--
-- Data for Name: estados_documentos_legales; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_documentos_legales VALUES (1, 'VALIDO');
INSERT INTO estados_documentos_legales VALUES (2, 'INVALIDO');
INSERT INTO estados_documentos_legales VALUES (3, 'CADUCO');


--
-- Data for Name: estados_grem; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_grem VALUES (1, 'ACTIVO');
INSERT INTO estados_grem VALUES (2, 'INACTIVO');
INSERT INTO estados_grem VALUES (3, 'BORRADO');
INSERT INTO estados_grem VALUES (4, 'SUSPENDIDO');


--
-- Data for Name: estados_ordenes_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_ordenes_servs_hono VALUES (1, 'CREADA');
INSERT INTO estados_ordenes_servs_hono VALUES (2, 'ASIGNADA A PROFESIONAL');
INSERT INTO estados_ordenes_servs_hono VALUES (3, 'TERMINADA EXITOSAMENTE (APROBADO EL TRABAJO)');
INSERT INTO estados_ordenes_servs_hono VALUES (4, 'TERMINADA NO EXITOSAMENTE (RECHAZADO EL TRABAJO)');


--
-- Data for Name: estados_pagos_ords_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_pagos_ords_servs_hono VALUES (1, 'CREADO');
INSERT INTO estados_pagos_ords_servs_hono VALUES (2, 'PAGADO');


--
-- Data for Name: estados_registros; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_registros VALUES (1, 'ACTIVO');
INSERT INTO estados_registros VALUES (2, 'INACTIVO');
INSERT INTO estados_registros VALUES (3, 'BORRADO');


--
-- Data for Name: estados_solics_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_solics_servs_hono VALUES (1, 'CREADA');
INSERT INTO estados_solics_servs_hono VALUES (2, 'TRANSFERIDA A JEFE DE COMPRAS');
INSERT INTO estados_solics_servs_hono VALUES (3, 'EN PROCESO');
INSERT INTO estados_solics_servs_hono VALUES (4, 'ACEPTADA UNA COTIZACION');
INSERT INTO estados_solics_servs_hono VALUES (5, 'RECHAZADAS TODAS LAS COTIZACIONES');


--
-- Data for Name: gerencias; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO gerencias VALUES (1, 2, 'GERENCIA GENERAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (2, 2, 'GERENCIA COMERCIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (3, 2, 'GERENCIA MARKETING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (4, 2, 'GERENCIA RRHH', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (5, 2, 'GERENCIA ADM. Y FINANZAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (6, 3, 'GERENCIA GENERAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (7, 3, 'GERENCIA COMERCIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (8, 3, 'GERENCIA MARKETING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (9, 3, 'GERENCIA RRHH', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (10, 3, 'GERENCIA ADM. Y FINANZAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (11, 4, 'GERENCIA GENERAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (12, 4, 'GERENCIA COMERCIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (13, 4, 'GERENCIA MARKETING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (14, 4, 'GERENCIA RRHH', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (15, 4, 'GERENCIA ADM. Y FINANZAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (16, 5, 'GERENCIA GENERAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (17, 5, 'GERENCIA COMERCIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (18, 5, 'GERENCIA MARKETING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (19, 5, 'GERENCIA RRHH', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (20, 5, 'GERENCIA ADM. Y FINANZAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (21, 6, 'GERENCIA GENERAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (22, 6, 'GERENCIA COMERCIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (23, 6, 'GERENCIA MARKETING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (24, 6, 'GERENCIA RRHH', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (25, 6, 'GERENCIA ADM. Y FINANZAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (26, 7, 'GERENCIA GENERAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (27, 7, 'GERENCIA COMERCIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (28, 7, 'GERENCIA MARKETING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (29, 7, 'GERENCIA RRHH', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (30, 7, 'GERENCIA ADM. Y FINANZAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (31, 8, 'GERENCIA GENERAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (32, 8, 'GERENCIA COMERCIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (33, 8, 'GERENCIA MARKETING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (34, 8, 'GERENCIA RRHH', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (35, 8, 'GERENCIA ADM. Y FINANZAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (36, 9, 'GERENCIA GENERAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (37, 9, 'GERENCIA COMERCIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (38, 9, 'GERENCIA MARKETING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (39, 9, 'GERENCIA RRHH', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (40, 9, 'GERENCIA ADM. Y FINANZAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (41, 10, 'GERENCIA GENERAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (42, 10, 'GERENCIA COMERCIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (43, 10, 'GERENCIA MARKETING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (44, 10, 'GERENCIA RRHH', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (45, 10, 'GERENCIA ADM. Y FINANZAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);


--
-- Data for Name: grupos_empresariales; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO grupos_empresariales VALUES (1, 'BUSINESS & TECHNOLOGY 5 CONSULTING', 'BT5', 'bt5.jpg', 1, 1, 1, '2017-09-23 22:33:59.528716', NULL, NULL, NULL, NULL);
INSERT INTO grupos_empresariales VALUES (2, 'METALPAR', 'MPAR', 'hold_metalpar.jpg', 1, 1, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO grupos_empresariales VALUES (3, 'CRUZ VERDE', 'CV', 'hold_cruz_verde.jpg', 1, 1, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO grupos_empresariales VALUES (4, 'AMASANDERIA TRIGAL', 'AT', 'hold_trigal.jpg', 1, 1, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);


--
-- Data for Name: lineas_negocios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO lineas_negocios VALUES (1, 2, 'PERFILES DE ACERO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (2, 2, 'CANALETAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (3, 2, 'FIERROS CILINDRICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (4, 2, 'CONSTRUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (5, 2, 'COMERCIALIZACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (6, 2, 'IMPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (7, 2, 'EXPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (8, 3, 'PERFILES DE ACERO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (9, 3, 'CANALETAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (10, 3, 'FIERROS CILINDRICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (11, 3, 'CONSTRUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (12, 3, 'COMERCIALIZACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (13, 3, 'IMPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (14, 3, 'EXPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (15, 4, 'PERFILES DE ACERO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (16, 4, 'CANALETAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (17, 4, 'FIERROS CILINDRICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (18, 4, 'CONSTRUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (19, 4, 'COMERCIALIZACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (20, 4, 'IMPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (21, 4, 'EXPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (22, 5, 'PERFILES DE ACERO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (23, 5, 'CANALETAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (24, 5, 'FIERROS CILINDRICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (25, 5, 'CONSTRUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (26, 5, 'COMERCIALIZACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (27, 5, 'IMPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (28, 5, 'EXPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (29, 6, 'PERFILES DE ACERO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (30, 6, 'CANALETAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (31, 6, 'FIERROS CILINDRICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (32, 6, 'CONSTRUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (33, 6, 'COMERCIALIZACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (34, 6, 'IMPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (35, 6, 'EXPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (36, 7, 'PERFILES DE ACERO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (37, 7, 'CANALETAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (38, 7, 'FIERROS CILINDRICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (39, 7, 'CONSTRUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (40, 7, 'COMERCIALIZACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (41, 7, 'IMPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (42, 7, 'EXPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (43, 8, 'PERFILES DE ACERO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (44, 8, 'CANALETAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (45, 8, 'FIERROS CILINDRICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (46, 8, 'CONSTRUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (47, 8, 'COMERCIALIZACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (48, 8, 'IMPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (49, 8, 'EXPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (50, 9, 'PERFILES DE ACERO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (51, 9, 'CANALETAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (52, 9, 'FIERROS CILINDRICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (53, 9, 'CONSTRUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (54, 9, 'COMERCIALIZACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (55, 9, 'IMPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (56, 9, 'EXPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (57, 10, 'PERFILES DE ACERO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (58, 10, 'CANALETAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (59, 10, 'FIERROS CILINDRICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (60, 10, 'CONSTRUCCION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (61, 10, 'COMERCIALIZACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (62, 10, 'IMPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (63, 10, 'EXPORTACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);


--
-- Data for Name: monedas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO monedas VALUES (1, 'PESO CHILENO', 'CLP');
INSERT INTO monedas VALUES (2, 'PESO ARGENTINO', 'ARS');
INSERT INTO monedas VALUES (3, 'NUEVO SOL', 'PEN');
INSERT INTO monedas VALUES (4, 'BOLIVIANO', 'BOB');
INSERT INTO monedas VALUES (5, 'GUARANI', 'PYG');
INSERT INTO monedas VALUES (6, 'PESO URUGUAYO', 'UYU');
INSERT INTO monedas VALUES (7, 'REAL', 'BRL');
INSERT INTO monedas VALUES (8, 'SUCRE', 'ECS');
INSERT INTO monedas VALUES (9, 'BOLIVAR', 'VEB');
INSERT INTO monedas VALUES (10, 'PESO COLOMBIANO', 'COP');


--
-- Data for Name: ordenes_servicios_hono; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: pagos_ordenes_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: paises; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO paises VALUES (1, 'CHILE', 1, 'CHILENA');
INSERT INTO paises VALUES (2, 'ARGENTINA', 2, 'ARGENTINA');
INSERT INTO paises VALUES (3, 'PERU', 3, 'PERUANA');
INSERT INTO paises VALUES (4, 'BOLIVIA', 4, 'BOLIVIANA');
INSERT INTO paises VALUES (5, 'PARAGUAY', 5, 'PARAGUAYA');
INSERT INTO paises VALUES (6, 'URUGUAY', 6, 'URUGUAYA');
INSERT INTO paises VALUES (7, 'BRASIL', 7, 'BRASILENA');
INSERT INTO paises VALUES (8, 'ECUADOR', 8, 'ECUATORIANA');
INSERT INTO paises VALUES (9, 'VENEZUELA', 9, 'VENEZOLANA');
INSERT INTO paises VALUES (10, 'COLOMBIA', 10, 'COLOMBIANA');


--
-- Data for Name: parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO parametros VALUES (1, 2, 'LARGOMINCLAVE', 'LARGO MINIMO CLAVE USUARIOS', 'LARGO MINIMO EXIGIDO PARA LAS CLAVE DE LOS USUARIOS', '5', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (2, 2, 'NROSEGMSPLCU', 'NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS', 'NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING', '4', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (3, 3, 'LARGOMINCLAVE', 'LARGO MINIMO CLAVE USUARIOS', 'LARGO MINIMO EXIGIDO PARA LAS CLAVE DE LOS USUARIOS', '5', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (4, 3, 'NROSEGMSPLCU', 'NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS', 'NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING', '4', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (5, 4, 'LARGOMINCLAVE', 'LARGO MINIMO CLAVE USUARIOS', 'LARGO MINIMO EXIGIDO PARA LAS CLAVE DE LOS USUARIOS', '5', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (6, 4, 'NROSEGMSPLCU', 'NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS', 'NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING', '4', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);


--
-- Data for Name: perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO perfiles VALUES (1, 'ADMINISTRADOR DEL SISTEMA');
INSERT INTO perfiles VALUES (2, 'ADMINISTRADOR HOLDING');
INSERT INTO perfiles VALUES (3, 'ADMINISTRADOR EMPRESA');
INSERT INTO perfiles VALUES (4, 'GERENTE GENERAL');
INSERT INTO perfiles VALUES (5, 'SECRETARIA GERENTE GENERAL');
INSERT INTO perfiles VALUES (6, 'GERENTE DE ADMINISTRACION Y FINANZAS');
INSERT INTO perfiles VALUES (7, 'SECRETARIA GERENTE DE ADMINISTRACION Y FINANZAS');
INSERT INTO perfiles VALUES (8, 'TESORERO');
INSERT INTO perfiles VALUES (9, 'ASISTENTE 1 TESORERO');
INSERT INTO perfiles VALUES (10, 'ASISTENTE 2 TESORERO');
INSERT INTO perfiles VALUES (11, 'CAJERO');
INSERT INTO perfiles VALUES (12, 'CONTADOR GENERAL');
INSERT INTO perfiles VALUES (13, 'ASISTENTE 1 CONTABILIDAD');
INSERT INTO perfiles VALUES (14, 'ASISTENTE 2 CONTABILIDAD');
INSERT INTO perfiles VALUES (15, 'JEFE DE COMPRAS');
INSERT INTO perfiles VALUES (16, 'AYUDANTE JEFE DE COMPRAS');
INSERT INTO perfiles VALUES (17, 'JEFE DE VENTAS');
INSERT INTO perfiles VALUES (18, 'AYUDANTE JEFE DE VENTAS');
INSERT INTO perfiles VALUES (19, 'PERFIL DE PRUEBA CON ACCESO A TODO');


--
-- Data for Name: perfiles_programas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO perfiles_programas VALUES (1, 1, 1, 1, '2017-09-23 22:34:00.179392', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (2, 1, 2, 1, '2017-09-23 22:34:00.187875', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (3, 1, 3, 1, '2017-09-23 22:34:00.196185', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (4, 1, 4, 1, '2017-09-23 22:34:00.204484', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (5, 1, 5, 1, '2017-09-23 22:34:00.212792', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (6, 1, 6, 1, '2017-09-23 22:34:00.221116', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (7, 8, 1, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (8, 8, 2, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (9, 8, 3, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (10, 12, 1, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (11, 12, 2, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (12, 12, 3, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (13, 15, 1, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (14, 15, 2, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (15, 15, 3, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (16, 17, 1, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (17, 17, 2, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (18, 17, 3, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (19, 19, 1, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (20, 19, 2, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (21, 19, 3, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (22, 19, 4, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (23, 19, 5, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (24, 19, 6, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (25, 19, 7, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (26, 19, 8, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (27, 19, 9, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (28, 19, 10, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (29, 19, 11, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (30, 19, 12, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (31, 19, 13, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (32, 19, 14, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (33, 19, 15, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (34, 19, 16, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (35, 19, 17, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (36, 19, 18, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (37, 19, 19, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (38, 19, 20, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (39, 19, 21, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (40, 19, 22, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (41, 19, 23, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (42, 19, 24, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (43, 19, 25, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (44, 19, 26, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (45, 19, 27, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (46, 19, 28, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (47, 19, 29, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (48, 19, 30, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (49, 19, 31, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (50, 19, 32, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (51, 19, 33, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (52, 19, 34, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (53, 19, 35, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (54, 19, 36, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (55, 19, 37, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (56, 19, 38, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (57, 19, 39, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (58, 19, 40, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (59, 19, 41, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (60, 19, 42, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (61, 19, 43, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (62, 19, 44, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (63, 19, 45, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (64, 19, 46, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);


--
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO personas VALUES (1, 1, '1', '9', 'ADMINISTRADOR', NULL, 'SISTEMA', 'AS', NULL, NULL, NULL, NULL, NULL, 1, '2017-09-23 22:33:59.545411', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (2, 1, '2', '0', 'ROLANDO', NULL, 'SILVA', '-', '', NULL, 2, 1, 1, 1, '2017-09-23 22:33:59.73633', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (3, 1, '3', '0', 'SERGIO', NULL, 'AGUIRRE', '-', 'sergio.aguirre@bt5.cl', NULL, 1, 1, 1, 1, '2017-09-23 22:33:59.75425', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (4, 1, '4', '0', 'JUAN', 'JOSE', 'MONSALVE', '-', 'juan.jose.monsalve@bt5.cl', NULL, NULL, 1, 1, 1, '2017-09-23 22:33:59.762795', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (5, 1, '5', '0', 'JUAN', 'ANDRES', 'BORZONE', '-', '', NULL, NULL, 1, 1, 1, '2017-09-23 22:33:59.770856', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (6, 1, '6', '0', 'RODRIGO', NULL, 'CIFUENTES', '-', 'rodrigo.cifuentes@bt5.cl', NULL, 1, 1, 1, 1, '2017-09-23 22:33:59.779173', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (7, 1, '7695503', '4', 'ROBERTO', 'DANIEL', 'QUEZADA', 'ASTE', 'roberto.quezada@bt5.cl', NULL, 2, 1, 1, 1, '2017-09-23 22:33:59.78751', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (8, 1, '8965445', '9', 'OSCIEL', 'SEGUNDO', 'SOLAR', 'MALDONADO', 'solar2design@gmail.com', NULL, 2, 1, 1, 1, '2017-09-23 22:33:59.795832', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (9, 1, '13254825', '0', 'NILTON', 'PATRICIO', 'SALAZAR', 'GONZALEZ', 'nilton.salazar@gmail.com', NULL, 1, 1, 1, 1, '2017-09-23 22:33:59.804252', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (10, 1, '10917721', '0', 'G. CRISTIAN', NULL, 'PALMA', 'ASTE', 'gerardo.palma.aste@gmail.com', '1968-11-12', 1, 1, 1, 1, '2017-09-23 22:33:59.812569', NULL, NULL, NULL, NULL);


--
-- Data for Name: planes_cuentas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO planes_cuentas VALUES (1, 2, '1', '00', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (2, 2, '1', '10', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS CORRIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (3, 2, '1', '10', '10', '0000', NULL, NULL, NULL, NULL, 'EFECTIVO Y EQUIVALENTE AL EFECTIVO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (4, 2, '1', '10', '10', '1001', NULL, NULL, NULL, NULL, 'CAJA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (5, 2, '1', '10', '10', '1002', NULL, NULL, NULL, NULL, 'FONDO FIJO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (6, 2, '1', '10', '10', '2001', NULL, NULL, NULL, NULL, 'BANCO SANTANDER', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (7, 2, '1', '10', '10', '2002', NULL, NULL, NULL, NULL, 'BANCO DE CHILE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (8, 2, '1', '10', '10', '2003', NULL, NULL, NULL, NULL, 'BANCO BBVA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (9, 2, '1', '10', '10', '2004', NULL, NULL, NULL, NULL, 'BANCO BCI', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (10, 2, '1', '10', '10', '2005', NULL, NULL, NULL, NULL, 'BANCO ITAU', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (11, 2, '1', '10', '10', '2006', NULL, NULL, NULL, NULL, 'BANCO SECURITY', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (12, 2, '1', '10', '10', '2007', NULL, NULL, NULL, NULL, 'BANCO SANTANDER DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (13, 2, '1', '10', '10', '2008', NULL, NULL, NULL, NULL, 'BANCO DE CHILE DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (14, 2, '1', '10', '10', '2009', NULL, NULL, NULL, NULL, 'BANCO BBVA DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (15, 2, '1', '10', '10', '2010', NULL, NULL, NULL, NULL, 'BANCO BCI DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (16, 2, '1', '10', '10', '2011', NULL, NULL, NULL, NULL, 'BANCO ITAU DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (17, 2, '1', '10', '10', '2012', NULL, NULL, NULL, NULL, 'BANCO SECURITY DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (18, 2, '1', '10', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (19, 2, '1', '10', '11', '0001', NULL, NULL, NULL, NULL, 'DEPOSITOS A PLAZO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (20, 2, '1', '10', '11', '1002', NULL, NULL, NULL, NULL, 'FONDOS MUTUOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (21, 2, '1', '10', '11', '1003', NULL, NULL, NULL, NULL, 'PACTOS RETROVENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (22, 2, '1', '10', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (23, 2, '1', '10', '13', '0000', NULL, NULL, NULL, NULL, 'DEUDORES COMERCIALES Y OTRAS CUENTAS POR COBRAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (24, 2, '1', '10', '13', '1001', NULL, NULL, NULL, NULL, 'CLIENTES NACIONALES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (25, 2, '1', '10', '13', '1002', NULL, NULL, NULL, NULL, 'CLIENTES EXTRANJEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (26, 2, '1', '10', '13', '1003', NULL, NULL, NULL, NULL, 'CHEQUES EN CARTERA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (27, 2, '1', '10', '13', '1004', NULL, NULL, NULL, NULL, 'TARJETA DE DEBITO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (28, 2, '1', '10', '13', '1005', NULL, NULL, NULL, NULL, 'TARJETA DE CREDITO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (29, 2, '1', '10', '13', '1006', NULL, NULL, NULL, NULL, 'CHEQUES PROTESTADOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (30, 2, '1', '10', '13', '1007', NULL, NULL, NULL, NULL, 'DOCUMENTOS PROTESTADOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (31, 2, '1', '10', '13', '2001', NULL, NULL, NULL, NULL, 'ESTIMACION DEUDORES INCOBRABLES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (32, 2, '1', '10', '13', '3001', NULL, NULL, NULL, NULL, 'FONDOS POR RENDIR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (33, 2, '1', '10', '13', '4001', NULL, NULL, NULL, NULL, 'PRESTAMOS AL PERSONAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (34, 2, '1', '10', '13', '5001', NULL, NULL, NULL, NULL, 'ANTICIPO DE SUELDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (35, 2, '1', '10', '13', '5002', NULL, NULL, NULL, NULL, 'ANTICIPO DE HONORARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (36, 2, '1', '10', '13', '5003', NULL, NULL, NULL, NULL, 'ANTICIPO A PROVEEDORES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (37, 2, '1', '10', '14', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (38, 2, '1', '10', '14', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA NACIONAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (39, 2, '1', '10', '14', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA EXTRANJERA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (40, 2, '1', '10', '15', '0000', NULL, NULL, NULL, NULL, 'INVENTARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (41, 2, '1', '10', '15', '1001', NULL, NULL, NULL, NULL, 'EXISTENCIA EN TRANSITO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (42, 2, '1', '10', '15', '1002', NULL, NULL, NULL, NULL, 'EXISTENCIAS EN PROCESO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (43, 2, '1', '10', '15', '2001', NULL, NULL, NULL, NULL, 'EXISTENCIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (44, 2, '1', '10', '16', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (45, 2, '1', '10', '17', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (46, 2, '1', '10', '17', '1001', NULL, NULL, NULL, NULL, 'PAGOS PROVISIONALES MENSUALES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (47, 2, '1', '10', '17', '1002', NULL, NULL, NULL, NULL, 'IVA CREDITO FISCAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (48, 2, '1', '10', '17', '2001', NULL, NULL, NULL, NULL, 'OTROS IMPUESTOS POR RECUPERAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (49, 2, '1', '10', '19', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (50, 2, '1', '10', '19', '1001', NULL, NULL, NULL, NULL, 'ACTIVOS DISPONIBLES MANTENIDOS PARA LA VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (51, 2, '1', '10', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA DISTRIBUIR A PROPIETARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (52, 2, '1', '10', '21', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA O A DISTRIBUIR A LOS PROPIETARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (53, 2, '1', '20', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS NO CORRIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (54, 2, '1', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (55, 2, '1', '20', '10', '1001', NULL, NULL, NULL, NULL, 'SEGUROS PAGADOS POR ANTICIPADO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (56, 2, '1', '20', '10', '1002', NULL, NULL, NULL, NULL, 'ARRIENDOS PAGADOS POR ANTICIPADO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (57, 2, '1', '20', '10', '1003', NULL, NULL, NULL, NULL, 'OTROS GASTOS PAGADOS POR ANTICIPADO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (58, 2, '1', '20', '10', '1004', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (59, 2, '1', '20', '10', '2001', NULL, NULL, NULL, NULL, 'INTERESES DIFERIDOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (60, 2, '1', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (61, 2, '1', '20', '12', '0000', NULL, NULL, NULL, NULL, 'DERECHOS POR COBRAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (62, 2, '1', '20', '13', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (63, 2, '1', '20', '14', '0000', NULL, NULL, NULL, NULL, 'INVERSIONES POR METODO DE PARTICIPACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (64, 2, '1', '20', '15', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS INTANGIBLES DISTINTO A LA PLUSVALIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (65, 2, '1', '20', '16', '0000', NULL, NULL, NULL, NULL, 'PLUSVALIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (66, 2, '1', '20', '17', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES, PLANTAS Y EQUIPOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (67, 2, '1', '20', '17', '1001', NULL, NULL, NULL, NULL, 'TERRENOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (68, 2, '1', '20', '17', '2001', NULL, NULL, NULL, NULL, 'CONSTRUCCIONES E INTALACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (69, 2, '1', '20', '17', '3001', NULL, NULL, NULL, NULL, 'MUEBLES E UTILES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (70, 2, '1', '20', '17', '4001', NULL, NULL, NULL, NULL, 'VEHICULOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (71, 2, '1', '20', '17', '5001', NULL, NULL, NULL, NULL, 'EQUIPOS COMPUTACIONALES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (72, 2, '1', '20', '17', '6001', NULL, NULL, NULL, NULL, 'ACTIVOS EN LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (73, 2, '1', '20', '17', '7001', NULL, NULL, NULL, NULL, 'PROGRAMAS Y SOFTWARES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (74, 2, '1', '20', '17', '8001', NULL, NULL, NULL, NULL, 'DEPRECIACIÓN ACUMULADA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (75, 2, '1', '20', '18', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (76, 2, '1', '20', '19', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES DE INVERSION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (77, 2, '1', '20', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTO DIFERIDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (78, 2, '2', '00', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (79, 2, '2', '10', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CORRIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (80, 2, '2', '10', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (81, 2, '2', '10', '10', '1001', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON BANCOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (82, 2, '2', '10', '10', '1002', NULL, NULL, NULL, NULL, 'LÍNEAS DE CREDITO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (83, 2, '2', '10', '10', '1003', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (84, 2, '2', '10', '11', '0000', NULL, NULL, NULL, NULL, 'CUENTAS COMERCIALES Y OTRAS CUENTAS POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (85, 2, '2', '10', '11', '1001', NULL, NULL, NULL, NULL, 'PROVEEDORES NACIONALES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (86, 2, '2', '10', '11', '1002', NULL, NULL, NULL, NULL, 'PROVEEDORES EXTRANJEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (87, 2, '2', '10', '11', '1003', NULL, NULL, NULL, NULL, 'CHEQUES POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (88, 2, '2', '10', '11', '1004', NULL, NULL, NULL, NULL, 'HONORARIOS POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (89, 2, '2', '10', '11', '1005', NULL, NULL, NULL, NULL, 'ANTICIPOS DE CLIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (90, 2, '2', '10', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (91, 2, '2', '10', '12', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA NACIONAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (92, 2, '2', '10', '12', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA EXTRANJERA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (93, 2, '2', '10', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (94, 2, '2', '10', '13', '1001', NULL, NULL, NULL, NULL, 'PROVISIONES POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (95, 2, '2', '10', '13', '2001', NULL, NULL, NULL, NULL, 'PROVISION DE VACACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (96, 2, '2', '10', '13', '2002', NULL, NULL, NULL, NULL, 'PROVISIONES VARIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (97, 2, '2', '10', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (98, 2, '2', '10', '14', '1001', NULL, NULL, NULL, NULL, 'IVA DEBITO FISCAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (99, 2, '2', '10', '14', '1002', NULL, NULL, NULL, NULL, 'IVA POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (100, 2, '2', '10', '14', '1003', NULL, NULL, NULL, NULL, 'RETENCION 1° CATEGORIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (101, 2, '2', '10', '14', '1004', NULL, NULL, NULL, NULL, 'RETENCION 2° CATEGORIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (102, 2, '2', '10', '14', '1005', NULL, NULL, NULL, NULL, 'PPM POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (103, 2, '2', '10', '14', '2001', NULL, NULL, NULL, NULL, 'PROVISION IMPUESTO A LA RENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (104, 2, '2', '10', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A EMPLEADOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (105, 2, '2', '10', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (106, 2, '2', '10', '18', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CLASIFICADOS COMO MANTENIDOS PARA LA VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (107, 2, '2', '20', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS NO CORRIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (108, 2, '2', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (109, 2, '2', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS CUENTAS POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (110, 2, '2', '20', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (111, 2, '2', '20', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (112, 2, '2', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS DIFERIDOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (113, 2, '2', '20', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A LOS EMPLEADOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (114, 2, '2', '20', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (115, 2, '2', '30', '00', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO  ', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (116, 2, '2', '30', '10', '0000', NULL, NULL, NULL, NULL, 'CAPITAL EMITIDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (117, 2, '2', '30', '10', '0001', NULL, NULL, NULL, NULL, 'CAPITAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (118, 2, '2', '30', '11', '0000', NULL, NULL, NULL, NULL, 'GANANCIAS (PERDIDAS) ACUMULADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (119, 2, '2', '30', '11', '0001', NULL, NULL, NULL, NULL, 'RESULTADO ACUMULADO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (120, 2, '2', '30', '12', '0000', NULL, NULL, NULL, NULL, 'PRIMAS DE EMISION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (121, 2, '2', '30', '13', '0000', NULL, NULL, NULL, NULL, 'ACCIONES PROPIAS EN CARTERA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (122, 2, '2', '30', '14', '0000', NULL, NULL, NULL, NULL, 'OTRAS PARTICIPACIONES EN EL PATRIMONIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (123, 2, '2', '30', '15', '0000', NULL, NULL, NULL, NULL, 'OTRAS RESERVAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (124, 2, '2', '30', '16', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO ATRIBUIBLE A PROPIETARIOS DE LA CONTROLADORA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (125, 2, '2', '30', '17', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACIONES NO CONTROLADORAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (126, 2, '3', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO GANANCIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (127, 2, '3', '10', '10', '0000', NULL, NULL, NULL, NULL, 'INGRESOS DE ACTIVIDADES ORDINARIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (128, 2, '3', '10', '10', '1001', NULL, NULL, NULL, NULL, 'VENTA DE GRUAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (129, 2, '3', '10', '10', '1002', NULL, NULL, NULL, NULL, 'VENTA DE ACCESORIAS DE GRUAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (130, 2, '3', '10', '10', '1003', NULL, NULL, NULL, NULL, 'VENTA DE PLATAFORMAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (131, 2, '3', '10', '10', '1004', NULL, NULL, NULL, NULL, 'VENTA DE REPUESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (132, 2, '3', '10', '10', '1005', NULL, NULL, NULL, NULL, 'VENTA DE SERVICIO TECNICO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (133, 2, '3', '10', '10', '1006', NULL, NULL, NULL, NULL, 'VENTA DE LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (134, 2, '3', '10', '10', '2001', NULL, NULL, NULL, NULL, 'ARRIENDOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (135, 2, '3', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS INGRESOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (136, 2, '3', '20', '10', '1001', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (137, 2, '3', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS GANANCIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (138, 2, '3', '20', '12', '0000', NULL, NULL, NULL, NULL, 'INGRESOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (139, 2, '4', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO PERDIDA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (140, 2, '4', '10', '00', '0000', NULL, NULL, NULL, NULL, 'COSTO DE VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (141, 2, '4', '10', '10', '1001', NULL, NULL, NULL, NULL, 'COSTO DE GRUAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (142, 2, '4', '10', '10', '1002', NULL, NULL, NULL, NULL, 'COSTO DE ACCESORIAS DE GRUAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (143, 2, '4', '10', '10', '1003', NULL, NULL, NULL, NULL, 'COSTO DE PLATAFORMAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (144, 2, '4', '10', '10', '1004', NULL, NULL, NULL, NULL, 'COSTO DE REPUESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (145, 2, '4', '10', '10', '1005', NULL, NULL, NULL, NULL, 'COSTO DE SERVICIO TECNICO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (146, 2, '4', '10', '10', '1006', NULL, NULL, NULL, NULL, 'COSTO DE LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (147, 2, '4', '10', '10', '2001', NULL, NULL, NULL, NULL, 'COSTO DE ARRIENDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (148, 2, '4', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS COSTOS DE EXPLOTACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (149, 2, '4', '20', '11', '0000', NULL, NULL, NULL, NULL, 'GASTOS DE ADMINISTRACION Y VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (150, 2, '4', '20', '11', '1001', NULL, NULL, NULL, NULL, 'REMUNERACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (151, 2, '4', '20', '11', '1002', NULL, NULL, NULL, NULL, 'COMISIONES POR VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (152, 2, '4', '20', '11', '1003', NULL, NULL, NULL, NULL, 'FINIQUITOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (153, 2, '4', '20', '11', '2001', NULL, NULL, NULL, NULL, 'ASESORIA INFORMATICA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (154, 2, '4', '20', '11', '2002', NULL, NULL, NULL, NULL, 'ASESORIA COMEX', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (155, 2, '4', '20', '11', '2003', NULL, NULL, NULL, NULL, 'ASESORIA DE MARKETING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (156, 2, '4', '20', '11', '2004', NULL, NULL, NULL, NULL, 'ASESORIA LEGAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (157, 2, '4', '20', '11', '2005', NULL, NULL, NULL, NULL, 'ASESORIA CONTABLE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (158, 2, '4', '20', '11', '2006', NULL, NULL, NULL, NULL, 'ASESORIA TECNICA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (159, 2, '4', '20', '11', '3001', NULL, NULL, NULL, NULL, 'GASTOS DE PUBLICIDAD', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (160, 2, '4', '20', '11', '3002', NULL, NULL, NULL, NULL, 'GASTOS DE REPRESENTACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (161, 2, '4', '20', '11', '3003', NULL, NULL, NULL, NULL, 'VIAJES Y ESTADIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (162, 2, '4', '20', '11', '3004', NULL, NULL, NULL, NULL, 'FERIAS Y STAND', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (163, 2, '4', '20', '11', '4001', NULL, NULL, NULL, NULL, 'ARRIENDO DE OFICINAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (164, 2, '4', '20', '11', '4002', NULL, NULL, NULL, NULL, 'COMBUSTIBLE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (165, 2, '4', '20', '11', '4003', NULL, NULL, NULL, NULL, 'GASTOS DE OFICINA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (166, 2, '4', '20', '11', '4004', NULL, NULL, NULL, NULL, 'MANTENCION DE VEHICULOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (167, 2, '4', '20', '11', '4005', NULL, NULL, NULL, NULL, 'TELEFONOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (168, 2, '4', '20', '11', '4006', NULL, NULL, NULL, NULL, 'AGUA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (169, 2, '4', '20', '11', '4007', NULL, NULL, NULL, NULL, 'ELECTRICIDAD', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (170, 2, '4', '20', '11', '4008', NULL, NULL, NULL, NULL, 'GASTOS DE IMPRENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (171, 2, '4', '20', '11', '5001', NULL, NULL, NULL, NULL, 'SERVICIO DE ASEO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (172, 2, '4', '20', '11', '5002', NULL, NULL, NULL, NULL, 'SERVICIO DE VIGILANCIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (173, 2, '4', '20', '11', '6001', NULL, NULL, NULL, NULL, 'SEGUROS DE CHEQUES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (174, 2, '4', '20', '11', '6002', NULL, NULL, NULL, NULL, 'SEGUROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (175, 2, '4', '20', '11', '7001', NULL, NULL, NULL, NULL, 'COLACIÓN', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (176, 2, '4', '20', '11', '7002', NULL, NULL, NULL, NULL, 'CORRESPONDENCIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (177, 2, '4', '20', '11', '7003', NULL, NULL, NULL, NULL, 'ALARMA DE SEGURIDAD', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (178, 2, '4', '20', '11', '7004', NULL, NULL, NULL, NULL, 'TAG', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (179, 2, '4', '20', '11', '7005', NULL, NULL, NULL, NULL, 'ROPA DE TRABAJO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (180, 2, '4', '20', '11', '7006', NULL, NULL, NULL, NULL, 'GASTOS DE TV CABLE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (181, 2, '4', '20', '11', '7007', NULL, NULL, NULL, NULL, 'GASTOS DE DICOM', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (182, 2, '4', '20', '11', '7008', NULL, NULL, NULL, NULL, 'GASTOS DE DOMINIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (183, 2, '4', '20', '11', '7009', NULL, NULL, NULL, NULL, 'FLETES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (184, 2, '4', '20', '11', '7010', NULL, NULL, NULL, NULL, 'GPS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (185, 2, '4', '20', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS GASTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (186, 2, '4', '20', '13', '0000', NULL, NULL, NULL, NULL, 'COSTOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (187, 2, '4', '20', '13', '1001', NULL, NULL, NULL, NULL, 'GASTOS POR LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (188, 2, '4', '20', '13', '1002', NULL, NULL, NULL, NULL, 'GASTOS BANCARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (189, 2, '4', '20', '13', '1003', NULL, NULL, NULL, NULL, 'GASTOS POR PROTESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (190, 2, '4', '20', '13', '2001', NULL, NULL, NULL, NULL, 'INTERESES BANCARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (191, 2, '4', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACION EN RESULTADO POR INVERSIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (192, 2, '4', '20', '15', '0000', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (193, 2, '4', '20', '15', '1001', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (194, 2, '4', '20', '16', '0000', NULL, NULL, NULL, NULL, 'RESULTADO POR UNIDADES DE REAJUSTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (195, 2, '4', '20', '16', '1001', NULL, NULL, NULL, NULL, 'REAJUSTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (196, 2, '4', '20', '17', '0000', NULL, NULL, NULL, NULL, 'GASTOS POR IMPUESTO A LA RENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (197, 2, '4', '20', '17', '1001', NULL, NULL, NULL, NULL, 'IMPUESTO A LA RENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (198, 2, '5', '00', '00', '0000', NULL, NULL, NULL, NULL, 'CUENTAS DE ORDEN Y TRASPASOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (199, 3, '1', '00', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (200, 3, '1', '10', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS CORRIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (201, 3, '1', '10', '10', '0000', NULL, NULL, NULL, NULL, 'EFECTIVO Y EQUIVALENTE AL EFECTIVO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (202, 3, '1', '10', '10', '1001', NULL, NULL, NULL, NULL, 'CAJA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (203, 3, '1', '10', '10', '1002', NULL, NULL, NULL, NULL, 'FONDO FIJO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (204, 3, '1', '10', '10', '2001', NULL, NULL, NULL, NULL, 'BANCO SANTANDER', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (205, 3, '1', '10', '10', '2002', NULL, NULL, NULL, NULL, 'BANCO DE CHILE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (206, 3, '1', '10', '10', '2003', NULL, NULL, NULL, NULL, 'BANCO BBVA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (207, 3, '1', '10', '10', '2004', NULL, NULL, NULL, NULL, 'BANCO BCI', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (208, 3, '1', '10', '10', '2005', NULL, NULL, NULL, NULL, 'BANCO ITAU', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (209, 3, '1', '10', '10', '2006', NULL, NULL, NULL, NULL, 'BANCO SECURITY', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (210, 3, '1', '10', '10', '2007', NULL, NULL, NULL, NULL, 'BANCO SANTANDER DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (211, 3, '1', '10', '10', '2008', NULL, NULL, NULL, NULL, 'BANCO DE CHILE DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (212, 3, '1', '10', '10', '2009', NULL, NULL, NULL, NULL, 'BANCO BBVA DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (213, 3, '1', '10', '10', '2010', NULL, NULL, NULL, NULL, 'BANCO BCI DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (214, 3, '1', '10', '10', '2011', NULL, NULL, NULL, NULL, 'BANCO ITAU DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (215, 3, '1', '10', '10', '2012', NULL, NULL, NULL, NULL, 'BANCO SECURITY DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (216, 3, '1', '10', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (217, 3, '1', '10', '11', '0001', NULL, NULL, NULL, NULL, 'DEPOSITOS A PLAZO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (218, 3, '1', '10', '11', '1002', NULL, NULL, NULL, NULL, 'FONDOS MUTUOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (219, 3, '1', '10', '11', '1003', NULL, NULL, NULL, NULL, 'PACTOS RETROVENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (220, 3, '1', '10', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (221, 3, '1', '10', '13', '0000', NULL, NULL, NULL, NULL, 'DEUDORES COMERCIALES Y OTRAS CUENTAS POR COBRAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (222, 3, '1', '10', '13', '1001', NULL, NULL, NULL, NULL, 'CLIENTES NACIONALES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (223, 3, '1', '10', '13', '1002', NULL, NULL, NULL, NULL, 'CLIENTES EXTRANJEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (224, 3, '1', '10', '13', '1003', NULL, NULL, NULL, NULL, 'CHEQUES EN CARTERA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (225, 3, '1', '10', '13', '1004', NULL, NULL, NULL, NULL, 'TARJETA DE DEBITO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (226, 3, '1', '10', '13', '1005', NULL, NULL, NULL, NULL, 'TARJETA DE CREDITO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (227, 3, '1', '10', '13', '1006', NULL, NULL, NULL, NULL, 'CHEQUES PROTESTADOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (228, 3, '1', '10', '13', '1007', NULL, NULL, NULL, NULL, 'DOCUMENTOS PROTESTADOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (229, 3, '1', '10', '13', '2001', NULL, NULL, NULL, NULL, 'ESTIMACION DEUDORES INCOBRABLES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (230, 3, '1', '10', '13', '3001', NULL, NULL, NULL, NULL, 'FONDOS POR RENDIR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (231, 3, '1', '10', '13', '4001', NULL, NULL, NULL, NULL, 'PRESTAMOS AL PERSONAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (232, 3, '1', '10', '13', '5001', NULL, NULL, NULL, NULL, 'ANTICIPO DE SUELDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (233, 3, '1', '10', '13', '5002', NULL, NULL, NULL, NULL, 'ANTICIPO DE HONORARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (234, 3, '1', '10', '13', '5003', NULL, NULL, NULL, NULL, 'ANTICIPO A PROVEEDORES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (235, 3, '1', '10', '14', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (236, 3, '1', '10', '14', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA NACIONAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (237, 3, '1', '10', '14', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA EXTRANJERA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (238, 3, '1', '10', '15', '0000', NULL, NULL, NULL, NULL, 'INVENTARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (239, 3, '1', '10', '15', '1001', NULL, NULL, NULL, NULL, 'EXISTENCIA EN TRANSITO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (240, 3, '1', '10', '15', '1002', NULL, NULL, NULL, NULL, 'EXISTENCIAS EN PROCESO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (241, 3, '1', '10', '15', '2001', NULL, NULL, NULL, NULL, 'EXISTENCIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (242, 3, '1', '10', '16', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (243, 3, '1', '10', '17', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (244, 3, '1', '10', '17', '1001', NULL, NULL, NULL, NULL, 'PAGOS PROVISIONALES MENSUALES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (245, 3, '1', '10', '17', '1002', NULL, NULL, NULL, NULL, 'IVA CREDITO FISCAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (246, 3, '1', '10', '17', '2001', NULL, NULL, NULL, NULL, 'OTROS IMPUESTOS POR RECUPERAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (247, 3, '1', '10', '19', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (248, 3, '1', '10', '19', '1001', NULL, NULL, NULL, NULL, 'ACTIVOS DISPONIBLES MANTENIDOS PARA LA VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (249, 3, '1', '10', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA DISTRIBUIR A PROPIETARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (250, 3, '1', '10', '21', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA O A DISTRIBUIR A LOS PROPIETARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (251, 3, '1', '20', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS NO CORRIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (252, 3, '1', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (253, 3, '1', '20', '10', '1001', NULL, NULL, NULL, NULL, 'SEGUROS PAGADOS POR ANTICIPADO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (254, 3, '1', '20', '10', '1002', NULL, NULL, NULL, NULL, 'ARRIENDOS PAGADOS POR ANTICIPADO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (255, 3, '1', '20', '10', '1003', NULL, NULL, NULL, NULL, 'OTROS GASTOS PAGADOS POR ANTICIPADO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (256, 3, '1', '20', '10', '1004', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (257, 3, '1', '20', '10', '2001', NULL, NULL, NULL, NULL, 'INTERESES DIFERIDOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (258, 3, '1', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (259, 3, '1', '20', '12', '0000', NULL, NULL, NULL, NULL, 'DERECHOS POR COBRAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (260, 3, '1', '20', '13', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (261, 3, '1', '20', '14', '0000', NULL, NULL, NULL, NULL, 'INVERSIONES POR METODO DE PARTICIPACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (262, 3, '1', '20', '15', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS INTANGIBLES DISTINTO A LA PLUSVALIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (263, 3, '1', '20', '16', '0000', NULL, NULL, NULL, NULL, 'PLUSVALIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (264, 3, '1', '20', '17', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES, PLANTAS Y EQUIPOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (265, 3, '1', '20', '17', '1001', NULL, NULL, NULL, NULL, 'TERRENOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (266, 3, '1', '20', '17', '2001', NULL, NULL, NULL, NULL, 'CONSTRUCCIONES E INTALACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (267, 3, '1', '20', '17', '3001', NULL, NULL, NULL, NULL, 'MUEBLES E UTILES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (268, 3, '1', '20', '17', '4001', NULL, NULL, NULL, NULL, 'VEHICULOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (269, 3, '1', '20', '17', '5001', NULL, NULL, NULL, NULL, 'EQUIPOS COMPUTACIONALES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (270, 3, '1', '20', '17', '6001', NULL, NULL, NULL, NULL, 'ACTIVOS EN LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (271, 3, '1', '20', '17', '7001', NULL, NULL, NULL, NULL, 'PROGRAMAS Y SOFTWARES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (272, 3, '1', '20', '17', '8001', NULL, NULL, NULL, NULL, 'DEPRECIACIÓN ACUMULADA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (273, 3, '1', '20', '18', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (274, 3, '1', '20', '19', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES DE INVERSION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (275, 3, '1', '20', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTO DIFERIDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (276, 3, '2', '00', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (277, 3, '2', '10', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CORRIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (278, 3, '2', '10', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (279, 3, '2', '10', '10', '1001', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON BANCOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (280, 3, '2', '10', '10', '1002', NULL, NULL, NULL, NULL, 'LÍNEAS DE CREDITO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (281, 3, '2', '10', '10', '1003', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (282, 3, '2', '10', '11', '0000', NULL, NULL, NULL, NULL, 'CUENTAS COMERCIALES Y OTRAS CUENTAS POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (283, 3, '2', '10', '11', '1001', NULL, NULL, NULL, NULL, 'PROVEEDORES NACIONALES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (284, 3, '2', '10', '11', '1002', NULL, NULL, NULL, NULL, 'PROVEEDORES EXTRANJEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (285, 3, '2', '10', '11', '1003', NULL, NULL, NULL, NULL, 'CHEQUES POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (286, 3, '2', '10', '11', '1004', NULL, NULL, NULL, NULL, 'HONORARIOS POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (287, 3, '2', '10', '11', '1005', NULL, NULL, NULL, NULL, 'ANTICIPOS DE CLIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (288, 3, '2', '10', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (289, 3, '2', '10', '12', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA NACIONAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (290, 3, '2', '10', '12', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA EXTRANJERA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (291, 3, '2', '10', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (292, 3, '2', '10', '13', '1001', NULL, NULL, NULL, NULL, 'PROVISIONES POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (293, 3, '2', '10', '13', '2001', NULL, NULL, NULL, NULL, 'PROVISION DE VACACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (294, 3, '2', '10', '13', '2002', NULL, NULL, NULL, NULL, 'PROVISIONES VARIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (295, 3, '2', '10', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (296, 3, '2', '10', '14', '1001', NULL, NULL, NULL, NULL, 'IVA DEBITO FISCAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (297, 3, '2', '10', '14', '1002', NULL, NULL, NULL, NULL, 'IVA POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (298, 3, '2', '10', '14', '1003', NULL, NULL, NULL, NULL, 'RETENCION 1° CATEGORIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (299, 3, '2', '10', '14', '1004', NULL, NULL, NULL, NULL, 'RETENCION 2° CATEGORIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (300, 3, '2', '10', '14', '1005', NULL, NULL, NULL, NULL, 'PPM POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (301, 3, '2', '10', '14', '2001', NULL, NULL, NULL, NULL, 'PROVISION IMPUESTO A LA RENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (302, 3, '2', '10', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A EMPLEADOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (303, 3, '2', '10', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (304, 3, '2', '10', '18', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CLASIFICADOS COMO MANTENIDOS PARA LA VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (305, 3, '2', '20', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS NO CORRIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (306, 3, '2', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (307, 3, '2', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS CUENTAS POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (308, 3, '2', '20', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (309, 3, '2', '20', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (310, 3, '2', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS DIFERIDOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (311, 3, '2', '20', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A LOS EMPLEADOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (312, 3, '2', '20', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (313, 3, '2', '30', '00', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO  ', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (314, 3, '2', '30', '10', '0000', NULL, NULL, NULL, NULL, 'CAPITAL EMITIDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (315, 3, '2', '30', '10', '0001', NULL, NULL, NULL, NULL, 'CAPITAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (316, 3, '2', '30', '11', '0000', NULL, NULL, NULL, NULL, 'GANANCIAS (PERDIDAS) ACUMULADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (317, 3, '2', '30', '11', '0001', NULL, NULL, NULL, NULL, 'RESULTADO ACUMULADO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (318, 3, '2', '30', '12', '0000', NULL, NULL, NULL, NULL, 'PRIMAS DE EMISION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (319, 3, '2', '30', '13', '0000', NULL, NULL, NULL, NULL, 'ACCIONES PROPIAS EN CARTERA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (320, 3, '2', '30', '14', '0000', NULL, NULL, NULL, NULL, 'OTRAS PARTICIPACIONES EN EL PATRIMONIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (321, 3, '2', '30', '15', '0000', NULL, NULL, NULL, NULL, 'OTRAS RESERVAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (322, 3, '2', '30', '16', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO ATRIBUIBLE A PROPIETARIOS DE LA CONTROLADORA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (323, 3, '2', '30', '17', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACIONES NO CONTROLADORAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (324, 3, '3', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO GANANCIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (325, 3, '3', '10', '10', '0000', NULL, NULL, NULL, NULL, 'INGRESOS DE ACTIVIDADES ORDINARIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (326, 3, '3', '10', '10', '1001', NULL, NULL, NULL, NULL, 'VENTA DE GRUAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (327, 3, '3', '10', '10', '1002', NULL, NULL, NULL, NULL, 'VENTA DE ACCESORIAS DE GRUAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (328, 3, '3', '10', '10', '1003', NULL, NULL, NULL, NULL, 'VENTA DE PLATAFORMAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (329, 3, '3', '10', '10', '1004', NULL, NULL, NULL, NULL, 'VENTA DE REPUESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (330, 3, '3', '10', '10', '1005', NULL, NULL, NULL, NULL, 'VENTA DE SERVICIO TECNICO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (331, 3, '3', '10', '10', '1006', NULL, NULL, NULL, NULL, 'VENTA DE LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (332, 3, '3', '10', '10', '2001', NULL, NULL, NULL, NULL, 'ARRIENDOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (333, 3, '3', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS INGRESOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (334, 3, '3', '20', '10', '1001', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (335, 3, '3', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS GANANCIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (336, 3, '3', '20', '12', '0000', NULL, NULL, NULL, NULL, 'INGRESOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (337, 3, '4', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO PERDIDA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (338, 3, '4', '10', '00', '0000', NULL, NULL, NULL, NULL, 'COSTO DE VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (339, 3, '4', '10', '10', '1001', NULL, NULL, NULL, NULL, 'COSTO DE GRUAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (340, 3, '4', '10', '10', '1002', NULL, NULL, NULL, NULL, 'COSTO DE ACCESORIAS DE GRUAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (341, 3, '4', '10', '10', '1003', NULL, NULL, NULL, NULL, 'COSTO DE PLATAFORMAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (342, 3, '4', '10', '10', '1004', NULL, NULL, NULL, NULL, 'COSTO DE REPUESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (343, 3, '4', '10', '10', '1005', NULL, NULL, NULL, NULL, 'COSTO DE SERVICIO TECNICO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (344, 3, '4', '10', '10', '1006', NULL, NULL, NULL, NULL, 'COSTO DE LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (345, 3, '4', '10', '10', '2001', NULL, NULL, NULL, NULL, 'COSTO DE ARRIENDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (346, 3, '4', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS COSTOS DE EXPLOTACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (347, 3, '4', '20', '11', '0000', NULL, NULL, NULL, NULL, 'GASTOS DE ADMINISTRACION Y VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (348, 3, '4', '20', '11', '1001', NULL, NULL, NULL, NULL, 'REMUNERACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (349, 3, '4', '20', '11', '1002', NULL, NULL, NULL, NULL, 'COMISIONES POR VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (350, 3, '4', '20', '11', '1003', NULL, NULL, NULL, NULL, 'FINIQUITOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (351, 3, '4', '20', '11', '2001', NULL, NULL, NULL, NULL, 'ASESORIA INFORMATICA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (352, 3, '4', '20', '11', '2002', NULL, NULL, NULL, NULL, 'ASESORIA COMEX', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (353, 3, '4', '20', '11', '2003', NULL, NULL, NULL, NULL, 'ASESORIA DE MARKETING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (354, 3, '4', '20', '11', '2004', NULL, NULL, NULL, NULL, 'ASESORIA LEGAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (355, 3, '4', '20', '11', '2005', NULL, NULL, NULL, NULL, 'ASESORIA CONTABLE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (356, 3, '4', '20', '11', '2006', NULL, NULL, NULL, NULL, 'ASESORIA TECNICA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (357, 3, '4', '20', '11', '3001', NULL, NULL, NULL, NULL, 'GASTOS DE PUBLICIDAD', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (358, 3, '4', '20', '11', '3002', NULL, NULL, NULL, NULL, 'GASTOS DE REPRESENTACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (359, 3, '4', '20', '11', '3003', NULL, NULL, NULL, NULL, 'VIAJES Y ESTADIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (360, 3, '4', '20', '11', '3004', NULL, NULL, NULL, NULL, 'FERIAS Y STAND', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (361, 3, '4', '20', '11', '4001', NULL, NULL, NULL, NULL, 'ARRIENDO DE OFICINAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (362, 3, '4', '20', '11', '4002', NULL, NULL, NULL, NULL, 'COMBUSTIBLE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (363, 3, '4', '20', '11', '4003', NULL, NULL, NULL, NULL, 'GASTOS DE OFICINA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (364, 3, '4', '20', '11', '4004', NULL, NULL, NULL, NULL, 'MANTENCION DE VEHICULOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (365, 3, '4', '20', '11', '4005', NULL, NULL, NULL, NULL, 'TELEFONOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (366, 3, '4', '20', '11', '4006', NULL, NULL, NULL, NULL, 'AGUA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (367, 3, '4', '20', '11', '4007', NULL, NULL, NULL, NULL, 'ELECTRICIDAD', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (368, 3, '4', '20', '11', '4008', NULL, NULL, NULL, NULL, 'GASTOS DE IMPRENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (369, 3, '4', '20', '11', '5001', NULL, NULL, NULL, NULL, 'SERVICIO DE ASEO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (370, 3, '4', '20', '11', '5002', NULL, NULL, NULL, NULL, 'SERVICIO DE VIGILANCIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (371, 3, '4', '20', '11', '6001', NULL, NULL, NULL, NULL, 'SEGUROS DE CHEQUES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (372, 3, '4', '20', '11', '6002', NULL, NULL, NULL, NULL, 'SEGUROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (373, 3, '4', '20', '11', '7001', NULL, NULL, NULL, NULL, 'COLACIÓN', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (374, 3, '4', '20', '11', '7002', NULL, NULL, NULL, NULL, 'CORRESPONDENCIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (375, 3, '4', '20', '11', '7003', NULL, NULL, NULL, NULL, 'ALARMA DE SEGURIDAD', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (376, 3, '4', '20', '11', '7004', NULL, NULL, NULL, NULL, 'TAG', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (377, 3, '4', '20', '11', '7005', NULL, NULL, NULL, NULL, 'ROPA DE TRABAJO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (378, 3, '4', '20', '11', '7006', NULL, NULL, NULL, NULL, 'GASTOS DE TV CABLE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (379, 3, '4', '20', '11', '7007', NULL, NULL, NULL, NULL, 'GASTOS DE DICOM', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (380, 3, '4', '20', '11', '7008', NULL, NULL, NULL, NULL, 'GASTOS DE DOMINIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (381, 3, '4', '20', '11', '7009', NULL, NULL, NULL, NULL, 'FLETES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (382, 3, '4', '20', '11', '7010', NULL, NULL, NULL, NULL, 'GPS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (383, 3, '4', '20', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS GASTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (384, 3, '4', '20', '13', '0000', NULL, NULL, NULL, NULL, 'COSTOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (385, 3, '4', '20', '13', '1001', NULL, NULL, NULL, NULL, 'GASTOS POR LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (386, 3, '4', '20', '13', '1002', NULL, NULL, NULL, NULL, 'GASTOS BANCARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (387, 3, '4', '20', '13', '1003', NULL, NULL, NULL, NULL, 'GASTOS POR PROTESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (388, 3, '4', '20', '13', '2001', NULL, NULL, NULL, NULL, 'INTERESES BANCARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (389, 3, '4', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACION EN RESULTADO POR INVERSIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (390, 3, '4', '20', '15', '0000', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (391, 3, '4', '20', '15', '1001', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (392, 3, '4', '20', '16', '0000', NULL, NULL, NULL, NULL, 'RESULTADO POR UNIDADES DE REAJUSTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (393, 3, '4', '20', '16', '1001', NULL, NULL, NULL, NULL, 'REAJUSTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (394, 3, '4', '20', '17', '0000', NULL, NULL, NULL, NULL, 'GASTOS POR IMPUESTO A LA RENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (395, 3, '4', '20', '17', '1001', NULL, NULL, NULL, NULL, 'IMPUESTO A LA RENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (396, 3, '5', '00', '00', '0000', NULL, NULL, NULL, NULL, 'CUENTAS DE ORDEN Y TRASPASOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (397, 4, '1', '00', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (398, 4, '1', '10', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS CORRIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (399, 4, '1', '10', '10', '0000', NULL, NULL, NULL, NULL, 'EFECTIVO Y EQUIVALENTE AL EFECTIVO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (400, 4, '1', '10', '10', '1001', NULL, NULL, NULL, NULL, 'CAJA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (401, 4, '1', '10', '10', '1002', NULL, NULL, NULL, NULL, 'FONDO FIJO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (402, 4, '1', '10', '10', '2001', NULL, NULL, NULL, NULL, 'BANCO SANTANDER', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (403, 4, '1', '10', '10', '2002', NULL, NULL, NULL, NULL, 'BANCO DE CHILE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (404, 4, '1', '10', '10', '2003', NULL, NULL, NULL, NULL, 'BANCO BBVA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (405, 4, '1', '10', '10', '2004', NULL, NULL, NULL, NULL, 'BANCO BCI', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (406, 4, '1', '10', '10', '2005', NULL, NULL, NULL, NULL, 'BANCO ITAU', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (407, 4, '1', '10', '10', '2006', NULL, NULL, NULL, NULL, 'BANCO SECURITY', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (408, 4, '1', '10', '10', '2007', NULL, NULL, NULL, NULL, 'BANCO SANTANDER DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (409, 4, '1', '10', '10', '2008', NULL, NULL, NULL, NULL, 'BANCO DE CHILE DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (410, 4, '1', '10', '10', '2009', NULL, NULL, NULL, NULL, 'BANCO BBVA DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (411, 4, '1', '10', '10', '2010', NULL, NULL, NULL, NULL, 'BANCO BCI DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (412, 4, '1', '10', '10', '2011', NULL, NULL, NULL, NULL, 'BANCO ITAU DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (413, 4, '1', '10', '10', '2012', NULL, NULL, NULL, NULL, 'BANCO SECURITY DOLAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (414, 4, '1', '10', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (415, 4, '1', '10', '11', '0001', NULL, NULL, NULL, NULL, 'DEPOSITOS A PLAZO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (416, 4, '1', '10', '11', '1002', NULL, NULL, NULL, NULL, 'FONDOS MUTUOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (417, 4, '1', '10', '11', '1003', NULL, NULL, NULL, NULL, 'PACTOS RETROVENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (418, 4, '1', '10', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (419, 4, '1', '10', '13', '0000', NULL, NULL, NULL, NULL, 'DEUDORES COMERCIALES Y OTRAS CUENTAS POR COBRAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (420, 4, '1', '10', '13', '1001', NULL, NULL, NULL, NULL, 'CLIENTES NACIONALES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (421, 4, '1', '10', '13', '1002', NULL, NULL, NULL, NULL, 'CLIENTES EXTRANJEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (422, 4, '1', '10', '13', '1003', NULL, NULL, NULL, NULL, 'CHEQUES EN CARTERA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (423, 4, '1', '10', '13', '1004', NULL, NULL, NULL, NULL, 'TARJETA DE DEBITO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (424, 4, '1', '10', '13', '1005', NULL, NULL, NULL, NULL, 'TARJETA DE CREDITO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (425, 4, '1', '10', '13', '1006', NULL, NULL, NULL, NULL, 'CHEQUES PROTESTADOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (426, 4, '1', '10', '13', '1007', NULL, NULL, NULL, NULL, 'DOCUMENTOS PROTESTADOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (427, 4, '1', '10', '13', '2001', NULL, NULL, NULL, NULL, 'ESTIMACION DEUDORES INCOBRABLES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (428, 4, '1', '10', '13', '3001', NULL, NULL, NULL, NULL, 'FONDOS POR RENDIR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (429, 4, '1', '10', '13', '4001', NULL, NULL, NULL, NULL, 'PRESTAMOS AL PERSONAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (430, 4, '1', '10', '13', '5001', NULL, NULL, NULL, NULL, 'ANTICIPO DE SUELDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (431, 4, '1', '10', '13', '5002', NULL, NULL, NULL, NULL, 'ANTICIPO DE HONORARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (432, 4, '1', '10', '13', '5003', NULL, NULL, NULL, NULL, 'ANTICIPO A PROVEEDORES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (433, 4, '1', '10', '14', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (434, 4, '1', '10', '14', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA NACIONAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (435, 4, '1', '10', '14', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA EXTRANJERA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (436, 4, '1', '10', '15', '0000', NULL, NULL, NULL, NULL, 'INVENTARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (437, 4, '1', '10', '15', '1001', NULL, NULL, NULL, NULL, 'EXISTENCIA EN TRANSITO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (438, 4, '1', '10', '15', '1002', NULL, NULL, NULL, NULL, 'EXISTENCIAS EN PROCESO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (439, 4, '1', '10', '15', '2001', NULL, NULL, NULL, NULL, 'EXISTENCIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (440, 4, '1', '10', '16', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (441, 4, '1', '10', '17', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (442, 4, '1', '10', '17', '1001', NULL, NULL, NULL, NULL, 'PAGOS PROVISIONALES MENSUALES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (443, 4, '1', '10', '17', '1002', NULL, NULL, NULL, NULL, 'IVA CREDITO FISCAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (444, 4, '1', '10', '17', '2001', NULL, NULL, NULL, NULL, 'OTROS IMPUESTOS POR RECUPERAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (445, 4, '1', '10', '19', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (446, 4, '1', '10', '19', '1001', NULL, NULL, NULL, NULL, 'ACTIVOS DISPONIBLES MANTENIDOS PARA LA VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (447, 4, '1', '10', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA DISTRIBUIR A PROPIETARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (448, 4, '1', '10', '21', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA O A DISTRIBUIR A LOS PROPIETARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (449, 4, '1', '20', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS NO CORRIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (450, 4, '1', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (451, 4, '1', '20', '10', '1001', NULL, NULL, NULL, NULL, 'SEGUROS PAGADOS POR ANTICIPADO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (452, 4, '1', '20', '10', '1002', NULL, NULL, NULL, NULL, 'ARRIENDOS PAGADOS POR ANTICIPADO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (453, 4, '1', '20', '10', '1003', NULL, NULL, NULL, NULL, 'OTROS GASTOS PAGADOS POR ANTICIPADO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (454, 4, '1', '20', '10', '1004', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (455, 4, '1', '20', '10', '2001', NULL, NULL, NULL, NULL, 'INTERESES DIFERIDOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (456, 4, '1', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (457, 4, '1', '20', '12', '0000', NULL, NULL, NULL, NULL, 'DERECHOS POR COBRAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (458, 4, '1', '20', '13', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (459, 4, '1', '20', '14', '0000', NULL, NULL, NULL, NULL, 'INVERSIONES POR METODO DE PARTICIPACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (460, 4, '1', '20', '15', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS INTANGIBLES DISTINTO A LA PLUSVALIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (461, 4, '1', '20', '16', '0000', NULL, NULL, NULL, NULL, 'PLUSVALIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (462, 4, '1', '20', '17', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES, PLANTAS Y EQUIPOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (463, 4, '1', '20', '17', '1001', NULL, NULL, NULL, NULL, 'TERRENOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (464, 4, '1', '20', '17', '2001', NULL, NULL, NULL, NULL, 'CONSTRUCCIONES E INTALACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (465, 4, '1', '20', '17', '3001', NULL, NULL, NULL, NULL, 'MUEBLES E UTILES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (466, 4, '1', '20', '17', '4001', NULL, NULL, NULL, NULL, 'VEHICULOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (467, 4, '1', '20', '17', '5001', NULL, NULL, NULL, NULL, 'EQUIPOS COMPUTACIONALES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (468, 4, '1', '20', '17', '6001', NULL, NULL, NULL, NULL, 'ACTIVOS EN LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (469, 4, '1', '20', '17', '7001', NULL, NULL, NULL, NULL, 'PROGRAMAS Y SOFTWARES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (470, 4, '1', '20', '17', '8001', NULL, NULL, NULL, NULL, 'DEPRECIACIÓN ACUMULADA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (471, 4, '1', '20', '18', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (472, 4, '1', '20', '19', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES DE INVERSION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (473, 4, '1', '20', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTO DIFERIDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (474, 4, '2', '00', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (475, 4, '2', '10', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CORRIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (476, 4, '2', '10', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (477, 4, '2', '10', '10', '1001', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON BANCOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (478, 4, '2', '10', '10', '1002', NULL, NULL, NULL, NULL, 'LÍNEAS DE CREDITO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (479, 4, '2', '10', '10', '1003', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (480, 4, '2', '10', '11', '0000', NULL, NULL, NULL, NULL, 'CUENTAS COMERCIALES Y OTRAS CUENTAS POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (481, 4, '2', '10', '11', '1001', NULL, NULL, NULL, NULL, 'PROVEEDORES NACIONALES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (482, 4, '2', '10', '11', '1002', NULL, NULL, NULL, NULL, 'PROVEEDORES EXTRANJEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (483, 4, '2', '10', '11', '1003', NULL, NULL, NULL, NULL, 'CHEQUES POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (484, 4, '2', '10', '11', '1004', NULL, NULL, NULL, NULL, 'HONORARIOS POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (485, 4, '2', '10', '11', '1005', NULL, NULL, NULL, NULL, 'ANTICIPOS DE CLIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (486, 4, '2', '10', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (487, 4, '2', '10', '12', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA NACIONAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (488, 4, '2', '10', '12', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA EXTRANJERA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (489, 4, '2', '10', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (490, 4, '2', '10', '13', '1001', NULL, NULL, NULL, NULL, 'PROVISIONES POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (491, 4, '2', '10', '13', '2001', NULL, NULL, NULL, NULL, 'PROVISION DE VACACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (492, 4, '2', '10', '13', '2002', NULL, NULL, NULL, NULL, 'PROVISIONES VARIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (493, 4, '2', '10', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (494, 4, '2', '10', '14', '1001', NULL, NULL, NULL, NULL, 'IVA DEBITO FISCAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (495, 4, '2', '10', '14', '1002', NULL, NULL, NULL, NULL, 'IVA POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (496, 4, '2', '10', '14', '1003', NULL, NULL, NULL, NULL, 'RETENCION 1° CATEGORIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (497, 4, '2', '10', '14', '1004', NULL, NULL, NULL, NULL, 'RETENCION 2° CATEGORIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (498, 4, '2', '10', '14', '1005', NULL, NULL, NULL, NULL, 'PPM POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (499, 4, '2', '10', '14', '2001', NULL, NULL, NULL, NULL, 'PROVISION IMPUESTO A LA RENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (500, 4, '2', '10', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A EMPLEADOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (501, 4, '2', '10', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (502, 4, '2', '10', '18', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CLASIFICADOS COMO MANTENIDOS PARA LA VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (503, 4, '2', '20', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS NO CORRIENTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (504, 4, '2', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (505, 4, '2', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS CUENTAS POR PAGAR', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (506, 4, '2', '20', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (507, 4, '2', '20', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (508, 4, '2', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS DIFERIDOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (509, 4, '2', '20', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A LOS EMPLEADOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (510, 4, '2', '20', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (511, 4, '2', '30', '00', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO  ', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (512, 4, '2', '30', '10', '0000', NULL, NULL, NULL, NULL, 'CAPITAL EMITIDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (513, 4, '2', '30', '10', '0001', NULL, NULL, NULL, NULL, 'CAPITAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (514, 4, '2', '30', '11', '0000', NULL, NULL, NULL, NULL, 'GANANCIAS (PERDIDAS) ACUMULADAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (515, 4, '2', '30', '11', '0001', NULL, NULL, NULL, NULL, 'RESULTADO ACUMULADO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (516, 4, '2', '30', '12', '0000', NULL, NULL, NULL, NULL, 'PRIMAS DE EMISION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (517, 4, '2', '30', '13', '0000', NULL, NULL, NULL, NULL, 'ACCIONES PROPIAS EN CARTERA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (518, 4, '2', '30', '14', '0000', NULL, NULL, NULL, NULL, 'OTRAS PARTICIPACIONES EN EL PATRIMONIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (519, 4, '2', '30', '15', '0000', NULL, NULL, NULL, NULL, 'OTRAS RESERVAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (520, 4, '2', '30', '16', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO ATRIBUIBLE A PROPIETARIOS DE LA CONTROLADORA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (521, 4, '2', '30', '17', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACIONES NO CONTROLADORAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (522, 4, '3', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO GANANCIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (523, 4, '3', '10', '10', '0000', NULL, NULL, NULL, NULL, 'INGRESOS DE ACTIVIDADES ORDINARIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (524, 4, '3', '10', '10', '1001', NULL, NULL, NULL, NULL, 'VENTA DE GRUAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (525, 4, '3', '10', '10', '1002', NULL, NULL, NULL, NULL, 'VENTA DE ACCESORIAS DE GRUAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (526, 4, '3', '10', '10', '1003', NULL, NULL, NULL, NULL, 'VENTA DE PLATAFORMAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (527, 4, '3', '10', '10', '1004', NULL, NULL, NULL, NULL, 'VENTA DE REPUESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (528, 4, '3', '10', '10', '1005', NULL, NULL, NULL, NULL, 'VENTA DE SERVICIO TECNICO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (529, 4, '3', '10', '10', '1006', NULL, NULL, NULL, NULL, 'VENTA DE LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (530, 4, '3', '10', '10', '2001', NULL, NULL, NULL, NULL, 'ARRIENDOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (531, 4, '3', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS INGRESOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (532, 4, '3', '20', '10', '1001', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (533, 4, '3', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS GANANCIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (534, 4, '3', '20', '12', '0000', NULL, NULL, NULL, NULL, 'INGRESOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (535, 4, '4', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO PERDIDA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (536, 4, '4', '10', '00', '0000', NULL, NULL, NULL, NULL, 'COSTO DE VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (537, 4, '4', '10', '10', '1001', NULL, NULL, NULL, NULL, 'COSTO DE GRUAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (538, 4, '4', '10', '10', '1002', NULL, NULL, NULL, NULL, 'COSTO DE ACCESORIAS DE GRUAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (539, 4, '4', '10', '10', '1003', NULL, NULL, NULL, NULL, 'COSTO DE PLATAFORMAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (540, 4, '4', '10', '10', '1004', NULL, NULL, NULL, NULL, 'COSTO DE REPUESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (541, 4, '4', '10', '10', '1005', NULL, NULL, NULL, NULL, 'COSTO DE SERVICIO TECNICO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (542, 4, '4', '10', '10', '1006', NULL, NULL, NULL, NULL, 'COSTO DE LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (543, 4, '4', '10', '10', '2001', NULL, NULL, NULL, NULL, 'COSTO DE ARRIENDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (544, 4, '4', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS COSTOS DE EXPLOTACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (545, 4, '4', '20', '11', '0000', NULL, NULL, NULL, NULL, 'GASTOS DE ADMINISTRACION Y VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (546, 4, '4', '20', '11', '1001', NULL, NULL, NULL, NULL, 'REMUNERACIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (547, 4, '4', '20', '11', '1002', NULL, NULL, NULL, NULL, 'COMISIONES POR VENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (548, 4, '4', '20', '11', '1003', NULL, NULL, NULL, NULL, 'FINIQUITOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (549, 4, '4', '20', '11', '2001', NULL, NULL, NULL, NULL, 'ASESORIA INFORMATICA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (550, 4, '4', '20', '11', '2002', NULL, NULL, NULL, NULL, 'ASESORIA COMEX', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (551, 4, '4', '20', '11', '2003', NULL, NULL, NULL, NULL, 'ASESORIA DE MARKETING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (552, 4, '4', '20', '11', '2004', NULL, NULL, NULL, NULL, 'ASESORIA LEGAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (553, 4, '4', '20', '11', '2005', NULL, NULL, NULL, NULL, 'ASESORIA CONTABLE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (554, 4, '4', '20', '11', '2006', NULL, NULL, NULL, NULL, 'ASESORIA TECNICA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (555, 4, '4', '20', '11', '3001', NULL, NULL, NULL, NULL, 'GASTOS DE PUBLICIDAD', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (556, 4, '4', '20', '11', '3002', NULL, NULL, NULL, NULL, 'GASTOS DE REPRESENTACION', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (557, 4, '4', '20', '11', '3003', NULL, NULL, NULL, NULL, 'VIAJES Y ESTADIAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (558, 4, '4', '20', '11', '3004', NULL, NULL, NULL, NULL, 'FERIAS Y STAND', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (559, 4, '4', '20', '11', '4001', NULL, NULL, NULL, NULL, 'ARRIENDO DE OFICINAS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (560, 4, '4', '20', '11', '4002', NULL, NULL, NULL, NULL, 'COMBUSTIBLE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (561, 4, '4', '20', '11', '4003', NULL, NULL, NULL, NULL, 'GASTOS DE OFICINA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (562, 4, '4', '20', '11', '4004', NULL, NULL, NULL, NULL, 'MANTENCION DE VEHICULOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (563, 4, '4', '20', '11', '4005', NULL, NULL, NULL, NULL, 'TELEFONOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (564, 4, '4', '20', '11', '4006', NULL, NULL, NULL, NULL, 'AGUA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (565, 4, '4', '20', '11', '4007', NULL, NULL, NULL, NULL, 'ELECTRICIDAD', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (566, 4, '4', '20', '11', '4008', NULL, NULL, NULL, NULL, 'GASTOS DE IMPRENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (567, 4, '4', '20', '11', '5001', NULL, NULL, NULL, NULL, 'SERVICIO DE ASEO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (568, 4, '4', '20', '11', '5002', NULL, NULL, NULL, NULL, 'SERVICIO DE VIGILANCIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (569, 4, '4', '20', '11', '6001', NULL, NULL, NULL, NULL, 'SEGUROS DE CHEQUES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (570, 4, '4', '20', '11', '6002', NULL, NULL, NULL, NULL, 'SEGUROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (571, 4, '4', '20', '11', '7001', NULL, NULL, NULL, NULL, 'COLACIÓN', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (572, 4, '4', '20', '11', '7002', NULL, NULL, NULL, NULL, 'CORRESPONDENCIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (573, 4, '4', '20', '11', '7003', NULL, NULL, NULL, NULL, 'ALARMA DE SEGURIDAD', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (574, 4, '4', '20', '11', '7004', NULL, NULL, NULL, NULL, 'TAG', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (575, 4, '4', '20', '11', '7005', NULL, NULL, NULL, NULL, 'ROPA DE TRABAJO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (576, 4, '4', '20', '11', '7006', NULL, NULL, NULL, NULL, 'GASTOS DE TV CABLE', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (577, 4, '4', '20', '11', '7007', NULL, NULL, NULL, NULL, 'GASTOS DE DICOM', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (578, 4, '4', '20', '11', '7008', NULL, NULL, NULL, NULL, 'GASTOS DE DOMINIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (579, 4, '4', '20', '11', '7009', NULL, NULL, NULL, NULL, 'FLETES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (580, 4, '4', '20', '11', '7010', NULL, NULL, NULL, NULL, 'GPS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (581, 4, '4', '20', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS GASTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (582, 4, '4', '20', '13', '0000', NULL, NULL, NULL, NULL, 'COSTOS FINANCIEROS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (583, 4, '4', '20', '13', '1001', NULL, NULL, NULL, NULL, 'GASTOS POR LEASING', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (584, 4, '4', '20', '13', '1002', NULL, NULL, NULL, NULL, 'GASTOS BANCARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (585, 4, '4', '20', '13', '1003', NULL, NULL, NULL, NULL, 'GASTOS POR PROTESTOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (586, 4, '4', '20', '13', '2001', NULL, NULL, NULL, NULL, 'INTERESES BANCARIOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (587, 4, '4', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACION EN RESULTADO POR INVERSIONES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (588, 4, '4', '20', '15', '0000', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (589, 4, '4', '20', '15', '1001', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (590, 4, '4', '20', '16', '0000', NULL, NULL, NULL, NULL, 'RESULTADO POR UNIDADES DE REAJUSTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (591, 4, '4', '20', '16', '1001', NULL, NULL, NULL, NULL, 'REAJUSTES', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (592, 4, '4', '20', '17', '0000', NULL, NULL, NULL, NULL, 'GASTOS POR IMPUESTO A LA RENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (593, 4, '4', '20', '17', '1001', NULL, NULL, NULL, NULL, 'IMPUESTO A LA RENTA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (594, 4, '5', '00', '00', '0000', NULL, NULL, NULL, NULL, 'CUENTAS DE ORDEN Y TRASPASOS', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);


--
-- Data for Name: programas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO programas VALUES (1, NULL, 'Personales', NULL, 'Personales', 1);
INSERT INTO programas VALUES (2, 1, 'Mantención datos personales', 'principales/en-construccion', 'Mantención datos personales', 1);
INSERT INTO programas VALUES (3, 1, 'Cambio clave acceso', 'principales/en-construccion', 'Cambio clave acceso', 2);
INSERT INTO programas VALUES (4, NULL, 'Adm. sistema', NULL, 'Administración sistema', 2);
INSERT INTO programas VALUES (5, 4, 'Mantención grupos empresariales', 'grupos-empresariales', 'Mantención grupos empresariales', 1);
INSERT INTO programas VALUES (6, NULL, 'Adm. holding', NULL, 'Administración holding', 3);
INSERT INTO programas VALUES (7, 6, 'Mantención empresas', 'empresas', 'Mantención empresas', 1);
INSERT INTO programas VALUES (8, 6, 'Mantención personas', 'personas', 'Mantención personas', 2);
INSERT INTO programas VALUES (9, 6, 'Mantención usuarios', 'principales/en-construccion', 'Mantención usuarios', 3);
INSERT INTO programas VALUES (10, 6, 'Mantención parametros', 'principales/en-construccion', 'Mantención parametros', 4);
INSERT INTO programas VALUES (11, 6, 'Mantención plan de cuentas', 'mantplancta', 'Mantención plan de cuentas', 5);
INSERT INTO programas VALUES (12, 6, 'Mantención rubros', 'principales/en-construccion', 'Mantención rubros', 6);
INSERT INTO programas VALUES (13, 6, 'Mantención tipos documentos legales', 'principales/en-construccion', 'Mantención tipos documentos legales', 7);
INSERT INTO programas VALUES (14, 6, 'Mantención estados documentos legales', 'principales/en-construccion', 'Mantención estados documentos legales', 8);
INSERT INTO programas VALUES (15, NULL, 'Legales', NULL, 'Legales', 4);
INSERT INTO programas VALUES (16, 15, 'Legales 1', 'principales/en-construccion', 'Legales 1', 1);
INSERT INTO programas VALUES (17, 15, 'Legales 2', 'principales/en-construccion', 'Legales 2', 2);
INSERT INTO programas VALUES (18, 15, 'Legales 3', 'principales/en-construccion', 'Legales 3', 3);
INSERT INTO programas VALUES (19, 15, 'Legales 4', 'principales/en-construccion', 'Legales 4', 4);
INSERT INTO programas VALUES (20, 15, 'Legales 5', 'principales/en-construccion', 'Legales 5', 5);
INSERT INTO programas VALUES (21, NULL, 'Honorarios', NULL, 'Honorarios', 5);
INSERT INTO programas VALUES (22, 21, 'Honorarios 1', 'principales/en-construccion', 'Honorarios 1', 1);
INSERT INTO programas VALUES (23, 21, 'Honorarios 2', 'principales/en-construccion', 'Honorarios 2', 2);
INSERT INTO programas VALUES (24, 21, 'Honorarios 3', 'principales/en-construccion', 'Honorarios 3', 3);
INSERT INTO programas VALUES (25, 21, 'Honorarios 4', 'principales/en-construccion', 'Honorarios 4', 4);
INSERT INTO programas VALUES (26, 21, 'Honorarios 5', 'principales/en-construccion', 'Honorarios 5', 5);
INSERT INTO programas VALUES (27, NULL, 'Rendiciones', NULL, 'Rendiciones', 6);
INSERT INTO programas VALUES (28, 27, 'Rendiciones 1', 'principales/en-construccion', 'Rendiciones 1', 1);
INSERT INTO programas VALUES (29, 27, 'Rendiciones 2', 'principales/en-construccion', 'Rendiciones 2', 2);
INSERT INTO programas VALUES (30, 27, 'Rendiciones 3', 'principales/en-construccion', 'Rendiciones 3', 3);
INSERT INTO programas VALUES (31, 27, 'Rendiciones 4', 'principales/en-construccion', 'Rendiciones 4', 4);
INSERT INTO programas VALUES (32, 27, 'Rendiciones 5', 'principales/en-construccion', 'Rendiciones 5', 5);
INSERT INTO programas VALUES (33, NULL, 'Compras', NULL, 'Compras', 7);
INSERT INTO programas VALUES (34, 33, 'Compras 1', 'principales/en-construccion', 'Compras 1', 1);
INSERT INTO programas VALUES (35, 33, 'Compras 2', 'principales/en-construccion', 'Compras 2', 2);
INSERT INTO programas VALUES (36, 33, 'Compras 3', 'principales/en-construccion', 'Compras 3', 3);
INSERT INTO programas VALUES (37, 33, 'Compras 4', 'principales/en-construccion', 'Compras 4', 4);
INSERT INTO programas VALUES (38, 33, 'Compras 5', 'principales/en-construccion', 'Compras 5', 5);
INSERT INTO programas VALUES (39, NULL, 'Ventas', NULL, 'Ventas', 8);
INSERT INTO programas VALUES (40, 39, 'Ventas 1', 'principales/en-construccion', 'Ventas 1', 1);
INSERT INTO programas VALUES (41, 39, 'Ventas 2', 'principales/en-construccion', 'Ventas 2', 2);
INSERT INTO programas VALUES (42, 39, 'Ventas 3', 'principales/en-construccion', 'Ventas 3', 3);
INSERT INTO programas VALUES (43, 39, 'Ventas 4', 'principales/en-construccion', 'Ventas 4', 4);
INSERT INTO programas VALUES (44, 39, 'Ventas 5', 'principales/en-construccion', 'Ventas 5', 5);
INSERT INTO programas VALUES (45, NULL, 'Contabilidad', NULL, 'Contabilidad', 9);
INSERT INTO programas VALUES (46, 45, 'Contabilidad 1', 'principales/en-construccion', 'Contabilidad 1', 1);
INSERT INTO programas VALUES (47, 45, 'Contabilidad 2', 'principales/en-construccion', 'Contabilidad 2', 2);
INSERT INTO programas VALUES (48, 45, 'Contabilidad 3', 'principales/en-construccion', 'Contabilidad 3', 3);
INSERT INTO programas VALUES (49, 45, 'Contabilidad 4', 'principales/en-construccion', 'Contabilidad 4', 4);
INSERT INTO programas VALUES (50, 45, 'Contabilidad 5', 'principales/en-construccion', 'Contabilidad 5', 5);
INSERT INTO programas VALUES (51, NULL, 'Cambiar emp./perf.', 'sel-perfil', 'Cambiar empresa/perfil', 10);


--
-- Data for Name: proyectos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO proyectos VALUES (1, 2, 'ALTO MAIPO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (2, 2, 'GRAN SANTIAGO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (3, 2, 'PARQUE INDUSTRIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (4, 2, 'CARCEL CONCESIONADA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (5, 2, 'FRUTICOLA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (6, 2, 'METRO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (7, 3, 'ALTO MAIPO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (8, 3, 'GRAN SANTIAGO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (9, 3, 'PARQUE INDUSTRIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (10, 3, 'CARCEL CONCESIONADA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (11, 3, 'FRUTICOLA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (12, 3, 'METRO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (13, 4, 'ALTO MAIPO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (14, 4, 'GRAN SANTIAGO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (15, 4, 'PARQUE INDUSTRIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (16, 4, 'CARCEL CONCESIONADA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (17, 4, 'FRUTICOLA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (18, 4, 'METRO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (19, 5, 'ALTO MAIPO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (20, 5, 'GRAN SANTIAGO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (21, 5, 'PARQUE INDUSTRIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (22, 5, 'CARCEL CONCESIONADA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (23, 5, 'FRUTICOLA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (24, 5, 'METRO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (25, 6, 'ALTO MAIPO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (26, 6, 'GRAN SANTIAGO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (27, 6, 'PARQUE INDUSTRIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (28, 6, 'CARCEL CONCESIONADA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (29, 6, 'FRUTICOLA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (30, 6, 'METRO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (31, 7, 'ALTO MAIPO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (32, 7, 'GRAN SANTIAGO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (33, 7, 'PARQUE INDUSTRIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (34, 7, 'CARCEL CONCESIONADA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (35, 7, 'FRUTICOLA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (36, 7, 'METRO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (37, 8, 'ALTO MAIPO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (38, 8, 'GRAN SANTIAGO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (39, 8, 'PARQUE INDUSTRIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (40, 8, 'CARCEL CONCESIONADA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (41, 8, 'FRUTICOLA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (42, 8, 'METRO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (43, 9, 'ALTO MAIPO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (44, 9, 'GRAN SANTIAGO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (45, 9, 'PARQUE INDUSTRIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (46, 9, 'CARCEL CONCESIONADA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (47, 9, 'FRUTICOLA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (48, 9, 'METRO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (49, 10, 'ALTO MAIPO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (50, 10, 'GRAN SANTIAGO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (51, 10, 'PARQUE INDUSTRIAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (52, 10, 'CARCEL CONCESIONADA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (53, 10, 'FRUTICOLA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (54, 10, 'METRO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);


--
-- Data for Name: rubros; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO rubros VALUES (1, 1, 'CONSULTORIA');
INSERT INTO rubros VALUES (2, 2, 'CONSULTORIA');
INSERT INTO rubros VALUES (3, 2, 'AUTOMOTRIZ');
INSERT INTO rubros VALUES (4, 2, 'INDUSTRIAL');
INSERT INTO rubros VALUES (5, 2, 'INVERSIONES');
INSERT INTO rubros VALUES (6, 2, 'AGRICOLA');
INSERT INTO rubros VALUES (7, 2, 'FARMACEUTICO');
INSERT INTO rubros VALUES (8, 2, 'LOGISTICA');
INSERT INTO rubros VALUES (9, 2, 'AMASANDERIA');
INSERT INTO rubros VALUES (11, 3, 'CONSULTORIA');
INSERT INTO rubros VALUES (12, 3, 'AUTOMOTRIZ');
INSERT INTO rubros VALUES (13, 3, 'INDUSTRIAL');
INSERT INTO rubros VALUES (14, 3, 'INVERSIONES');
INSERT INTO rubros VALUES (15, 3, 'AGRICOLA');
INSERT INTO rubros VALUES (16, 3, 'FARMACEUTICO');
INSERT INTO rubros VALUES (17, 3, 'LOGISTICA');
INSERT INTO rubros VALUES (18, 3, 'AMASANDERIA');
INSERT INTO rubros VALUES (19, 4, 'CONSULTORIA');
INSERT INTO rubros VALUES (20, 4, 'AUTOMOTRIZ');
INSERT INTO rubros VALUES (21, 4, 'INDUSTRIAL');
INSERT INTO rubros VALUES (22, 4, 'INVERSIONES');
INSERT INTO rubros VALUES (23, 4, 'AGRICOLA');
INSERT INTO rubros VALUES (24, 4, 'FARMACEUTICO');
INSERT INTO rubros VALUES (25, 4, 'LOGISTICA');
INSERT INTO rubros VALUES (26, 4, 'AMASANDERIA');


--
-- Data for Name: sexos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO sexos VALUES (1, 'M', 'MASCULINO');
INSERT INTO sexos VALUES (2, 'F', 'FEMENINO');


--
-- Data for Name: solicitudes_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: tareas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tareas VALUES (1, 2, 'TAREA PRINCIPAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (2, 2, 'TAREA SECUNDARIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (3, 2, 'OTRA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (4, 2, 'ULTIMA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (5, 3, 'TAREA PRINCIPAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (6, 3, 'TAREA SECUNDARIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (7, 3, 'OTRA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (8, 3, 'ULTIMA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (9, 4, 'TAREA PRINCIPAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (10, 4, 'TAREA SECUNDARIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (11, 4, 'OTRA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (12, 4, 'ULTIMA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (13, 5, 'TAREA PRINCIPAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (14, 5, 'TAREA SECUNDARIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (15, 5, 'OTRA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (16, 5, 'ULTIMA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (17, 6, 'TAREA PRINCIPAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (18, 6, 'TAREA SECUNDARIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (19, 6, 'OTRA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (20, 6, 'ULTIMA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (21, 7, 'TAREA PRINCIPAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (22, 7, 'TAREA SECUNDARIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (23, 7, 'OTRA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (24, 7, 'ULTIMA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (25, 8, 'TAREA PRINCIPAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (26, 8, 'TAREA SECUNDARIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (27, 8, 'OTRA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (28, 8, 'ULTIMA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (29, 9, 'TAREA PRINCIPAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (30, 9, 'TAREA SECUNDARIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (31, 9, 'OTRA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (32, 9, 'ULTIMA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (33, 10, 'TAREA PRINCIPAL', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (34, 10, 'TAREA SECUNDARIA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (35, 10, 'OTRA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (36, 10, 'ULTIMA TAREA', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);


--
-- Data for Name: tipos_documentos_legales; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tipos_documentos_legales VALUES (1, 2, 'CONSTITUCION DE SOCIEDAD', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (2, 2, 'ACTA DE DIRECTORIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (3, 2, 'SESION DE DIRECTORIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (4, 2, 'CONTRATO DE ARRIENDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (5, 3, 'CONSTITUCION DE SOCIEDAD', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (6, 3, 'ACTA DE DIRECTORIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (7, 3, 'SESION DE DIRECTORIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (8, 3, 'CONTRATO DE ARRIENDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (9, 4, 'CONSTITUCION DE SOCIEDAD', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (10, 4, 'ACTA DE DIRECTORIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (11, 4, 'SESION DE DIRECTORIO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (12, 4, 'CONTRATO DE ARRIENDO', 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);


--
-- Data for Name: tipos_formas_pagos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tipos_formas_pagos VALUES (1, 'CONTADO');
INSERT INTO tipos_formas_pagos VALUES (2, 'CHEQUE');
INSERT INTO tipos_formas_pagos VALUES (3, 'VALE VISTA');
INSERT INTO tipos_formas_pagos VALUES (4, 'OTRO');


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO usuarios VALUES (1, 'ADMIN', '12345', 1, 1, 1, '2017-09-23 22:33:59.553719', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (2, 'ROSILVA', '12345', 2, 1, 1, '2017-09-23 22:33:59.820891', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (3, 'SEAGUIRRE', '12345', 3, 1, 1, '2017-09-23 22:33:59.82923', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (4, 'JJMONSALVE', '12345', 4, 1, 1, '2017-09-23 22:33:59.837523', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (5, 'JABORZONE', '12345', 5, 1, 1, '2017-09-23 22:33:59.845846', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (6, 'ROCIFUENTES', '12345', 6, 1, 1, '2017-09-23 22:33:59.854161', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (7, 'RQUEZADAA', '12345', 7, 2, 1, '2017-09-23 22:33:59.862493', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (8, 'OSOLARM', '12345', 8, 1, 1, '2017-09-23 22:33:59.870806', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (9, 'NSALAZARG', '12345', 9, 1, 1, '2017-09-23 22:33:59.87913', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (10, 'CPALMAA', '12345', 10, 1, 1, '2017-09-23 22:33:59.887656', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (11, 'JCISTERNAF', '12345', 11, 1, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (12, 'UAT', '12345', 12, 1, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);


--
-- Data for Name: usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO usuarios_perfiles VALUES (1, 1, 1, NULL, NULL, 1, 1, '2017-09-23 22:34:00.054021', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (2, 2, 1, NULL, NULL, 1, 1, '2017-09-23 22:34:00.062448', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (3, 3, 1, NULL, NULL, 1, 1, '2017-09-23 22:34:00.070734', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (4, 4, 1, NULL, NULL, 1, 1, '2017-09-23 22:34:00.079039', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (5, 5, 1, NULL, NULL, 1, 1, '2017-09-23 22:34:00.08736', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (6, 6, 1, NULL, NULL, 1, 1, '2017-09-23 22:34:00.095684', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (7, 7, 1, NULL, NULL, 1, 1, '2017-09-23 22:34:00.104006', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (8, 8, 1, NULL, NULL, 1, 1, '2017-09-23 22:34:00.112344', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (9, 9, 1, NULL, NULL, 1, 1, '2017-09-23 22:34:00.120722', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (10, 10, 1, NULL, NULL, 1, 1, '2017-09-23 22:34:00.129091', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (11, 11, 8, NULL, 2, 1, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (12, 11, 12, NULL, 3, 1, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (13, 11, 15, NULL, 4, 1, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (14, 11, 17, NULL, 5, 1, 1, '2017-09-23 22:34:01.834262', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (15, 12, 19, NULL, 1, 1, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (16, 2, 19, NULL, 1, 1, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (17, 3, 19, NULL, 1, 1, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (18, 4, 19, NULL, 1, 1, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (19, 5, 19, NULL, 1, 1, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (20, 6, 19, NULL, 1, 1, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (21, 7, 19, NULL, 1, 1, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (22, 8, 19, NULL, 1, 1, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (23, 9, 19, NULL, 1, 1, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (24, 10, 19, NULL, 1, 1, 1, '2017-09-23 22:34:02.137725', NULL, NULL, NULL, NULL);


--
-- Data for Name: valores_paises; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO valores_paises VALUES (1, 1, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUT', 1, '2017-09-23 22:34:00.22946', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (2, 1, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2017-09-23 22:34:00.237825', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (3, 1, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUT', 1, '2017-09-23 22:34:00.246132', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (4, 1, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2017-09-23 22:34:00.254439', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (5, 1, 'RETHON', 'RETENCION HONORARIOS', '% RETENCION DE HONORARIOS EN ESTE PAIS', '10', 1, '2017-09-23 22:34:00.26275', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (6, 1, 'NUMUNIT', 'NRO. UNIDADES TERRITORIALES', 'NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS', '3', 1, '2017-09-23 22:34:00.271358', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (7, 1, 'UNITER1', 'UNIDAD TERRITORIAL ORDEN 1', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 1', 'REGION', 1, '2017-09-23 22:34:00.279415', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (8, 1, 'UNITER2', 'UNIDAD TERRITORIAL ORDEN 2', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 2', 'PROVINCIA', 1, '2017-09-23 22:34:00.287714', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (9, 1, 'UNITER3', 'UNIDAD TERRITORIAL ORDEN 3', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 3', 'COMUNA', 1, '2017-09-23 22:34:00.296038', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (10, 2, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'DNI', 1, '2017-09-23 22:34:00.304381', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (11, 2, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2017-09-23 22:34:00.312685', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (12, 2, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUT', 1, '2017-09-23 22:34:00.321132', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (13, 2, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2017-09-23 22:34:00.32945', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (14, 2, 'RETHON', 'RETENCION HONORARIOS', '% RETENCION DE HONORARIOS EN ESTE PAIS', '10', 1, '2017-09-23 22:34:00.33776', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (15, 3, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2017-09-23 22:34:00.346094', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (16, 3, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2017-09-23 22:34:00.354414', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (17, 3, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2017-09-23 22:34:00.362725', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (18, 3, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2017-09-23 22:34:00.371046', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (19, 3, 'RETHON', 'RETENCION HONORARIOS', '% RETENCION DE HONORARIOS EN ESTE PAIS', '10', 1, '2017-09-23 22:34:00.37937', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (20, 4, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2017-09-23 22:34:00.387692', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (21, 4, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2017-09-23 22:34:00.396012', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (22, 4, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2017-09-23 22:34:00.40434', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (23, 4, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2017-09-23 22:34:00.412661', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (24, 4, 'RETHON', 'RETENCION HONORARIOS', '% RETENCION DE HONORARIOS EN ESTE PAIS', '10', 1, '2017-09-23 22:34:00.42098', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (25, 5, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2017-09-23 22:34:00.42931', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (26, 5, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2017-09-23 22:34:00.437626', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (27, 5, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2017-09-23 22:34:00.445954', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (28, 5, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2017-09-23 22:34:00.454446', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (29, 5, 'RETHON', 'RETENCION HONORARIOS', '% RETENCION DE HONORARIOS EN ESTE PAIS', '10', 1, '2017-09-23 22:34:00.462756', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (30, 6, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2017-09-23 22:34:00.471075', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (31, 6, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2017-09-23 22:34:00.479407', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (32, 6, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2017-09-23 22:34:00.487715', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (33, 6, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2017-09-23 22:34:00.496057', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (34, 6, 'RETHON', 'RETENCION HONORARIOS', '% RETENCION DE HONORARIOS EN ESTE PAIS', '10', 1, '2017-09-23 22:34:00.504367', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (35, 7, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2017-09-23 22:34:00.512685', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (36, 7, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2017-09-23 22:34:00.521022', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (37, 7, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2017-09-23 22:34:00.529334', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (38, 7, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2017-09-23 22:34:00.53766', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (39, 7, 'RETHON', 'RETENCION HONORARIOS', '% RETENCION DE HONORARIOS EN ESTE PAIS', '10', 1, '2017-09-23 22:34:00.545978', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (40, 8, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2017-09-23 22:34:00.554301', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (41, 8, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2017-09-23 22:34:00.562621', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (42, 8, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2017-09-23 22:34:00.570945', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (43, 8, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2017-09-23 22:34:00.57927', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (44, 8, 'RETHON', 'RETENCION HONORARIOS', '% RETENCION DE HONORARIOS EN ESTE PAIS', '10', 1, '2017-09-23 22:34:00.587698', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (45, 9, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2017-09-23 22:34:00.596018', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (46, 9, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2017-09-23 22:34:00.604342', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (47, 9, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2017-09-23 22:34:00.612661', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (48, 9, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2017-09-23 22:34:00.620984', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (49, 9, 'RETHON', 'RETENCION HONORARIOS', '% RETENCION DE HONORARIOS EN ESTE PAIS', '10', 1, '2017-09-23 22:34:00.629314', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (50, 10, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2017-09-23 22:34:00.637697', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (51, 10, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2017-09-23 22:34:00.645957', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (52, 10, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2017-09-23 22:34:00.654275', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (53, 10, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2017-09-23 22:34:00.662653', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (54, 10, 'RETHON', 'RETENCION HONORARIOS', '% RETENCION DE HONORARIOS EN ESTE PAIS', '10', 1, '2017-09-23 22:34:00.67093', NULL, NULL, NULL, NULL);


--
-- Name: ceco_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY centros_costos
    ADD CONSTRAINT ceco_pk PRIMARY KEY (id);


--
-- Name: ceco_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY centros_costos
    ADD CONSTRAINT ceco_uk_01 UNIQUE (idempr, nombre);


--
-- Name: cosh_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY cotizaciones_servs_hono
    ADD CONSTRAINT cosh_pk PRIMARY KEY (id);


--
-- Name: cosh_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY cotizaciones_servs_hono
    ADD CONSTRAINT cosh_uk_01 UNIQUE (idsosh, idpers);


--
-- Name: dcsh_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY doctos_cotizacs_servs_hono
    ADD CONSTRAINT dcsh_pk PRIMARY KEY (id);


--
-- Name: dcsh_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY doctos_cotizacs_servs_hono
    ADD CONSTRAINT dcsh_uk_01 UNIQUE (idcosh, nombrearchivoorig);


--
-- Name: dcsh_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY doctos_cotizacs_servs_hono
    ADD CONSTRAINT dcsh_uk_02 UNIQUE (idcosh, nombrearchivomodif);


--
-- Name: dole_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY documentos_legales
    ADD CONSTRAINT dole_pk PRIMARY KEY (id);


--
-- Name: dole_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY documentos_legales
    ADD CONSTRAINT dole_uk_01 UNIQUE (idempr, nombreoriginal);


--
-- Name: dole_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY documentos_legales
    ADD CONSTRAINT dole_uk_02 UNIQUE (idempr, nombresistema);


--
-- Name: dosh_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY doctos_ordenes_servs_hono
    ADD CONSTRAINT dosh_pk PRIMARY KEY (id);


--
-- Name: dosh_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY doctos_ordenes_servs_hono
    ADD CONSTRAINT dosh_uk_01 UNIQUE (idorsh, nombrearchivoorig);


--
-- Name: dosh_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY doctos_ordenes_servs_hono
    ADD CONSTRAINT dosh_uk_02 UNIQUE (idorsh, nombrearchivomodif);


--
-- Name: ecsh_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_cotizacs_servs_hono
    ADD CONSTRAINT ecsh_pk PRIMARY KEY (id);


--
-- Name: ecsh_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_cotizacs_servs_hono
    ADD CONSTRAINT ecsh_uk_01 UNIQUE (descripcion);


--
-- Name: empr_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY empresas
    ADD CONSTRAINT empr_pk PRIMARY KEY (id);


--
-- Name: empr_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY empresas
    ADD CONSTRAINT empr_uk_01 UNIQUE (identificador1);


--
-- Name: empr_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY empresas
    ADD CONSTRAINT empr_uk_02 UNIQUE (idgrem, razonsocial);


--
-- Name: empr_uk_03; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY empresas
    ADD CONSTRAINT empr_uk_03 UNIQUE (idgrem, nombrefantasia);


--
-- Name: eosh_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_ordenes_servs_hono
    ADD CONSTRAINT eosh_pk PRIMARY KEY (id);


--
-- Name: eosh_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_ordenes_servs_hono
    ADD CONSTRAINT eosh_uk_01 UNIQUE (descripcion);


--
-- Name: epos_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_pagos_ords_servs_hono
    ADD CONSTRAINT epos_pk PRIMARY KEY (id);


--
-- Name: epos_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_pagos_ords_servs_hono
    ADD CONSTRAINT epos_uk_01 UNIQUE (descripcion);


--
-- Name: esci_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_civiles
    ADD CONSTRAINT esci_pk PRIMARY KEY (id);


--
-- Name: esci_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_civiles
    ADD CONSTRAINT esci_uk_01 UNIQUE (alias);


--
-- Name: esci_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_civiles
    ADD CONSTRAINT esci_uk_02 UNIQUE (descripcion);


--
-- Name: esdl_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_documentos_legales
    ADD CONSTRAINT esdl_pk PRIMARY KEY (id);


--
-- Name: esdl_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_documentos_legales
    ADD CONSTRAINT esdl_uk_01 UNIQUE (descripcion);


--
-- Name: esge_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_grem
    ADD CONSTRAINT esge_pk PRIMARY KEY (id);


--
-- Name: esge_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_grem
    ADD CONSTRAINT esge_uk_01 UNIQUE (descripcion);


--
-- Name: esre_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_registros
    ADD CONSTRAINT esre_pk PRIMARY KEY (id);


--
-- Name: esre_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_registros
    ADD CONSTRAINT esre_uk_01 UNIQUE (descripcion);


--
-- Name: essh_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_solics_servs_hono
    ADD CONSTRAINT essh_pk PRIMARY KEY (id);


--
-- Name: essh_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_solics_servs_hono
    ADD CONSTRAINT essh_uk_01 UNIQUE (descripcion);


--
-- Name: gere_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY gerencias
    ADD CONSTRAINT gere_pk PRIMARY KEY (id);


--
-- Name: gere_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY gerencias
    ADD CONSTRAINT gere_uk_01 UNIQUE (idempr, nombre);


--
-- Name: grem_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY grupos_empresariales
    ADD CONSTRAINT grem_pk PRIMARY KEY (id);


--
-- Name: grem_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY grupos_empresariales
    ADD CONSTRAINT grem_uk_01 UNIQUE (nombre);


--
-- Name: grem_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY grupos_empresariales
    ADD CONSTRAINT grem_uk_02 UNIQUE (alias);


--
-- Name: line_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY lineas_negocios
    ADD CONSTRAINT line_pk PRIMARY KEY (id);


--
-- Name: line_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY lineas_negocios
    ADD CONSTRAINT line_uk_01 UNIQUE (idempr, nombre);


--
-- Name: mone_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY monedas
    ADD CONSTRAINT mone_pk PRIMARY KEY (id);


--
-- Name: mone_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY monedas
    ADD CONSTRAINT mone_uk_01 UNIQUE (nombre);


--
-- Name: mone_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY monedas
    ADD CONSTRAINT mone_uk_02 UNIQUE (nombrecorto);


--
-- Name: orsh_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_pk PRIMARY KEY (id);


--
-- Name: orsh_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_uk_01 UNIQUE (idempr, correlativo);


--
-- Name: pais_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pais_pk PRIMARY KEY (id);


--
-- Name: pais_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pais_uk_01 UNIQUE (nombre);


--
-- Name: pais_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pais_uk_02 UNIQUE (idmone);


--
-- Name: pais_uk_03; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pais_uk_03 UNIQUE (nacionalidad);


--
-- Name: para_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY parametros
    ADD CONSTRAINT para_pk PRIMARY KEY (id);


--
-- Name: para_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY parametros
    ADD CONSTRAINT para_uk_01 UNIQUE (idgrem, nombrecorto);


--
-- Name: para_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY parametros
    ADD CONSTRAINT para_uk_02 UNIQUE (idgrem, nombrelargo);


--
-- Name: pepr_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY perfiles_programas
    ADD CONSTRAINT pepr_pk PRIMARY KEY (id);


--
-- Name: pepr_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY perfiles_programas
    ADD CONSTRAINT pepr_uk_01 UNIQUE (idperf, idprog);


--
-- Name: perf_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY perfiles
    ADD CONSTRAINT perf_pk PRIMARY KEY (id);


--
-- Name: perf_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY perfiles
    ADD CONSTRAINT perf_uk_01 UNIQUE (descripcion);


--
-- Name: pers_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT pers_pk PRIMARY KEY (id);


--
-- Name: pers_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT pers_uk_01 UNIQUE (idgrem, identificador1);


--
-- Name: plcu_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY planes_cuentas
    ADD CONSTRAINT plcu_pk PRIMARY KEY (id);


--
-- Name: plcu_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY planes_cuentas
    ADD CONSTRAINT plcu_uk_01 UNIQUE (idgrem, segmento1, segmento2, segmento3, segmento4, segmento5, segmento6, segmento7, segmento8);


--
-- Name: posh_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY pagos_ordenes_servs_hono
    ADD CONSTRAINT posh_pk PRIMARY KEY (id);


--
-- Name: posh_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY pagos_ordenes_servs_hono
    ADD CONSTRAINT posh_uk_01 UNIQUE (idorsh, fechapago);


--
-- Name: prog_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY programas
    ADD CONSTRAINT prog_pk PRIMARY KEY (id);


--
-- Name: prog_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY programas
    ADD CONSTRAINT prog_uk_01 UNIQUE (idprogpadre, peso);


--
-- Name: proy_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proy_pk PRIMARY KEY (id);


--
-- Name: proy_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proy_uk_01 UNIQUE (idempr, nombre);


--
-- Name: rubr_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY rubros
    ADD CONSTRAINT rubr_pk PRIMARY KEY (id);


--
-- Name: rubr_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY rubros
    ADD CONSTRAINT rubr_uk_01 UNIQUE (idgrem, descripcion);


--
-- Name: sexo_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY sexos
    ADD CONSTRAINT sexo_pk PRIMARY KEY (id);


--
-- Name: sexo_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY sexos
    ADD CONSTRAINT sexo_uk_01 UNIQUE (alias);


--
-- Name: sexo_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY sexos
    ADD CONSTRAINT sexo_uk_02 UNIQUE (descripcion);


--
-- Name: sosh_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY solicitudes_servs_hono
    ADD CONSTRAINT sosh_pk PRIMARY KEY (id);


--
-- Name: sosh_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY solicitudes_servs_hono
    ADD CONSTRAINT sosh_uk_01 UNIQUE (idempr, correlativo);


--
-- Name: tare_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tareas
    ADD CONSTRAINT tare_pk PRIMARY KEY (id);


--
-- Name: tare_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tareas
    ADD CONSTRAINT tare_uk_01 UNIQUE (idempr, nombre);


--
-- Name: tidl_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_documentos_legales
    ADD CONSTRAINT tidl_pk PRIMARY KEY (id);


--
-- Name: tidl_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_documentos_legales
    ADD CONSTRAINT tidl_uk_01 UNIQUE (idgrem, descripcion);


--
-- Name: tifp_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_formas_pagos
    ADD CONSTRAINT tifp_pk PRIMARY KEY (id);


--
-- Name: tifp_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_formas_pagos
    ADD CONSTRAINT tifp_uk_01 UNIQUE (descripcion);


--
-- Name: uspe_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY usuarios_perfiles
    ADD CONSTRAINT uspe_pk PRIMARY KEY (id);


--
-- Name: uspe_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY usuarios_perfiles
    ADD CONSTRAINT uspe_uk_01 UNIQUE (idusua, idperf, idgrem);


--
-- Name: uspe_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY usuarios_perfiles
    ADD CONSTRAINT uspe_uk_02 UNIQUE (idusua, idperf, idempr);


--
-- Name: usua_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usua_pk PRIMARY KEY (id);


--
-- Name: usua_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usua_uk_01 UNIQUE (username);


--
-- Name: vapa_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY valores_paises
    ADD CONSTRAINT vapa_pk PRIMARY KEY (id);


--
-- Name: vapa_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY valores_paises
    ADD CONSTRAINT vapa_uk_01 UNIQUE (idpais, nombrecorto);


--
-- Name: vapa_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY valores_paises
    ADD CONSTRAINT vapa_uk_02 UNIQUE (idpais, nombrelargo);


--
-- Name: trg_after_ins_grem; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_after_ins_grem
    AFTER INSERT ON grupos_empresariales
    FOR EACH ROW
    EXECUTE PROCEDURE f_crear_datos_holding();


--
-- Name: trg_before_ins_upd_pers; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_ins_upd_pers
    BEFORE INSERT OR UPDATE ON personas
    FOR EACH ROW
    EXECUTE PROCEDURE f_validar_dv_pers();


--
-- Name: ceco_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY centros_costos
    ADD CONSTRAINT ceco_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: cosh_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_servs_hono
    ADD CONSTRAINT cosh_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: cosh_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_servs_hono
    ADD CONSTRAINT cosh_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: cosh_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_servs_hono
    ADD CONSTRAINT cosh_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: cosh_fk_ecsh; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_servs_hono
    ADD CONSTRAINT cosh_fk_ecsh FOREIGN KEY (idecsh) REFERENCES estados_cotizacs_servs_hono(id);


--
-- Name: cosh_fk_pers; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_servs_hono
    ADD CONSTRAINT cosh_fk_pers FOREIGN KEY (idpers) REFERENCES personas(id);


--
-- Name: cosh_fk_sosh; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_servs_hono
    ADD CONSTRAINT cosh_fk_sosh FOREIGN KEY (idsosh) REFERENCES solicitudes_servs_hono(id);


--
-- Name: dcsh_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY doctos_cotizacs_servs_hono
    ADD CONSTRAINT dcsh_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: dcsh_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY doctos_cotizacs_servs_hono
    ADD CONSTRAINT dcsh_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: dcsh_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY doctos_cotizacs_servs_hono
    ADD CONSTRAINT dcsh_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: dcsh_fk_cosh; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY doctos_cotizacs_servs_hono
    ADD CONSTRAINT dcsh_fk_cosh FOREIGN KEY (idcosh) REFERENCES cotizaciones_servs_hono(id);


--
-- Name: dole_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_legales
    ADD CONSTRAINT dole_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: dole_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_legales
    ADD CONSTRAINT dole_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: dole_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_legales
    ADD CONSTRAINT dole_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: dole_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_legales
    ADD CONSTRAINT dole_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: dole_fk_esdl; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_legales
    ADD CONSTRAINT dole_fk_esdl FOREIGN KEY (idesdl) REFERENCES estados_documentos_legales(id);


--
-- Name: dole_fk_tidl; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_legales
    ADD CONSTRAINT dole_fk_tidl FOREIGN KEY (idtidl) REFERENCES tipos_documentos_legales(id);


--
-- Name: dosh_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY doctos_ordenes_servs_hono
    ADD CONSTRAINT dosh_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: dosh_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY doctos_ordenes_servs_hono
    ADD CONSTRAINT dosh_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: dosh_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY doctos_ordenes_servs_hono
    ADD CONSTRAINT dosh_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: dosh_fk_orsh; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY doctos_ordenes_servs_hono
    ADD CONSTRAINT dosh_fk_orsh FOREIGN KEY (idorsh) REFERENCES ordenes_servicios_hono(id);


--
-- Name: empr_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY empresas
    ADD CONSTRAINT empr_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: empr_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY empresas
    ADD CONSTRAINT empr_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: empr_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY empresas
    ADD CONSTRAINT empr_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: empr_fk_grem; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY empresas
    ADD CONSTRAINT empr_fk_grem FOREIGN KEY (idgrem) REFERENCES grupos_empresariales(id);


--
-- Name: empr_fk_pais; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY empresas
    ADD CONSTRAINT empr_fk_pais FOREIGN KEY (idpais) REFERENCES paises(id);


--
-- Name: empr_fk_rubr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY empresas
    ADD CONSTRAINT empr_fk_rubr FOREIGN KEY (idrubr) REFERENCES rubros(id);


--
-- Name: gere_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY gerencias
    ADD CONSTRAINT gere_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: grem_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY grupos_empresariales
    ADD CONSTRAINT grem_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: grem_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY grupos_empresariales
    ADD CONSTRAINT grem_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: grem_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY grupos_empresariales
    ADD CONSTRAINT grem_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: grem_fk_esge; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY grupos_empresariales
    ADD CONSTRAINT grem_fk_esge FOREIGN KEY (idesge) REFERENCES estados_grem(id);


--
-- Name: grem_fk_pais; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY grupos_empresariales
    ADD CONSTRAINT grem_fk_pais FOREIGN KEY (idpais) REFERENCES paises(id);


--
-- Name: line_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY lineas_negocios
    ADD CONSTRAINT line_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: orsh_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: orsh_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: orsh_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: orsh_fk_ceco; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_fk_ceco FOREIGN KEY (idceco) REFERENCES centros_costos(id);


--
-- Name: orsh_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: orsh_fk_eosh; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_fk_eosh FOREIGN KEY (ideosh) REFERENCES estados_ordenes_servs_hono(id);


--
-- Name: orsh_fk_gere; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_fk_gere FOREIGN KEY (idgere) REFERENCES gerencias(id);


--
-- Name: orsh_fk_line; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_fk_line FOREIGN KEY (idline) REFERENCES lineas_negocios(id);


--
-- Name: orsh_fk_pers; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_fk_pers FOREIGN KEY (idpers) REFERENCES personas(id);


--
-- Name: orsh_fk_proy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_fk_proy FOREIGN KEY (idproy) REFERENCES proyectos(id);


--
-- Name: orsh_fk_sosh; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_fk_sosh FOREIGN KEY (idsosh) REFERENCES solicitudes_servs_hono(id);


--
-- Name: orsh_fk_tare; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ordenes_servicios_hono
    ADD CONSTRAINT orsh_fk_tare FOREIGN KEY (idtare) REFERENCES tareas(id);


--
-- Name: pais_fk_mone; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pais_fk_mone FOREIGN KEY (idmone) REFERENCES monedas(id);


--
-- Name: para_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY parametros
    ADD CONSTRAINT para_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: para_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY parametros
    ADD CONSTRAINT para_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: para_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY parametros
    ADD CONSTRAINT para_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: para_fk_grem; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY parametros
    ADD CONSTRAINT para_fk_grem FOREIGN KEY (idgrem) REFERENCES grupos_empresariales(id);


--
-- Name: pepr_fk_perf; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY perfiles_programas
    ADD CONSTRAINT pepr_fk_perf FOREIGN KEY (idperf) REFERENCES perfiles(id);


--
-- Name: pepr_fk_prog; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY perfiles_programas
    ADD CONSTRAINT pepr_fk_prog FOREIGN KEY (idprog) REFERENCES programas(id);


--
-- Name: pers_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT pers_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: pers_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT pers_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: pers_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT pers_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: pers_fk_esci; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT pers_fk_esci FOREIGN KEY (idesci) REFERENCES estados_civiles(id);


--
-- Name: pers_fk_grem; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT pers_fk_grem FOREIGN KEY (idgrem) REFERENCES grupos_empresariales(id);


--
-- Name: pers_fk_pais; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT pers_fk_pais FOREIGN KEY (idpais) REFERENCES paises(id);


--
-- Name: pers_fk_sexo; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT pers_fk_sexo FOREIGN KEY (idsexo) REFERENCES sexos(id);


--
-- Name: plcu_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY planes_cuentas
    ADD CONSTRAINT plcu_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: plcu_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY planes_cuentas
    ADD CONSTRAINT plcu_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: plcu_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY planes_cuentas
    ADD CONSTRAINT plcu_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: plcu_fk_grem; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY planes_cuentas
    ADD CONSTRAINT plcu_fk_grem FOREIGN KEY (idgrem) REFERENCES grupos_empresariales(id);


--
-- Name: posh_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY pagos_ordenes_servs_hono
    ADD CONSTRAINT posh_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: posh_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY pagos_ordenes_servs_hono
    ADD CONSTRAINT posh_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: posh_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY pagos_ordenes_servs_hono
    ADD CONSTRAINT posh_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: posh_fk_epos; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY pagos_ordenes_servs_hono
    ADD CONSTRAINT posh_fk_epos FOREIGN KEY (idepos) REFERENCES estados_pagos_ords_servs_hono(id);


--
-- Name: posh_fk_orsh; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY pagos_ordenes_servs_hono
    ADD CONSTRAINT posh_fk_orsh FOREIGN KEY (idorsh) REFERENCES ordenes_servicios_hono(id);


--
-- Name: posh_fk_tifp; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY pagos_ordenes_servs_hono
    ADD CONSTRAINT posh_fk_tifp FOREIGN KEY (idtifp) REFERENCES tipos_formas_pagos(id);


--
-- Name: prog_fk_prog; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY programas
    ADD CONSTRAINT prog_fk_prog FOREIGN KEY (idprogpadre) REFERENCES programas(id);


--
-- Name: proy_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proy_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: rubr_fk_grem; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY rubros
    ADD CONSTRAINT rubr_fk_grem FOREIGN KEY (idgrem) REFERENCES grupos_empresariales(id);


--
-- Name: sosh_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY solicitudes_servs_hono
    ADD CONSTRAINT sosh_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: sosh_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY solicitudes_servs_hono
    ADD CONSTRAINT sosh_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: sosh_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY solicitudes_servs_hono
    ADD CONSTRAINT sosh_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: sosh_fk_ceco; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY solicitudes_servs_hono
    ADD CONSTRAINT sosh_fk_ceco FOREIGN KEY (idceco) REFERENCES centros_costos(id);


--
-- Name: sosh_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY solicitudes_servs_hono
    ADD CONSTRAINT sosh_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: sosh_fk_gere; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY solicitudes_servs_hono
    ADD CONSTRAINT sosh_fk_gere FOREIGN KEY (idgere) REFERENCES gerencias(id);


--
-- Name: sosh_fk_line; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY solicitudes_servs_hono
    ADD CONSTRAINT sosh_fk_line FOREIGN KEY (idline) REFERENCES lineas_negocios(id);


--
-- Name: sosh_fk_pers; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY solicitudes_servs_hono
    ADD CONSTRAINT sosh_fk_pers FOREIGN KEY (idpers) REFERENCES personas(id);


--
-- Name: sosh_fk_proy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY solicitudes_servs_hono
    ADD CONSTRAINT sosh_fk_proy FOREIGN KEY (idproy) REFERENCES proyectos(id);


--
-- Name: sosh_fk_tare; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY solicitudes_servs_hono
    ADD CONSTRAINT sosh_fk_tare FOREIGN KEY (idtare) REFERENCES tareas(id);


--
-- Name: tare_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY tareas
    ADD CONSTRAINT tare_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: tidl_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY tipos_documentos_legales
    ADD CONSTRAINT tidl_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: tidl_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY tipos_documentos_legales
    ADD CONSTRAINT tidl_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: tidl_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY tipos_documentos_legales
    ADD CONSTRAINT tidl_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: tidl_fk_grem; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY tipos_documentos_legales
    ADD CONSTRAINT tidl_fk_grem FOREIGN KEY (idgrem) REFERENCES grupos_empresariales(id);


--
-- Name: uspe_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuarios_perfiles
    ADD CONSTRAINT uspe_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: uspe_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuarios_perfiles
    ADD CONSTRAINT uspe_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: uspe_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuarios_perfiles
    ADD CONSTRAINT uspe_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: uspe_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuarios_perfiles
    ADD CONSTRAINT uspe_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: uspe_fk_esre; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuarios_perfiles
    ADD CONSTRAINT uspe_fk_esre FOREIGN KEY (idesre) REFERENCES estados_registros(id);


--
-- Name: uspe_fk_grem; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuarios_perfiles
    ADD CONSTRAINT uspe_fk_grem FOREIGN KEY (idgrem) REFERENCES grupos_empresariales(id);


--
-- Name: uspe_fk_perf; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuarios_perfiles
    ADD CONSTRAINT uspe_fk_perf FOREIGN KEY (idperf) REFERENCES perfiles(id);


--
-- Name: uspe_fk_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuarios_perfiles
    ADD CONSTRAINT uspe_fk_usua FOREIGN KEY (idusua) REFERENCES usuarios(id);


--
-- Name: usua_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usua_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: usua_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usua_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: usua_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usua_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: usua_fk_esre; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usua_fk_esre FOREIGN KEY (idesre) REFERENCES estados_registros(id);


--
-- Name: vapa_fk_pais; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY valores_paises
    ADD CONSTRAINT vapa_fk_pais FOREIGN KEY (idpais) REFERENCES paises(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

