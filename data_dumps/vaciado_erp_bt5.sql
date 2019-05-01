--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: f_copiar_cove_a_nove(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_copiar_cove_a_nove() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  Vidnove                   numeric;
  Vnumero                   numeric;
  Vid                       numeric;
  Vcorrelativo              numeric;
  Vidprod                   numeric;
  Vidserv                   numeric;
  Vpreciounitario           numeric;
  Vcantidad                 numeric;
  Vporcentajedescuento      numeric;
  Vmontodescuento           numeric;
  Vexento                   numeric;
  Vafecto                   numeric;
  Vimpuestos                numeric;
  Vtotallinea               numeric;
  Vidusuacrearegistro       numeric;
  Viddenv                   numeric;
  C_decv cursor for
    select id
          ,correlativo
          ,idprod
          ,idserv
          ,preciounitario
          ,cantidad
          ,porcentajedescuento
          ,montodescuento
          ,exento
          ,afecto
          ,impuestos
          ,totallinea
          ,idusuacrearegistro
    from   detalles_cotizs_vtas
    where  idcove = new.id
    ;
begin
  if old.idescv = 2 and new.idescv = 3 then
    select nextval('nove_seq')
    into   Vidnove
    ;
    select max(numero)
    into   Vnumero
    from   notas_ventas
    where  idempr = new.idempr
    ;
    if Vnumero is null then
      Vnumero := 1;
    end if;
    insert into notas_ventas (id                       -- numeric(20,0)   not null
                             ,idempr                   -- numeric(20,0)   not null
                             ,idcove                   -- numeric(20,0)       null
                             ,numero                   -- numeric(20,0)   not null
                             ,idclie                   -- numeric(20,0)   not null
                             ,descripcionnotaventa     -- varchar(1000)   not null
                             ,idgere                   -- numeric(20,0)       null
                             ,idproy                   -- numeric(20,0)       null
                             ,idline                   -- numeric(20,0)       null
                             ,idceco                   -- numeric(20,0)       null
                             ,idtare                   -- numeric(20,0)       null
                             ,exento                   -- numeric(20,0)   not null
                             ,afecto                   -- numeric(20,0)   not null
                             ,impuestos                -- numeric(20,0)   not null
                             ,porcentajedescuento      -- numeric(20,5)   not null
                             ,montodescuento           -- numeric(20,0)   not null
                             ,total                    -- numeric(20,0)   not null
                             ,idesnv                   -- numeric(20,0)   not null
                             ,idusuacrearegistro       -- numeric(20,0)   not null
                             ,fechacrearegistro        -- timestamp       not null
                             ,idusuamodifregistro      -- numeric(20,0)       null
                             ,fechamodifregistro       -- timestamp           null
                             ,idusuaborraregistro      -- numeric(20,0)       null
                             ,fechaborraregistro       -- timestamp           null
                             )
    values (Vidnove                       -- id                       numeric(20,0)   not null
           ,new.idempr                    -- idempr                   numeric(20,0)   not null
           ,new.id                        -- idcove                   numeric(20,0)       null
           ,Vnumero                       -- numero                   numeric(20,0)   not null
           ,new.idclie                    -- idclie                   numeric(20,0)   not null
           ,new.descripcioncotizacion     -- descripcionnotaventa     varchar(1000)   not null
           ,new.idgere                    -- idgere                   numeric(20,0)       null
           ,new.idproy                    -- idproy                   numeric(20,0)       null
           ,new.idline                    -- idline                   numeric(20,0)       null
           ,new.idceco                    -- idceco                   numeric(20,0)       null
           ,new.idtare                    -- idtare                   numeric(20,0)       null
           ,new.exento                    -- exento                   numeric(20,0)   not null
           ,new.afecto                    -- afecto                   numeric(20,0)   not null
           ,new.impuestos                 -- impuestos                numeric(20,0)   not null
           ,new.porcentajedescuento       -- porcentajedescuento      numeric(20,5)   not null
           ,new.montodescuento            -- montodescuento           numeric(20,0)   not null
           ,new.total                     -- total                    numeric(20,0)   not null
           ,1                             -- idesnv                   numeric(20,0)   not null
           ,new.idusuacrearegistro        -- idusuacrearegistro       numeric(20,0)   not null
           ,current_timestamp             -- fechacrearegistro        timestamp       not null
           ,null                          -- idusuamodifregistro      numeric(20,0)       null
           ,null                          -- fechamodifregistro       timestamp           null
           ,null                          -- idusuaborraregistro      numeric(20,0)       null
           ,null                          -- fechaborraregistro       timestamp           null
           )
    ;
    open C_decv;
    loop
      fetch C_decv into Vid
                       ,Vcorrelativo
                       ,Vidprod
                       ,Vidserv
                       ,Vpreciounitario
                       ,Vcantidad
                       ,Vporcentajedescuento
                       ,Vmontodescuento
                       ,Vexento
                       ,Vafecto
                       ,Vimpuestos
                       ,Vtotallinea
                       ,Vidusuacrearegistro
                       ;
      exit when not found;
      select nextval('denv_seq')
      into   Viddenv
      ;
      insert into detalles_notas_vtas (id                       -- numeric(20,0)   not null
                                      ,idnove                   -- numeric(20,0)   not null
                                      ,correlativo              -- numeric(20,0)   not null
                                      ,idprod                   -- numeric(20,0)       null
                                      ,idserv                   -- numeric(20,0)       null
                                      ,preciounitario           -- numeric(20,0)   not null
                                      ,cantidad                 -- numeric(20,2)   not null
                                      ,porcentajedescuento      -- numeric(20,5)   not null
                                      ,montodescuento           -- numeric(20,0)   not null
                                      ,exento                   -- numeric(20,0)   not null
                                      ,afecto                   -- numeric(20,0)   not null
                                      ,impuestos                -- numeric(20,2)   not null
                                      ,totallinea               -- numeric(20,2)   not null
                                      ,idusuacrearegistro       -- numeric(20,0)   not null
                                      ,fechacrearegistro        -- timestamp       not null
                                      ,idusuamodifregistro      -- numeric(20,0)       null
                                      ,fechamodifregistro       -- timestamp           null
                                      ,idusuaborraregistro      -- numeric(20,0)       null
                                      ,fechaborraregistro       -- timestamp           null
                                      )
      values (Viddenv                              -- id                       numeric(20,0)   not null
             ,Vidnove                              -- idnove                   numeric(20,0)   not null
             ,Vcorrelativo                         -- correlativo              numeric(20,0)   not null
             ,Vidprod                              -- idprod                   numeric(20,0)       null
             ,Vidserv                              -- idserv                   numeric(20,0)       null
             ,Vpreciounitario                      -- preciounitario           numeric(20,0)   not null
             ,Vcantidad                            -- cantidad                 numeric(20,2)   not null
             ,Vporcentajedescuento                 -- porcentajedescuento      numeric(20,5)   not null
             ,Vmontodescuento                      -- montodescuento           numeric(20,0)   not null
             ,Vexento                              -- exento                   numeric(20,0)   not null
             ,Vafecto                              -- afecto                   numeric(20,0)   not null
             ,Vimpuestos                           -- impuestos                numeric(20,2)   not null
             ,Vtotallinea                          -- totallinea               numeric(20,2)   not null
             ,Vidusuacrearegistro                  -- idusuacrearegistro       numeric(20,0)   not null
             ,current_timestamp                    -- fechacrearegistro        timestamp       not null
             ,null                                 -- idusuamodifregistro      numeric(20,0)       null
             ,null                                 -- fechamodifregistro       timestamp           null
             ,null                                 -- idusuaborraregistro      numeric(20,0)       null
             ,null                                 -- fechaborraregistro       timestamp           null
             )
      ;
    end loop;
    close C_decv;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.f_copiar_cove_a_nove() OWNER TO admin;

--
-- Name: f_copiar_nove_a_dove(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_copiar_nove_a_dove() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  Viddove                   numeric;
  Vnumero                   numeric;
  Vid                       numeric;
  Vcorrelativo              numeric;
  Vidprod                   numeric;
  Vidserv                   numeric;
  Vcantidad                 numeric;
  Vpreciounitario           numeric;
  Vporcentajedescuento      numeric;
  Vmontodescuento           numeric;
  Vimpuestos                numeric;
  Vsubtotal                 numeric;
  Vidusuacrearegistro       numeric;
  Viddedv                   numeric;
  Vidtidv                   numeric;
  Vidpais                   numeric;
  C_denv cursor for
    select id
          ,correlativo
          ,idprod
          ,idserv
          ,cantidad
          ,preciounitario
          ,porcentajedescuento
          ,montodescuento
          ,impuestos
          ,subtotal
          ,idusuacrearegistro
    from   detalles_notas_vtas
    where  idnove = new.id
    ;
begin
  if old.idesnv = 2 and new.idesnv = 3 then
    select idpais
    into   Vidpais
    from   empresas
    where  id = new.idempr
    ;
    select min(id)
    into   Vidtidv
    from   tipos_doctos_ventas
    where  idpais = Vidpais
    ;
    select nextval('nove_seq')
    into   Viddove
    ;
    select max(numero)
    into   Vnumero
    from   notas_ventas
    where  idempr = new.idempr
    ;
    if Vnumero is null then
      Vnumero := 1;
    end if;
    insert into documentos_ventas (id                       -- numeric(20,0)   not null
                                  ,idempr                   -- numeric(20,0)   not null
                                  ,idnove                   -- numeric(20,0)       null
                                  ,idtidv                   -- numeric(20,0)   not null
                                  ,numero                   -- numeric(20,0)   not null
                                  ,idclie                   -- numeric(20,0)   not null
                                  ,descripciondoctoventa    -- varchar(1000)   not null
                                  ,idgere                   -- numeric(20,0)       null
                                  ,idproy                   -- numeric(20,0)       null
                                  ,idline                   -- numeric(20,0)       null
                                  ,idceco                   -- numeric(20,0)       null
                                  ,idtare                   -- numeric(20,0)       null
                                  ,subtotal                 -- numeric(20,0)   not null
                                  ,porcentajedescuento      -- numeric(20,2)   not null
                                  ,montodescuento           -- numeric(20,2)   not null
                                  ,valorimpuestos           -- numeric(20,0)   not null
                                  ,total                    -- numeric(20,0)   not null
                                  ,idesve                   -- numeric(20,0)   not null
                                  ,idusuacrearegistro       -- numeric(20,0)   not null
                                  ,fechacrearegistro        -- timestamp       not null
                                  ,idusuamodifregistro      -- numeric(20,0)       null
                                  ,fechamodifregistro       -- timestamp           null
                                  ,idusuaborraregistro      -- numeric(20,0)       null
                                  ,fechaborraregistro       -- timestamp           null
                                  )
    values (Viddove                       -- id                       numeric(20,0)   not null
           ,new.idempr                    -- idempr                   numeric(20,0)   not null
           ,new.id                        -- idnove                   numeric(20,0)       null
           ,Vidtidv                       -- idtidv                   numeric(20,0)   not null
           ,Vnumero                       -- numero                   numeric(20,0)   not null
           ,new.idclie                    -- idclie                   numeric(20,0)   not null
           ,new.descripcionnotaventa      -- descripciondoctoventa    varchar(1000)   not null
           ,new.idgere                    -- idgere                   numeric(20,0)       null
           ,new.idproy                    -- idproy                   numeric(20,0)       null
           ,new.idline                    -- idline                   numeric(20,0)       null
           ,new.idceco                    -- idceco                   numeric(20,0)       null
           ,new.idtare                    -- idtare                   numeric(20,0)       null
           ,new.subtotal                  -- subtotal                 numeric(20,0)   not null
           ,new.porcentajedescuento       -- porcentajedescuento      numeric(20,2)   not null
           ,new.montodescuento            -- montodescuento           numeric(20,2)   not null
           ,new.valorimpuestos            -- valorimpuestos           numeric(20,0)   not null
           ,new.total                     -- total                    numeric(20,0)   not null
           ,1                             -- idesve                   numeric(20,0)   not null
           ,new.idusuacrearegistro        -- idusuacrearegistro       numeric(20,0)   not null
           ,current_timestamp             -- fechacrearegistro        timestamp       not null
           ,null                          -- idusuamodifregistro      numeric(20,0)       null
           ,null                          -- fechamodifregistro       timestamp           null
           ,null                          -- idusuaborraregistro      numeric(20,0)       null
           ,null                          -- fechaborraregistro       timestamp           null
           )
    ;
    open C_denv;
    loop
      fetch C_denv into Vid
                       ,Vcorrelativo
                       ,Vidprod
                       ,Vidserv
                       ,Vcantidad
                       ,Vpreciounitario
                       ,Vporcentajedescuento
                       ,Vmontodescuento
                       ,Vimpuestos
                       ,Vsubtotal
                       ,Vidusuacrearegistro
                       ;
      exit when not found;
      select nextval('dedv_seq')
      into   Viddedv
      ;
      insert into detalles_doctos_vtas (id                       -- numeric(20,0)   not null
                                       ,iddove                   -- numeric(20,0)   not null
                                       ,correlativo              -- numeric(20,0)   not null
                                       ,idprod                   -- numeric(20,0)       null
                                       ,idserv                   -- numeric(20,0)       null
                                       ,cantidad                 -- numeric(20,2)   not null
                                       ,preciounitario           -- numeric(20,0)   not null
                                       ,porcentajedescuento      -- numeric(20,2)   not null
                                       ,montodescuento           -- numeric(20,2)   not null
                                       ,impuestos                -- numeric(20,2)   not null
                                       ,subtotal                 -- numeric(20,2)   not null
                                       ,idusuacrearegistro       -- numeric(20,0)   not null
                                       ,fechacrearegistro        -- timestamp       not null
                                       ,idusuamodifregistro      -- numeric(20,0)       null
                                       ,fechamodifregistro       -- timestamp           null
                                       ,idusuaborraregistro      -- numeric(20,0)       null
                                       ,fechaborraregistro       -- timestamp           null
                                       )
      values (Viddedv                              -- id                       numeric(20,0)   not null
             ,Viddove                              -- iddove                   numeric(20,0)   not null
             ,Vcorrelativo                         -- correlativo              numeric(20,0)   not null
             ,Vidprod                              -- idprod                   numeric(20,0)       null
             ,Vidserv                              -- idserv                   numeric(20,0)       null
             ,Vcantidad                            -- cantidad                 numeric(20,2)   not null
             ,Vpreciounitario                      -- preciounitario           numeric(20,0)   not null
             ,Vporcentajedescuento                 -- porcentajedescuento      numeric(20,2)   not null
             ,Vmontodescuento                      -- montodescuento           numeric(20,2)   not null
             ,Vimpuestos                           -- impuestos                numeric(20,2)   not null
             ,Vsubtotal                            -- subtotal                 numeric(20,2)   not null
             ,Vidusuacrearegistro                  -- idusuacrearegistro       numeric(20,0)   not null
             ,current_timestamp                    -- fechacrearegistro        timestamp       not null
             ,null                                 -- idusuamodifregistro      numeric(20,0)       null
             ,null                                 -- fechamodifregistro       timestamp           null
             ,null                                 -- idusuaborraregistro      numeric(20,0)       null
             ,null                                 -- fechaborraregistro       timestamp           null
             )
      ;
    end loop;
    close C_denv;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.f_copiar_nove_a_dove() OWNER TO admin;

--
-- Name: f_crear_datos_holding(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_crear_datos_holding() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
  insert into parametros values (nextval('para_seq'), new.id, 'LARGOMINCLAVE', 'LARGO MÍNIMO CLAVES USUARIOS'             , 'LARGO MINIMO EXIGIDO PARA LAS CLAVES DE LOS USUARIOS'               , '5' , 1, current_timestamp, null, null, null, null);
  insert into parametros values (nextval('para_seq'), new.id, 'NROSEGMSPLCU' , 'NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS', 'NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING', '4' , 1, current_timestamp, null, null, null, null);
  insert into parametros values (nextval('para_seq'), new.id, 'UMVALNOTVE'   , 'UNIDAD DE MEDIDA VALIDEZ NOTA VENTA'      , 'H = HORAS; D = DÍAS'                                                , 'D' , 1, current_timestamp, null, null, null, null);     
  insert into parametros values (nextval('para_seq'), new.id, 'CADUCNV'      , 'CADUCIDAD NOTAS DE VENTA'                 , 'TIEMPO TRAS EL CUAL CADUCA UNA NOTA DE VENTA (1 DÍA, 2 HORAS, ETC.)', '1' , 1, current_timestamp, null, null, null, null);     
  insert into parametros values (nextval('para_seq'), new.id, 'VALIDEZCOTI'  , 'DEFAULT DÍAS VALIDEZ COTIZACIÓN'          , 'DÍAS DE VALIDEZ POR DEFECTO DE UNA COTIZACIÓN'                      , '5' , 1, current_timestamp, null, null, null, null);     

  insert into rubros values (nextval('rubr_seq'), new.id, 'CONSULTORÍA' );
  insert into rubros values (nextval('rubr_seq'), new.id, 'AUTOMOTRIZ'  );
  insert into rubros values (nextval('rubr_seq'), new.id, 'INDUSTRIAL'  );
  insert into rubros values (nextval('rubr_seq'), new.id, 'INVERSIONES' );
  insert into rubros values (nextval('rubr_seq'), new.id, 'AGRÍCOLA'    );
  insert into rubros values (nextval('rubr_seq'), new.id, 'FARMACÉUTICO');
  insert into rubros values (nextval('rubr_seq'), new.id, 'LOGÍSTICA'   );
  insert into rubros values (nextval('rubr_seq'), new.id, 'AMASANDERÍA' );

  insert into tipos_documentos_legales values (nextval('tidl_seq'), new.id, 'CONSTITUCIÓN DE SOCIEDAD', 'CONST. SOC.', '#FF0000'  , 1, current_timestamp, null, null, null, null);
  insert into tipos_documentos_legales values (nextval('tidl_seq'), new.id, 'ACTA DE DIRECTORIO'      , 'ACTA DIR.'  , '#00FF00'  , 1, current_timestamp, null, null, null, null);
  insert into tipos_documentos_legales values (nextval('tidl_seq'), new.id, 'SESIÓN DE DIRECTORIO'    , 'SES. DIR.'  , '#0000FF'  , 1, current_timestamp, null, null, null, null);
  insert into tipos_documentos_legales values (nextval('tidl_seq'), new.id, 'CONTRATO DE ARRIENDO'    , 'CONT. ARR.' , '#FFFFFF', 1, current_timestamp, null, null, null, null);

  insert into estados_documentos_legales values (nextval('esdl_seq'), new.id, 'VÁLIDO'  , 1, current_timestamp, null, null, null, null);
  insert into estados_documentos_legales values (nextval('esdl_seq'), new.id, 'INVÁLIDO', 1, current_timestamp, null, null, null, null);
  insert into estados_documentos_legales values (nextval('esdl_seq'), new.id, 'CADUCO'  , 1, current_timestamp, null, null, null, null);

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
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '17', '8001', null, null, null, null, 'DEPRECIACION ACUMULADA'                                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '18', '0000', null, null, null, null, 'ACTIVOS BIOLOGICOS'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '19', '0000', null, null, null, null, 'PROPIEDADES DE INVERSION'                                          , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '1', '20', '20', '0000', null, null, null, null, 'ACTIVOS POR IMPUESTO DIFERIDO'                                     , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '00', '00', '0000', null, null, null, null, 'PASIVOS'                                                           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '00', '0000', null, null, null, null, 'PASIVOS CORRIENTES'                                                , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '10', '0000', null, null, null, null, 'OTROS PASIVOS FINANCIEROS'                                         , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '10', '1001', null, null, null, null, 'OBLIGACIONES CON BANCOS'                                           , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '10', '1002', null, null, null, null, 'LINEAS DE CREDITO'                                                 , 1, current_timestamp, null, null, null, null);
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
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '14', '1003', null, null, null, null, 'RETENCION 1RA CATEGORIA'                                            , 1, current_timestamp, null, null, null, null);
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '2', '10', '14', '1004', null, null, null, null, 'RETENCION 2DA CATEGORIA'                                            , 1, current_timestamp, null, null, null, null);
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
  insert into planes_cuentas values (nextval('plcu_seq'), new.id, '4', '20', '11', '7001', null, null, null, null, 'COLACION'                                                          , 1, current_timestamp, null, null, null, null);
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

  return new;
end;
$$;


ALTER FUNCTION public.f_crear_datos_holding() OWNER TO admin;

--
-- Name: f_datos_linea_vta(numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_datos_linea_vta(numeric, numeric, numeric, numeric, numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
declare
  Pidprod          numeric := $1;
  Pidserv          numeric := $2;
  Pcantidad        numeric := $3;
  Pmonto_dscto     numeric := $4;
  Pdato_deseado    numeric := $5;
  Vidpais          numeric;
  aux              numeric;
  Vvalorunitario   numeric;
  Vidtipr          numeric;
  Vidtise          numeric;
  Vestaexento      char(1);
  Vsub_total       numeric;
  Vvalor_impuesto  numeric;
  Veste_impuesto   numeric;
  Vimpuestos       numeric;
  C_impuestos_prod cursor for
    select valor
    from   impuestos
    where  idpais      = Vidpais
    and    obligatorio = 'S'
    and    Vestaexento = 'N'
    union
    select impu.valor
    from   tipos_productos_impuestos tipi
          ,impuestos                 impu
    where  tipi.idimpu      = impu.id
    and    tipi.idtipr      = Vidtipr
    and    impu.obligatorio = 'N'
    and    impu.idpais      = Vidpais
    ;
  C_impuestos_serv cursor for
    select valor
    from   impuestos
    where  idpais      = Vidpais
    and    obligatorio = 'S'
    and    Vestaexento = 'N'
    ;
begin
  /*
    Esta función debe ser invocada con (Pidprod o Pidserv), solo uno de los 2, y con Pcantidad y Pmonto_dscto (el cual puede ser 0)
    Además, un parámetro extra que indica qué dato es el que se desea obtener, a saber:

    1: precio de venta (del producto o servicio)
    2: total exento
    3: total afecto
    4: impuestos
  */
  if (Pidprod is null and Pidserv is null) or Pcantidad is null or Pmonto_dscto is null or Pdato_deseado is null then
    return(0);
  end if;
  if Pidprod is not null and Pidserv is not null then
    return(0);
  end if;
  if Pdato_deseado not in (1, 2, 3, 4) then
    return(0);
  end if;
  if Pidprod is not null then
    select count(*)
    into   aux
    from   productos
    where  id = Pidprod
    ;
    if aux = 0 then
      return(0);
    end if;
    select valorunitario
          ,idtipr
    into   Vvalorunitario
          ,Vidtipr
    from   productos
    where  id = Pidprod
    ;
    if Pdato_deseado = 1 then
      return(Vvalorunitario);
    end if;
    select estaexento
    into   Vestaexento
    from   tipos_productos
    where  id = Vidtipr
    ;
    if Pdato_deseado in (2, 3) then
      if Vestaexento = 'S' then
        if Pdato_deseado = 2 then
          return(Pcantidad*Vvalorunitario - Pmonto_dscto);
        else
          return(0);
        end if;
      else
        if Pdato_deseado = 2 then
          return(0);
        else
          return(Pcantidad*Vvalorunitario - Pmonto_dscto);
        end if;
      end if;
    end if;
    select grem.idpais
    into   Vidpais
    from   grupos_empresariales grem
          ,empresas             empr
          ,productos            prod
    where  grem.id = empr.idgrem
    and    empr.id = prod.idempr
    and    prod.id = Pidprod
    ;
    Vsub_total := Pcantidad*Vvalorunitario - Pmonto_dscto;
    Vimpuestos := 0;
    open C_impuestos_prod;
    loop
      fetch C_impuestos_prod into Vvalor_impuesto;
      exit when not found;
      Veste_impuesto := round((Vsub_total * Vvalor_impuesto) / 100);
      Vimpuestos     := Vimpuestos + Veste_impuesto;
    end loop;
    close C_impuestos_prod;
    return(Vimpuestos);
  else /* servicio */
    select count(*)
    into   aux
    from   servicios
    where  id = Pidserv
    ;
    if aux = 0 then
      return(0);
    end if;
    select valorunitario
          ,idtise
    into   Vvalorunitario
          ,Vidtise
    from   servicios
    where  id = Pidserv
    ;
    if Pdato_deseado = 1 then
      return(Vvalorunitario);
    end if;
    select estaexento
    into   Vestaexento
    from   tipos_servicios
    where  id = Vidtise
    ;
    if Pdato_deseado in (2, 3) then
      if Vestaexento = 'S' then
        if Pdato_deseado = 2 then
          return(Pcantidad*Vvalorunitario - Pmonto_dscto);
        else
          return(0);
        end if;
      else
        if Pdato_deseado = 2 then
          return(0);
        else
          return(Pcantidad*Vvalorunitario - Pmonto_dscto);
        end if;
      end if;
    end if;
    select grem.idpais
    into   Vidpais
    from   grupos_empresariales grem
          ,empresas             empr
          ,servicios            serv
    where  grem.id = empr.idgrem
    and    empr.id = serv.idempr
    and    serv.id = Pidserv
    ;
    Vsub_total := Pcantidad*Vvalorunitario - Pmonto_dscto;
    Vimpuestos := 0;
    open C_impuestos_serv;
    loop
      fetch C_impuestos_serv into Vvalor_impuesto;
      exit when not found;
      Veste_impuesto := round((Vsub_total * Vvalor_impuesto) / 100);
      Vimpuestos     := Vimpuestos + Veste_impuesto;
    end loop;
    close C_impuestos_serv;
    return(Vimpuestos);
  end if;
end;
$_$;


ALTER FUNCTION public.f_datos_linea_vta(numeric, numeric, numeric, numeric, numeric) OWNER TO admin;

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
-- Name: f_limpia(character varying); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_limpia(character varying) RETURNS character
    LANGUAGE plpgsql
    AS $_$
declare
  Ventrada varchar(1000);
  Vsalida  varchar(1000);
begin
  Ventrada := $1;
  Vsalida  := replace(
              replace(
              replace(
              replace(
              replace(
              replace(
              replace(
              replace(
              replace(
              replace(
              replace(
              replace(Ventrada, 'á', 'a')
                              , 'é', 'e')
                              , 'í', 'i')
                              , 'ó', 'o')
                              , 'ú', 'u')
                              , 'Á', 'A')
                              , 'É', 'E')
                              , 'Í', 'I')
                              , 'Ó', 'O')
                              , 'Ú', 'U')
                              , 'ñ', 'n')
                              , 'Ñ', 'Ñ')
              ;
  return(Vsalida);
end;
$_$;


ALTER FUNCTION public.f_limpia(character varying) OWNER TO admin;

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
-- Name: f_poblar_fode_fide(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_poblar_fode_fide() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
  Vidfode                      numeric;
  Vtablename                   varchar(100);
  Vordinal_position            numeric;
  Vcolumn_name                 varchar(100);
  Vdata_type                   varchar(100);
  Adata_type                   varchar(100);
  Vcharacter_maximum_length    numeric;
  Vnumeric_precision           numeric;
  Vis_nullable                 varchar(100);
  Vrequerido                   varchar(100);
  Vlargo                       numeric;
  Vpk                          varchar(100);
  C_tablas cursor for
    select table_name
    from   information_schema.tables
    where  table_schema = 'public'
    and    table_type   = 'BASE TABLE'
    and    table_name   not in ('tablas_secuencias', 'field_defs', 'form_defs')
    order  by 1
    ;
  C_columnas cursor for
    select ordinal_position
          ,column_name
          ,data_type
          ,character_maximum_length
          ,numeric_precision
          ,is_nullable
    from   information_schema.columns
    where  table_schema = 'public'
    and    table_name   = Vtablename
    and    column_name  not in ('idusuacrearegistro', 'fechacrearegistro', 'idusuamodifregistro',
                                'fechamodifregistro', 'idusuaborraregistro', 'fechaborraregistro',
                                'xfld'
                               )
    order  by 1
    ;
begin
  delete from field_defs;
  delete from form_defs;
  open C_tablas;
  loop
    fetch C_tablas into Vtablename
                        ;
    exit when not found;
    Vidfode := nextval('fode_seq');
    insert into form_defs values (Vidfode                    -- id                       numeric(11)     not null
                                 ,Vtablename                 -- caption                  varchar(50)     not null
                                 ,Vtablename                 -- table_name               varchar(30)     not null
                                 ,'Y'                        -- ins_allowed              varchar(1)      not null
                                 ,'Y'                        -- upd_allowed              varchar(1)      not null
                                 ,'Y'                        -- del_allowed              varchar(1)      not null
                                 )
    ;

    open C_columnas;
    loop
      fetch C_columnas into Vordinal_position
                           ,Vcolumn_name
                           ,Vdata_type
                           ,Vcharacter_maximum_length
                           ,Vnumeric_precision
                           ,Vis_nullable
                           ;
      exit when not found;
      Adata_type := trim(substr(Vdata_type,1,10));
      if    Adata_type = 'character' then
        Vlargo := Vcharacter_maximum_length;
      elsif Vdata_type = 'numeric' then
        Vlargo := Vnumeric_precision;
      else
        Vlargo := 0;
      end if;
      if Vis_nullable = 'NO' then
        Vrequerido := 'Y';
      else
        Vrequerido := 'N';
      end if;
      if Vordinal_position = 1 then
        Vpk := 'Y';
      else
        Vpk := 'N';
      end if;
      insert into field_defs values (nextval('fide_seq')            -- id                       numeric(11)     not null
                                    ,Vidfode                        -- form_id                  numeric(11)     not null
                                    ,Vordinal_position              -- forder                   numeric(11)     not null
                                    ,Vcolumn_name                   -- name                     varchar(30)     not null
                                    ,Adata_type                     -- type                     varchar(10)     not null
                                    ,Vlargo                         -- len                      numeric(11)     not null
                                    ,0                              -- decim                    numeric(11)     not null
                                    ,Vpk                            -- pk                       varchar(1)      not null
                                    ,Vrequerido                     -- req                      varchar(1)      not null
                                    ,Vcolumn_name                   -- caption                  varchar(50)     not null
                                    ,'input'                        -- gadget                   varchar(10)     not null
                                    ,Vlargo                         -- size                     numeric(11)     not null
                                    ,Vlargo                         -- maxlength                numeric(11)     not null
                                    ,5                              -- rows                     numeric(11)     not null
                                    ,60                             -- cols                     numeric(11)     not null
                                    ,''                             -- selvalues                varchar(500)        null
                                    ,''                             -- sqlvalues                varchar(500)        null
                                    ,'Y'                            -- visible                  varchar(1)      not null
                                    ,'N'                            -- readonly                 varchar(1)      not null
                                    ,'P'                            -- fld_type                 varchar(1)      not null
                                    ,-1                             -- fld_offset               numeric(11)     not null
                                    )
      ;
    end loop;
    close C_columnas;
  end loop;
  close C_tablas;
  return('S');
end;
$$;


ALTER FUNCTION public.f_poblar_fode_fide() OWNER TO admin;

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
    return('N:Password inválida');
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
    return('N:Usuario no está activo');
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
        ,grupos_empresariales grem
  where  usua.id              = uspe.idusua
  and    uspe.idgrem          = grem.id
  and    upper(usua.username) = upper(Pusername)
  and    grem.idesge          = 1
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
-- Name: f_validar_cove(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_validar_cove() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  aux      numeric;
  Vmensaje varchar(1000);
begin
  -- Estados posibles:
  -- 1 | CREADA
  -- 2 | CERRADA
  -- 3 | ACEPTADA
  -- 4 | CADUCADA
  --
  -- los cambios de estado válidos son
  -- 1 -> 2
  -- 1 -> 4
  -- 2 -> 3
  -- 2 -> 4
  -- y nada más; todo otro posible cambio de estado es error
  --
  if (old.idescv = 1 and new.idescv = 2) or
     (old.idescv = 1 and new.idescv = 4) or
     (old.idescv = 2 and new.idescv = 3) or
     (old.idescv = 2 and new.idescv = 4) then
    aux := 1; /* estos son los cambios válidos */
  else
    Vmensaje := 'Cotización no puede pasar de estado ' || old.idescv || ' a ' || new.idescv;
    raise exception 'Cambio de estado inválido'
    using hint = Vmensaje;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.f_validar_cove() OWNER TO admin;

--
-- Name: f_validar_cove_ins(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_validar_cove_ins() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  Vmensaje varchar(1000);
begin
  if new.idescv != 1 then
    Vmensaje := 'Una nueva cotización solo puede tener estado 1';
    raise exception 'Estado para nueva cotización inválido'
    using hint = Vmensaje;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.f_validar_cove_ins() OWNER TO admin;

--
-- Name: f_validar_dove(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_validar_dove() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  aux      numeric;
  Vmensaje varchar(1000);
begin
  -- Estados posibles:
  -- 1 | CREADA
  -- 2 | CERRADA
  -- 3 | ANULADA
  --
  -- los cambios de estado válidos son
  -- 1 -> 2
  -- 1 -> 3
  -- y nada más; todo otro posible cambio de estado es error
  --
  if (old.idesve = 1 and new.idesve = 2) or
     (old.idesve = 1 and new.idesve = 3) then
    aux := 1; /* estos son los cambios válidos */
  else
    Vmensaje := 'Venta no puede pasar de estado ' || old.idesve || ' a ' || new.idesve;
    raise exception 'Cambio de estado inválido'
    using hint = Vmensaje;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.f_validar_dove() OWNER TO admin;

--
-- Name: f_validar_dove_ins(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_validar_dove_ins() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  Vmensaje varchar(1000);
begin
  if new.idesdv != 1 then
    Vmensaje := 'Un nuevo documento de venta solo puede tener estado 1';
    raise exception 'Estado para nuevo documento de venta inválido'
    using hint = Vmensaje;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.f_validar_dove_ins() OWNER TO admin;

--
-- Name: f_validar_dv_pers(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_validar_dv_pers() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  Vidpais         numeric;
  Vdv_correcto    varchar(100);
  Vmensaje        varchar(1000);
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
      Vmensaje := 'DV incorrecto para RUT ' || new.identificador1 || '. Reingrese DV';
      raise exception 'DV incorrecto'
      using hint = Vmensaje;
    end if;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.f_validar_dv_pers() OWNER TO admin;

--
-- Name: f_validar_nove(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_validar_nove() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  aux      numeric;
  Vmensaje varchar(1000);
begin
  -- Estados posibles:
  -- 1 | CREADA
  -- 2 | EMITIDA
  -- 3 | FACTURADA
  -- 4 | CADUCADA
  --
  -- los cambios de estado válidos son
  -- 1 -> 2
  -- 1 -> 4
  -- 2 -> 3
  -- 2 -> 4
  -- y nada más; todo otro posible cambio de estado es error
  --
  if (old.idesnv = 1 and new.idesnv = 2) or
     (old.idesnv = 1 and new.idesnv = 4) or
     (old.idesnv = 2 and new.idesnv = 3) or
     (old.idesnv = 2 and new.idesnv = 4) then
    aux := 1; /* estos son los cambios válidos */
  else
    Vmensaje := 'Nota de venta no puede pasar de estado ' || old.idesnv || ' a ' || new.idesnv;
    raise exception 'Cambio de estado inválido'
    using hint = Vmensaje;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.f_validar_nove() OWNER TO admin;

--
-- Name: f_validar_nove_ins(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_validar_nove_ins() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  Vmensaje varchar(1000);
begin
  if new.idesnv != 1 then
    Vmensaje := 'Una nueva nota de venta solo puede tener estado 1';
    raise exception 'Estado para nueva nota de venta inválido'
    using hint = Vmensaje;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.f_validar_nove_ins() OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ceco_seq OWNER TO admin;

--
-- Name: clientes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE clientes (
    id numeric(20,0) NOT NULL,
    idgrem numeric(20,0) NOT NULL,
    idpais numeric(20,0) NOT NULL,
    identificador1 character varying(50) NOT NULL,
    identificador2 character varying(50) NOT NULL,
    idticl numeric(20,0) NOT NULL,
    razonsocial character varying(100),
    nombrefantasia character varying(100),
    primernombre character varying(100),
    segundonombre character varying(100),
    apellidopaterno character varying(100),
    apellidomaterno character varying(100),
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone,
    CONSTRAINT clie_chk_01 CHECK (((((((idticl = (1)::numeric) AND (razonsocial IS NULL)) AND (nombrefantasia IS NULL)) AND (primernombre IS NOT NULL)) AND (apellidopaterno IS NOT NULL)) OR (((((((idticl = (2)::numeric) AND (razonsocial IS NOT NULL)) AND (nombrefantasia IS NOT NULL)) AND (primernombre IS NULL)) AND (segundonombre IS NULL)) AND (apellidopaterno IS NULL)) AND (apellidomaterno IS NULL))))
);


ALTER TABLE public.clientes OWNER TO admin;

--
-- Name: clie; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW clie AS
    SELECT clientes.id, clientes.idgrem, clientes.idpais, clientes.identificador1, clientes.identificador2, clientes.idticl, clientes.razonsocial, clientes.nombrefantasia, clientes.primernombre, clientes.segundonombre, clientes.apellidopaterno, clientes.apellidomaterno, clientes.idusuacrearegistro, clientes.fechacrearegistro, clientes.idusuamodifregistro, clientes.fechamodifregistro, clientes.idusuaborraregistro, clientes.fechaborraregistro FROM clientes;


ALTER TABLE public.clie OWNER TO admin;

--
-- Name: clie_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE clie_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clie_seq OWNER TO admin;

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
-- Name: tipos_clientes; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE tipos_clientes (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.tipos_clientes OWNER TO admin;

--
-- Name: cliev; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW cliev AS
    SELECT clie.id, clie.idgrem, grem.alias AS holding, clie.idpais, pais.nombre AS pais, clie.identificador1, clie.identificador2, clie.idticl, ticl.descripcion AS tipo_cliente, clie.razonsocial, clie.nombrefantasia, clie.primernombre, clie.segundonombre, clie.apellidopaterno, clie.apellidomaterno FROM (((clientes clie LEFT JOIN grupos_empresariales grem ON ((clie.idgrem = grem.id))) LEFT JOIN paises pais ON ((clie.idpais = pais.id))) LEFT JOIN tipos_clientes ticl ON ((clie.idticl = ticl.id))) WHERE ((clie.idusuaborraregistro IS NULL) AND (grem.idusuaborraregistro IS NULL));


ALTER TABLE public.cliev OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cosh_seq OWNER TO admin;

--
-- Name: cotizaciones_ventas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE cotizaciones_ventas (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    numero numeric(20,0) NOT NULL,
    idclie numeric(20,0) NOT NULL,
    descripcioncotizacion character varying(1000) NOT NULL,
    idgere numeric(20,0),
    idproy numeric(20,0),
    idline numeric(20,0),
    idceco numeric(20,0),
    idtare numeric(20,0),
    exento numeric(20,0) NOT NULL,
    afecto numeric(20,0) NOT NULL,
    impuestos numeric(20,0) NOT NULL,
    porcentajedescuento numeric(20,5) NOT NULL,
    montodescuento numeric(20,0) NOT NULL,
    total numeric(20,0) NOT NULL,
    diasvalidez numeric(20,0) NOT NULL,
    idescv numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.cotizaciones_ventas OWNER TO admin;

--
-- Name: cove; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW cove AS
    SELECT cotizaciones_ventas.id, cotizaciones_ventas.idempr, cotizaciones_ventas.numero, cotizaciones_ventas.idclie, cotizaciones_ventas.descripcioncotizacion, cotizaciones_ventas.idgere, cotizaciones_ventas.idproy, cotizaciones_ventas.idline, cotizaciones_ventas.idceco, cotizaciones_ventas.idtare, cotizaciones_ventas.exento, cotizaciones_ventas.afecto, cotizaciones_ventas.impuestos, cotizaciones_ventas.porcentajedescuento, cotizaciones_ventas.montodescuento, cotizaciones_ventas.total, cotizaciones_ventas.diasvalidez, cotizaciones_ventas.idescv, cotizaciones_ventas.idusuacrearegistro, cotizaciones_ventas.fechacrearegistro, cotizaciones_ventas.idusuamodifregistro, cotizaciones_ventas.fechamodifregistro, cotizaciones_ventas.idusuaborraregistro, cotizaciones_ventas.fechaborraregistro FROM cotizaciones_ventas;


ALTER TABLE public.cove OWNER TO admin;

--
-- Name: cove_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE cove_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cove_seq OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcsh_seq OWNER TO admin;

--
-- Name: detalles_cotizs_vtas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE detalles_cotizs_vtas (
    id numeric(20,0) NOT NULL,
    idcove numeric(20,0) NOT NULL,
    correlativo numeric(20,0) NOT NULL,
    idprod numeric(20,0),
    idserv numeric(20,0),
    preciounitario numeric(20,0) NOT NULL,
    cantidad numeric(20,2) NOT NULL,
    porcentajedescuento numeric(20,5) NOT NULL,
    montodescuento numeric(20,0) NOT NULL,
    exento numeric(20,0) NOT NULL,
    afecto numeric(20,0) NOT NULL,
    impuestos numeric(20,2) NOT NULL,
    totallinea numeric(20,2) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone,
    CONSTRAINT decv_chk_01 CHECK ((((idprod IS NOT NULL) AND (idserv IS NULL)) OR ((idprod IS NULL) AND (idserv IS NOT NULL))))
);


ALTER TABLE public.detalles_cotizs_vtas OWNER TO admin;

--
-- Name: decv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW decv AS
    SELECT detalles_cotizs_vtas.id, detalles_cotizs_vtas.idcove, detalles_cotizs_vtas.correlativo, detalles_cotizs_vtas.idprod, detalles_cotizs_vtas.idserv, detalles_cotizs_vtas.preciounitario, detalles_cotizs_vtas.cantidad, detalles_cotizs_vtas.porcentajedescuento, detalles_cotizs_vtas.montodescuento, detalles_cotizs_vtas.exento, detalles_cotizs_vtas.afecto, detalles_cotizs_vtas.impuestos, detalles_cotizs_vtas.totallinea, detalles_cotizs_vtas.idusuacrearegistro, detalles_cotizs_vtas.fechacrearegistro, detalles_cotizs_vtas.idusuamodifregistro, detalles_cotizs_vtas.fechamodifregistro, detalles_cotizs_vtas.idusuaborraregistro, detalles_cotizs_vtas.fechaborraregistro FROM detalles_cotizs_vtas;


ALTER TABLE public.decv OWNER TO admin;

--
-- Name: decv_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE decv_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.decv_seq OWNER TO admin;

--
-- Name: detalles_doctos_vtas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE detalles_doctos_vtas (
    id numeric(20,0) NOT NULL,
    iddove numeric(20,0) NOT NULL,
    correlativo numeric(20,0) NOT NULL,
    idprod numeric(20,0),
    idserv numeric(20,0),
    preciounitario numeric(20,0) NOT NULL,
    cantidad numeric(20,2) NOT NULL,
    porcentajedescuento numeric(20,5) NOT NULL,
    montodescuento numeric(20,0) NOT NULL,
    exento numeric(20,0) NOT NULL,
    afecto numeric(20,0) NOT NULL,
    impuestos numeric(20,2) NOT NULL,
    totallinea numeric(20,2) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone,
    CONSTRAINT dedv_chk_01 CHECK ((((idprod IS NOT NULL) AND (idserv IS NULL)) OR ((idprod IS NULL) AND (idserv IS NOT NULL))))
);


ALTER TABLE public.detalles_doctos_vtas OWNER TO admin;

--
-- Name: dedv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW dedv AS
    SELECT detalles_doctos_vtas.id, detalles_doctos_vtas.iddove, detalles_doctos_vtas.correlativo, detalles_doctos_vtas.idprod, detalles_doctos_vtas.idserv, detalles_doctos_vtas.preciounitario, detalles_doctos_vtas.cantidad, detalles_doctos_vtas.porcentajedescuento, detalles_doctos_vtas.montodescuento, detalles_doctos_vtas.exento, detalles_doctos_vtas.afecto, detalles_doctos_vtas.impuestos, detalles_doctos_vtas.totallinea, detalles_doctos_vtas.idusuacrearegistro, detalles_doctos_vtas.fechacrearegistro, detalles_doctos_vtas.idusuamodifregistro, detalles_doctos_vtas.fechamodifregistro, detalles_doctos_vtas.idusuaborraregistro, detalles_doctos_vtas.fechaborraregistro FROM detalles_doctos_vtas;


ALTER TABLE public.dedv OWNER TO admin;

--
-- Name: dedv_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE dedv_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dedv_seq OWNER TO admin;

--
-- Name: detalles_notas_vtas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE detalles_notas_vtas (
    id numeric(20,0) NOT NULL,
    idnove numeric(20,0) NOT NULL,
    correlativo numeric(20,0) NOT NULL,
    idprod numeric(20,0),
    idserv numeric(20,0),
    preciounitario numeric(20,0) NOT NULL,
    cantidad numeric(20,2) NOT NULL,
    porcentajedescuento numeric(20,5) NOT NULL,
    montodescuento numeric(20,0) NOT NULL,
    exento numeric(20,2) NOT NULL,
    afecto numeric(20,2) NOT NULL,
    impuestos numeric(20,2) NOT NULL,
    totallinea numeric(20,2) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone,
    CONSTRAINT denv_chk_01 CHECK ((((idprod IS NOT NULL) AND (idserv IS NULL)) OR ((idprod IS NULL) AND (idserv IS NOT NULL))))
);


ALTER TABLE public.detalles_notas_vtas OWNER TO admin;

--
-- Name: denv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW denv AS
    SELECT detalles_notas_vtas.id, detalles_notas_vtas.idnove, detalles_notas_vtas.correlativo, detalles_notas_vtas.idprod, detalles_notas_vtas.idserv, detalles_notas_vtas.preciounitario, detalles_notas_vtas.cantidad, detalles_notas_vtas.porcentajedescuento, detalles_notas_vtas.montodescuento, detalles_notas_vtas.exento, detalles_notas_vtas.afecto, detalles_notas_vtas.impuestos, detalles_notas_vtas.totallinea, detalles_notas_vtas.idusuacrearegistro, detalles_notas_vtas.fechacrearegistro, detalles_notas_vtas.idusuamodifregistro, detalles_notas_vtas.fechamodifregistro, detalles_notas_vtas.idusuaborraregistro, detalles_notas_vtas.fechaborraregistro FROM detalles_notas_vtas;


ALTER TABLE public.denv OWNER TO admin;

--
-- Name: denv_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE denv_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.denv_seq OWNER TO admin;

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
    nombreoriginal character varying(500) NOT NULL,
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
    CONSTRAINT dole_chk_02 CHECK (((((fechaaviso IS NULL) AND (emailaviso IS NULL)) AND (avisodado IS NULL)) OR (((fechaaviso IS NOT NULL) AND (emailaviso IS NOT NULL)) AND (avisodado IS NOT NULL)))),
    CONSTRAINT dole_chk_03 CHECK ((fecha < fechaaviso)),
    CONSTRAINT dole_chk_04 CHECK ((fecha <= fechacrearegistro)),
    CONSTRAINT dole_chk_05 CHECK ((fechaaviso > fechacrearegistro))
);


ALTER TABLE public.documentos_legales OWNER TO admin;

--
-- Name: documentos_ventas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE documentos_ventas (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    idnove numeric(20,0),
    idtidv numeric(20,0) NOT NULL,
    numero numeric(20,0) NOT NULL,
    idclie numeric(20,0) NOT NULL,
    descripciondoctoventa character varying(1000) NOT NULL,
    idgere numeric(20,0),
    idproy numeric(20,0),
    idline numeric(20,0),
    idceco numeric(20,0),
    idtare numeric(20,0),
    exento numeric(20,0) NOT NULL,
    afecto numeric(20,0) NOT NULL,
    impuestos numeric(20,0) NOT NULL,
    porcentajedescuento numeric(20,5) NOT NULL,
    montodescuento numeric(20,0) NOT NULL,
    total numeric(20,0) NOT NULL,
    idesve numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.documentos_ventas OWNER TO admin;

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
    START WITH 25
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dole_seq OWNER TO admin;

--
-- Name: empresas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE empresas (
    id numeric(20,0) NOT NULL,
    idgrem numeric(20,0) NOT NULL,
    idpais numeric(20,0) NOT NULL,
    idrubr numeric(20,0) NOT NULL,
    idesre numeric(20,0) NOT NULL,
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
-- Name: estados_documentos_legales; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estados_documentos_legales (
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


ALTER TABLE public.estados_documentos_legales OWNER TO admin;

--
-- Name: tipos_documentos_legales; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE tipos_documentos_legales (
    id numeric(20,0) NOT NULL,
    idgrem numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL,
    descripcioncorta character varying(15) NOT NULL,
    color character varying(50) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.tipos_documentos_legales OWNER TO admin;

--
-- Name: dolev; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW dolev AS
    SELECT dole.id, dole.idempr, empr.nombrefantasia AS empresa, dole.idtidl, tidl.descripcion AS tipodocumentolegal, dole.nombreoriginal, dole.nombresistema, dole.idesdl, esdl.descripcion AS estadodocumentolegal, dole.fecha, dole.notaria, dole.foja, dole.responsable, dole.comentario, dole.fechaaviso, dole.emailaviso, dole.avisodado FROM (((documentos_legales dole LEFT JOIN empresas empr ON ((dole.idempr = empr.id))) LEFT JOIN tipos_documentos_legales tidl ON ((dole.idtidl = tidl.id))) LEFT JOIN estados_documentos_legales esdl ON ((dole.idesdl = esdl.id))) WHERE (empr.idusuaborraregistro IS NULL);


ALTER TABLE public.dolev OWNER TO admin;

--
-- Name: dominios; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE dominios (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.dominios OWNER TO admin;

--
-- Name: domi; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW domi AS
    SELECT dominios.id, dominios.descripcion, dominios.idusuacrearegistro, dominios.fechacrearegistro, dominios.idusuamodifregistro, dominios.fechamodifregistro, dominios.idusuaborraregistro, dominios.fechaborraregistro FROM dominios;


ALTER TABLE public.domi OWNER TO admin;

--
-- Name: domi_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE domi_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.domi_seq OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dosh_seq OWNER TO admin;

--
-- Name: dove; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW dove AS
    SELECT documentos_ventas.id, documentos_ventas.idempr, documentos_ventas.idnove, documentos_ventas.idtidv, documentos_ventas.numero, documentos_ventas.idclie, documentos_ventas.descripciondoctoventa, documentos_ventas.idgere, documentos_ventas.idproy, documentos_ventas.idline, documentos_ventas.idceco, documentos_ventas.idtare, documentos_ventas.exento, documentos_ventas.afecto, documentos_ventas.impuestos, documentos_ventas.porcentajedescuento, documentos_ventas.montodescuento, documentos_ventas.total, documentos_ventas.idesve, documentos_ventas.idusuacrearegistro, documentos_ventas.fechacrearegistro, documentos_ventas.idusuamodifregistro, documentos_ventas.fechamodifregistro, documentos_ventas.idusuaborraregistro, documentos_ventas.fechaborraregistro FROM documentos_ventas;


ALTER TABLE public.dove OWNER TO admin;

--
-- Name: dove_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE dove_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dove_seq OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ecsh_seq OWNER TO admin;

--
-- Name: empr; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW empr AS
    SELECT empresas.id, empresas.idgrem, empresas.idpais, empresas.idrubr, empresas.idesre, empresas.identificador1, empresas.identificador2, empresas.razonsocial, empresas.nombrefantasia, empresas.icono, empresas.idusuacrearegistro, empresas.fechacrearegistro, empresas.idusuamodifregistro, empresas.fechamodifregistro, empresas.idusuaborraregistro, empresas.fechaborraregistro, empresas.xfld FROM empresas;


ALTER TABLE public.empr OWNER TO admin;

--
-- Name: empr_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE empr_seq
    START WITH 12
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.empr_seq OWNER TO admin;

--
-- Name: estados_registros; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estados_registros (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_registros OWNER TO admin;

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
-- Name: emprv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW emprv AS
    SELECT empr.id, empr.idgrem, grem.nombre AS holding, empr.idpais, pais.nombre AS pais, empr.idrubr, rubr.descripcion AS rubro, empr.idesre, esre.descripcion AS estadoregistro, empr.identificador1, empr.identificador2, empr.razonsocial, empr.nombrefantasia, empr.icono FROM ((((empresas empr LEFT JOIN grupos_empresariales grem ON ((empr.idgrem = grem.id))) LEFT JOIN paises pais ON ((empr.idpais = pais.id))) LEFT JOIN rubros rubr ON ((empr.idrubr = rubr.id))) LEFT JOIN estados_registros esre ON ((empr.idesre = esre.id))) WHERE ((empr.idusuaborraregistro IS NULL) AND (grem.idusuaborraregistro IS NULL));


ALTER TABLE public.emprv OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eosh_seq OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.epos_seq OWNER TO admin;

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
    START WITH 5
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.esci_seq OWNER TO admin;

--
-- Name: estados_cotizaciones_vtas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estados_cotizaciones_vtas (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_cotizaciones_vtas OWNER TO admin;

--
-- Name: escv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW escv AS
    SELECT estados_cotizaciones_vtas.id, estados_cotizaciones_vtas.descripcion FROM estados_cotizaciones_vtas;


ALTER TABLE public.escv OWNER TO admin;

--
-- Name: escv_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE escv_seq
    START WITH 5
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.escv_seq OWNER TO admin;

--
-- Name: esdl; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW esdl AS
    SELECT estados_documentos_legales.id, estados_documentos_legales.idgrem, estados_documentos_legales.descripcion, estados_documentos_legales.idusuacrearegistro, estados_documentos_legales.fechacrearegistro, estados_documentos_legales.idusuamodifregistro, estados_documentos_legales.fechamodifregistro, estados_documentos_legales.idusuaborraregistro, estados_documentos_legales.fechaborraregistro FROM estados_documentos_legales;


ALTER TABLE public.esdl OWNER TO admin;

--
-- Name: esdl_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE esdl_seq
    START WITH 13
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.esdl_seq OWNER TO admin;

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
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.esge_seq OWNER TO admin;

--
-- Name: estados_notas_vtas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estados_notas_vtas (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_notas_vtas OWNER TO admin;

--
-- Name: esnv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW esnv AS
    SELECT estados_notas_vtas.id, estados_notas_vtas.descripcion FROM estados_notas_vtas;


ALTER TABLE public.esnv OWNER TO admin;

--
-- Name: esnv_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE esnv_seq
    START WITH 5
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.esnv_seq OWNER TO admin;

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
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.esre_seq OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.essh_seq OWNER TO admin;

--
-- Name: estados_ventas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE estados_ventas (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_ventas OWNER TO admin;

--
-- Name: esve; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW esve AS
    SELECT estados_ventas.id, estados_ventas.descripcion FROM estados_ventas;


ALTER TABLE public.esve OWNER TO admin;

--
-- Name: esve_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE esve_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.esve_seq OWNER TO admin;

--
-- Name: fide_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE fide_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fide_seq OWNER TO admin;

--
-- Name: field_defs; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE field_defs (
    id numeric(11,0) NOT NULL,
    form_id numeric(11,0) NOT NULL,
    forder numeric(11,0) NOT NULL,
    name character varying(30) NOT NULL,
    type character varying(10) NOT NULL,
    len numeric(11,0) NOT NULL,
    decim numeric(11,0) NOT NULL,
    pk character varying(1) NOT NULL,
    req character varying(1) NOT NULL,
    caption character varying(50) NOT NULL,
    gadget character varying(10) NOT NULL,
    size numeric(11,0) NOT NULL,
    maxlength numeric(11,0) NOT NULL,
    rows numeric(11,0) NOT NULL,
    cols numeric(11,0) NOT NULL,
    selvalues character varying(500) DEFAULT NULL::character varying,
    sqlvalues character varying(500) DEFAULT NULL::character varying,
    visible character varying(1) NOT NULL,
    readonly character varying(1) NOT NULL,
    fld_type character varying(1) NOT NULL,
    fld_offset numeric(11,0) NOT NULL
);


ALTER TABLE public.field_defs OWNER TO admin;

--
-- Name: fode_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE fode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fode_seq OWNER TO admin;

--
-- Name: form_defs; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE form_defs (
    id numeric(11,0) NOT NULL,
    caption character varying(50) NOT NULL,
    table_name character varying(30) NOT NULL,
    ins_allowed character varying(1) NOT NULL,
    upd_allowed character varying(1) NOT NULL,
    del_allowed character varying(1) NOT NULL
);


ALTER TABLE public.form_defs OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gere_seq OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grem_seq OWNER TO admin;

--
-- Name: gremv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW gremv AS
    SELECT grem.id, grem.nombre, grem.alias, grem.icono, grem.idpais, pais.nombre AS pais, grem.idesge, esge.descripcion AS estadoholding FROM ((grupos_empresariales grem LEFT JOIN paises pais ON ((grem.idpais = pais.id))) LEFT JOIN estados_grem esge ON ((grem.idesge = esge.id))) WHERE (grem.idusuaborraregistro IS NULL);


ALTER TABLE public.gremv OWNER TO admin;

--
-- Name: impuestos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE impuestos (
    id numeric(20,0) NOT NULL,
    idpais numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL,
    descripcioncorta character varying(10) NOT NULL,
    obligatorio character varying(1) NOT NULL,
    valor numeric(20,1) NOT NULL,
    CONSTRAINT impu_chk_01 CHECK (((obligatorio)::text = ANY ((ARRAY['S'::character varying, 'N'::character varying])::text[])))
);


ALTER TABLE public.impuestos OWNER TO admin;

--
-- Name: impu; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW impu AS
    SELECT impuestos.id, impuestos.idpais, impuestos.descripcion, impuestos.descripcioncorta, impuestos.obligatorio, impuestos.valor FROM impuestos;


ALTER TABLE public.impu OWNER TO admin;

--
-- Name: impu_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE impu_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.impu_seq OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.line_seq OWNER TO admin;

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
    START WITH 503
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mone_seq OWNER TO admin;

--
-- Name: notas_ventas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE notas_ventas (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    idcove numeric(20,0),
    numero numeric(20,0) NOT NULL,
    idclie numeric(20,0) NOT NULL,
    descripcionnotaventa character varying(1000) NOT NULL,
    idgere numeric(20,0),
    idproy numeric(20,0),
    idline numeric(20,0),
    idceco numeric(20,0),
    idtare numeric(20,0),
    exento numeric(20,0) NOT NULL,
    afecto numeric(20,0) NOT NULL,
    impuestos numeric(20,0) NOT NULL,
    porcentajedescuento numeric(20,5) NOT NULL,
    montodescuento numeric(20,0) NOT NULL,
    total numeric(20,0) NOT NULL,
    idesnv numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.notas_ventas OWNER TO admin;

--
-- Name: nove; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW nove AS
    SELECT notas_ventas.id, notas_ventas.idempr, notas_ventas.idcove, notas_ventas.numero, notas_ventas.idclie, notas_ventas.descripcionnotaventa, notas_ventas.idgere, notas_ventas.idproy, notas_ventas.idline, notas_ventas.idceco, notas_ventas.idtare, notas_ventas.exento, notas_ventas.afecto, notas_ventas.impuestos, notas_ventas.porcentajedescuento, notas_ventas.montodescuento, notas_ventas.total, notas_ventas.idesnv, notas_ventas.idusuacrearegistro, notas_ventas.fechacrearegistro, notas_ventas.idusuamodifregistro, notas_ventas.fechamodifregistro, notas_ventas.idusuaborraregistro, notas_ventas.fechaborraregistro FROM notas_ventas;


ALTER TABLE public.nove OWNER TO admin;

--
-- Name: nove_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE nove_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nove_seq OWNER TO admin;

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
-- Name: origenes_productos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE origenes_productos (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL,
    descripcioncorta character varying(10) NOT NULL
);


ALTER TABLE public.origenes_productos OWNER TO admin;

--
-- Name: orpr; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW orpr AS
    SELECT origenes_productos.id, origenes_productos.descripcion, origenes_productos.descripcioncorta FROM origenes_productos;


ALTER TABLE public.orpr OWNER TO admin;

--
-- Name: orpr_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE orpr_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orpr_seq OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orsh_seq OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pais_seq OWNER TO admin;

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
    START WITH 21
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.para_seq OWNER TO admin;

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
    START WITH 215
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pepr_seq OWNER TO admin;

--
-- Name: perfiles; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE perfiles (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.perfiles OWNER TO admin;

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
-- Name: peprv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW peprv AS
    SELECT pepr.id, pepr.idperf, perf.descripcion AS perfil, pepr.idprog, prog.titulo AS programa FROM ((perfiles_programas pepr LEFT JOIN perfiles perf ON ((pepr.idperf = perf.id))) LEFT JOIN programas prog ON ((pepr.idprog = prog.id))) WHERE (pepr.idusuaborraregistro IS NULL);


ALTER TABLE public.peprv OWNER TO admin;

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
    START WITH 2025
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.perf_seq OWNER TO admin;

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
    apellidomaterno character varying(100),
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
-- Name: perfilamientov; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW perfilamientov AS
    (SELECT NULL::text AS id_holding, '--'::character varying AS holding, NULL::text AS id_empresa, '--'::text AS empresa, perf.id AS id_perfil, perf.descripcion AS perfil, usua.username FROM personas pers, usuarios usua, usuarios_perfiles uspe, perfiles perf WHERE (((((((((pers.id = usua.idpers) AND (usua.id = uspe.idusua)) AND (uspe.idperf = perf.id)) AND (uspe.idgrem IS NULL)) AND (uspe.idempr IS NULL)) AND (perf.id = (1)::numeric)) AND (pers.idusuaborraregistro IS NULL)) AND (usua.idusuaborraregistro IS NULL)) AND (uspe.idusuaborraregistro IS NULL)) UNION SELECT to_char(grem.id, '9999999999'::text) AS id_holding, grem.nombre AS holding, NULL::text AS id_empresa, '--'::text AS empresa, perf.id AS id_perfil, perf.descripcion AS perfil, usua.username FROM personas pers, usuarios usua, usuarios_perfiles uspe, perfiles perf, grupos_empresariales grem WHERE (((((((((((pers.id = usua.idpers) AND (usua.id = uspe.idusua)) AND (uspe.idperf = perf.id)) AND (uspe.idgrem = grem.id)) AND (uspe.idgrem IS NOT NULL)) AND (uspe.idempr IS NULL)) AND (perf.id = (2)::numeric)) AND (pers.idusuaborraregistro IS NULL)) AND (usua.idusuaborraregistro IS NULL)) AND (uspe.idusuaborraregistro IS NULL)) AND (grem.idesge = (1)::numeric))) UNION SELECT to_char(grem.id, '9999999999'::text) AS id_holding, grem.nombre AS holding, to_char(empr.id, '9999999999'::text) AS id_empresa, empr.nombrefantasia AS empresa, perf.id AS id_perfil, perf.descripcion AS perfil, usua.username FROM personas pers, usuarios usua, usuarios_perfiles uspe, perfiles perf, empresas empr, grupos_empresariales grem WHERE (((((((((((((pers.id = usua.idpers) AND (usua.id = uspe.idusua)) AND (uspe.idperf = perf.id)) AND (uspe.idempr = empr.id)) AND (empr.idgrem = grem.id)) AND (uspe.idgrem IS NULL)) AND (uspe.idempr IS NOT NULL)) AND (perf.id <> ALL (ARRAY[(1)::numeric, (2)::numeric]))) AND (pers.idusuaborraregistro IS NULL)) AND (usua.idusuaborraregistro IS NULL)) AND (uspe.idusuaborraregistro IS NULL)) AND (empr.idesre = (1)::numeric)) AND (grem.idesge = (1)::numeric)) ORDER BY 2, 4, 6;


ALTER TABLE public.perfilamientov OWNER TO admin;

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
    START WITH 14
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pers_seq OWNER TO admin;

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
-- Name: persv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW persv AS
    SELECT pers.id, pers.idgrem, grem.alias AS holding, pers.identificador1 AS rut, pers.identificador2 AS dv, pers.primernombre, pers.segundonombre, pers.apellidopaterno, pers.apellidomaterno, pers.email, pers.fechanac, pers.idesci, esci.descripcion AS estadocivil, pers.idsexo, sexo.descripcion AS sexo, pers.idpais, pais.nacionalidad FROM ((((personas pers LEFT JOIN grupos_empresariales grem ON ((pers.idgrem = grem.id))) LEFT JOIN estados_civiles esci ON ((pers.idesci = esci.id))) LEFT JOIN sexos sexo ON ((pers.idsexo = sexo.id))) LEFT JOIN paises pais ON ((pers.idpais = pais.id))) WHERE ((pers.idusuaborraregistro IS NULL) AND (grem.idusuaborraregistro IS NULL));


ALTER TABLE public.persv OWNER TO admin;

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
    START WITH 793
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plcu_seq OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posh_seq OWNER TO admin;

--
-- Name: productos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE productos (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    idtipr numeric(20,0) NOT NULL,
    idunmp numeric(20,0) NOT NULL,
    idorpr numeric(20,0) NOT NULL,
    nombre character varying(1000) NOT NULL,
    valorunitario numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.productos OWNER TO admin;

--
-- Name: prod; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW prod AS
    SELECT productos.id, productos.idempr, productos.idtipr, productos.idunmp, productos.idorpr, productos.nombre, productos.valorunitario, productos.idusuacrearegistro, productos.fechacrearegistro, productos.idusuamodifregistro, productos.fechamodifregistro, productos.idusuaborraregistro, productos.fechaborraregistro FROM productos;


ALTER TABLE public.prod OWNER TO admin;

--
-- Name: prod_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE prod_seq
    START WITH 18
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prod_seq OWNER TO admin;

--
-- Name: tipos_productos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE tipos_productos (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL,
    estaexento character varying(1) NOT NULL,
    CONSTRAINT tipr_chk_01 CHECK (((estaexento)::text = ANY ((ARRAY['S'::character varying, 'N'::character varying])::text[])))
);


ALTER TABLE public.tipos_productos OWNER TO admin;

--
-- Name: unidades_medidas_productos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE unidades_medidas_productos (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL,
    descripcioncorta character varying(10) NOT NULL
);


ALTER TABLE public.unidades_medidas_productos OWNER TO admin;

--
-- Name: prodv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW prodv AS
    SELECT prod.id, prod.idempr, empr.nombrefantasia AS empresa, prod.idtipr, tipr.descripcion AS tipo_producto, prod.idunmp, unmp.descripcion AS unidad_de_medida, unmp.descripcioncorta AS alias_unidad_de_medida, prod.idorpr, orpr.descripcion AS origen, orpr.descripcioncorta AS alias_origen, prod.nombre, prod.valorunitario FROM ((((productos prod LEFT JOIN empresas empr ON ((prod.idempr = empr.id))) LEFT JOIN tipos_productos tipr ON ((prod.idtipr = tipr.id))) LEFT JOIN unidades_medidas_productos unmp ON ((prod.idunmp = unmp.id))) LEFT JOIN origenes_productos orpr ON ((prod.idorpr = orpr.id))) WHERE ((prod.idusuaborraregistro IS NULL) AND (empr.idusuaborraregistro IS NULL));


ALTER TABLE public.prodv OWNER TO admin;

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
    START WITH 11001
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prog_seq OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proy_seq OWNER TO admin;

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
    START WITH 34
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rubr_seq OWNER TO admin;

--
-- Name: servicios; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE servicios (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    idtise numeric(20,0) NOT NULL,
    idunms numeric(20,0) NOT NULL,
    nombre character varying(1000) NOT NULL,
    valorunitario numeric(20,2) NOT NULL,
    idmone numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.servicios OWNER TO admin;

--
-- Name: serv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW serv AS
    SELECT servicios.id, servicios.idempr, servicios.idtise, servicios.idunms, servicios.nombre, servicios.valorunitario, servicios.idmone, servicios.idusuacrearegistro, servicios.fechacrearegistro, servicios.idusuamodifregistro, servicios.fechamodifregistro, servicios.idusuaborraregistro, servicios.fechaborraregistro FROM servicios;


ALTER TABLE public.serv OWNER TO admin;

--
-- Name: serv_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE serv_seq
    START WITH 7
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.serv_seq OWNER TO admin;

--
-- Name: tipos_servicios; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE tipos_servicios (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL,
    estaexento character varying(1) NOT NULL,
    CONSTRAINT tise_chk_01 CHECK (((estaexento)::text = ANY ((ARRAY['S'::character varying, 'N'::character varying])::text[])))
);


ALTER TABLE public.tipos_servicios OWNER TO admin;

--
-- Name: unidades_medidas_servicios; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE unidades_medidas_servicios (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL,
    descripcioncorta character varying(10) NOT NULL
);


ALTER TABLE public.unidades_medidas_servicios OWNER TO admin;

--
-- Name: servv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW servv AS
    SELECT serv.id, serv.idempr, empr.nombrefantasia AS empresa, serv.idtise, tise.descripcion AS tipo_servicio, serv.idunms, unms.descripcion AS unidad_medida_servicio, unms.descripcioncorta AS alias_unidad_medida_servicio, serv.nombre, serv.valorunitario, serv.idmone, mone.nombre AS moneda, mone.nombrecorto AS alias_moneda FROM ((((servicios serv LEFT JOIN empresas empr ON ((serv.idempr = empr.id))) LEFT JOIN tipos_servicios tise ON ((serv.idtise = tise.id))) LEFT JOIN unidades_medidas_servicios unms ON ((serv.idunms = unms.id))) LEFT JOIN monedas mone ON ((serv.idmone = mone.id))) WHERE ((serv.idusuaborraregistro IS NULL) AND (empr.idusuaborraregistro IS NULL));


ALTER TABLE public.servv OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sexo_seq OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sosh_seq OWNER TO admin;

--
-- Name: tablas_secuencias; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE tablas_secuencias (
    tabla character varying(1000) NOT NULL,
    secuencia character varying(1000) NOT NULL
);


ALTER TABLE public.tablas_secuencias OWNER TO admin;

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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tare_seq OWNER TO admin;

--
-- Name: ticl; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW ticl AS
    SELECT tipos_clientes.id, tipos_clientes.descripcion FROM tipos_clientes;


ALTER TABLE public.ticl OWNER TO admin;

--
-- Name: ticl_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE ticl_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticl_seq OWNER TO admin;

--
-- Name: tipos_cotizaciones_vtas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE tipos_cotizaciones_vtas (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.tipos_cotizaciones_vtas OWNER TO admin;

--
-- Name: ticv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW ticv AS
    SELECT tipos_cotizaciones_vtas.id, tipos_cotizaciones_vtas.descripcion FROM tipos_cotizaciones_vtas;


ALTER TABLE public.ticv OWNER TO admin;

--
-- Name: ticv_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE ticv_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticv_seq OWNER TO admin;

--
-- Name: tidl; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW tidl AS
    SELECT tipos_documentos_legales.id, tipos_documentos_legales.idgrem, tipos_documentos_legales.descripcion, tipos_documentos_legales.descripcioncorta, tipos_documentos_legales.color, tipos_documentos_legales.idusuacrearegistro, tipos_documentos_legales.fechacrearegistro, tipos_documentos_legales.idusuamodifregistro, tipos_documentos_legales.fechamodifregistro, tipos_documentos_legales.idusuaborraregistro, tipos_documentos_legales.fechaborraregistro FROM tipos_documentos_legales;


ALTER TABLE public.tidl OWNER TO admin;

--
-- Name: tidl_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE tidl_seq
    START WITH 17
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tidl_seq OWNER TO admin;

--
-- Name: tipos_doctos_ventas; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE tipos_doctos_ventas (
    id numeric(20,0) NOT NULL,
    idpais numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL,
    descripcioncorta character varying(10) NOT NULL,
    codigooficial character varying(10) NOT NULL
);


ALTER TABLE public.tipos_doctos_ventas OWNER TO admin;

--
-- Name: tidv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW tidv AS
    SELECT tipos_doctos_ventas.id, tipos_doctos_ventas.idpais, tipos_doctos_ventas.descripcion, tipos_doctos_ventas.descripcioncorta, tipos_doctos_ventas.codigooficial FROM tipos_doctos_ventas;


ALTER TABLE public.tidv OWNER TO admin;

--
-- Name: tidv_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE tidv_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tidv_seq OWNER TO admin;

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
    START WITH 7
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tifp_seq OWNER TO admin;

--
-- Name: tipos_productos_impuestos; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE tipos_productos_impuestos (
    id numeric(20,0) NOT NULL,
    idtipr numeric(20,0) NOT NULL,
    idimpu numeric(20,0) NOT NULL
);


ALTER TABLE public.tipos_productos_impuestos OWNER TO admin;

--
-- Name: tipi; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW tipi AS
    SELECT tipos_productos_impuestos.id, tipos_productos_impuestos.idtipr, tipos_productos_impuestos.idimpu FROM tipos_productos_impuestos;


ALTER TABLE public.tipi OWNER TO admin;

--
-- Name: tipi_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE tipi_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipi_seq OWNER TO admin;

--
-- Name: tipiv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW tipiv AS
    SELECT tipi.id, tipr.id AS idtipr, tipr.descripcion AS tipo_producto, impu.id AS idimpu, impu.descripcion AS impuesto, impu.descripcioncorta AS alias_impuesto, impu.valor FROM ((tipos_productos_impuestos tipi LEFT JOIN tipos_productos tipr ON ((tipi.idtipr = tipr.id))) LEFT JOIN impuestos impu ON ((tipi.idimpu = impu.id)));


ALTER TABLE public.tipiv OWNER TO admin;

--
-- Name: tipr; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW tipr AS
    SELECT tipos_productos.id, tipos_productos.descripcion, tipos_productos.estaexento FROM tipos_productos;


ALTER TABLE public.tipr OWNER TO admin;

--
-- Name: tipr_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE tipr_seq
    START WITH 16
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipr_seq OWNER TO admin;

--
-- Name: tise; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW tise AS
    SELECT tipos_servicios.id, tipos_servicios.descripcion, tipos_servicios.estaexento FROM tipos_servicios;


ALTER TABLE public.tise OWNER TO admin;

--
-- Name: tise_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE tise_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tise_seq OWNER TO admin;

--
-- Name: unidades_territoriales_1; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE unidades_territoriales_1 (
    id numeric(20,0) NOT NULL,
    idpais numeric(20,0) NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.unidades_territoriales_1 OWNER TO admin;

--
-- Name: unidades_territoriales_2; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE unidades_territoriales_2 (
    id numeric(20,0) NOT NULL,
    idunt1 numeric(20,0) NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.unidades_territoriales_2 OWNER TO admin;

--
-- Name: unidades_territoriales_3; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE unidades_territoriales_3 (
    id numeric(20,0) NOT NULL,
    idunt2 numeric(20,0) NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.unidades_territoriales_3 OWNER TO admin;

--
-- Name: unmp; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW unmp AS
    SELECT unidades_medidas_productos.id, unidades_medidas_productos.descripcion, unidades_medidas_productos.descripcioncorta FROM unidades_medidas_productos;


ALTER TABLE public.unmp OWNER TO admin;

--
-- Name: unmp_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE unmp_seq
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unmp_seq OWNER TO admin;

--
-- Name: unms; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW unms AS
    SELECT unidades_medidas_servicios.id, unidades_medidas_servicios.descripcion, unidades_medidas_servicios.descripcioncorta FROM unidades_medidas_servicios;


ALTER TABLE public.unms OWNER TO admin;

--
-- Name: unms_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE unms_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unms_seq OWNER TO admin;

--
-- Name: unt1; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW unt1 AS
    SELECT unidades_territoriales_1.id, unidades_territoriales_1.idpais, unidades_territoriales_1.nombre FROM unidades_territoriales_1;


ALTER TABLE public.unt1 OWNER TO admin;

--
-- Name: unt1_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE unt1_seq
    START WITH 17
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unt1_seq OWNER TO admin;

--
-- Name: unt2; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW unt2 AS
    SELECT unidades_territoriales_2.id, unidades_territoriales_2.idunt1, unidades_territoriales_2.nombre FROM unidades_territoriales_2;


ALTER TABLE public.unt2 OWNER TO admin;

--
-- Name: unt2_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE unt2_seq
    START WITH 57
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unt2_seq OWNER TO admin;

--
-- Name: unt3; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW unt3 AS
    SELECT unidades_territoriales_3.id, unidades_territoriales_3.idunt2, unidades_territoriales_3.nombre FROM unidades_territoriales_3;


ALTER TABLE public.unt3 OWNER TO admin;

--
-- Name: unt3_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE unt3_seq
    START WITH 368
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unt3_seq OWNER TO admin;

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
    START WITH 1062
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.uspe_seq OWNER TO admin;

--
-- Name: uspev; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW uspev AS
    SELECT uspe.id, uspe.idusua, usua.username, uspe.idperf, perf.descripcion AS perfil, uspe.idgrem, grem.nombre AS holding, uspe.idempr, empr.razonsocial, uspe.idesre, esre.descripcion AS estadoregistro FROM (((((usuarios_perfiles uspe LEFT JOIN usuarios usua ON ((uspe.idusua = usua.id))) LEFT JOIN perfiles perf ON ((uspe.idperf = perf.id))) LEFT JOIN grupos_empresariales grem ON ((uspe.idgrem = grem.id))) LEFT JOIN empresas empr ON ((uspe.idempr = empr.id))) LEFT JOIN estados_registros esre ON ((uspe.idesre = esre.id))) WHERE ((((uspe.idusuaborraregistro IS NULL) AND (usua.idusuaborraregistro IS NULL)) AND (grem.idusuaborraregistro IS NULL)) AND (empr.idusuaborraregistro IS NULL));


ALTER TABLE public.uspev OWNER TO admin;

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
    START WITH 14
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usua_seq OWNER TO admin;

--
-- Name: valores_dominios; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE valores_dominios (
    id numeric(20,0) NOT NULL,
    iddomi numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.valores_dominios OWNER TO admin;

--
-- Name: vado; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW vado AS
    SELECT valores_dominios.id, valores_dominios.iddomi, valores_dominios.descripcion, valores_dominios.idusuacrearegistro, valores_dominios.fechacrearegistro, valores_dominios.idusuamodifregistro, valores_dominios.fechamodifregistro, valores_dominios.idusuaborraregistro, valores_dominios.fechaborraregistro FROM valores_dominios;


ALTER TABLE public.vado OWNER TO admin;

--
-- Name: vado_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE vado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vado_seq OWNER TO admin;

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
    START WITH 91
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vapa_seq OWNER TO admin;

--
-- Name: ceco_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('ceco_seq', 48, true);


--
-- Data for Name: centros_costos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY centros_costos (id, idempr, nombre, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	2	ZONA CENTRO - PRODUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
2	2	ZONA CENTRO - ADMINISTRACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
3	2	ZONA CENTRO - VENTAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
4	2	ZONA NORTE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
5	2	ZONA SUR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
6	3	ZONA CENTRO - PRODUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
7	3	ZONA CENTRO - ADMINISTRACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
8	3	ZONA CENTRO - VENTAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
9	3	ZONA NORTE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
10	3	ZONA SUR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
11	4	ZONA CENTRO - PRODUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
12	4	ZONA CENTRO - ADMINISTRACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
13	4	ZONA CENTRO - VENTAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
14	4	ZONA NORTE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
15	4	ZONA SUR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
16	5	ZONA CENTRO - PRODUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
17	5	ZONA CENTRO - ADMINISTRACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
18	5	ZONA CENTRO - VENTAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
19	5	ZONA NORTE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
20	5	ZONA SUR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
21	6	ZONA CENTRO - PRODUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
22	6	ZONA CENTRO - ADMINISTRACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
23	6	ZONA CENTRO - VENTAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
24	6	ZONA NORTE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
25	6	ZONA SUR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
26	7	ZONA CENTRO - PRODUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
27	7	ZONA CENTRO - ADMINISTRACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
28	7	ZONA CENTRO - VENTAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
29	7	ZONA NORTE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
30	7	ZONA SUR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
31	8	ZONA CENTRO - PRODUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
32	8	ZONA CENTRO - ADMINISTRACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
33	8	ZONA CENTRO - VENTAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
34	8	ZONA NORTE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
35	8	ZONA SUR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
36	9	ZONA CENTRO - PRODUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
37	9	ZONA CENTRO - ADMINISTRACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
38	9	ZONA CENTRO - VENTAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
39	9	ZONA NORTE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
40	9	ZONA SUR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
41	10	ZONA CENTRO - PRODUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
42	10	ZONA CENTRO - ADMINISTRACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
43	10	ZONA CENTRO - VENTAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
44	10	ZONA NORTE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
45	10	ZONA SUR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
46	1	QQQ	3	2017-12-25 13:39:25	\N	\N	\N	\N
47	1	CC 601	3	2017-12-25 18:43:44	\N	\N	\N	\N
48	1	OPERACIONES	3	2017-12-25 18:43:58	\N	\N	\N	\N
\.


--
-- Name: clie_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('clie_seq', 3, true);


--
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY clientes (id, idgrem, idpais, identificador1, identificador2, idticl, razonsocial, nombrefantasia, primernombre, segundonombre, apellidopaterno, apellidomaterno, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	1	1	10917721	0	1	\N	\N	CRISTIAN	\N	PALMA	\N	1	2017-12-24 10:48:08.423181	\N	\N	\N	\N
3	1	1	4709176	4	2	VEAM SPA	VEAM	\N	\N	\N	\N	3	2017-12-26 08:37:59	\N	\N	\N	\N
\.


--
-- Name: cosh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('cosh_seq', 1, false);


--
-- Data for Name: cotizaciones_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY cotizaciones_servs_hono (id, idsosh, idpers, monto, descservofrecido, informeevaluaccotiz, idecsh, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
\.


--
-- Data for Name: cotizaciones_ventas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY cotizaciones_ventas (id, idempr, numero, idclie, descripcioncotizacion, idgere, idproy, idline, idceco, idtare, exento, afecto, impuestos, porcentajedescuento, montodescuento, total, diasvalidez, idescv, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	1	1	1	PRUEBA	\N	\N	\N	\N	\N	0	3000	570	0.00000	0	3570	5	1	1	2017-12-24 10:48:08.423181	\N	\N	\N	\N
\.


--
-- Name: cove_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('cove_seq', 2, false);


--
-- Name: dcsh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('dcsh_seq', 1, false);


--
-- Name: decv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('decv_seq', 3, false);


--
-- Name: dedv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('dedv_seq', 1, false);


--
-- Name: denv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('denv_seq', 1, false);


--
-- Data for Name: detalles_cotizs_vtas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY detalles_cotizs_vtas (id, idcove, correlativo, idprod, idserv, preciounitario, cantidad, porcentajedescuento, montodescuento, exento, afecto, impuestos, totallinea, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	1	1	1	\N	500	2.00	0.00000	0	0	1000	190.00	1190.00	1	2017-12-24 10:48:08.423181	\N	\N	\N	\N
2	1	2	2	\N	100	20.00	0.00000	0	0	2000	380.00	2380.00	1	2017-12-24 10:48:08.423181	\N	\N	\N	\N
\.


--
-- Data for Name: detalles_doctos_vtas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY detalles_doctos_vtas (id, iddove, correlativo, idprod, idserv, preciounitario, cantidad, porcentajedescuento, montodescuento, exento, afecto, impuestos, totallinea, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
\.


--
-- Data for Name: detalles_notas_vtas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY detalles_notas_vtas (id, idnove, correlativo, idprod, idserv, preciounitario, cantidad, porcentajedescuento, montodescuento, exento, afecto, impuestos, totallinea, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
\.


--
-- Data for Name: doctos_cotizacs_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY doctos_cotizacs_servs_hono (id, idcosh, nombrearchivoorig, nombrearchivomodif, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
\.


--
-- Data for Name: doctos_ordenes_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY doctos_ordenes_servs_hono (id, idorsh, nombrearchivoorig, nombrearchivomodif, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
\.


--
-- Data for Name: documentos_legales; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY documentos_legales (id, idempr, idtidl, nombreoriginal, nombresistema, idesdl, fecha, notaria, foja, responsable, comentario, fechaaviso, emailaviso, avisodado, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro, xfld) FROM stdin;
1	1	1	prueba_1.txt	prueba_1.txt	1	2017-12-23	LA UNICA	F1	PEDRO PIEDRA	NINGUNO	2018-01-04	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
2	1	2	prueba_2.txt	prueba_2.txt	1	2017-12-22	LA CUCHUFLETA	100	JUAN SOTO	NADA	2018-01-05	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
3	1	3	prueba_3.txt	prueba_3.txt	1	2017-12-21	PEREZ	500	FERNANDO ASTE	NINGUNA	2018-01-06	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
4	1	4	acta_const_soc.docx	acta_const_soc.docx	1	2017-12-20	RENÉ SANTELICES	700	AGUSTÍN LOPEZ A.	ALGO QUE COMENTAR	2018-01-07	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
5	1	1	prueba_4.txt	prueba_4.txt	1	2017-12-19	ANTONIETA MENDOZA	F10	Pedro LOPEZ B.	TODO QUE COMENTAR	2018-01-08	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
6	1	1	prueba_5.txt	prueba_5.txt	1	2017-12-18	ANTONIETA ESCALA	700	MARIO JOFRÉ M.	NADA QUE COMENTAR	2018-01-09	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
7	1	1	prueba_6.txt	prueba_6.txt	1	2017-12-17	MA. ANTONIETA ESCALA	400	ERNESTO PINTO M.	NADA QUE COMENTAR	2018-01-10	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
8	1	3	prueba_7.txt	prueba_7.txt	1	2017-12-16	MA. ANTONIETA MENDOZA ESCALA	300	AGUSTÍN LOPEZ B.	TODO QUE COMENTAR	2018-01-11	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
9	1	3	prueba_8.txt	prueba_8.txt	1	2017-12-15	RENÉ SANTELICES	500	YULIA JOFRÉ M.	ALGO QUE COMENTAR	2018-01-12	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
10	1	3	prueba_9.txt	prueba_9.txt	1	2017-12-23	RENÉ SANTELICES P.	800	OTILIO JOFRÉ M.	NO COMENTAR	2018-01-04	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
11	1	3	prueba_10.txt	prueba_10.txt	1	2017-12-22	ANTONIETA MENDOZA	100	CLAUDIO LOPEZ B.	NADA QUE COMENTAR	2018-01-05	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
12	1	3	prueba_11.txt	prueba_11.txt	1	2017-12-21	ANTONIETA MENDOZA	F 2	AGUSTÍN JOFRÉ A.	ALGO QUE COMENTAR	2018-01-06	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
13	1	2	prueba_12.txT	prueba_12.txt	1	2017-12-20	RENÉ SANTELICES	000	YULIA JOFRÉ C.	TODO QUE COMENTAR	2018-01-07	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
14	1	2	prueba_13.txt	prueba_13.txt	1	2017-12-19	RENÉ SANTELICES	900	CLAUDIO LOPEZ M.	NADA QUE COMENTAR	2018-01-08	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
15	1	2	prueba_14.txt	prueba_14.txt	1	2017-12-18	ANTONIETA MENDOZA	123	AGUSTÍN JOFRÉ A.	ALGO QUE COMENTAR	2018-01-09	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
16	1	2	prueba_15.txt	prueba_15.txt	1	2017-12-17	ANTONIETA MENDOZA C.	456	YULIA CARMONA M.	NO COMENTAR	2018-01-10	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
17	1	2	prueba_16.txt	prueba_16.txt	1	2017-12-16	RENÉ SANTELICES	789	AGUSTÍN LOPEZ C.	TODO QUE COMENTAR	2018-01-11	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
18	1	2	prueba_17.txt	prueba_17.txt	1	2017-12-15	RENÉ SANTELICES	012	CLAUDIO JOFRÉ A.	ALGO QUE COMENTAR	2018-01-12	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
19	1	2	prueba_18.txt	prueba_18.txt	1	2017-12-23	R. SANTELICES	345	AGUSTÍN LOPEZ M.	NADA QUE COMENTAR	2018-01-04	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
20	1	4	prueba_19.txt	prueba_19.txt	1	2017-12-22	RENÉ SANTELICES	678	CLAUDIO PINTO M.	NADA QUE COMENTAR	2018-01-05	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
21	1	1	const_soc.txt	const_soc.txt	1	2017-12-21	ANTONIETA MENDOZA ESCALA	901	JULIA PINTO A.	--	2018-01-06	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
22	1	2	act_dir.txt	act_dir.txt	1	2017-12-20	ANTONIETA MENDOZA E.	100	JULIA PINTO A.	--	2018-01-07	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
23	1	3	ses_dir.txt	ses_dir.txt	1	2017-12-19	ANTONIETA MENDOZA E.	200	JULIA PINTO A.	--	2018-01-08	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
24	1	4	cont_arr.txt	cont_arr.txt	1	2017-12-18	ANTONIETA MENDOZA ESCALA	300	JULIA PINTO A.	--	2018-01-09	GERARDO.PALMA.ASTE@GMAIL.COM	N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N	\N
\.


--
-- Data for Name: documentos_ventas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY documentos_ventas (id, idempr, idnove, idtidv, numero, idclie, descripciondoctoventa, idgere, idproy, idline, idceco, idtare, exento, afecto, impuestos, porcentajedescuento, montodescuento, total, idesve, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
\.


--
-- Name: dole_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('dole_seq', 25, false);


--
-- Name: domi_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('domi_seq', 1, false);


--
-- Data for Name: dominios; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY dominios (id, descripcion, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
\.


--
-- Name: dosh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('dosh_seq', 1, false);


--
-- Name: dove_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('dove_seq', 1, false);


--
-- Name: ecsh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('ecsh_seq', 4, false);


--
-- Name: empr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('empr_seq', 12, true);


--
-- Data for Name: empresas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY empresas (id, idgrem, idpais, idrubr, idesre, identificador1, identificador2, razonsocial, nombrefantasia, icono, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro, xfld) FROM stdin;
1	1	1	1	1	1	9	BUSINESS & TECHNOLOGY 5 CONSULTING	BT5	bt5.jpg	1	2017-12-24 10:47:54.296971	\N	\N	\N	\N	\N
2	2	1	10	1	96550820	1	METALPAR S.A.	METALPAR S.A.	emp_metalpar.jpg	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N	
3	2	1	11	1	93576000	3	INDUSTRIAS METALURGICAS PAREDES	INDUSTRIAL METALPAR S.A.	emp_industrias.jpg	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N	
4	2	1	12	1	88337800	8	INVERSIONES METALPAR S.A.	INVERSIONES METALPAR S.A.	emp_inv_metalpar.jpg	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N	
5	2	1	13	1	78400010	9	AGRICOLA Y GANADERA SANTA BARBARA	STA. BARBARA	emp_sta_barbara.jpg	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N	
6	3	1	23	1	89807200	2	FARMACIAS CRUZ VERDE	FCV	emp_cruz_verde.jpg	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N	
7	3	1	23	1	89741200	4	DIFARMA	DIFARMA	emp_difarma.jpg	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N	
8	3	1	24	1	91575000	1	SOCOFAR	SOCOFAR	emp_socofar.jpg	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N	
9	3	1	23	1	71378000	6	LABORATORIO MINTLAB	MINTLAB	emp_mintlab.jpg	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N	
10	3	1	23	1	77781470	2	LABORATORIO MUNICH	MUNICH	emp_munich.jpg	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N	
11	4	1	33	1	76765660	2	AMASANDERIA TRIGAL	TRIGAL	emp_trigal.jpg	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N	
12	6	1	5	1	21878885	4	PRUEBA CPALMA	PCP	microsoft.png	3	2017-12-25 13:02:25	\N	\N	\N	\N	\N
\.


--
-- Name: eosh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('eosh_seq', 5, false);


--
-- Name: epos_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('epos_seq', 3, false);


--
-- Name: esci_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esci_seq', 5, false);


--
-- Name: escv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('escv_seq', 5, true);


--
-- Name: esdl_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esdl_seq', 15, true);


--
-- Name: esge_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esge_seq', 4, false);


--
-- Name: esnv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esnv_seq', 5, true);


--
-- Name: esre_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esre_seq', 3, false);


--
-- Name: essh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('essh_seq', 6, false);


--
-- Data for Name: estados_civiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY estados_civiles (id, alias, descripcion) FROM stdin;
1	S	SOLTERO
2	C	CASADO
3	V	VIUDO
4	E	SEPARADO
\.


--
-- Data for Name: estados_cotizaciones_vtas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY estados_cotizaciones_vtas (id, descripcion) FROM stdin;
1	CREADA
2	CERRADA
3	ACEPTADA
4	CADUCADA
5	PRUEBA CPALMA
\.


--
-- Data for Name: estados_cotizacs_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY estados_cotizacs_servs_hono (id, descripcion) FROM stdin;
1	RECIBIDA
2	ACEPTADA
3	RECHAZADA
\.


--
-- Data for Name: estados_documentos_legales; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY estados_documentos_legales (id, idgrem, descripcion, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	1	VÁLIDO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
2	1	INVÁLIDO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
3	1	CADUCO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
4	2	VÁLIDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
5	2	INVÁLIDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
6	2	CADUCO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
7	3	VÁLIDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
8	3	INVÁLIDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
9	3	CADUCO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
10	4	VÁLIDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
11	4	INVÁLIDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
12	4	CADUCO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
13	6	VÁLIDO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
14	6	INVÁLIDO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
15	6	CADUCO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
\.


--
-- Data for Name: estados_grem; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY estados_grem (id, descripcion) FROM stdin;
1	ACTIVO
2	INACTIVO
3	SUSPENDIDO
\.


--
-- Data for Name: estados_notas_vtas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY estados_notas_vtas (id, descripcion) FROM stdin;
1	CREADA
2	EMITIDA
3	FACTURADA
4	CADUCADA
5	PRUEBA CPALMA
\.


--
-- Data for Name: estados_ordenes_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY estados_ordenes_servs_hono (id, descripcion) FROM stdin;
1	CREADA
2	ASIGNADA A PROFESIONAL
3	TERMINADA EXITOSAMENTE (APROBADO EL TRABAJO)
4	TERMINADA NO EXITOSAMENTE (RECHAZADO EL TRABAJO)
\.


--
-- Data for Name: estados_pagos_ords_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY estados_pagos_ords_servs_hono (id, descripcion) FROM stdin;
1	CREADO
2	PAGADO
\.


--
-- Data for Name: estados_registros; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY estados_registros (id, descripcion) FROM stdin;
1	ACTIVO
2	INACTIVO
\.


--
-- Data for Name: estados_solics_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY estados_solics_servs_hono (id, descripcion) FROM stdin;
1	CREADA
2	TRANSFERIDA A JEFE DE COMPRAS
3	EN PROCESO
4	ACEPTADA UNA COTIZACIÓN
5	RECHAZADAS TODAS LAS COTIZACIONES
\.


--
-- Data for Name: estados_ventas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY estados_ventas (id, descripcion) FROM stdin;
1	CREADA
2	CERRADA
3	ANULADA
\.


--
-- Name: esve_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esve_seq', 4, false);


--
-- Name: fide_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('fide_seq', 348, true);


--
-- Data for Name: field_defs; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY field_defs (id, form_id, forder, name, type, len, decim, pk, req, caption, gadget, size, maxlength, rows, cols, selvalues, sqlvalues, visible, readonly, fld_type, fld_offset) FROM stdin;
1	1	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
2	1	2	idempr	numeric	20	0	N	Y	idempr	input	20	20	5	60			Y	N	P	-1
3	1	3	nombre	character	100	0	N	Y	nombre	input	100	100	5	60			Y	N	P	-1
4	2	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
5	2	2	idgrem	numeric	20	0	N	Y	idgrem	input	20	20	5	60			Y	N	P	-1
6	2	3	idpais	numeric	20	0	N	Y	idpais	input	20	20	5	60			Y	N	P	-1
7	2	4	identificador1	character	50	0	N	Y	identificador1	input	50	50	5	60			Y	N	P	-1
8	2	5	identificador2	character	50	0	N	Y	identificador2	input	50	50	5	60			Y	N	P	-1
9	2	6	idticl	numeric	20	0	N	Y	idticl	input	20	20	5	60			Y	N	P	-1
10	2	7	razonsocial	character	100	0	N	N	razonsocial	input	100	100	5	60			Y	N	P	-1
11	2	8	nombrefantasia	character	100	0	N	N	nombrefantasia	input	100	100	5	60			Y	N	P	-1
12	2	9	primernombre	character	100	0	N	N	primernombre	input	100	100	5	60			Y	N	P	-1
13	2	10	segundonombre	character	100	0	N	N	segundonombre	input	100	100	5	60			Y	N	P	-1
14	2	11	apellidopaterno	character	100	0	N	N	apellidopaterno	input	100	100	5	60			Y	N	P	-1
15	2	12	apellidomaterno	character	100	0	N	N	apellidomaterno	input	100	100	5	60			Y	N	P	-1
16	3	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
17	3	2	idsosh	numeric	20	0	N	Y	idsosh	input	20	20	5	60			Y	N	P	-1
18	3	3	idpers	numeric	20	0	N	Y	idpers	input	20	20	5	60			Y	N	P	-1
19	3	4	monto	numeric	20	0	N	Y	monto	input	20	20	5	60			Y	N	P	-1
20	3	5	descservofrecido	character	1000	0	N	Y	descservofrecido	input	1000	1000	5	60			Y	N	P	-1
21	3	6	informeevaluaccotiz	character	1000	0	N	N	informeevaluaccotiz	input	1000	1000	5	60			Y	N	P	-1
22	3	7	idecsh	numeric	20	0	N	Y	idecsh	input	20	20	5	60			Y	N	P	-1
51	6	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
52	6	2	iddove	numeric	20	0	N	Y	iddove	input	20	20	5	60			Y	N	P	-1
53	6	3	correlativo	numeric	20	0	N	Y	correlativo	input	20	20	5	60			Y	N	P	-1
54	6	4	idprod	numeric	20	0	N	N	idprod	input	20	20	5	60			Y	N	P	-1
55	6	5	idserv	numeric	20	0	N	N	idserv	input	20	20	5	60			Y	N	P	-1
56	6	6	cantidad	numeric	20	0	N	Y	cantidad	input	20	20	5	60			Y	N	P	-1
57	6	7	preciounitario	numeric	20	0	N	Y	preciounitario	input	20	20	5	60			Y	N	P	-1
58	6	8	porcentajedescuento	numeric	20	0	N	Y	porcentajedescuento	input	20	20	5	60			Y	N	P	-1
59	6	9	montodescuento	numeric	20	0	N	Y	montodescuento	input	20	20	5	60			Y	N	P	-1
60	6	10	impuestos	numeric	20	0	N	Y	impuestos	input	20	20	5	60			Y	N	P	-1
61	6	11	subtotal	numeric	20	0	N	Y	subtotal	input	20	20	5	60			Y	N	P	-1
62	7	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
63	7	2	idnove	numeric	20	0	N	Y	idnove	input	20	20	5	60			Y	N	P	-1
64	7	3	correlativo	numeric	20	0	N	Y	correlativo	input	20	20	5	60			Y	N	P	-1
65	7	4	idprod	numeric	20	0	N	N	idprod	input	20	20	5	60			Y	N	P	-1
26	4	4	idclie	numeric	20	0	N	Y	Cliente	hidden	20	20	5	60	\N		Y	N	P	-1
27	4	5	descripcioncotizacion	character	1000	0	N	Y	Descripción cotizado	area	1000	1000	5	60	\N		Y	N	P	-1
28	4	6	idgere	numeric	20	0	N	N	Gerencia	select	20	20	5	60	\N		Y	N	P	-1
30	4	8	idline	numeric	20	0	N	N	Línea de negocios	select	20	20	5	60	\N		Y	N	P	-1
31	4	9	idceco	numeric	20	0	N	N	Centro de costos	select	20	20	5	60	\N		Y	N	P	-1
32	4	10	idtare	numeric	20	0	N	N	Tarea	select	20	20	5	60	\N		Y	N	P	-1
33	4	11	subtotal	numeric	20	0	N	Y	Sub.Total	input	11	11	5	60	\N		Y	N	P	-1
34	4	12	porcentajedescuento	numeric	20	0	N	Y	% de Descto.	input	11	11	5	60	\N		Y	N	P	-1
35	4	13	montodescuento	numeric	20	0	N	Y	Mto.Descto	input	11	11	5	60	\N		Y	N	P	-1
36	4	14	valorimpuestos	numeric	20	0	N	Y	Valor Impuestos	input	11	11	5	60	\N		Y	N	P	-1
37	4	15	total	numeric	20	0	N	Y	Total	input	11	11	5	60	\N		Y	N	P	-1
39	4	17	idescv	numeric	20	0	N	Y	Estado	select	20	20	5	60	\N		Y	N	P	-1
24	4	2	idempr	numeric	20	0	N	Y	Empresa	hidden	20	20	5	60	\N		Y	N	P	-1
40	5	1	id	numeric	20	0	Y	Y	id	hidden	20	20	5	60	\N		Y	N	P	-1
41	5	2	idcove	numeric	20	0	N	Y	idcove	hidden	20	20	5	60	\N		Y	N	P	-1
42	5	3	correlativo	numeric	20	0	N	Y	Corr	input	3	3	5	60	\N		Y	Y	P	-1
43	5	4	idprod	numeric	20	0	N	N	Producto	input	20	20	5	60	\N		Y	N	P	-1
44	5	5	idserv	numeric	20	0	N	N	Servicio	input	20	20	5	60	\N		Y	N	P	-1
45	5	6	cantidad	numeric	20	0	N	Y	Cantidad	input	20	20	5	60	\N		Y	N	P	-1
46	5	7	preciounitario	numeric	20	0	N	Y	Precio Unit.	input	20	20	5	60	\N		Y	N	P	-1
47	5	8	porcentajedescuento	numeric	20	0	N	Y	%Descto	input	20	20	5	60	\N		Y	N	P	-1
48	5	9	montodescuento	numeric	20	0	N	Y	Mto.Descto	input	20	20	5	60	\N		Y	N	P	-1
49	5	10	impuestos	numeric	20	0	N	Y	Imptos.	input	20	20	5	60	\N		Y	N	P	-1
25	4	3	numero	numeric	20	0	N	Y	Número	input	10	20	5	60	\N		Y	N	P	-1
66	7	5	idserv	numeric	20	0	N	N	idserv	input	20	20	5	60			Y	N	P	-1
67	7	6	cantidad	numeric	20	0	N	Y	cantidad	input	20	20	5	60			Y	N	P	-1
68	7	7	preciounitario	numeric	20	0	N	Y	preciounitario	input	20	20	5	60			Y	N	P	-1
69	7	8	porcentajedescuento	numeric	20	0	N	Y	porcentajedescuento	input	20	20	5	60			Y	N	P	-1
70	7	9	montodescuento	numeric	20	0	N	Y	montodescuento	input	20	20	5	60			Y	N	P	-1
71	7	10	impuestos	numeric	20	0	N	Y	impuestos	input	20	20	5	60			Y	N	P	-1
72	7	11	subtotal	numeric	20	0	N	Y	subtotal	input	20	20	5	60			Y	N	P	-1
73	8	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
74	8	2	idcosh	numeric	20	0	N	Y	idcosh	input	20	20	5	60			Y	N	P	-1
75	8	3	nombrearchivoorig	character	100	0	N	Y	nombrearchivoorig	input	100	100	5	60			Y	N	P	-1
76	8	4	nombrearchivomodif	character	100	0	N	Y	nombrearchivomodif	input	100	100	5	60			Y	N	P	-1
77	9	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
78	9	2	idorsh	numeric	20	0	N	Y	idorsh	input	20	20	5	60			Y	N	P	-1
79	9	3	nombrearchivoorig	character	100	0	N	Y	nombrearchivoorig	input	100	100	5	60			Y	N	P	-1
80	9	4	nombrearchivomodif	character	100	0	N	Y	nombrearchivomodif	input	100	100	5	60			Y	N	P	-1
81	10	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
82	10	2	idempr	numeric	20	0	N	Y	idempr	input	20	20	5	60			Y	N	P	-1
83	10	3	idtidl	numeric	20	0	N	Y	idtidl	input	20	20	5	60			Y	N	P	-1
84	10	4	nombreoriginal	character	500	0	N	Y	nombreoriginal	input	500	500	5	60			Y	N	P	-1
85	10	5	nombresistema	character	100	0	N	Y	nombresistema	input	100	100	5	60			Y	N	P	-1
86	10	6	idesdl	numeric	20	0	N	Y	idesdl	input	20	20	5	60			Y	N	P	-1
87	10	7	fecha	date	0	0	N	Y	fecha	input	0	0	5	60			Y	N	P	-1
88	10	8	notaria	character	100	0	N	N	notaria	input	100	100	5	60			Y	N	P	-1
89	10	9	foja	character	100	0	N	N	foja	input	100	100	5	60			Y	N	P	-1
90	10	10	responsable	character	100	0	N	Y	responsable	input	100	100	5	60			Y	N	P	-1
91	10	11	comentario	character	1000	0	N	Y	comentario	input	1000	1000	5	60			Y	N	P	-1
92	10	12	fechaaviso	date	0	0	N	N	fechaaviso	input	0	0	5	60			Y	N	P	-1
93	10	13	emailaviso	character	100	0	N	N	emailaviso	input	100	100	5	60			Y	N	P	-1
94	10	14	avisodado	character	1	0	N	N	avisodado	input	1	1	5	60			Y	N	P	-1
95	11	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
96	11	2	idempr	numeric	20	0	N	Y	idempr	input	20	20	5	60			Y	N	P	-1
97	11	3	idnove	numeric	20	0	N	N	idnove	input	20	20	5	60			Y	N	P	-1
98	11	4	idtidv	numeric	20	0	N	Y	idtidv	input	20	20	5	60			Y	N	P	-1
99	11	5	numero	numeric	20	0	N	Y	numero	input	20	20	5	60			Y	N	P	-1
100	11	6	idclie	numeric	20	0	N	Y	idclie	input	20	20	5	60			Y	N	P	-1
101	11	7	descripciondoctoventa	character	1000	0	N	Y	descripciondoctoventa	input	1000	1000	5	60			Y	N	P	-1
102	11	8	idgere	numeric	20	0	N	N	idgere	input	20	20	5	60			Y	N	P	-1
103	11	9	idproy	numeric	20	0	N	N	idproy	input	20	20	5	60			Y	N	P	-1
104	11	10	idline	numeric	20	0	N	N	idline	input	20	20	5	60			Y	N	P	-1
105	11	11	idceco	numeric	20	0	N	N	idceco	input	20	20	5	60			Y	N	P	-1
106	11	12	idtare	numeric	20	0	N	N	idtare	input	20	20	5	60			Y	N	P	-1
107	11	13	subtotal	numeric	20	0	N	Y	subtotal	input	20	20	5	60			Y	N	P	-1
108	11	14	porcentajedescuento	numeric	20	0	N	Y	porcentajedescuento	input	20	20	5	60			Y	N	P	-1
109	11	15	montodescuento	numeric	20	0	N	Y	montodescuento	input	20	20	5	60			Y	N	P	-1
110	11	16	valorimpuestos	numeric	20	0	N	Y	valorimpuestos	input	20	20	5	60			Y	N	P	-1
111	11	17	total	numeric	20	0	N	Y	total	input	20	20	5	60			Y	N	P	-1
112	11	18	idesve	numeric	20	0	N	Y	idesve	input	20	20	5	60			Y	N	P	-1
113	12	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
114	12	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
115	13	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
116	13	2	idgrem	numeric	20	0	N	Y	idgrem	input	20	20	5	60			Y	N	P	-1
117	13	3	idpais	numeric	20	0	N	Y	idpais	input	20	20	5	60			Y	N	P	-1
118	13	4	idrubr	numeric	20	0	N	Y	idrubr	input	20	20	5	60			Y	N	P	-1
119	13	5	idesre	numeric	20	0	N	Y	idesre	input	20	20	5	60			Y	N	P	-1
120	13	6	identificador1	character	50	0	N	Y	identificador1	input	50	50	5	60			Y	N	P	-1
121	13	7	identificador2	character	50	0	N	Y	identificador2	input	50	50	5	60			Y	N	P	-1
122	13	8	razonsocial	character	100	0	N	Y	razonsocial	input	100	100	5	60			Y	N	P	-1
123	13	9	nombrefantasia	character	100	0	N	Y	nombrefantasia	input	100	100	5	60			Y	N	P	-1
124	13	10	icono	character	100	0	N	Y	icono	input	100	100	5	60			Y	N	P	-1
125	14	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
126	14	2	alias	character	1	0	N	Y	alias	input	1	1	5	60			Y	N	P	-1
127	14	3	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
128	15	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
129	15	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
130	16	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
131	16	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
132	17	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
133	17	2	idgrem	numeric	20	0	N	Y	idgrem	input	20	20	5	60			Y	N	P	-1
134	17	3	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
135	18	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
136	18	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
137	19	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
138	19	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
139	20	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
140	20	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
141	21	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
142	21	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
143	22	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
144	22	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
145	23	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
146	23	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
147	24	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
148	24	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
158	27	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
159	27	2	idpais	numeric	20	0	N	Y	idpais	input	20	20	5	60			Y	N	P	-1
160	27	3	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
161	27	4	descripcioncorta	character	10	0	N	Y	descripcioncorta	input	10	10	5	60			Y	N	P	-1
162	27	5	obligatorio	character	1	0	N	Y	obligatorio	input	1	1	5	60			Y	N	P	-1
163	27	6	valor	numeric	20	0	N	Y	valor	input	20	20	5	60			Y	N	P	-1
167	29	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
168	29	2	nombre	character	100	0	N	Y	nombre	input	100	100	5	60			Y	N	P	-1
169	29	3	nombrecorto	character	10	0	N	Y	nombrecorto	input	10	10	5	60			Y	N	P	-1
170	30	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
171	30	2	idempr	numeric	20	0	N	Y	idempr	input	20	20	5	60			Y	N	P	-1
172	30	3	idcove	numeric	20	0	N	N	idcove	input	20	20	5	60			Y	N	P	-1
173	30	4	numero	numeric	20	0	N	Y	numero	input	20	20	5	60			Y	N	P	-1
174	30	5	idclie	numeric	20	0	N	Y	idclie	input	20	20	5	60			Y	N	P	-1
175	30	6	descripcionnotaventa	character	1000	0	N	Y	descripcionnotaventa	input	1000	1000	5	60			Y	N	P	-1
176	30	7	idgere	numeric	20	0	N	N	idgere	input	20	20	5	60			Y	N	P	-1
177	30	8	idproy	numeric	20	0	N	N	idproy	input	20	20	5	60			Y	N	P	-1
178	30	9	idline	numeric	20	0	N	N	idline	input	20	20	5	60			Y	N	P	-1
179	30	10	idceco	numeric	20	0	N	N	idceco	input	20	20	5	60			Y	N	P	-1
180	30	11	idtare	numeric	20	0	N	N	idtare	input	20	20	5	60			Y	N	P	-1
181	30	12	subtotal	numeric	20	0	N	Y	subtotal	input	20	20	5	60			Y	N	P	-1
182	30	13	porcentajedescuento	numeric	20	0	N	Y	porcentajedescuento	input	20	20	5	60			Y	N	P	-1
183	30	14	montodescuento	numeric	20	0	N	Y	montodescuento	input	20	20	5	60			Y	N	P	-1
184	30	15	valorimpuestos	numeric	20	0	N	Y	valorimpuestos	input	20	20	5	60			Y	N	P	-1
185	30	16	total	numeric	20	0	N	Y	total	input	20	20	5	60			Y	N	P	-1
186	30	17	idesnv	numeric	20	0	N	Y	idesnv	input	20	20	5	60			Y	N	P	-1
187	31	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
188	31	2	idempr	numeric	20	0	N	Y	idempr	input	20	20	5	60			Y	N	P	-1
189	31	3	idsosh	numeric	20	0	N	N	idsosh	input	20	20	5	60			Y	N	P	-1
190	31	4	correlativo	numeric	20	0	N	Y	correlativo	input	20	20	5	60			Y	N	P	-1
191	31	5	codigocompra	character	100	0	N	Y	codigocompra	input	100	100	5	60			Y	N	P	-1
192	31	6	idpers	numeric	20	0	N	Y	idpers	input	20	20	5	60			Y	N	P	-1
193	31	7	descripcionordenserv	character	1000	0	N	Y	descripcionordenserv	input	1000	1000	5	60			Y	N	P	-1
194	31	8	resultadofinal	character	1000	0	N	N	resultadofinal	input	1000	1000	5	60			Y	N	P	-1
195	31	9	ideosh	numeric	20	0	N	Y	ideosh	input	20	20	5	60			Y	N	P	-1
196	31	10	idgere	numeric	20	0	N	N	idgere	input	20	20	5	60			Y	N	P	-1
197	31	11	idproy	numeric	20	0	N	N	idproy	input	20	20	5	60			Y	N	P	-1
198	31	12	idline	numeric	20	0	N	N	idline	input	20	20	5	60			Y	N	P	-1
154	26	3	alias	character	10	0	N	Y	Alias	input	10	10	5	60	\N		Y	N	P	-1
155	26	4	icono	character	100	0	N	Y	Ícono	input	50	100	5	60	\N		Y	N	P	-1
156	26	5	idpais	numeric	20	0	N	Y	País	select	20	20	5	60	\N		Y	N	P	-1
157	26	6	idesge	numeric	20	0	N	Y	Estado	input	20	20	5	60	\N		Y	N	P	-1
165	28	2	idempr	numeric	20	0	N	Y	Empresa	hidden	20	20	5	60	\N		Y	N	P	-1
153	26	2	nombre	character	100	0	N	Y	Nombre	input	50	100	5	60	\N		Y	N	P	-1
149	25	1	id	numeric	20	0	Y	Y	id	hidden	20	20	5	60	\N		Y	N	P	-1
150	25	2	idempr	numeric	20	0	N	Y	idempr	hidden	20	20	5	60	\N		Y	N	P	-1
151	25	3	nombre	character	100	0	N	Y	Nombre	input	45	45	5	60	\N		Y	N	P	-1
164	28	1	id	numeric	20	0	Y	Y	ID	hidden	20	20	5	60	\N		Y	N	P	-1
199	31	13	idceco	numeric	20	0	N	N	idceco	input	20	20	5	60			Y	N	P	-1
200	31	14	idtare	numeric	20	0	N	N	idtare	input	20	20	5	60			Y	N	P	-1
201	32	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
202	32	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
203	32	3	descripcioncorta	character	10	0	N	Y	descripcioncorta	input	10	10	5	60			Y	N	P	-1
204	33	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
205	33	2	idorsh	numeric	20	0	N	Y	idorsh	input	20	20	5	60			Y	N	P	-1
206	33	3	fechapago	date	0	0	N	Y	fechapago	input	0	0	5	60			Y	N	P	-1
207	33	4	monto	numeric	20	0	N	Y	monto	input	20	20	5	60			Y	N	P	-1
208	33	5	idtifp	numeric	20	0	N	Y	idtifp	input	20	20	5	60			Y	N	P	-1
209	33	6	idepos	numeric	20	0	N	Y	idepos	input	20	20	5	60			Y	N	P	-1
210	34	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
211	34	2	nombre	character	100	0	N	Y	nombre	input	100	100	5	60			Y	N	P	-1
212	34	3	idmone	numeric	20	0	N	Y	idmone	input	20	20	5	60			Y	N	P	-1
213	34	4	nacionalidad	character	100	0	N	Y	nacionalidad	input	100	100	5	60			Y	N	P	-1
214	35	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
215	35	2	idgrem	numeric	20	0	N	Y	idgrem	input	20	20	5	60			Y	N	P	-1
216	35	3	nombrecorto	character	50	0	N	Y	nombrecorto	input	50	50	5	60			Y	N	P	-1
217	35	4	nombrelargo	character	500	0	N	Y	nombrelargo	input	500	500	5	60			Y	N	P	-1
218	35	5	descripcion	character	1000	0	N	Y	descripcion	input	1000	1000	5	60			Y	N	P	-1
219	35	6	valor	character	500	0	N	Y	valor	input	500	500	5	60			Y	N	P	-1
220	36	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
221	36	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
222	37	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
223	37	2	idperf	numeric	20	0	N	Y	idperf	input	20	20	5	60			Y	N	P	-1
224	37	3	idprog	numeric	20	0	N	Y	idprog	input	20	20	5	60			Y	N	P	-1
225	38	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
226	38	2	idgrem	numeric	20	0	N	Y	idgrem	input	20	20	5	60			Y	N	P	-1
227	38	3	identificador1	character	50	0	N	Y	identificador1	input	50	50	5	60			Y	N	P	-1
228	38	4	identificador2	character	50	0	N	Y	identificador2	input	50	50	5	60			Y	N	P	-1
229	38	5	primernombre	character	100	0	N	Y	primernombre	input	100	100	5	60			Y	N	P	-1
230	38	6	segundonombre	character	100	0	N	N	segundonombre	input	100	100	5	60			Y	N	P	-1
231	38	7	apellidopaterno	character	100	0	N	Y	apellidopaterno	input	100	100	5	60			Y	N	P	-1
232	38	8	apellidomaterno	character	100	0	N	N	apellidomaterno	input	100	100	5	60			Y	N	P	-1
233	38	9	email	character	100	0	N	N	email	input	100	100	5	60			Y	N	P	-1
234	38	10	fechanac	date	0	0	N	N	fechanac	input	0	0	5	60			Y	N	P	-1
235	38	11	idesci	numeric	20	0	N	N	idesci	input	20	20	5	60			Y	N	P	-1
236	38	12	idsexo	numeric	20	0	N	N	idsexo	input	20	20	5	60			Y	N	P	-1
237	38	13	idpais	numeric	20	0	N	N	idpais	input	20	20	5	60			Y	N	P	-1
238	39	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
239	39	2	idgrem	numeric	20	0	N	Y	idgrem	input	20	20	5	60			Y	N	P	-1
240	39	3	segmento1	character	100	0	N	Y	segmento1	input	100	100	5	60			Y	N	P	-1
241	39	4	segmento2	character	100	0	N	N	segmento2	input	100	100	5	60			Y	N	P	-1
242	39	5	segmento3	character	100	0	N	N	segmento3	input	100	100	5	60			Y	N	P	-1
243	39	6	segmento4	character	100	0	N	N	segmento4	input	100	100	5	60			Y	N	P	-1
244	39	7	segmento5	character	100	0	N	N	segmento5	input	100	100	5	60			Y	N	P	-1
245	39	8	segmento6	character	100	0	N	N	segmento6	input	100	100	5	60			Y	N	P	-1
246	39	9	segmento7	character	100	0	N	N	segmento7	input	100	100	5	60			Y	N	P	-1
247	39	10	segmento8	character	100	0	N	N	segmento8	input	100	100	5	60			Y	N	P	-1
248	39	11	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
249	40	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
250	40	2	idempr	numeric	20	0	N	Y	idempr	input	20	20	5	60			Y	N	P	-1
251	40	3	idtipr	numeric	20	0	N	Y	idtipr	input	20	20	5	60			Y	N	P	-1
252	40	4	idunmp	numeric	20	0	N	Y	idunmp	input	20	20	5	60			Y	N	P	-1
253	40	5	idorpr	numeric	20	0	N	Y	idorpr	input	20	20	5	60			Y	N	P	-1
254	40	6	nombre	character	1000	0	N	Y	nombre	input	1000	1000	5	60			Y	N	P	-1
255	40	7	valorunitario	numeric	20	0	N	Y	valorunitario	input	20	20	5	60			Y	N	P	-1
256	41	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
257	41	2	idprogpadre	numeric	20	0	N	N	idprogpadre	input	20	20	5	60			Y	N	P	-1
258	41	3	titulo	character	100	0	N	Y	titulo	input	100	100	5	60			Y	N	P	-1
259	41	4	link	character	100	0	N	N	link	input	100	100	5	60			Y	N	P	-1
260	41	5	etiqueta	character	100	0	N	Y	etiqueta	input	100	100	5	60			Y	N	P	-1
261	41	6	peso	numeric	20	0	N	Y	peso	input	20	20	5	60			Y	N	P	-1
265	43	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
263	42	2	idempr	numeric	20	0	N	Y	Empresa	hidden	20	20	5	60	\N		Y	N	P	-1
264	42	3	nombre	character	100	0	N	Y	Nombre	input	45	45	5	60	\N		Y	N	P	-1
266	43	2	idgrem	numeric	20	0	N	Y	idgrem	input	20	20	5	60			Y	N	P	-1
267	43	3	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
268	44	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
269	44	2	idempr	numeric	20	0	N	Y	idempr	input	20	20	5	60			Y	N	P	-1
270	44	3	idtise	numeric	20	0	N	Y	idtise	input	20	20	5	60			Y	N	P	-1
271	44	4	idunms	numeric	20	0	N	Y	idunms	input	20	20	5	60			Y	N	P	-1
272	44	5	nombre	character	1000	0	N	Y	nombre	input	1000	1000	5	60			Y	N	P	-1
273	44	6	valorunitario	numeric	20	0	N	Y	valorunitario	input	20	20	5	60			Y	N	P	-1
274	45	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
275	45	2	alias	character	1	0	N	Y	alias	input	1	1	5	60			Y	N	P	-1
276	45	3	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
277	46	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
278	46	2	idempr	numeric	20	0	N	Y	idempr	input	20	20	5	60			Y	N	P	-1
279	46	3	correlativo	numeric	20	0	N	Y	correlativo	input	20	20	5	60			Y	N	P	-1
280	46	4	idpers	numeric	20	0	N	Y	idpers	input	20	20	5	60			Y	N	P	-1
281	46	5	descripcionsolicserv	character	1000	0	N	Y	descripcionsolicserv	input	1000	1000	5	60			Y	N	P	-1
282	46	6	idgere	numeric	20	0	N	N	idgere	input	20	20	5	60			Y	N	P	-1
283	46	7	idproy	numeric	20	0	N	N	idproy	input	20	20	5	60			Y	N	P	-1
284	46	8	idline	numeric	20	0	N	N	idline	input	20	20	5	60			Y	N	P	-1
285	46	9	idceco	numeric	20	0	N	N	idceco	input	20	20	5	60			Y	N	P	-1
286	46	10	idtare	numeric	20	0	N	N	idtare	input	20	20	5	60			Y	N	P	-1
290	48	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
291	48	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
292	49	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
293	49	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
294	50	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
295	50	2	idpais	numeric	20	0	N	Y	idpais	input	20	20	5	60			Y	N	P	-1
296	50	3	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
297	50	4	descripcioncorta	character	10	0	N	Y	descripcioncorta	input	10	10	5	60			Y	N	P	-1
298	50	5	codigooficial	character	10	0	N	Y	codigooficial	input	10	10	5	60			Y	N	P	-1
299	51	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
300	51	2	idgrem	numeric	20	0	N	Y	idgrem	input	20	20	5	60			Y	N	P	-1
301	51	3	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
302	51	4	descripcioncorta	character	15	0	N	Y	descripcioncorta	input	15	15	5	60			Y	N	P	-1
303	51	5	color	character	50	0	N	Y	color	input	50	50	5	60			Y	N	P	-1
304	52	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
305	52	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
306	53	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
307	53	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
308	54	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
309	54	2	idtipr	numeric	20	0	N	Y	idtipr	input	20	20	5	60			Y	N	P	-1
310	54	3	idimpu	numeric	20	0	N	Y	idimpu	input	20	20	5	60			Y	N	P	-1
311	55	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
312	55	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
313	55	3	estaexento	character	1	0	N	Y	estaexento	input	1	1	5	60			Y	N	P	-1
314	56	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
315	56	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
316	56	3	descripcioncorta	character	10	0	N	Y	descripcioncorta	input	10	10	5	60			Y	N	P	-1
317	57	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
318	57	2	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
319	57	3	descripcioncorta	character	10	0	N	Y	descripcioncorta	input	10	10	5	60			Y	N	P	-1
320	58	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
321	58	2	idpais	numeric	20	0	N	Y	idpais	input	20	20	5	60			Y	N	P	-1
322	58	3	nombre	character	100	0	N	Y	nombre	input	100	100	5	60			Y	N	P	-1
323	59	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
324	59	2	idunt1	numeric	20	0	N	Y	idunt1	input	20	20	5	60			Y	N	P	-1
325	59	3	nombre	character	100	0	N	Y	nombre	input	100	100	5	60			Y	N	P	-1
326	60	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
327	60	2	idunt2	numeric	20	0	N	Y	idunt2	input	20	20	5	60			Y	N	P	-1
328	60	3	nombre	character	100	0	N	Y	nombre	input	100	100	5	60			Y	N	P	-1
329	61	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
330	61	2	username	character	100	0	N	Y	username	input	100	100	5	60			Y	N	P	-1
331	61	3	password	character	100	0	N	Y	password	input	100	100	5	60			Y	N	P	-1
332	61	4	idpers	numeric	20	0	N	Y	idpers	input	20	20	5	60			Y	N	P	-1
333	61	5	idesre	numeric	20	0	N	Y	idesre	input	20	20	5	60			Y	N	P	-1
289	47	3	nombre	character	100	0	N	Y	Nombre Tarea	input	100	100	5	60	\N		Y	N	P	-1
334	62	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
335	62	2	idusua	numeric	20	0	N	Y	idusua	input	20	20	5	60			Y	N	P	-1
336	62	3	idperf	numeric	20	0	N	Y	idperf	input	20	20	5	60			Y	N	P	-1
337	62	4	idgrem	numeric	20	0	N	N	idgrem	input	20	20	5	60			Y	N	P	-1
338	62	5	idempr	numeric	20	0	N	N	idempr	input	20	20	5	60			Y	N	P	-1
339	62	6	idesre	numeric	20	0	N	Y	idesre	input	20	20	5	60			Y	N	P	-1
340	63	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
341	63	2	iddomi	numeric	20	0	N	Y	iddomi	input	20	20	5	60			Y	N	P	-1
342	63	3	descripcion	character	100	0	N	Y	descripcion	input	100	100	5	60			Y	N	P	-1
343	64	1	id	numeric	20	0	Y	Y	id	input	20	20	5	60			Y	N	P	-1
344	64	2	idpais	numeric	20	0	N	Y	idpais	input	20	20	5	60			Y	N	P	-1
345	64	3	nombrecorto	character	10	0	N	Y	nombrecorto	input	10	10	5	60			Y	N	P	-1
346	64	4	nombrelargo	character	500	0	N	Y	nombrelargo	input	500	500	5	60			Y	N	P	-1
347	64	5	descripcion	character	1000	0	N	Y	descripcion	input	1000	1000	5	60			Y	N	P	-1
348	64	6	valor	character	1000	0	N	Y	valor	input	1000	1000	5	60			Y	N	P	-1
152	26	1	id	numeric	20	0	Y	Y	id	hidden	20	20	5	60	\N		Y	N	P	-1
262	42	1	id	numeric	20	0	Y	Y	ID	hidden	20	20	5	60	\N		Y	N	P	-1
287	47	1	id	numeric	20	0	Y	Y	ID	hidden	20	20	5	60	\N		Y	N	P	-1
288	47	2	idempr	numeric	20	0	N	Y	Empresa	hidden	20	20	5	60	\N		Y	N	P	-1
166	28	3	nombre	character	100	0	N	Y	Nombre línea de negocio	input	50	50	5	60	\N		Y	N	P	-1
50	5	11	subtotal	numeric	20	0	N	Y	SubTotal	input	20	20	5	60	\N		Y	N	P	-1
23	4	1	id	numeric	20	0	Y	Y	ID	hidden	20	20	5	60	\N		Y	N	P	-1
29	4	7	idproy	numeric	20	0	N	N	Proyecto	select	20	20	5	60	\N		Y	N	P	-1
38	4	16	diasvalidez	numeric	20	0	N	Y	Días Validez	input	5	5	5	60	\N		Y	N	P	-1
\.


--
-- Name: fode_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('fode_seq', 64, true);


--
-- Data for Name: form_defs; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY form_defs (id, caption, table_name, ins_allowed, upd_allowed, del_allowed) FROM stdin;
1	centros_costos	centros_costos	Y	Y	Y
2	clientes	clientes	Y	Y	Y
3	cotizaciones_servs_hono	cotizaciones_servs_hono	Y	Y	Y
5	detalles_cotizs_vtas	detalles_cotizs_vtas	Y	Y	Y
6	detalles_doctos_vtas	detalles_doctos_vtas	Y	Y	Y
7	detalles_notas_vtas	detalles_notas_vtas	Y	Y	Y
8	doctos_cotizacs_servs_hono	doctos_cotizacs_servs_hono	Y	Y	Y
9	doctos_ordenes_servs_hono	doctos_ordenes_servs_hono	Y	Y	Y
10	documentos_legales	documentos_legales	Y	Y	Y
11	documentos_ventas	documentos_ventas	Y	Y	Y
12	dominios	dominios	Y	Y	Y
13	empresas	empresas	Y	Y	Y
14	estados_civiles	estados_civiles	Y	Y	Y
15	estados_cotizaciones_vtas	estados_cotizaciones_vtas	Y	Y	Y
16	estados_cotizacs_servs_hono	estados_cotizacs_servs_hono	Y	Y	Y
17	estados_documentos_legales	estados_documentos_legales	Y	Y	Y
18	estados_grem	estados_grem	Y	Y	Y
19	estados_notas_vtas	estados_notas_vtas	Y	Y	Y
20	estados_ordenes_servs_hono	estados_ordenes_servs_hono	Y	Y	Y
21	estados_pagos_ords_servs_hono	estados_pagos_ords_servs_hono	Y	Y	Y
22	estados_registros	estados_registros	Y	Y	Y
23	estados_solics_servs_hono	estados_solics_servs_hono	Y	Y	Y
24	estados_ventas	estados_ventas	Y	Y	Y
27	impuestos	impuestos	Y	Y	Y
29	monedas	monedas	Y	Y	Y
30	notas_ventas	notas_ventas	Y	Y	Y
31	ordenes_servicios_hono	ordenes_servicios_hono	Y	Y	Y
32	origenes_productos	origenes_productos	Y	Y	Y
33	pagos_ordenes_servs_hono	pagos_ordenes_servs_hono	Y	Y	Y
34	paises	paises	Y	Y	Y
35	parametros	parametros	Y	Y	Y
36	perfiles	perfiles	Y	Y	Y
37	perfiles_programas	perfiles_programas	Y	Y	Y
38	personas	personas	Y	Y	Y
39	planes_cuentas	planes_cuentas	Y	Y	Y
40	productos	productos	Y	Y	Y
41	programas	programas	Y	Y	Y
43	rubros	rubros	Y	Y	Y
44	servicios	servicios	Y	Y	Y
45	sexos	sexos	Y	Y	Y
46	solicitudes_servs_hono	solicitudes_servs_hono	Y	Y	Y
48	tipos_clientes	tipos_clientes	Y	Y	Y
49	tipos_cotizaciones_vtas	tipos_cotizaciones_vtas	Y	Y	Y
50	tipos_doctos_ventas	tipos_doctos_ventas	Y	Y	Y
51	tipos_documentos_legales	tipos_documentos_legales	Y	Y	Y
52	tipos_formas_pagos	tipos_formas_pagos	Y	Y	Y
53	tipos_productos	tipos_productos	Y	Y	Y
54	tipos_productos_impuestos	tipos_productos_impuestos	Y	Y	Y
55	tipos_servicios	tipos_servicios	Y	Y	Y
56	unidades_medidas_productos	unidades_medidas_productos	Y	Y	Y
57	unidades_medidas_servicios	unidades_medidas_servicios	Y	Y	Y
58	unidades_territoriales_1	unidades_territoriales_1	Y	Y	Y
59	unidades_territoriales_2	unidades_territoriales_2	Y	Y	Y
60	unidades_territoriales_3	unidades_territoriales_3	Y	Y	Y
61	usuarios	usuarios	Y	Y	Y
62	usuarios_perfiles	usuarios_perfiles	Y	Y	Y
63	valores_dominios	valores_dominios	Y	Y	Y
64	valores_paises	valores_paises	Y	Y	Y
26	Mantención de Grupos Empresariales	grupos_empresariales	Y	Y	Y
42	Mantención de Proyectos	proyectos	Y	Y	Y
47	Mantención de Tareas	tareas	Y	Y	Y
28	Mantención de Líneas de Negocio	lineas_negocios	Y	Y	Y
25	Mantención de Gerencias	gerencias	Y	Y	Y
4	Cotizaciones Ventas	cotizaciones_ventas	Y	Y	Y
\.


--
-- Name: gere_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('gere_seq', 46, true);


--
-- Data for Name: gerencias; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY gerencias (id, idempr, nombre, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	2	GERENCIA GENERAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
2	2	GERENCIA COMERCIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
3	2	GERENCIA MARKETING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
4	2	GERENCIA RRHH	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
5	2	GERENCIA ADM. Y FINANZAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
6	3	GERENCIA GENERAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
7	3	GERENCIA COMERCIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
8	3	GERENCIA MARKETING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
9	3	GERENCIA RRHH	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
10	3	GERENCIA ADM. Y FINANZAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
11	4	GERENCIA GENERAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
12	4	GERENCIA COMERCIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
13	4	GERENCIA MARKETING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
14	4	GERENCIA RRHH	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
15	4	GERENCIA ADM. Y FINANZAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
16	5	GERENCIA GENERAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
17	5	GERENCIA COMERCIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
18	5	GERENCIA MARKETING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
19	5	GERENCIA RRHH	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
20	5	GERENCIA ADM. Y FINANZAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
21	6	GERENCIA GENERAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
22	6	GERENCIA COMERCIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
23	6	GERENCIA MARKETING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
24	6	GERENCIA RRHH	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
25	6	GERENCIA ADM. Y FINANZAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
26	7	GERENCIA GENERAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
27	7	GERENCIA COMERCIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
28	7	GERENCIA MARKETING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
29	7	GERENCIA RRHH	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
30	7	GERENCIA ADM. Y FINANZAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
31	8	GERENCIA GENERAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
32	8	GERENCIA COMERCIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
33	8	GERENCIA MARKETING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
34	8	GERENCIA RRHH	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
35	8	GERENCIA ADM. Y FINANZAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
36	9	GERENCIA GENERAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
37	9	GERENCIA COMERCIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
38	9	GERENCIA MARKETING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
39	9	GERENCIA RRHH	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
40	9	GERENCIA ADM. Y FINANZAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
41	10	GERENCIA GENERAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
42	10	GERENCIA COMERCIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
43	10	GERENCIA MARKETING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
44	10	GERENCIA RRHH	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
45	10	GERENCIA ADM. Y FINANZAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
46	1	GERENCIA GENERAL	3	2017-12-25 13:30:59	\N	\N	\N	\N
\.


--
-- Name: grem_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('grem_seq', 6, true);


--
-- Data for Name: grupos_empresariales; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY grupos_empresariales (id, nombre, alias, icono, idpais, idesge, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	BUSINESS & TECHNOLOGY 5 CONSULTING	BT5	bt5.jpg	1	1	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
2	METALPAR	MPAR	hold_metalpar.jpg	1	1	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
3	CRUZ VERDE	CV	hold_cruz_verde.jpg	1	1	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
4	AMASANDERIA TRIGAL	AT	hold_trigal.jpg	1	1	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
6	PRUEBA CPALMA	PCP	microsoft.png	1	1	3	2017-12-25 13:02:25	\N	\N	\N	\N
\.


--
-- Name: impu_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('impu_seq', 4, true);


--
-- Data for Name: impuestos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY impuestos (id, idpais, descripcion, descripcioncorta, obligatorio, valor) FROM stdin;
1	1	IMPUESTO AL VALOR AGREGADO	IVA	S	19.0
2	1	IMPUESTO ADICIONAL A LAS BEBIDAS ALCOHÓLICAS	ILA	N	20.0
3	1	IMPUESTO ADICIONAL A LAS BEBIDAS ANALCOHÓLICAS	IABA	N	5.0
4	1	IMPUESTO A LA CARNE	ICA	N	30.0
\.


--
-- Name: line_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('line_seq', 68, true);


--
-- Data for Name: lineas_negocios; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY lineas_negocios (id, idempr, nombre, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	2	PERFILES DE ACERO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
2	2	CANALETAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
3	2	FIERROS CILINDRICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
4	2	CONSTRUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
5	2	COMERCIALIZACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
6	2	IMPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
7	2	EXPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
8	3	PERFILES DE ACERO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
9	3	CANALETAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
10	3	FIERROS CILINDRICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
11	3	CONSTRUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
12	3	COMERCIALIZACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
13	3	IMPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
14	3	EXPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
15	4	PERFILES DE ACERO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
16	4	CANALETAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
17	4	FIERROS CILINDRICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
18	4	CONSTRUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
19	4	COMERCIALIZACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
20	4	IMPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
21	4	EXPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
22	5	PERFILES DE ACERO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
23	5	CANALETAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
24	5	FIERROS CILINDRICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
25	5	CONSTRUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
26	5	COMERCIALIZACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
27	5	IMPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
28	5	EXPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
29	6	PERFILES DE ACERO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
30	6	CANALETAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
31	6	FIERROS CILINDRICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
32	6	CONSTRUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
33	6	COMERCIALIZACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
34	6	IMPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
35	6	EXPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
36	7	PERFILES DE ACERO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
37	7	CANALETAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
38	7	FIERROS CILINDRICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
39	7	CONSTRUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
40	7	COMERCIALIZACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
41	7	IMPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
42	7	EXPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
43	8	PERFILES DE ACERO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
44	8	CANALETAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
45	8	FIERROS CILINDRICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
46	8	CONSTRUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
47	8	COMERCIALIZACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
48	8	IMPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
49	8	EXPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
50	9	PERFILES DE ACERO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
51	9	CANALETAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
52	9	FIERROS CILINDRICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
53	9	CONSTRUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
54	9	COMERCIALIZACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
55	9	IMPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
56	9	EXPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
57	10	PERFILES DE ACERO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
58	10	CANALETAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
59	10	FIERROS CILINDRICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
60	10	CONSTRUCCION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
61	10	COMERCIALIZACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
62	10	IMPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
63	10	EXPORTACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
64	1	PRUEBA CPALMA	3	2017-12-25 13:38:43	\N	\N	\N	\N
65	1	LINEA DURA	3	2017-12-25 18:42:08	\N	\N	\N	\N
66	1	LINEA BLANDA	3	2017-12-25 18:42:23	\N	\N	\N	\N
67	1	L. DELGADA	3	2017-12-25 18:42:39	\N	\N	\N	\N
68	1	L. GRUESA	3	2017-12-25 18:42:53	\N	\N	\N	\N
\.


--
-- Name: mone_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('mone_seq', 503, false);


--
-- Data for Name: monedas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY monedas (id, nombre, nombrecorto) FROM stdin;
1	PESO CHILENO	CLP
2	PESO ARGENTINO	ARS
3	NUEVO SOL	PEN
4	BOLIVIANO	BOB
5	GUARANÍ	PYG
6	PESO URUGUAYO	UYU
7	REAL	BRL
8	SUCRE	ECS
9	BOLIVAR	VEB
10	PESO COLOMBIANO	COP
11	DÓLAR	USD
501	UNIDAD DE FOMENTO	UF
502	UNIDAD TRIBUTARIA MENSUAL	UTM
\.


--
-- Data for Name: notas_ventas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY notas_ventas (id, idempr, idcove, numero, idclie, descripcionnotaventa, idgere, idproy, idline, idceco, idtare, exento, afecto, impuestos, porcentajedescuento, montodescuento, total, idesnv, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
\.


--
-- Name: nove_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('nove_seq', 1, false);


--
-- Data for Name: ordenes_servicios_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY ordenes_servicios_hono (id, idempr, idsosh, correlativo, codigocompra, idpers, descripcionordenserv, resultadofinal, ideosh, idgere, idproy, idline, idceco, idtare, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
\.


--
-- Data for Name: origenes_productos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY origenes_productos (id, descripcion, descripcioncorta) FROM stdin;
1	NACIONAL	NAC
2	IMPORTADO	IMP
3	EXTRATERRESTRE	ET
\.


--
-- Name: orpr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('orpr_seq', 3, true);


--
-- Name: orsh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('orsh_seq', 1, false);


--
-- Data for Name: pagos_ordenes_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY pagos_ordenes_servs_hono (id, idorsh, fechapago, monto, idtifp, idepos, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
\.


--
-- Name: pais_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('pais_seq', 11, false);


--
-- Data for Name: paises; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY paises (id, nombre, idmone, nacionalidad) FROM stdin;
1	CHILE	1	CHILENA
2	ARGENTINA	2	ARGENTINA
3	PERU	3	PERUANA
4	BOLIVIA	4	BOLIVIANA
5	PARAGUAY	5	PARAGUAYA
6	URUGUAY	6	URUGUAYA
7	BRASIL	7	BRASILENA
8	ECUADOR	8	ECUATORIANA
9	VENEZUELA	9	VENEZOLANA
10	COLOMBIA	10	COLOMBIANA
\.


--
-- Name: para_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('para_seq', 25, true);


--
-- Data for Name: parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY parametros (id, idgrem, nombrecorto, nombrelargo, descripcion, valor, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	1	LARGOMINCLAVE	LARGO MÍNIMO CLAVES USUARIOS	LARGO MINIMO EXIGIDO PARA LAS CLAVES DE LOS USUARIOS	5	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
2	1	NROSEGMSPLCU	NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS	NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING	4	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
3	1	UMVALNOTVE	UNIDAD DE MEDIDA VALIDEZ NOTA VENTA	H = HORAS; D = DÍAS	D	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
4	1	CADUCNV	CADUCIDAD NOTAS DE VENTA	TIEMPO TRAS EL CUAL CADUCA UNA NOTA DE VENTA (1 DÍA, 2 HORAS, ETC.)	1	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
5	1	VALIDEZCOTI	DEFAULT DÍAS VALIDEZ COTIZACIÓN	DÍAS DE VALIDEZ POR DEFECTO DE UNA COTIZACIÓN	5	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
6	2	LARGOMINCLAVE	LARGO MÍNIMO CLAVES USUARIOS	LARGO MINIMO EXIGIDO PARA LAS CLAVES DE LOS USUARIOS	5	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
7	2	NROSEGMSPLCU	NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS	NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING	4	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
8	2	UMVALNOTVE	UNIDAD DE MEDIDA VALIDEZ NOTA VENTA	H = HORAS; D = DÍAS	D	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
9	2	CADUCNV	CADUCIDAD NOTAS DE VENTA	TIEMPO TRAS EL CUAL CADUCA UNA NOTA DE VENTA (1 DÍA, 2 HORAS, ETC.)	1	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
10	2	VALIDEZCOTI	DEFAULT DÍAS VALIDEZ COTIZACIÓN	DÍAS DE VALIDEZ POR DEFECTO DE UNA COTIZACIÓN	5	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
11	3	LARGOMINCLAVE	LARGO MÍNIMO CLAVES USUARIOS	LARGO MINIMO EXIGIDO PARA LAS CLAVES DE LOS USUARIOS	5	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
12	3	NROSEGMSPLCU	NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS	NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING	4	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
13	3	UMVALNOTVE	UNIDAD DE MEDIDA VALIDEZ NOTA VENTA	H = HORAS; D = DÍAS	D	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
14	3	CADUCNV	CADUCIDAD NOTAS DE VENTA	TIEMPO TRAS EL CUAL CADUCA UNA NOTA DE VENTA (1 DÍA, 2 HORAS, ETC.)	1	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
15	3	VALIDEZCOTI	DEFAULT DÍAS VALIDEZ COTIZACIÓN	DÍAS DE VALIDEZ POR DEFECTO DE UNA COTIZACIÓN	5	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
16	4	LARGOMINCLAVE	LARGO MÍNIMO CLAVES USUARIOS	LARGO MINIMO EXIGIDO PARA LAS CLAVES DE LOS USUARIOS	5	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
17	4	NROSEGMSPLCU	NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS	NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING	4	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
18	4	UMVALNOTVE	UNIDAD DE MEDIDA VALIDEZ NOTA VENTA	H = HORAS; D = DÍAS	D	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
19	4	CADUCNV	CADUCIDAD NOTAS DE VENTA	TIEMPO TRAS EL CUAL CADUCA UNA NOTA DE VENTA (1 DÍA, 2 HORAS, ETC.)	1	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
20	4	VALIDEZCOTI	DEFAULT DÍAS VALIDEZ COTIZACIÓN	DÍAS DE VALIDEZ POR DEFECTO DE UNA COTIZACIÓN	5	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
21	6	LARGOMINCLAVE	LARGO MÍNIMO CLAVES USUARIOS	LARGO MINIMO EXIGIDO PARA LAS CLAVES DE LOS USUARIOS	5	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
22	6	NROSEGMSPLCU	NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS	NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING	4	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
23	6	UMVALNOTVE	UNIDAD DE MEDIDA VALIDEZ NOTA VENTA	H = HORAS; D = DÍAS	D	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
24	6	CADUCNV	CADUCIDAD NOTAS DE VENTA	TIEMPO TRAS EL CUAL CADUCA UNA NOTA DE VENTA (1 DÍA, 2 HORAS, ETC.)	1	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
25	6	VALIDEZCOTI	DEFAULT DÍAS VALIDEZ COTIZACIÓN	DÍAS DE VALIDEZ POR DEFECTO DE UNA COTIZACIÓN	5	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
\.


--
-- Name: pepr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('pepr_seq', 215, false);


--
-- Name: perf_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('perf_seq', 2025, false);


--
-- Data for Name: perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY perfiles (id, descripcion) FROM stdin;
1	CONFIGURADOR
2	ADMINISTRADOR DEL CLIENTE
3	ADMINISTRADOR EMPRESA
4	ADMINISTRADOR DEL CLIENTE Y EMPRESA
5	GERENTE GENERAL
6	SECRETARIA GERENTE GENERAL
7	GERENTE DE ADMINISTRACION Y FINANZAS
8	SECRETARIA GERENTE DE ADMINISTRACION Y FINANZAS
9	TESORERO
0	ASISTENTE 1 TESORERO
11	ASISTENTE 2 TESORERO
12	CAJERO
13	CONTADOR GENERAL
14	ASISTENTE 1 CONTABILIDAD
15	ASISTENTE 2 CONTABILIDAD
16	JEFE DE COMPRAS
17	AYUDANTE JEFE DE COMPRAS
18	JEFE DE VENTAS
19	AYUDANTE JEFE DE VENTAS
10	VENDEDOR
21	USUARIO
22	USUARIO HÍBRIDO
273	PERFIL DE PRUEBA CON ACCESO A TODO
2024	PERFIL DE PRUEBA LEGALES
\.


--
-- Data for Name: perfiles_programas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY perfiles_programas (id, idperf, idprog, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	1	1000	1	2017-12-24 10:48:04.713995	\N	\N	\N	\N
2	1	1010	1	2017-12-24 10:48:04.722324	\N	\N	\N	\N
3	1	1020	1	2017-12-24 10:48:04.730684	\N	\N	\N	\N
4	1	2000	1	2017-12-24 10:48:04.739027	\N	\N	\N	\N
5	1	2010	1	2017-12-24 10:48:04.74738	\N	\N	\N	\N
6	1	2020	1	2017-12-24 10:48:04.755661	\N	\N	\N	\N
7	1	2030	1	2017-12-24 10:48:04.76399	\N	\N	\N	\N
8	1	2040	1	2017-12-24 10:48:04.772416	\N	\N	\N	\N
9	1	2050	1	2017-12-24 10:48:04.780727	\N	\N	\N	\N
10	1	2060	1	2017-12-24 10:48:04.789048	\N	\N	\N	\N
11	1	2070	1	2017-12-24 10:48:04.797418	\N	\N	\N	\N
12	1	2080	1	2017-12-24 10:48:04.805749	\N	\N	\N	\N
13	1	2090	1	2017-12-24 10:48:04.814077	\N	\N	\N	\N
14	1	2100	1	2017-12-24 10:48:04.822418	\N	\N	\N	\N
15	1	2110	1	2017-12-24 10:48:04.830749	\N	\N	\N	\N
16	1	2120	1	2017-12-24 10:48:04.839083	\N	\N	\N	\N
17	1	2130	1	2017-12-24 10:48:04.847413	\N	\N	\N	\N
18	1	2140	1	2017-12-24 10:48:04.85575	\N	\N	\N	\N
19	1	2150	1	2017-12-24 10:48:04.864077	\N	\N	\N	\N
20	1	2160	1	2017-12-24 10:48:04.872414	\N	\N	\N	\N
21	1	2170	1	2017-12-24 10:48:04.880754	\N	\N	\N	\N
22	1	2180	1	2017-12-24 10:48:04.889078	\N	\N	\N	\N
23	1	2190	1	2017-12-24 10:48:04.897405	\N	\N	\N	\N
24	1	2200	1	2017-12-24 10:48:04.905747	\N	\N	\N	\N
25	1	3000	1	2017-12-24 10:48:04.914076	\N	\N	\N	\N
26	1	3010	1	2017-12-24 10:48:04.922397	\N	\N	\N	\N
27	1	3020	1	2017-12-24 10:48:04.930725	\N	\N	\N	\N
28	1	3030	1	2017-12-24 10:48:04.939144	\N	\N	\N	\N
29	1	3040	1	2017-12-24 10:48:04.947478	\N	\N	\N	\N
30	1	3060	1	2017-12-24 10:48:04.955804	\N	\N	\N	\N
31	1	3070	1	2017-12-24 10:48:04.964146	\N	\N	\N	\N
32	1	3080	1	2017-12-24 10:48:04.972461	\N	\N	\N	\N
33	1	5000	1	2017-12-24 10:48:04.980808	\N	\N	\N	\N
34	1	5010	1	2017-12-24 10:48:04.989141	\N	\N	\N	\N
35	1	5020	1	2017-12-24 10:48:04.997479	\N	\N	\N	\N
36	2	1000	1	2017-12-24 10:48:05.005803	\N	\N	\N	\N
37	2	1010	1	2017-12-24 10:48:05.014146	\N	\N	\N	\N
38	2	1020	1	2017-12-24 10:48:05.022458	\N	\N	\N	\N
39	2	2000	1	2017-12-24 10:48:05.0308	\N	\N	\N	\N
40	2	2040	1	2017-12-24 10:48:05.039051	\N	\N	\N	\N
41	2	3000	1	2017-12-24 10:48:05.047478	\N	\N	\N	\N
42	2	3010	1	2017-12-24 10:48:05.055721	\N	\N	\N	\N
43	2	3020	1	2017-12-24 10:48:05.064137	\N	\N	\N	\N
44	2	3030	1	2017-12-24 10:48:05.07246	\N	\N	\N	\N
45	2	3040	1	2017-12-24 10:48:05.097536	\N	\N	\N	\N
46	2	3060	1	2017-12-24 10:48:05.105869	\N	\N	\N	\N
47	2	3070	1	2017-12-24 10:48:05.114199	\N	\N	\N	\N
48	2	3080	1	2017-12-24 10:48:05.122561	\N	\N	\N	\N
49	3	4000	1	2017-12-24 10:48:05.130865	\N	\N	\N	\N
50	3	4010	1	2017-12-24 10:48:05.139203	\N	\N	\N	\N
51	3	4020	1	2017-12-24 10:48:05.147561	\N	\N	\N	\N
52	3	4030	1	2017-12-24 10:48:05.15587	\N	\N	\N	\N
53	3	4040	1	2017-12-24 10:48:05.164192	\N	\N	\N	\N
54	3	4050	1	2017-12-24 10:48:05.172563	\N	\N	\N	\N
55	3	4060	1	2017-12-24 10:48:05.18087	\N	\N	\N	\N
56	3	4070	1	2017-12-24 10:48:05.189196	\N	\N	\N	\N
57	4	1000	1	2017-12-24 10:48:05.197564	\N	\N	\N	\N
58	4	1010	1	2017-12-24 10:48:05.205862	\N	\N	\N	\N
59	4	1020	1	2017-12-24 10:48:05.214158	\N	\N	\N	\N
60	4	2000	1	2017-12-24 10:48:05.222498	\N	\N	\N	\N
61	4	2040	1	2017-12-24 10:48:05.230828	\N	\N	\N	\N
62	4	3000	1	2017-12-24 10:48:05.239157	\N	\N	\N	\N
63	4	3010	1	2017-12-24 10:48:05.247477	\N	\N	\N	\N
64	4	3020	1	2017-12-24 10:48:05.255883	\N	\N	\N	\N
65	4	3030	1	2017-12-24 10:48:05.264225	\N	\N	\N	\N
66	4	3040	1	2017-12-24 10:48:05.314231	\N	\N	\N	\N
67	4	3060	1	2017-12-24 10:48:05.322572	\N	\N	\N	\N
68	4	3070	1	2017-12-24 10:48:05.330922	\N	\N	\N	\N
69	4	3080	1	2017-12-24 10:48:05.339252	\N	\N	\N	\N
70	4	4000	1	2017-12-24 10:48:05.34757	\N	\N	\N	\N
71	4	4010	1	2017-12-24 10:48:05.355933	\N	\N	\N	\N
72	4	4020	1	2017-12-24 10:48:05.364256	\N	\N	\N	\N
73	4	4030	1	2017-12-24 10:48:05.372569	\N	\N	\N	\N
74	4	4040	1	2017-12-24 10:48:05.380928	\N	\N	\N	\N
75	4	4050	1	2017-12-24 10:48:05.389257	\N	\N	\N	\N
76	4	4060	1	2017-12-24 10:48:05.397572	\N	\N	\N	\N
77	4	4070	1	2017-12-24 10:48:05.447596	\N	\N	\N	\N
78	21	1000	1	2017-12-24 10:48:05.455918	\N	\N	\N	\N
79	21	1010	1	2017-12-24 10:48:05.464251	\N	\N	\N	\N
80	21	1020	1	2017-12-24 10:48:05.472571	\N	\N	\N	\N
81	21	5000	1	2017-12-24 10:48:05.480925	\N	\N	\N	\N
82	21	5010	1	2017-12-24 10:48:05.489251	\N	\N	\N	\N
83	21	5020	1	2017-12-24 10:48:05.497649	\N	\N	\N	\N
84	22	1000	1	2017-12-24 10:48:05.505988	\N	\N	\N	\N
85	22	1010	1	2017-12-24 10:48:05.514307	\N	\N	\N	\N
86	22	1020	1	2017-12-24 10:48:05.522649	\N	\N	\N	\N
87	22	2000	1	2017-12-24 10:48:05.530994	\N	\N	\N	\N
88	22	2010	1	2017-12-24 10:48:05.581002	\N	\N	\N	\N
89	22	2030	1	2017-12-24 10:48:05.58932	\N	\N	\N	\N
90	22	2040	1	2017-12-24 10:48:05.597633	\N	\N	\N	\N
91	22	2050	1	2017-12-24 10:48:05.605954	\N	\N	\N	\N
92	22	2060	1	2017-12-24 10:48:05.614292	\N	\N	\N	\N
93	22	2070	1	2017-12-24 10:48:05.622558	\N	\N	\N	\N
94	22	2080	1	2017-12-24 10:48:05.630964	\N	\N	\N	\N
95	22	2090	1	2017-12-24 10:48:05.639291	\N	\N	\N	\N
96	22	2100	1	2017-12-24 10:48:05.647636	\N	\N	\N	\N
97	22	2110	1	2017-12-24 10:48:05.655953	\N	\N	\N	\N
98	22	2120	1	2017-12-24 10:48:05.664288	\N	\N	\N	\N
99	22	2130	1	2017-12-24 10:48:05.705971	\N	\N	\N	\N
100	22	2140	1	2017-12-24 10:48:05.714295	\N	\N	\N	\N
101	22	2150	1	2017-12-24 10:48:05.722697	\N	\N	\N	\N
102	22	2160	1	2017-12-24 10:48:05.731032	\N	\N	\N	\N
103	22	2170	1	2017-12-24 10:48:05.739389	\N	\N	\N	\N
104	22	2180	1	2017-12-24 10:48:05.747699	\N	\N	\N	\N
105	22	2190	1	2017-12-24 10:48:05.756032	\N	\N	\N	\N
106	22	2200	1	2017-12-24 10:48:05.764382	\N	\N	\N	\N
107	22	3000	1	2017-12-24 10:48:05.772698	\N	\N	\N	\N
108	22	3010	1	2017-12-24 10:48:05.781029	\N	\N	\N	\N
109	22	3020	1	2017-12-24 10:48:05.789386	\N	\N	\N	\N
110	22	3030	1	2017-12-24 10:48:05.839393	\N	\N	\N	\N
111	22	3040	1	2017-12-24 10:48:05.847693	\N	\N	\N	\N
112	22	3060	1	2017-12-24 10:48:05.85603	\N	\N	\N	\N
113	22	3070	1	2017-12-24 10:48:05.864382	\N	\N	\N	\N
114	22	3080	1	2017-12-24 10:48:05.872686	\N	\N	\N	\N
115	22	5000	1	2017-12-24 10:48:05.881027	\N	\N	\N	\N
116	22	5010	1	2017-12-24 10:48:05.889349	\N	\N	\N	\N
117	22	5020	1	2017-12-24 10:48:05.897693	\N	\N	\N	\N
118	8	1000	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
119	8	1010	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
120	8	1020	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
121	12	1000	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
122	12	1010	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
123	12	1020	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
124	15	1000	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
125	15	1010	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
126	15	1020	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
127	17	1000	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
128	17	1010	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
129	17	1020	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
130	273	1000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
131	273	1010	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
132	273	1020	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
133	273	2000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
134	273	2010	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
135	273	2020	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
136	273	2030	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
137	273	2040	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
138	273	2050	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
139	273	2060	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
140	273	2070	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
141	273	2080	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
142	273	2090	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
143	273	2100	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
144	273	2110	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
145	273	2120	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
146	273	2130	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
147	273	2140	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
148	273	2150	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
149	273	2160	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
150	273	2170	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
151	273	2180	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
152	273	2190	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
153	273	2200	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
154	273	3000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
155	273	3010	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
156	273	3020	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
157	273	3030	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
158	273	3040	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
159	273	3050	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
160	273	3060	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
161	273	3070	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
162	273	3080	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
163	273	3090	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
164	273	4000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
165	273	4010	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
166	273	4020	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
167	273	4030	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
168	273	4040	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
169	273	4050	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
170	273	4060	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
171	273	4070	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
172	273	5000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
173	273	5010	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
174	273	5020	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
175	273	6000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
176	273	6010	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
177	273	6020	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
178	273	6030	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
179	273	6040	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
180	273	6050	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
181	273	7000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
182	273	7010	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
183	273	7020	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
184	273	7030	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
185	273	7040	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
186	273	7050	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
187	273	8000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
188	273	8010	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
189	273	8020	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
190	273	8030	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
191	273	8040	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
192	273	8050	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
193	273	9000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
194	273	9010	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
195	273	9020	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
196	273	9030	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
197	273	9040	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
198	273	9050	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
199	273	10000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
200	273	10010	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
201	273	10020	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
202	273	10030	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
203	273	10040	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
204	273	10050	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
205	273	11000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
206	2024	1000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
207	2024	1010	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
208	2024	1020	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
209	2024	3000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
210	2024	3070	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
211	2024	3080	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
212	2024	5000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
213	2024	5010	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
214	2024	5020	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
\.


--
-- Name: pers_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('pers_seq', 14, true);


--
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY personas (id, idgrem, identificador1, identificador2, primernombre, segundonombre, apellidopaterno, apellidomaterno, email, fechanac, idesci, idsexo, idpais, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	1	1	9	ADMINISTRADOR	\N	SISTEMA	AS	\N	\N	\N	\N	\N	1	2017-12-24 10:47:53.937782	\N	\N	\N	\N
2	1	2	7	ROLANDO	\N	SILVA	-		\N	2	1	1	1	2017-12-24 10:47:54.063612	\N	\N	\N	\N
3	1	3	5	SERGIO	\N	AGUIRRE	-	sergio.aguirre@bt5.cl	\N	1	1	1	1	2017-12-24 10:47:54.071918	\N	\N	\N	\N
4	1	4	3	JUAN	JOSE	MONSALVE	-	juan.jose.monsalve@bt5.cl	\N	\N	1	1	1	2017-12-24 10:47:54.080248	\N	\N	\N	\N
5	1	5	1	JUAN	ANDRES	BORZONE	-		\N	\N	1	1	1	2017-12-24 10:47:54.088614	\N	\N	\N	\N
6	1	6	K	RODRIGO	\N	CIFUENTES	-	rodrigo.cifuentes@bt5.cl	\N	1	1	1	1	2017-12-24 10:47:54.138612	\N	\N	\N	\N
7	1	7695503	4	ROBERTO	DANIEL	QUEZADA	ASTE	roberto.quezada@bt5.cl	\N	2	1	1	1	2017-12-24 10:47:54.146912	\N	\N	\N	\N
8	1	8965445	9	OSCIEL	SEGUNDO	SOLAR	MALDONADO	solar2design@gmail.com	\N	2	1	1	1	2017-12-24 10:47:54.155298	\N	\N	\N	\N
9	1	13254825	0	NILTON	PATRICIO	SALAZAR	GONZALEZ	nilton.salazar@gmail.com	\N	1	1	1	1	2017-12-24 10:47:54.163644	\N	\N	\N	\N
10	1	10917721	0	G. CRISTIAN	\N	PALMA	ASTE	gerardo.palma.aste@gmail.com	1968-11-12	1	1	1	1	2017-12-24 10:47:54.171976	\N	\N	\N	\N
11	2	13047104	8	JUAN	\N	CISTERNA	FUENTES	\N	\N	\N	\N	\N	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
12	1	999	7	USUARIO	\N	ACCESO	TOTAL	\N	\N	\N	\N	\N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
13	1	99	K	UBALDO	\N	LEGALES	\N	\N	\N	\N	\N	\N	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
14	6	21878885	8	NICOLAS	ANTONIO	PALMA	MANRIQUEZ	GCPA68@HOTMAIL.COM	2005-07-05	1	1	1	3	2017-12-25 13:02:25	\N	\N	\N	\N
\.


--
-- Data for Name: planes_cuentas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY planes_cuentas (id, idgrem, segmento1, segmento2, segmento3, segmento4, segmento5, segmento6, segmento7, segmento8, descripcion, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	1	1	00	00	0000	\N	\N	\N	\N	ACTIVOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
2	1	1	10	00	0000	\N	\N	\N	\N	ACTIVOS CORRIENTES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
3	1	1	10	10	0000	\N	\N	\N	\N	EFECTIVO Y EQUIVALENTE AL EFECTIVO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
4	1	1	10	10	1001	\N	\N	\N	\N	CAJA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
5	1	1	10	10	1002	\N	\N	\N	\N	FONDO FIJO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
6	1	1	10	10	2001	\N	\N	\N	\N	BANCO SANTANDER	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
7	1	1	10	10	2002	\N	\N	\N	\N	BANCO DE CHILE	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
8	1	1	10	10	2003	\N	\N	\N	\N	BANCO BBVA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
9	1	1	10	10	2004	\N	\N	\N	\N	BANCO BCI	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
10	1	1	10	10	2005	\N	\N	\N	\N	BANCO ITAU	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
11	1	1	10	10	2006	\N	\N	\N	\N	BANCO SECURITY	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
12	1	1	10	10	2007	\N	\N	\N	\N	BANCO SANTANDER DOLAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
13	1	1	10	10	2008	\N	\N	\N	\N	BANCO DE CHILE DOLAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
14	1	1	10	10	2009	\N	\N	\N	\N	BANCO BBVA DOLAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
15	1	1	10	10	2010	\N	\N	\N	\N	BANCO BCI DOLAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
16	1	1	10	10	2011	\N	\N	\N	\N	BANCO ITAU DOLAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
17	1	1	10	10	2012	\N	\N	\N	\N	BANCO SECURITY DOLAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
18	1	1	10	11	0000	\N	\N	\N	\N	OTROS ACTIVOS FINANCIEROS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
19	1	1	10	11	0001	\N	\N	\N	\N	DEPOSITOS A PLAZO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
20	1	1	10	11	1002	\N	\N	\N	\N	FONDOS MUTUOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
21	1	1	10	11	1003	\N	\N	\N	\N	PACTOS RETROVENTA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
22	1	1	10	12	0000	\N	\N	\N	\N	OTROS ACTIVOS NO FINANCIEROS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
23	1	1	10	13	0000	\N	\N	\N	\N	DEUDORES COMERCIALES Y OTRAS CUENTAS POR COBRAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
24	1	1	10	13	1001	\N	\N	\N	\N	CLIENTES NACIONALES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
25	1	1	10	13	1002	\N	\N	\N	\N	CLIENTES EXTRANJEROS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
26	1	1	10	13	1003	\N	\N	\N	\N	CHEQUES EN CARTERA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
27	1	1	10	13	1004	\N	\N	\N	\N	TARJETA DE DEBITO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
28	1	1	10	13	1005	\N	\N	\N	\N	TARJETA DE CREDITO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
29	1	1	10	13	1006	\N	\N	\N	\N	CHEQUES PROTESTADOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
30	1	1	10	13	1007	\N	\N	\N	\N	DOCUMENTOS PROTESTADOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
31	1	1	10	13	2001	\N	\N	\N	\N	ESTIMACION DEUDORES INCOBRABLES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
32	1	1	10	13	3001	\N	\N	\N	\N	FONDOS POR RENDIR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
33	1	1	10	13	4001	\N	\N	\N	\N	PRESTAMOS AL PERSONAL	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
34	1	1	10	13	5001	\N	\N	\N	\N	ANTICIPO DE SUELDO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
35	1	1	10	13	5002	\N	\N	\N	\N	ANTICIPO DE HONORARIOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
36	1	1	10	13	5003	\N	\N	\N	\N	ANTICIPO A PROVEEDORES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
37	1	1	10	14	0000	\N	\N	\N	\N	CUENTAS POR COBRAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
38	1	1	10	14	1001	\N	\N	\N	\N	CUENTAS POR COBRAR EMPRESA RELACIONADA NACIONAL	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
39	1	1	10	14	1002	\N	\N	\N	\N	CUENTAS POR COBRAR EMPRESA RELACIONADA EXTRANJERA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
40	1	1	10	15	0000	\N	\N	\N	\N	INVENTARIOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
41	1	1	10	15	1001	\N	\N	\N	\N	EXISTENCIA EN TRANSITO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
42	1	1	10	15	1002	\N	\N	\N	\N	EXISTENCIAS EN PROCESO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
43	1	1	10	15	2001	\N	\N	\N	\N	EXISTENCIAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
44	1	1	10	16	0000	\N	\N	\N	\N	ACTIVOS BIOLOGICOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
45	1	1	10	17	0000	\N	\N	\N	\N	ACTIVOS POR IMPUESTOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
46	1	1	10	17	1001	\N	\N	\N	\N	PAGOS PROVISIONALES MENSUALES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
47	1	1	10	17	1002	\N	\N	\N	\N	IVA CREDITO FISCAL	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
48	1	1	10	17	2001	\N	\N	\N	\N	OTROS IMPUESTOS POR RECUPERAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
49	1	1	10	19	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA LA VENTA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
50	1	1	10	19	1001	\N	\N	\N	\N	ACTIVOS DISPONIBLES MANTENIDOS PARA LA VENTA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
51	1	1	10	20	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA DISTRIBUIR A PROPIETARIOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
52	1	1	10	21	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA LA VENTA O A DISTRIBUIR A LOS PROPIETARIOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
53	1	1	20	00	0000	\N	\N	\N	\N	ACTIVOS NO CORRIENTES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
54	1	1	20	10	0000	\N	\N	\N	\N	OTROS ACTIVOS FINANCIEROS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
55	1	1	20	10	1001	\N	\N	\N	\N	SEGUROS PAGADOS POR ANTICIPADO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
56	1	1	20	10	1002	\N	\N	\N	\N	ARRIENDOS PAGADOS POR ANTICIPADO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
57	1	1	20	10	1003	\N	\N	\N	\N	OTROS GASTOS PAGADOS POR ANTICIPADO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
58	1	1	20	10	1004	\N	\N	\N	\N	GARANTIAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
59	1	1	20	10	2001	\N	\N	\N	\N	INTERESES DIFERIDOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
60	1	1	20	11	0000	\N	\N	\N	\N	OTROS ACTIVOS NO FINANCIEROS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
61	1	1	20	12	0000	\N	\N	\N	\N	DERECHOS POR COBRAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
62	1	1	20	13	0000	\N	\N	\N	\N	CUENTAS POR COBRAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
63	1	1	20	14	0000	\N	\N	\N	\N	INVERSIONES POR METODO DE PARTICIPACION	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
64	1	1	20	15	0000	\N	\N	\N	\N	ACTIVOS INTANGIBLES DISTINTO A LA PLUSVALIA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
65	1	1	20	16	0000	\N	\N	\N	\N	PLUSVALIA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
66	1	1	20	17	0000	\N	\N	\N	\N	PROPIEDADES, PLANTAS Y EQUIPOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
67	1	1	20	17	1001	\N	\N	\N	\N	TERRENOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
68	1	1	20	17	2001	\N	\N	\N	\N	CONSTRUCCIONES E INTALACIONES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
69	1	1	20	17	3001	\N	\N	\N	\N	MUEBLES E UTILES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
70	1	1	20	17	4001	\N	\N	\N	\N	VEHICULOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
71	1	1	20	17	5001	\N	\N	\N	\N	EQUIPOS COMPUTACIONALES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
72	1	1	20	17	6001	\N	\N	\N	\N	ACTIVOS EN LEASING	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
73	1	1	20	17	7001	\N	\N	\N	\N	PROGRAMAS Y SOFTWARES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
74	1	1	20	17	8001	\N	\N	\N	\N	DEPRECIACION ACUMULADA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
75	1	1	20	18	0000	\N	\N	\N	\N	ACTIVOS BIOLOGICOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
76	1	1	20	19	0000	\N	\N	\N	\N	PROPIEDADES DE INVERSION	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
77	1	1	20	20	0000	\N	\N	\N	\N	ACTIVOS POR IMPUESTO DIFERIDO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
78	1	2	00	00	0000	\N	\N	\N	\N	PASIVOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
79	1	2	10	00	0000	\N	\N	\N	\N	PASIVOS CORRIENTES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
80	1	2	10	10	0000	\N	\N	\N	\N	OTROS PASIVOS FINANCIEROS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
81	1	2	10	10	1001	\N	\N	\N	\N	OBLIGACIONES CON BANCOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
82	1	2	10	10	1002	\N	\N	\N	\N	LINEAS DE CREDITO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
83	1	2	10	10	1003	\N	\N	\N	\N	OBLIGACIONES CON LEASING	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
84	1	2	10	11	0000	\N	\N	\N	\N	CUENTAS COMERCIALES Y OTRAS CUENTAS POR PAGAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
85	1	2	10	11	1001	\N	\N	\N	\N	PROVEEDORES NACIONALES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
86	1	2	10	11	1002	\N	\N	\N	\N	PROVEEDORES EXTRANJEROS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
87	1	2	10	11	1003	\N	\N	\N	\N	CHEQUES POR PAGAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
88	1	2	10	11	1004	\N	\N	\N	\N	HONORARIOS POR PAGAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
89	1	2	10	11	1005	\N	\N	\N	\N	ANTICIPOS DE CLIENTES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
90	1	2	10	12	0000	\N	\N	\N	\N	CUENTAS POR PAGAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
91	1	2	10	12	1001	\N	\N	\N	\N	CUENTAS POR PAGAR ENTIDAD RELACIONADA NACIONAL	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
92	1	2	10	12	1002	\N	\N	\N	\N	CUENTAS POR PAGAR ENTIDAD RELACIONADA EXTRANJERA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
93	1	2	10	13	0000	\N	\N	\N	\N	OTRAS PROVISIONES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
94	1	2	10	13	1001	\N	\N	\N	\N	PROVISIONES POR PAGAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
95	1	2	10	13	2001	\N	\N	\N	\N	PROVISION DE VACACIONES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
96	1	2	10	13	2002	\N	\N	\N	\N	PROVISIONES VARIAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
97	1	2	10	14	0000	\N	\N	\N	\N	PASIVOS POR IMPUESTOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
98	1	2	10	14	1001	\N	\N	\N	\N	IVA DEBITO FISCAL	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
99	1	2	10	14	1002	\N	\N	\N	\N	IVA POR PAGAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
100	1	2	10	14	1003	\N	\N	\N	\N	RETENCION 1RA CATEGORIA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
101	1	2	10	14	1004	\N	\N	\N	\N	RETENCION 2DA CATEGORIA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
102	1	2	10	14	1005	\N	\N	\N	\N	PPM POR PAGAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
103	1	2	10	14	2001	\N	\N	\N	\N	PROVISION IMPUESTO A LA RENTA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
104	1	2	10	15	0000	\N	\N	\N	\N	PROVISIONES POR BENEFICIOS A EMPLEADOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
105	1	2	10	16	0000	\N	\N	\N	\N	OTROS PASIVOS NO FINANCIEROS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
106	1	2	10	18	0000	\N	\N	\N	\N	PASIVOS CLASIFICADOS COMO MANTENIDOS PARA LA VENTA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
107	1	2	20	00	0000	\N	\N	\N	\N	PASIVOS NO CORRIENTES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
108	1	2	20	10	0000	\N	\N	\N	\N	OTROS PASIVOS FINANCIEROS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
109	1	2	20	11	0000	\N	\N	\N	\N	OTRAS CUENTAS POR PAGAR	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
110	1	2	20	12	0000	\N	\N	\N	\N	CUENTAS POR PAGAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
111	1	2	20	13	0000	\N	\N	\N	\N	OTRAS PROVISIONES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
112	1	2	20	14	0000	\N	\N	\N	\N	PASIVOS POR IMPUESTOS DIFERIDOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
113	1	2	20	15	0000	\N	\N	\N	\N	PROVISIONES POR BENEFICIOS A LOS EMPLEADOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
114	1	2	20	16	0000	\N	\N	\N	\N	OTROS PASIVOS NO FINANCIEROS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
115	1	2	30	00	0000	\N	\N	\N	\N	PATRIMONIO  	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
116	1	2	30	10	0000	\N	\N	\N	\N	CAPITAL EMITIDO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
117	1	2	30	10	0001	\N	\N	\N	\N	CAPITAL	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
118	1	2	30	11	0000	\N	\N	\N	\N	GANANCIAS (PERDIDAS) ACUMULADAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
119	1	2	30	11	0001	\N	\N	\N	\N	RESULTADO ACUMULADO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
120	1	2	30	12	0000	\N	\N	\N	\N	PRIMAS DE EMISION	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
121	1	2	30	13	0000	\N	\N	\N	\N	ACCIONES PROPIAS EN CARTERA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
122	1	2	30	14	0000	\N	\N	\N	\N	OTRAS PARTICIPACIONES EN EL PATRIMONIO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
123	1	2	30	15	0000	\N	\N	\N	\N	OTRAS RESERVAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
124	1	2	30	16	0000	\N	\N	\N	\N	PATRIMONIO ATRIBUIBLE A PROPIETARIOS DE LA CONTROLADORA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
125	1	2	30	17	0000	\N	\N	\N	\N	PARTICIPACIONES NO CONTROLADORAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
126	1	3	00	00	0000	\N	\N	\N	\N	RESULTADO GANANCIA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
127	1	3	10	10	0000	\N	\N	\N	\N	INGRESOS DE ACTIVIDADES ORDINARIAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
128	1	3	10	10	1001	\N	\N	\N	\N	VENTA DE GRUAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
129	1	3	10	10	1002	\N	\N	\N	\N	VENTA DE ACCESORIAS DE GRUAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
130	1	3	10	10	1003	\N	\N	\N	\N	VENTA DE PLATAFORMAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
131	1	3	10	10	1004	\N	\N	\N	\N	VENTA DE REPUESTOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
132	1	3	10	10	1005	\N	\N	\N	\N	VENTA DE SERVICIO TECNICO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
133	1	3	10	10	1006	\N	\N	\N	\N	VENTA DE LEASING	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
134	1	3	10	10	2001	\N	\N	\N	\N	ARRIENDOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
135	1	3	20	10	0000	\N	\N	\N	\N	OTROS INGRESOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
136	1	3	20	10	1001	\N	\N	\N	\N	GARANTIAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
137	1	3	20	11	0000	\N	\N	\N	\N	OTRAS GANANCIAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
138	1	3	20	12	0000	\N	\N	\N	\N	INGRESOS FINANCIEROS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
139	1	4	00	00	0000	\N	\N	\N	\N	RESULTADO PERDIDA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
140	1	4	10	00	0000	\N	\N	\N	\N	COSTO DE VENTA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
141	1	4	10	10	1001	\N	\N	\N	\N	COSTO DE GRUAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
142	1	4	10	10	1002	\N	\N	\N	\N	COSTO DE ACCESORIAS DE GRUAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
143	1	4	10	10	1003	\N	\N	\N	\N	COSTO DE PLATAFORMAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
144	1	4	10	10	1004	\N	\N	\N	\N	COSTO DE REPUESTOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
145	1	4	10	10	1005	\N	\N	\N	\N	COSTO DE SERVICIO TECNICO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
146	1	4	10	10	1006	\N	\N	\N	\N	COSTO DE LEASING	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
147	1	4	10	10	2001	\N	\N	\N	\N	COSTO DE ARRIENDO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
148	1	4	20	10	0000	\N	\N	\N	\N	OTROS COSTOS DE EXPLOTACION	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
149	1	4	20	11	0000	\N	\N	\N	\N	GASTOS DE ADMINISTRACION Y VENTA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
150	1	4	20	11	1001	\N	\N	\N	\N	REMUNERACIONES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
151	1	4	20	11	1002	\N	\N	\N	\N	COMISIONES POR VENTA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
152	1	4	20	11	1003	\N	\N	\N	\N	FINIQUITOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
153	1	4	20	11	2001	\N	\N	\N	\N	ASESORIA INFORMATICA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
154	1	4	20	11	2002	\N	\N	\N	\N	ASESORIA COMEX	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
155	1	4	20	11	2003	\N	\N	\N	\N	ASESORIA DE MARKETING	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
156	1	4	20	11	2004	\N	\N	\N	\N	ASESORIA LEGAL	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
157	1	4	20	11	2005	\N	\N	\N	\N	ASESORIA CONTABLE	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
158	1	4	20	11	2006	\N	\N	\N	\N	ASESORIA TECNICA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
159	1	4	20	11	3001	\N	\N	\N	\N	GASTOS DE PUBLICIDAD	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
160	1	4	20	11	3002	\N	\N	\N	\N	GASTOS DE REPRESENTACION	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
161	1	4	20	11	3003	\N	\N	\N	\N	VIAJES Y ESTADIAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
162	1	4	20	11	3004	\N	\N	\N	\N	FERIAS Y STAND	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
163	1	4	20	11	4001	\N	\N	\N	\N	ARRIENDO DE OFICINAS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
164	1	4	20	11	4002	\N	\N	\N	\N	COMBUSTIBLE	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
165	1	4	20	11	4003	\N	\N	\N	\N	GASTOS DE OFICINA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
166	1	4	20	11	4004	\N	\N	\N	\N	MANTENCION DE VEHICULOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
167	1	4	20	11	4005	\N	\N	\N	\N	TELEFONOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
168	1	4	20	11	4006	\N	\N	\N	\N	AGUA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
169	1	4	20	11	4007	\N	\N	\N	\N	ELECTRICIDAD	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
170	1	4	20	11	4008	\N	\N	\N	\N	GASTOS DE IMPRENTA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
171	1	4	20	11	5001	\N	\N	\N	\N	SERVICIO DE ASEO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
172	1	4	20	11	5002	\N	\N	\N	\N	SERVICIO DE VIGILANCIA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
173	1	4	20	11	6001	\N	\N	\N	\N	SEGUROS DE CHEQUES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
174	1	4	20	11	6002	\N	\N	\N	\N	SEGUROS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
175	1	4	20	11	7001	\N	\N	\N	\N	COLACION	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
176	1	4	20	11	7002	\N	\N	\N	\N	CORRESPONDENCIA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
177	1	4	20	11	7003	\N	\N	\N	\N	ALARMA DE SEGURIDAD	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
178	1	4	20	11	7004	\N	\N	\N	\N	TAG	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
179	1	4	20	11	7005	\N	\N	\N	\N	ROPA DE TRABAJO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
180	1	4	20	11	7006	\N	\N	\N	\N	GASTOS DE TV CABLE	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
181	1	4	20	11	7007	\N	\N	\N	\N	GASTOS DE DICOM	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
182	1	4	20	11	7008	\N	\N	\N	\N	GASTOS DE DOMINIO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
183	1	4	20	11	7009	\N	\N	\N	\N	FLETES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
184	1	4	20	11	7010	\N	\N	\N	\N	GPS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
185	1	4	20	12	0000	\N	\N	\N	\N	OTROS GASTOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
186	1	4	20	13	0000	\N	\N	\N	\N	COSTOS FINANCIEROS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
187	1	4	20	13	1001	\N	\N	\N	\N	GASTOS POR LEASING	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
188	1	4	20	13	1002	\N	\N	\N	\N	GASTOS BANCARIOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
189	1	4	20	13	1003	\N	\N	\N	\N	GASTOS POR PROTESTOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
190	1	4	20	13	2001	\N	\N	\N	\N	INTERESES BANCARIOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
191	1	4	20	14	0000	\N	\N	\N	\N	PARTICIPACION EN RESULTADO POR INVERSIONES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
192	1	4	20	15	0000	\N	\N	\N	\N	DIFERENCIA DE CAMBIO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
193	1	4	20	15	1001	\N	\N	\N	\N	DIFERENCIA DE CAMBIO	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
194	1	4	20	16	0000	\N	\N	\N	\N	RESULTADO POR UNIDADES DE REAJUSTES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
195	1	4	20	16	1001	\N	\N	\N	\N	REAJUSTES	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
196	1	4	20	17	0000	\N	\N	\N	\N	GASTOS POR IMPUESTO A LA RENTA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
197	1	4	20	17	1001	\N	\N	\N	\N	IMPUESTO A LA RENTA	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
198	1	5	00	00	0000	\N	\N	\N	\N	CUENTAS DE ORDEN Y TRASPASOS	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
199	2	1	00	00	0000	\N	\N	\N	\N	ACTIVOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
200	2	1	10	00	0000	\N	\N	\N	\N	ACTIVOS CORRIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
201	2	1	10	10	0000	\N	\N	\N	\N	EFECTIVO Y EQUIVALENTE AL EFECTIVO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
202	2	1	10	10	1001	\N	\N	\N	\N	CAJA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
203	2	1	10	10	1002	\N	\N	\N	\N	FONDO FIJO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
204	2	1	10	10	2001	\N	\N	\N	\N	BANCO SANTANDER	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
205	2	1	10	10	2002	\N	\N	\N	\N	BANCO DE CHILE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
206	2	1	10	10	2003	\N	\N	\N	\N	BANCO BBVA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
207	2	1	10	10	2004	\N	\N	\N	\N	BANCO BCI	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
208	2	1	10	10	2005	\N	\N	\N	\N	BANCO ITAU	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
209	2	1	10	10	2006	\N	\N	\N	\N	BANCO SECURITY	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
210	2	1	10	10	2007	\N	\N	\N	\N	BANCO SANTANDER DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
211	2	1	10	10	2008	\N	\N	\N	\N	BANCO DE CHILE DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
212	2	1	10	10	2009	\N	\N	\N	\N	BANCO BBVA DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
213	2	1	10	10	2010	\N	\N	\N	\N	BANCO BCI DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
214	2	1	10	10	2011	\N	\N	\N	\N	BANCO ITAU DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
215	2	1	10	10	2012	\N	\N	\N	\N	BANCO SECURITY DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
216	2	1	10	11	0000	\N	\N	\N	\N	OTROS ACTIVOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
217	2	1	10	11	0001	\N	\N	\N	\N	DEPOSITOS A PLAZO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
218	2	1	10	11	1002	\N	\N	\N	\N	FONDOS MUTUOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
219	2	1	10	11	1003	\N	\N	\N	\N	PACTOS RETROVENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
220	2	1	10	12	0000	\N	\N	\N	\N	OTROS ACTIVOS NO FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
221	2	1	10	13	0000	\N	\N	\N	\N	DEUDORES COMERCIALES Y OTRAS CUENTAS POR COBRAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
222	2	1	10	13	1001	\N	\N	\N	\N	CLIENTES NACIONALES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
223	2	1	10	13	1002	\N	\N	\N	\N	CLIENTES EXTRANJEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
224	2	1	10	13	1003	\N	\N	\N	\N	CHEQUES EN CARTERA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
225	2	1	10	13	1004	\N	\N	\N	\N	TARJETA DE DEBITO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
226	2	1	10	13	1005	\N	\N	\N	\N	TARJETA DE CREDITO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
227	2	1	10	13	1006	\N	\N	\N	\N	CHEQUES PROTESTADOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
228	2	1	10	13	1007	\N	\N	\N	\N	DOCUMENTOS PROTESTADOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
229	2	1	10	13	2001	\N	\N	\N	\N	ESTIMACION DEUDORES INCOBRABLES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
230	2	1	10	13	3001	\N	\N	\N	\N	FONDOS POR RENDIR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
231	2	1	10	13	4001	\N	\N	\N	\N	PRESTAMOS AL PERSONAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
232	2	1	10	13	5001	\N	\N	\N	\N	ANTICIPO DE SUELDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
233	2	1	10	13	5002	\N	\N	\N	\N	ANTICIPO DE HONORARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
234	2	1	10	13	5003	\N	\N	\N	\N	ANTICIPO A PROVEEDORES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
235	2	1	10	14	0000	\N	\N	\N	\N	CUENTAS POR COBRAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
236	2	1	10	14	1001	\N	\N	\N	\N	CUENTAS POR COBRAR EMPRESA RELACIONADA NACIONAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
237	2	1	10	14	1002	\N	\N	\N	\N	CUENTAS POR COBRAR EMPRESA RELACIONADA EXTRANJERA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
238	2	1	10	15	0000	\N	\N	\N	\N	INVENTARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
239	2	1	10	15	1001	\N	\N	\N	\N	EXISTENCIA EN TRANSITO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
240	2	1	10	15	1002	\N	\N	\N	\N	EXISTENCIAS EN PROCESO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
241	2	1	10	15	2001	\N	\N	\N	\N	EXISTENCIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
242	2	1	10	16	0000	\N	\N	\N	\N	ACTIVOS BIOLOGICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
243	2	1	10	17	0000	\N	\N	\N	\N	ACTIVOS POR IMPUESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
244	2	1	10	17	1001	\N	\N	\N	\N	PAGOS PROVISIONALES MENSUALES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
245	2	1	10	17	1002	\N	\N	\N	\N	IVA CREDITO FISCAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
246	2	1	10	17	2001	\N	\N	\N	\N	OTROS IMPUESTOS POR RECUPERAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
247	2	1	10	19	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA LA VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
248	2	1	10	19	1001	\N	\N	\N	\N	ACTIVOS DISPONIBLES MANTENIDOS PARA LA VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
249	2	1	10	20	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA DISTRIBUIR A PROPIETARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
250	2	1	10	21	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA LA VENTA O A DISTRIBUIR A LOS PROPIETARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
251	2	1	20	00	0000	\N	\N	\N	\N	ACTIVOS NO CORRIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
252	2	1	20	10	0000	\N	\N	\N	\N	OTROS ACTIVOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
253	2	1	20	10	1001	\N	\N	\N	\N	SEGUROS PAGADOS POR ANTICIPADO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
254	2	1	20	10	1002	\N	\N	\N	\N	ARRIENDOS PAGADOS POR ANTICIPADO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
255	2	1	20	10	1003	\N	\N	\N	\N	OTROS GASTOS PAGADOS POR ANTICIPADO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
256	2	1	20	10	1004	\N	\N	\N	\N	GARANTIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
257	2	1	20	10	2001	\N	\N	\N	\N	INTERESES DIFERIDOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
258	2	1	20	11	0000	\N	\N	\N	\N	OTROS ACTIVOS NO FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
259	2	1	20	12	0000	\N	\N	\N	\N	DERECHOS POR COBRAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
260	2	1	20	13	0000	\N	\N	\N	\N	CUENTAS POR COBRAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
261	2	1	20	14	0000	\N	\N	\N	\N	INVERSIONES POR METODO DE PARTICIPACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
262	2	1	20	15	0000	\N	\N	\N	\N	ACTIVOS INTANGIBLES DISTINTO A LA PLUSVALIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
263	2	1	20	16	0000	\N	\N	\N	\N	PLUSVALIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
264	2	1	20	17	0000	\N	\N	\N	\N	PROPIEDADES, PLANTAS Y EQUIPOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
265	2	1	20	17	1001	\N	\N	\N	\N	TERRENOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
266	2	1	20	17	2001	\N	\N	\N	\N	CONSTRUCCIONES E INTALACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
267	2	1	20	17	3001	\N	\N	\N	\N	MUEBLES E UTILES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
268	2	1	20	17	4001	\N	\N	\N	\N	VEHICULOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
269	2	1	20	17	5001	\N	\N	\N	\N	EQUIPOS COMPUTACIONALES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
270	2	1	20	17	6001	\N	\N	\N	\N	ACTIVOS EN LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
271	2	1	20	17	7001	\N	\N	\N	\N	PROGRAMAS Y SOFTWARES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
272	2	1	20	17	8001	\N	\N	\N	\N	DEPRECIACION ACUMULADA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
273	2	1	20	18	0000	\N	\N	\N	\N	ACTIVOS BIOLOGICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
274	2	1	20	19	0000	\N	\N	\N	\N	PROPIEDADES DE INVERSION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
275	2	1	20	20	0000	\N	\N	\N	\N	ACTIVOS POR IMPUESTO DIFERIDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
276	2	2	00	00	0000	\N	\N	\N	\N	PASIVOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
277	2	2	10	00	0000	\N	\N	\N	\N	PASIVOS CORRIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
278	2	2	10	10	0000	\N	\N	\N	\N	OTROS PASIVOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
279	2	2	10	10	1001	\N	\N	\N	\N	OBLIGACIONES CON BANCOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
280	2	2	10	10	1002	\N	\N	\N	\N	LINEAS DE CREDITO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
281	2	2	10	10	1003	\N	\N	\N	\N	OBLIGACIONES CON LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
282	2	2	10	11	0000	\N	\N	\N	\N	CUENTAS COMERCIALES Y OTRAS CUENTAS POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
283	2	2	10	11	1001	\N	\N	\N	\N	PROVEEDORES NACIONALES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
284	2	2	10	11	1002	\N	\N	\N	\N	PROVEEDORES EXTRANJEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
285	2	2	10	11	1003	\N	\N	\N	\N	CHEQUES POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
286	2	2	10	11	1004	\N	\N	\N	\N	HONORARIOS POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
287	2	2	10	11	1005	\N	\N	\N	\N	ANTICIPOS DE CLIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
288	2	2	10	12	0000	\N	\N	\N	\N	CUENTAS POR PAGAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
289	2	2	10	12	1001	\N	\N	\N	\N	CUENTAS POR PAGAR ENTIDAD RELACIONADA NACIONAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
290	2	2	10	12	1002	\N	\N	\N	\N	CUENTAS POR PAGAR ENTIDAD RELACIONADA EXTRANJERA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
291	2	2	10	13	0000	\N	\N	\N	\N	OTRAS PROVISIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
292	2	2	10	13	1001	\N	\N	\N	\N	PROVISIONES POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
293	2	2	10	13	2001	\N	\N	\N	\N	PROVISION DE VACACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
294	2	2	10	13	2002	\N	\N	\N	\N	PROVISIONES VARIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
295	2	2	10	14	0000	\N	\N	\N	\N	PASIVOS POR IMPUESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
296	2	2	10	14	1001	\N	\N	\N	\N	IVA DEBITO FISCAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
297	2	2	10	14	1002	\N	\N	\N	\N	IVA POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
298	2	2	10	14	1003	\N	\N	\N	\N	RETENCION 1RA CATEGORIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
299	2	2	10	14	1004	\N	\N	\N	\N	RETENCION 2DA CATEGORIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
300	2	2	10	14	1005	\N	\N	\N	\N	PPM POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
301	2	2	10	14	2001	\N	\N	\N	\N	PROVISION IMPUESTO A LA RENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
302	2	2	10	15	0000	\N	\N	\N	\N	PROVISIONES POR BENEFICIOS A EMPLEADOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
303	2	2	10	16	0000	\N	\N	\N	\N	OTROS PASIVOS NO FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
304	2	2	10	18	0000	\N	\N	\N	\N	PASIVOS CLASIFICADOS COMO MANTENIDOS PARA LA VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
305	2	2	20	00	0000	\N	\N	\N	\N	PASIVOS NO CORRIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
306	2	2	20	10	0000	\N	\N	\N	\N	OTROS PASIVOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
307	2	2	20	11	0000	\N	\N	\N	\N	OTRAS CUENTAS POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
308	2	2	20	12	0000	\N	\N	\N	\N	CUENTAS POR PAGAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
309	2	2	20	13	0000	\N	\N	\N	\N	OTRAS PROVISIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
310	2	2	20	14	0000	\N	\N	\N	\N	PASIVOS POR IMPUESTOS DIFERIDOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
311	2	2	20	15	0000	\N	\N	\N	\N	PROVISIONES POR BENEFICIOS A LOS EMPLEADOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
312	2	2	20	16	0000	\N	\N	\N	\N	OTROS PASIVOS NO FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
313	2	2	30	00	0000	\N	\N	\N	\N	PATRIMONIO  	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
314	2	2	30	10	0000	\N	\N	\N	\N	CAPITAL EMITIDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
315	2	2	30	10	0001	\N	\N	\N	\N	CAPITAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
316	2	2	30	11	0000	\N	\N	\N	\N	GANANCIAS (PERDIDAS) ACUMULADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
317	2	2	30	11	0001	\N	\N	\N	\N	RESULTADO ACUMULADO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
318	2	2	30	12	0000	\N	\N	\N	\N	PRIMAS DE EMISION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
319	2	2	30	13	0000	\N	\N	\N	\N	ACCIONES PROPIAS EN CARTERA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
320	2	2	30	14	0000	\N	\N	\N	\N	OTRAS PARTICIPACIONES EN EL PATRIMONIO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
321	2	2	30	15	0000	\N	\N	\N	\N	OTRAS RESERVAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
322	2	2	30	16	0000	\N	\N	\N	\N	PATRIMONIO ATRIBUIBLE A PROPIETARIOS DE LA CONTROLADORA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
323	2	2	30	17	0000	\N	\N	\N	\N	PARTICIPACIONES NO CONTROLADORAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
324	2	3	00	00	0000	\N	\N	\N	\N	RESULTADO GANANCIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
325	2	3	10	10	0000	\N	\N	\N	\N	INGRESOS DE ACTIVIDADES ORDINARIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
326	2	3	10	10	1001	\N	\N	\N	\N	VENTA DE GRUAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
327	2	3	10	10	1002	\N	\N	\N	\N	VENTA DE ACCESORIAS DE GRUAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
328	2	3	10	10	1003	\N	\N	\N	\N	VENTA DE PLATAFORMAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
329	2	3	10	10	1004	\N	\N	\N	\N	VENTA DE REPUESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
330	2	3	10	10	1005	\N	\N	\N	\N	VENTA DE SERVICIO TECNICO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
331	2	3	10	10	1006	\N	\N	\N	\N	VENTA DE LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
332	2	3	10	10	2001	\N	\N	\N	\N	ARRIENDOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
333	2	3	20	10	0000	\N	\N	\N	\N	OTROS INGRESOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
334	2	3	20	10	1001	\N	\N	\N	\N	GARANTIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
335	2	3	20	11	0000	\N	\N	\N	\N	OTRAS GANANCIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
336	2	3	20	12	0000	\N	\N	\N	\N	INGRESOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
337	2	4	00	00	0000	\N	\N	\N	\N	RESULTADO PERDIDA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
338	2	4	10	00	0000	\N	\N	\N	\N	COSTO DE VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
339	2	4	10	10	1001	\N	\N	\N	\N	COSTO DE GRUAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
340	2	4	10	10	1002	\N	\N	\N	\N	COSTO DE ACCESORIAS DE GRUAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
341	2	4	10	10	1003	\N	\N	\N	\N	COSTO DE PLATAFORMAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
342	2	4	10	10	1004	\N	\N	\N	\N	COSTO DE REPUESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
343	2	4	10	10	1005	\N	\N	\N	\N	COSTO DE SERVICIO TECNICO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
344	2	4	10	10	1006	\N	\N	\N	\N	COSTO DE LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
345	2	4	10	10	2001	\N	\N	\N	\N	COSTO DE ARRIENDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
346	2	4	20	10	0000	\N	\N	\N	\N	OTROS COSTOS DE EXPLOTACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
347	2	4	20	11	0000	\N	\N	\N	\N	GASTOS DE ADMINISTRACION Y VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
348	2	4	20	11	1001	\N	\N	\N	\N	REMUNERACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
349	2	4	20	11	1002	\N	\N	\N	\N	COMISIONES POR VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
350	2	4	20	11	1003	\N	\N	\N	\N	FINIQUITOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
351	2	4	20	11	2001	\N	\N	\N	\N	ASESORIA INFORMATICA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
352	2	4	20	11	2002	\N	\N	\N	\N	ASESORIA COMEX	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
353	2	4	20	11	2003	\N	\N	\N	\N	ASESORIA DE MARKETING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
354	2	4	20	11	2004	\N	\N	\N	\N	ASESORIA LEGAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
355	2	4	20	11	2005	\N	\N	\N	\N	ASESORIA CONTABLE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
356	2	4	20	11	2006	\N	\N	\N	\N	ASESORIA TECNICA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
357	2	4	20	11	3001	\N	\N	\N	\N	GASTOS DE PUBLICIDAD	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
358	2	4	20	11	3002	\N	\N	\N	\N	GASTOS DE REPRESENTACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
359	2	4	20	11	3003	\N	\N	\N	\N	VIAJES Y ESTADIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
360	2	4	20	11	3004	\N	\N	\N	\N	FERIAS Y STAND	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
361	2	4	20	11	4001	\N	\N	\N	\N	ARRIENDO DE OFICINAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
362	2	4	20	11	4002	\N	\N	\N	\N	COMBUSTIBLE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
363	2	4	20	11	4003	\N	\N	\N	\N	GASTOS DE OFICINA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
364	2	4	20	11	4004	\N	\N	\N	\N	MANTENCION DE VEHICULOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
365	2	4	20	11	4005	\N	\N	\N	\N	TELEFONOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
366	2	4	20	11	4006	\N	\N	\N	\N	AGUA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
367	2	4	20	11	4007	\N	\N	\N	\N	ELECTRICIDAD	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
368	2	4	20	11	4008	\N	\N	\N	\N	GASTOS DE IMPRENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
369	2	4	20	11	5001	\N	\N	\N	\N	SERVICIO DE ASEO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
370	2	4	20	11	5002	\N	\N	\N	\N	SERVICIO DE VIGILANCIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
371	2	4	20	11	6001	\N	\N	\N	\N	SEGUROS DE CHEQUES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
372	2	4	20	11	6002	\N	\N	\N	\N	SEGUROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
373	2	4	20	11	7001	\N	\N	\N	\N	COLACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
374	2	4	20	11	7002	\N	\N	\N	\N	CORRESPONDENCIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
375	2	4	20	11	7003	\N	\N	\N	\N	ALARMA DE SEGURIDAD	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
376	2	4	20	11	7004	\N	\N	\N	\N	TAG	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
377	2	4	20	11	7005	\N	\N	\N	\N	ROPA DE TRABAJO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
378	2	4	20	11	7006	\N	\N	\N	\N	GASTOS DE TV CABLE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
379	2	4	20	11	7007	\N	\N	\N	\N	GASTOS DE DICOM	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
380	2	4	20	11	7008	\N	\N	\N	\N	GASTOS DE DOMINIO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
381	2	4	20	11	7009	\N	\N	\N	\N	FLETES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
382	2	4	20	11	7010	\N	\N	\N	\N	GPS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
383	2	4	20	12	0000	\N	\N	\N	\N	OTROS GASTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
384	2	4	20	13	0000	\N	\N	\N	\N	COSTOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
385	2	4	20	13	1001	\N	\N	\N	\N	GASTOS POR LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
386	2	4	20	13	1002	\N	\N	\N	\N	GASTOS BANCARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
387	2	4	20	13	1003	\N	\N	\N	\N	GASTOS POR PROTESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
388	2	4	20	13	2001	\N	\N	\N	\N	INTERESES BANCARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
389	2	4	20	14	0000	\N	\N	\N	\N	PARTICIPACION EN RESULTADO POR INVERSIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
390	2	4	20	15	0000	\N	\N	\N	\N	DIFERENCIA DE CAMBIO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
391	2	4	20	15	1001	\N	\N	\N	\N	DIFERENCIA DE CAMBIO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
392	2	4	20	16	0000	\N	\N	\N	\N	RESULTADO POR UNIDADES DE REAJUSTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
393	2	4	20	16	1001	\N	\N	\N	\N	REAJUSTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
394	2	4	20	17	0000	\N	\N	\N	\N	GASTOS POR IMPUESTO A LA RENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
395	2	4	20	17	1001	\N	\N	\N	\N	IMPUESTO A LA RENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
396	2	5	00	00	0000	\N	\N	\N	\N	CUENTAS DE ORDEN Y TRASPASOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
397	3	1	00	00	0000	\N	\N	\N	\N	ACTIVOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
398	3	1	10	00	0000	\N	\N	\N	\N	ACTIVOS CORRIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
399	3	1	10	10	0000	\N	\N	\N	\N	EFECTIVO Y EQUIVALENTE AL EFECTIVO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
400	3	1	10	10	1001	\N	\N	\N	\N	CAJA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
401	3	1	10	10	1002	\N	\N	\N	\N	FONDO FIJO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
402	3	1	10	10	2001	\N	\N	\N	\N	BANCO SANTANDER	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
403	3	1	10	10	2002	\N	\N	\N	\N	BANCO DE CHILE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
404	3	1	10	10	2003	\N	\N	\N	\N	BANCO BBVA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
405	3	1	10	10	2004	\N	\N	\N	\N	BANCO BCI	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
406	3	1	10	10	2005	\N	\N	\N	\N	BANCO ITAU	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
407	3	1	10	10	2006	\N	\N	\N	\N	BANCO SECURITY	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
408	3	1	10	10	2007	\N	\N	\N	\N	BANCO SANTANDER DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
409	3	1	10	10	2008	\N	\N	\N	\N	BANCO DE CHILE DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
410	3	1	10	10	2009	\N	\N	\N	\N	BANCO BBVA DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
411	3	1	10	10	2010	\N	\N	\N	\N	BANCO BCI DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
412	3	1	10	10	2011	\N	\N	\N	\N	BANCO ITAU DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
413	3	1	10	10	2012	\N	\N	\N	\N	BANCO SECURITY DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
414	3	1	10	11	0000	\N	\N	\N	\N	OTROS ACTIVOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
415	3	1	10	11	0001	\N	\N	\N	\N	DEPOSITOS A PLAZO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
416	3	1	10	11	1002	\N	\N	\N	\N	FONDOS MUTUOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
417	3	1	10	11	1003	\N	\N	\N	\N	PACTOS RETROVENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
418	3	1	10	12	0000	\N	\N	\N	\N	OTROS ACTIVOS NO FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
419	3	1	10	13	0000	\N	\N	\N	\N	DEUDORES COMERCIALES Y OTRAS CUENTAS POR COBRAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
420	3	1	10	13	1001	\N	\N	\N	\N	CLIENTES NACIONALES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
421	3	1	10	13	1002	\N	\N	\N	\N	CLIENTES EXTRANJEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
422	3	1	10	13	1003	\N	\N	\N	\N	CHEQUES EN CARTERA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
423	3	1	10	13	1004	\N	\N	\N	\N	TARJETA DE DEBITO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
424	3	1	10	13	1005	\N	\N	\N	\N	TARJETA DE CREDITO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
425	3	1	10	13	1006	\N	\N	\N	\N	CHEQUES PROTESTADOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
426	3	1	10	13	1007	\N	\N	\N	\N	DOCUMENTOS PROTESTADOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
427	3	1	10	13	2001	\N	\N	\N	\N	ESTIMACION DEUDORES INCOBRABLES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
428	3	1	10	13	3001	\N	\N	\N	\N	FONDOS POR RENDIR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
429	3	1	10	13	4001	\N	\N	\N	\N	PRESTAMOS AL PERSONAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
430	3	1	10	13	5001	\N	\N	\N	\N	ANTICIPO DE SUELDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
431	3	1	10	13	5002	\N	\N	\N	\N	ANTICIPO DE HONORARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
432	3	1	10	13	5003	\N	\N	\N	\N	ANTICIPO A PROVEEDORES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
433	3	1	10	14	0000	\N	\N	\N	\N	CUENTAS POR COBRAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
434	3	1	10	14	1001	\N	\N	\N	\N	CUENTAS POR COBRAR EMPRESA RELACIONADA NACIONAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
435	3	1	10	14	1002	\N	\N	\N	\N	CUENTAS POR COBRAR EMPRESA RELACIONADA EXTRANJERA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
436	3	1	10	15	0000	\N	\N	\N	\N	INVENTARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
437	3	1	10	15	1001	\N	\N	\N	\N	EXISTENCIA EN TRANSITO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
438	3	1	10	15	1002	\N	\N	\N	\N	EXISTENCIAS EN PROCESO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
439	3	1	10	15	2001	\N	\N	\N	\N	EXISTENCIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
440	3	1	10	16	0000	\N	\N	\N	\N	ACTIVOS BIOLOGICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
441	3	1	10	17	0000	\N	\N	\N	\N	ACTIVOS POR IMPUESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
442	3	1	10	17	1001	\N	\N	\N	\N	PAGOS PROVISIONALES MENSUALES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
443	3	1	10	17	1002	\N	\N	\N	\N	IVA CREDITO FISCAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
444	3	1	10	17	2001	\N	\N	\N	\N	OTROS IMPUESTOS POR RECUPERAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
445	3	1	10	19	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA LA VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
446	3	1	10	19	1001	\N	\N	\N	\N	ACTIVOS DISPONIBLES MANTENIDOS PARA LA VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
447	3	1	10	20	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA DISTRIBUIR A PROPIETARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
448	3	1	10	21	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA LA VENTA O A DISTRIBUIR A LOS PROPIETARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
449	3	1	20	00	0000	\N	\N	\N	\N	ACTIVOS NO CORRIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
450	3	1	20	10	0000	\N	\N	\N	\N	OTROS ACTIVOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
451	3	1	20	10	1001	\N	\N	\N	\N	SEGUROS PAGADOS POR ANTICIPADO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
452	3	1	20	10	1002	\N	\N	\N	\N	ARRIENDOS PAGADOS POR ANTICIPADO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
453	3	1	20	10	1003	\N	\N	\N	\N	OTROS GASTOS PAGADOS POR ANTICIPADO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
454	3	1	20	10	1004	\N	\N	\N	\N	GARANTIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
455	3	1	20	10	2001	\N	\N	\N	\N	INTERESES DIFERIDOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
456	3	1	20	11	0000	\N	\N	\N	\N	OTROS ACTIVOS NO FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
457	3	1	20	12	0000	\N	\N	\N	\N	DERECHOS POR COBRAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
458	3	1	20	13	0000	\N	\N	\N	\N	CUENTAS POR COBRAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
459	3	1	20	14	0000	\N	\N	\N	\N	INVERSIONES POR METODO DE PARTICIPACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
460	3	1	20	15	0000	\N	\N	\N	\N	ACTIVOS INTANGIBLES DISTINTO A LA PLUSVALIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
461	3	1	20	16	0000	\N	\N	\N	\N	PLUSVALIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
462	3	1	20	17	0000	\N	\N	\N	\N	PROPIEDADES, PLANTAS Y EQUIPOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
463	3	1	20	17	1001	\N	\N	\N	\N	TERRENOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
464	3	1	20	17	2001	\N	\N	\N	\N	CONSTRUCCIONES E INTALACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
465	3	1	20	17	3001	\N	\N	\N	\N	MUEBLES E UTILES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
466	3	1	20	17	4001	\N	\N	\N	\N	VEHICULOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
467	3	1	20	17	5001	\N	\N	\N	\N	EQUIPOS COMPUTACIONALES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
468	3	1	20	17	6001	\N	\N	\N	\N	ACTIVOS EN LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
469	3	1	20	17	7001	\N	\N	\N	\N	PROGRAMAS Y SOFTWARES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
470	3	1	20	17	8001	\N	\N	\N	\N	DEPRECIACION ACUMULADA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
471	3	1	20	18	0000	\N	\N	\N	\N	ACTIVOS BIOLOGICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
472	3	1	20	19	0000	\N	\N	\N	\N	PROPIEDADES DE INVERSION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
473	3	1	20	20	0000	\N	\N	\N	\N	ACTIVOS POR IMPUESTO DIFERIDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
474	3	2	00	00	0000	\N	\N	\N	\N	PASIVOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
475	3	2	10	00	0000	\N	\N	\N	\N	PASIVOS CORRIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
476	3	2	10	10	0000	\N	\N	\N	\N	OTROS PASIVOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
477	3	2	10	10	1001	\N	\N	\N	\N	OBLIGACIONES CON BANCOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
478	3	2	10	10	1002	\N	\N	\N	\N	LINEAS DE CREDITO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
479	3	2	10	10	1003	\N	\N	\N	\N	OBLIGACIONES CON LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
480	3	2	10	11	0000	\N	\N	\N	\N	CUENTAS COMERCIALES Y OTRAS CUENTAS POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
481	3	2	10	11	1001	\N	\N	\N	\N	PROVEEDORES NACIONALES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
482	3	2	10	11	1002	\N	\N	\N	\N	PROVEEDORES EXTRANJEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
483	3	2	10	11	1003	\N	\N	\N	\N	CHEQUES POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
484	3	2	10	11	1004	\N	\N	\N	\N	HONORARIOS POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
485	3	2	10	11	1005	\N	\N	\N	\N	ANTICIPOS DE CLIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
486	3	2	10	12	0000	\N	\N	\N	\N	CUENTAS POR PAGAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
487	3	2	10	12	1001	\N	\N	\N	\N	CUENTAS POR PAGAR ENTIDAD RELACIONADA NACIONAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
488	3	2	10	12	1002	\N	\N	\N	\N	CUENTAS POR PAGAR ENTIDAD RELACIONADA EXTRANJERA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
489	3	2	10	13	0000	\N	\N	\N	\N	OTRAS PROVISIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
490	3	2	10	13	1001	\N	\N	\N	\N	PROVISIONES POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
491	3	2	10	13	2001	\N	\N	\N	\N	PROVISION DE VACACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
492	3	2	10	13	2002	\N	\N	\N	\N	PROVISIONES VARIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
493	3	2	10	14	0000	\N	\N	\N	\N	PASIVOS POR IMPUESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
494	3	2	10	14	1001	\N	\N	\N	\N	IVA DEBITO FISCAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
495	3	2	10	14	1002	\N	\N	\N	\N	IVA POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
496	3	2	10	14	1003	\N	\N	\N	\N	RETENCION 1RA CATEGORIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
497	3	2	10	14	1004	\N	\N	\N	\N	RETENCION 2DA CATEGORIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
498	3	2	10	14	1005	\N	\N	\N	\N	PPM POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
499	3	2	10	14	2001	\N	\N	\N	\N	PROVISION IMPUESTO A LA RENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
500	3	2	10	15	0000	\N	\N	\N	\N	PROVISIONES POR BENEFICIOS A EMPLEADOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
501	3	2	10	16	0000	\N	\N	\N	\N	OTROS PASIVOS NO FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
502	3	2	10	18	0000	\N	\N	\N	\N	PASIVOS CLASIFICADOS COMO MANTENIDOS PARA LA VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
503	3	2	20	00	0000	\N	\N	\N	\N	PASIVOS NO CORRIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
504	3	2	20	10	0000	\N	\N	\N	\N	OTROS PASIVOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
505	3	2	20	11	0000	\N	\N	\N	\N	OTRAS CUENTAS POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
506	3	2	20	12	0000	\N	\N	\N	\N	CUENTAS POR PAGAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
507	3	2	20	13	0000	\N	\N	\N	\N	OTRAS PROVISIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
508	3	2	20	14	0000	\N	\N	\N	\N	PASIVOS POR IMPUESTOS DIFERIDOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
509	3	2	20	15	0000	\N	\N	\N	\N	PROVISIONES POR BENEFICIOS A LOS EMPLEADOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
510	3	2	20	16	0000	\N	\N	\N	\N	OTROS PASIVOS NO FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
511	3	2	30	00	0000	\N	\N	\N	\N	PATRIMONIO  	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
512	3	2	30	10	0000	\N	\N	\N	\N	CAPITAL EMITIDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
513	3	2	30	10	0001	\N	\N	\N	\N	CAPITAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
514	3	2	30	11	0000	\N	\N	\N	\N	GANANCIAS (PERDIDAS) ACUMULADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
515	3	2	30	11	0001	\N	\N	\N	\N	RESULTADO ACUMULADO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
516	3	2	30	12	0000	\N	\N	\N	\N	PRIMAS DE EMISION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
517	3	2	30	13	0000	\N	\N	\N	\N	ACCIONES PROPIAS EN CARTERA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
518	3	2	30	14	0000	\N	\N	\N	\N	OTRAS PARTICIPACIONES EN EL PATRIMONIO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
519	3	2	30	15	0000	\N	\N	\N	\N	OTRAS RESERVAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
520	3	2	30	16	0000	\N	\N	\N	\N	PATRIMONIO ATRIBUIBLE A PROPIETARIOS DE LA CONTROLADORA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
521	3	2	30	17	0000	\N	\N	\N	\N	PARTICIPACIONES NO CONTROLADORAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
522	3	3	00	00	0000	\N	\N	\N	\N	RESULTADO GANANCIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
523	3	3	10	10	0000	\N	\N	\N	\N	INGRESOS DE ACTIVIDADES ORDINARIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
524	3	3	10	10	1001	\N	\N	\N	\N	VENTA DE GRUAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
525	3	3	10	10	1002	\N	\N	\N	\N	VENTA DE ACCESORIAS DE GRUAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
526	3	3	10	10	1003	\N	\N	\N	\N	VENTA DE PLATAFORMAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
527	3	3	10	10	1004	\N	\N	\N	\N	VENTA DE REPUESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
528	3	3	10	10	1005	\N	\N	\N	\N	VENTA DE SERVICIO TECNICO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
529	3	3	10	10	1006	\N	\N	\N	\N	VENTA DE LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
530	3	3	10	10	2001	\N	\N	\N	\N	ARRIENDOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
531	3	3	20	10	0000	\N	\N	\N	\N	OTROS INGRESOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
532	3	3	20	10	1001	\N	\N	\N	\N	GARANTIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
533	3	3	20	11	0000	\N	\N	\N	\N	OTRAS GANANCIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
534	3	3	20	12	0000	\N	\N	\N	\N	INGRESOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
535	3	4	00	00	0000	\N	\N	\N	\N	RESULTADO PERDIDA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
536	3	4	10	00	0000	\N	\N	\N	\N	COSTO DE VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
537	3	4	10	10	1001	\N	\N	\N	\N	COSTO DE GRUAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
538	3	4	10	10	1002	\N	\N	\N	\N	COSTO DE ACCESORIAS DE GRUAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
539	3	4	10	10	1003	\N	\N	\N	\N	COSTO DE PLATAFORMAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
540	3	4	10	10	1004	\N	\N	\N	\N	COSTO DE REPUESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
541	3	4	10	10	1005	\N	\N	\N	\N	COSTO DE SERVICIO TECNICO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
542	3	4	10	10	1006	\N	\N	\N	\N	COSTO DE LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
543	3	4	10	10	2001	\N	\N	\N	\N	COSTO DE ARRIENDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
544	3	4	20	10	0000	\N	\N	\N	\N	OTROS COSTOS DE EXPLOTACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
545	3	4	20	11	0000	\N	\N	\N	\N	GASTOS DE ADMINISTRACION Y VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
546	3	4	20	11	1001	\N	\N	\N	\N	REMUNERACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
547	3	4	20	11	1002	\N	\N	\N	\N	COMISIONES POR VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
548	3	4	20	11	1003	\N	\N	\N	\N	FINIQUITOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
549	3	4	20	11	2001	\N	\N	\N	\N	ASESORIA INFORMATICA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
550	3	4	20	11	2002	\N	\N	\N	\N	ASESORIA COMEX	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
551	3	4	20	11	2003	\N	\N	\N	\N	ASESORIA DE MARKETING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
552	3	4	20	11	2004	\N	\N	\N	\N	ASESORIA LEGAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
553	3	4	20	11	2005	\N	\N	\N	\N	ASESORIA CONTABLE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
554	3	4	20	11	2006	\N	\N	\N	\N	ASESORIA TECNICA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
555	3	4	20	11	3001	\N	\N	\N	\N	GASTOS DE PUBLICIDAD	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
556	3	4	20	11	3002	\N	\N	\N	\N	GASTOS DE REPRESENTACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
557	3	4	20	11	3003	\N	\N	\N	\N	VIAJES Y ESTADIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
558	3	4	20	11	3004	\N	\N	\N	\N	FERIAS Y STAND	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
559	3	4	20	11	4001	\N	\N	\N	\N	ARRIENDO DE OFICINAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
560	3	4	20	11	4002	\N	\N	\N	\N	COMBUSTIBLE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
561	3	4	20	11	4003	\N	\N	\N	\N	GASTOS DE OFICINA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
562	3	4	20	11	4004	\N	\N	\N	\N	MANTENCION DE VEHICULOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
563	3	4	20	11	4005	\N	\N	\N	\N	TELEFONOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
564	3	4	20	11	4006	\N	\N	\N	\N	AGUA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
565	3	4	20	11	4007	\N	\N	\N	\N	ELECTRICIDAD	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
566	3	4	20	11	4008	\N	\N	\N	\N	GASTOS DE IMPRENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
567	3	4	20	11	5001	\N	\N	\N	\N	SERVICIO DE ASEO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
568	3	4	20	11	5002	\N	\N	\N	\N	SERVICIO DE VIGILANCIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
569	3	4	20	11	6001	\N	\N	\N	\N	SEGUROS DE CHEQUES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
570	3	4	20	11	6002	\N	\N	\N	\N	SEGUROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
571	3	4	20	11	7001	\N	\N	\N	\N	COLACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
572	3	4	20	11	7002	\N	\N	\N	\N	CORRESPONDENCIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
573	3	4	20	11	7003	\N	\N	\N	\N	ALARMA DE SEGURIDAD	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
574	3	4	20	11	7004	\N	\N	\N	\N	TAG	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
575	3	4	20	11	7005	\N	\N	\N	\N	ROPA DE TRABAJO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
576	3	4	20	11	7006	\N	\N	\N	\N	GASTOS DE TV CABLE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
577	3	4	20	11	7007	\N	\N	\N	\N	GASTOS DE DICOM	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
578	3	4	20	11	7008	\N	\N	\N	\N	GASTOS DE DOMINIO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
579	3	4	20	11	7009	\N	\N	\N	\N	FLETES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
580	3	4	20	11	7010	\N	\N	\N	\N	GPS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
581	3	4	20	12	0000	\N	\N	\N	\N	OTROS GASTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
582	3	4	20	13	0000	\N	\N	\N	\N	COSTOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
583	3	4	20	13	1001	\N	\N	\N	\N	GASTOS POR LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
584	3	4	20	13	1002	\N	\N	\N	\N	GASTOS BANCARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
585	3	4	20	13	1003	\N	\N	\N	\N	GASTOS POR PROTESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
586	3	4	20	13	2001	\N	\N	\N	\N	INTERESES BANCARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
587	3	4	20	14	0000	\N	\N	\N	\N	PARTICIPACION EN RESULTADO POR INVERSIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
588	3	4	20	15	0000	\N	\N	\N	\N	DIFERENCIA DE CAMBIO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
589	3	4	20	15	1001	\N	\N	\N	\N	DIFERENCIA DE CAMBIO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
590	3	4	20	16	0000	\N	\N	\N	\N	RESULTADO POR UNIDADES DE REAJUSTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
591	3	4	20	16	1001	\N	\N	\N	\N	REAJUSTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
592	3	4	20	17	0000	\N	\N	\N	\N	GASTOS POR IMPUESTO A LA RENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
593	3	4	20	17	1001	\N	\N	\N	\N	IMPUESTO A LA RENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
594	3	5	00	00	0000	\N	\N	\N	\N	CUENTAS DE ORDEN Y TRASPASOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
595	4	1	00	00	0000	\N	\N	\N	\N	ACTIVOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
596	4	1	10	00	0000	\N	\N	\N	\N	ACTIVOS CORRIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
597	4	1	10	10	0000	\N	\N	\N	\N	EFECTIVO Y EQUIVALENTE AL EFECTIVO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
598	4	1	10	10	1001	\N	\N	\N	\N	CAJA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
599	4	1	10	10	1002	\N	\N	\N	\N	FONDO FIJO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
600	4	1	10	10	2001	\N	\N	\N	\N	BANCO SANTANDER	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
601	4	1	10	10	2002	\N	\N	\N	\N	BANCO DE CHILE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
602	4	1	10	10	2003	\N	\N	\N	\N	BANCO BBVA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
603	4	1	10	10	2004	\N	\N	\N	\N	BANCO BCI	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
604	4	1	10	10	2005	\N	\N	\N	\N	BANCO ITAU	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
605	4	1	10	10	2006	\N	\N	\N	\N	BANCO SECURITY	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
606	4	1	10	10	2007	\N	\N	\N	\N	BANCO SANTANDER DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
607	4	1	10	10	2008	\N	\N	\N	\N	BANCO DE CHILE DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
608	4	1	10	10	2009	\N	\N	\N	\N	BANCO BBVA DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
609	4	1	10	10	2010	\N	\N	\N	\N	BANCO BCI DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
610	4	1	10	10	2011	\N	\N	\N	\N	BANCO ITAU DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
611	4	1	10	10	2012	\N	\N	\N	\N	BANCO SECURITY DOLAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
612	4	1	10	11	0000	\N	\N	\N	\N	OTROS ACTIVOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
613	4	1	10	11	0001	\N	\N	\N	\N	DEPOSITOS A PLAZO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
614	4	1	10	11	1002	\N	\N	\N	\N	FONDOS MUTUOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
615	4	1	10	11	1003	\N	\N	\N	\N	PACTOS RETROVENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
616	4	1	10	12	0000	\N	\N	\N	\N	OTROS ACTIVOS NO FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
617	4	1	10	13	0000	\N	\N	\N	\N	DEUDORES COMERCIALES Y OTRAS CUENTAS POR COBRAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
618	4	1	10	13	1001	\N	\N	\N	\N	CLIENTES NACIONALES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
619	4	1	10	13	1002	\N	\N	\N	\N	CLIENTES EXTRANJEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
620	4	1	10	13	1003	\N	\N	\N	\N	CHEQUES EN CARTERA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
621	4	1	10	13	1004	\N	\N	\N	\N	TARJETA DE DEBITO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
622	4	1	10	13	1005	\N	\N	\N	\N	TARJETA DE CREDITO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
623	4	1	10	13	1006	\N	\N	\N	\N	CHEQUES PROTESTADOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
624	4	1	10	13	1007	\N	\N	\N	\N	DOCUMENTOS PROTESTADOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
625	4	1	10	13	2001	\N	\N	\N	\N	ESTIMACION DEUDORES INCOBRABLES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
626	4	1	10	13	3001	\N	\N	\N	\N	FONDOS POR RENDIR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
627	4	1	10	13	4001	\N	\N	\N	\N	PRESTAMOS AL PERSONAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
628	4	1	10	13	5001	\N	\N	\N	\N	ANTICIPO DE SUELDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
629	4	1	10	13	5002	\N	\N	\N	\N	ANTICIPO DE HONORARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
630	4	1	10	13	5003	\N	\N	\N	\N	ANTICIPO A PROVEEDORES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
631	4	1	10	14	0000	\N	\N	\N	\N	CUENTAS POR COBRAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
632	4	1	10	14	1001	\N	\N	\N	\N	CUENTAS POR COBRAR EMPRESA RELACIONADA NACIONAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
633	4	1	10	14	1002	\N	\N	\N	\N	CUENTAS POR COBRAR EMPRESA RELACIONADA EXTRANJERA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
634	4	1	10	15	0000	\N	\N	\N	\N	INVENTARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
635	4	1	10	15	1001	\N	\N	\N	\N	EXISTENCIA EN TRANSITO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
636	4	1	10	15	1002	\N	\N	\N	\N	EXISTENCIAS EN PROCESO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
637	4	1	10	15	2001	\N	\N	\N	\N	EXISTENCIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
638	4	1	10	16	0000	\N	\N	\N	\N	ACTIVOS BIOLOGICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
639	4	1	10	17	0000	\N	\N	\N	\N	ACTIVOS POR IMPUESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
640	4	1	10	17	1001	\N	\N	\N	\N	PAGOS PROVISIONALES MENSUALES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
641	4	1	10	17	1002	\N	\N	\N	\N	IVA CREDITO FISCAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
642	4	1	10	17	2001	\N	\N	\N	\N	OTROS IMPUESTOS POR RECUPERAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
643	4	1	10	19	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA LA VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
644	4	1	10	19	1001	\N	\N	\N	\N	ACTIVOS DISPONIBLES MANTENIDOS PARA LA VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
645	4	1	10	20	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA DISTRIBUIR A PROPIETARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
646	4	1	10	21	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA LA VENTA O A DISTRIBUIR A LOS PROPIETARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
647	4	1	20	00	0000	\N	\N	\N	\N	ACTIVOS NO CORRIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
648	4	1	20	10	0000	\N	\N	\N	\N	OTROS ACTIVOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
649	4	1	20	10	1001	\N	\N	\N	\N	SEGUROS PAGADOS POR ANTICIPADO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
650	4	1	20	10	1002	\N	\N	\N	\N	ARRIENDOS PAGADOS POR ANTICIPADO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
651	4	1	20	10	1003	\N	\N	\N	\N	OTROS GASTOS PAGADOS POR ANTICIPADO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
652	4	1	20	10	1004	\N	\N	\N	\N	GARANTIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
653	4	1	20	10	2001	\N	\N	\N	\N	INTERESES DIFERIDOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
654	4	1	20	11	0000	\N	\N	\N	\N	OTROS ACTIVOS NO FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
655	4	1	20	12	0000	\N	\N	\N	\N	DERECHOS POR COBRAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
656	4	1	20	13	0000	\N	\N	\N	\N	CUENTAS POR COBRAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
657	4	1	20	14	0000	\N	\N	\N	\N	INVERSIONES POR METODO DE PARTICIPACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
658	4	1	20	15	0000	\N	\N	\N	\N	ACTIVOS INTANGIBLES DISTINTO A LA PLUSVALIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
659	4	1	20	16	0000	\N	\N	\N	\N	PLUSVALIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
660	4	1	20	17	0000	\N	\N	\N	\N	PROPIEDADES, PLANTAS Y EQUIPOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
661	4	1	20	17	1001	\N	\N	\N	\N	TERRENOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
662	4	1	20	17	2001	\N	\N	\N	\N	CONSTRUCCIONES E INTALACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
663	4	1	20	17	3001	\N	\N	\N	\N	MUEBLES E UTILES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
664	4	1	20	17	4001	\N	\N	\N	\N	VEHICULOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
665	4	1	20	17	5001	\N	\N	\N	\N	EQUIPOS COMPUTACIONALES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
666	4	1	20	17	6001	\N	\N	\N	\N	ACTIVOS EN LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
667	4	1	20	17	7001	\N	\N	\N	\N	PROGRAMAS Y SOFTWARES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
668	4	1	20	17	8001	\N	\N	\N	\N	DEPRECIACION ACUMULADA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
669	4	1	20	18	0000	\N	\N	\N	\N	ACTIVOS BIOLOGICOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
670	4	1	20	19	0000	\N	\N	\N	\N	PROPIEDADES DE INVERSION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
671	4	1	20	20	0000	\N	\N	\N	\N	ACTIVOS POR IMPUESTO DIFERIDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
672	4	2	00	00	0000	\N	\N	\N	\N	PASIVOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
673	4	2	10	00	0000	\N	\N	\N	\N	PASIVOS CORRIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
674	4	2	10	10	0000	\N	\N	\N	\N	OTROS PASIVOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
675	4	2	10	10	1001	\N	\N	\N	\N	OBLIGACIONES CON BANCOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
676	4	2	10	10	1002	\N	\N	\N	\N	LINEAS DE CREDITO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
677	4	2	10	10	1003	\N	\N	\N	\N	OBLIGACIONES CON LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
678	4	2	10	11	0000	\N	\N	\N	\N	CUENTAS COMERCIALES Y OTRAS CUENTAS POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
679	4	2	10	11	1001	\N	\N	\N	\N	PROVEEDORES NACIONALES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
680	4	2	10	11	1002	\N	\N	\N	\N	PROVEEDORES EXTRANJEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
681	4	2	10	11	1003	\N	\N	\N	\N	CHEQUES POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
682	4	2	10	11	1004	\N	\N	\N	\N	HONORARIOS POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
683	4	2	10	11	1005	\N	\N	\N	\N	ANTICIPOS DE CLIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
684	4	2	10	12	0000	\N	\N	\N	\N	CUENTAS POR PAGAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
685	4	2	10	12	1001	\N	\N	\N	\N	CUENTAS POR PAGAR ENTIDAD RELACIONADA NACIONAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
686	4	2	10	12	1002	\N	\N	\N	\N	CUENTAS POR PAGAR ENTIDAD RELACIONADA EXTRANJERA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
687	4	2	10	13	0000	\N	\N	\N	\N	OTRAS PROVISIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
688	4	2	10	13	1001	\N	\N	\N	\N	PROVISIONES POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
689	4	2	10	13	2001	\N	\N	\N	\N	PROVISION DE VACACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
690	4	2	10	13	2002	\N	\N	\N	\N	PROVISIONES VARIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
691	4	2	10	14	0000	\N	\N	\N	\N	PASIVOS POR IMPUESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
692	4	2	10	14	1001	\N	\N	\N	\N	IVA DEBITO FISCAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
693	4	2	10	14	1002	\N	\N	\N	\N	IVA POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
694	4	2	10	14	1003	\N	\N	\N	\N	RETENCION 1RA CATEGORIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
695	4	2	10	14	1004	\N	\N	\N	\N	RETENCION 2DA CATEGORIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
696	4	2	10	14	1005	\N	\N	\N	\N	PPM POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
697	4	2	10	14	2001	\N	\N	\N	\N	PROVISION IMPUESTO A LA RENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
698	4	2	10	15	0000	\N	\N	\N	\N	PROVISIONES POR BENEFICIOS A EMPLEADOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
699	4	2	10	16	0000	\N	\N	\N	\N	OTROS PASIVOS NO FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
700	4	2	10	18	0000	\N	\N	\N	\N	PASIVOS CLASIFICADOS COMO MANTENIDOS PARA LA VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
701	4	2	20	00	0000	\N	\N	\N	\N	PASIVOS NO CORRIENTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
702	4	2	20	10	0000	\N	\N	\N	\N	OTROS PASIVOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
703	4	2	20	11	0000	\N	\N	\N	\N	OTRAS CUENTAS POR PAGAR	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
704	4	2	20	12	0000	\N	\N	\N	\N	CUENTAS POR PAGAR A ENTIDADES RELACIONADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
705	4	2	20	13	0000	\N	\N	\N	\N	OTRAS PROVISIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
706	4	2	20	14	0000	\N	\N	\N	\N	PASIVOS POR IMPUESTOS DIFERIDOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
707	4	2	20	15	0000	\N	\N	\N	\N	PROVISIONES POR BENEFICIOS A LOS EMPLEADOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
708	4	2	20	16	0000	\N	\N	\N	\N	OTROS PASIVOS NO FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
709	4	2	30	00	0000	\N	\N	\N	\N	PATRIMONIO  	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
710	4	2	30	10	0000	\N	\N	\N	\N	CAPITAL EMITIDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
711	4	2	30	10	0001	\N	\N	\N	\N	CAPITAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
712	4	2	30	11	0000	\N	\N	\N	\N	GANANCIAS (PERDIDAS) ACUMULADAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
713	4	2	30	11	0001	\N	\N	\N	\N	RESULTADO ACUMULADO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
714	4	2	30	12	0000	\N	\N	\N	\N	PRIMAS DE EMISION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
715	4	2	30	13	0000	\N	\N	\N	\N	ACCIONES PROPIAS EN CARTERA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
716	4	2	30	14	0000	\N	\N	\N	\N	OTRAS PARTICIPACIONES EN EL PATRIMONIO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
717	4	2	30	15	0000	\N	\N	\N	\N	OTRAS RESERVAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
718	4	2	30	16	0000	\N	\N	\N	\N	PATRIMONIO ATRIBUIBLE A PROPIETARIOS DE LA CONTROLADORA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
719	4	2	30	17	0000	\N	\N	\N	\N	PARTICIPACIONES NO CONTROLADORAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
720	4	3	00	00	0000	\N	\N	\N	\N	RESULTADO GANANCIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
721	4	3	10	10	0000	\N	\N	\N	\N	INGRESOS DE ACTIVIDADES ORDINARIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
722	4	3	10	10	1001	\N	\N	\N	\N	VENTA DE GRUAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
723	4	3	10	10	1002	\N	\N	\N	\N	VENTA DE ACCESORIAS DE GRUAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
724	4	3	10	10	1003	\N	\N	\N	\N	VENTA DE PLATAFORMAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
725	4	3	10	10	1004	\N	\N	\N	\N	VENTA DE REPUESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
726	4	3	10	10	1005	\N	\N	\N	\N	VENTA DE SERVICIO TECNICO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
727	4	3	10	10	1006	\N	\N	\N	\N	VENTA DE LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
728	4	3	10	10	2001	\N	\N	\N	\N	ARRIENDOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
729	4	3	20	10	0000	\N	\N	\N	\N	OTROS INGRESOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
730	4	3	20	10	1001	\N	\N	\N	\N	GARANTIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
731	4	3	20	11	0000	\N	\N	\N	\N	OTRAS GANANCIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
732	4	3	20	12	0000	\N	\N	\N	\N	INGRESOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
733	4	4	00	00	0000	\N	\N	\N	\N	RESULTADO PERDIDA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
734	4	4	10	00	0000	\N	\N	\N	\N	COSTO DE VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
735	4	4	10	10	1001	\N	\N	\N	\N	COSTO DE GRUAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
736	4	4	10	10	1002	\N	\N	\N	\N	COSTO DE ACCESORIAS DE GRUAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
737	4	4	10	10	1003	\N	\N	\N	\N	COSTO DE PLATAFORMAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
738	4	4	10	10	1004	\N	\N	\N	\N	COSTO DE REPUESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
739	4	4	10	10	1005	\N	\N	\N	\N	COSTO DE SERVICIO TECNICO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
740	4	4	10	10	1006	\N	\N	\N	\N	COSTO DE LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
741	4	4	10	10	2001	\N	\N	\N	\N	COSTO DE ARRIENDO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
742	4	4	20	10	0000	\N	\N	\N	\N	OTROS COSTOS DE EXPLOTACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
743	4	4	20	11	0000	\N	\N	\N	\N	GASTOS DE ADMINISTRACION Y VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
744	4	4	20	11	1001	\N	\N	\N	\N	REMUNERACIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
745	4	4	20	11	1002	\N	\N	\N	\N	COMISIONES POR VENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
746	4	4	20	11	1003	\N	\N	\N	\N	FINIQUITOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
747	4	4	20	11	2001	\N	\N	\N	\N	ASESORIA INFORMATICA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
748	4	4	20	11	2002	\N	\N	\N	\N	ASESORIA COMEX	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
749	4	4	20	11	2003	\N	\N	\N	\N	ASESORIA DE MARKETING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
750	4	4	20	11	2004	\N	\N	\N	\N	ASESORIA LEGAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
751	4	4	20	11	2005	\N	\N	\N	\N	ASESORIA CONTABLE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
752	4	4	20	11	2006	\N	\N	\N	\N	ASESORIA TECNICA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
753	4	4	20	11	3001	\N	\N	\N	\N	GASTOS DE PUBLICIDAD	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
754	4	4	20	11	3002	\N	\N	\N	\N	GASTOS DE REPRESENTACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
755	4	4	20	11	3003	\N	\N	\N	\N	VIAJES Y ESTADIAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
756	4	4	20	11	3004	\N	\N	\N	\N	FERIAS Y STAND	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
757	4	4	20	11	4001	\N	\N	\N	\N	ARRIENDO DE OFICINAS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
758	4	4	20	11	4002	\N	\N	\N	\N	COMBUSTIBLE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
759	4	4	20	11	4003	\N	\N	\N	\N	GASTOS DE OFICINA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
760	4	4	20	11	4004	\N	\N	\N	\N	MANTENCION DE VEHICULOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
761	4	4	20	11	4005	\N	\N	\N	\N	TELEFONOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
762	4	4	20	11	4006	\N	\N	\N	\N	AGUA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
763	4	4	20	11	4007	\N	\N	\N	\N	ELECTRICIDAD	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
764	4	4	20	11	4008	\N	\N	\N	\N	GASTOS DE IMPRENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
765	4	4	20	11	5001	\N	\N	\N	\N	SERVICIO DE ASEO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
766	4	4	20	11	5002	\N	\N	\N	\N	SERVICIO DE VIGILANCIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
767	4	4	20	11	6001	\N	\N	\N	\N	SEGUROS DE CHEQUES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
768	4	4	20	11	6002	\N	\N	\N	\N	SEGUROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
769	4	4	20	11	7001	\N	\N	\N	\N	COLACION	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
770	4	4	20	11	7002	\N	\N	\N	\N	CORRESPONDENCIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
771	4	4	20	11	7003	\N	\N	\N	\N	ALARMA DE SEGURIDAD	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
772	4	4	20	11	7004	\N	\N	\N	\N	TAG	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
773	4	4	20	11	7005	\N	\N	\N	\N	ROPA DE TRABAJO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
774	4	4	20	11	7006	\N	\N	\N	\N	GASTOS DE TV CABLE	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
775	4	4	20	11	7007	\N	\N	\N	\N	GASTOS DE DICOM	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
776	4	4	20	11	7008	\N	\N	\N	\N	GASTOS DE DOMINIO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
777	4	4	20	11	7009	\N	\N	\N	\N	FLETES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
778	4	4	20	11	7010	\N	\N	\N	\N	GPS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
779	4	4	20	12	0000	\N	\N	\N	\N	OTROS GASTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
780	4	4	20	13	0000	\N	\N	\N	\N	COSTOS FINANCIEROS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
781	4	4	20	13	1001	\N	\N	\N	\N	GASTOS POR LEASING	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
782	4	4	20	13	1002	\N	\N	\N	\N	GASTOS BANCARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
783	4	4	20	13	1003	\N	\N	\N	\N	GASTOS POR PROTESTOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
784	4	4	20	13	2001	\N	\N	\N	\N	INTERESES BANCARIOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
785	4	4	20	14	0000	\N	\N	\N	\N	PARTICIPACION EN RESULTADO POR INVERSIONES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
786	4	4	20	15	0000	\N	\N	\N	\N	DIFERENCIA DE CAMBIO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
787	4	4	20	15	1001	\N	\N	\N	\N	DIFERENCIA DE CAMBIO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
788	4	4	20	16	0000	\N	\N	\N	\N	RESULTADO POR UNIDADES DE REAJUSTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
789	4	4	20	16	1001	\N	\N	\N	\N	REAJUSTES	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
790	4	4	20	17	0000	\N	\N	\N	\N	GASTOS POR IMPUESTO A LA RENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
791	4	4	20	17	1001	\N	\N	\N	\N	IMPUESTO A LA RENTA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
792	4	5	00	00	0000	\N	\N	\N	\N	CUENTAS DE ORDEN Y TRASPASOS	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
793	6	1	00	00	0000	\N	\N	\N	\N	ACTIVOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
794	6	1	10	00	0000	\N	\N	\N	\N	ACTIVOS CORRIENTES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
795	6	1	10	10	0000	\N	\N	\N	\N	EFECTIVO Y EQUIVALENTE AL EFECTIVO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
796	6	1	10	10	1001	\N	\N	\N	\N	CAJA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
797	6	1	10	10	1002	\N	\N	\N	\N	FONDO FIJO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
798	6	1	10	10	2001	\N	\N	\N	\N	BANCO SANTANDER	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
799	6	1	10	10	2002	\N	\N	\N	\N	BANCO DE CHILE	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
800	6	1	10	10	2003	\N	\N	\N	\N	BANCO BBVA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
801	6	1	10	10	2004	\N	\N	\N	\N	BANCO BCI	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
802	6	1	10	10	2005	\N	\N	\N	\N	BANCO ITAU	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
803	6	1	10	10	2006	\N	\N	\N	\N	BANCO SECURITY	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
804	6	1	10	10	2007	\N	\N	\N	\N	BANCO SANTANDER DOLAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
805	6	1	10	10	2008	\N	\N	\N	\N	BANCO DE CHILE DOLAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
806	6	1	10	10	2009	\N	\N	\N	\N	BANCO BBVA DOLAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
807	6	1	10	10	2010	\N	\N	\N	\N	BANCO BCI DOLAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
808	6	1	10	10	2011	\N	\N	\N	\N	BANCO ITAU DOLAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
809	6	1	10	10	2012	\N	\N	\N	\N	BANCO SECURITY DOLAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
810	6	1	10	11	0000	\N	\N	\N	\N	OTROS ACTIVOS FINANCIEROS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
811	6	1	10	11	0001	\N	\N	\N	\N	DEPOSITOS A PLAZO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
812	6	1	10	11	1002	\N	\N	\N	\N	FONDOS MUTUOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
813	6	1	10	11	1003	\N	\N	\N	\N	PACTOS RETROVENTA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
814	6	1	10	12	0000	\N	\N	\N	\N	OTROS ACTIVOS NO FINANCIEROS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
815	6	1	10	13	0000	\N	\N	\N	\N	DEUDORES COMERCIALES Y OTRAS CUENTAS POR COBRAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
816	6	1	10	13	1001	\N	\N	\N	\N	CLIENTES NACIONALES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
817	6	1	10	13	1002	\N	\N	\N	\N	CLIENTES EXTRANJEROS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
818	6	1	10	13	1003	\N	\N	\N	\N	CHEQUES EN CARTERA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
819	6	1	10	13	1004	\N	\N	\N	\N	TARJETA DE DEBITO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
820	6	1	10	13	1005	\N	\N	\N	\N	TARJETA DE CREDITO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
821	6	1	10	13	1006	\N	\N	\N	\N	CHEQUES PROTESTADOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
822	6	1	10	13	1007	\N	\N	\N	\N	DOCUMENTOS PROTESTADOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
823	6	1	10	13	2001	\N	\N	\N	\N	ESTIMACION DEUDORES INCOBRABLES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
824	6	1	10	13	3001	\N	\N	\N	\N	FONDOS POR RENDIR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
825	6	1	10	13	4001	\N	\N	\N	\N	PRESTAMOS AL PERSONAL	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
826	6	1	10	13	5001	\N	\N	\N	\N	ANTICIPO DE SUELDO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
827	6	1	10	13	5002	\N	\N	\N	\N	ANTICIPO DE HONORARIOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
828	6	1	10	13	5003	\N	\N	\N	\N	ANTICIPO A PROVEEDORES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
829	6	1	10	14	0000	\N	\N	\N	\N	CUENTAS POR COBRAR A ENTIDADES RELACIONADAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
830	6	1	10	14	1001	\N	\N	\N	\N	CUENTAS POR COBRAR EMPRESA RELACIONADA NACIONAL	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
831	6	1	10	14	1002	\N	\N	\N	\N	CUENTAS POR COBRAR EMPRESA RELACIONADA EXTRANJERA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
832	6	1	10	15	0000	\N	\N	\N	\N	INVENTARIOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
833	6	1	10	15	1001	\N	\N	\N	\N	EXISTENCIA EN TRANSITO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
834	6	1	10	15	1002	\N	\N	\N	\N	EXISTENCIAS EN PROCESO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
835	6	1	10	15	2001	\N	\N	\N	\N	EXISTENCIAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
836	6	1	10	16	0000	\N	\N	\N	\N	ACTIVOS BIOLOGICOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
837	6	1	10	17	0000	\N	\N	\N	\N	ACTIVOS POR IMPUESTOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
838	6	1	10	17	1001	\N	\N	\N	\N	PAGOS PROVISIONALES MENSUALES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
839	6	1	10	17	1002	\N	\N	\N	\N	IVA CREDITO FISCAL	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
840	6	1	10	17	2001	\N	\N	\N	\N	OTROS IMPUESTOS POR RECUPERAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
841	6	1	10	19	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA LA VENTA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
842	6	1	10	19	1001	\N	\N	\N	\N	ACTIVOS DISPONIBLES MANTENIDOS PARA LA VENTA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
843	6	1	10	20	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA DISTRIBUIR A PROPIETARIOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
844	6	1	10	21	0000	\N	\N	\N	\N	ACTIVOS MANTENIDOS PARA LA VENTA O A DISTRIBUIR A LOS PROPIETARIOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
845	6	1	20	00	0000	\N	\N	\N	\N	ACTIVOS NO CORRIENTES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
846	6	1	20	10	0000	\N	\N	\N	\N	OTROS ACTIVOS FINANCIEROS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
847	6	1	20	10	1001	\N	\N	\N	\N	SEGUROS PAGADOS POR ANTICIPADO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
848	6	1	20	10	1002	\N	\N	\N	\N	ARRIENDOS PAGADOS POR ANTICIPADO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
849	6	1	20	10	1003	\N	\N	\N	\N	OTROS GASTOS PAGADOS POR ANTICIPADO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
850	6	1	20	10	1004	\N	\N	\N	\N	GARANTIAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
851	6	1	20	10	2001	\N	\N	\N	\N	INTERESES DIFERIDOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
852	6	1	20	11	0000	\N	\N	\N	\N	OTROS ACTIVOS NO FINANCIEROS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
853	6	1	20	12	0000	\N	\N	\N	\N	DERECHOS POR COBRAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
854	6	1	20	13	0000	\N	\N	\N	\N	CUENTAS POR COBRAR A ENTIDADES RELACIONADAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
855	6	1	20	14	0000	\N	\N	\N	\N	INVERSIONES POR METODO DE PARTICIPACION	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
856	6	1	20	15	0000	\N	\N	\N	\N	ACTIVOS INTANGIBLES DISTINTO A LA PLUSVALIA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
857	6	1	20	16	0000	\N	\N	\N	\N	PLUSVALIA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
858	6	1	20	17	0000	\N	\N	\N	\N	PROPIEDADES, PLANTAS Y EQUIPOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
859	6	1	20	17	1001	\N	\N	\N	\N	TERRENOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
860	6	1	20	17	2001	\N	\N	\N	\N	CONSTRUCCIONES E INTALACIONES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
861	6	1	20	17	3001	\N	\N	\N	\N	MUEBLES E UTILES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
862	6	1	20	17	4001	\N	\N	\N	\N	VEHICULOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
863	6	1	20	17	5001	\N	\N	\N	\N	EQUIPOS COMPUTACIONALES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
864	6	1	20	17	6001	\N	\N	\N	\N	ACTIVOS EN LEASING	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
865	6	1	20	17	7001	\N	\N	\N	\N	PROGRAMAS Y SOFTWARES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
866	6	1	20	17	8001	\N	\N	\N	\N	DEPRECIACION ACUMULADA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
867	6	1	20	18	0000	\N	\N	\N	\N	ACTIVOS BIOLOGICOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
868	6	1	20	19	0000	\N	\N	\N	\N	PROPIEDADES DE INVERSION	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
869	6	1	20	20	0000	\N	\N	\N	\N	ACTIVOS POR IMPUESTO DIFERIDO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
870	6	2	00	00	0000	\N	\N	\N	\N	PASIVOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
871	6	2	10	00	0000	\N	\N	\N	\N	PASIVOS CORRIENTES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
872	6	2	10	10	0000	\N	\N	\N	\N	OTROS PASIVOS FINANCIEROS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
873	6	2	10	10	1001	\N	\N	\N	\N	OBLIGACIONES CON BANCOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
874	6	2	10	10	1002	\N	\N	\N	\N	LINEAS DE CREDITO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
875	6	2	10	10	1003	\N	\N	\N	\N	OBLIGACIONES CON LEASING	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
876	6	2	10	11	0000	\N	\N	\N	\N	CUENTAS COMERCIALES Y OTRAS CUENTAS POR PAGAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
877	6	2	10	11	1001	\N	\N	\N	\N	PROVEEDORES NACIONALES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
878	6	2	10	11	1002	\N	\N	\N	\N	PROVEEDORES EXTRANJEROS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
879	6	2	10	11	1003	\N	\N	\N	\N	CHEQUES POR PAGAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
880	6	2	10	11	1004	\N	\N	\N	\N	HONORARIOS POR PAGAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
881	6	2	10	11	1005	\N	\N	\N	\N	ANTICIPOS DE CLIENTES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
882	6	2	10	12	0000	\N	\N	\N	\N	CUENTAS POR PAGAR A ENTIDADES RELACIONADAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
883	6	2	10	12	1001	\N	\N	\N	\N	CUENTAS POR PAGAR ENTIDAD RELACIONADA NACIONAL	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
884	6	2	10	12	1002	\N	\N	\N	\N	CUENTAS POR PAGAR ENTIDAD RELACIONADA EXTRANJERA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
885	6	2	10	13	0000	\N	\N	\N	\N	OTRAS PROVISIONES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
886	6	2	10	13	1001	\N	\N	\N	\N	PROVISIONES POR PAGAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
887	6	2	10	13	2001	\N	\N	\N	\N	PROVISION DE VACACIONES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
888	6	2	10	13	2002	\N	\N	\N	\N	PROVISIONES VARIAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
889	6	2	10	14	0000	\N	\N	\N	\N	PASIVOS POR IMPUESTOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
890	6	2	10	14	1001	\N	\N	\N	\N	IVA DEBITO FISCAL	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
891	6	2	10	14	1002	\N	\N	\N	\N	IVA POR PAGAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
892	6	2	10	14	1003	\N	\N	\N	\N	RETENCION 1RA CATEGORIA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
893	6	2	10	14	1004	\N	\N	\N	\N	RETENCION 2DA CATEGORIA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
894	6	2	10	14	1005	\N	\N	\N	\N	PPM POR PAGAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
895	6	2	10	14	2001	\N	\N	\N	\N	PROVISION IMPUESTO A LA RENTA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
896	6	2	10	15	0000	\N	\N	\N	\N	PROVISIONES POR BENEFICIOS A EMPLEADOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
897	6	2	10	16	0000	\N	\N	\N	\N	OTROS PASIVOS NO FINANCIEROS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
898	6	2	10	18	0000	\N	\N	\N	\N	PASIVOS CLASIFICADOS COMO MANTENIDOS PARA LA VENTA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
899	6	2	20	00	0000	\N	\N	\N	\N	PASIVOS NO CORRIENTES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
900	6	2	20	10	0000	\N	\N	\N	\N	OTROS PASIVOS FINANCIEROS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
901	6	2	20	11	0000	\N	\N	\N	\N	OTRAS CUENTAS POR PAGAR	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
902	6	2	20	12	0000	\N	\N	\N	\N	CUENTAS POR PAGAR A ENTIDADES RELACIONADAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
903	6	2	20	13	0000	\N	\N	\N	\N	OTRAS PROVISIONES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
904	6	2	20	14	0000	\N	\N	\N	\N	PASIVOS POR IMPUESTOS DIFERIDOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
905	6	2	20	15	0000	\N	\N	\N	\N	PROVISIONES POR BENEFICIOS A LOS EMPLEADOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
906	6	2	20	16	0000	\N	\N	\N	\N	OTROS PASIVOS NO FINANCIEROS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
907	6	2	30	00	0000	\N	\N	\N	\N	PATRIMONIO  	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
908	6	2	30	10	0000	\N	\N	\N	\N	CAPITAL EMITIDO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
909	6	2	30	10	0001	\N	\N	\N	\N	CAPITAL	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
910	6	2	30	11	0000	\N	\N	\N	\N	GANANCIAS (PERDIDAS) ACUMULADAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
911	6	2	30	11	0001	\N	\N	\N	\N	RESULTADO ACUMULADO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
912	6	2	30	12	0000	\N	\N	\N	\N	PRIMAS DE EMISION	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
913	6	2	30	13	0000	\N	\N	\N	\N	ACCIONES PROPIAS EN CARTERA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
914	6	2	30	14	0000	\N	\N	\N	\N	OTRAS PARTICIPACIONES EN EL PATRIMONIO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
915	6	2	30	15	0000	\N	\N	\N	\N	OTRAS RESERVAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
916	6	2	30	16	0000	\N	\N	\N	\N	PATRIMONIO ATRIBUIBLE A PROPIETARIOS DE LA CONTROLADORA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
917	6	2	30	17	0000	\N	\N	\N	\N	PARTICIPACIONES NO CONTROLADORAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
918	6	3	00	00	0000	\N	\N	\N	\N	RESULTADO GANANCIA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
919	6	3	10	10	0000	\N	\N	\N	\N	INGRESOS DE ACTIVIDADES ORDINARIAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
920	6	3	10	10	1001	\N	\N	\N	\N	VENTA DE GRUAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
921	6	3	10	10	1002	\N	\N	\N	\N	VENTA DE ACCESORIAS DE GRUAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
922	6	3	10	10	1003	\N	\N	\N	\N	VENTA DE PLATAFORMAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
923	6	3	10	10	1004	\N	\N	\N	\N	VENTA DE REPUESTOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
924	6	3	10	10	1005	\N	\N	\N	\N	VENTA DE SERVICIO TECNICO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
925	6	3	10	10	1006	\N	\N	\N	\N	VENTA DE LEASING	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
926	6	3	10	10	2001	\N	\N	\N	\N	ARRIENDOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
927	6	3	20	10	0000	\N	\N	\N	\N	OTROS INGRESOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
928	6	3	20	10	1001	\N	\N	\N	\N	GARANTIAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
929	6	3	20	11	0000	\N	\N	\N	\N	OTRAS GANANCIAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
930	6	3	20	12	0000	\N	\N	\N	\N	INGRESOS FINANCIEROS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
931	6	4	00	00	0000	\N	\N	\N	\N	RESULTADO PERDIDA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
932	6	4	10	00	0000	\N	\N	\N	\N	COSTO DE VENTA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
933	6	4	10	10	1001	\N	\N	\N	\N	COSTO DE GRUAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
934	6	4	10	10	1002	\N	\N	\N	\N	COSTO DE ACCESORIAS DE GRUAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
935	6	4	10	10	1003	\N	\N	\N	\N	COSTO DE PLATAFORMAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
936	6	4	10	10	1004	\N	\N	\N	\N	COSTO DE REPUESTOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
937	6	4	10	10	1005	\N	\N	\N	\N	COSTO DE SERVICIO TECNICO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
938	6	4	10	10	1006	\N	\N	\N	\N	COSTO DE LEASING	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
939	6	4	10	10	2001	\N	\N	\N	\N	COSTO DE ARRIENDO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
940	6	4	20	10	0000	\N	\N	\N	\N	OTROS COSTOS DE EXPLOTACION	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
941	6	4	20	11	0000	\N	\N	\N	\N	GASTOS DE ADMINISTRACION Y VENTA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
942	6	4	20	11	1001	\N	\N	\N	\N	REMUNERACIONES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
943	6	4	20	11	1002	\N	\N	\N	\N	COMISIONES POR VENTA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
944	6	4	20	11	1003	\N	\N	\N	\N	FINIQUITOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
945	6	4	20	11	2001	\N	\N	\N	\N	ASESORIA INFORMATICA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
946	6	4	20	11	2002	\N	\N	\N	\N	ASESORIA COMEX	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
947	6	4	20	11	2003	\N	\N	\N	\N	ASESORIA DE MARKETING	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
948	6	4	20	11	2004	\N	\N	\N	\N	ASESORIA LEGAL	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
949	6	4	20	11	2005	\N	\N	\N	\N	ASESORIA CONTABLE	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
950	6	4	20	11	2006	\N	\N	\N	\N	ASESORIA TECNICA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
951	6	4	20	11	3001	\N	\N	\N	\N	GASTOS DE PUBLICIDAD	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
952	6	4	20	11	3002	\N	\N	\N	\N	GASTOS DE REPRESENTACION	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
953	6	4	20	11	3003	\N	\N	\N	\N	VIAJES Y ESTADIAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
954	6	4	20	11	3004	\N	\N	\N	\N	FERIAS Y STAND	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
955	6	4	20	11	4001	\N	\N	\N	\N	ARRIENDO DE OFICINAS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
956	6	4	20	11	4002	\N	\N	\N	\N	COMBUSTIBLE	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
957	6	4	20	11	4003	\N	\N	\N	\N	GASTOS DE OFICINA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
958	6	4	20	11	4004	\N	\N	\N	\N	MANTENCION DE VEHICULOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
959	6	4	20	11	4005	\N	\N	\N	\N	TELEFONOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
960	6	4	20	11	4006	\N	\N	\N	\N	AGUA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
961	6	4	20	11	4007	\N	\N	\N	\N	ELECTRICIDAD	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
962	6	4	20	11	4008	\N	\N	\N	\N	GASTOS DE IMPRENTA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
963	6	4	20	11	5001	\N	\N	\N	\N	SERVICIO DE ASEO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
964	6	4	20	11	5002	\N	\N	\N	\N	SERVICIO DE VIGILANCIA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
965	6	4	20	11	6001	\N	\N	\N	\N	SEGUROS DE CHEQUES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
966	6	4	20	11	6002	\N	\N	\N	\N	SEGUROS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
967	6	4	20	11	7001	\N	\N	\N	\N	COLACION	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
968	6	4	20	11	7002	\N	\N	\N	\N	CORRESPONDENCIA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
969	6	4	20	11	7003	\N	\N	\N	\N	ALARMA DE SEGURIDAD	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
970	6	4	20	11	7004	\N	\N	\N	\N	TAG	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
971	6	4	20	11	7005	\N	\N	\N	\N	ROPA DE TRABAJO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
972	6	4	20	11	7006	\N	\N	\N	\N	GASTOS DE TV CABLE	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
973	6	4	20	11	7007	\N	\N	\N	\N	GASTOS DE DICOM	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
974	6	4	20	11	7008	\N	\N	\N	\N	GASTOS DE DOMINIO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
975	6	4	20	11	7009	\N	\N	\N	\N	FLETES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
976	6	4	20	11	7010	\N	\N	\N	\N	GPS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
977	6	4	20	12	0000	\N	\N	\N	\N	OTROS GASTOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
978	6	4	20	13	0000	\N	\N	\N	\N	COSTOS FINANCIEROS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
979	6	4	20	13	1001	\N	\N	\N	\N	GASTOS POR LEASING	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
980	6	4	20	13	1002	\N	\N	\N	\N	GASTOS BANCARIOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
981	6	4	20	13	1003	\N	\N	\N	\N	GASTOS POR PROTESTOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
982	6	4	20	13	2001	\N	\N	\N	\N	INTERESES BANCARIOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
983	6	4	20	14	0000	\N	\N	\N	\N	PARTICIPACION EN RESULTADO POR INVERSIONES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
984	6	4	20	15	0000	\N	\N	\N	\N	DIFERENCIA DE CAMBIO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
985	6	4	20	15	1001	\N	\N	\N	\N	DIFERENCIA DE CAMBIO	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
986	6	4	20	16	0000	\N	\N	\N	\N	RESULTADO POR UNIDADES DE REAJUSTES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
987	6	4	20	16	1001	\N	\N	\N	\N	REAJUSTES	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
988	6	4	20	17	0000	\N	\N	\N	\N	GASTOS POR IMPUESTO A LA RENTA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
989	6	4	20	17	1001	\N	\N	\N	\N	IMPUESTO A LA RENTA	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
990	6	5	00	00	0000	\N	\N	\N	\N	CUENTAS DE ORDEN Y TRASPASOS	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
\.


--
-- Name: plcu_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('plcu_seq', 990, true);


--
-- Name: posh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('posh_seq', 1, false);


--
-- Name: prod_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('prod_seq', 20, true);


--
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY productos (id, idempr, idtipr, idunmp, idorpr, nombre, valorunitario, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	1	4	9	1	COCA COLA RETORNABLE 1 LT	800	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
2	1	4	9	1	COCA COLA RETORNABLE 2 LT	1100	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
3	1	4	9	1	COCA COLA RETORNABLE 2.5 LT	1200	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
4	1	4	9	1	COCA COLA RETORNABLE 3 LT	1300	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
5	1	4	9	1	COCA COLA LIGHT RETORNABLE 1 LT	750	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
6	1	4	9	1	COCA COLA LIGHT RETORNABLE 2 LT	1050	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
7	1	4	9	1	COCA COLA LIGHT RETORNABLE 2.5 LT	1150	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
8	1	4	9	1	COCA COLA LIGHT RETORNABLE 3 LT	1250	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
9	1	4	9	1	COCA COLA ZERO RETORNABLE 1 LT	750	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
10	1	4	9	1	COCA COLA ZERO RETORNABLE 2 LT	1050	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
11	1	4	9	1	COCA COLA ZERO RETORNABLE 2.5 LT	1150	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
12	1	4	9	1	COCA COLA ZERO RETORNABLE 3 LT	1250	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
13	1	14	3	1	JAMÓN DE CERDO PF	5000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
14	1	14	3	1	JAMÓN DE CERDO AHUMADO PF	5500	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
15	1	14	3	1	JAMÓN DE CERDO ACARAMELADO PF	6000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
16	1	15	9	1	LIBRO DE RECETAS MASTER CHEF	5000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
17	1	5	9	1	PISCO CAPEL 35°	3000	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
18	2	7	3	2	FILETE DE PRIMERA ARGENTINO	3990	8	2017-12-25 19:58:36	8	2017-12-25 19:58:50	\N	\N
19	1	15	9	1	COCINANDO CON MÓNICA	10000	3	2017-12-25 20:17:04	\N	\N	\N	\N
20	1	3	8	2	ACEITE DE COCO MARCA ACME	15000	3	2017-12-25 20:18:54	\N	\N	\N	\N
\.


--
-- Name: prog_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('prog_seq', 11001, false);


--
-- Data for Name: programas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY programas (id, idprogpadre, titulo, link, etiqueta, peso) FROM stdin;
1000	\N	Personales	\N	Personales	1
1010	1000	Mantención datos personales	personas/datos-personales	Mantención datos personales	1
1020	1000	Cambio clave acceso	usuarios/cambio_contrasena	Cambio clave acceso	2
2000	\N	Adm. sistema	\N	Administracion sistema	2
2010	2000	Mantención grupos empresariales	grupos-empresariales	Mantención grupos empresariales	1
2020	2000	Mant. estados grupos empresariales	estados-grem	Mantención estados grupos empresariales	2
2030	2000	Mant. estados registros	estados-registros	Mantención estados registros	3
2040	2000	Mant. estados civiles	estados-civiles	Mantención estados civiles	4
2050	2000	Mant. estados solics. servs. hono.	principales/en-construccion	Mantención estados solics. servs. hono.	5
2060	2000	Mant. estados cotizacs. servs. hono.	principales/en-construccion	Mantención estados cotizacs. servs. hono.	6
2070	2000	Mant. estados órdenes servs. hono.	principales/en-construccion	Mantención estados órdenes servs. hono.	7
2080	2000	Mant. ests. pagos órds. servs. hono.	principales/en-construccion	Mantención ests. pagos órds. servs. hono.	8
2090	2000	Mant. estados cotizaciones vtas.	estados-cotizaciones-vtas	Mantención estados cotizaciones vtas.	9
2100	2000	Mant. estados notas vtas.	estados-notas-vtas	Mantención estados notas vtas.	10
2110	2000	Mant. impuestos	impuestos	Mantención impuestos	11
2120	2000	Mant. tipos formas pagos	tipos-formas-pagos	Mantención tipos formas pagos	12
2130	2000	Mant. tipos clientes	tipos-clientes	Mantención tipos clientes	13
2140	2000	Mant. tipos cotizaciones vtas.	tipos-cotizaciones-vtas	Mantención tipos cotizaciones vtas.	14
2150	2000	Mant. tipos productos	tipos-productos	Mantención tipos productos	15
2160	2000	Mant. tipos productos impuestos	tipos-productos-impuestos	Mantención tipos productos impuestos	16
2170	2000	Mant. tipos servicios	tipos-servicios	Mantención tipos servicios	17
2180	2000	Mant. unidades territoriales 1	unidades-territoriales-1	Mantención unidades territoriales 1	18
2190	2000	Mant. unidades territoriales 2	unidades-territoriales-2	Mantención unidades territoriales 2	19
2200	2000	Mant. unidades territoriales 3	unidades-territoriales-3	Mantención unidades territoriales 3	20
3000	\N	Adm. holding	\N	Administracion holding	3
3010	3000	Mantención empresas	empresas	Mantención empresas	1
3020	3000	Mantención personas	personas	Mantención personas	2
3030	3000	Mantención usuarios	mant-usuarios	Mantención usuarios	3
3040	3000	Mantención parámetros	parametros	Mantención parámetros	4
3050	3000	Mantención plan de cuentas	principales/en-construccion	Mantención plan de cuentas	5
3060	3000	Mantención rubros	rubros	Mantención rubros	6
3070	3000	Mantención tipos documentos legales	TiposDocumentosLegales	Mantención tipos documentos legales	7
3080	3000	Mantención estados documentos legales	estados-documentos-legales	Mantención estados documentos legales	8
3090	3000	Mantención clientes	clientes	Mantención rubros	9
4000	\N	Adm. empresa	\N	Administracion empresa	4
4010	4000	Mantención gerencias	gerencias	Mantención gerencias	1
4020	4000	Mantención proyectos	proyectos	Mantención proyectos	2
4030	4000	Mantención líneas de negocios	lineas-negocios	Mantención líneas de negocios	3
4040	4000	Mantención centros costos	centros-costos	Mantención centros costos	4
4050	4000	Mantención tareas	tareas	Mantención tareas	5
4060	4000	Mantención productos	productos	Mantención productos	6
4070	4000	Mantención servicios	servicios	Mantención servicios	7
5000	\N	Legales	\N	Legales	5
5010	5000	Documentos legales	DocumentosLegales	Documentos legales	1
5020	5000	Gráfica legales	DocumentosLegales/estadisticas	Gráfica legales	2
6000	\N	Honorarios	\N	Honorarios	6
6010	6000	Honorarios 1	principales/en-construccion	Honorarios 1	1
6020	6000	Honorarios 2	principales/en-construccion	Honorarios 2	2
6030	6000	Honorarios 3	principales/en-construccion	Honorarios 3	3
6040	6000	Honorarios 4	principales/en-construccion	Honorarios 4	4
6050	6000	Honorarios 5	principales/en-construccion	Honorarios 5	5
7000	\N	Rendiciones	\N	Rendiciones	7
7010	7000	Rendiciones 1	principales/en-construccion	Rendiciones 1	1
7020	7000	Rendiciones 2	principales/en-construccion	Rendiciones 2	2
7030	7000	Rendiciones 3	principales/en-construccion	Rendiciones 3	3
7040	7000	Rendiciones 4	principales/en-construccion	Rendiciones 4	4
7050	7000	Rendiciones 5	principales/en-construccion	Rendiciones 5	5
8000	\N	Compras	\N	Compras	8
8010	8000	Compras 1	principales/en-construccion	Compras 1	1
8020	8000	Compras 2	principales/en-construccion	Compras 2	2
8030	8000	Compras 3	principales/en-construccion	Compras 3	3
8040	8000	Compras 4	principales/en-construccion	Compras 4	4
8050	8000	Compras 5	principales/en-construccion	Compras 5	5
9000	\N	Ventas	\N	Ventas	9
9010	9000	Ventas 1	principales/en-construccion	Ventas 1	1
9020	9000	Ventas 2	principales/en-construccion	Ventas 2	2
9030	9000	Ventas 3	principales/en-construccion	Ventas 3	3
9040	9000	Ventas 4	principales/en-construccion	Ventas 4	4
9050	9000	Ventas 5	principales/en-construccion	Ventas 5	5
10000	\N	Contabilidad	\N	Contabilidad	10
10010	10000	Contabilidad 1	principales/en-construccion	Contabilidad 1	1
10020	10000	Contabilidad 2	principales/en-construccion	Contabilidad 2	2
10030	10000	Contabilidad 3	principales/en-construccion	Contabilidad 3	3
10040	10000	Contabilidad 4	principales/en-construccion	Contabilidad 4	4
10050	10000	Contabilidad 5	principales/en-construccion	Contabilidad 5	5
11000	\N	Cambiar emp./perf.	sel-perfil	Cambiar empresa/perfil	11
\.


--
-- Name: proy_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('proy_seq', 55, true);


--
-- Data for Name: proyectos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY proyectos (id, idempr, nombre, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	2	ALTO MAIPO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
2	2	GRAN SANTIAGO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
3	2	PARQUE INDUSTRIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
4	2	CARCEL CONCESIONADA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
5	2	FRUTICOLA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
6	2	METRO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
7	3	ALTO MAIPO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
8	3	GRAN SANTIAGO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
9	3	PARQUE INDUSTRIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
10	3	CARCEL CONCESIONADA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
11	3	FRUTICOLA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
12	3	METRO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
13	4	ALTO MAIPO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
14	4	GRAN SANTIAGO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
15	4	PARQUE INDUSTRIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
16	4	CARCEL CONCESIONADA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
17	4	FRUTICOLA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
18	4	METRO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
19	5	ALTO MAIPO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
20	5	GRAN SANTIAGO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
21	5	PARQUE INDUSTRIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
22	5	CARCEL CONCESIONADA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
23	5	FRUTICOLA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
24	5	METRO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
25	6	ALTO MAIPO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
26	6	GRAN SANTIAGO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
27	6	PARQUE INDUSTRIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
28	6	CARCEL CONCESIONADA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
29	6	FRUTICOLA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
30	6	METRO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
31	7	ALTO MAIPO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
32	7	GRAN SANTIAGO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
33	7	PARQUE INDUSTRIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
34	7	CARCEL CONCESIONADA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
35	7	FRUTICOLA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
36	7	METRO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
37	8	ALTO MAIPO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
38	8	GRAN SANTIAGO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
39	8	PARQUE INDUSTRIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
40	8	CARCEL CONCESIONADA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
41	8	FRUTICOLA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
42	8	METRO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
43	9	ALTO MAIPO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
44	9	GRAN SANTIAGO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
45	9	PARQUE INDUSTRIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
46	9	CARCEL CONCESIONADA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
47	9	FRUTICOLA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
48	9	METRO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
49	10	ALTO MAIPO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
50	10	GRAN SANTIAGO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
51	10	PARQUE INDUSTRIAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
52	10	CARCEL CONCESIONADA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
53	10	FRUTICOLA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
54	10	METRO	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
55	1	PROYECTO UNO	3	2017-12-25 13:35:47	\N	\N	\N	\N
\.


--
-- Name: rubr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('rubr_seq', 41, true);


--
-- Data for Name: rubros; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY rubros (id, idgrem, descripcion) FROM stdin;
1	1	CONSULTORÍA
2	1	AUTOMOTRIZ
3	1	INDUSTRIAL
4	1	INVERSIONES
5	1	AGRÍCOLA
6	1	FARMACÉUTICO
7	1	LOGÍSTICA
8	1	AMASANDERÍA
9	2	CONSULTORÍA
10	2	AUTOMOTRIZ
11	2	INDUSTRIAL
12	2	INVERSIONES
13	2	AGRÍCOLA
14	2	FARMACÉUTICO
15	2	LOGÍSTICA
16	2	AMASANDERÍA
18	3	CONSULTORÍA
19	3	AUTOMOTRIZ
20	3	INDUSTRIAL
21	3	INVERSIONES
22	3	AGRÍCOLA
23	3	FARMACÉUTICO
24	3	LOGÍSTICA
25	3	AMASANDERÍA
26	4	CONSULTORÍA
27	4	AUTOMOTRIZ
28	4	INDUSTRIAL
29	4	INVERSIONES
30	4	AGRÍCOLA
31	4	FARMACÉUTICO
32	4	LOGÍSTICA
33	4	AMASANDERÍA
34	6	CONSULTORÍA
35	6	AUTOMOTRIZ
36	6	INDUSTRIAL
37	6	INVERSIONES
38	6	AGRÍCOLA
39	6	FARMACÉUTICO
40	6	LOGÍSTICA
41	6	AMASANDERÍA
\.


--
-- Name: serv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('serv_seq', 11, true);


--
-- Data for Name: servicios; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY servicios (id, idempr, idtise, idunms, nombre, valorunitario, idmone, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	1	1	1	CONSULTOR JUNIOR	0.50	501	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
2	1	1	1	CONSULTOR SENIOR	1.00	501	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
3	1	1	1	JEFE DE PROYECTO	1.50	501	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
4	1	1	1	GERENTE DE PROYECTO	3.00	501	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
5	1	2	1	ASEO	5000.00	1	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
6	1	2	1	GUARDIA DE SEGURIDAD	10000.00	1	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
9	2	2	1	HORAS INGENIERIA DE SOFTWARE	45000.00	1	8	2017-12-25 21:45:04	\N	\N	\N	\N
10	2	1	2	VISITA CONSULTOR	450.00	5	8	2017-12-25 21:48:50	\N	\N	\N	\N
11	1	3	2	SERVICIO DE NANA A DOMICILIO TIEMPO STANDARD 5 HORAS	30000.00	1	3	2017-12-25 22:11:54	\N	\N	\N	\N
\.


--
-- Name: sexo_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('sexo_seq', 3, false);


--
-- Data for Name: sexos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY sexos (id, alias, descripcion) FROM stdin;
1	M	MASCULINO
2	F	FEMENINO
\.


--
-- Data for Name: solicitudes_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY solicitudes_servs_hono (id, idempr, correlativo, idpers, descripcionsolicserv, idgere, idproy, idline, idceco, idtare, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
\.


--
-- Name: sosh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('sosh_seq', 1, false);


--
-- Data for Name: tablas_secuencias; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY tablas_secuencias (tabla, secuencia) FROM stdin;
grupos_empresariales	grem_seq
empresas	empr_seq
parametros	para_seq
estados_grem	esge_seq
rubros	rubr_seq
estados_registros	esre_seq
valores_paises	vapa_seq
monedas	mone_seq
gerencias	gere_seq
proyectos	proy_seq
lineas_negocios	line_seq
centros_costos	ceco_seq
tareas	tare_seq
paises	pais_seq
personas	pers_seq
perfiles	perf_seq
estados_civiles	esci_seq
sexos	sexo_seq
programas	prog_seq
usuarios	usua_seq
usuarios_perfiles	uspe_seq
perfiles_programas	pepr_seq
planes_cuentas	plcu_seq
documentos_legales	dole_seq
tipos_documentos_legales	tidl_seq
estados_documentos_legales	esdl_seq
solicitudes_servs_hono	sosh_seq
estados_solics_servs_hono	essh_seq
cotizaciones_servs_hono	cosh_seq
doctos_cotizacs_servs_hono	dcsh_seq
estados_cotizacs_servs_hono	ecsh_seq
ordenes_servicios_hono	orsh_seq
doctos_ordenes_servs_hono	dosh_seq
estados_ordenes_servs_hono	eosh_seq
pagos_ordenes_servs_hono	posh_seq
estados_pagos_ords_servs_hono	epos_seq
tipos_formas_pagos	tifp_seq
unidades_territoriales_1	unt1_seq
unidades_territoriales_2	unt2_seq
unidades_territoriales_3	unt3_seq
tipos_clientes	ticl_seq
tipos_cotizaciones_vtas	ticv_seq
estados_cotizaciones_vtas	escv_seq
estados_notas_vtas	esnv_seq
estados_ventas	esve_seq
origenes_productos	orpr_seq
unidades_medidas_productos	unmp_seq
unidades_medidas_servicios	unms_seq
tipos_productos	tipr_seq
impuestos	impu_seq
tipos_productos_impuestos	tipi_seq
tipos_doctos_ventas	tidv_seq
tipos_servicios	tise_seq
clientes	clie_seq
documentos_ventas	dove_seq
detalles_doctos_vtas	dedv_seq
notas_ventas	nove_seq
detalles_notas_vtas	denv_seq
cotizaciones_ventas	cove_seq
detalles_cotizs_vtas	decv_seq
productos	prod_seq
servicios	serv_seq
dominios	domi_seq
valores_dominios	vado_seq
\.


--
-- Name: tare_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tare_seq', 37, true);


--
-- Data for Name: tareas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY tareas (id, idempr, nombre, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	2	TAREA PRINCIPAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
2	2	TAREA SECUNDARIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
3	2	OTRA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
4	2	ULTIMA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
5	3	TAREA PRINCIPAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
6	3	TAREA SECUNDARIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
7	3	OTRA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
8	3	ULTIMA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
9	4	TAREA PRINCIPAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
10	4	TAREA SECUNDARIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
11	4	OTRA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
12	4	ULTIMA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
13	5	TAREA PRINCIPAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
14	5	TAREA SECUNDARIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
15	5	OTRA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
16	5	ULTIMA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
17	6	TAREA PRINCIPAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
18	6	TAREA SECUNDARIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
19	6	OTRA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
20	6	ULTIMA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
21	7	TAREA PRINCIPAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
22	7	TAREA SECUNDARIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
23	7	OTRA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
24	7	ULTIMA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
25	8	TAREA PRINCIPAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
26	8	TAREA SECUNDARIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
27	8	OTRA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
28	8	ULTIMA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
29	9	TAREA PRINCIPAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
30	9	TAREA SECUNDARIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
31	9	OTRA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
32	9	ULTIMA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
33	10	TAREA PRINCIPAL	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
34	10	TAREA SECUNDARIA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
35	10	OTRA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
36	10	ULTIMA TAREA	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
37	1	PRUEBA CPALMA TAREA	3	2017-12-25 13:39:48	\N	\N	\N	\N
\.


--
-- Name: ticl_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('ticl_seq', 3, true);


--
-- Name: ticv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('ticv_seq', 3, true);


--
-- Name: tidl_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tidl_seq', 20, true);


--
-- Name: tidv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tidv_seq', 4, false);


--
-- Name: tifp_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tifp_seq', 7, true);


--
-- Name: tipi_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tipi_seq', 3, true);


--
-- Data for Name: tipos_clientes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY tipos_clientes (id, descripcion) FROM stdin;
1	PERSONA NATURAL
2	EMPRESA
3	OTRO
\.


--
-- Data for Name: tipos_cotizaciones_vtas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY tipos_cotizaciones_vtas (id, descripcion) FROM stdin;
1	PRESUPUESTO
2	PROSPECTO
3	PRUEBA CPALMA
\.


--
-- Data for Name: tipos_doctos_ventas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY tipos_doctos_ventas (id, idpais, descripcion, descripcioncorta, codigooficial) FROM stdin;
1	1	FACTURA ELECTRÓNICA	FAEA	33
2	1	NOTA DE CRÉDITO ELECTRÓNICA	NCEL	61
3	1	GUÍA DE DESPACHO ELECTRÓNICA	GDEL	52
\.


--
-- Data for Name: tipos_documentos_legales; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY tipos_documentos_legales (id, idgrem, descripcion, descripcioncorta, color, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	1	CONSTITUCIÓN DE SOCIEDAD	CONST. SOC.	#FF0000	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
2	1	ACTA DE DIRECTORIO	ACTA DIR.	#00FF00	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
3	1	SESIÓN DE DIRECTORIO	SES. DIR.	#0000FF	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
4	1	CONTRATO DE ARRIENDO	CONT. ARR.	#FFFFFF	1	2017-12-24 10:47:53.902783	\N	\N	\N	\N
5	2	CONSTITUCIÓN DE SOCIEDAD	CONST. SOC.	#FF0000	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
6	2	ACTA DE DIRECTORIO	ACTA DIR.	#00FF00	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
7	2	SESIÓN DE DIRECTORIO	SES. DIR.	#0000FF	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
8	2	CONTRATO DE ARRIENDO	CONT. ARR.	#FFFFFF	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
9	3	CONSTITUCIÓN DE SOCIEDAD	CONST. SOC.	#FF0000	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
10	3	ACTA DE DIRECTORIO	ACTA DIR.	#00FF00	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
11	3	SESIÓN DE DIRECTORIO	SES. DIR.	#0000FF	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
12	3	CONTRATO DE ARRIENDO	CONT. ARR.	#FFFFFF	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
13	4	CONSTITUCIÓN DE SOCIEDAD	CONST. SOC.	#FF0000	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
14	4	ACTA DE DIRECTORIO	ACTA DIR.	#00FF00	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
15	4	SESIÓN DE DIRECTORIO	SES. DIR.	#0000FF	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
16	4	CONTRATO DE ARRIENDO	CONT. ARR.	#FFFFFF	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
17	6	CONSTITUCIÓN DE SOCIEDAD	CONST. SOC.	#FF0000	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
18	6	ACTA DE DIRECTORIO	ACTA DIR.	#00FF00	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
19	6	SESIÓN DE DIRECTORIO	SES. DIR.	#0000FF	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
20	6	CONTRATO DE ARRIENDO	CONT. ARR.	#FFFFFF	1	2017-12-25 13:02:25.135179	\N	\N	\N	\N
\.


--
-- Data for Name: tipos_formas_pagos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY tipos_formas_pagos (id, descripcion) FROM stdin;
1	EFECTIVO
2	TARJETA CRÉDITO
3	TARJETA DÉBITO
4	CHEQUE
5	LETRA
6	VALE VISTA
7	PRUEBA CPALMA
\.


--
-- Data for Name: tipos_productos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY tipos_productos (id, descripcion, estaexento) FROM stdin;
1	ARTICULOS DE ASEO	N
2	ARTICULOS DE ESCRITORIO	N
3	ARTICULOS DE PERFUMERÍA	N
4	BEBIDAS GASEOSAS	N
5	BABIDAS ALCOHÓLICAS	N
6	CIGARRILLOS	N
7	CARNE	N
8	PETRÓLEO	N
9	BENCINA	N
10	PARAFINA	N
11	ALIMENTOS NO PERECIBLES	N
12	ALIMENTOS PERECIBLES FRUTAS	N
13	ALIMENTOS PERECIBLES VERDURAS	N
14	ALIMENTOS PERECIBLES OTROS	N
15	LIBROS	S
22	JUGUETES PARA ADULTOS	N
21	JUGUETES PARA NIÑOS	S
\.


--
-- Data for Name: tipos_productos_impuestos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY tipos_productos_impuestos (id, idtipr, idimpu) FROM stdin;
1	4	3
2	5	2
3	10	2
\.


--
-- Data for Name: tipos_servicios; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY tipos_servicios (id, descripcion, estaexento) FROM stdin;
1	SERVICIOS PROFESIONALES	S
2	SERVICIOS NO PROFESIONALES	N
3	SERVICIOS INTERMEDIOS	N
\.


--
-- Name: tipr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tipr_seq', 22, true);


--
-- Name: tise_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tise_seq', 3, true);


--
-- Data for Name: unidades_medidas_productos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY unidades_medidas_productos (id, descripcion, descripcioncorta) FROM stdin;
1	MILÍGRAMOS	MG
2	GRAMOS	GR
3	KILÓGRAMOS	KG
4	MILÍMETROS	MM
5	CENTÍMETROS	CM
6	METROS	MT
7	MILÍLITROS	ML
8	LITROS	LT
9	UNIDADES	UN
10	TONELADAS	TN
\.


--
-- Data for Name: unidades_medidas_servicios; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY unidades_medidas_servicios (id, descripcion, descripcioncorta) FROM stdin;
1	HORAS HOMBRE	HH
2	VISITA TERRENO	VT
\.


--
-- Data for Name: unidades_territoriales_1; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY unidades_territoriales_1 (id, idpais, nombre) FROM stdin;
1	1	REGIÓN DE TARAPACÁ
2	1	REGIÓN DE ANTOFAGASTA
3	1	REGIÓN DE ATACAMA
4	1	REGIÓN DE COQUIMBO
5	1	REGIÓN DE VALPARAÍSO
6	1	REGIÓN DEL LIBERTADOR GENERAL BERNARDO O'HIGGINS
7	1	REGIÓN DEL MAULE
8	1	REGIÓN DEL BIOBÍO
9	1	REGIÓN DE LA ARAUCANÍA
10	1	REGIÓN DE LOS LAGOS
11	1	REGIÓN DE AISÉN DEL GENERAL CARLOS IBAÑEZ DEL CAMPO
12	1	REGIÓN DE MAGALLANES Y DE LA ANTÁRTICA CHILENA
13	1	REGIÓN METROPOLITANA DE SANTIAGO
14	1	REGIÓN DE LOS RÍOS
15	1	REGIÓN DE ARICA Y PARINACOTA
16	1	REGIÓN DEL ÑUBLE
\.


--
-- Data for Name: unidades_territoriales_2; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY unidades_territoriales_2 (id, idunt1, nombre) FROM stdin;
1	1	IQUIQUE
2	1	TAMARUGAL
3	2	TOCOPILLA
4	2	EL LOA
5	2	ANTOFAGASTA
6	3	CHAÑARAL
7	3	COPIAPÓ
8	3	HUASCO
9	4	ELQUI
10	4	LIMARI
11	4	CHOAPA
12	5	PETORCA
13	5	SAN FELIPE DE ACONCAGUA
14	5	QUILLOTA
15	5	LOS ANDES
16	5	VALPARAISO
17	5	SAN ANTONIO
18	5	ISLA DE PASCUA
19	6	CACHAPOAL
20	6	CARDENAL CARO
21	6	COLCHAGUA
22	7	CURICÓ
23	7	TALCA
24	7	CAUQUENES
25	7	LINARES
26	8	ÑUBLE
27	8	CONCEPCIÓN
28	8	BIOBÍO
29	8	ARAUCO
30	9	MALLECO
31	9	CAUTIN
32	10	OSORNO
33	10	LLANQUIHUE
34	10	CHILOE
35	10	PALENA
36	11	AISÉN
37	11	COYHAIQUE
38	11	GENERAL CARRERA
39	11	CAPITAN PRAT
40	12	ULTIMA ESPERANZA
41	12	MAGALLANES
42	12	TIERRA DEL FUEGO
43	12	ANTARTICA CHILENA
44	13	SANTIAGO
45	13	CHACABUCO
46	13	MELIPILLA
47	13	TALAGANTE
48	13	MAIPO
49	13	CORDILLERA
50	14	VALDIVIA
51	14	RANCO
52	15	PARINACOTA
53	15	ARICA
54	16	ITATA
55	16	DIGUILLIN
56	16	PUNILLA
\.


--
-- Data for Name: unidades_territoriales_3; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY unidades_territoriales_3 (id, idunt2, nombre) FROM stdin;
1	1	IQUIQUE
2	1	ALTO HOSPICIO
3	2	HUARA
4	2	CAMIÑA
5	2	COLCHANE
6	2	POZO ALMONTE
7	2	PICA
8	3	TOCOPILLA
9	3	MARIA ELENA
10	4	CALAMA
11	4	OLLAGÜE
12	4	SAN PEDRO DE ATACAMA
13	5	MEJILLONES
14	5	SIERRA GORDA
15	5	ANTOFAGASTA
16	5	TALTAL
17	6	CHAÑARAL
18	6	DIEGO DE ALMAGRO
19	7	CALDERA
20	7	COPIAPÓ
21	7	TIERRA AMARILLA
22	8	HUASCO
23	8	VALLENAR
24	8	FREIRINA
25	8	ALTO DEL CARMEN
26	9	LA HIGUERA
27	9	VICUÑA
28	9	LA SERENA
29	9	COQUIMBO
30	9	ANDACOLLO
31	9	PAIHUANO
32	10	OVALLE
33	10	RIO HURTADO
34	10	PUNITAQUI
35	10	MONTE PATRIA
36	10	COMBARBALÁ
37	11	CANELA
38	11	ILLAPEL
39	11	LOS VILOS
40	11	SALAMANCA
41	12	PETORCA
42	12	LA LIGUA
43	12	CABILDO
44	12	PAPUDO
45	12	ZAPALLAR
46	13	PUTAENDO
47	13	CATEMU
48	13	SAN FELIPE
49	13	SANTA MARIA
50	13	PANQUEHUE
51	13	LLAILLAY
52	14	NOGALES
53	14	LA CALERA
54	14	LA CRUZ
55	14	QUILLOTA
56	14	HIJUELAS
57	14	LIMACHE
58	14	OLMUE
59	15	SAN ESTEBAN
60	15	RINCONADA
61	15	CALLE LARGA
62	15	LOS ANDES
63	16	PUCHUNCAVI
64	16	JUAN FERNANDEZ
65	16	QUINTERO
66	16	VINA DEL MAR
67	16	VILLA ALEMANA
68	16	VALPARAISO
69	16	QUILPUE
70	16	CASABLANCA
71	16	CONCÓN
72	17	ALGARROBO
73	17	EL QUISCO
74	17	EL TABO
75	17	CARTAGENA
76	17	SAN ANTONIO
77	17	SANTO DOMINGO
78	18	ISLA DE PASCUA
79	19	MOSTAZAL
80	19	GRANEROS
81	19	CODEGUA
82	19	RANCAGUA
83	19	MACHALI
84	19	LAS CABRAS
85	19	COLTAUCO
86	19	DONIHUE
87	19	OLIVAR
88	19	COINCO
89	19	REQUINOA
90	19	PEUMO
91	19	QUINTA DE TILCOCO
92	19	PICHIDEGUA
93	19	SAN VICENTE
94	19	MALLOA
95	19	RENGO
96	20	NAVIDAD
97	20	LITUECHE
98	20	LA ESTRELLA
99	20	PICHILEMU
100	20	MARCHIHUE
101	20	PAREDONES
102	21	PERALILLO
103	21	PALMILLA
104	21	SAN FERNANDO
105	21	PUMANQUE
106	21	SANTA CRUZ
107	21	NANCAGUA
108	21	PLACILLA
109	21	LOLOL
110	21	CHEPICA
111	21	CHIMBARONGO
112	22	TENO
113	22	VICHUQUÉN
114	22	HUALAÑE
115	22	RAUCO
116	22	CURICÓ
117	22	ROMERAL
118	22	LICANTÉN
119	22	SAGRADA FAMILIA
120	22	MOLINA
121	23	CUREPTO
122	23	RIO CLARO
123	23	CONSTITUCIÓN
124	23	PENCAHUE
125	23	TALCA
126	23	PELARCO
127	23	SAN CLEMENTE
128	23	MAULE
129	23	EMPEDRADO
130	23	SAN RAFAEL
131	24	CHANCO
132	24	CAUQUENES
133	24	PELLUHUE
134	25	SAN JAVIER
135	25	VILLA ALEGRE
136	25	YERBAS BUENAS
137	25	COLBUN
138	25	LINARES
139	25	RETIRO
140	25	LONGAVI
141	25	PARRAL
163	27	TOME
164	27	FLORIDA
165	27	TALCAHUANO
166	27	HUALPÉN
167	27	PENCO
168	27	CONCEPCIÓN
169	27	SAN PEDRO DE LA PAZ
170	27	CHIGUAYANTE
171	27	HUALQUI
172	27	CORONEL
173	27	LOTA
174	27	SANTA JUANA
175	27	YUMBEL
176	28	CABRERO
177	28	TUCAPEL
178	28	ANTUCO
179	28	SAN ROSENDO
180	28	LAJA
181	28	LOS ANGELES
182	28	QUILLECO
183	28	SANTA BÁRBARA
184	28	ALTO BIOBÍO
185	28	NACIMIENTO
186	28	NEGRETE
187	28	QUILACO
188	28	MULCHÉN
189	29	ARAUCO
190	29	CURANILAHUE
191	29	LEBU
192	29	LOS ALAMOS
193	29	CAÑETE
194	29	CONTULMO
195	29	TIRUA
196	30	ANGOL
197	30	RENAICO
198	30	COLLIPULLI
199	30	PURÉN
200	30	LOS SAUCES
201	30	ERCILLA
202	30	LONQUIMAY
203	30	LUMACO
204	30	TRAIGUÉN
205	30	VICTORIA
206	30	CURACAUTIN
207	31	GALVARINO
208	31	PERQUENCO
209	31	CARAHUE
210	31	NUEVA IMPERIAL
211	31	CHOLCHOL
212	31	TEMUCO
213	31	PADRE LAS CASAS
214	31	LAUTARO
215	31	VILCUN
216	31	MELIPEUCO
217	31	SAAVEDRA
218	31	TEODORO SCHMIDT
219	31	FREIRE
220	31	CUNCO
221	31	TOLTÉN
222	31	PITRUFQUÉN
223	31	GORBEA
224	31	LONCOCHE
225	31	VILLARRICA
226	31	PUCÓN
227	31	CURARREHUE
228	32	SAN JUAN DE LA COSTA
229	32	SAN PABLO
230	32	OSORNO
231	32	PUYEHUE
232	32	RIO NEGRO
233	32	PUERTO OCTAY
234	32	PURRANQUE
235	33	FRESIA
236	33	FRUTILLAR
237	33	PUERTO VARAS
238	33	LLANQUIHUE
239	33	LOS MUERMOS
240	33	PUERTO MONTT
241	33	COCHAMO
242	33	MAULLIN
243	33	CALBUCO
244	34	ANCUD
245	34	QUEMCHI
246	34	DALCAHUE
247	34	CASTRO
248	34	CURACO DE VELEZ
249	34	QUINCHAO
250	34	CHONCHI
251	34	PUQUELDÓN
252	34	QUEILÉN
253	34	QUELLÓN
254	35	HUALAIHUE
255	35	CHAITÉN
256	35	FUTALEUFU
257	35	PALENA
258	36	GUAITECAS
259	36	CISNES
260	36	AISÉN
261	37	LAGO VERDE
262	37	COYHAIQUE
263	38	RIO IBANEZ
264	38	CHILE CHICO
265	39	COCHRANE
266	39	TORTEL
267	39	O'HIGGINS
268	40	NATALES
269	40	TORRES DEL PAINE
270	41	LAGUNA BLANCA
271	41	SAN GREGORIO
272	41	RIO VERDE
273	41	PUNTA ARENAS
274	42	PRIMAVERA
275	42	PORVENIR
276	42	TIMAUKEL
277	43	CABO DE HORNOS
278	43	ANTARTICA
279	44	SANTIAGO
280	44	CERRILLOS
281	44	CERRO NAVIA
282	44	CONCHALI
283	44	EL BOSQUE
284	44	ESTACION CENTRAL
285	44	HUECHURABA
286	44	INDEPENDENCIA
287	44	LA CISTERNA
288	44	LA FLORIDA
289	44	LA GRANJA
290	44	LA PINTANA
291	44	LA REINA
292	44	LAS CONDES
293	44	LO BARNECHEA
294	44	LO ESPEJO
295	44	LO PRADO
296	44	MACUL
297	44	MAIPU
298	44	ÑUÑOA
299	44	PEDRO AGUIRRE CERDA
300	44	PEÑALOLÉN
301	44	PROVIDENCIA
302	44	PUDAHUEL
303	44	QUILICURA
304	44	QUINTA NORMAL
305	44	RECOLETA
306	44	RENCA
307	44	SAN JOAQUIN
308	44	SAN MIGUEL
309	44	SAN RAMÓN
310	44	VITACURA
311	45	TILTIL
312	45	COLINA
313	45	LAMPA
314	46	CURACAVI
315	46	MARIA PINTO
316	46	MELIPILLA
317	46	SAN PEDRO
318	46	ALHUE
319	47	PEÑAFLOR
320	47	EL MONTE
321	47	TALAGANTE
322	47	ISLA DE MAIPO
323	47	PADRE HURTADO
324	48	CALERA DE TANGO
325	48	SAN BERNARDO
326	48	BUIN
327	48	PAINE
328	49	PUENTE ALTO
329	49	PIRQUE
330	49	SAN JOSE DE MAIPO
331	50	MARIQUINA
332	50	LANCO
333	50	PANGUIPULLI
334	50	MAFIL
335	50	VALDIVIA
336	50	LOS LAGOS
337	50	CORRAL
338	50	PAILLACO
339	51	FUTRONO
340	51	LA UNIÓN
341	51	LAGO RANCO
342	51	RIO BUENO
343	52	GENERAL LAGOS
344	52	PUTRE
345	53	ARICA
346	53	CAMARONES
347	54	COBQUECURA
348	54	COELEMU
349	54	NINHUE
350	54	PORTEZUELO
351	54	QUIRIHUE
352	54	RANQUIL
353	54	TREGUACO
354	55	BULNES
355	55	CHILLAN VIEJO
356	55	CHILLAN
357	55	EL CARMEN
358	55	PEMUCO
359	55	PINTO
360	55	QUILLÓN
361	55	SAN IGNACIO
362	55	YUNGAY
363	56	COIHUECO
364	56	ÑIQUÉN
365	56	SAN CARLOS
366	56	SAN FABIAN
367	56	SAN NICOLAS
\.


--
-- Name: unmp_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('unmp_seq', 10, true);


--
-- Name: unms_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('unms_seq', 2, true);


--
-- Name: unt1_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('unt1_seq', 17, false);


--
-- Name: unt2_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('unt2_seq', 57, false);


--
-- Name: unt3_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('unt3_seq', 368, false);


--
-- Name: uspe_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('uspe_seq', 1063, true);


--
-- Name: usua_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('usua_seq', 16, true);


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY usuarios (id, username, password, idpers, idesre, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	ADMIN	12345	1	1	1	2017-12-24 10:47:53.945989	\N	\N	\N	\N
2	ROSILVA	12345	2	1	1	2017-12-24 10:47:54.180293	\N	\N	\N	\N
3	SEAGUIRRE	12345	3	1	1	2017-12-24 10:47:54.18863	\N	\N	\N	\N
4	JJMONSALVE	12345	4	1	1	2017-12-24 10:47:54.196975	\N	\N	\N	\N
5	JABORZONE	12345	5	1	1	2017-12-24 10:47:54.205293	\N	\N	\N	\N
6	ROCIFUENTES	12345	6	1	1	2017-12-24 10:47:54.213653	\N	\N	\N	\N
7	RQUEZADAA	12345	7	2	1	2017-12-24 10:47:54.221976	\N	\N	\N	\N
8	OSOLARM	12345	8	1	1	2017-12-24 10:47:54.271975	\N	\N	\N	\N
9	NSALAZARG	12345	9	1	1	2017-12-24 10:47:54.280288	\N	\N	\N	\N
10	CPALMAA	12345	10	1	1	2017-12-24 10:47:54.288636	\N	\N	\N	\N
11	JCISTERNAF	12345	11	1	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
12	UAT	12345	12	1	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
13	ULEGALES	12345	13	1	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
14	NPALMAM	12345	14	1	3	2017-12-25 13:02:25	\N	\N	\N	\N
15	JUAN PERES 	12345	5	1	4	2017-12-26 11:19:16	\N	\N	\N	\N
\.


--
-- Data for Name: usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY usuarios_perfiles (id, idusua, idperf, idgrem, idempr, idesre, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	1	1	\N	\N	1	1	2017-12-24 10:48:03.83877	\N	\N	\N	\N
2	2	1	\N	\N	1	1	2017-12-24 10:48:03.847119	\N	\N	\N	\N
3	3	1	\N	\N	1	1	2017-12-24 10:48:03.855452	\N	\N	\N	\N
4	4	1	\N	\N	1	1	2017-12-24 10:48:03.863773	\N	\N	\N	\N
5	5	1	\N	\N	1	1	2017-12-24 10:48:03.872109	\N	\N	\N	\N
6	6	1	\N	\N	1	1	2017-12-24 10:48:03.880486	\N	\N	\N	\N
7	7	1	\N	\N	1	1	2017-12-24 10:48:03.888785	\N	\N	\N	\N
111	11	8	\N	2	1	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
12	11	12	\N	3	1	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
13	11	15	\N	4	1	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
14	11	17	\N	5	1	1	2017-12-24 10:48:07.5785	\N	\N	\N	\N
515	12	273	\N	1	1	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
516	2	273	\N	1	1	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
517	3	273	\N	1	1	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
518	4	273	\N	1	1	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
519	5	273	\N	1	1	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
520	6	273	\N	1	1	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
521	7	273	\N	1	1	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
1025	13	2024	\N	1	1	1	2017-12-24 10:48:07.722594	\N	\N	\N	\N
1026	8	1	\N	\N	1	1	2017-12-24 10:48:07.764642	\N	\N	\N	\N
1027	8	2	3	\N	1	1	2017-12-24 10:48:07.773034	\N	\N	\N	\N
1028	8	4	\N	7	1	1	2017-12-24 10:48:07.781323	\N	\N	\N	\N
1029	8	4	\N	9	1	1	2017-12-24 10:48:07.789726	\N	\N	\N	\N
1030	8	4	\N	10	1	1	2017-12-24 10:48:07.797987	\N	\N	\N	\N
1031	8	12	\N	6	1	1	2017-12-24 10:48:07.806326	\N	\N	\N	\N
1032	8	12	\N	7	1	1	2017-12-24 10:48:07.814665	\N	\N	\N	\N
1033	8	12	\N	10	1	1	2017-12-24 10:48:07.822985	\N	\N	\N	\N
1034	8	19	\N	6	1	1	2017-12-24 10:48:07.872997	\N	\N	\N	\N
1035	8	19	\N	8	1	1	2017-12-24 10:48:07.881326	\N	\N	\N	\N
1036	8	19	\N	9	1	1	2017-12-24 10:48:07.889656	\N	\N	\N	\N
1037	8	19	\N	10	1	1	2017-12-24 10:48:07.998079	\N	\N	\N	\N
1038	9	1	\N	\N	1	1	2017-12-24 10:48:08.1122	\N	\N	\N	\N
1039	9	2	3	\N	1	1	2017-12-24 10:48:08.139789	\N	\N	\N	\N
1040	9	4	\N	7	1	1	2017-12-24 10:48:08.148062	\N	\N	\N	\N
1041	9	4	\N	9	1	1	2017-12-24 10:48:08.15631	\N	\N	\N	\N
1042	9	4	\N	10	1	1	2017-12-24 10:48:08.16475	\N	\N	\N	\N
1043	9	12	\N	6	1	1	2017-12-24 10:48:08.173061	\N	\N	\N	\N
1044	9	12	\N	7	1	1	2017-12-24 10:48:08.181382	\N	\N	\N	\N
1045	9	12	\N	10	1	1	2017-12-24 10:48:08.189747	\N	\N	\N	\N
1046	9	19	\N	6	1	1	2017-12-24 10:48:08.198064	\N	\N	\N	\N
1047	9	19	\N	8	1	1	2017-12-24 10:48:08.206381	\N	\N	\N	\N
1048	9	19	\N	9	1	1	2017-12-24 10:48:08.214729	\N	\N	\N	\N
1049	9	19	\N	10	1	1	2017-12-24 10:48:08.264733	\N	\N	\N	\N
1050	10	1	\N	\N	1	1	2017-12-24 10:48:08.273126	\N	\N	\N	\N
1051	10	2	3	\N	1	1	2017-12-24 10:48:08.281456	\N	\N	\N	\N
1052	10	4	\N	7	1	1	2017-12-24 10:48:08.289794	\N	\N	\N	\N
1053	10	4	\N	9	1	1	2017-12-24 10:48:08.298122	\N	\N	\N	\N
1054	10	4	\N	10	1	1	2017-12-24 10:48:08.30645	\N	\N	\N	\N
1055	10	12	\N	6	1	1	2017-12-24 10:48:08.314791	\N	\N	\N	\N
1056	10	12	\N	7	1	1	2017-12-24 10:48:08.323131	\N	\N	\N	\N
1057	10	12	\N	10	1	1	2017-12-24 10:48:08.331448	\N	\N	\N	\N
1058	10	19	\N	6	1	1	2017-12-24 10:48:08.339786	\N	\N	\N	\N
1059	10	19	\N	8	1	1	2017-12-24 10:48:08.348126	\N	\N	\N	\N
1060	10	19	\N	9	1	1	2017-12-24 10:48:08.398131	\N	\N	\N	\N
1061	10	19	\N	10	1	1	2017-12-24 10:48:08.406561	\N	\N	\N	\N
1062	14	4	\N	12	1	3	2017-12-25 13:02:25	\N	\N	\N	\N
\.


--
-- Name: vado_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('vado_seq', 1, false);


--
-- Data for Name: valores_dominios; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY valores_dominios (id, iddomi, descripcion, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
\.


--
-- Data for Name: valores_paises; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY valores_paises (id, idpais, nombrecorto, nombrelargo, descripcion, valor, idusuacrearegistro, fechacrearegistro, idusuamodifregistro, fechamodifregistro, idusuaborraregistro, fechaborraregistro) FROM stdin;
1	1	IDENTP1	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	RUT	1	2017-12-24 10:47:54.305286	\N	\N	\N	\N
2	1	IDENTP2	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	DV	1	2017-12-24 10:47:54.313706	\N	\N	\N	\N
3	1	IDENTE1	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	RUT	1	2017-12-24 10:47:54.322039	\N	\N	\N	\N
4	1	IDENTE2	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	DV	1	2017-12-24 10:47:54.330385	\N	\N	\N	\N
5	1	RETHON	RETENCIÓN HONORARIOS	% RETENCIÓN DE HONORARIOS EN ESTE PAIS	10	1	2017-12-24 10:47:54.338705	\N	\N	\N	\N
6	1	NUMUNIT	NRO. UNIDADES TERRITORIALES	NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS	3	1	2017-12-24 10:47:54.347041	\N	\N	\N	\N
7	1	UNITER1	UNIDAD TERRITORIAL ORDEN 1	NOMBRE UNIDAD TERRITORIAL DE ORDEN 1	REGIÓN	1	2017-12-24 10:47:54.355382	\N	\N	\N	\N
8	1	UNITER2	UNIDAD TERRITORIAL ORDEN 2	NOMBRE UNIDAD TERRITORIAL DE ORDEN 2	PROVINCIA	1	2017-12-24 10:47:54.397042	\N	\N	\N	\N
9	1	UNITER3	UNIDAD TERRITORIAL ORDEN 3	NOMBRE UNIDAD TERRITORIAL DE ORDEN 3	COMUNA	1	2017-12-24 10:47:54.405384	\N	\N	\N	\N
10	2	IDENTP1	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	DNI	1	2017-12-24 10:47:54.4137	\N	\N	\N	\N
11	2	IDENTP2	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	DV	1	2017-12-24 10:47:54.422034	\N	\N	\N	\N
12	2	IDENTE1	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	RUT	1	2017-12-24 10:47:54.430354	\N	\N	\N	\N
13	2	IDENTE2	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	DV	1	2017-12-24 10:47:54.438713	\N	\N	\N	\N
14	2	RETHON	RETENCIÓN HONORARIOS	% RETENCIÓN DE HONORARIOS EN ESTE PAIS	10	1	2017-12-24 10:47:54.447034	\N	\N	\N	\N
15	2	NUMUNIT	NRO. UNIDADES TERRITORIALES	NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS	3	1	2017-12-24 10:47:54.455354	\N	\N	\N	\N
16	2	UNITER1	UNIDAD TERRITORIAL ORDEN 1	NOMBRE UNIDAD TERRITORIAL DE ORDEN 1	REGIÓN	1	2017-12-24 10:47:54.463712	\N	\N	\N	\N
17	2	UNITER2	UNIDAD TERRITORIAL ORDEN 2	NOMBRE UNIDAD TERRITORIAL DE ORDEN 2	PROVINCIA	1	2017-12-24 10:47:54.472097	\N	\N	\N	\N
18	2	UNITER3	UNIDAD TERRITORIAL ORDEN 3	NOMBRE UNIDAD TERRITORIAL DE ORDEN 3	COMUNA	1	2017-12-24 10:47:54.480436	\N	\N	\N	\N
19	3	IDENTP1	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	RUC	1	2017-12-24 10:47:54.530418	\N	\N	\N	\N
20	3	IDENTP2	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	DV	1	2017-12-24 10:47:54.53875	\N	\N	\N	\N
21	3	IDENTE1	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	RUC	1	2017-12-24 10:47:54.547083	\N	\N	\N	\N
22	3	IDENTE2	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	DV	1	2017-12-24 10:47:54.55544	\N	\N	\N	\N
23	3	RETHON	RETENCIÓN HONORARIOS	% RETENCIÓN DE HONORARIOS EN ESTE PAIS	10	1	2017-12-24 10:47:54.563674	\N	\N	\N	\N
24	3	NUMUNIT	NRO. UNIDADES TERRITORIALES	NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS	3	1	2017-12-24 10:47:54.572068	\N	\N	\N	\N
25	3	UNITER1	UNIDAD TERRITORIAL ORDEN 1	NOMBRE UNIDAD TERRITORIAL DE ORDEN 1	REGIÓN	1	2017-12-24 10:47:54.5804	\N	\N	\N	\N
26	3	UNITER2	UNIDAD TERRITORIAL ORDEN 2	NOMBRE UNIDAD TERRITORIAL DE ORDEN 2	PROVINCIA	1	2017-12-24 10:47:54.588677	\N	\N	\N	\N
27	3	UNITER3	UNIDAD TERRITORIAL ORDEN 3	NOMBRE UNIDAD TERRITORIAL DE ORDEN 3	COMUNA	1	2017-12-24 10:47:54.59707	\N	\N	\N	\N
28	4	IDENTP1	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	RUC	1	2017-12-24 10:47:54.605485	\N	\N	\N	\N
29	4	IDENTP2	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	DV	1	2017-12-24 10:47:54.613745	\N	\N	\N	\N
30	4	IDENTE1	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	RUC	1	2017-12-24 10:47:54.663751	\N	\N	\N	\N
31	4	IDENTE2	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	DV	1	2017-12-24 10:47:54.672142	\N	\N	\N	\N
32	4	RETHON	RETENCIÓN HONORARIOS	% RETENCIÓN DE HONORARIOS EN ESTE PAIS	10	1	2017-12-24 10:47:54.680498	\N	\N	\N	\N
33	4	NUMUNIT	NRO. UNIDADES TERRITORIALES	NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS	3	1	2017-12-24 10:47:54.688734	\N	\N	\N	\N
34	4	UNITER1	UNIDAD TERRITORIAL ORDEN 1	NOMBRE UNIDAD TERRITORIAL DE ORDEN 1	REGIÓN	1	2017-12-24 10:47:54.69713	\N	\N	\N	\N
35	4	UNITER2	UNIDAD TERRITORIAL ORDEN 2	NOMBRE UNIDAD TERRITORIAL DE ORDEN 2	PROVINCIA	1	2017-12-24 10:47:54.705463	\N	\N	\N	\N
36	4	UNITER3	UNIDAD TERRITORIAL ORDEN 3	NOMBRE UNIDAD TERRITORIAL DE ORDEN 3	COMUNA	1	2017-12-24 10:47:54.713735	\N	\N	\N	\N
37	5	IDENTP1	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	RUC	1	2017-12-24 10:47:54.722124	\N	\N	\N	\N
38	5	IDENTP2	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	DV	1	2017-12-24 10:47:54.730472	\N	\N	\N	\N
39	5	IDENTE1	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	RUC	1	2017-12-24 10:47:54.738815	\N	\N	\N	\N
40	5	IDENTE2	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	DV	1	2017-12-24 10:47:54.747138	\N	\N	\N	\N
41	5	RETHON	RETENCIÓN HONORARIOS	% RETENCIÓN DE HONORARIOS EN ESTE PAIS	10	1	2017-12-24 10:47:54.797146	\N	\N	\N	\N
42	5	NUMUNIT	NRO. UNIDADES TERRITORIALES	NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS	3	1	2017-12-24 10:47:54.805419	\N	\N	\N	\N
43	5	UNITER1	UNIDAD TERRITORIAL ORDEN 1	NOMBRE UNIDAD TERRITORIAL DE ORDEN 1	REGIÓN	1	2017-12-24 10:47:54.813801	\N	\N	\N	\N
44	5	UNITER2	UNIDAD TERRITORIAL ORDEN 2	NOMBRE UNIDAD TERRITORIAL DE ORDEN 2	PROVINCIA	1	2017-12-24 10:47:54.822136	\N	\N	\N	\N
45	5	UNITER3	UNIDAD TERRITORIAL ORDEN 3	NOMBRE UNIDAD TERRITORIAL DE ORDEN 3	COMUNA	1	2017-12-24 10:47:54.830531	\N	\N	\N	\N
46	6	IDENTP1	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	RUC	1	2017-12-24 10:47:54.838877	\N	\N	\N	\N
47	6	IDENTP2	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	DV	1	2017-12-24 10:47:54.847206	\N	\N	\N	\N
48	6	IDENTE1	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	RUC	1	2017-12-24 10:47:54.85551	\N	\N	\N	\N
49	6	IDENTE2	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	DV	1	2017-12-24 10:47:54.863869	\N	\N	\N	\N
50	6	RETHON	RETENCIÓN HONORARIOS	% RETENCIÓN DE HONORARIOS EN ESTE PAIS	10	1	2017-12-24 10:47:54.872212	\N	\N	\N	\N
51	6	NUMUNIT	NRO. UNIDADES TERRITORIALES	NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS	3	1	2017-12-24 10:47:54.88051	\N	\N	\N	\N
52	6	UNITER1	UNIDAD TERRITORIAL ORDEN 1	NOMBRE UNIDAD TERRITORIAL DE ORDEN 1	REGIÓN	1	2017-12-24 10:47:54.930549	\N	\N	\N	\N
53	6	UNITER2	UNIDAD TERRITORIAL ORDEN 2	NOMBRE UNIDAD TERRITORIAL DE ORDEN 2	PROVINCIA	1	2017-12-24 10:47:54.938917	\N	\N	\N	\N
54	6	UNITER3	UNIDAD TERRITORIAL ORDEN 3	NOMBRE UNIDAD TERRITORIAL DE ORDEN 3	COMUNA	1	2017-12-24 10:47:54.947208	\N	\N	\N	\N
55	7	IDENTP1	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	RUC	1	2017-12-24 10:47:54.955511	\N	\N	\N	\N
56	7	IDENTP2	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	DV	1	2017-12-24 10:47:54.963882	\N	\N	\N	\N
57	7	IDENTE1	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	RUC	1	2017-12-24 10:47:54.972203	\N	\N	\N	\N
58	7	IDENTE2	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	DV	1	2017-12-24 10:47:54.980525	\N	\N	\N	\N
59	7	RETHON	RETENCIÓN HONORARIOS	% RETENCIÓN DE HONORARIOS EN ESTE PAIS	10	1	2017-12-24 10:47:54.988913	\N	\N	\N	\N
60	7	NUMUNIT	NRO. UNIDADES TERRITORIALES	NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS	3	1	2017-12-24 10:47:54.997254	\N	\N	\N	\N
61	7	UNITER1	UNIDAD TERRITORIAL ORDEN 1	NOMBRE UNIDAD TERRITORIAL DE ORDEN 1	REGIÓN	1	2017-12-24 10:47:55.005583	\N	\N	\N	\N
62	7	UNITER2	UNIDAD TERRITORIAL ORDEN 2	NOMBRE UNIDAD TERRITORIAL DE ORDEN 2	PROVINCIA	1	2017-12-24 10:47:55.013949	\N	\N	\N	\N
63	7	UNITER3	UNIDAD TERRITORIAL ORDEN 3	NOMBRE UNIDAD TERRITORIAL DE ORDEN 3	COMUNA	1	2017-12-24 10:47:55.063947	\N	\N	\N	\N
64	8	IDENTP1	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	RUC	1	2017-12-24 10:47:55.097264	\N	\N	\N	\N
65	8	IDENTP2	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	DV	1	2017-12-24 10:47:55.105583	\N	\N	\N	\N
66	8	IDENTE1	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	RUC	1	2017-12-24 10:47:55.113936	\N	\N	\N	\N
67	8	IDENTE2	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	DV	1	2017-12-24 10:47:55.122267	\N	\N	\N	\N
68	8	RETHON	RETENCIÓN HONORARIOS	% RETENCIÓN DE HONORARIOS EN ESTE PAIS	10	1	2017-12-24 10:47:55.130578	\N	\N	\N	\N
69	8	NUMUNIT	NRO. UNIDADES TERRITORIALES	NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS	3	1	2017-12-24 10:47:55.138939	\N	\N	\N	\N
70	8	UNITER1	UNIDAD TERRITORIAL ORDEN 1	NOMBRE UNIDAD TERRITORIAL DE ORDEN 1	REGIÓN	1	2017-12-24 10:47:55.188938	\N	\N	\N	\N
71	8	UNITER2	UNIDAD TERRITORIAL ORDEN 2	NOMBRE UNIDAD TERRITORIAL DE ORDEN 2	PROVINCIA	1	2017-12-24 10:47:55.19727	\N	\N	\N	\N
72	8	UNITER3	UNIDAD TERRITORIAL ORDEN 3	NOMBRE UNIDAD TERRITORIAL DE ORDEN 3	COMUNA	1	2017-12-24 10:47:55.205571	\N	\N	\N	\N
73	9	IDENTP1	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	RUC	1	2017-12-24 10:47:55.213935	\N	\N	\N	\N
74	9	IDENTP2	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	DV	1	2017-12-24 10:47:55.222401	\N	\N	\N	\N
75	9	IDENTE1	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	RUC	1	2017-12-24 10:47:55.230662	\N	\N	\N	\N
76	9	IDENTE2	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	DV	1	2017-12-24 10:47:55.239001	\N	\N	\N	\N
77	9	RETHON	RETENCIÓN HONORARIOS	% RETENCIÓN DE HONORARIOS EN ESTE PAIS	10	1	2017-12-24 10:47:55.247332	\N	\N	\N	\N
78	9	NUMUNIT	NRO. UNIDADES TERRITORIALES	NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS	3	1	2017-12-24 10:47:55.255579	\N	\N	\N	\N
79	9	UNITER1	UNIDAD TERRITORIAL ORDEN 1	NOMBRE UNIDAD TERRITORIAL DE ORDEN 1	REGIÓN	1	2017-12-24 10:47:55.263989	\N	\N	\N	\N
80	9	UNITER2	UNIDAD TERRITORIAL ORDEN 2	NOMBRE UNIDAD TERRITORIAL DE ORDEN 2	PROVINCIA	1	2017-12-24 10:47:55.272326	\N	\N	\N	\N
81	9	UNITER3	UNIDAD TERRITORIAL ORDEN 3	NOMBRE UNIDAD TERRITORIAL DE ORDEN 3	COMUNA	1	2017-12-24 10:47:55.322332	\N	\N	\N	\N
82	10	IDENTP1	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS	RUC	1	2017-12-24 10:47:55.330671	\N	\N	\N	\N
83	10	IDENTP2	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS	DV	1	2017-12-24 10:47:55.338998	\N	\N	\N	\N
84	10	IDENTE1	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS	RUC	1	2017-12-24 10:47:55.34732	\N	\N	\N	\N
85	10	IDENTE2	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS	DV	1	2017-12-24 10:47:55.35566	\N	\N	\N	\N
86	10	RETHON	RETENCIÓN HONORARIOS	% RETENCIÓN DE HONORARIOS EN ESTE PAIS	10	1	2017-12-24 10:47:55.363995	\N	\N	\N	\N
87	10	NUMUNIT	NRO. UNIDADES TERRITORIALES	NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS	3	1	2017-12-24 10:47:55.372326	\N	\N	\N	\N
88	10	UNITER1	UNIDAD TERRITORIAL ORDEN 1	NOMBRE UNIDAD TERRITORIAL DE ORDEN 1	REGIÓN	1	2017-12-24 10:47:55.380659	\N	\N	\N	\N
89	10	UNITER2	UNIDAD TERRITORIAL ORDEN 2	NOMBRE UNIDAD TERRITORIAL DE ORDEN 2	PROVINCIA	1	2017-12-24 10:47:55.389081	\N	\N	\N	\N
90	10	UNITER3	UNIDAD TERRITORIAL ORDEN 3	NOMBRE UNIDAD TERRITORIAL DE ORDEN 3	COMUNA	1	2017-12-24 10:47:55.397404	\N	\N	\N	\N
\.


--
-- Name: vapa_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('vapa_seq', 91, false);


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
-- Name: clie_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT clie_pk PRIMARY KEY (id);


--
-- Name: clie_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT clie_uk_01 UNIQUE (idgrem, identificador1);


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
-- Name: cove_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY cotizaciones_ventas
    ADD CONSTRAINT cove_pk PRIMARY KEY (id);


--
-- Name: cove_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY cotizaciones_ventas
    ADD CONSTRAINT cove_uk_01 UNIQUE (idempr, numero);


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
-- Name: decv_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY detalles_cotizs_vtas
    ADD CONSTRAINT decv_pk PRIMARY KEY (id);


--
-- Name: decv_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY detalles_cotizs_vtas
    ADD CONSTRAINT decv_uk_01 UNIQUE (idcove, correlativo);


--
-- Name: decv_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY detalles_cotizs_vtas
    ADD CONSTRAINT decv_uk_02 UNIQUE (idcove, idprod, idserv);


--
-- Name: dedv_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY detalles_doctos_vtas
    ADD CONSTRAINT dedv_pk PRIMARY KEY (id);


--
-- Name: dedv_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY detalles_doctos_vtas
    ADD CONSTRAINT dedv_uk_01 UNIQUE (iddove, correlativo);


--
-- Name: dedv_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY detalles_doctos_vtas
    ADD CONSTRAINT dedv_uk_02 UNIQUE (iddove, idprod, idserv);


--
-- Name: denv_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY detalles_notas_vtas
    ADD CONSTRAINT denv_pk PRIMARY KEY (id);


--
-- Name: denv_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY detalles_notas_vtas
    ADD CONSTRAINT denv_uk_01 UNIQUE (idnove, correlativo);


--
-- Name: denv_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY detalles_notas_vtas
    ADD CONSTRAINT denv_uk_02 UNIQUE (idnove, idprod, idserv);


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
-- Name: domi_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY dominios
    ADD CONSTRAINT domi_pk PRIMARY KEY (id);


--
-- Name: domi_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY dominios
    ADD CONSTRAINT domi_uk_01 UNIQUE (descripcion);


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
-- Name: dove_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_pk PRIMARY KEY (id);


--
-- Name: dove_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_uk_01 UNIQUE (idempr, idtidv, numero);


--
-- Name: dove_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_uk_02 UNIQUE (idempr, idnove, idtidv);


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
-- Name: escv_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_cotizaciones_vtas
    ADD CONSTRAINT escv_pk PRIMARY KEY (id);


--
-- Name: escv_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_cotizaciones_vtas
    ADD CONSTRAINT escv_uk_01 UNIQUE (descripcion);


--
-- Name: esdl_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_documentos_legales
    ADD CONSTRAINT esdl_pk PRIMARY KEY (id);


--
-- Name: esdl_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_documentos_legales
    ADD CONSTRAINT esdl_uk_01 UNIQUE (idgrem, descripcion);


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
-- Name: esnv_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_notas_vtas
    ADD CONSTRAINT esnv_pk PRIMARY KEY (id);


--
-- Name: esnv_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_notas_vtas
    ADD CONSTRAINT esnv_uk_01 UNIQUE (descripcion);


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
-- Name: esve_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_ventas
    ADD CONSTRAINT esve_pk PRIMARY KEY (id);


--
-- Name: esve_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY estados_ventas
    ADD CONSTRAINT esve_uk_01 UNIQUE (descripcion);


--
-- Name: fide_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY field_defs
    ADD CONSTRAINT fide_pk PRIMARY KEY (id);


--
-- Name: fode_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY form_defs
    ADD CONSTRAINT fode_pk PRIMARY KEY (id);


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
-- Name: impu_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY impuestos
    ADD CONSTRAINT impu_pk PRIMARY KEY (id);


--
-- Name: impu_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY impuestos
    ADD CONSTRAINT impu_uk_01 UNIQUE (descripcion);


--
-- Name: impu_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY impuestos
    ADD CONSTRAINT impu_uk_02 UNIQUE (descripcioncorta);


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
-- Name: nove_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_pk PRIMARY KEY (id);


--
-- Name: nove_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_uk_01 UNIQUE (idempr, numero);


--
-- Name: nove_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_uk_02 UNIQUE (idempr, idcove);


--
-- Name: orpr_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY origenes_productos
    ADD CONSTRAINT orpr_pk PRIMARY KEY (id);


--
-- Name: orpr_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY origenes_productos
    ADD CONSTRAINT orpr_uk_01 UNIQUE (descripcion);


--
-- Name: orpr_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY origenes_productos
    ADD CONSTRAINT orpr_uk_02 UNIQUE (descripcioncorta);


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
-- Name: prod_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT prod_pk PRIMARY KEY (id);


--
-- Name: prod_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT prod_uk_01 UNIQUE (idempr, nombre);


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
-- Name: serv_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY servicios
    ADD CONSTRAINT serv_pk PRIMARY KEY (id);


--
-- Name: serv_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY servicios
    ADD CONSTRAINT serv_uk_01 UNIQUE (idempr, nombre);


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
-- Name: tase_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tablas_secuencias
    ADD CONSTRAINT tase_pk PRIMARY KEY (tabla, secuencia);


--
-- Name: ticl_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_clientes
    ADD CONSTRAINT ticl_pk PRIMARY KEY (id);


--
-- Name: ticl_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_clientes
    ADD CONSTRAINT ticl_uk_01 UNIQUE (descripcion);


--
-- Name: ticv_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_cotizaciones_vtas
    ADD CONSTRAINT ticv_pk PRIMARY KEY (id);


--
-- Name: ticv_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_cotizaciones_vtas
    ADD CONSTRAINT ticv_uk_01 UNIQUE (descripcion);


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
-- Name: tidl_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_documentos_legales
    ADD CONSTRAINT tidl_uk_02 UNIQUE (idgrem, descripcioncorta);


--
-- Name: tidl_uk_03; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_documentos_legales
    ADD CONSTRAINT tidl_uk_03 UNIQUE (idgrem, color);


--
-- Name: tidv_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_doctos_ventas
    ADD CONSTRAINT tidv_pk PRIMARY KEY (id);


--
-- Name: tidv_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_doctos_ventas
    ADD CONSTRAINT tidv_uk_01 UNIQUE (idpais, descripcion);


--
-- Name: tidv_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_doctos_ventas
    ADD CONSTRAINT tidv_uk_02 UNIQUE (idpais, descripcioncorta);


--
-- Name: tidv_uk_03; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_doctos_ventas
    ADD CONSTRAINT tidv_uk_03 UNIQUE (idpais, codigooficial);


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
-- Name: tipi_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_productos_impuestos
    ADD CONSTRAINT tipi_pk PRIMARY KEY (id);


--
-- Name: tipi_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_productos_impuestos
    ADD CONSTRAINT tipi_uk_01 UNIQUE (idtipr, idimpu);


--
-- Name: tipr_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_productos
    ADD CONSTRAINT tipr_pk PRIMARY KEY (id);


--
-- Name: tipr_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_productos
    ADD CONSTRAINT tipr_uk_01 UNIQUE (descripcion);


--
-- Name: tise_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_servicios
    ADD CONSTRAINT tise_pk PRIMARY KEY (id);


--
-- Name: tise_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY tipos_servicios
    ADD CONSTRAINT tise_uk_01 UNIQUE (descripcion);


--
-- Name: unmp_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY unidades_medidas_productos
    ADD CONSTRAINT unmp_pk PRIMARY KEY (id);


--
-- Name: unmp_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY unidades_medidas_productos
    ADD CONSTRAINT unmp_uk_01 UNIQUE (descripcion);


--
-- Name: unmp_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY unidades_medidas_productos
    ADD CONSTRAINT unmp_uk_02 UNIQUE (descripcioncorta);


--
-- Name: unms_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY unidades_medidas_servicios
    ADD CONSTRAINT unms_pk PRIMARY KEY (id);


--
-- Name: unms_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY unidades_medidas_servicios
    ADD CONSTRAINT unms_uk_01 UNIQUE (descripcion);


--
-- Name: unms_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY unidades_medidas_servicios
    ADD CONSTRAINT unms_uk_02 UNIQUE (descripcioncorta);


--
-- Name: unt1_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY unidades_territoriales_1
    ADD CONSTRAINT unt1_pk PRIMARY KEY (id);


--
-- Name: unt1_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY unidades_territoriales_1
    ADD CONSTRAINT unt1_uk_01 UNIQUE (idpais, nombre);


--
-- Name: unt2_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY unidades_territoriales_2
    ADD CONSTRAINT unt2_pk PRIMARY KEY (id);


--
-- Name: unt2_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY unidades_territoriales_2
    ADD CONSTRAINT unt2_uk_01 UNIQUE (idunt1, nombre);


--
-- Name: unt3_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY unidades_territoriales_3
    ADD CONSTRAINT unt3_pk PRIMARY KEY (id);


--
-- Name: unt3_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY unidades_territoriales_3
    ADD CONSTRAINT unt3_uk_01 UNIQUE (idunt2, nombre);


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
-- Name: vado_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY valores_dominios
    ADD CONSTRAINT vado_pk PRIMARY KEY (id);


--
-- Name: vado_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY valores_dominios
    ADD CONSTRAINT vado_uk_01 UNIQUE (iddomi, descripcion);


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

CREATE TRIGGER trg_after_ins_grem AFTER INSERT ON grupos_empresariales FOR EACH ROW EXECUTE PROCEDURE f_crear_datos_holding();


--
-- Name: trg_after_upd_cove; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_after_upd_cove AFTER UPDATE ON cotizaciones_ventas FOR EACH ROW EXECUTE PROCEDURE f_copiar_cove_a_nove();


--
-- Name: trg_before_ins_cove; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_ins_cove BEFORE INSERT ON cotizaciones_ventas FOR EACH ROW EXECUTE PROCEDURE f_validar_cove_ins();


--
-- Name: trg_before_ins_dove; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_ins_dove BEFORE INSERT ON documentos_ventas FOR EACH ROW EXECUTE PROCEDURE f_validar_dove_ins();


--
-- Name: trg_before_ins_nove; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_ins_nove BEFORE INSERT ON notas_ventas FOR EACH ROW EXECUTE PROCEDURE f_validar_nove_ins();


--
-- Name: trg_before_ins_upd_pers; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_ins_upd_pers BEFORE INSERT OR UPDATE ON personas FOR EACH ROW EXECUTE PROCEDURE f_validar_dv_pers();


--
-- Name: trg_before_upd_cove; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_upd_cove BEFORE UPDATE ON cotizaciones_ventas FOR EACH ROW EXECUTE PROCEDURE f_validar_cove();


--
-- Name: trg_before_upd_dove; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_upd_dove BEFORE UPDATE ON documentos_ventas FOR EACH ROW EXECUTE PROCEDURE f_validar_dove();


--
-- Name: trg_before_upd_nove; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_upd_nove BEFORE UPDATE ON notas_ventas FOR EACH ROW EXECUTE PROCEDURE f_validar_nove();


--
-- Name: ceco_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY centros_costos
    ADD CONSTRAINT ceco_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: clie_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT clie_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: clie_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT clie_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: clie_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT clie_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: clie_fk_grem; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT clie_fk_grem FOREIGN KEY (idgrem) REFERENCES grupos_empresariales(id);


--
-- Name: clie_fk_pais; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT clie_fk_pais FOREIGN KEY (idpais) REFERENCES paises(id);


--
-- Name: clie_fk_ticl; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT clie_fk_ticl FOREIGN KEY (idticl) REFERENCES tipos_clientes(id);


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
-- Name: cove_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_ventas
    ADD CONSTRAINT cove_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: cove_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_ventas
    ADD CONSTRAINT cove_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: cove_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_ventas
    ADD CONSTRAINT cove_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: cove_fk_ceco; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_ventas
    ADD CONSTRAINT cove_fk_ceco FOREIGN KEY (idceco) REFERENCES centros_costos(id);


--
-- Name: cove_fk_clie; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_ventas
    ADD CONSTRAINT cove_fk_clie FOREIGN KEY (idclie) REFERENCES clientes(id);


--
-- Name: cove_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_ventas
    ADD CONSTRAINT cove_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: cove_fk_escv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_ventas
    ADD CONSTRAINT cove_fk_escv FOREIGN KEY (idescv) REFERENCES estados_cotizaciones_vtas(id);


--
-- Name: cove_fk_gere; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_ventas
    ADD CONSTRAINT cove_fk_gere FOREIGN KEY (idgere) REFERENCES gerencias(id);


--
-- Name: cove_fk_line; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_ventas
    ADD CONSTRAINT cove_fk_line FOREIGN KEY (idline) REFERENCES lineas_negocios(id);


--
-- Name: cove_fk_proy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_ventas
    ADD CONSTRAINT cove_fk_proy FOREIGN KEY (idproy) REFERENCES proyectos(id);


--
-- Name: cove_fk_tare; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cotizaciones_ventas
    ADD CONSTRAINT cove_fk_tare FOREIGN KEY (idtare) REFERENCES tareas(id);


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
-- Name: decv_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_cotizs_vtas
    ADD CONSTRAINT decv_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: decv_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_cotizs_vtas
    ADD CONSTRAINT decv_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: decv_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_cotizs_vtas
    ADD CONSTRAINT decv_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: decv_fk_cove; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_cotizs_vtas
    ADD CONSTRAINT decv_fk_cove FOREIGN KEY (idcove) REFERENCES cotizaciones_ventas(id);


--
-- Name: decv_fk_prod; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_cotizs_vtas
    ADD CONSTRAINT decv_fk_prod FOREIGN KEY (idprod) REFERENCES productos(id);


--
-- Name: decv_fk_serv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_cotizs_vtas
    ADD CONSTRAINT decv_fk_serv FOREIGN KEY (idserv) REFERENCES servicios(id);


--
-- Name: dedv_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_doctos_vtas
    ADD CONSTRAINT dedv_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: dedv_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_doctos_vtas
    ADD CONSTRAINT dedv_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: dedv_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_doctos_vtas
    ADD CONSTRAINT dedv_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: dedv_fk_dove; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_doctos_vtas
    ADD CONSTRAINT dedv_fk_dove FOREIGN KEY (iddove) REFERENCES documentos_ventas(id);


--
-- Name: dedv_fk_prod; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_doctos_vtas
    ADD CONSTRAINT dedv_fk_prod FOREIGN KEY (idprod) REFERENCES productos(id);


--
-- Name: dedv_fk_serv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_doctos_vtas
    ADD CONSTRAINT dedv_fk_serv FOREIGN KEY (idserv) REFERENCES servicios(id);


--
-- Name: denv_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_notas_vtas
    ADD CONSTRAINT denv_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: denv_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_notas_vtas
    ADD CONSTRAINT denv_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: denv_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_notas_vtas
    ADD CONSTRAINT denv_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: denv_fk_nove; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_notas_vtas
    ADD CONSTRAINT denv_fk_nove FOREIGN KEY (idnove) REFERENCES notas_ventas(id);


--
-- Name: denv_fk_prod; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_notas_vtas
    ADD CONSTRAINT denv_fk_prod FOREIGN KEY (idprod) REFERENCES productos(id);


--
-- Name: denv_fk_serv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_notas_vtas
    ADD CONSTRAINT denv_fk_serv FOREIGN KEY (idserv) REFERENCES servicios(id);


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
-- Name: domi_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY dominios
    ADD CONSTRAINT domi_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: domi_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY dominios
    ADD CONSTRAINT domi_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: domi_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY dominios
    ADD CONSTRAINT domi_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


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
-- Name: dove_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: dove_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: dove_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: dove_fk_ceco; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_fk_ceco FOREIGN KEY (idceco) REFERENCES centros_costos(id);


--
-- Name: dove_fk_clie; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_fk_clie FOREIGN KEY (idclie) REFERENCES clientes(id);


--
-- Name: dove_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: dove_fk_esve; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_fk_esve FOREIGN KEY (idesve) REFERENCES estados_ventas(id);


--
-- Name: dove_fk_gere; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_fk_gere FOREIGN KEY (idgere) REFERENCES gerencias(id);


--
-- Name: dove_fk_line; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_fk_line FOREIGN KEY (idline) REFERENCES lineas_negocios(id);


--
-- Name: dove_fk_nove; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_fk_nove FOREIGN KEY (idnove) REFERENCES notas_ventas(id);


--
-- Name: dove_fk_proy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_fk_proy FOREIGN KEY (idproy) REFERENCES proyectos(id);


--
-- Name: dove_fk_tare; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_fk_tare FOREIGN KEY (idtare) REFERENCES tareas(id);


--
-- Name: dove_fk_tidv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY documentos_ventas
    ADD CONSTRAINT dove_fk_tidv FOREIGN KEY (idtidv) REFERENCES tipos_doctos_ventas(id);


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
-- Name: empr_fk_esre; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY empresas
    ADD CONSTRAINT empr_fk_esre FOREIGN KEY (idesre) REFERENCES estados_registros(id);


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
-- Name: esdl_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY estados_documentos_legales
    ADD CONSTRAINT esdl_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: esdl_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY estados_documentos_legales
    ADD CONSTRAINT esdl_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: esdl_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY estados_documentos_legales
    ADD CONSTRAINT esdl_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: esdl_fk_grem; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY estados_documentos_legales
    ADD CONSTRAINT esdl_fk_grem FOREIGN KEY (idgrem) REFERENCES grupos_empresariales(id);


--
-- Name: fide_fk_fode; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY field_defs
    ADD CONSTRAINT fide_fk_fode FOREIGN KEY (form_id) REFERENCES form_defs(id);


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
-- Name: impu_fk_pais; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY impuestos
    ADD CONSTRAINT impu_fk_pais FOREIGN KEY (idpais) REFERENCES paises(id);


--
-- Name: line_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY lineas_negocios
    ADD CONSTRAINT line_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: nove_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: nove_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: nove_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: nove_fk_ceco; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_fk_ceco FOREIGN KEY (idceco) REFERENCES centros_costos(id);


--
-- Name: nove_fk_clie; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_fk_clie FOREIGN KEY (idclie) REFERENCES clientes(id);


--
-- Name: nove_fk_cove; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_fk_cove FOREIGN KEY (idcove) REFERENCES cotizaciones_ventas(id);


--
-- Name: nove_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: nove_fk_esnv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_fk_esnv FOREIGN KEY (idesnv) REFERENCES estados_notas_vtas(id);


--
-- Name: nove_fk_gere; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_fk_gere FOREIGN KEY (idgere) REFERENCES gerencias(id);


--
-- Name: nove_fk_line; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_fk_line FOREIGN KEY (idline) REFERENCES lineas_negocios(id);


--
-- Name: nove_fk_proy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_fk_proy FOREIGN KEY (idproy) REFERENCES proyectos(id);


--
-- Name: nove_fk_tare; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY notas_ventas
    ADD CONSTRAINT nove_fk_tare FOREIGN KEY (idtare) REFERENCES tareas(id);


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
-- Name: prod_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT prod_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: prod_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT prod_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: prod_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT prod_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: prod_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT prod_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: prod_fk_orpr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT prod_fk_orpr FOREIGN KEY (idorpr) REFERENCES origenes_productos(id);


--
-- Name: prod_fk_tipr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT prod_fk_tipr FOREIGN KEY (idtipr) REFERENCES tipos_productos(id);


--
-- Name: prod_fk_unmp; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT prod_fk_unmp FOREIGN KEY (idunmp) REFERENCES unidades_medidas_productos(id);


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
-- Name: serv_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY servicios
    ADD CONSTRAINT serv_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: serv_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY servicios
    ADD CONSTRAINT serv_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: serv_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY servicios
    ADD CONSTRAINT serv_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: serv_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY servicios
    ADD CONSTRAINT serv_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: serv_fk_mone; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY servicios
    ADD CONSTRAINT serv_fk_mone FOREIGN KEY (idmone) REFERENCES monedas(id);


--
-- Name: serv_fk_tise; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY servicios
    ADD CONSTRAINT serv_fk_tise FOREIGN KEY (idtise) REFERENCES tipos_servicios(id);


--
-- Name: serv_fk_unms; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY servicios
    ADD CONSTRAINT serv_fk_unms FOREIGN KEY (idunms) REFERENCES unidades_medidas_servicios(id);


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
-- Name: tidv_fk_pais; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY tipos_doctos_ventas
    ADD CONSTRAINT tidv_fk_pais FOREIGN KEY (idpais) REFERENCES paises(id);


--
-- Name: tipi_fk_impu; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY tipos_productos_impuestos
    ADD CONSTRAINT tipi_fk_impu FOREIGN KEY (idimpu) REFERENCES impuestos(id);


--
-- Name: tipi_fk_tipr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY tipos_productos_impuestos
    ADD CONSTRAINT tipi_fk_tipr FOREIGN KEY (idtipr) REFERENCES tipos_productos(id);


--
-- Name: unt1_fk_pais; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY unidades_territoriales_1
    ADD CONSTRAINT unt1_fk_pais FOREIGN KEY (idpais) REFERENCES paises(id);


--
-- Name: unt2_fk_unt1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY unidades_territoriales_2
    ADD CONSTRAINT unt2_fk_unt1 FOREIGN KEY (idunt1) REFERENCES unidades_territoriales_1(id);


--
-- Name: unt3_fk_unt2; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY unidades_territoriales_3
    ADD CONSTRAINT unt3_fk_unt2 FOREIGN KEY (idunt2) REFERENCES unidades_territoriales_2(id);


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
-- Name: usua_fk_pers; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usua_fk_pers FOREIGN KEY (idpers) REFERENCES personas(id);


--
-- Name: vado_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY valores_dominios
    ADD CONSTRAINT vado_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: vado_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY valores_dominios
    ADD CONSTRAINT vado_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: vado_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY valores_dominios
    ADD CONSTRAINT vado_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: vado_fk_domi; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY valores_dominios
    ADD CONSTRAINT vado_fk_domi FOREIGN KEY (iddomi) REFERENCES dominios(id);


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

