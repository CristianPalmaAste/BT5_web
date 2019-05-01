--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: f_completar_rubro_empresa(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_completar_rubro_empresa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  Vidrubr numeric;
begin
  if new.idrubr is null then
    select min(id)
    into   Vidrubr
    from   rubros
    where  idgrem = new.idgrem
    ;
    new.idrubr := Vidrubr;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.f_completar_rubro_empresa() OWNER TO admin;

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
  Vporcentajedescuento1     numeric;
  Vmontodescuento1          numeric;
  Vporcentajedescuento2     numeric;
  Vmontodescuento2          numeric;
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
          ,porcentajedescuento1
          ,montodescuento1
          ,porcentajedescuento2
          ,montodescuento2
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
    else
      Vnumero := Vnumero + 1;
    end if;
    insert into notas_ventas (id                       -- numeric(20,0)   not null
                             ,idempr                   -- numeric(20,0)   not null
                             ,idcove                   -- numeric(20,0)       null
                             ,numero                   -- numeric(20,0)   not null
                             ,idclie                   -- numeric(20,0)   not null
                             ,descripcionnotaventa     -- varchar(1000)   not null
                             ,fechanotaventa           -- timestamp       not null
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
           ,current_timestamp             -- fechanotaventa           timestamp       not null
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
                       ,Vporcentajedescuento1
                       ,Vmontodescuento1
                       ,Vporcentajedescuento2
                       ,Vmontodescuento2
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
                                      ,porcentajedescuento1     -- numeric(20,5)   not null
                                      ,montodescuento1          -- numeric(20,0)   not null
                                      ,porcentajedescuento2     -- numeric(20,5)   not null
                                      ,montodescuento2          -- numeric(20,0)   not null
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
             ,Vporcentajedescuento1                -- porcentajedescuento1     numeric(20,5)   not null
             ,Vmontodescuento1                     -- montodescuento1          numeric(20,0)   not null
             ,Vporcentajedescuento2                -- porcentajedescuento2     numeric(20,5)   not null
             ,Vmontodescuento2                     -- montodescuento2          numeric(20,0)   not null
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
  Vexento                   numeric;
  Vafecto                   numeric;
  Vtotallinea               numeric;
  C_denv cursor for
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
    from   detalles_notas_vtas
    where  idnove = new.id
    ;
begin
insert into cpalma values (1, 'm1');
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
                                  ,exento                   -- numeric(20,0)   not null
                                  ,afecto                   -- numeric(20,0)   not null
                                  ,impuestos                -- numeric(20,0)   not null
                                  ,porcentajedescuento      -- numeric(20,2)   not null
                                  ,montodescuento           -- numeric(20,2)   not null
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
           ,new.exento                    -- exento                   numeric(20,0)   not null
           ,new.afecto                    -- afecto                   numeric(20,0)   not null
           ,new.impuestos                 -- impuestos                numeric(20,0)   not null
           ,new.porcentajedescuento       -- porcentajedescuento      numeric(20,2)   not null
           ,new.montodescuento            -- montodescuento           numeric(20,2)   not null
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
      select nextval('dedv_seq')
      into   Viddedv
      ;
      insert into detalles_doctos_vtas (id                       -- numeric(20,0)   not null
                                       ,iddove                   -- numeric(20,0)   not null
                                       ,correlativo              -- numeric(20,0)   not null
                                       ,idprod                   -- numeric(20,0)       null
                                       ,idserv                   -- numeric(20,0)       null
                                       ,preciounitario           -- numeric(20,0)   not null
                                       ,cantidad                 -- numeric(20,2)   not null
                                       ,porcentajedescuento      -- numeric(20,2)   not null
                                       ,montodescuento           -- numeric(20,2)   not null
                                       ,exento                   -- numeric(20,2)   not null
                                       ,afecto                   -- numeric(20,2)   not null
                                       ,impuestos                -- numeric(20,2)   not null
                                       ,totallinea               -- numeric(20,2)   not null
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
             ,Vpreciounitario                      -- preciounitario           numeric(20,0)   not null
             ,Vcantidad                            -- cantidad                 numeric(20,2)   not null
             ,Vporcentajedescuento                 -- porcentajedescuento      numeric(20,2)   not null
             ,Vmontodescuento                      -- montodescuento           numeric(20,2)   not null
             ,Vexento                              -- impuestos                numeric(20,2)   not null
             ,Vafecto                              -- impuestos                numeric(20,2)   not null
             ,Vimpuestos                           -- impuestos                numeric(20,2)   not null
             ,Vtotallinea                          -- subtotal                 numeric(20,2)   not null
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
-- Name: f_copiar_nove_a_vent(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_copiar_nove_a_vent() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  Vidvent                   numeric;
  Vnumero                   numeric;
  Vcorrelativo              numeric;
  Vidprod                   numeric;
  Vidserv                   numeric;
  Vcantidad                 numeric;
  Vpreciounitario           numeric;
  Vporcentajedescuento1     numeric;
  Vmontodescuento1          numeric;
  Vporcentajedescuento2     numeric;
  Vmontodescuento2          numeric;
  Vimpuestos                numeric;
  Vsubtotal                 numeric;
  Vidusuacrearegistro       numeric;
  Viddeve                   numeric;
  Vidtidv                   numeric;
  Vidpais                   numeric;
  Vexento                   numeric;
  Vafecto                   numeric;
  Vtotallinea               numeric;
  Vidnove                   numeric;
  Vidfpve                   numeric;
  Vidtifp                   numeric;
  Vmonto                    numeric;
  C_denv cursor for
    select correlativo
          ,idprod
          ,idserv
          ,preciounitario
          ,cantidad
          ,porcentajedescuento1
          ,montodescuento1
          ,porcentajedescuento2
          ,montodescuento2
          ,exento
          ,afecto
          ,impuestos
          ,totallinea
          ,idusuacrearegistro
    from   detalles_notas_vtas
    where  idnove = new.id
    ;
  C_fpnv cursor for
    select idtifp
          ,monto
          ,idusuacrearegistro
    from   formas_pagos_notas_ventas
    where  idnove = new.id
    ;
begin
  if old.idesnv = 2 and new.idesnv = 3 then
    select idpais
    into   Vidpais
    from   empresas
    where  id = new.idempr
    ;
    select id
    into   Vidtidv
    from   tipos_doctos_ventas
    where  idpais      = Vidpais
    and    descripcion = 'NO DEFINIDO'
    ;
    select nextval('vent_seq')
    into   Vidvent
    ;
    select max(numero)
    into   Vnumero
    from   ventas
    where  idempr = new.idempr
    and    idtidv = Vidtidv
    ;
    if Vnumero is null then
      Vnumero := 1;
    else
      Vnumero := Vnumero + 1;
    end if;
    insert into ventas (id                       -- numeric(20,0)   not null
                       ,idempr                   -- numeric(20,0)   not null
                       ,idnove                   -- numeric(20,0)       null
                       ,idtidv                   -- numeric(20,0)   not null
                       ,numero                   -- numeric(20,0)   not null
                       ,idclie                   -- numeric(20,0)   not null
                       ,descripcionventa         -- varchar(1000)   not null
                       ,fechaventa               -- timestamp       not null
                       ,idgere                   -- numeric(20,0)       null
                       ,idproy                   -- numeric(20,0)       null
                       ,idline                   -- numeric(20,0)       null
                       ,idceco                   -- numeric(20,0)       null
                       ,idtare                   -- numeric(20,0)       null
                       ,exento                   -- numeric(20,0)   not null
                       ,afecto                   -- numeric(20,0)   not null
                       ,impuestos                -- numeric(20,0)   not null
                       ,porcentajedescuento      -- numeric(20,2)   not null
                       ,montodescuento           -- numeric(20,2)   not null
                       ,total                    -- numeric(20,0)   not null
                       ,idesve                   -- numeric(20,0)   not null
                       ,idusuacrearegistro       -- numeric(20,0)   not null
                       ,fechacrearegistro        -- timestamp       not null
                       ,idusuamodifregistro      -- numeric(20,0)       null
                       ,fechamodifregistro       -- timestamp           null
                       ,idusuaborraregistro      -- numeric(20,0)       null
                       ,fechaborraregistro       -- timestamp           null
                       )
    values (Vidvent                       -- id                       numeric(20,0)   not null
           ,new.idempr                    -- idempr                   numeric(20,0)   not null
           ,new.id                        -- idnove                   numeric(20,0)       null
           ,Vidtidv                       -- idtidv                   numeric(20,0)   not null
           ,Vnumero                       -- numero                   numeric(20,0)   not null
           ,new.idclie                    -- idclie                   numeric(20,0)   not null
           ,new.descripcionnotaventa      -- descripcionventa         varchar(1000)   not null
           ,current_timestamp             -- fechaventa               timestamp       not null
           ,new.idgere                    -- idgere                   numeric(20,0)       null
           ,new.idproy                    -- idproy                   numeric(20,0)       null
           ,new.idline                    -- idline                   numeric(20,0)       null
           ,new.idceco                    -- idceco                   numeric(20,0)       null
           ,new.idtare                    -- idtare                   numeric(20,0)       null
           ,new.exento                    -- exento                   numeric(20,0)   not null
           ,new.afecto                    -- afecto                   numeric(20,0)   not null
           ,new.impuestos                 -- impuestos                numeric(20,0)   not null
           ,new.porcentajedescuento       -- porcentajedescuento      numeric(20,2)   not null
           ,new.montodescuento            -- montodescuento           numeric(20,2)   not null
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
      fetch C_denv into Vcorrelativo
                       ,Vidprod
                       ,Vidserv
                       ,Vpreciounitario
                       ,Vcantidad
                       ,Vporcentajedescuento1
                       ,Vmontodescuento1
                       ,Vporcentajedescuento2
                       ,Vmontodescuento2
                       ,Vexento
                       ,Vafecto
                       ,Vimpuestos
                       ,Vtotallinea
                       ,Vidusuacrearegistro
                       ;
      exit when not found;
      select nextval('deve_seq')
      into   Viddeve
      ;
      insert into detalles_ventas (id                       -- numeric(20,0)   not null
                                  ,idvent                   -- numeric(20,0)   not null
                                  ,correlativo              -- numeric(20,0)   not null
                                  ,idprod                   -- numeric(20,0)       null
                                  ,idserv                   -- numeric(20,0)       null
                                  ,preciounitario           -- numeric(20,0)   not null
                                  ,cantidad                 -- numeric(20,2)   not null
                                  ,porcentajedescuento1     -- numeric(20,2)   not null
                                  ,montodescuento1          -- numeric(20,2)   not null
                                  ,porcentajedescuento2     -- numeric(20,2)   not null
                                  ,montodescuento2          -- numeric(20,2)   not null
                                  ,exento                   -- numeric(20,2)   not null
                                  ,afecto                   -- numeric(20,2)   not null
                                  ,impuestos                -- numeric(20,2)   not null
                                  ,totallinea               -- numeric(20,2)   not null
                                  ,idusuacrearegistro       -- numeric(20,0)   not null
                                  ,fechacrearegistro        -- timestamp       not null
                                  ,idusuamodifregistro      -- numeric(20,0)       null
                                  ,fechamodifregistro       -- timestamp           null
                                  ,idusuaborraregistro      -- numeric(20,0)       null
                                  ,fechaborraregistro       -- timestamp           null
                                  )
      values (Viddeve                              -- id                       numeric(20,0)   not null
             ,Vidvent                              -- idvent                   numeric(20,0)   not null
             ,Vcorrelativo                         -- correlativo              numeric(20,0)   not null
             ,Vidprod                              -- idprod                   numeric(20,0)       null
             ,Vidserv                              -- idserv                   numeric(20,0)       null
             ,Vpreciounitario                      -- preciounitario           numeric(20,0)   not null
             ,Vcantidad                            -- cantidad                 numeric(20,2)   not null
             ,Vporcentajedescuento1                -- porcentajedescuento1     numeric(20,2)   not null
             ,Vmontodescuento1                     -- montodescuento1          numeric(20,2)   not null
             ,Vporcentajedescuento2                -- porcentajedescuento2     numeric(20,2)   not null
             ,Vmontodescuento2                     -- montodescuento2          numeric(20,2)   not null
             ,Vexento                              -- exento                   numeric(20,2)   not null
             ,Vafecto                              -- afecto                   numeric(20,2)   not null
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
    close C_denv;
    open C_fpnv;
    loop
      fetch C_fpnv into Vidtifp
                       ,Vmonto
                       ,Vidusuacrearegistro
                       ;
      exit when not found;
      select nextval('fpve_seq')
      into   Vidfpve
      ;
      insert into formas_pagos_ventas (id                       -- numeric(20,0)   not null
                                      ,idvent                   -- numeric(20,0)   not null
                                      ,idtifp                   -- numeric(20,0)   not null
                                      ,monto                    -- numeric(20,0)       null
                                      ,idusuacrearegistro       -- numeric(20,0)   not null
                                      ,fechacrearegistro        -- timestamp       not null
                                      ,idusuamodifregistro      -- numeric(20,0)       null
                                      ,fechamodifregistro       -- timestamp           null
                                      ,idusuaborraregistro      -- numeric(20,0)       null
                                      ,fechaborraregistro       -- timestamp           null
                                      )
      values (Vidfpve                              -- id                       numeric(20,0)   not null
             ,Vidvent                              -- idvent                   numeric(20,0)   not null
             ,Vidtifp                              -- idtifp                   numeric(20,0)   not null
             ,Vmonto                               -- monto                    numeric(20,0)       null
             ,Vidusuacrearegistro                  -- idusuacrearegistro       numeric(20,0)   not null
             ,current_timestamp                    -- fechacrearegistro        timestamp       not null
             ,null                                 -- idusuamodifregistro      numeric(20,0)       null
             ,null                                 -- fechamodifregistro       timestamp           null
             ,null                                 -- idusuaborraregistro      numeric(20,0)       null
             ,null                                 -- fechaborraregistro       timestamp           null
             )
      ;
    end loop;
    close C_fpnv;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.f_copiar_nove_a_vent() OWNER TO admin;

--
-- Name: f_crear_datos_empresa(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_crear_datos_empresa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  Vidfapr int;
begin
  insert into bodegas values (nextval('bode_seq'), new.id, 'BODEGA CENTRAL', 1, current_timestamp, null, null, null, null);

  select nextval('fapr_seq')
  into   Vidfapr
  ;

  insert into familias_productos values (Vidfapr, new.id, '01', 'FAMILIA GENÉRICA', 1, current_timestamp, null, null, null, null);

  insert into sub_familias_productos values (nextval('sfpr_seq'), Vidfapr, '01', 'SUB FAMILIA GENÉRICA', 1, current_timestamp, null, null, null, null);

  return new;
end;
$$;


ALTER FUNCTION public.f_crear_datos_empresa() OWNER TO admin;

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

  insert into rubros values (nextval('rubr_seq'), new.id, 'OTRO'        );
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
-- Name: f_datos_producto(numeric, numeric); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_datos_producto(numeric, numeric) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare
  Pidprod                    numeric := $1;
  Pdato_deseado              numeric := $2;
  Vcod_familia               varchar(1000);
  Vcod_sub_familia           varchar(1000);
  Vunidad_medida_producto    varchar(1000);
  Vorigen_producto           varchar(1000);
  Vnombre_producto           varchar(1000);
  Vvalorunitario             numeric;
  Vporcentajedescuento       numeric;
  Vmontodescuento            numeric;
  Vidfapr                    numeric;
  Vidsfpr                    numeric;
begin
  /*

     Esta función retorna los sgtes. datos de un producto:

     Flag   Dato retornado
     ----   -----------------
       1    familia
       2    sub familia
       3    unidad de medida
       4    origen
       5    nombre
       6    precio
       7    descuento
       8    tipo descuento: P=porcentaje; M=monto

  */
  if    Pdato_deseado between 1 and 5 then
    select fapr.cod_familia
          ,sfpr.cod_sub_familia
          ,unmp.descripcioncorta
          ,orpr.descripcioncorta
          ,prod.nombre
    into   Vcod_familia
          ,Vcod_sub_familia
          ,Vunidad_medida_producto
          ,Vorigen_producto
          ,Vnombre_producto
    from   productos                  prod
          ,sub_familias_productos     sfpr
          ,familias_productos         fapr
          ,unidades_medidas_productos unmp
          ,origenes_productos         orpr
    where  prod.idsfpr = sfpr.id
    and    sfpr.idfapr = fapr.id
    and    prod.idunmp = unmp.id
    and    prod.idorpr = orpr.id
    and    prod.id     = Pidprod
    ;
    if    Pdato_deseado = 1 then
      return(Vcod_familia);
    elsif Pdato_deseado = 2 then
      return(Vcod_sub_familia);
    elsif Pdato_deseado = 3 then
      return(Vunidad_medida_producto);
    elsif Pdato_deseado = 4 then
      return(Vorigen_producto);
    elsif Pdato_deseado = 5 then
      return(Vnombre_producto);
    end if;
  elsif Pdato_deseado = 6 then
    select delp.valorunitario
    into   Vvalorunitario
    from   listas_precios          lipr
          ,detalles_listas_precios delp
    where  lipr.id     = delp.idlipr
    and    lipr.idesre = 1
    and    delp.idprod = Pidprod
    ;
    return(Vvalorunitario);
  elsif Pdato_deseado between 7 and 8 then
    select porcentajedescuento
          ,montodescuento
    into   Vporcentajedescuento
          ,Vmontodescuento
    from   descuentos
    where  idprod = Pidprod
    and    idesre = 1
    ;
    if Vporcentajedescuento is not null or Vmontodescuento is not null then
      if Vporcentajedescuento is not null then
        if Pdato_deseado = 7 then
          return(Vporcentajedescuento);
        else
          return('P');
        end if;
      else
        if Pdato_deseado = 7 then
          return(Vmontodescuento);
        else
          return('M');
        end if;
      end if;
    else
      select sfpr.idfapr
            ,sfpr.id
      into   Vidfapr
            ,Vidsfpr
      from   productos              prod
            ,sub_familias_productos sfpr
      where  prod.idsfpr = sfpr.id
      and    prod.id     = Pidprod
      ;
      select porcentajedescuento
            ,montodescuento
      into   Vporcentajedescuento
            ,Vmontodescuento
      from   descuentos
      where  idsfpr = Vidsfpr
      and    idesre = 1
      ;
      if Vporcentajedescuento is not null or Vmontodescuento is not null then
        if Vporcentajedescuento is not null then
          if Pdato_deseado = 7 then
            return(Vporcentajedescuento);
          else
            return('P');
          end if;
        else
          if Pdato_deseado = 7 then
            return(Vmontodescuento);
          else
            return('M');
          end if;
        end if;
      else
        select porcentajedescuento
              ,montodescuento
        into   Vporcentajedescuento
              ,Vmontodescuento
        from   descuentos
        where  idfapr = Vidfapr
        and    idesre = 1
        ;
        if Vporcentajedescuento is not null or Vmontodescuento is not null then
          if Vporcentajedescuento is not null then
            if Pdato_deseado = 7 then
              return(Vporcentajedescuento);
            else
              return('P');
            end if;
          else
            if Pdato_deseado = 7 then
              return(Vmontodescuento);
            else
              return('M');
            end if;
          end if;
        else
          return('');
        end if;
      end if;
    end if;
  else
    return('-----');
  end if;
end;
$_$;


ALTER FUNCTION public.f_datos_producto(numeric, numeric) OWNER TO admin;

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
and table_name in ('listas_precios', 'detalles_listas_precios', 'familias_productos', 'sub_familias_productos', 'descuentos', 'bodegas', 'bodegas_productos')
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
    and    column_name  not in ('idusuacrearegistro', 'fechacrearegistro'  , 'idusuamodifregistro'
                               ,'fechamodifregistro', 'idusuaborraregistro', 'fechaborraregistro'
                               ,'xfld'
                               )
    order  by 1
    ;
begin
--  delete from field_defs;
--  delete from form_defs;
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
-- Name: f_stock_producto(numeric, numeric); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_stock_producto(numeric, numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
declare
  Pidprod          numeric := $1;
  Pdato_deseado    numeric := $2;
  aux              numeric;
  Vstock           numeric;
  Vreservado_nove  numeric;
  Vreservado_vent  numeric;
begin


return(10);


  /*
     Esta función retorna el stock de un producto, siendo el stock el

       a) disponible físicamente
       b) disponible para venta
       c) "reservado" (por una nota de venta o una venta)

     Explicación:
     Supóngase que se tiene físicamente 100 unidades de un producto. Eso es lo que tengo realmente.
     Pero hay una nota de venta CREADA o EMITIDA que está haciendo referencia a este producto, por ej., 5 unidades
     Entonces no tengo 100 unidades disponibles para venta, sólo tego 95, porque 5 están "comprometidas" en esa
     nota de venta
     Íden con ventas en estado CREADA
     Una venta que pasa a CERRADA rebaja inmediatamente del stock

     Entonces, respecto de este producto se podría pedir:

       1) disponible físicamente                       : 100
       2) disponible para venta                        : 95
       3) reservado (por una nota de venta o una venta): 5
  */
  if Pidprod is null or Pdato_deseado is null then
    return(0);
  end if;
  if Pdato_deseado not in (1, 2, 3) then
    return(0);
  end if;
  select count(*)
  into   aux
  from   productos
  where  id = Pidprod
  ;
  if aux = 0 then
    return(0);
  end if;
  select stock
  into   Vstock
  from   productos
  where  id = Pidprod
  ;
  if Pdato_deseado = 1 then
    return(Vstock);
  end if;
  select sum(denv.cantidad)
  into   Vreservado_nove
  from   notas_ventas        nove
        ,detalles_notas_vtas denv
  where  nove.id     = denv.idnove
  and    nove.idesnv in (1, 2)
  and    denv.idprod = Pidprod
  ;
  if Vreservado_nove is null then
    Vreservado_nove := 0;
  end if;
  select sum(deve.cantidad)
  into   Vreservado_vent
  from   ventas          vent
        ,detalles_ventas deve
  where  vent.id     = deve.idvent
  and    vent.idesve = 1
  and    deve.idprod = Pidprod
  ;
  if Vreservado_vent is null then
    Vreservado_vent := 0;
  end if;
  if Pdato_deseado = 2 then
    return(Vstock - (Vreservado_nove + Vreservado_vent));
  else
    return(Vreservado_nove + Vreservado_vent);
  end if;
end;
$_$;


ALTER FUNCTION public.f_stock_producto(numeric, numeric) OWNER TO admin;

--
-- Name: f_stock_producto(numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_stock_producto(numeric, numeric, numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
declare
  Pidprod          numeric := $1;
  Pidbode          numeric := $3;
  Pdato_deseado    numeric := $2;
  aux              numeric;
  Vstock           numeric;
  Vreservado_nove  numeric;
  Vreservado_vent  numeric;
begin


return(10);


  /*
     Esta función retorna el stock de un producto, siendo el stock el

       a) disponible físicamente
       b) disponible para venta
       c) "reservado" (por una nota de venta o una venta)

     Explicación:
     Supóngase que se tiene físicamente 100 unidades de un producto. Eso es lo que tengo realmente.
     Pero hay una nota de venta CREADA o EMITIDA que está haciendo referencia a este producto, por ej., 5 unidades
     Entonces no tengo 100 unidades disponibles para venta, sólo tego 95, porque 5 están "comprometidas" en esa
     nota de venta
     Íden con ventas en estado CREADA
     Una venta que pasa a CERRADA rebaja inmediatamente del stock

     Entonces, respecto de este producto se podría pedir:

       1) disponible físicamente                       : 100
       2) disponible para venta                        : 95
       3) reservado (por una nota de venta o una venta): 5

     Nota: más adelante habrá que incluir solicitudes de traspaso entre bodegas, esto es, si hay una solicitud de
           traspaso entre bodegas creada o cerrada, entonces los prpductos involucrados en esa solicitud están
           "reservados". Se deberían sumar al caso c) antes señalado

  */
  if Pidprod is null or Pdato_deseado is null then
    return(0);
  end if;
  if Pdato_deseado not in (1, 2, 3) then
    return(0);
  end if;
  select count(*)
  into   aux
  from   productos
  where  id = Pidprod
  ;
  if aux = 0 then
    return(0);
  end if;
  select stock
  into   Vstock
  from   productos
  where  id = Pidprod
  ;
  if Pdato_deseado = 1 then
    return(Vstock);
  end if;
  select sum(denv.cantidad)
  into   Vreservado_nove
  from   notas_ventas        nove
        ,detalles_notas_vtas denv
  where  nove.id     = denv.idnove
  and    nove.idesnv in (1, 2)
  and    denv.idprod = Pidprod
  ;
  if Vreservado_nove is null then
    Vreservado_nove := 0;
  end if;
  select sum(deve.cantidad)
  into   Vreservado_vent
  from   ventas          vent
        ,detalles_ventas deve
  where  vent.id     = deve.idvent
  and    vent.idesve = 1
  and    deve.idprod = Pidprod
  ;
  if Vreservado_vent is null then
    Vreservado_vent := 0;
  end if;
  if Pdato_deseado = 2 then
    return(Vstock - (Vreservado_nove + Vreservado_vent));
  else
    return(Vreservado_nove + Vreservado_vent);
  end if;
end;
$_$;


ALTER FUNCTION public.f_stock_producto(numeric, numeric, numeric) OWNER TO admin;

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
  if new.idesve != 1 then
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

--
-- Name: f_validar_vent(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_validar_vent() RETURNS trigger
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


ALTER FUNCTION public.f_validar_vent() OWNER TO admin;

--
-- Name: f_validar_vent_ins(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_validar_vent_ins() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  Vmensaje varchar(1000);
begin
  if new.idesve != 1 then
    Vmensaje := 'Un nuevo documento de venta solo puede tener estado 1';
    raise exception 'Estado para nuevo documento de venta inválido'
    using hint = Vmensaje;
  end if;
  return new;
end;
$$;


ALTER FUNCTION public.f_validar_vent_ins() OWNER TO admin;

--
-- Name: f_valor_linea_det_vta(character varying); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_valor_linea_det_vta(character varying) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
declare
  Pidprod numeric := $1;
begin
/*
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
*/
  return(Pidprofd);
end;
$_$;


ALTER FUNCTION public.f_valor_linea_det_vta(character varying) OWNER TO admin;

--
-- Name: f_valor_linea_det_vta(numeric); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_valor_linea_det_vta(numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
declare
  Pidprod numeric := $1;
begin
/*
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
*/
  return(Pidprod);
end;
$_$;


ALTER FUNCTION public.f_valor_linea_det_vta(numeric) OWNER TO admin;

--
-- Name: f_valor_linea_det_vta(numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_valor_linea_det_vta(numeric, numeric, numeric, numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
declare
  Pidprod          numeric := $1;
  Pidserv          numeric := $2;
  Pcantidad        numeric := $3;
  Pmonto_dscto     numeric := $4;
  Vidpais          numeric;
  Vtotal_linea     numeric;
  aux              numeric;
  Vvalorunitario   numeric;
  Vidtipr          numeric;
  Vestaexento      char(1);
  Vsub_total       numeric;
  Vvalor_impuesto  numeric;
  Vimpuesto        numeric;
  C_impuestos cursor for
    select valor
    from   impuestos
    where  idpais      = Pidpais
    and    obligatorio = 'S'
    and    Vestaexento = 'N'
    union
    select impu.valor
    from   tipos_productos_impuestos tipi
          ,impuestos                 impu
    where  tipi.idimpu      = impu.id
    and    tipi.idtipr      = Vidtipr
    and    impu.obligatorio = 'N'
    and    impu.idpais      = Pidpais
    ;
begin
  /* esta función debe ser invocada con Pidpais, (Pidprod o Pidserv), solo uno de los 2, y con Pcantidad y Pmonto_dscto (el cual puede ser 0) */
  if Pidpais is null or (Pidprod is null and Pidserv is null) or Pcantidad is null or Pmonto_dscto is null then
    return(0);
  end if;
  if Pidprod is not null and Pidserv is not null then
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
    select estaexento
    into   Vestaexento
    from   tipos_productos
    where  id = Vidtipr
    ;
    Vsub_total   := Pcantidad*Vvalorunitario - Pmonto_dscto;
    Vtotal_linea := Vsub_total;
    open C_impuestos;
    loop
      fetch C_impuestos into Vvalor_impuesto;
      exit when not found;
      Vimpuesto    := round((Vsub_total * Vvalor_impuesto) / 100);
      Vtotal_linea := Vtotal_linea + Vimpuesto;
    end loop;
    close C_impuestos;
  else
Vtotal_linea:=0;
  end if;
  return(Vtotal_linea);
end;
$_$;


ALTER FUNCTION public.f_valor_linea_det_vta(numeric, numeric, numeric, numeric) OWNER TO admin;

--
-- Name: f_valor_linea_det_vta(numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION f_valor_linea_det_vta(numeric, numeric, numeric, numeric, numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
declare
  Pidpais          numeric := $1;
  Pidprod          numeric := $2;
  Pidserv          numeric := $3;
  Pcantidad        numeric := $4;
  Pmonto_dscto     numeric := $5;
  Vtotal_linea     numeric;
  aux              numeric;
  Vvalorunitario   numeric;
  Vidtipr          numeric;
  Vestaexento      char(1);
  Vsub_total       numeric;
  Vvalor_impuesto  numeric;
  Vimpuesto        numeric;
  C_impuestos cursor for
    select valor
    from   impuestos
    where  idpais      = Pidpais
    and    obligatorio = 'S'
    and    Vestaexento = 'N'
    union
    select impu.valor
    from   tipos_productos_impuestos tipi
          ,impuestos                 impu
    where  tipi.idimpu      = impu.id
    and    tipi.idtipr      = Vidtipr
    and    impu.obligatorio = 'N'
    and    impu.idpais      = Pidpais
    ;
begin
  /* esta función debe ser invocada con Pidpais, (Pidprod o Pidserv), solo uno de los 2, y con Pcantidad y Pmonto_dscto (el cual puede ser 0) */
  if Pidpais is null or (Pidprod is null and Pidserv is null) or Pcantidad is null or Pmonto_dscto is null then
    return(0);
  end if;
  if Pidprod is not null and Pidserv is not null then
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
    select estaexento
    into   Vestaexento
    from   tipos_productos
    where  id = Vidtipr
    ;
    Vsub_total   := Pcantidad*Vvalorunitario - Pmonto_dscto;
    Vtotal_linea := Vsub_total;
    open C_impuestos;
    loop
      fetch C_impuestos into Vvalor_impuesto;
      exit when not found;
      Vimpuesto    := round((Vsub_total * Vvalor_impuesto) / 100);
      Vtotal_linea := Vtotal_linea + Vimpuesto;
    end loop;
    close C_impuestos;
  else
Vtotal_linea:=0;
  end if;
  return(Vtotal_linea);
end;
$_$;


ALTER FUNCTION public.f_valor_linea_det_vta(numeric, numeric, numeric, numeric, numeric) OWNER TO admin;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bitacoras_cambios_precios; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE bitacoras_cambios_precios (
    id numeric(20,0) NOT NULL,
    idprod numeric(20,0) NOT NULL,
    preciounitario numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL
);


ALTER TABLE public.bitacoras_cambios_precios OWNER TO admin;

--
-- Name: bicp; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW bicp AS
    SELECT bitacoras_cambios_precios.id, bitacoras_cambios_precios.idprod, bitacoras_cambios_precios.preciounitario, bitacoras_cambios_precios.idusuacrearegistro, bitacoras_cambios_precios.fechacrearegistro FROM bitacoras_cambios_precios;


ALTER TABLE public.bicp OWNER TO admin;

--
-- Name: bicp_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE bicp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bicp_seq OWNER TO admin;

--
-- Name: bodegas; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE bodegas (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    nombre character varying(1000) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.bodegas OWNER TO admin;

--
-- Name: bode; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW bode AS
    SELECT bodegas.id, bodegas.idempr, bodegas.nombre, bodegas.idusuacrearegistro, bodegas.fechacrearegistro, bodegas.idusuamodifregistro, bodegas.fechamodifregistro, bodegas.idusuaborraregistro, bodegas.fechaborraregistro FROM bodegas;


ALTER TABLE public.bode OWNER TO admin;

--
-- Name: bode_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE bode_seq
    START WITH 12
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bode_seq OWNER TO admin;

--
-- Name: bodegas_productos; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE bodegas_productos (
    id numeric(20,0) NOT NULL,
    idbode numeric(20,0) NOT NULL,
    idprod numeric(20,0) NOT NULL,
    stock numeric(20,2) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.bodegas_productos OWNER TO admin;

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
-- Name: bodev; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW bodev AS
    SELECT bode.id, bode.idempr, empr.nombrefantasia AS empresa, bode.nombre AS bodega FROM (bodegas bode LEFT JOIN empresas empr ON ((bode.idempr = empr.id))) WHERE (bode.idusuaborraregistro IS NULL);


ALTER TABLE public.bodev OWNER TO admin;

--
-- Name: bopr; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW bopr AS
    SELECT bodegas_productos.id, bodegas_productos.idbode, bodegas_productos.idprod, bodegas_productos.stock, bodegas_productos.idusuacrearegistro, bodegas_productos.fechacrearegistro, bodegas_productos.idusuamodifregistro, bodegas_productos.fechamodifregistro, bodegas_productos.idusuaborraregistro, bodegas_productos.fechaborraregistro FROM bodegas_productos;


ALTER TABLE public.bopr OWNER TO admin;

--
-- Name: bopr_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE bopr_seq
    START WITH 18
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bopr_seq OWNER TO admin;

--
-- Name: productos; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE productos (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    idsfpr numeric(20,0) NOT NULL,
    idtipr numeric(20,0) NOT NULL,
    idunmp numeric(20,0) NOT NULL,
    idorpr numeric(20,0) NOT NULL,
    nombre character varying(1000) NOT NULL,
    correlativoflia character varying(4) NOT NULL,
    sku character varying(1000),
    ean13 character varying(1000),
    qr character varying(1000),
    pesounitariokg numeric(20,2) NOT NULL,
    idesre numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.productos OWNER TO admin;

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
-- Name: boprv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW boprv AS
    SELECT bopr.id, bode.idempr, empr.nombrefantasia AS empresa, bopr.idbode, bode.nombre AS bodega, bopr.idprod, prod.nombre AS producto, bopr.stock, prod.idunmp, unmp.descripcioncorta AS unidad_medida FROM ((((bodegas_productos bopr LEFT JOIN bodegas bode ON ((bopr.idbode = bode.id))) LEFT JOIN empresas empr ON ((bode.idempr = empr.id))) LEFT JOIN productos prod ON ((bopr.idprod = prod.id))) LEFT JOIN unidades_medidas_productos unmp ON ((prod.idunmp = unmp.id))) WHERE (bopr.idusuaborraregistro IS NULL);


ALTER TABLE public.boprv OWNER TO admin;

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
    fechacotizacion timestamp without time zone NOT NULL,
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
    SELECT cotizaciones_ventas.id, cotizaciones_ventas.idempr, cotizaciones_ventas.numero, cotizaciones_ventas.idclie, cotizaciones_ventas.descripcioncotizacion, cotizaciones_ventas.fechacotizacion, cotizaciones_ventas.idgere, cotizaciones_ventas.idproy, cotizaciones_ventas.idline, cotizaciones_ventas.idceco, cotizaciones_ventas.idtare, cotizaciones_ventas.exento, cotizaciones_ventas.afecto, cotizaciones_ventas.impuestos, cotizaciones_ventas.porcentajedescuento, cotizaciones_ventas.montodescuento, cotizaciones_ventas.total, cotizaciones_ventas.diasvalidez, cotizaciones_ventas.idescv, cotizaciones_ventas.idusuacrearegistro, cotizaciones_ventas.fechacrearegistro, cotizaciones_ventas.idusuamodifregistro, cotizaciones_ventas.fechamodifregistro, cotizaciones_ventas.idusuaborraregistro, cotizaciones_ventas.fechaborraregistro FROM cotizaciones_ventas;


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
-- Name: estados_cotizaciones_vtas; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE estados_cotizaciones_vtas (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_cotizaciones_vtas OWNER TO admin;

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
-- Name: covev; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW covev AS
    SELECT cove.id, cove.idempr, empr.nombrefantasia AS empresa, cove.numero AS numero_cotiz, cove.idclie, (((((COALESCE(clie.nombrefantasia, ' '::character varying))::text || ' '::text) || (COALESCE(clie.primernombre, ' '::character varying))::text) || ' '::text) || (COALESCE(clie.apellidopaterno, ' '::character varying))::text) AS cliente, cove.descripcioncotizacion AS desc_cotiz, cove.idgere, gere.nombre AS gerencia, cove.idproy, proy.nombre AS proyecto, cove.idline, line.nombre AS linea_negocio, cove.idceco, ceco.nombre AS centro_costo, cove.idtare, tare.nombre AS tarea, cove.exento, cove.afecto, cove.impuestos, cove.porcentajedescuento, cove.montodescuento, cove.total, cove.diasvalidez, cove.idescv, escv.descripcion AS estado_cotiz FROM ((((((((cotizaciones_ventas cove LEFT JOIN empresas empr ON ((cove.idempr = empr.id))) LEFT JOIN clientes clie ON ((cove.idclie = clie.id))) LEFT JOIN gerencias gere ON ((cove.idgere = gere.id))) LEFT JOIN proyectos proy ON ((cove.idproy = proy.id))) LEFT JOIN lineas_negocios line ON ((cove.idline = line.id))) LEFT JOIN centros_costos ceco ON ((cove.idceco = ceco.id))) LEFT JOIN tareas tare ON ((cove.idtare = tare.id))) LEFT JOIN estados_cotizaciones_vtas escv ON ((cove.idescv = escv.id))) WHERE (cove.idusuaborraregistro IS NULL);


ALTER TABLE public.covev OWNER TO admin;

--
-- Name: cpalma; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE cpalma (
    a numeric,
    b character varying(1000)
);


ALTER TABLE public.cpalma OWNER TO admin;

--
-- Name: cpalma_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE cpalma_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cpalma_seq OWNER TO admin;

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
    porcentajedescuento1 numeric(20,5) NOT NULL,
    montodescuento1 numeric(20,0) NOT NULL,
    porcentajedescuento2 numeric(20,5) NOT NULL,
    montodescuento2 numeric(20,0) NOT NULL,
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
    SELECT detalles_cotizs_vtas.id, detalles_cotizs_vtas.idcove, detalles_cotizs_vtas.correlativo, detalles_cotizs_vtas.idprod, detalles_cotizs_vtas.idserv, detalles_cotizs_vtas.preciounitario, detalles_cotizs_vtas.cantidad, detalles_cotizs_vtas.porcentajedescuento1, detalles_cotizs_vtas.montodescuento1, detalles_cotizs_vtas.porcentajedescuento2, detalles_cotizs_vtas.montodescuento2, detalles_cotizs_vtas.exento, detalles_cotizs_vtas.afecto, detalles_cotizs_vtas.impuestos, detalles_cotizs_vtas.totallinea, detalles_cotizs_vtas.idusuacrearegistro, detalles_cotizs_vtas.fechacrearegistro, detalles_cotizs_vtas.idusuamodifregistro, detalles_cotizs_vtas.fechamodifregistro, detalles_cotizs_vtas.idusuaborraregistro, detalles_cotizs_vtas.fechaborraregistro FROM detalles_cotizs_vtas;


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
    idvent numeric(20,0) NOT NULL,
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
    SELECT detalles_doctos_vtas.id, detalles_doctos_vtas.idvent, detalles_doctos_vtas.correlativo, detalles_doctos_vtas.idprod, detalles_doctos_vtas.idserv, detalles_doctos_vtas.preciounitario, detalles_doctos_vtas.cantidad, detalles_doctos_vtas.porcentajedescuento, detalles_doctos_vtas.montodescuento, detalles_doctos_vtas.exento, detalles_doctos_vtas.afecto, detalles_doctos_vtas.impuestos, detalles_doctos_vtas.totallinea, detalles_doctos_vtas.idusuacrearegistro, detalles_doctos_vtas.fechacrearegistro, detalles_doctos_vtas.idusuamodifregistro, detalles_doctos_vtas.fechamodifregistro, detalles_doctos_vtas.idusuaborraregistro, detalles_doctos_vtas.fechaborraregistro FROM detalles_doctos_vtas;


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
-- Name: detalles_listas_precios; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE detalles_listas_precios (
    id numeric(20,0) NOT NULL,
    idlipr numeric(20,0) NOT NULL,
    idprod numeric(20,0) NOT NULL,
    valorunitario numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.detalles_listas_precios OWNER TO admin;

--
-- Name: delp; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW delp AS
    SELECT detalles_listas_precios.id, detalles_listas_precios.idlipr, detalles_listas_precios.idprod, detalles_listas_precios.valorunitario, detalles_listas_precios.idusuacrearegistro, detalles_listas_precios.fechacrearegistro, detalles_listas_precios.idusuamodifregistro, detalles_listas_precios.fechamodifregistro, detalles_listas_precios.idusuaborraregistro, detalles_listas_precios.fechaborraregistro FROM detalles_listas_precios;


ALTER TABLE public.delp OWNER TO admin;

--
-- Name: delp_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE delp_seq
    START WITH 35
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delp_seq OWNER TO admin;

--
-- Name: listas_precios; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE listas_precios (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    correlativo numeric(20,0) NOT NULL,
    fechainicio date NOT NULL,
    fechafin date,
    observaciones character varying(1000) NOT NULL,
    idesre numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone,
    CONSTRAINT lipr_chk_01 CHECK ((((idesre = (1)::numeric) AND (fechafin IS NULL)) OR ((idesre = (2)::numeric) AND (fechafin IS NOT NULL))))
);


ALTER TABLE public.listas_precios OWNER TO admin;

--
-- Name: delpv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW delpv AS
    SELECT delp.id, delp.idlipr, ((lipr.correlativo || ' - '::text) || (lipr.observaciones)::text) AS lista_precio, lipr.idempr, empr.nombrefantasia AS empresa, delp.idprod, prod.nombre AS producto, delp.valorunitario FROM (((detalles_listas_precios delp LEFT JOIN listas_precios lipr ON ((delp.idlipr = lipr.id))) LEFT JOIN empresas empr ON ((lipr.idempr = empr.id))) LEFT JOIN productos prod ON ((delp.idprod = prod.id))) WHERE (delp.idusuaborraregistro IS NULL);


ALTER TABLE public.delpv OWNER TO admin;

--
-- Name: detalles_movtos_bodegas; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE detalles_movtos_bodegas (
    id numeric(20,0) NOT NULL,
    idmobo numeric(20,0) NOT NULL,
    correlativo numeric(20,0) NOT NULL,
    idprod numeric(20,0) NOT NULL,
    cantidad numeric(20,0) NOT NULL,
    idunmp numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.detalles_movtos_bodegas OWNER TO admin;

--
-- Name: demb; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW demb AS
    SELECT detalles_movtos_bodegas.id, detalles_movtos_bodegas.idmobo, detalles_movtos_bodegas.correlativo, detalles_movtos_bodegas.idprod, detalles_movtos_bodegas.cantidad, detalles_movtos_bodegas.idunmp, detalles_movtos_bodegas.idusuacrearegistro, detalles_movtos_bodegas.fechacrearegistro, detalles_movtos_bodegas.idusuamodifregistro, detalles_movtos_bodegas.fechamodifregistro, detalles_movtos_bodegas.idusuaborraregistro, detalles_movtos_bodegas.fechaborraregistro FROM detalles_movtos_bodegas;


ALTER TABLE public.demb OWNER TO admin;

--
-- Name: demb_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE demb_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demb_seq OWNER TO admin;

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
    porcentajedescuento1 numeric(20,5) NOT NULL,
    montodescuento1 numeric(20,0) NOT NULL,
    porcentajedescuento2 numeric(20,5) NOT NULL,
    montodescuento2 numeric(20,0) NOT NULL,
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
    SELECT detalles_notas_vtas.id, detalles_notas_vtas.idnove, detalles_notas_vtas.correlativo, detalles_notas_vtas.idprod, detalles_notas_vtas.idserv, detalles_notas_vtas.preciounitario, detalles_notas_vtas.cantidad, detalles_notas_vtas.porcentajedescuento1, detalles_notas_vtas.montodescuento1, detalles_notas_vtas.porcentajedescuento2, detalles_notas_vtas.montodescuento2, detalles_notas_vtas.exento, detalles_notas_vtas.afecto, detalles_notas_vtas.impuestos, detalles_notas_vtas.totallinea, detalles_notas_vtas.idusuacrearegistro, detalles_notas_vtas.fechacrearegistro, detalles_notas_vtas.idusuamodifregistro, detalles_notas_vtas.fechamodifregistro, detalles_notas_vtas.idusuaborraregistro, detalles_notas_vtas.fechaborraregistro FROM detalles_notas_vtas;


ALTER TABLE public.denv OWNER TO admin;

--
-- Name: denv_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE denv_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.denv_seq OWNER TO admin;

--
-- Name: desc_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE desc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.desc_seq OWNER TO admin;

--
-- Name: descuentos; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE descuentos (
    id numeric(20,0) NOT NULL,
    idfapr numeric(20,0),
    idsfpr numeric(20,0),
    idprod numeric(20,0),
    porcentajedescuento numeric(20,5),
    montodescuento numeric(20,0),
    idesre numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone,
    CONSTRAINT desu_chk_01 CHECK ((((((idfapr IS NOT NULL) AND (idsfpr IS NULL)) AND (idprod IS NULL)) OR (((idfapr IS NULL) AND (idsfpr IS NOT NULL)) AND (idprod IS NULL))) OR (((idfapr IS NULL) AND (idsfpr IS NULL)) AND (idprod IS NOT NULL)))),
    CONSTRAINT desu_chk_02 CHECK ((((porcentajedescuento IS NOT NULL) AND (montodescuento IS NULL)) OR ((porcentajedescuento IS NULL) AND (montodescuento IS NOT NULL))))
);


ALTER TABLE public.descuentos OWNER TO admin;

--
-- Name: desu; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW desu AS
    SELECT descuentos.id, descuentos.idfapr, descuentos.idsfpr, descuentos.idprod, descuentos.porcentajedescuento, descuentos.montodescuento, descuentos.idesre, descuentos.idusuacrearegistro, descuentos.fechacrearegistro, descuentos.idusuamodifregistro, descuentos.fechamodifregistro, descuentos.idusuaborraregistro, descuentos.fechaborraregistro FROM descuentos;


ALTER TABLE public.desu OWNER TO admin;

--
-- Name: desu_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE desu_seq
    START WITH 8
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.desu_seq OWNER TO admin;

--
-- Name: estados_registros; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE estados_registros (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.estados_registros OWNER TO admin;

--
-- Name: familias_productos; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE familias_productos (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    cod_familia character varying(2) NOT NULL,
    descripcion character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.familias_productos OWNER TO admin;

--
-- Name: sub_familias_productos; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE sub_familias_productos (
    id numeric(20,0) NOT NULL,
    idfapr numeric(20,0) NOT NULL,
    cod_sub_familia character varying(2) NOT NULL,
    descripcion character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.sub_familias_productos OWNER TO admin;

--
-- Name: desuv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW desuv AS
    SELECT desu.id, desu.idfapr, fapr.cod_familia, fapr.descripcion AS familia, desu.idsfpr, ((fapr2.cod_familia)::text || (sfpr.cod_sub_familia)::text) AS cod_sub_familia, (((fapr2.descripcion)::text || ' - '::text) || (sfpr.descripcion)::text) AS sub_familia, desu.idprod, prod.nombre AS producto, desu.porcentajedescuento, desu.montodescuento, desu.idesre, esre.descripcion AS estado_regsitro FROM ((((((descuentos desu LEFT JOIN familias_productos fapr ON ((desu.idfapr = fapr.id))) LEFT JOIN sub_familias_productos sfpr ON ((desu.idsfpr = sfpr.id))) LEFT JOIN familias_productos fapr2 ON ((sfpr.idfapr = fapr2.id))) LEFT JOIN empresas empr ON ((fapr.idempr = empr.id))) LEFT JOIN productos prod ON ((desu.idprod = prod.id))) LEFT JOIN estados_registros esre ON ((desu.idesre = esre.id))) WHERE (desu.idusuaborraregistro IS NULL);


ALTER TABLE public.desuv OWNER TO admin;

--
-- Name: detalles_ventas; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE detalles_ventas (
    id numeric(20,0) NOT NULL,
    idvent numeric(20,0) NOT NULL,
    correlativo numeric(20,0) NOT NULL,
    idprod numeric(20,0),
    idserv numeric(20,0),
    preciounitario numeric(20,0) NOT NULL,
    cantidad numeric(20,2) NOT NULL,
    porcentajedescuento1 numeric(20,5) NOT NULL,
    montodescuento1 numeric(20,0) NOT NULL,
    porcentajedescuento2 numeric(20,5) NOT NULL,
    montodescuento2 numeric(20,0) NOT NULL,
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
    CONSTRAINT deve_chk_01 CHECK ((((idprod IS NOT NULL) AND (idserv IS NULL)) OR ((idprod IS NULL) AND (idserv IS NOT NULL))))
);


ALTER TABLE public.detalles_ventas OWNER TO admin;

--
-- Name: deve; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW deve AS
    SELECT detalles_ventas.id, detalles_ventas.idvent, detalles_ventas.correlativo, detalles_ventas.idprod, detalles_ventas.idserv, detalles_ventas.preciounitario, detalles_ventas.cantidad, detalles_ventas.porcentajedescuento1, detalles_ventas.montodescuento1, detalles_ventas.porcentajedescuento2, detalles_ventas.montodescuento2, detalles_ventas.exento, detalles_ventas.afecto, detalles_ventas.impuestos, detalles_ventas.totallinea, detalles_ventas.idusuacrearegistro, detalles_ventas.fechacrearegistro, detalles_ventas.idusuamodifregistro, detalles_ventas.fechamodifregistro, detalles_ventas.idusuaborraregistro, detalles_ventas.fechaborraregistro FROM detalles_ventas;


ALTER TABLE public.deve OWNER TO admin;

--
-- Name: deve_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE deve_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deve_seq OWNER TO admin;

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
-- Name: fapr; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW fapr AS
    SELECT familias_productos.id, familias_productos.idempr, familias_productos.cod_familia, familias_productos.descripcion, familias_productos.idusuacrearegistro, familias_productos.fechacrearegistro, familias_productos.idusuamodifregistro, familias_productos.fechamodifregistro, familias_productos.idusuaborraregistro, familias_productos.fechaborraregistro FROM familias_productos;


ALTER TABLE public.fapr OWNER TO admin;

--
-- Name: fapr_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE fapr_seq
    START WITH 12
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fapr_seq OWNER TO admin;

--
-- Name: faprv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW faprv AS
    SELECT fapr.id, fapr.idempr, empr.nombrefantasia AS empresa, fapr.cod_familia, fapr.descripcion FROM (familias_productos fapr LEFT JOIN empresas empr ON ((fapr.idempr = empr.id))) WHERE (fapr.idusuaborraregistro IS NULL);


ALTER TABLE public.faprv OWNER TO admin;

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
-- Name: fopv_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE fopv_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fopv_seq OWNER TO admin;

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
-- Name: formas_pagos_notas_ventas; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE formas_pagos_notas_ventas (
    id numeric(20,0) NOT NULL,
    idnove numeric(20,0) NOT NULL,
    idtifp numeric(20,0) NOT NULL,
    monto numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.formas_pagos_notas_ventas OWNER TO admin;

--
-- Name: formas_pagos_ventas; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE formas_pagos_ventas (
    id numeric(20,0) NOT NULL,
    idvent numeric(20,0) NOT NULL,
    idtifp numeric(20,0) NOT NULL,
    monto numeric(20,0) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.formas_pagos_ventas OWNER TO admin;

--
-- Name: fpnv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW fpnv AS
    SELECT formas_pagos_notas_ventas.id, formas_pagos_notas_ventas.idnove, formas_pagos_notas_ventas.idtifp, formas_pagos_notas_ventas.monto, formas_pagos_notas_ventas.idusuacrearegistro, formas_pagos_notas_ventas.fechacrearegistro, formas_pagos_notas_ventas.idusuamodifregistro, formas_pagos_notas_ventas.fechamodifregistro, formas_pagos_notas_ventas.idusuaborraregistro, formas_pagos_notas_ventas.fechaborraregistro FROM formas_pagos_notas_ventas;


ALTER TABLE public.fpnv OWNER TO admin;

--
-- Name: fpnv_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE fpnv_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fpnv_seq OWNER TO admin;

--
-- Name: fpve; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW fpve AS
    SELECT formas_pagos_ventas.id, formas_pagos_ventas.idvent, formas_pagos_ventas.idtifp, formas_pagos_ventas.monto, formas_pagos_ventas.idusuacrearegistro, formas_pagos_ventas.fechacrearegistro, formas_pagos_ventas.idusuamodifregistro, formas_pagos_ventas.fechamodifregistro, formas_pagos_ventas.idusuaborraregistro, formas_pagos_ventas.fechaborraregistro FROM formas_pagos_ventas;


ALTER TABLE public.fpve OWNER TO admin;

--
-- Name: fpve_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE fpve_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fpve_seq OWNER TO admin;

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
-- Name: lipr; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW lipr AS
    SELECT listas_precios.id, listas_precios.idempr, listas_precios.correlativo, listas_precios.fechainicio, listas_precios.fechafin, listas_precios.observaciones, listas_precios.idesre, listas_precios.idusuacrearegistro, listas_precios.fechacrearegistro, listas_precios.idusuamodifregistro, listas_precios.fechamodifregistro, listas_precios.idusuaborraregistro, listas_precios.fechaborraregistro FROM listas_precios;


ALTER TABLE public.lipr OWNER TO admin;

--
-- Name: lipr_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE lipr_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lipr_seq OWNER TO admin;

--
-- Name: liprv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW liprv AS
    SELECT lipr.id, lipr.idempr, empr.nombrefantasia AS empresa, lipr.correlativo, lipr.fechainicio, lipr.fechafin, lipr.observaciones, lipr.idesre, esre.descripcion AS estado_regsitro FROM ((listas_precios lipr LEFT JOIN empresas empr ON ((lipr.idempr = empr.id))) LEFT JOIN estados_registros esre ON ((lipr.idesre = esre.id))) WHERE (lipr.idusuaborraregistro IS NULL);


ALTER TABLE public.liprv OWNER TO admin;

--
-- Name: movimientos_bodegas; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE movimientos_bodegas (
    id numeric(20,0) NOT NULL,
    idbode numeric(20,0) NOT NULL,
    correlativo numeric(20,0) NOT NULL,
    idtimb numeric(20,0) NOT NULL,
    fechamovto date NOT NULL,
    descripcion character varying(100) NOT NULL,
    idusuacrearegistro numeric(20,0) NOT NULL,
    fechacrearegistro timestamp without time zone NOT NULL,
    idusuamodifregistro numeric(20,0),
    fechamodifregistro timestamp without time zone,
    idusuaborraregistro numeric(20,0),
    fechaborraregistro timestamp without time zone
);


ALTER TABLE public.movimientos_bodegas OWNER TO admin;

--
-- Name: mobo; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW mobo AS
    SELECT movimientos_bodegas.id, movimientos_bodegas.idbode, movimientos_bodegas.correlativo, movimientos_bodegas.idtimb, movimientos_bodegas.fechamovto, movimientos_bodegas.descripcion, movimientos_bodegas.idusuacrearegistro, movimientos_bodegas.fechacrearegistro, movimientos_bodegas.idusuamodifregistro, movimientos_bodegas.fechamodifregistro, movimientos_bodegas.idusuaborraregistro, movimientos_bodegas.fechaborraregistro FROM movimientos_bodegas;


ALTER TABLE public.mobo OWNER TO admin;

--
-- Name: mobo_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE mobo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mobo_seq OWNER TO admin;

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
    fechanotaventa timestamp without time zone NOT NULL,
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
    SELECT notas_ventas.id, notas_ventas.idempr, notas_ventas.idcove, notas_ventas.numero, notas_ventas.idclie, notas_ventas.descripcionnotaventa, notas_ventas.fechanotaventa, notas_ventas.idgere, notas_ventas.idproy, notas_ventas.idline, notas_ventas.idceco, notas_ventas.idtare, notas_ventas.exento, notas_ventas.afecto, notas_ventas.impuestos, notas_ventas.porcentajedescuento, notas_ventas.montodescuento, notas_ventas.total, notas_ventas.idesnv, notas_ventas.idusuacrearegistro, notas_ventas.fechacrearegistro, notas_ventas.idusuamodifregistro, notas_ventas.fechamodifregistro, notas_ventas.idusuaborraregistro, notas_ventas.fechaborraregistro FROM notas_ventas;


ALTER TABLE public.nove OWNER TO admin;

--
-- Name: nove_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE nove_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nove_seq OWNER TO admin;

--
-- Name: novev; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW novev AS
    SELECT nove.id, nove.idempr, empr.nombrefantasia AS empresa, nove.idcove, cove.numero AS numero_cotizacion, nove.numero AS numero_nota_venta, nove.idclie, (((((COALESCE(clie.nombrefantasia, ' '::character varying))::text || ' '::text) || (COALESCE(clie.primernombre, ' '::character varying))::text) || ' '::text) || (COALESCE(clie.apellidopaterno, ' '::character varying))::text) AS cliente, nove.descripcionnotaventa AS descripcion_nota_venta, nove.fechanotaventa AS fecha_nota_venta, nove.idgere, gere.nombre AS gerencia, nove.idproy, proy.nombre AS proyecto, nove.idline, line.nombre AS linea_negocio, nove.idceco, ceco.nombre AS centro_costo, nove.idtare, tare.nombre AS tarea, nove.exento, nove.afecto, nove.impuestos, nove.porcentajedescuento AS porc_descto, nove.montodescuento AS monto_descto, nove.total, nove.idesnv, esnv.descripcion AS estado_nota_venta FROM (((((((((notas_ventas nove LEFT JOIN empresas empr ON ((nove.idempr = empr.id))) LEFT JOIN cotizaciones_ventas cove ON ((nove.idcove = cove.id))) LEFT JOIN clientes clie ON ((nove.idclie = clie.id))) LEFT JOIN gerencias gere ON ((nove.idgere = gere.id))) LEFT JOIN proyectos proy ON ((nove.idproy = proy.id))) LEFT JOIN lineas_negocios line ON ((nove.idline = line.id))) LEFT JOIN centros_costos ceco ON ((nove.idceco = ceco.id))) LEFT JOIN tareas tare ON ((nove.idtare = tare.id))) LEFT JOIN estados_notas_vtas esnv ON ((nove.idesnv = esnv.id))) WHERE (nove.idusuaborraregistro IS NULL);


ALTER TABLE public.novev OWNER TO admin;

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
    START WITH 229
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
    START WITH 2024
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
    (SELECT NULL::text AS id_holding, '--'::character varying AS holding, NULL::text AS id_empresa, '--'::text AS empresa, perf.id AS id_perfil, perf.descripcion AS perfil, usua.username, usua.id AS idusua, pers.id AS idpers FROM personas pers, usuarios usua, usuarios_perfiles uspe, perfiles perf WHERE (((((((((pers.id = usua.idpers) AND (usua.id = uspe.idusua)) AND (uspe.idperf = perf.id)) AND (uspe.idgrem IS NULL)) AND (uspe.idempr IS NULL)) AND (perf.id = (1)::numeric)) AND (pers.idusuaborraregistro IS NULL)) AND (usua.idusuaborraregistro IS NULL)) AND (uspe.idusuaborraregistro IS NULL)) UNION SELECT to_char(grem.id, '9999999999'::text) AS id_holding, grem.nombre AS holding, NULL::text AS id_empresa, '--'::text AS empresa, perf.id AS id_perfil, perf.descripcion AS perfil, usua.username, usua.id AS idusua, pers.id AS idpers FROM personas pers, usuarios usua, usuarios_perfiles uspe, perfiles perf, grupos_empresariales grem WHERE (((((((((((pers.id = usua.idpers) AND (usua.id = uspe.idusua)) AND (uspe.idperf = perf.id)) AND (uspe.idgrem = grem.id)) AND (uspe.idgrem IS NOT NULL)) AND (uspe.idempr IS NULL)) AND (perf.id = (2)::numeric)) AND (pers.idusuaborraregistro IS NULL)) AND (usua.idusuaborraregistro IS NULL)) AND (uspe.idusuaborraregistro IS NULL)) AND (grem.idesge = (1)::numeric))) UNION SELECT to_char(grem.id, '9999999999'::text) AS id_holding, grem.nombre AS holding, to_char(empr.id, '9999999999'::text) AS id_empresa, empr.nombrefantasia AS empresa, perf.id AS id_perfil, perf.descripcion AS perfil, usua.username, usua.id AS idusua, pers.id AS idpers FROM personas pers, usuarios usua, usuarios_perfiles uspe, perfiles perf, empresas empr, grupos_empresariales grem WHERE (((((((((((((pers.id = usua.idpers) AND (usua.id = uspe.idusua)) AND (uspe.idperf = perf.id)) AND (uspe.idempr = empr.id)) AND (empr.idgrem = grem.id)) AND (uspe.idgrem IS NULL)) AND (uspe.idempr IS NOT NULL)) AND (perf.id <> ALL (ARRAY[(1)::numeric, (2)::numeric]))) AND (pers.idusuaborraregistro IS NULL)) AND (usua.idusuaborraregistro IS NULL)) AND (uspe.idusuaborraregistro IS NULL)) AND (empr.idesre = (1)::numeric)) AND (grem.idesge = (1)::numeric)) ORDER BY 2, 4, 6;


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
-- Name: prod; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW prod AS
    SELECT productos.id, productos.idempr, productos.idsfpr, productos.idtipr, productos.idunmp, productos.idorpr, productos.nombre, productos.correlativoflia, productos.sku, productos.ean13, productos.qr, productos.pesounitariokg, productos.idesre, productos.idusuacrearegistro, productos.fechacrearegistro, productos.idusuamodifregistro, productos.fechamodifregistro, productos.idusuaborraregistro, productos.fechaborraregistro FROM productos;


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
-- Name: prodv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW prodv AS
    SELECT prod.id, prod.idempr, empr.nombrefantasia AS empresa, prod.idsfpr, sfpr.cod_sub_familia AS sub_familia, sfpr.descripcion AS nombre_sub_familia, sfpr.idfapr, fapr.cod_familia AS familia, fapr.descripcion AS nombre_familia, prod.idtipr, tipr.descripcion AS tipo_producto, prod.idunmp, unmp.descripcion AS unidad_de_medida, unmp.descripcioncorta AS alias_unidad_de_medida, prod.idorpr, orpr.descripcion AS origen, orpr.descripcioncorta AS alias_origen, prod.nombre, prod.correlativoflia, prod.sku, prod.ean13, prod.qr, prod.pesounitariokg, prod.idesre, esre.descripcion AS estado_regsitro FROM (((((((productos prod LEFT JOIN empresas empr ON ((prod.idempr = empr.id))) LEFT JOIN sub_familias_productos sfpr ON ((prod.idsfpr = sfpr.id))) LEFT JOIN familias_productos fapr ON ((sfpr.idfapr = fapr.id))) LEFT JOIN tipos_productos tipr ON ((prod.idtipr = tipr.id))) LEFT JOIN unidades_medidas_productos unmp ON ((prod.idunmp = unmp.id))) LEFT JOIN origenes_productos orpr ON ((prod.idorpr = orpr.id))) LEFT JOIN estados_registros esre ON ((prod.idesre = esre.id))) WHERE ((prod.idusuaborraregistro IS NULL) AND (empr.idusuaborraregistro IS NULL));


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
    START WITH 99001
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prog_seq OWNER TO admin;

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
-- Name: prueba; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE prueba (
    a numeric(20,0),
    b numeric(20,0)
);


ALTER TABLE public.prueba OWNER TO admin;

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
    START WITH 38
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
-- Name: sfpr; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW sfpr AS
    SELECT sub_familias_productos.id, sub_familias_productos.idfapr, sub_familias_productos.cod_sub_familia, sub_familias_productos.descripcion, sub_familias_productos.idusuacrearegistro, sub_familias_productos.fechacrearegistro, sub_familias_productos.idusuamodifregistro, sub_familias_productos.fechamodifregistro, sub_familias_productos.idusuaborraregistro, sub_familias_productos.fechaborraregistro FROM sub_familias_productos;


ALTER TABLE public.sfpr OWNER TO admin;

--
-- Name: sfpr_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE sfpr_seq
    START WITH 12
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sfpr_seq OWNER TO admin;

--
-- Name: sfprv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW sfprv AS
    SELECT sfpr.id, sfpr.idfapr, fapr.cod_familia, fapr.descripcion AS familia, sfpr.cod_sub_familia, sfpr.descripcion AS sub_familia, fapr.idempr, empr.nombrefantasia AS empresa FROM ((sub_familias_productos sfpr LEFT JOIN familias_productos fapr ON ((sfpr.idfapr = fapr.id))) LEFT JOIN empresas empr ON ((fapr.idempr = empr.id))) WHERE (sfpr.idusuaborraregistro IS NULL);


ALTER TABLE public.sfprv OWNER TO admin;

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
    START WITH 5
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
-- Name: tipos_movimientos_bodegas; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE tipos_movimientos_bodegas (
    id numeric(20,0) NOT NULL,
    descripcion character varying(100) NOT NULL,
    signo numeric(1,0) NOT NULL,
    CONSTRAINT timb_chk_01 CHECK ((signo = ANY (ARRAY[(1)::numeric, ((-1))::numeric])))
);


ALTER TABLE public.tipos_movimientos_bodegas OWNER TO admin;

--
-- Name: timb; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW timb AS
    SELECT tipos_movimientos_bodegas.id, tipos_movimientos_bodegas.descripcion, tipos_movimientos_bodegas.signo FROM tipos_movimientos_bodegas;


ALTER TABLE public.timb OWNER TO admin;

--
-- Name: timb_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE timb_seq
    START WITH 6
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.timb_seq OWNER TO admin;

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
-- Name: ventas; Type: TABLE; Schema: public; Owner: admin; Tablespace:
--

CREATE TABLE ventas (
    id numeric(20,0) NOT NULL,
    idempr numeric(20,0) NOT NULL,
    idnove numeric(20,0),
    idtidv numeric(20,0) NOT NULL,
    numero numeric(20,0) NOT NULL,
    idclie numeric(20,0) NOT NULL,
    descripcionventa character varying(1000) NOT NULL,
    fechaventa timestamp without time zone NOT NULL,
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


ALTER TABLE public.ventas OWNER TO admin;

--
-- Name: vent; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW vent AS
    SELECT ventas.id, ventas.idempr, ventas.idnove, ventas.idtidv, ventas.numero, ventas.idclie, ventas.descripcionventa, ventas.fechaventa, ventas.idgere, ventas.idproy, ventas.idline, ventas.idceco, ventas.idtare, ventas.exento, ventas.afecto, ventas.impuestos, ventas.porcentajedescuento, ventas.montodescuento, ventas.total, ventas.idesve, ventas.idusuacrearegistro, ventas.fechacrearegistro, ventas.idusuamodifregistro, ventas.fechamodifregistro, ventas.idusuaborraregistro, ventas.fechaborraregistro FROM ventas;


ALTER TABLE public.vent OWNER TO admin;

--
-- Name: vent_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE vent_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vent_seq OWNER TO admin;

--
-- Name: ventv; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW ventv AS
    SELECT vent.id, vent.idempr, empr.nombrefantasia AS empresa, vent.idnove, nove.numero AS numero_nota_venta, vent.idtidv, tidv.descripcion AS tipo_docto_venta, vent.numero AS folio_docto_venta, vent.idclie, (((((COALESCE(clie.nombrefantasia, ' '::character varying))::text || ' '::text) || (COALESCE(clie.primernombre, ' '::character varying))::text) || ' '::text) || (COALESCE(clie.apellidopaterno, ' '::character varying))::text) AS cliente, vent.descripcionventa AS descripcion_venta, vent.fechaventa AS fecha_venta, vent.idgere, gere.nombre AS gerencia, vent.idproy, proy.nombre AS proyecto, vent.idline, line.nombre AS linea_negocio, vent.idceco, ceco.nombre AS centro_costo, vent.idtare, tare.nombre AS tarea, vent.exento, vent.afecto, vent.impuestos, vent.porcentajedescuento AS porc_descto, vent.montodescuento AS monto_descto, vent.total, vent.idesve, esve.descripcion AS estado_venta FROM ((((((((((ventas vent LEFT JOIN empresas empr ON ((vent.idempr = empr.id))) LEFT JOIN notas_ventas nove ON ((vent.idnove = nove.id))) LEFT JOIN tipos_doctos_ventas tidv ON ((vent.idtidv = tidv.id))) LEFT JOIN clientes clie ON ((vent.idclie = clie.id))) LEFT JOIN gerencias gere ON ((vent.idgere = gere.id))) LEFT JOIN proyectos proy ON ((vent.idproy = proy.id))) LEFT JOIN lineas_negocios line ON ((vent.idline = line.id))) LEFT JOIN centros_costos ceco ON ((vent.idceco = ceco.id))) LEFT JOIN tareas tare ON ((vent.idtare = tare.id))) LEFT JOIN estados_ventas esve ON ((vent.idesve = esve.id))) WHERE (vent.idusuaborraregistro IS NULL);


ALTER TABLE public.ventv OWNER TO admin;

--
-- Name: bicp_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('bicp_seq', 1, false);


--
-- Data for Name: bitacoras_cambios_precios; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Name: bode_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('bode_seq', 12, false);


--
-- Data for Name: bodegas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO bodegas VALUES (1, 1, 'BODEGA CENTRAL', 1, '2018-02-18 00:37:42.380033', NULL, NULL, NULL, NULL);
INSERT INTO bodegas VALUES (2, 2, 'BODEGA CENTRAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO bodegas VALUES (3, 3, 'BODEGA CENTRAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO bodegas VALUES (4, 4, 'BODEGA CENTRAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO bodegas VALUES (5, 5, 'BODEGA CENTRAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO bodegas VALUES (6, 6, 'BODEGA CENTRAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO bodegas VALUES (7, 7, 'BODEGA CENTRAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO bodegas VALUES (8, 8, 'BODEGA CENTRAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO bodegas VALUES (9, 9, 'BODEGA CENTRAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO bodegas VALUES (10, 10, 'BODEGA CENTRAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO bodegas VALUES (11, 11, 'BODEGA CENTRAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);


--
-- Data for Name: bodegas_productos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO bodegas_productos VALUES (1, 1, 1, 100.00, 1, '2018-02-18 00:37:57.345256', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (2, 1, 2, 100.00, 1, '2018-02-18 00:37:57.353579', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (3, 1, 3, 100.00, 1, '2018-02-18 00:37:57.361925', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (4, 1, 4, 100.00, 1, '2018-02-18 00:37:57.370251', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (5, 1, 5, 100.00, 1, '2018-02-18 00:37:57.37857', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (6, 1, 6, 100.00, 1, '2018-02-18 00:37:57.386929', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (7, 1, 7, 100.00, 1, '2018-02-18 00:37:57.395246', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (8, 1, 8, 100.00, 1, '2018-02-18 00:37:57.403547', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (9, 1, 9, 100.00, 1, '2018-02-18 00:37:57.411924', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (10, 1, 10, 100.00, 1, '2018-02-18 00:37:57.470377', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (11, 1, 11, 100.00, 1, '2018-02-18 00:37:57.478656', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (12, 1, 12, 100.00, 1, '2018-02-18 00:37:57.48698', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (13, 1, 13, 100.00, 1, '2018-02-18 00:37:57.4953', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (14, 1, 14, 100.00, 1, '2018-02-18 00:37:57.503659', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (15, 1, 15, 100.00, 1, '2018-02-18 00:37:57.511976', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (16, 1, 16, 100.00, 1, '2018-02-18 00:37:57.520303', NULL, NULL, NULL, NULL);
INSERT INTO bodegas_productos VALUES (17, 1, 17, 100.00, 1, '2018-02-18 00:37:57.528658', NULL, NULL, NULL, NULL);


--
-- Name: bopr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('bopr_seq', 18, false);


--
-- Name: ceco_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('ceco_seq', 46, false);


--
-- Data for Name: centros_costos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO centros_costos VALUES (1, 2, 'ZONA CENTRO - PRODUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (2, 2, 'ZONA CENTRO - ADMINISTRACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (3, 2, 'ZONA CENTRO - VENTAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (4, 2, 'ZONA NORTE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (5, 2, 'ZONA SUR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (6, 3, 'ZONA CENTRO - PRODUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (7, 3, 'ZONA CENTRO - ADMINISTRACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (8, 3, 'ZONA CENTRO - VENTAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (9, 3, 'ZONA NORTE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (10, 3, 'ZONA SUR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (11, 4, 'ZONA CENTRO - PRODUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (12, 4, 'ZONA CENTRO - ADMINISTRACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (13, 4, 'ZONA CENTRO - VENTAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (14, 4, 'ZONA NORTE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (15, 4, 'ZONA SUR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (16, 5, 'ZONA CENTRO - PRODUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (17, 5, 'ZONA CENTRO - ADMINISTRACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (18, 5, 'ZONA CENTRO - VENTAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (19, 5, 'ZONA NORTE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (20, 5, 'ZONA SUR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (21, 6, 'ZONA CENTRO - PRODUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (22, 6, 'ZONA CENTRO - ADMINISTRACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (23, 6, 'ZONA CENTRO - VENTAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (24, 6, 'ZONA NORTE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (25, 6, 'ZONA SUR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (26, 7, 'ZONA CENTRO - PRODUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (27, 7, 'ZONA CENTRO - ADMINISTRACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (28, 7, 'ZONA CENTRO - VENTAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (29, 7, 'ZONA NORTE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (30, 7, 'ZONA SUR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (31, 8, 'ZONA CENTRO - PRODUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (32, 8, 'ZONA CENTRO - ADMINISTRACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (33, 8, 'ZONA CENTRO - VENTAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (34, 8, 'ZONA NORTE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (35, 8, 'ZONA SUR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (36, 9, 'ZONA CENTRO - PRODUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (37, 9, 'ZONA CENTRO - ADMINISTRACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (38, 9, 'ZONA CENTRO - VENTAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (39, 9, 'ZONA NORTE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (40, 9, 'ZONA SUR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (41, 10, 'ZONA CENTRO - PRODUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (42, 10, 'ZONA CENTRO - ADMINISTRACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (43, 10, 'ZONA CENTRO - VENTAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (44, 10, 'ZONA NORTE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO centros_costos VALUES (45, 10, 'ZONA SUR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);


--
-- Name: clie_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('clie_seq', 2, false);


--
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO clientes VALUES (1, 1, 1, '10917721', '0', 1, NULL, NULL, 'CRISTIAN', NULL, 'PALMA', NULL, 1, '2018-02-18 00:37:56.72835', NULL, NULL, NULL, NULL);


--
-- Name: cosh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('cosh_seq', 1, false);


--
-- Data for Name: cotizaciones_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: cotizaciones_ventas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO cotizaciones_ventas VALUES (1, 1, 1, 1, 'PRUEBA', '2018-02-18 00:37:56.72835', NULL, NULL, NULL, NULL, NULL, 0, 3000, 570, 0.00000, 0, 3570, 5, 3, 1, '2018-02-18 00:37:56.72835', NULL, NULL, NULL, NULL);


--
-- Name: cove_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('cove_seq', 2, false);


--
-- Data for Name: cpalma; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO cpalma VALUES (1, 'm1');
INSERT INTO cpalma VALUES (2, 'm2');
INSERT INTO cpalma VALUES (2, 'm2');
INSERT INTO cpalma VALUES (2, 'm2');
INSERT INTO cpalma VALUES (2, 'm2');
INSERT INTO cpalma VALUES (2, 'm2');
INSERT INTO cpalma VALUES (2, 'm2');


--
-- Name: cpalma_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('cpalma_seq', 33, true);


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

SELECT pg_catalog.setval('dedv_seq', 3, true);


--
-- Name: delp_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('delp_seq', 35, false);


--
-- Name: demb_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('demb_seq', 1, false);


--
-- Name: denv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('denv_seq', 3, false);


--
-- Name: desc_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('desc_seq', 1, false);


--
-- Data for Name: descuentos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO descuentos VALUES (1, 1, NULL, NULL, 5.00000, NULL, 1, 1, '2018-02-18 00:37:57.245259', NULL, NULL, NULL, NULL);
INSERT INTO descuentos VALUES (2, NULL, 1, NULL, 10.00000, NULL, 1, 1, '2018-02-18 00:37:57.253579', NULL, NULL, NULL, NULL);
INSERT INTO descuentos VALUES (3, NULL, NULL, 1, 15.00000, NULL, 1, 1, '2018-02-18 00:37:57.261937', NULL, NULL, NULL, NULL);
INSERT INTO descuentos VALUES (4, NULL, NULL, 2, 20.00000, NULL, 1, 1, '2018-02-18 00:37:57.270245', NULL, NULL, NULL, NULL);
INSERT INTO descuentos VALUES (5, NULL, NULL, 3, NULL, 100, 1, 1, '2018-02-18 00:37:57.278579', NULL, NULL, NULL, NULL);
INSERT INTO descuentos VALUES (6, NULL, NULL, 4, NULL, 200, 1, 1, '2018-02-18 00:37:57.3286', NULL, NULL, NULL, NULL);
INSERT INTO descuentos VALUES (7, NULL, NULL, 5, NULL, 300, 1, 1, '2018-02-18 00:37:57.336929', NULL, NULL, NULL, NULL);


--
-- Name: desu_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('desu_seq', 8, false);


--
-- Data for Name: detalles_cotizs_vtas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO detalles_cotizs_vtas VALUES (1, 1, 1, 1, NULL, 500, 2.00, 0.00000, 0, 0.00000, 0, 0, 1000, 190.00, 1190.00, 1, '2018-02-18 00:37:56.72835', NULL, NULL, NULL, NULL);
INSERT INTO detalles_cotizs_vtas VALUES (2, 1, 2, 2, NULL, 100, 20.00, 0.00000, 0, 0.00000, 0, 0, 2000, 380.00, 2380.00, 1, '2018-02-18 00:37:56.72835', NULL, NULL, NULL, NULL);


--
-- Data for Name: detalles_doctos_vtas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO detalles_doctos_vtas VALUES (1, 1, 1, 1, NULL, 500, 2.00, 0.00000, 0, 0, 1000, 190.00, 1190.00, 1, '2018-01-06 22:50:12.507313', NULL, NULL, NULL, NULL);
INSERT INTO detalles_doctos_vtas VALUES (2, 1, 2, 2, NULL, 100, 20.00, 0.00000, 0, 0, 2000, 380.00, 2380.00, 1, '2018-01-06 22:50:12.507313', NULL, NULL, NULL, NULL);


--
-- Data for Name: detalles_listas_precios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO detalles_listas_precios VALUES (1, 1, 1, 1000, 1, '2018-02-18 00:37:56.836752', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (2, 1, 2, 1100, 1, '2018-02-18 00:37:56.845119', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (3, 1, 3, 1200, 1, '2018-02-18 00:37:56.853499', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (4, 1, 4, 1300, 1, '2018-02-18 00:37:56.861831', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (5, 1, 5, 1000, 1, '2018-02-18 00:37:56.870174', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (6, 1, 6, 1100, 1, '2018-02-18 00:37:56.878474', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (7, 1, 7, 1200, 1, '2018-02-18 00:37:56.928494', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (8, 1, 8, 1300, 1, '2018-02-18 00:37:56.936775', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (9, 1, 9, 1000, 1, '2018-02-18 00:37:56.945153', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (10, 1, 10, 1100, 1, '2018-02-18 00:37:56.953475', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (11, 1, 11, 1200, 1, '2018-02-18 00:37:56.961818', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (12, 1, 12, 1300, 1, '2018-02-18 00:37:56.970155', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (13, 1, 13, 5000, 1, '2018-02-18 00:37:56.978475', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (14, 1, 14, 5100, 1, '2018-02-18 00:37:56.986759', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (15, 1, 15, 5200, 1, '2018-02-18 00:37:56.995155', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (16, 1, 16, 3000, 1, '2018-02-18 00:37:57.003502', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (17, 1, 17, 4000, 1, '2018-02-18 00:37:57.011848', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (18, 2, 1, 1100, 1, '2018-02-18 00:37:57.061853', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (19, 2, 2, 1200, 1, '2018-02-18 00:37:57.07022', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (20, 2, 3, 1300, 1, '2018-02-18 00:37:57.078573', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (21, 2, 4, 1400, 1, '2018-02-18 00:37:57.086906', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (22, 2, 5, 1100, 1, '2018-02-18 00:37:57.095232', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (23, 2, 6, 1200, 1, '2018-02-18 00:37:57.103538', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (24, 2, 7, 1300, 1, '2018-02-18 00:37:57.111872', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (25, 2, 8, 1400, 1, '2018-02-18 00:37:57.120199', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (26, 2, 9, 1100, 1, '2018-02-18 00:37:57.128512', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (27, 2, 10, 1200, 1, '2018-02-18 00:37:57.13687', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (28, 2, 11, 1300, 1, '2018-02-18 00:37:57.145195', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (29, 2, 12, 1400, 1, '2018-02-18 00:37:57.1952', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (30, 2, 13, 5100, 1, '2018-02-18 00:37:57.203539', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (31, 2, 14, 5200, 1, '2018-02-18 00:37:57.21186', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (32, 2, 15, 5300, 1, '2018-02-18 00:37:57.220184', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (33, 2, 16, 3100, 1, '2018-02-18 00:37:57.228505', NULL, NULL, NULL, NULL);
INSERT INTO detalles_listas_precios VALUES (34, 2, 17, 4100, 1, '2018-02-18 00:37:57.236855', NULL, NULL, NULL, NULL);


--
-- Data for Name: detalles_movtos_bodegas; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: detalles_notas_vtas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO detalles_notas_vtas VALUES (1, 1, 1, 1, NULL, 500, 2.00, 0.00000, 0, 0.00000, 0, 0.00, 1000.00, 190.00, 1190.00, 1, '2018-02-18 00:37:56.795116', NULL, NULL, NULL, NULL);
INSERT INTO detalles_notas_vtas VALUES (2, 1, 2, 2, NULL, 100, 20.00, 0.00000, 0, 0.00000, 0, 0.00, 2000.00, 380.00, 2380.00, 1, '2018-02-18 00:37:56.795116', NULL, NULL, NULL, NULL);


--
-- Data for Name: detalles_ventas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO detalles_ventas VALUES (1, 1, 1, 1, NULL, 500, 2.00, 0.00000, 0, 0.00000, 0, 0, 1000, 190.00, 1190.00, 1, '2018-02-18 00:37:56.811766', NULL, NULL, NULL, NULL);
INSERT INTO detalles_ventas VALUES (2, 1, 2, 2, NULL, 100, 20.00, 0.00000, 0, 0.00000, 0, 0, 2000, 380.00, 2380.00, 1, '2018-02-18 00:37:56.811766', NULL, NULL, NULL, NULL);


--
-- Name: deve_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('deve_seq', 3, false);


--
-- Data for Name: doctos_cotizacs_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: doctos_ordenes_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: documentos_legales; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO documentos_legales VALUES (1, 1, 1, 'prueba_1.txt', 'prueba_1.txt', 1, '2018-02-17', 'LA UNICA', 'F1', 'PEDRO PIEDRA', 'NINGUNO', '2018-03-01', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (2, 1, 2, 'prueba_2.txt', 'prueba_2.txt', 1, '2018-02-16', 'LA CUCHUFLETA', '100', 'JUAN SOTO', 'NADA', '2018-03-02', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (3, 1, 3, 'prueba_3.txt', 'prueba_3.txt', 1, '2018-02-15', 'PEREZ', '500', 'FERNANDO ASTE', 'NINGUNA', '2018-03-03', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (4, 1, 4, 'acta_const_soc.docx', 'acta_const_soc.docx', 1, '2018-02-14', 'RENÉ SANTELICES', '700', 'AGUSTÍN LOPEZ A.', 'ALGO QUE COMENTAR', '2018-03-04', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (5, 1, 1, 'prueba_4.txt', 'prueba_4.txt', 1, '2018-02-13', 'ANTONIETA MENDOZA', 'F10', 'Pedro LOPEZ B.', 'TODO QUE COMENTAR', '2018-03-05', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (6, 1, 1, 'prueba_5.txt', 'prueba_5.txt', 1, '2018-02-12', 'ANTONIETA ESCALA', '700', 'MARIO JOFRÉ M.', 'NADA QUE COMENTAR', '2018-03-06', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (7, 1, 1, 'prueba_6.txt', 'prueba_6.txt', 1, '2018-02-11', 'MA. ANTONIETA ESCALA', '400', 'ERNESTO PINTO M.', 'NADA QUE COMENTAR', '2018-03-07', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (8, 1, 3, 'prueba_7.txt', 'prueba_7.txt', 1, '2018-02-10', 'MA. ANTONIETA MENDOZA ESCALA', '300', 'AGUSTÍN LOPEZ B.', 'TODO QUE COMENTAR', '2018-03-08', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (9, 1, 3, 'prueba_8.txt', 'prueba_8.txt', 1, '2018-02-09', 'RENÉ SANTELICES', '500', 'YULIA JOFRÉ M.', 'ALGO QUE COMENTAR', '2018-03-09', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (10, 1, 3, 'prueba_9.txt', 'prueba_9.txt', 1, '2018-02-17', 'RENÉ SANTELICES P.', '800', 'OTILIO JOFRÉ M.', 'NO COMENTAR', '2018-03-01', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (11, 1, 3, 'prueba_10.txt', 'prueba_10.txt', 1, '2018-02-16', 'ANTONIETA MENDOZA', '100', 'CLAUDIO LOPEZ B.', 'NADA QUE COMENTAR', '2018-03-02', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (12, 1, 3, 'prueba_11.txt', 'prueba_11.txt', 1, '2018-02-15', 'ANTONIETA MENDOZA', 'F 2', 'AGUSTÍN JOFRÉ A.', 'ALGO QUE COMENTAR', '2018-03-03', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (13, 1, 2, 'prueba_12.txT', 'prueba_12.txt', 1, '2018-02-14', 'RENÉ SANTELICES', '000', 'YULIA JOFRÉ C.', 'TODO QUE COMENTAR', '2018-03-04', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (14, 1, 2, 'prueba_13.txt', 'prueba_13.txt', 1, '2018-02-13', 'RENÉ SANTELICES', '900', 'CLAUDIO LOPEZ M.', 'NADA QUE COMENTAR', '2018-03-05', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (15, 1, 2, 'prueba_14.txt', 'prueba_14.txt', 1, '2018-02-12', 'ANTONIETA MENDOZA', '123', 'AGUSTÍN JOFRÉ A.', 'ALGO QUE COMENTAR', '2018-03-06', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (16, 1, 2, 'prueba_15.txt', 'prueba_15.txt', 1, '2018-02-11', 'ANTONIETA MENDOZA C.', '456', 'YULIA CARMONA M.', 'NO COMENTAR', '2018-03-07', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (17, 1, 2, 'prueba_16.txt', 'prueba_16.txt', 1, '2018-02-10', 'RENÉ SANTELICES', '789', 'AGUSTÍN LOPEZ C.', 'TODO QUE COMENTAR', '2018-03-08', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (18, 1, 2, 'prueba_17.txt', 'prueba_17.txt', 1, '2018-02-09', 'RENÉ SANTELICES', '012', 'CLAUDIO JOFRÉ A.', 'ALGO QUE COMENTAR', '2018-03-09', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (19, 1, 2, 'prueba_18.txt', 'prueba_18.txt', 1, '2018-02-17', 'R. SANTELICES', '345', 'AGUSTÍN LOPEZ M.', 'NADA QUE COMENTAR', '2018-03-01', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (20, 1, 4, 'prueba_19.txt', 'prueba_19.txt', 1, '2018-02-16', 'RENÉ SANTELICES', '678', 'CLAUDIO PINTO M.', 'NADA QUE COMENTAR', '2018-03-02', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (21, 1, 1, 'const_soc.txt', 'const_soc.txt', 1, '2018-02-15', 'ANTONIETA MENDOZA ESCALA', '901', 'JULIA PINTO A.', '--', '2018-03-03', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (22, 1, 2, 'act_dir.txt', 'act_dir.txt', 1, '2018-02-14', 'ANTONIETA MENDOZA E.', '100', 'JULIA PINTO A.', '--', '2018-03-04', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (23, 1, 3, 'ses_dir.txt', 'ses_dir.txt', 1, '2018-02-13', 'ANTONIETA MENDOZA E.', '200', 'JULIA PINTO A.', '--', '2018-03-05', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);
INSERT INTO documentos_legales VALUES (24, 1, 4, 'cont_arr.txt', 'cont_arr.txt', 1, '2018-02-12', 'ANTONIETA MENDOZA ESCALA', '300', 'JULIA PINTO A.', '--', '2018-03-06', 'GERARDO.PALMA.ASTE@GMAIL.COM', 'N', 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: documentos_ventas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO documentos_ventas VALUES (17, 1, 16, 1, 1, 1, 'PRUEBA', NULL, NULL, NULL, NULL, NULL, 0, 3000, 570, 0.00000, 0, 3570, 1, 1, '2018-01-06 14:24:59.039946', NULL, NULL, NULL, NULL);


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

SELECT pg_catalog.setval('empr_seq', 12, false);


--
-- Data for Name: empresas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO empresas VALUES (1, 1, 1, 1, 1, '1', '9', 'BUSINESS & TECHNOLOGY 5 CONSULTING', 'BT5', 'bt5.jpg', 1, '2018-02-18 00:37:42.380033', NULL, NULL, NULL, NULL, NULL);
INSERT INTO empresas VALUES (2, 2, 1, 12, 1, '96550820', '1', 'METALPAR S.A.', 'METALPAR S.A.', 'emp_metalpar.jpg', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (3, 2, 1, 13, 1, '93576000', '3', 'INDUSTRIAS METALURGICAS PAREDES', 'INDUSTRIAL METALPAR S.A.', 'emp_industrias.jpg', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (4, 2, 1, 14, 1, '88337800', '8', 'INVERSIONES METALPAR S.A.', 'INVERSIONES METALPAR S.A.', 'emp_inv_metalpar.jpg', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (5, 2, 1, 15, 1, '78400010', '9', 'AGRICOLA Y GANADERA SANTA BARBARA', 'STA. BARBARA', 'emp_sta_barbara.jpg', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (6, 3, 1, 26, 1, '89807200', '2', 'FARMACIAS CRUZ VERDE', 'FCV', 'emp_cruz_verde.jpg', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (7, 3, 1, 26, 1, '89741200', '4', 'DIFARMA', 'DIFARMA', 'emp_difarma.jpg', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (8, 3, 1, 27, 1, '91575000', '1', 'SOCOFAR', 'SOCOFAR', 'emp_socofar.jpg', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (9, 3, 1, 26, 1, '71378000', '6', 'LABORATORIO MINTLAB', 'MINTLAB', 'emp_mintlab.jpg', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (10, 3, 1, 26, 1, '77781470', '2', 'LABORATORIO MUNICH', 'MUNICH', 'emp_munich.jpg', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL, '');
INSERT INTO empresas VALUES (11, 4, 1, 37, 1, '76765660', '2', 'AMASANDERIA TRIGAL', 'TRIGAL', 'emp_trigal.jpg', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL, '');


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

SELECT pg_catalog.setval('escv_seq', 5, false);


--
-- Name: esdl_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esdl_seq', 13, false);


--
-- Name: esge_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esge_seq', 4, false);


--
-- Name: esnv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esnv_seq', 5, false);


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

INSERT INTO estados_civiles VALUES (1, 'S', 'SOLTERO');
INSERT INTO estados_civiles VALUES (2, 'C', 'CASADO');
INSERT INTO estados_civiles VALUES (3, 'V', 'VIUDO');
INSERT INTO estados_civiles VALUES (4, 'E', 'SEPARADO');


--
-- Data for Name: estados_cotizaciones_vtas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_cotizaciones_vtas VALUES (1, 'CREADA');
INSERT INTO estados_cotizaciones_vtas VALUES (2, 'CERRADA');
INSERT INTO estados_cotizaciones_vtas VALUES (3, 'ACEPTADA');
INSERT INTO estados_cotizaciones_vtas VALUES (4, 'CADUCADA');


--
-- Data for Name: estados_cotizacs_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_cotizacs_servs_hono VALUES (1, 'RECIBIDA');
INSERT INTO estados_cotizacs_servs_hono VALUES (2, 'ACEPTADA');
INSERT INTO estados_cotizacs_servs_hono VALUES (3, 'RECHAZADA');


--
-- Data for Name: estados_documentos_legales; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_documentos_legales VALUES (1, 1, 'VÁLIDO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO estados_documentos_legales VALUES (2, 1, 'INVÁLIDO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO estados_documentos_legales VALUES (3, 1, 'CADUCO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO estados_documentos_legales VALUES (4, 2, 'VÁLIDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO estados_documentos_legales VALUES (5, 2, 'INVÁLIDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO estados_documentos_legales VALUES (6, 2, 'CADUCO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO estados_documentos_legales VALUES (7, 3, 'VÁLIDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO estados_documentos_legales VALUES (8, 3, 'INVÁLIDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO estados_documentos_legales VALUES (9, 3, 'CADUCO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO estados_documentos_legales VALUES (10, 4, 'VÁLIDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO estados_documentos_legales VALUES (11, 4, 'INVÁLIDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO estados_documentos_legales VALUES (12, 4, 'CADUCO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);


--
-- Data for Name: estados_grem; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_grem VALUES (1, 'ACTIVO');
INSERT INTO estados_grem VALUES (2, 'INACTIVO');
INSERT INTO estados_grem VALUES (3, 'SUSPENDIDO');


--
-- Data for Name: estados_notas_vtas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_notas_vtas VALUES (1, 'CREADA');
INSERT INTO estados_notas_vtas VALUES (2, 'CERRADA');
INSERT INTO estados_notas_vtas VALUES (3, 'EMITIDA');
INSERT INTO estados_notas_vtas VALUES (4, 'CADUCADA');


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


--
-- Data for Name: estados_solics_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_solics_servs_hono VALUES (1, 'CREADA');
INSERT INTO estados_solics_servs_hono VALUES (2, 'TRANSFERIDA A JEFE DE COMPRAS');
INSERT INTO estados_solics_servs_hono VALUES (3, 'EN PROCESO');
INSERT INTO estados_solics_servs_hono VALUES (4, 'ACEPTADA UNA COTIZACIÓN');
INSERT INTO estados_solics_servs_hono VALUES (5, 'RECHAZADAS TODAS LAS COTIZACIONES');


--
-- Data for Name: estados_ventas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO estados_ventas VALUES (1, 'CREADA');
INSERT INTO estados_ventas VALUES (2, 'CERRADA');
INSERT INTO estados_ventas VALUES (3, 'ANULADA');


--
-- Name: esve_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('esve_seq', 4, false);


--
-- Data for Name: familias_productos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO familias_productos VALUES (1, 1, '01', 'FAMILIA GENÉRICA', 1, '2018-02-18 00:37:42.380033', NULL, NULL, NULL, NULL);
INSERT INTO familias_productos VALUES (2, 2, '01', 'FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO familias_productos VALUES (3, 3, '01', 'FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO familias_productos VALUES (4, 4, '01', 'FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO familias_productos VALUES (5, 5, '01', 'FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO familias_productos VALUES (6, 6, '01', 'FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO familias_productos VALUES (7, 7, '01', 'FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO familias_productos VALUES (8, 8, '01', 'FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO familias_productos VALUES (9, 9, '01', 'FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO familias_productos VALUES (10, 10, '01', 'FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO familias_productos VALUES (11, 11, '01', 'FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);


--
-- Name: fapr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('fapr_seq', 12, false);


--
-- Name: fide_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('fide_seq', 381, true);


--
-- Data for Name: field_defs; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO field_defs VALUES (1, 1, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (2, 1, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (3, 1, 3, 'nombre', 'character', 100, 0, 'N', 'Y', 'nombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (4, 2, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (5, 2, 2, 'idgrem', 'numeric', 20, 0, 'N', 'Y', 'idgrem', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (6, 2, 3, 'idpais', 'numeric', 20, 0, 'N', 'Y', 'idpais', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (7, 2, 4, 'identificador1', 'character', 50, 0, 'N', 'Y', 'identificador1', 'input', 50, 50, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (8, 2, 5, 'identificador2', 'character', 50, 0, 'N', 'Y', 'identificador2', 'input', 50, 50, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (9, 2, 6, 'idticl', 'numeric', 20, 0, 'N', 'Y', 'idticl', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (10, 2, 7, 'razonsocial', 'character', 100, 0, 'N', 'N', 'razonsocial', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (11, 2, 8, 'nombrefantasia', 'character', 100, 0, 'N', 'N', 'nombrefantasia', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (12, 2, 9, 'primernombre', 'character', 100, 0, 'N', 'N', 'primernombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (13, 2, 10, 'segundonombre', 'character', 100, 0, 'N', 'N', 'segundonombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (14, 2, 11, 'apellidopaterno', 'character', 100, 0, 'N', 'N', 'apellidopaterno', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (15, 2, 12, 'apellidomaterno', 'character', 100, 0, 'N', 'N', 'apellidomaterno', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (16, 3, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (17, 3, 2, 'idsosh', 'numeric', 20, 0, 'N', 'Y', 'idsosh', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (18, 3, 3, 'idpers', 'numeric', 20, 0, 'N', 'Y', 'idpers', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (19, 3, 4, 'monto', 'numeric', 20, 0, 'N', 'Y', 'monto', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (20, 3, 5, 'descservofrecido', 'character', 1000, 0, 'N', 'Y', 'descservofrecido', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (21, 3, 6, 'informeevaluaccotiz', 'character', 1000, 0, 'N', 'N', 'informeevaluaccotiz', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (22, 3, 7, 'idecsh', 'numeric', 20, 0, 'N', 'Y', 'idecsh', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (23, 4, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (24, 4, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (25, 4, 3, 'numero', 'numeric', 20, 0, 'N', 'Y', 'numero', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (26, 4, 4, 'idclie', 'numeric', 20, 0, 'N', 'Y', 'idclie', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (27, 4, 5, 'descripcioncotizacion', 'character', 1000, 0, 'N', 'Y', 'descripcioncotizacion', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (28, 4, 6, 'idgere', 'numeric', 20, 0, 'N', 'N', 'idgere', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (29, 4, 7, 'idproy', 'numeric', 20, 0, 'N', 'N', 'idproy', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (30, 4, 8, 'idline', 'numeric', 20, 0, 'N', 'N', 'idline', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (31, 4, 9, 'idceco', 'numeric', 20, 0, 'N', 'N', 'idceco', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (32, 4, 10, 'idtare', 'numeric', 20, 0, 'N', 'N', 'idtare', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (33, 4, 11, 'subtotal', 'numeric', 20, 0, 'N', 'Y', 'subtotal', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (34, 4, 12, 'porcentajedescuento', 'numeric', 20, 0, 'N', 'Y', 'porcentajedescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (35, 4, 13, 'montodescuento', 'numeric', 20, 0, 'N', 'Y', 'montodescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (36, 4, 14, 'valorimpuestos', 'numeric', 20, 0, 'N', 'Y', 'valorimpuestos', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (37, 4, 15, 'total', 'numeric', 20, 0, 'N', 'Y', 'total', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (38, 4, 16, 'diasvalidez', 'numeric', 20, 0, 'N', 'Y', 'diasvalidez', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (39, 4, 17, 'idescv', 'numeric', 20, 0, 'N', 'Y', 'idescv', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (40, 5, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (41, 5, 2, 'idcove', 'numeric', 20, 0, 'N', 'Y', 'idcove', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (42, 5, 3, 'correlativo', 'numeric', 20, 0, 'N', 'Y', 'correlativo', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (43, 5, 4, 'idprod', 'numeric', 20, 0, 'N', 'N', 'idprod', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (44, 5, 5, 'idserv', 'numeric', 20, 0, 'N', 'N', 'idserv', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (45, 5, 6, 'cantidad', 'numeric', 20, 0, 'N', 'Y', 'cantidad', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (46, 5, 7, 'preciounitario', 'numeric', 20, 0, 'N', 'Y', 'preciounitario', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (47, 5, 8, 'porcentajedescuento', 'numeric', 20, 0, 'N', 'Y', 'porcentajedescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (48, 5, 9, 'montodescuento', 'numeric', 20, 0, 'N', 'Y', 'montodescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (49, 5, 10, 'impuestos', 'numeric', 20, 0, 'N', 'Y', 'impuestos', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (50, 5, 11, 'subtotal', 'numeric', 20, 0, 'N', 'Y', 'subtotal', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (51, 6, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (52, 6, 2, 'iddove', 'numeric', 20, 0, 'N', 'Y', 'iddove', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (53, 6, 3, 'correlativo', 'numeric', 20, 0, 'N', 'Y', 'correlativo', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (54, 6, 4, 'idprod', 'numeric', 20, 0, 'N', 'N', 'idprod', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (55, 6, 5, 'idserv', 'numeric', 20, 0, 'N', 'N', 'idserv', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (56, 6, 6, 'cantidad', 'numeric', 20, 0, 'N', 'Y', 'cantidad', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (57, 6, 7, 'preciounitario', 'numeric', 20, 0, 'N', 'Y', 'preciounitario', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (58, 6, 8, 'porcentajedescuento', 'numeric', 20, 0, 'N', 'Y', 'porcentajedescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (59, 6, 9, 'montodescuento', 'numeric', 20, 0, 'N', 'Y', 'montodescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (60, 6, 10, 'impuestos', 'numeric', 20, 0, 'N', 'Y', 'impuestos', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (61, 6, 11, 'subtotal', 'numeric', 20, 0, 'N', 'Y', 'subtotal', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (62, 7, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (63, 7, 2, 'idnove', 'numeric', 20, 0, 'N', 'Y', 'idnove', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (64, 7, 3, 'correlativo', 'numeric', 20, 0, 'N', 'Y', 'correlativo', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (65, 7, 4, 'idprod', 'numeric', 20, 0, 'N', 'N', 'idprod', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (66, 7, 5, 'idserv', 'numeric', 20, 0, 'N', 'N', 'idserv', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (67, 7, 6, 'cantidad', 'numeric', 20, 0, 'N', 'Y', 'cantidad', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (68, 7, 7, 'preciounitario', 'numeric', 20, 0, 'N', 'Y', 'preciounitario', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (69, 7, 8, 'porcentajedescuento', 'numeric', 20, 0, 'N', 'Y', 'porcentajedescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (70, 7, 9, 'montodescuento', 'numeric', 20, 0, 'N', 'Y', 'montodescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (71, 7, 10, 'impuestos', 'numeric', 20, 0, 'N', 'Y', 'impuestos', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (72, 7, 11, 'subtotal', 'numeric', 20, 0, 'N', 'Y', 'subtotal', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (73, 8, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (74, 8, 2, 'idcosh', 'numeric', 20, 0, 'N', 'Y', 'idcosh', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (75, 8, 3, 'nombrearchivoorig', 'character', 100, 0, 'N', 'Y', 'nombrearchivoorig', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (76, 8, 4, 'nombrearchivomodif', 'character', 100, 0, 'N', 'Y', 'nombrearchivomodif', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (77, 9, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (78, 9, 2, 'idorsh', 'numeric', 20, 0, 'N', 'Y', 'idorsh', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (79, 9, 3, 'nombrearchivoorig', 'character', 100, 0, 'N', 'Y', 'nombrearchivoorig', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (80, 9, 4, 'nombrearchivomodif', 'character', 100, 0, 'N', 'Y', 'nombrearchivomodif', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (81, 10, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (82, 10, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (83, 10, 3, 'idtidl', 'numeric', 20, 0, 'N', 'Y', 'idtidl', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (84, 10, 4, 'nombreoriginal', 'character', 500, 0, 'N', 'Y', 'nombreoriginal', 'input', 500, 500, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (85, 10, 5, 'nombresistema', 'character', 100, 0, 'N', 'Y', 'nombresistema', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (86, 10, 6, 'idesdl', 'numeric', 20, 0, 'N', 'Y', 'idesdl', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (87, 10, 7, 'fecha', 'date', 0, 0, 'N', 'Y', 'fecha', 'input', 0, 0, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (88, 10, 8, 'notaria', 'character', 100, 0, 'N', 'N', 'notaria', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (89, 10, 9, 'foja', 'character', 100, 0, 'N', 'N', 'foja', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (90, 10, 10, 'responsable', 'character', 100, 0, 'N', 'Y', 'responsable', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (91, 10, 11, 'comentario', 'character', 1000, 0, 'N', 'Y', 'comentario', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (92, 10, 12, 'fechaaviso', 'date', 0, 0, 'N', 'N', 'fechaaviso', 'input', 0, 0, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (93, 10, 13, 'emailaviso', 'character', 100, 0, 'N', 'N', 'emailaviso', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (94, 10, 14, 'avisodado', 'character', 1, 0, 'N', 'N', 'avisodado', 'input', 1, 1, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (95, 11, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (96, 11, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (97, 11, 3, 'idnove', 'numeric', 20, 0, 'N', 'N', 'idnove', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (98, 11, 4, 'idtidv', 'numeric', 20, 0, 'N', 'Y', 'idtidv', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (99, 11, 5, 'numero', 'numeric', 20, 0, 'N', 'Y', 'numero', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (100, 11, 6, 'idclie', 'numeric', 20, 0, 'N', 'Y', 'idclie', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (101, 11, 7, 'descripciondoctoventa', 'character', 1000, 0, 'N', 'Y', 'descripciondoctoventa', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (102, 11, 8, 'idgere', 'numeric', 20, 0, 'N', 'N', 'idgere', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (103, 11, 9, 'idproy', 'numeric', 20, 0, 'N', 'N', 'idproy', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (104, 11, 10, 'idline', 'numeric', 20, 0, 'N', 'N', 'idline', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (105, 11, 11, 'idceco', 'numeric', 20, 0, 'N', 'N', 'idceco', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (106, 11, 12, 'idtare', 'numeric', 20, 0, 'N', 'N', 'idtare', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (107, 11, 13, 'subtotal', 'numeric', 20, 0, 'N', 'Y', 'subtotal', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (108, 11, 14, 'porcentajedescuento', 'numeric', 20, 0, 'N', 'Y', 'porcentajedescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (109, 11, 15, 'montodescuento', 'numeric', 20, 0, 'N', 'Y', 'montodescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (110, 11, 16, 'valorimpuestos', 'numeric', 20, 0, 'N', 'Y', 'valorimpuestos', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (111, 11, 17, 'total', 'numeric', 20, 0, 'N', 'Y', 'total', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (112, 11, 18, 'idesve', 'numeric', 20, 0, 'N', 'Y', 'idesve', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (113, 12, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (114, 12, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (115, 13, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (116, 13, 2, 'idgrem', 'numeric', 20, 0, 'N', 'Y', 'idgrem', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (117, 13, 3, 'idpais', 'numeric', 20, 0, 'N', 'Y', 'idpais', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (118, 13, 4, 'idrubr', 'numeric', 20, 0, 'N', 'Y', 'idrubr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (119, 13, 5, 'idesre', 'numeric', 20, 0, 'N', 'Y', 'idesre', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (120, 13, 6, 'identificador1', 'character', 50, 0, 'N', 'Y', 'identificador1', 'input', 50, 50, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (121, 13, 7, 'identificador2', 'character', 50, 0, 'N', 'Y', 'identificador2', 'input', 50, 50, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (122, 13, 8, 'razonsocial', 'character', 100, 0, 'N', 'Y', 'razonsocial', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (123, 13, 9, 'nombrefantasia', 'character', 100, 0, 'N', 'Y', 'nombrefantasia', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (124, 13, 10, 'icono', 'character', 100, 0, 'N', 'Y', 'icono', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (125, 14, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (126, 14, 2, 'alias', 'character', 1, 0, 'N', 'Y', 'alias', 'input', 1, 1, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (127, 14, 3, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (128, 15, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (129, 15, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (130, 16, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (131, 16, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (132, 17, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (133, 17, 2, 'idgrem', 'numeric', 20, 0, 'N', 'Y', 'idgrem', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (134, 17, 3, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (135, 18, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (136, 18, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (137, 19, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (138, 19, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (139, 20, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (140, 20, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (141, 21, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (142, 21, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (143, 22, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (144, 22, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (145, 23, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (146, 23, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (147, 24, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (148, 24, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (149, 25, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (150, 25, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (151, 25, 3, 'nombre', 'character', 100, 0, 'N', 'Y', 'nombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (152, 26, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (153, 26, 2, 'nombre', 'character', 100, 0, 'N', 'Y', 'nombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (154, 26, 3, 'alias', 'character', 10, 0, 'N', 'Y', 'alias', 'input', 10, 10, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (155, 26, 4, 'icono', 'character', 100, 0, 'N', 'Y', 'icono', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (156, 26, 5, 'idpais', 'numeric', 20, 0, 'N', 'Y', 'idpais', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (157, 26, 6, 'idesge', 'numeric', 20, 0, 'N', 'Y', 'idesge', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (158, 27, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (159, 27, 2, 'idpais', 'numeric', 20, 0, 'N', 'Y', 'idpais', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (160, 27, 3, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (161, 27, 4, 'descripcioncorta', 'character', 10, 0, 'N', 'Y', 'descripcioncorta', 'input', 10, 10, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (162, 27, 5, 'obligatorio', 'character', 1, 0, 'N', 'Y', 'obligatorio', 'input', 1, 1, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (163, 27, 6, 'valor', 'numeric', 20, 0, 'N', 'Y', 'valor', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (164, 28, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (165, 28, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (166, 28, 3, 'nombre', 'character', 100, 0, 'N', 'Y', 'nombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (167, 29, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (168, 29, 2, 'nombre', 'character', 100, 0, 'N', 'Y', 'nombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (169, 29, 3, 'nombrecorto', 'character', 10, 0, 'N', 'Y', 'nombrecorto', 'input', 10, 10, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (170, 30, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (171, 30, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (172, 30, 3, 'idcove', 'numeric', 20, 0, 'N', 'N', 'idcove', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (173, 30, 4, 'numero', 'numeric', 20, 0, 'N', 'Y', 'numero', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (174, 30, 5, 'idclie', 'numeric', 20, 0, 'N', 'Y', 'idclie', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (175, 30, 6, 'descripcionnotaventa', 'character', 1000, 0, 'N', 'Y', 'descripcionnotaventa', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (176, 30, 7, 'idgere', 'numeric', 20, 0, 'N', 'N', 'idgere', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (177, 30, 8, 'idproy', 'numeric', 20, 0, 'N', 'N', 'idproy', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (178, 30, 9, 'idline', 'numeric', 20, 0, 'N', 'N', 'idline', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (179, 30, 10, 'idceco', 'numeric', 20, 0, 'N', 'N', 'idceco', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (180, 30, 11, 'idtare', 'numeric', 20, 0, 'N', 'N', 'idtare', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (181, 30, 12, 'subtotal', 'numeric', 20, 0, 'N', 'Y', 'subtotal', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (182, 30, 13, 'porcentajedescuento', 'numeric', 20, 0, 'N', 'Y', 'porcentajedescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (183, 30, 14, 'montodescuento', 'numeric', 20, 0, 'N', 'Y', 'montodescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (184, 30, 15, 'valorimpuestos', 'numeric', 20, 0, 'N', 'Y', 'valorimpuestos', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (185, 30, 16, 'total', 'numeric', 20, 0, 'N', 'Y', 'total', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (186, 30, 17, 'idesnv', 'numeric', 20, 0, 'N', 'Y', 'idesnv', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (187, 31, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (188, 31, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (189, 31, 3, 'idsosh', 'numeric', 20, 0, 'N', 'N', 'idsosh', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (190, 31, 4, 'correlativo', 'numeric', 20, 0, 'N', 'Y', 'correlativo', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (191, 31, 5, 'codigocompra', 'character', 100, 0, 'N', 'Y', 'codigocompra', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (192, 31, 6, 'idpers', 'numeric', 20, 0, 'N', 'Y', 'idpers', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (193, 31, 7, 'descripcionordenserv', 'character', 1000, 0, 'N', 'Y', 'descripcionordenserv', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (194, 31, 8, 'resultadofinal', 'character', 1000, 0, 'N', 'N', 'resultadofinal', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (195, 31, 9, 'ideosh', 'numeric', 20, 0, 'N', 'Y', 'ideosh', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (196, 31, 10, 'idgere', 'numeric', 20, 0, 'N', 'N', 'idgere', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (197, 31, 11, 'idproy', 'numeric', 20, 0, 'N', 'N', 'idproy', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (198, 31, 12, 'idline', 'numeric', 20, 0, 'N', 'N', 'idline', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (199, 31, 13, 'idceco', 'numeric', 20, 0, 'N', 'N', 'idceco', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (200, 31, 14, 'idtare', 'numeric', 20, 0, 'N', 'N', 'idtare', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (201, 32, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (202, 32, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (203, 32, 3, 'descripcioncorta', 'character', 10, 0, 'N', 'Y', 'descripcioncorta', 'input', 10, 10, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (204, 33, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (205, 33, 2, 'idorsh', 'numeric', 20, 0, 'N', 'Y', 'idorsh', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (206, 33, 3, 'fechapago', 'date', 0, 0, 'N', 'Y', 'fechapago', 'input', 0, 0, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (207, 33, 4, 'monto', 'numeric', 20, 0, 'N', 'Y', 'monto', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (208, 33, 5, 'idtifp', 'numeric', 20, 0, 'N', 'Y', 'idtifp', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (209, 33, 6, 'idepos', 'numeric', 20, 0, 'N', 'Y', 'idepos', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (210, 34, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (211, 34, 2, 'nombre', 'character', 100, 0, 'N', 'Y', 'nombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (212, 34, 3, 'idmone', 'numeric', 20, 0, 'N', 'Y', 'idmone', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (213, 34, 4, 'nacionalidad', 'character', 100, 0, 'N', 'Y', 'nacionalidad', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (214, 35, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (215, 35, 2, 'idgrem', 'numeric', 20, 0, 'N', 'Y', 'idgrem', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (216, 35, 3, 'nombrecorto', 'character', 50, 0, 'N', 'Y', 'nombrecorto', 'input', 50, 50, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (217, 35, 4, 'nombrelargo', 'character', 500, 0, 'N', 'Y', 'nombrelargo', 'input', 500, 500, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (218, 35, 5, 'descripcion', 'character', 1000, 0, 'N', 'Y', 'descripcion', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (219, 35, 6, 'valor', 'character', 500, 0, 'N', 'Y', 'valor', 'input', 500, 500, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (220, 36, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (221, 36, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (222, 37, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (223, 37, 2, 'idperf', 'numeric', 20, 0, 'N', 'Y', 'idperf', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (224, 37, 3, 'idprog', 'numeric', 20, 0, 'N', 'Y', 'idprog', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (225, 38, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (226, 38, 2, 'idgrem', 'numeric', 20, 0, 'N', 'Y', 'idgrem', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (227, 38, 3, 'identificador1', 'character', 50, 0, 'N', 'Y', 'identificador1', 'input', 50, 50, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (228, 38, 4, 'identificador2', 'character', 50, 0, 'N', 'Y', 'identificador2', 'input', 50, 50, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (229, 38, 5, 'primernombre', 'character', 100, 0, 'N', 'Y', 'primernombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (230, 38, 6, 'segundonombre', 'character', 100, 0, 'N', 'N', 'segundonombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (231, 38, 7, 'apellidopaterno', 'character', 100, 0, 'N', 'Y', 'apellidopaterno', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (232, 38, 8, 'apellidomaterno', 'character', 100, 0, 'N', 'N', 'apellidomaterno', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (233, 38, 9, 'email', 'character', 100, 0, 'N', 'N', 'email', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (234, 38, 10, 'fechanac', 'date', 0, 0, 'N', 'N', 'fechanac', 'input', 0, 0, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (235, 38, 11, 'idesci', 'numeric', 20, 0, 'N', 'N', 'idesci', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (236, 38, 12, 'idsexo', 'numeric', 20, 0, 'N', 'N', 'idsexo', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (237, 38, 13, 'idpais', 'numeric', 20, 0, 'N', 'N', 'idpais', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (238, 39, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (239, 39, 2, 'idgrem', 'numeric', 20, 0, 'N', 'Y', 'idgrem', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (240, 39, 3, 'segmento1', 'character', 100, 0, 'N', 'Y', 'segmento1', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (241, 39, 4, 'segmento2', 'character', 100, 0, 'N', 'N', 'segmento2', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (242, 39, 5, 'segmento3', 'character', 100, 0, 'N', 'N', 'segmento3', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (243, 39, 6, 'segmento4', 'character', 100, 0, 'N', 'N', 'segmento4', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (244, 39, 7, 'segmento5', 'character', 100, 0, 'N', 'N', 'segmento5', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (245, 39, 8, 'segmento6', 'character', 100, 0, 'N', 'N', 'segmento6', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (246, 39, 9, 'segmento7', 'character', 100, 0, 'N', 'N', 'segmento7', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (247, 39, 10, 'segmento8', 'character', 100, 0, 'N', 'N', 'segmento8', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (248, 39, 11, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (249, 40, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (250, 40, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (251, 40, 3, 'idtipr', 'numeric', 20, 0, 'N', 'Y', 'idtipr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (252, 40, 4, 'idunmp', 'numeric', 20, 0, 'N', 'Y', 'idunmp', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (253, 40, 5, 'idorpr', 'numeric', 20, 0, 'N', 'Y', 'idorpr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (254, 40, 6, 'nombre', 'character', 1000, 0, 'N', 'Y', 'nombre', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (255, 40, 7, 'valorunitario', 'numeric', 20, 0, 'N', 'Y', 'valorunitario', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (256, 41, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (257, 41, 2, 'idprogpadre', 'numeric', 20, 0, 'N', 'N', 'idprogpadre', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (258, 41, 3, 'titulo', 'character', 100, 0, 'N', 'Y', 'titulo', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (259, 41, 4, 'link', 'character', 100, 0, 'N', 'N', 'link', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (260, 41, 5, 'etiqueta', 'character', 100, 0, 'N', 'Y', 'etiqueta', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (261, 41, 6, 'peso', 'numeric', 20, 0, 'N', 'Y', 'peso', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (262, 42, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (263, 42, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (264, 42, 3, 'nombre', 'character', 100, 0, 'N', 'Y', 'nombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (265, 43, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (266, 43, 2, 'idgrem', 'numeric', 20, 0, 'N', 'Y', 'idgrem', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (267, 43, 3, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (268, 44, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (269, 44, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (270, 44, 3, 'idtise', 'numeric', 20, 0, 'N', 'Y', 'idtise', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (271, 44, 4, 'idunms', 'numeric', 20, 0, 'N', 'Y', 'idunms', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (272, 44, 5, 'nombre', 'character', 1000, 0, 'N', 'Y', 'nombre', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (273, 44, 6, 'valorunitario', 'numeric', 20, 0, 'N', 'Y', 'valorunitario', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (274, 45, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (275, 45, 2, 'alias', 'character', 1, 0, 'N', 'Y', 'alias', 'input', 1, 1, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (276, 45, 3, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (277, 46, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (278, 46, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (279, 46, 3, 'correlativo', 'numeric', 20, 0, 'N', 'Y', 'correlativo', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (280, 46, 4, 'idpers', 'numeric', 20, 0, 'N', 'Y', 'idpers', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (281, 46, 5, 'descripcionsolicserv', 'character', 1000, 0, 'N', 'Y', 'descripcionsolicserv', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (282, 46, 6, 'idgere', 'numeric', 20, 0, 'N', 'N', 'idgere', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (283, 46, 7, 'idproy', 'numeric', 20, 0, 'N', 'N', 'idproy', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (284, 46, 8, 'idline', 'numeric', 20, 0, 'N', 'N', 'idline', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (285, 46, 9, 'idceco', 'numeric', 20, 0, 'N', 'N', 'idceco', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (286, 46, 10, 'idtare', 'numeric', 20, 0, 'N', 'N', 'idtare', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (287, 47, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (288, 47, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (289, 47, 3, 'nombre', 'character', 100, 0, 'N', 'Y', 'nombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (290, 48, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (291, 48, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (292, 49, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (293, 49, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (294, 50, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (295, 50, 2, 'idpais', 'numeric', 20, 0, 'N', 'Y', 'idpais', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (296, 50, 3, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (297, 50, 4, 'descripcioncorta', 'character', 10, 0, 'N', 'Y', 'descripcioncorta', 'input', 10, 10, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (298, 50, 5, 'codigooficial', 'character', 10, 0, 'N', 'Y', 'codigooficial', 'input', 10, 10, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (299, 51, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (300, 51, 2, 'idgrem', 'numeric', 20, 0, 'N', 'Y', 'idgrem', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (301, 51, 3, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (302, 51, 4, 'descripcioncorta', 'character', 15, 0, 'N', 'Y', 'descripcioncorta', 'input', 15, 15, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (303, 51, 5, 'color', 'character', 50, 0, 'N', 'Y', 'color', 'input', 50, 50, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (304, 52, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (305, 52, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (306, 53, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (307, 53, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (308, 54, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (309, 54, 2, 'idtipr', 'numeric', 20, 0, 'N', 'Y', 'idtipr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (310, 54, 3, 'idimpu', 'numeric', 20, 0, 'N', 'Y', 'idimpu', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (311, 55, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (312, 55, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (313, 55, 3, 'estaexento', 'character', 1, 0, 'N', 'Y', 'estaexento', 'input', 1, 1, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (314, 56, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (315, 56, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (316, 56, 3, 'descripcioncorta', 'character', 10, 0, 'N', 'Y', 'descripcioncorta', 'input', 10, 10, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (317, 57, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (318, 57, 2, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (319, 57, 3, 'descripcioncorta', 'character', 10, 0, 'N', 'Y', 'descripcioncorta', 'input', 10, 10, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (320, 58, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (321, 58, 2, 'idpais', 'numeric', 20, 0, 'N', 'Y', 'idpais', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (322, 58, 3, 'nombre', 'character', 100, 0, 'N', 'Y', 'nombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (323, 59, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (324, 59, 2, 'idunt1', 'numeric', 20, 0, 'N', 'Y', 'idunt1', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (325, 59, 3, 'nombre', 'character', 100, 0, 'N', 'Y', 'nombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (326, 60, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (327, 60, 2, 'idunt2', 'numeric', 20, 0, 'N', 'Y', 'idunt2', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (328, 60, 3, 'nombre', 'character', 100, 0, 'N', 'Y', 'nombre', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (329, 61, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (330, 61, 2, 'username', 'character', 100, 0, 'N', 'Y', 'username', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (331, 61, 3, 'password', 'character', 100, 0, 'N', 'Y', 'password', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (332, 61, 4, 'idpers', 'numeric', 20, 0, 'N', 'Y', 'idpers', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (333, 61, 5, 'idesre', 'numeric', 20, 0, 'N', 'Y', 'idesre', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (334, 62, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (335, 62, 2, 'idusua', 'numeric', 20, 0, 'N', 'Y', 'idusua', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (336, 62, 3, 'idperf', 'numeric', 20, 0, 'N', 'Y', 'idperf', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (337, 62, 4, 'idgrem', 'numeric', 20, 0, 'N', 'N', 'idgrem', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (338, 62, 5, 'idempr', 'numeric', 20, 0, 'N', 'N', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (339, 62, 6, 'idesre', 'numeric', 20, 0, 'N', 'Y', 'idesre', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (340, 63, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (341, 63, 2, 'iddomi', 'numeric', 20, 0, 'N', 'Y', 'iddomi', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (342, 63, 3, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (343, 64, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (344, 64, 2, 'idpais', 'numeric', 20, 0, 'N', 'Y', 'idpais', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (345, 64, 3, 'nombrecorto', 'character', 10, 0, 'N', 'Y', 'nombrecorto', 'input', 10, 10, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (346, 64, 4, 'nombrelargo', 'character', 500, 0, 'N', 'Y', 'nombrelargo', 'input', 500, 500, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (347, 64, 5, 'descripcion', 'character', 1000, 0, 'N', 'Y', 'descripcion', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (348, 64, 6, 'valor', 'character', 1000, 0, 'N', 'Y', 'valor', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (349, 65, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (350, 65, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (351, 65, 3, 'nombre', 'character', 1000, 0, 'N', 'Y', 'nombre', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (352, 66, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (353, 66, 2, 'idbode', 'numeric', 20, 0, 'N', 'Y', 'idbode', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (354, 66, 3, 'idprod', 'numeric', 20, 0, 'N', 'Y', 'idprod', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (355, 66, 4, 'stock', 'numeric', 20, 0, 'N', 'Y', 'stock', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (356, 67, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (357, 67, 2, 'idfapr', 'numeric', 20, 0, 'N', 'N', 'idfapr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (358, 67, 3, 'idsfpr', 'numeric', 20, 0, 'N', 'N', 'idsfpr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (359, 67, 4, 'idprod', 'numeric', 20, 0, 'N', 'N', 'idprod', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (360, 67, 5, 'porcentajedescuento', 'numeric', 20, 0, 'N', 'N', 'porcentajedescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (361, 67, 6, 'montodescuento', 'numeric', 20, 0, 'N', 'N', 'montodescuento', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (362, 67, 7, 'idesre', 'numeric', 20, 0, 'N', 'Y', 'idesre', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (363, 68, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (364, 68, 2, 'idlipr', 'numeric', 20, 0, 'N', 'Y', 'idlipr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (365, 68, 3, 'idprod', 'numeric', 20, 0, 'N', 'Y', 'idprod', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (366, 68, 4, 'valorunitario', 'numeric', 20, 0, 'N', 'Y', 'valorunitario', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (367, 69, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (368, 69, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (369, 69, 3, 'cod_familia', 'character', 2, 0, 'N', 'Y', 'cod_familia', 'input', 2, 2, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (370, 69, 4, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (371, 70, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (372, 70, 2, 'idempr', 'numeric', 20, 0, 'N', 'Y', 'idempr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (373, 70, 3, 'correlativo', 'numeric', 20, 0, 'N', 'Y', 'correlativo', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (374, 70, 4, 'fechainicio', 'date', 0, 0, 'N', 'Y', 'fechainicio', 'input', 0, 0, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (375, 70, 5, 'fechafin', 'date', 0, 0, 'N', 'N', 'fechafin', 'input', 0, 0, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (376, 70, 6, 'observaciones', 'character', 1000, 0, 'N', 'Y', 'observaciones', 'input', 1000, 1000, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (377, 70, 7, 'idesre', 'numeric', 20, 0, 'N', 'Y', 'idesre', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (378, 71, 1, 'id', 'numeric', 20, 0, 'Y', 'Y', 'id', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (379, 71, 2, 'idfapr', 'numeric', 20, 0, 'N', 'Y', 'idfapr', 'input', 20, 20, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (380, 71, 3, 'cod_sub_familia', 'character', 2, 0, 'N', 'Y', 'cod_sub_familia', 'input', 2, 2, 5, 60, '', '', 'Y', 'N', 'P', -1);
INSERT INTO field_defs VALUES (381, 71, 4, 'descripcion', 'character', 100, 0, 'N', 'Y', 'descripcion', 'input', 100, 100, 5, 60, '', '', 'Y', 'N', 'P', -1);


--
-- Name: fode_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('fode_seq', 71, true);


--
-- Name: fopv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('fopv_seq', 1, false);


--
-- Data for Name: form_defs; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO form_defs VALUES (1, 'centros_costos', 'centros_costos', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (2, 'clientes', 'clientes', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (3, 'cotizaciones_servs_hono', 'cotizaciones_servs_hono', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (4, 'cotizaciones_ventas', 'cotizaciones_ventas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (5, 'detalles_cotizs_vtas', 'detalles_cotizs_vtas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (6, 'detalles_doctos_vtas', 'detalles_doctos_vtas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (7, 'detalles_notas_vtas', 'detalles_notas_vtas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (8, 'doctos_cotizacs_servs_hono', 'doctos_cotizacs_servs_hono', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (9, 'doctos_ordenes_servs_hono', 'doctos_ordenes_servs_hono', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (10, 'documentos_legales', 'documentos_legales', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (11, 'documentos_ventas', 'documentos_ventas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (12, 'dominios', 'dominios', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (13, 'empresas', 'empresas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (14, 'estados_civiles', 'estados_civiles', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (15, 'estados_cotizaciones_vtas', 'estados_cotizaciones_vtas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (16, 'estados_cotizacs_servs_hono', 'estados_cotizacs_servs_hono', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (17, 'estados_documentos_legales', 'estados_documentos_legales', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (18, 'estados_grem', 'estados_grem', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (19, 'estados_notas_vtas', 'estados_notas_vtas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (20, 'estados_ordenes_servs_hono', 'estados_ordenes_servs_hono', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (21, 'estados_pagos_ords_servs_hono', 'estados_pagos_ords_servs_hono', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (22, 'estados_registros', 'estados_registros', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (23, 'estados_solics_servs_hono', 'estados_solics_servs_hono', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (24, 'estados_ventas', 'estados_ventas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (25, 'gerencias', 'gerencias', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (26, 'grupos_empresariales', 'grupos_empresariales', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (27, 'impuestos', 'impuestos', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (28, 'lineas_negocios', 'lineas_negocios', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (29, 'monedas', 'monedas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (30, 'notas_ventas', 'notas_ventas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (31, 'ordenes_servicios_hono', 'ordenes_servicios_hono', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (32, 'origenes_productos', 'origenes_productos', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (33, 'pagos_ordenes_servs_hono', 'pagos_ordenes_servs_hono', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (34, 'paises', 'paises', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (35, 'parametros', 'parametros', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (36, 'perfiles', 'perfiles', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (37, 'perfiles_programas', 'perfiles_programas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (38, 'personas', 'personas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (39, 'planes_cuentas', 'planes_cuentas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (40, 'productos', 'productos', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (41, 'programas', 'programas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (42, 'proyectos', 'proyectos', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (43, 'rubros', 'rubros', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (44, 'servicios', 'servicios', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (45, 'sexos', 'sexos', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (46, 'solicitudes_servs_hono', 'solicitudes_servs_hono', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (47, 'tareas', 'tareas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (48, 'tipos_clientes', 'tipos_clientes', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (49, 'tipos_cotizaciones_vtas', 'tipos_cotizaciones_vtas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (50, 'tipos_doctos_ventas', 'tipos_doctos_ventas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (51, 'tipos_documentos_legales', 'tipos_documentos_legales', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (52, 'tipos_formas_pagos', 'tipos_formas_pagos', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (53, 'tipos_productos', 'tipos_productos', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (54, 'tipos_productos_impuestos', 'tipos_productos_impuestos', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (55, 'tipos_servicios', 'tipos_servicios', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (56, 'unidades_medidas_productos', 'unidades_medidas_productos', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (57, 'unidades_medidas_servicios', 'unidades_medidas_servicios', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (58, 'unidades_territoriales_1', 'unidades_territoriales_1', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (59, 'unidades_territoriales_2', 'unidades_territoriales_2', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (60, 'unidades_territoriales_3', 'unidades_territoriales_3', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (61, 'usuarios', 'usuarios', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (62, 'usuarios_perfiles', 'usuarios_perfiles', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (63, 'valores_dominios', 'valores_dominios', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (64, 'valores_paises', 'valores_paises', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (65, 'bodegas', 'bodegas', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (66, 'bodegas_productos', 'bodegas_productos', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (67, 'descuentos', 'descuentos', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (68, 'detalles_listas_precios', 'detalles_listas_precios', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (69, 'familias_productos', 'familias_productos', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (70, 'listas_precios', 'listas_precios', 'Y', 'Y', 'Y');
INSERT INTO form_defs VALUES (71, 'sub_familias_productos', 'sub_familias_productos', 'Y', 'Y', 'Y');


--
-- Data for Name: formas_pagos_notas_ventas; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: formas_pagos_ventas; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Name: fpnv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('fpnv_seq', 1, false);


--
-- Name: fpve_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('fpve_seq', 1, false);


--
-- Name: gere_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('gere_seq', 46, false);


--
-- Data for Name: gerencias; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO gerencias VALUES (1, 2, 'GERENCIA GENERAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (2, 2, 'GERENCIA COMERCIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (3, 2, 'GERENCIA MARKETING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (4, 2, 'GERENCIA RRHH', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (5, 2, 'GERENCIA ADM. Y FINANZAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (6, 3, 'GERENCIA GENERAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (7, 3, 'GERENCIA COMERCIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (8, 3, 'GERENCIA MARKETING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (9, 3, 'GERENCIA RRHH', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (10, 3, 'GERENCIA ADM. Y FINANZAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (11, 4, 'GERENCIA GENERAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (12, 4, 'GERENCIA COMERCIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (13, 4, 'GERENCIA MARKETING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (14, 4, 'GERENCIA RRHH', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (15, 4, 'GERENCIA ADM. Y FINANZAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (16, 5, 'GERENCIA GENERAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (17, 5, 'GERENCIA COMERCIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (18, 5, 'GERENCIA MARKETING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (19, 5, 'GERENCIA RRHH', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (20, 5, 'GERENCIA ADM. Y FINANZAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (21, 6, 'GERENCIA GENERAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (22, 6, 'GERENCIA COMERCIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (23, 6, 'GERENCIA MARKETING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (24, 6, 'GERENCIA RRHH', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (25, 6, 'GERENCIA ADM. Y FINANZAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (26, 7, 'GERENCIA GENERAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (27, 7, 'GERENCIA COMERCIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (28, 7, 'GERENCIA MARKETING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (29, 7, 'GERENCIA RRHH', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (30, 7, 'GERENCIA ADM. Y FINANZAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (31, 8, 'GERENCIA GENERAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (32, 8, 'GERENCIA COMERCIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (33, 8, 'GERENCIA MARKETING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (34, 8, 'GERENCIA RRHH', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (35, 8, 'GERENCIA ADM. Y FINANZAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (36, 9, 'GERENCIA GENERAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (37, 9, 'GERENCIA COMERCIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (38, 9, 'GERENCIA MARKETING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (39, 9, 'GERENCIA RRHH', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (40, 9, 'GERENCIA ADM. Y FINANZAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (41, 10, 'GERENCIA GENERAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (42, 10, 'GERENCIA COMERCIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (43, 10, 'GERENCIA MARKETING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (44, 10, 'GERENCIA RRHH', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO gerencias VALUES (45, 10, 'GERENCIA ADM. Y FINANZAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);


--
-- Name: grem_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('grem_seq', 5, false);


--
-- Data for Name: grupos_empresariales; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO grupos_empresariales VALUES (1, 'BUSINESS & TECHNOLOGY 5 CONSULTING', 'BT5', 'bt5.jpg', 1, 1, 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO grupos_empresariales VALUES (2, 'METALPAR', 'MPAR', 'hold_metalpar.jpg', 1, 1, 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO grupos_empresariales VALUES (3, 'CRUZ VERDE', 'CV', 'hold_cruz_verde.jpg', 1, 1, 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO grupos_empresariales VALUES (4, 'AMASANDERIA TRIGAL', 'AT', 'hold_trigal.jpg', 1, 1, 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);


--
-- Name: impu_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('impu_seq', 4, false);


--
-- Data for Name: impuestos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO impuestos VALUES (1, 1, 'IMPUESTO AL VALOR AGREGADO', 'IVA', 'S', 19.0);
INSERT INTO impuestos VALUES (2, 1, 'IMPUESTO ADICIONAL A LAS BEBIDAS ALCOHÓLICAS', 'ILA', 'N', 20.0);
INSERT INTO impuestos VALUES (3, 1, 'IMPUESTO ADICIONAL A LAS BEBIDAS ANALCOHÓLICAS', 'IABA', 'N', 5.0);


--
-- Name: line_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('line_seq', 64, false);


--
-- Data for Name: lineas_negocios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO lineas_negocios VALUES (1, 2, 'PERFILES DE ACERO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (2, 2, 'CANALETAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (3, 2, 'FIERROS CILINDRICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (4, 2, 'CONSTRUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (5, 2, 'COMERCIALIZACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (6, 2, 'IMPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (7, 2, 'EXPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (8, 3, 'PERFILES DE ACERO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (9, 3, 'CANALETAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (10, 3, 'FIERROS CILINDRICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (11, 3, 'CONSTRUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (12, 3, 'COMERCIALIZACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (13, 3, 'IMPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (14, 3, 'EXPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (15, 4, 'PERFILES DE ACERO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (16, 4, 'CANALETAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (17, 4, 'FIERROS CILINDRICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (18, 4, 'CONSTRUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (19, 4, 'COMERCIALIZACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (20, 4, 'IMPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (21, 4, 'EXPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (22, 5, 'PERFILES DE ACERO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (23, 5, 'CANALETAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (24, 5, 'FIERROS CILINDRICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (25, 5, 'CONSTRUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (26, 5, 'COMERCIALIZACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (27, 5, 'IMPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (28, 5, 'EXPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (29, 6, 'PERFILES DE ACERO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (30, 6, 'CANALETAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (31, 6, 'FIERROS CILINDRICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (32, 6, 'CONSTRUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (33, 6, 'COMERCIALIZACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (34, 6, 'IMPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (35, 6, 'EXPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (36, 7, 'PERFILES DE ACERO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (37, 7, 'CANALETAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (38, 7, 'FIERROS CILINDRICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (39, 7, 'CONSTRUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (40, 7, 'COMERCIALIZACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (41, 7, 'IMPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (42, 7, 'EXPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (43, 8, 'PERFILES DE ACERO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (44, 8, 'CANALETAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (45, 8, 'FIERROS CILINDRICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (46, 8, 'CONSTRUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (47, 8, 'COMERCIALIZACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (48, 8, 'IMPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (49, 8, 'EXPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (50, 9, 'PERFILES DE ACERO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (51, 9, 'CANALETAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (52, 9, 'FIERROS CILINDRICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (53, 9, 'CONSTRUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (54, 9, 'COMERCIALIZACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (55, 9, 'IMPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (56, 9, 'EXPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (57, 10, 'PERFILES DE ACERO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (58, 10, 'CANALETAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (59, 10, 'FIERROS CILINDRICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (60, 10, 'CONSTRUCCION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (61, 10, 'COMERCIALIZACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (62, 10, 'IMPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO lineas_negocios VALUES (63, 10, 'EXPORTACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);


--
-- Name: lipr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('lipr_seq', 3, false);


--
-- Data for Name: listas_precios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO listas_precios VALUES (1, 1, 1, '2017-01-01', '2017-12-31', 'LISTA PRECIOS 2017', 2, 1, '2018-02-18 00:37:56.820109', 1, '2018-02-18 00:37:56.820109', NULL, NULL);
INSERT INTO listas_precios VALUES (2, 1, 2, '2018-01-01', NULL, 'LISTA PRECIOS 2018', 1, 1, '2018-02-18 00:37:56.828409', NULL, NULL, NULL, NULL);


--
-- Name: mobo_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('mobo_seq', 1, false);


--
-- Name: mone_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('mone_seq', 503, false);


--
-- Data for Name: monedas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO monedas VALUES (1, 'PESO CHILENO', 'CLP');
INSERT INTO monedas VALUES (2, 'PESO ARGENTINO', 'ARS');
INSERT INTO monedas VALUES (3, 'NUEVO SOL', 'PEN');
INSERT INTO monedas VALUES (4, 'BOLIVIANO', 'BOB');
INSERT INTO monedas VALUES (5, 'GUARANÍ', 'PYG');
INSERT INTO monedas VALUES (6, 'PESO URUGUAYO', 'UYU');
INSERT INTO monedas VALUES (7, 'REAL', 'BRL');
INSERT INTO monedas VALUES (8, 'SUCRE', 'ECS');
INSERT INTO monedas VALUES (9, 'BOLIVAR', 'VEB');
INSERT INTO monedas VALUES (10, 'PESO COLOMBIANO', 'COP');
INSERT INTO monedas VALUES (11, 'DÓLAR', 'USD');
INSERT INTO monedas VALUES (501, 'UNIDAD DE FOMENTO', 'UF');
INSERT INTO monedas VALUES (502, 'UNIDAD TRIBUTARIA MENSUAL', 'UTM');


--
-- Data for Name: movimientos_bodegas; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: notas_ventas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO notas_ventas VALUES (1, 1, 1, 1, 1, 'PRUEBA', '2018-02-18 00:37:56.795116', NULL, NULL, NULL, NULL, NULL, 0, 3000, 570, 0.00000, 0, 3570, 3, 1, '2018-02-18 00:37:56.795116', NULL, NULL, NULL, NULL);


--
-- Name: nove_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('nove_seq', 2, false);


--
-- Data for Name: ordenes_servicios_hono; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: origenes_productos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO origenes_productos VALUES (1, 'NACIONAL', 'NAC');
INSERT INTO origenes_productos VALUES (2, 'IMPORTADO', 'IMP');


--
-- Name: orpr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('orpr_seq', 3, false);


--
-- Name: orsh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('orsh_seq', 1, false);


--
-- Data for Name: pagos_ordenes_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Name: pais_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('pais_seq', 11, false);


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
-- Name: para_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('para_seq', 21, false);


--
-- Data for Name: parametros; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO parametros VALUES (1, 1, 'LARGOMINCLAVE', 'LARGO MÍNIMO CLAVES USUARIOS', 'LARGO MINIMO EXIGIDO PARA LAS CLAVES DE LOS USUARIOS', '5', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (2, 1, 'NROSEGMSPLCU', 'NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS', 'NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING', '4', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (3, 1, 'UMVALNOTVE', 'UNIDAD DE MEDIDA VALIDEZ NOTA VENTA', 'H = HORAS; D = DÍAS', 'D', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (4, 1, 'CADUCNV', 'CADUCIDAD NOTAS DE VENTA', 'TIEMPO TRAS EL CUAL CADUCA UNA NOTA DE VENTA (1 DÍA, 2 HORAS, ETC.)', '1', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (5, 1, 'VALIDEZCOTI', 'DEFAULT DÍAS VALIDEZ COTIZACIÓN', 'DÍAS DE VALIDEZ POR DEFECTO DE UNA COTIZACIÓN', '5', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (6, 2, 'LARGOMINCLAVE', 'LARGO MÍNIMO CLAVES USUARIOS', 'LARGO MINIMO EXIGIDO PARA LAS CLAVES DE LOS USUARIOS', '5', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (7, 2, 'NROSEGMSPLCU', 'NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS', 'NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING', '4', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (8, 2, 'UMVALNOTVE', 'UNIDAD DE MEDIDA VALIDEZ NOTA VENTA', 'H = HORAS; D = DÍAS', 'D', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (9, 2, 'CADUCNV', 'CADUCIDAD NOTAS DE VENTA', 'TIEMPO TRAS EL CUAL CADUCA UNA NOTA DE VENTA (1 DÍA, 2 HORAS, ETC.)', '1', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (10, 2, 'VALIDEZCOTI', 'DEFAULT DÍAS VALIDEZ COTIZACIÓN', 'DÍAS DE VALIDEZ POR DEFECTO DE UNA COTIZACIÓN', '5', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (11, 3, 'LARGOMINCLAVE', 'LARGO MÍNIMO CLAVES USUARIOS', 'LARGO MINIMO EXIGIDO PARA LAS CLAVES DE LOS USUARIOS', '5', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (12, 3, 'NROSEGMSPLCU', 'NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS', 'NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING', '4', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (13, 3, 'UMVALNOTVE', 'UNIDAD DE MEDIDA VALIDEZ NOTA VENTA', 'H = HORAS; D = DÍAS', 'D', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (14, 3, 'CADUCNV', 'CADUCIDAD NOTAS DE VENTA', 'TIEMPO TRAS EL CUAL CADUCA UNA NOTA DE VENTA (1 DÍA, 2 HORAS, ETC.)', '1', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (15, 3, 'VALIDEZCOTI', 'DEFAULT DÍAS VALIDEZ COTIZACIÓN', 'DÍAS DE VALIDEZ POR DEFECTO DE UNA COTIZACIÓN', '5', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (16, 4, 'LARGOMINCLAVE', 'LARGO MÍNIMO CLAVES USUARIOS', 'LARGO MINIMO EXIGIDO PARA LAS CLAVES DE LOS USUARIOS', '5', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (17, 4, 'NROSEGMSPLCU', 'NUMERO DE SEGMENTOS EN EL PLAN DE CUENTAS', 'NUMERO DE SEGMENTOS QUE COMPONEN EL PLAN DE CUENTAS DE ESTE HOLDING', '4', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (18, 4, 'UMVALNOTVE', 'UNIDAD DE MEDIDA VALIDEZ NOTA VENTA', 'H = HORAS; D = DÍAS', 'D', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (19, 4, 'CADUCNV', 'CADUCIDAD NOTAS DE VENTA', 'TIEMPO TRAS EL CUAL CADUCA UNA NOTA DE VENTA (1 DÍA, 2 HORAS, ETC.)', '1', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO parametros VALUES (20, 4, 'VALIDEZCOTI', 'DEFAULT DÍAS VALIDEZ COTIZACIÓN', 'DÍAS DE VALIDEZ POR DEFECTO DE UNA COTIZACIÓN', '5', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);


--
-- Name: pepr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('pepr_seq', 229, false);


--
-- Name: perf_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('perf_seq', 2024, false);


--
-- Data for Name: perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO perfiles VALUES (1, 'CONFIGURADOR');
INSERT INTO perfiles VALUES (2, 'ADMINISTRADOR DEL CLIENTE');
INSERT INTO perfiles VALUES (3, 'ADMINISTRADOR EMPRESA');
INSERT INTO perfiles VALUES (4, 'ADMINISTRADOR DEL CLIENTE Y EMPRESA');
INSERT INTO perfiles VALUES (5, 'GERENTE GENERAL');
INSERT INTO perfiles VALUES (6, 'SECRETARIA GERENTE GENERAL');
INSERT INTO perfiles VALUES (7, 'GERENTE DE ADMINISTRACION Y FINANZAS');
INSERT INTO perfiles VALUES (8, 'SECRETARIA GERENTE DE ADMINISTRACION Y FINANZAS');
INSERT INTO perfiles VALUES (9, 'TESORERO');
INSERT INTO perfiles VALUES (10, 'ASISTENTE 1 TESORERO');
INSERT INTO perfiles VALUES (11, 'ASISTENTE 2 TESORERO');
INSERT INTO perfiles VALUES (12, 'CAJERO');
INSERT INTO perfiles VALUES (13, 'CONTADOR GENERAL');
INSERT INTO perfiles VALUES (14, 'ASISTENTE 1 CONTABILIDAD');
INSERT INTO perfiles VALUES (15, 'ASISTENTE 2 CONTABILIDAD');
INSERT INTO perfiles VALUES (16, 'JEFE DE COMPRAS');
INSERT INTO perfiles VALUES (17, 'AYUDANTE JEFE DE COMPRAS');
INSERT INTO perfiles VALUES (18, 'JEFE DE VENTAS');
INSERT INTO perfiles VALUES (19, 'AYUDANTE JEFE DE VENTAS');
INSERT INTO perfiles VALUES (20, 'VENDEDOR');
INSERT INTO perfiles VALUES (21, 'USUARIO');
INSERT INTO perfiles VALUES (272, 'PERFIL DE PRUEBA CON ACCESO A TODO');
INSERT INTO perfiles VALUES (2023, 'PERFIL DE PRUEBA LEGALES');


--
-- Data for Name: perfiles_programas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO perfiles_programas VALUES (1, 1, 1000, 1, '2018-02-18 00:37:52.467832', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (2, 1, 1010, 1, '2018-02-18 00:37:52.476173', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (3, 1, 1020, 1, '2018-02-18 00:37:52.484547', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (4, 1, 2000, 1, '2018-02-18 00:37:52.492838', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (5, 1, 2010, 1, '2018-02-18 00:37:52.501157', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (6, 1, 2020, 1, '2018-02-18 00:37:52.55116', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (7, 1, 2030, 1, '2018-02-18 00:37:52.55956', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (8, 1, 2040, 1, '2018-02-18 00:37:52.567866', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (9, 1, 2050, 1, '2018-02-18 00:37:52.576192', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (10, 1, 2060, 1, '2018-02-18 00:37:52.584513', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (11, 1, 2070, 1, '2018-02-18 00:37:52.592931', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (12, 1, 2080, 1, '2018-02-18 00:37:52.601228', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (13, 1, 2090, 1, '2018-02-18 00:37:52.609571', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (14, 1, 2100, 1, '2018-02-18 00:37:52.617918', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (15, 1, 2110, 1, '2018-02-18 00:37:52.626203', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (16, 1, 2120, 1, '2018-02-18 00:37:52.634572', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (17, 1, 2130, 1, '2018-02-18 00:37:52.684582', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (18, 1, 2140, 1, '2018-02-18 00:37:52.692922', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (19, 1, 2150, 1, '2018-02-18 00:37:52.701222', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (20, 1, 2160, 1, '2018-02-18 00:37:52.709572', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (21, 1, 2170, 1, '2018-02-18 00:37:52.717922', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (22, 1, 2180, 1, '2018-02-18 00:37:52.726218', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (23, 1, 2190, 1, '2018-02-18 00:37:52.734501', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (24, 1, 2200, 1, '2018-02-18 00:37:52.742885', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (25, 1, 2210, 1, '2018-02-18 00:37:52.75123', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (26, 1, 2220, 1, '2018-02-18 00:37:52.759576', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (27, 1, 2230, 1, '2018-02-18 00:37:52.767889', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (28, 1, 2240, 1, '2018-02-18 00:37:52.817897', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (29, 1, 2250, 1, '2018-02-18 00:37:52.826242', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (30, 2, 1000, 1, '2018-02-18 00:37:52.834568', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (31, 2, 1010, 1, '2018-02-18 00:37:52.842949', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (32, 2, 1020, 1, '2018-02-18 00:37:52.851249', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (33, 2, 3000, 1, '2018-02-18 00:37:52.859609', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (34, 2, 3010, 1, '2018-02-18 00:37:52.867951', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (35, 2, 3020, 1, '2018-02-18 00:37:52.876241', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (36, 2, 3030, 1, '2018-02-18 00:37:52.884586', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (37, 2, 3040, 1, '2018-02-18 00:37:52.892953', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (38, 2, 3050, 1, '2018-02-18 00:37:52.901242', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (39, 2, 3060, 1, '2018-02-18 00:37:52.951249', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (40, 2, 3070, 1, '2018-02-18 00:37:52.959605', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (41, 2, 3080, 1, '2018-02-18 00:37:52.967948', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (42, 2, 3090, 1, '2018-02-18 00:37:52.976234', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (43, 3, 1000, 1, '2018-02-18 00:37:52.984582', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (44, 3, 1010, 1, '2018-02-18 00:37:52.992944', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (45, 3, 1020, 1, '2018-02-18 00:37:53.001237', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (46, 3, 4000, 1, '2018-02-18 00:37:53.009586', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (47, 3, 4010, 1, '2018-02-18 00:37:53.017939', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (48, 3, 4020, 1, '2018-02-18 00:37:53.026297', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (49, 3, 4030, 1, '2018-02-18 00:37:53.034682', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (50, 3, 4040, 1, '2018-02-18 00:37:53.084684', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (51, 3, 4050, 1, '2018-02-18 00:37:53.09303', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (52, 3, 4060, 1, '2018-02-18 00:37:53.101325', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (53, 3, 4070, 1, '2018-02-18 00:37:53.109668', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (54, 4, 1000, 1, '2018-02-18 00:37:53.117997', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (55, 4, 1010, 1, '2018-02-18 00:37:53.126359', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (56, 4, 1020, 1, '2018-02-18 00:37:53.134653', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (57, 4, 3000, 1, '2018-02-18 00:37:53.14299', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (58, 4, 3010, 1, '2018-02-18 00:37:53.151372', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (59, 4, 3020, 1, '2018-02-18 00:37:53.159667', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (60, 4, 3030, 1, '2018-02-18 00:37:53.167999', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (61, 4, 3040, 1, '2018-02-18 00:37:53.217991', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (62, 4, 3060, 1, '2018-02-18 00:37:53.226322', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (63, 4, 3070, 1, '2018-02-18 00:37:53.234648', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (64, 4, 3080, 1, '2018-02-18 00:37:53.242988', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (65, 4, 3090, 1, '2018-02-18 00:37:53.251358', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (66, 4, 4000, 1, '2018-02-18 00:37:53.25965', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (67, 4, 4010, 1, '2018-02-18 00:37:53.268041', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (68, 4, 4020, 1, '2018-02-18 00:37:53.276404', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (69, 4, 4030, 1, '2018-02-18 00:37:53.28471', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (70, 4, 4040, 1, '2018-02-18 00:37:53.293046', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (71, 4, 4050, 1, '2018-02-18 00:37:53.301405', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (72, 4, 4060, 1, '2018-02-18 00:37:53.351404', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (73, 4, 4070, 1, '2018-02-18 00:37:53.359712', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (74, 4, 5000, 1, '2018-02-18 00:37:53.36804', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (75, 4, 5010, 1, '2018-02-18 00:37:53.376391', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (76, 4, 5020, 1, '2018-02-18 00:37:53.384707', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (77, 4, 11000, 1, '2018-02-18 00:37:53.39304', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (78, 4, 11010, 1, '2018-02-18 00:37:53.401366', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (79, 4, 11020, 1, '2018-02-18 00:37:53.409703', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (80, 4, 11030, 1, '2018-02-18 00:37:53.418033', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (81, 4, 11040, 1, '2018-02-18 00:37:53.426392', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (82, 5, 1000, 1, '2018-02-18 00:37:53.434703', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (83, 5, 1010, 1, '2018-02-18 00:37:53.484709', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (84, 5, 1020, 1, '2018-02-18 00:37:53.493039', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (85, 6, 1000, 1, '2018-02-18 00:37:53.501449', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (86, 6, 1010, 1, '2018-02-18 00:37:53.509769', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (87, 6, 1020, 1, '2018-02-18 00:37:53.518108', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (88, 7, 1000, 1, '2018-02-18 00:37:53.52643', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (89, 7, 1010, 1, '2018-02-18 00:37:53.534767', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (90, 7, 1020, 1, '2018-02-18 00:37:53.543104', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (91, 8, 1000, 1, '2018-02-18 00:37:53.55146', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (92, 8, 1010, 1, '2018-02-18 00:37:53.55979', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (93, 8, 1020, 1, '2018-02-18 00:37:53.568101', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (94, 9, 1000, 1, '2018-02-18 00:37:53.6181', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (95, 9, 1010, 1, '2018-02-18 00:37:53.62644', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (96, 9, 1020, 1, '2018-02-18 00:37:53.634684', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (97, 10, 1000, 1, '2018-02-18 00:37:53.643108', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (98, 10, 1010, 1, '2018-02-18 00:37:53.651433', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (99, 10, 1020, 1, '2018-02-18 00:37:53.65978', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (100, 11, 1000, 1, '2018-02-18 00:37:53.668103', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (101, 11, 1010, 1, '2018-02-18 00:37:53.67644', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (102, 11, 1020, 1, '2018-02-18 00:37:53.684773', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (103, 12, 1000, 1, '2018-02-18 00:37:53.69311', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (104, 12, 1010, 1, '2018-02-18 00:37:53.701487', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (105, 12, 1020, 1, '2018-02-18 00:37:53.759852', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (106, 13, 1000, 1, '2018-02-18 00:37:53.768179', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (107, 13, 1010, 1, '2018-02-18 00:37:53.776488', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (108, 13, 1020, 1, '2018-02-18 00:37:53.784842', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (109, 14, 1000, 1, '2018-02-18 00:37:53.793174', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (110, 14, 1010, 1, '2018-02-18 00:37:53.801481', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (111, 14, 1020, 1, '2018-02-18 00:37:53.809834', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (112, 15, 1000, 1, '2018-02-18 00:37:53.818167', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (113, 15, 1010, 1, '2018-02-18 00:37:53.826485', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (114, 15, 1020, 1, '2018-02-18 00:37:53.834838', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (115, 16, 1000, 1, '2018-02-18 00:37:53.843171', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (116, 16, 1010, 1, '2018-02-18 00:37:53.893174', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (117, 16, 1020, 1, '2018-02-18 00:37:53.901474', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (118, 17, 1000, 1, '2018-02-18 00:37:53.909829', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (119, 17, 1010, 1, '2018-02-18 00:37:53.918163', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (120, 17, 1020, 1, '2018-02-18 00:37:53.926483', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (121, 18, 1000, 1, '2018-02-18 00:37:53.934824', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (122, 18, 1010, 1, '2018-02-18 00:37:53.94318', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (123, 18, 1020, 1, '2018-02-18 00:37:53.951545', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (124, 19, 1000, 1, '2018-02-18 00:37:53.9599', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (125, 19, 1010, 1, '2018-02-18 00:37:53.96822', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (126, 19, 1020, 1, '2018-02-18 00:37:53.976549', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (127, 21, 1000, 1, '2018-02-18 00:37:54.026564', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (128, 21, 1010, 1, '2018-02-18 00:37:54.034872', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (129, 21, 1020, 1, '2018-02-18 00:37:54.043198', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (130, 21, 5000, 1, '2018-02-18 00:37:54.051512', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (131, 21, 5010, 1, '2018-02-18 00:37:54.059875', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (132, 21, 5020, 1, '2018-02-18 00:37:54.068203', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (134, 272, 1000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (135, 272, 1010, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (136, 272, 1020, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (137, 272, 2000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (138, 272, 2010, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (139, 272, 2020, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (140, 272, 2030, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (141, 272, 2040, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (142, 272, 2050, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (143, 272, 2060, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (144, 272, 2070, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (145, 272, 2080, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (146, 272, 2090, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (147, 272, 2100, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (148, 272, 2110, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (149, 272, 2120, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (150, 272, 2130, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (151, 272, 2140, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (152, 272, 2150, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (153, 272, 2160, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (154, 272, 2170, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (155, 272, 2180, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (156, 272, 2190, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (157, 272, 2200, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (158, 272, 2210, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (159, 272, 2220, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (160, 272, 2230, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (161, 272, 2240, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (162, 272, 2250, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (163, 272, 3000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (164, 272, 3010, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (165, 272, 3020, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (166, 272, 3030, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (167, 272, 3040, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (168, 272, 3050, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (169, 272, 3060, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (170, 272, 3070, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (171, 272, 3080, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (172, 272, 3090, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (173, 272, 4000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (174, 272, 4010, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (175, 272, 4020, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (176, 272, 4030, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (177, 272, 4040, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (178, 272, 4050, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (179, 272, 4060, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (180, 272, 4070, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (181, 272, 5000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (182, 272, 5010, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (183, 272, 5020, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (184, 272, 6000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (185, 272, 6010, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (186, 272, 6020, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (187, 272, 6030, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (188, 272, 6040, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (189, 272, 6050, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (190, 272, 7000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (191, 272, 7010, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (192, 272, 7020, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (193, 272, 7030, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (194, 272, 7040, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (195, 272, 7050, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (196, 272, 8000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (197, 272, 8010, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (198, 272, 8020, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (199, 272, 8030, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (200, 272, 8040, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (201, 272, 8050, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (202, 272, 9000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (203, 272, 9010, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (204, 272, 9020, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (205, 272, 9030, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (206, 272, 9040, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (207, 272, 9050, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (208, 272, 10000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (209, 272, 10010, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (210, 272, 10020, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (211, 272, 10030, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (212, 272, 10040, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (213, 272, 10050, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (214, 272, 11000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (215, 272, 11010, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (216, 272, 11020, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (217, 272, 11030, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (218, 272, 11040, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (219, 272, 99000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (220, 2023, 1000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (221, 2023, 1010, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (222, 2023, 1020, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (223, 2023, 3000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (224, 2023, 3070, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (225, 2023, 3080, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (226, 2023, 5000, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (227, 2023, 5010, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO perfiles_programas VALUES (228, 2023, 5020, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);


--
-- Name: pers_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('pers_seq', 14, false);


--
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO personas VALUES (1, 1, '1', '9', 'ADMINISTRADOR', NULL, 'SISTEMA', 'AS', NULL, NULL, NULL, NULL, NULL, 1, '2018-02-18 00:37:42.020293', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (2, 1, '2', '7', 'ROLANDO', NULL, 'SILVA', '-', '', NULL, 2, 1, 1, 1, '2018-02-18 00:37:42.146656', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (3, 1, '3', '5', 'SERGIO', NULL, 'AGUIRRE', '-', 'sergio.aguirre@bt5.cl', NULL, 1, 1, 1, 1, '2018-02-18 00:37:42.154993', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (4, 1, '4', '3', 'JUAN', 'JOSE', 'MONSALVE', '-', 'juan.jose.monsalve@bt5.cl', NULL, NULL, 1, 1, 1, '2018-02-18 00:37:42.16327', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (5, 1, '5', '1', 'JUAN', 'ANDRES', 'BORZONE', '-', '', NULL, NULL, 1, 1, 1, '2018-02-18 00:37:42.171653', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (6, 1, '6', 'K', 'RODRIGO', NULL, 'CIFUENTES', '-', 'rodrigo.cifuentes@bt5.cl', NULL, 1, 1, 1, 1, '2018-02-18 00:37:42.179975', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (7, 1, '7695503', '4', 'ROBERTO', 'DANIEL', 'QUEZADA', 'ASTE', 'roberto.quezada@bt5.cl', NULL, 2, 1, 1, 1, '2018-02-18 00:37:42.188254', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (8, 1, '8965445', '9', 'OSCIEL', 'SEGUNDO', 'SOLAR', 'MALDONADO', 'solar2design@gmail.com', NULL, 2, 1, 1, 1, '2018-02-18 00:37:42.238272', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (9, 1, '13254825', '0', 'NILTON', 'PATRICIO', 'SALAZAR', 'GONZALEZ', 'nilton.salazar@gmail.com', NULL, 1, 1, 1, 1, '2018-02-18 00:37:42.246653', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (10, 1, '10917721', '0', 'G. CRISTIAN', NULL, 'PALMA', 'ASTE', 'gerardo.palma.aste@gmail.com', '1968-11-12', 1, 1, 1, 1, '2018-02-18 00:37:42.254977', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (11, 2, '13047104', '8', 'JUAN', NULL, 'CISTERNA', 'FUENTES', NULL, NULL, NULL, NULL, NULL, 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (12, 1, '999', '7', 'USUARIO', NULL, 'ACCESO', 'TOTAL', NULL, NULL, NULL, NULL, NULL, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO personas VALUES (13, 1, '99', 'K', 'UBALDO', NULL, 'LEGALES', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);


--
-- Data for Name: planes_cuentas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO planes_cuentas VALUES (1, 1, '1', '00', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (2, 1, '1', '10', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS CORRIENTES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (3, 1, '1', '10', '10', '0000', NULL, NULL, NULL, NULL, 'EFECTIVO Y EQUIVALENTE AL EFECTIVO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (4, 1, '1', '10', '10', '1001', NULL, NULL, NULL, NULL, 'CAJA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (5, 1, '1', '10', '10', '1002', NULL, NULL, NULL, NULL, 'FONDO FIJO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (6, 1, '1', '10', '10', '2001', NULL, NULL, NULL, NULL, 'BANCO SANTANDER', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (7, 1, '1', '10', '10', '2002', NULL, NULL, NULL, NULL, 'BANCO DE CHILE', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (8, 1, '1', '10', '10', '2003', NULL, NULL, NULL, NULL, 'BANCO BBVA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (9, 1, '1', '10', '10', '2004', NULL, NULL, NULL, NULL, 'BANCO BCI', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (10, 1, '1', '10', '10', '2005', NULL, NULL, NULL, NULL, 'BANCO ITAU', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (11, 1, '1', '10', '10', '2006', NULL, NULL, NULL, NULL, 'BANCO SECURITY', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (12, 1, '1', '10', '10', '2007', NULL, NULL, NULL, NULL, 'BANCO SANTANDER DOLAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (13, 1, '1', '10', '10', '2008', NULL, NULL, NULL, NULL, 'BANCO DE CHILE DOLAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (14, 1, '1', '10', '10', '2009', NULL, NULL, NULL, NULL, 'BANCO BBVA DOLAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (15, 1, '1', '10', '10', '2010', NULL, NULL, NULL, NULL, 'BANCO BCI DOLAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (16, 1, '1', '10', '10', '2011', NULL, NULL, NULL, NULL, 'BANCO ITAU DOLAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (17, 1, '1', '10', '10', '2012', NULL, NULL, NULL, NULL, 'BANCO SECURITY DOLAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (18, 1, '1', '10', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (19, 1, '1', '10', '11', '0001', NULL, NULL, NULL, NULL, 'DEPOSITOS A PLAZO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (20, 1, '1', '10', '11', '1002', NULL, NULL, NULL, NULL, 'FONDOS MUTUOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (21, 1, '1', '10', '11', '1003', NULL, NULL, NULL, NULL, 'PACTOS RETROVENTA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (22, 1, '1', '10', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (23, 1, '1', '10', '13', '0000', NULL, NULL, NULL, NULL, 'DEUDORES COMERCIALES Y OTRAS CUENTAS POR COBRAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (24, 1, '1', '10', '13', '1001', NULL, NULL, NULL, NULL, 'CLIENTES NACIONALES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (25, 1, '1', '10', '13', '1002', NULL, NULL, NULL, NULL, 'CLIENTES EXTRANJEROS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (26, 1, '1', '10', '13', '1003', NULL, NULL, NULL, NULL, 'CHEQUES EN CARTERA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (27, 1, '1', '10', '13', '1004', NULL, NULL, NULL, NULL, 'TARJETA DE DEBITO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (28, 1, '1', '10', '13', '1005', NULL, NULL, NULL, NULL, 'TARJETA DE CREDITO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (29, 1, '1', '10', '13', '1006', NULL, NULL, NULL, NULL, 'CHEQUES PROTESTADOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (30, 1, '1', '10', '13', '1007', NULL, NULL, NULL, NULL, 'DOCUMENTOS PROTESTADOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (31, 1, '1', '10', '13', '2001', NULL, NULL, NULL, NULL, 'ESTIMACION DEUDORES INCOBRABLES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (32, 1, '1', '10', '13', '3001', NULL, NULL, NULL, NULL, 'FONDOS POR RENDIR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (33, 1, '1', '10', '13', '4001', NULL, NULL, NULL, NULL, 'PRESTAMOS AL PERSONAL', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (34, 1, '1', '10', '13', '5001', NULL, NULL, NULL, NULL, 'ANTICIPO DE SUELDO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (35, 1, '1', '10', '13', '5002', NULL, NULL, NULL, NULL, 'ANTICIPO DE HONORARIOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (36, 1, '1', '10', '13', '5003', NULL, NULL, NULL, NULL, 'ANTICIPO A PROVEEDORES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (37, 1, '1', '10', '14', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (38, 1, '1', '10', '14', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA NACIONAL', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (39, 1, '1', '10', '14', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA EXTRANJERA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (40, 1, '1', '10', '15', '0000', NULL, NULL, NULL, NULL, 'INVENTARIOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (41, 1, '1', '10', '15', '1001', NULL, NULL, NULL, NULL, 'EXISTENCIA EN TRANSITO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (42, 1, '1', '10', '15', '1002', NULL, NULL, NULL, NULL, 'EXISTENCIAS EN PROCESO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (43, 1, '1', '10', '15', '2001', NULL, NULL, NULL, NULL, 'EXISTENCIAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (44, 1, '1', '10', '16', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (45, 1, '1', '10', '17', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (46, 1, '1', '10', '17', '1001', NULL, NULL, NULL, NULL, 'PAGOS PROVISIONALES MENSUALES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (47, 1, '1', '10', '17', '1002', NULL, NULL, NULL, NULL, 'IVA CREDITO FISCAL', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (48, 1, '1', '10', '17', '2001', NULL, NULL, NULL, NULL, 'OTROS IMPUESTOS POR RECUPERAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (49, 1, '1', '10', '19', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (50, 1, '1', '10', '19', '1001', NULL, NULL, NULL, NULL, 'ACTIVOS DISPONIBLES MANTENIDOS PARA LA VENTA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (51, 1, '1', '10', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA DISTRIBUIR A PROPIETARIOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (52, 1, '1', '10', '21', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA O A DISTRIBUIR A LOS PROPIETARIOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (53, 1, '1', '20', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS NO CORRIENTES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (54, 1, '1', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (55, 1, '1', '20', '10', '1001', NULL, NULL, NULL, NULL, 'SEGUROS PAGADOS POR ANTICIPADO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (56, 1, '1', '20', '10', '1002', NULL, NULL, NULL, NULL, 'ARRIENDOS PAGADOS POR ANTICIPADO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (57, 1, '1', '20', '10', '1003', NULL, NULL, NULL, NULL, 'OTROS GASTOS PAGADOS POR ANTICIPADO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (58, 1, '1', '20', '10', '1004', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (59, 1, '1', '20', '10', '2001', NULL, NULL, NULL, NULL, 'INTERESES DIFERIDOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (60, 1, '1', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (61, 1, '1', '20', '12', '0000', NULL, NULL, NULL, NULL, 'DERECHOS POR COBRAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (62, 1, '1', '20', '13', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (63, 1, '1', '20', '14', '0000', NULL, NULL, NULL, NULL, 'INVERSIONES POR METODO DE PARTICIPACION', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (64, 1, '1', '20', '15', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS INTANGIBLES DISTINTO A LA PLUSVALIA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (65, 1, '1', '20', '16', '0000', NULL, NULL, NULL, NULL, 'PLUSVALIA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (66, 1, '1', '20', '17', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES, PLANTAS Y EQUIPOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (67, 1, '1', '20', '17', '1001', NULL, NULL, NULL, NULL, 'TERRENOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (68, 1, '1', '20', '17', '2001', NULL, NULL, NULL, NULL, 'CONSTRUCCIONES E INTALACIONES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (69, 1, '1', '20', '17', '3001', NULL, NULL, NULL, NULL, 'MUEBLES E UTILES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (70, 1, '1', '20', '17', '4001', NULL, NULL, NULL, NULL, 'VEHICULOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (71, 1, '1', '20', '17', '5001', NULL, NULL, NULL, NULL, 'EQUIPOS COMPUTACIONALES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (72, 1, '1', '20', '17', '6001', NULL, NULL, NULL, NULL, 'ACTIVOS EN LEASING', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (73, 1, '1', '20', '17', '7001', NULL, NULL, NULL, NULL, 'PROGRAMAS Y SOFTWARES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (74, 1, '1', '20', '17', '8001', NULL, NULL, NULL, NULL, 'DEPRECIACION ACUMULADA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (75, 1, '1', '20', '18', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (76, 1, '1', '20', '19', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES DE INVERSION', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (77, 1, '1', '20', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTO DIFERIDO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (78, 1, '2', '00', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (79, 1, '2', '10', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CORRIENTES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (80, 1, '2', '10', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (81, 1, '2', '10', '10', '1001', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON BANCOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (82, 1, '2', '10', '10', '1002', NULL, NULL, NULL, NULL, 'LINEAS DE CREDITO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (83, 1, '2', '10', '10', '1003', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON LEASING', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (84, 1, '2', '10', '11', '0000', NULL, NULL, NULL, NULL, 'CUENTAS COMERCIALES Y OTRAS CUENTAS POR PAGAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (85, 1, '2', '10', '11', '1001', NULL, NULL, NULL, NULL, 'PROVEEDORES NACIONALES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (86, 1, '2', '10', '11', '1002', NULL, NULL, NULL, NULL, 'PROVEEDORES EXTRANJEROS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (87, 1, '2', '10', '11', '1003', NULL, NULL, NULL, NULL, 'CHEQUES POR PAGAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (88, 1, '2', '10', '11', '1004', NULL, NULL, NULL, NULL, 'HONORARIOS POR PAGAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (89, 1, '2', '10', '11', '1005', NULL, NULL, NULL, NULL, 'ANTICIPOS DE CLIENTES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (90, 1, '2', '10', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (91, 1, '2', '10', '12', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA NACIONAL', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (92, 1, '2', '10', '12', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA EXTRANJERA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (93, 1, '2', '10', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (94, 1, '2', '10', '13', '1001', NULL, NULL, NULL, NULL, 'PROVISIONES POR PAGAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (95, 1, '2', '10', '13', '2001', NULL, NULL, NULL, NULL, 'PROVISION DE VACACIONES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (96, 1, '2', '10', '13', '2002', NULL, NULL, NULL, NULL, 'PROVISIONES VARIAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (97, 1, '2', '10', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (98, 1, '2', '10', '14', '1001', NULL, NULL, NULL, NULL, 'IVA DEBITO FISCAL', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (99, 1, '2', '10', '14', '1002', NULL, NULL, NULL, NULL, 'IVA POR PAGAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (100, 1, '2', '10', '14', '1003', NULL, NULL, NULL, NULL, 'RETENCION 1RA CATEGORIA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (101, 1, '2', '10', '14', '1004', NULL, NULL, NULL, NULL, 'RETENCION 2DA CATEGORIA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (102, 1, '2', '10', '14', '1005', NULL, NULL, NULL, NULL, 'PPM POR PAGAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (103, 1, '2', '10', '14', '2001', NULL, NULL, NULL, NULL, 'PROVISION IMPUESTO A LA RENTA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (104, 1, '2', '10', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A EMPLEADOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (105, 1, '2', '10', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (106, 1, '2', '10', '18', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CLASIFICADOS COMO MANTENIDOS PARA LA VENTA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (107, 1, '2', '20', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS NO CORRIENTES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (108, 1, '2', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (109, 1, '2', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS CUENTAS POR PAGAR', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (110, 1, '2', '20', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (111, 1, '2', '20', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (112, 1, '2', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS DIFERIDOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (113, 1, '2', '20', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A LOS EMPLEADOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (114, 1, '2', '20', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (115, 1, '2', '30', '00', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO  ', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (116, 1, '2', '30', '10', '0000', NULL, NULL, NULL, NULL, 'CAPITAL EMITIDO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (117, 1, '2', '30', '10', '0001', NULL, NULL, NULL, NULL, 'CAPITAL', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (118, 1, '2', '30', '11', '0000', NULL, NULL, NULL, NULL, 'GANANCIAS (PERDIDAS) ACUMULADAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (119, 1, '2', '30', '11', '0001', NULL, NULL, NULL, NULL, 'RESULTADO ACUMULADO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (120, 1, '2', '30', '12', '0000', NULL, NULL, NULL, NULL, 'PRIMAS DE EMISION', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (121, 1, '2', '30', '13', '0000', NULL, NULL, NULL, NULL, 'ACCIONES PROPIAS EN CARTERA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (122, 1, '2', '30', '14', '0000', NULL, NULL, NULL, NULL, 'OTRAS PARTICIPACIONES EN EL PATRIMONIO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (123, 1, '2', '30', '15', '0000', NULL, NULL, NULL, NULL, 'OTRAS RESERVAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (124, 1, '2', '30', '16', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO ATRIBUIBLE A PROPIETARIOS DE LA CONTROLADORA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (125, 1, '2', '30', '17', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACIONES NO CONTROLADORAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (126, 1, '3', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO GANANCIA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (127, 1, '3', '10', '10', '0000', NULL, NULL, NULL, NULL, 'INGRESOS DE ACTIVIDADES ORDINARIAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (128, 1, '3', '10', '10', '1001', NULL, NULL, NULL, NULL, 'VENTA DE GRUAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (129, 1, '3', '10', '10', '1002', NULL, NULL, NULL, NULL, 'VENTA DE ACCESORIAS DE GRUAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (130, 1, '3', '10', '10', '1003', NULL, NULL, NULL, NULL, 'VENTA DE PLATAFORMAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (131, 1, '3', '10', '10', '1004', NULL, NULL, NULL, NULL, 'VENTA DE REPUESTOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (132, 1, '3', '10', '10', '1005', NULL, NULL, NULL, NULL, 'VENTA DE SERVICIO TECNICO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (133, 1, '3', '10', '10', '1006', NULL, NULL, NULL, NULL, 'VENTA DE LEASING', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (134, 1, '3', '10', '10', '2001', NULL, NULL, NULL, NULL, 'ARRIENDOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (135, 1, '3', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS INGRESOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (136, 1, '3', '20', '10', '1001', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (137, 1, '3', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS GANANCIAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (138, 1, '3', '20', '12', '0000', NULL, NULL, NULL, NULL, 'INGRESOS FINANCIEROS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (139, 1, '4', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO PERDIDA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (140, 1, '4', '10', '00', '0000', NULL, NULL, NULL, NULL, 'COSTO DE VENTA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (141, 1, '4', '10', '10', '1001', NULL, NULL, NULL, NULL, 'COSTO DE GRUAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (142, 1, '4', '10', '10', '1002', NULL, NULL, NULL, NULL, 'COSTO DE ACCESORIAS DE GRUAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (143, 1, '4', '10', '10', '1003', NULL, NULL, NULL, NULL, 'COSTO DE PLATAFORMAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (144, 1, '4', '10', '10', '1004', NULL, NULL, NULL, NULL, 'COSTO DE REPUESTOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (145, 1, '4', '10', '10', '1005', NULL, NULL, NULL, NULL, 'COSTO DE SERVICIO TECNICO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (146, 1, '4', '10', '10', '1006', NULL, NULL, NULL, NULL, 'COSTO DE LEASING', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (147, 1, '4', '10', '10', '2001', NULL, NULL, NULL, NULL, 'COSTO DE ARRIENDO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (148, 1, '4', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS COSTOS DE EXPLOTACION', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (149, 1, '4', '20', '11', '0000', NULL, NULL, NULL, NULL, 'GASTOS DE ADMINISTRACION Y VENTA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (150, 1, '4', '20', '11', '1001', NULL, NULL, NULL, NULL, 'REMUNERACIONES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (151, 1, '4', '20', '11', '1002', NULL, NULL, NULL, NULL, 'COMISIONES POR VENTA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (152, 1, '4', '20', '11', '1003', NULL, NULL, NULL, NULL, 'FINIQUITOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (153, 1, '4', '20', '11', '2001', NULL, NULL, NULL, NULL, 'ASESORIA INFORMATICA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (154, 1, '4', '20', '11', '2002', NULL, NULL, NULL, NULL, 'ASESORIA COMEX', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (155, 1, '4', '20', '11', '2003', NULL, NULL, NULL, NULL, 'ASESORIA DE MARKETING', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (156, 1, '4', '20', '11', '2004', NULL, NULL, NULL, NULL, 'ASESORIA LEGAL', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (157, 1, '4', '20', '11', '2005', NULL, NULL, NULL, NULL, 'ASESORIA CONTABLE', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (158, 1, '4', '20', '11', '2006', NULL, NULL, NULL, NULL, 'ASESORIA TECNICA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (159, 1, '4', '20', '11', '3001', NULL, NULL, NULL, NULL, 'GASTOS DE PUBLICIDAD', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (160, 1, '4', '20', '11', '3002', NULL, NULL, NULL, NULL, 'GASTOS DE REPRESENTACION', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (161, 1, '4', '20', '11', '3003', NULL, NULL, NULL, NULL, 'VIAJES Y ESTADIAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (162, 1, '4', '20', '11', '3004', NULL, NULL, NULL, NULL, 'FERIAS Y STAND', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (163, 1, '4', '20', '11', '4001', NULL, NULL, NULL, NULL, 'ARRIENDO DE OFICINAS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (164, 1, '4', '20', '11', '4002', NULL, NULL, NULL, NULL, 'COMBUSTIBLE', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (165, 1, '4', '20', '11', '4003', NULL, NULL, NULL, NULL, 'GASTOS DE OFICINA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (166, 1, '4', '20', '11', '4004', NULL, NULL, NULL, NULL, 'MANTENCION DE VEHICULOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (167, 1, '4', '20', '11', '4005', NULL, NULL, NULL, NULL, 'TELEFONOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (168, 1, '4', '20', '11', '4006', NULL, NULL, NULL, NULL, 'AGUA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (169, 1, '4', '20', '11', '4007', NULL, NULL, NULL, NULL, 'ELECTRICIDAD', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (170, 1, '4', '20', '11', '4008', NULL, NULL, NULL, NULL, 'GASTOS DE IMPRENTA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (171, 1, '4', '20', '11', '5001', NULL, NULL, NULL, NULL, 'SERVICIO DE ASEO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (172, 1, '4', '20', '11', '5002', NULL, NULL, NULL, NULL, 'SERVICIO DE VIGILANCIA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (173, 1, '4', '20', '11', '6001', NULL, NULL, NULL, NULL, 'SEGUROS DE CHEQUES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (174, 1, '4', '20', '11', '6002', NULL, NULL, NULL, NULL, 'SEGUROS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (175, 1, '4', '20', '11', '7001', NULL, NULL, NULL, NULL, 'COLACION', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (176, 1, '4', '20', '11', '7002', NULL, NULL, NULL, NULL, 'CORRESPONDENCIA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (177, 1, '4', '20', '11', '7003', NULL, NULL, NULL, NULL, 'ALARMA DE SEGURIDAD', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (178, 1, '4', '20', '11', '7004', NULL, NULL, NULL, NULL, 'TAG', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (179, 1, '4', '20', '11', '7005', NULL, NULL, NULL, NULL, 'ROPA DE TRABAJO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (180, 1, '4', '20', '11', '7006', NULL, NULL, NULL, NULL, 'GASTOS DE TV CABLE', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (181, 1, '4', '20', '11', '7007', NULL, NULL, NULL, NULL, 'GASTOS DE DICOM', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (182, 1, '4', '20', '11', '7008', NULL, NULL, NULL, NULL, 'GASTOS DE DOMINIO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (183, 1, '4', '20', '11', '7009', NULL, NULL, NULL, NULL, 'FLETES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (184, 1, '4', '20', '11', '7010', NULL, NULL, NULL, NULL, 'GPS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (185, 1, '4', '20', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS GASTOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (186, 1, '4', '20', '13', '0000', NULL, NULL, NULL, NULL, 'COSTOS FINANCIEROS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (187, 1, '4', '20', '13', '1001', NULL, NULL, NULL, NULL, 'GASTOS POR LEASING', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (188, 1, '4', '20', '13', '1002', NULL, NULL, NULL, NULL, 'GASTOS BANCARIOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (189, 1, '4', '20', '13', '1003', NULL, NULL, NULL, NULL, 'GASTOS POR PROTESTOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (190, 1, '4', '20', '13', '2001', NULL, NULL, NULL, NULL, 'INTERESES BANCARIOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (191, 1, '4', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACION EN RESULTADO POR INVERSIONES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (192, 1, '4', '20', '15', '0000', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (193, 1, '4', '20', '15', '1001', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (194, 1, '4', '20', '16', '0000', NULL, NULL, NULL, NULL, 'RESULTADO POR UNIDADES DE REAJUSTES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (195, 1, '4', '20', '16', '1001', NULL, NULL, NULL, NULL, 'REAJUSTES', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (196, 1, '4', '20', '17', '0000', NULL, NULL, NULL, NULL, 'GASTOS POR IMPUESTO A LA RENTA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (197, 1, '4', '20', '17', '1001', NULL, NULL, NULL, NULL, 'IMPUESTO A LA RENTA', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (198, 1, '5', '00', '00', '0000', NULL, NULL, NULL, NULL, 'CUENTAS DE ORDEN Y TRASPASOS', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (199, 2, '1', '00', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (200, 2, '1', '10', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS CORRIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (201, 2, '1', '10', '10', '0000', NULL, NULL, NULL, NULL, 'EFECTIVO Y EQUIVALENTE AL EFECTIVO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (202, 2, '1', '10', '10', '1001', NULL, NULL, NULL, NULL, 'CAJA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (203, 2, '1', '10', '10', '1002', NULL, NULL, NULL, NULL, 'FONDO FIJO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (204, 2, '1', '10', '10', '2001', NULL, NULL, NULL, NULL, 'BANCO SANTANDER', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (205, 2, '1', '10', '10', '2002', NULL, NULL, NULL, NULL, 'BANCO DE CHILE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (206, 2, '1', '10', '10', '2003', NULL, NULL, NULL, NULL, 'BANCO BBVA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (207, 2, '1', '10', '10', '2004', NULL, NULL, NULL, NULL, 'BANCO BCI', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (208, 2, '1', '10', '10', '2005', NULL, NULL, NULL, NULL, 'BANCO ITAU', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (209, 2, '1', '10', '10', '2006', NULL, NULL, NULL, NULL, 'BANCO SECURITY', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (210, 2, '1', '10', '10', '2007', NULL, NULL, NULL, NULL, 'BANCO SANTANDER DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (211, 2, '1', '10', '10', '2008', NULL, NULL, NULL, NULL, 'BANCO DE CHILE DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (212, 2, '1', '10', '10', '2009', NULL, NULL, NULL, NULL, 'BANCO BBVA DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (213, 2, '1', '10', '10', '2010', NULL, NULL, NULL, NULL, 'BANCO BCI DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (214, 2, '1', '10', '10', '2011', NULL, NULL, NULL, NULL, 'BANCO ITAU DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (215, 2, '1', '10', '10', '2012', NULL, NULL, NULL, NULL, 'BANCO SECURITY DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (216, 2, '1', '10', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (217, 2, '1', '10', '11', '0001', NULL, NULL, NULL, NULL, 'DEPOSITOS A PLAZO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (218, 2, '1', '10', '11', '1002', NULL, NULL, NULL, NULL, 'FONDOS MUTUOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (219, 2, '1', '10', '11', '1003', NULL, NULL, NULL, NULL, 'PACTOS RETROVENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (220, 2, '1', '10', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (221, 2, '1', '10', '13', '0000', NULL, NULL, NULL, NULL, 'DEUDORES COMERCIALES Y OTRAS CUENTAS POR COBRAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (222, 2, '1', '10', '13', '1001', NULL, NULL, NULL, NULL, 'CLIENTES NACIONALES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (223, 2, '1', '10', '13', '1002', NULL, NULL, NULL, NULL, 'CLIENTES EXTRANJEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (224, 2, '1', '10', '13', '1003', NULL, NULL, NULL, NULL, 'CHEQUES EN CARTERA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (225, 2, '1', '10', '13', '1004', NULL, NULL, NULL, NULL, 'TARJETA DE DEBITO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (226, 2, '1', '10', '13', '1005', NULL, NULL, NULL, NULL, 'TARJETA DE CREDITO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (227, 2, '1', '10', '13', '1006', NULL, NULL, NULL, NULL, 'CHEQUES PROTESTADOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (228, 2, '1', '10', '13', '1007', NULL, NULL, NULL, NULL, 'DOCUMENTOS PROTESTADOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (229, 2, '1', '10', '13', '2001', NULL, NULL, NULL, NULL, 'ESTIMACION DEUDORES INCOBRABLES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (230, 2, '1', '10', '13', '3001', NULL, NULL, NULL, NULL, 'FONDOS POR RENDIR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (231, 2, '1', '10', '13', '4001', NULL, NULL, NULL, NULL, 'PRESTAMOS AL PERSONAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (232, 2, '1', '10', '13', '5001', NULL, NULL, NULL, NULL, 'ANTICIPO DE SUELDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (233, 2, '1', '10', '13', '5002', NULL, NULL, NULL, NULL, 'ANTICIPO DE HONORARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (234, 2, '1', '10', '13', '5003', NULL, NULL, NULL, NULL, 'ANTICIPO A PROVEEDORES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (235, 2, '1', '10', '14', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (236, 2, '1', '10', '14', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA NACIONAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (237, 2, '1', '10', '14', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA EXTRANJERA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (238, 2, '1', '10', '15', '0000', NULL, NULL, NULL, NULL, 'INVENTARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (239, 2, '1', '10', '15', '1001', NULL, NULL, NULL, NULL, 'EXISTENCIA EN TRANSITO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (240, 2, '1', '10', '15', '1002', NULL, NULL, NULL, NULL, 'EXISTENCIAS EN PROCESO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (241, 2, '1', '10', '15', '2001', NULL, NULL, NULL, NULL, 'EXISTENCIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (242, 2, '1', '10', '16', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (243, 2, '1', '10', '17', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (244, 2, '1', '10', '17', '1001', NULL, NULL, NULL, NULL, 'PAGOS PROVISIONALES MENSUALES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (245, 2, '1', '10', '17', '1002', NULL, NULL, NULL, NULL, 'IVA CREDITO FISCAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (246, 2, '1', '10', '17', '2001', NULL, NULL, NULL, NULL, 'OTROS IMPUESTOS POR RECUPERAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (247, 2, '1', '10', '19', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (248, 2, '1', '10', '19', '1001', NULL, NULL, NULL, NULL, 'ACTIVOS DISPONIBLES MANTENIDOS PARA LA VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (249, 2, '1', '10', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA DISTRIBUIR A PROPIETARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (250, 2, '1', '10', '21', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA O A DISTRIBUIR A LOS PROPIETARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (251, 2, '1', '20', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS NO CORRIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (252, 2, '1', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (253, 2, '1', '20', '10', '1001', NULL, NULL, NULL, NULL, 'SEGUROS PAGADOS POR ANTICIPADO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (254, 2, '1', '20', '10', '1002', NULL, NULL, NULL, NULL, 'ARRIENDOS PAGADOS POR ANTICIPADO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (255, 2, '1', '20', '10', '1003', NULL, NULL, NULL, NULL, 'OTROS GASTOS PAGADOS POR ANTICIPADO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (256, 2, '1', '20', '10', '1004', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (257, 2, '1', '20', '10', '2001', NULL, NULL, NULL, NULL, 'INTERESES DIFERIDOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (258, 2, '1', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (259, 2, '1', '20', '12', '0000', NULL, NULL, NULL, NULL, 'DERECHOS POR COBRAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (260, 2, '1', '20', '13', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (261, 2, '1', '20', '14', '0000', NULL, NULL, NULL, NULL, 'INVERSIONES POR METODO DE PARTICIPACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (262, 2, '1', '20', '15', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS INTANGIBLES DISTINTO A LA PLUSVALIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (263, 2, '1', '20', '16', '0000', NULL, NULL, NULL, NULL, 'PLUSVALIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (264, 2, '1', '20', '17', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES, PLANTAS Y EQUIPOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (265, 2, '1', '20', '17', '1001', NULL, NULL, NULL, NULL, 'TERRENOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (266, 2, '1', '20', '17', '2001', NULL, NULL, NULL, NULL, 'CONSTRUCCIONES E INTALACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (267, 2, '1', '20', '17', '3001', NULL, NULL, NULL, NULL, 'MUEBLES E UTILES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (268, 2, '1', '20', '17', '4001', NULL, NULL, NULL, NULL, 'VEHICULOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (269, 2, '1', '20', '17', '5001', NULL, NULL, NULL, NULL, 'EQUIPOS COMPUTACIONALES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (270, 2, '1', '20', '17', '6001', NULL, NULL, NULL, NULL, 'ACTIVOS EN LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (271, 2, '1', '20', '17', '7001', NULL, NULL, NULL, NULL, 'PROGRAMAS Y SOFTWARES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (272, 2, '1', '20', '17', '8001', NULL, NULL, NULL, NULL, 'DEPRECIACION ACUMULADA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (273, 2, '1', '20', '18', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (274, 2, '1', '20', '19', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES DE INVERSION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (275, 2, '1', '20', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTO DIFERIDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (276, 2, '2', '00', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (277, 2, '2', '10', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CORRIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (278, 2, '2', '10', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (279, 2, '2', '10', '10', '1001', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON BANCOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (280, 2, '2', '10', '10', '1002', NULL, NULL, NULL, NULL, 'LINEAS DE CREDITO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (281, 2, '2', '10', '10', '1003', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (282, 2, '2', '10', '11', '0000', NULL, NULL, NULL, NULL, 'CUENTAS COMERCIALES Y OTRAS CUENTAS POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (283, 2, '2', '10', '11', '1001', NULL, NULL, NULL, NULL, 'PROVEEDORES NACIONALES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (284, 2, '2', '10', '11', '1002', NULL, NULL, NULL, NULL, 'PROVEEDORES EXTRANJEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (285, 2, '2', '10', '11', '1003', NULL, NULL, NULL, NULL, 'CHEQUES POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (286, 2, '2', '10', '11', '1004', NULL, NULL, NULL, NULL, 'HONORARIOS POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (287, 2, '2', '10', '11', '1005', NULL, NULL, NULL, NULL, 'ANTICIPOS DE CLIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (288, 2, '2', '10', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (289, 2, '2', '10', '12', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA NACIONAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (290, 2, '2', '10', '12', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA EXTRANJERA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (291, 2, '2', '10', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (292, 2, '2', '10', '13', '1001', NULL, NULL, NULL, NULL, 'PROVISIONES POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (293, 2, '2', '10', '13', '2001', NULL, NULL, NULL, NULL, 'PROVISION DE VACACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (294, 2, '2', '10', '13', '2002', NULL, NULL, NULL, NULL, 'PROVISIONES VARIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (295, 2, '2', '10', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (296, 2, '2', '10', '14', '1001', NULL, NULL, NULL, NULL, 'IVA DEBITO FISCAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (297, 2, '2', '10', '14', '1002', NULL, NULL, NULL, NULL, 'IVA POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (298, 2, '2', '10', '14', '1003', NULL, NULL, NULL, NULL, 'RETENCION 1RA CATEGORIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (299, 2, '2', '10', '14', '1004', NULL, NULL, NULL, NULL, 'RETENCION 2DA CATEGORIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (300, 2, '2', '10', '14', '1005', NULL, NULL, NULL, NULL, 'PPM POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (301, 2, '2', '10', '14', '2001', NULL, NULL, NULL, NULL, 'PROVISION IMPUESTO A LA RENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (302, 2, '2', '10', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A EMPLEADOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (303, 2, '2', '10', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (304, 2, '2', '10', '18', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CLASIFICADOS COMO MANTENIDOS PARA LA VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (305, 2, '2', '20', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS NO CORRIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (306, 2, '2', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (307, 2, '2', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS CUENTAS POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (308, 2, '2', '20', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (309, 2, '2', '20', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (310, 2, '2', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS DIFERIDOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (311, 2, '2', '20', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A LOS EMPLEADOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (312, 2, '2', '20', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (313, 2, '2', '30', '00', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO  ', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (314, 2, '2', '30', '10', '0000', NULL, NULL, NULL, NULL, 'CAPITAL EMITIDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (315, 2, '2', '30', '10', '0001', NULL, NULL, NULL, NULL, 'CAPITAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (316, 2, '2', '30', '11', '0000', NULL, NULL, NULL, NULL, 'GANANCIAS (PERDIDAS) ACUMULADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (317, 2, '2', '30', '11', '0001', NULL, NULL, NULL, NULL, 'RESULTADO ACUMULADO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (318, 2, '2', '30', '12', '0000', NULL, NULL, NULL, NULL, 'PRIMAS DE EMISION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (319, 2, '2', '30', '13', '0000', NULL, NULL, NULL, NULL, 'ACCIONES PROPIAS EN CARTERA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (320, 2, '2', '30', '14', '0000', NULL, NULL, NULL, NULL, 'OTRAS PARTICIPACIONES EN EL PATRIMONIO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (321, 2, '2', '30', '15', '0000', NULL, NULL, NULL, NULL, 'OTRAS RESERVAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (322, 2, '2', '30', '16', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO ATRIBUIBLE A PROPIETARIOS DE LA CONTROLADORA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (323, 2, '2', '30', '17', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACIONES NO CONTROLADORAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (324, 2, '3', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO GANANCIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (325, 2, '3', '10', '10', '0000', NULL, NULL, NULL, NULL, 'INGRESOS DE ACTIVIDADES ORDINARIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (326, 2, '3', '10', '10', '1001', NULL, NULL, NULL, NULL, 'VENTA DE GRUAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (327, 2, '3', '10', '10', '1002', NULL, NULL, NULL, NULL, 'VENTA DE ACCESORIAS DE GRUAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (328, 2, '3', '10', '10', '1003', NULL, NULL, NULL, NULL, 'VENTA DE PLATAFORMAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (329, 2, '3', '10', '10', '1004', NULL, NULL, NULL, NULL, 'VENTA DE REPUESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (330, 2, '3', '10', '10', '1005', NULL, NULL, NULL, NULL, 'VENTA DE SERVICIO TECNICO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (331, 2, '3', '10', '10', '1006', NULL, NULL, NULL, NULL, 'VENTA DE LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (332, 2, '3', '10', '10', '2001', NULL, NULL, NULL, NULL, 'ARRIENDOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (333, 2, '3', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS INGRESOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (334, 2, '3', '20', '10', '1001', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (335, 2, '3', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS GANANCIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (336, 2, '3', '20', '12', '0000', NULL, NULL, NULL, NULL, 'INGRESOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (337, 2, '4', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO PERDIDA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (338, 2, '4', '10', '00', '0000', NULL, NULL, NULL, NULL, 'COSTO DE VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (339, 2, '4', '10', '10', '1001', NULL, NULL, NULL, NULL, 'COSTO DE GRUAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (340, 2, '4', '10', '10', '1002', NULL, NULL, NULL, NULL, 'COSTO DE ACCESORIAS DE GRUAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (341, 2, '4', '10', '10', '1003', NULL, NULL, NULL, NULL, 'COSTO DE PLATAFORMAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (342, 2, '4', '10', '10', '1004', NULL, NULL, NULL, NULL, 'COSTO DE REPUESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (343, 2, '4', '10', '10', '1005', NULL, NULL, NULL, NULL, 'COSTO DE SERVICIO TECNICO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (344, 2, '4', '10', '10', '1006', NULL, NULL, NULL, NULL, 'COSTO DE LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (345, 2, '4', '10', '10', '2001', NULL, NULL, NULL, NULL, 'COSTO DE ARRIENDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (346, 2, '4', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS COSTOS DE EXPLOTACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (347, 2, '4', '20', '11', '0000', NULL, NULL, NULL, NULL, 'GASTOS DE ADMINISTRACION Y VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (348, 2, '4', '20', '11', '1001', NULL, NULL, NULL, NULL, 'REMUNERACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (349, 2, '4', '20', '11', '1002', NULL, NULL, NULL, NULL, 'COMISIONES POR VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (350, 2, '4', '20', '11', '1003', NULL, NULL, NULL, NULL, 'FINIQUITOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (351, 2, '4', '20', '11', '2001', NULL, NULL, NULL, NULL, 'ASESORIA INFORMATICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (352, 2, '4', '20', '11', '2002', NULL, NULL, NULL, NULL, 'ASESORIA COMEX', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (353, 2, '4', '20', '11', '2003', NULL, NULL, NULL, NULL, 'ASESORIA DE MARKETING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (354, 2, '4', '20', '11', '2004', NULL, NULL, NULL, NULL, 'ASESORIA LEGAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (355, 2, '4', '20', '11', '2005', NULL, NULL, NULL, NULL, 'ASESORIA CONTABLE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (356, 2, '4', '20', '11', '2006', NULL, NULL, NULL, NULL, 'ASESORIA TECNICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (357, 2, '4', '20', '11', '3001', NULL, NULL, NULL, NULL, 'GASTOS DE PUBLICIDAD', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (358, 2, '4', '20', '11', '3002', NULL, NULL, NULL, NULL, 'GASTOS DE REPRESENTACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (359, 2, '4', '20', '11', '3003', NULL, NULL, NULL, NULL, 'VIAJES Y ESTADIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (360, 2, '4', '20', '11', '3004', NULL, NULL, NULL, NULL, 'FERIAS Y STAND', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (361, 2, '4', '20', '11', '4001', NULL, NULL, NULL, NULL, 'ARRIENDO DE OFICINAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (362, 2, '4', '20', '11', '4002', NULL, NULL, NULL, NULL, 'COMBUSTIBLE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (363, 2, '4', '20', '11', '4003', NULL, NULL, NULL, NULL, 'GASTOS DE OFICINA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (364, 2, '4', '20', '11', '4004', NULL, NULL, NULL, NULL, 'MANTENCION DE VEHICULOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (365, 2, '4', '20', '11', '4005', NULL, NULL, NULL, NULL, 'TELEFONOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (366, 2, '4', '20', '11', '4006', NULL, NULL, NULL, NULL, 'AGUA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (367, 2, '4', '20', '11', '4007', NULL, NULL, NULL, NULL, 'ELECTRICIDAD', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (368, 2, '4', '20', '11', '4008', NULL, NULL, NULL, NULL, 'GASTOS DE IMPRENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (369, 2, '4', '20', '11', '5001', NULL, NULL, NULL, NULL, 'SERVICIO DE ASEO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (370, 2, '4', '20', '11', '5002', NULL, NULL, NULL, NULL, 'SERVICIO DE VIGILANCIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (371, 2, '4', '20', '11', '6001', NULL, NULL, NULL, NULL, 'SEGUROS DE CHEQUES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (372, 2, '4', '20', '11', '6002', NULL, NULL, NULL, NULL, 'SEGUROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (373, 2, '4', '20', '11', '7001', NULL, NULL, NULL, NULL, 'COLACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (374, 2, '4', '20', '11', '7002', NULL, NULL, NULL, NULL, 'CORRESPONDENCIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (375, 2, '4', '20', '11', '7003', NULL, NULL, NULL, NULL, 'ALARMA DE SEGURIDAD', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (376, 2, '4', '20', '11', '7004', NULL, NULL, NULL, NULL, 'TAG', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (377, 2, '4', '20', '11', '7005', NULL, NULL, NULL, NULL, 'ROPA DE TRABAJO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (378, 2, '4', '20', '11', '7006', NULL, NULL, NULL, NULL, 'GASTOS DE TV CABLE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (379, 2, '4', '20', '11', '7007', NULL, NULL, NULL, NULL, 'GASTOS DE DICOM', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (380, 2, '4', '20', '11', '7008', NULL, NULL, NULL, NULL, 'GASTOS DE DOMINIO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (381, 2, '4', '20', '11', '7009', NULL, NULL, NULL, NULL, 'FLETES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (382, 2, '4', '20', '11', '7010', NULL, NULL, NULL, NULL, 'GPS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (383, 2, '4', '20', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS GASTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (384, 2, '4', '20', '13', '0000', NULL, NULL, NULL, NULL, 'COSTOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (385, 2, '4', '20', '13', '1001', NULL, NULL, NULL, NULL, 'GASTOS POR LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (386, 2, '4', '20', '13', '1002', NULL, NULL, NULL, NULL, 'GASTOS BANCARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (387, 2, '4', '20', '13', '1003', NULL, NULL, NULL, NULL, 'GASTOS POR PROTESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (388, 2, '4', '20', '13', '2001', NULL, NULL, NULL, NULL, 'INTERESES BANCARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (389, 2, '4', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACION EN RESULTADO POR INVERSIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (390, 2, '4', '20', '15', '0000', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (391, 2, '4', '20', '15', '1001', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (392, 2, '4', '20', '16', '0000', NULL, NULL, NULL, NULL, 'RESULTADO POR UNIDADES DE REAJUSTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (393, 2, '4', '20', '16', '1001', NULL, NULL, NULL, NULL, 'REAJUSTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (394, 2, '4', '20', '17', '0000', NULL, NULL, NULL, NULL, 'GASTOS POR IMPUESTO A LA RENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (395, 2, '4', '20', '17', '1001', NULL, NULL, NULL, NULL, 'IMPUESTO A LA RENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (396, 2, '5', '00', '00', '0000', NULL, NULL, NULL, NULL, 'CUENTAS DE ORDEN Y TRASPASOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (397, 3, '1', '00', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (398, 3, '1', '10', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS CORRIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (399, 3, '1', '10', '10', '0000', NULL, NULL, NULL, NULL, 'EFECTIVO Y EQUIVALENTE AL EFECTIVO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (400, 3, '1', '10', '10', '1001', NULL, NULL, NULL, NULL, 'CAJA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (401, 3, '1', '10', '10', '1002', NULL, NULL, NULL, NULL, 'FONDO FIJO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (402, 3, '1', '10', '10', '2001', NULL, NULL, NULL, NULL, 'BANCO SANTANDER', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (403, 3, '1', '10', '10', '2002', NULL, NULL, NULL, NULL, 'BANCO DE CHILE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (404, 3, '1', '10', '10', '2003', NULL, NULL, NULL, NULL, 'BANCO BBVA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (405, 3, '1', '10', '10', '2004', NULL, NULL, NULL, NULL, 'BANCO BCI', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (406, 3, '1', '10', '10', '2005', NULL, NULL, NULL, NULL, 'BANCO ITAU', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (407, 3, '1', '10', '10', '2006', NULL, NULL, NULL, NULL, 'BANCO SECURITY', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (408, 3, '1', '10', '10', '2007', NULL, NULL, NULL, NULL, 'BANCO SANTANDER DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (409, 3, '1', '10', '10', '2008', NULL, NULL, NULL, NULL, 'BANCO DE CHILE DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (410, 3, '1', '10', '10', '2009', NULL, NULL, NULL, NULL, 'BANCO BBVA DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (411, 3, '1', '10', '10', '2010', NULL, NULL, NULL, NULL, 'BANCO BCI DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (412, 3, '1', '10', '10', '2011', NULL, NULL, NULL, NULL, 'BANCO ITAU DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (413, 3, '1', '10', '10', '2012', NULL, NULL, NULL, NULL, 'BANCO SECURITY DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (414, 3, '1', '10', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (415, 3, '1', '10', '11', '0001', NULL, NULL, NULL, NULL, 'DEPOSITOS A PLAZO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (416, 3, '1', '10', '11', '1002', NULL, NULL, NULL, NULL, 'FONDOS MUTUOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (417, 3, '1', '10', '11', '1003', NULL, NULL, NULL, NULL, 'PACTOS RETROVENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (418, 3, '1', '10', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (419, 3, '1', '10', '13', '0000', NULL, NULL, NULL, NULL, 'DEUDORES COMERCIALES Y OTRAS CUENTAS POR COBRAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (420, 3, '1', '10', '13', '1001', NULL, NULL, NULL, NULL, 'CLIENTES NACIONALES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (421, 3, '1', '10', '13', '1002', NULL, NULL, NULL, NULL, 'CLIENTES EXTRANJEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (422, 3, '1', '10', '13', '1003', NULL, NULL, NULL, NULL, 'CHEQUES EN CARTERA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (423, 3, '1', '10', '13', '1004', NULL, NULL, NULL, NULL, 'TARJETA DE DEBITO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (424, 3, '1', '10', '13', '1005', NULL, NULL, NULL, NULL, 'TARJETA DE CREDITO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (425, 3, '1', '10', '13', '1006', NULL, NULL, NULL, NULL, 'CHEQUES PROTESTADOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (426, 3, '1', '10', '13', '1007', NULL, NULL, NULL, NULL, 'DOCUMENTOS PROTESTADOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (427, 3, '1', '10', '13', '2001', NULL, NULL, NULL, NULL, 'ESTIMACION DEUDORES INCOBRABLES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (428, 3, '1', '10', '13', '3001', NULL, NULL, NULL, NULL, 'FONDOS POR RENDIR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (429, 3, '1', '10', '13', '4001', NULL, NULL, NULL, NULL, 'PRESTAMOS AL PERSONAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (430, 3, '1', '10', '13', '5001', NULL, NULL, NULL, NULL, 'ANTICIPO DE SUELDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (431, 3, '1', '10', '13', '5002', NULL, NULL, NULL, NULL, 'ANTICIPO DE HONORARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (432, 3, '1', '10', '13', '5003', NULL, NULL, NULL, NULL, 'ANTICIPO A PROVEEDORES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (433, 3, '1', '10', '14', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (434, 3, '1', '10', '14', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA NACIONAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (435, 3, '1', '10', '14', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA EXTRANJERA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (436, 3, '1', '10', '15', '0000', NULL, NULL, NULL, NULL, 'INVENTARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (437, 3, '1', '10', '15', '1001', NULL, NULL, NULL, NULL, 'EXISTENCIA EN TRANSITO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (438, 3, '1', '10', '15', '1002', NULL, NULL, NULL, NULL, 'EXISTENCIAS EN PROCESO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (439, 3, '1', '10', '15', '2001', NULL, NULL, NULL, NULL, 'EXISTENCIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (440, 3, '1', '10', '16', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (441, 3, '1', '10', '17', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (442, 3, '1', '10', '17', '1001', NULL, NULL, NULL, NULL, 'PAGOS PROVISIONALES MENSUALES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (443, 3, '1', '10', '17', '1002', NULL, NULL, NULL, NULL, 'IVA CREDITO FISCAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (444, 3, '1', '10', '17', '2001', NULL, NULL, NULL, NULL, 'OTROS IMPUESTOS POR RECUPERAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (445, 3, '1', '10', '19', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (446, 3, '1', '10', '19', '1001', NULL, NULL, NULL, NULL, 'ACTIVOS DISPONIBLES MANTENIDOS PARA LA VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (447, 3, '1', '10', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA DISTRIBUIR A PROPIETARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (448, 3, '1', '10', '21', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA O A DISTRIBUIR A LOS PROPIETARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (449, 3, '1', '20', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS NO CORRIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (450, 3, '1', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (451, 3, '1', '20', '10', '1001', NULL, NULL, NULL, NULL, 'SEGUROS PAGADOS POR ANTICIPADO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (452, 3, '1', '20', '10', '1002', NULL, NULL, NULL, NULL, 'ARRIENDOS PAGADOS POR ANTICIPADO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (453, 3, '1', '20', '10', '1003', NULL, NULL, NULL, NULL, 'OTROS GASTOS PAGADOS POR ANTICIPADO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (454, 3, '1', '20', '10', '1004', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (455, 3, '1', '20', '10', '2001', NULL, NULL, NULL, NULL, 'INTERESES DIFERIDOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (456, 3, '1', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (457, 3, '1', '20', '12', '0000', NULL, NULL, NULL, NULL, 'DERECHOS POR COBRAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (458, 3, '1', '20', '13', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (459, 3, '1', '20', '14', '0000', NULL, NULL, NULL, NULL, 'INVERSIONES POR METODO DE PARTICIPACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (460, 3, '1', '20', '15', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS INTANGIBLES DISTINTO A LA PLUSVALIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (461, 3, '1', '20', '16', '0000', NULL, NULL, NULL, NULL, 'PLUSVALIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (462, 3, '1', '20', '17', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES, PLANTAS Y EQUIPOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (463, 3, '1', '20', '17', '1001', NULL, NULL, NULL, NULL, 'TERRENOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (464, 3, '1', '20', '17', '2001', NULL, NULL, NULL, NULL, 'CONSTRUCCIONES E INTALACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (465, 3, '1', '20', '17', '3001', NULL, NULL, NULL, NULL, 'MUEBLES E UTILES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (466, 3, '1', '20', '17', '4001', NULL, NULL, NULL, NULL, 'VEHICULOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (467, 3, '1', '20', '17', '5001', NULL, NULL, NULL, NULL, 'EQUIPOS COMPUTACIONALES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (468, 3, '1', '20', '17', '6001', NULL, NULL, NULL, NULL, 'ACTIVOS EN LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (469, 3, '1', '20', '17', '7001', NULL, NULL, NULL, NULL, 'PROGRAMAS Y SOFTWARES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (470, 3, '1', '20', '17', '8001', NULL, NULL, NULL, NULL, 'DEPRECIACION ACUMULADA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (471, 3, '1', '20', '18', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (472, 3, '1', '20', '19', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES DE INVERSION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (473, 3, '1', '20', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTO DIFERIDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (474, 3, '2', '00', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (475, 3, '2', '10', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CORRIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (476, 3, '2', '10', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (477, 3, '2', '10', '10', '1001', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON BANCOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (478, 3, '2', '10', '10', '1002', NULL, NULL, NULL, NULL, 'LINEAS DE CREDITO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (479, 3, '2', '10', '10', '1003', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (480, 3, '2', '10', '11', '0000', NULL, NULL, NULL, NULL, 'CUENTAS COMERCIALES Y OTRAS CUENTAS POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (481, 3, '2', '10', '11', '1001', NULL, NULL, NULL, NULL, 'PROVEEDORES NACIONALES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (482, 3, '2', '10', '11', '1002', NULL, NULL, NULL, NULL, 'PROVEEDORES EXTRANJEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (483, 3, '2', '10', '11', '1003', NULL, NULL, NULL, NULL, 'CHEQUES POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (484, 3, '2', '10', '11', '1004', NULL, NULL, NULL, NULL, 'HONORARIOS POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (485, 3, '2', '10', '11', '1005', NULL, NULL, NULL, NULL, 'ANTICIPOS DE CLIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (486, 3, '2', '10', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (487, 3, '2', '10', '12', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA NACIONAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (488, 3, '2', '10', '12', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA EXTRANJERA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (489, 3, '2', '10', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (490, 3, '2', '10', '13', '1001', NULL, NULL, NULL, NULL, 'PROVISIONES POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (491, 3, '2', '10', '13', '2001', NULL, NULL, NULL, NULL, 'PROVISION DE VACACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (492, 3, '2', '10', '13', '2002', NULL, NULL, NULL, NULL, 'PROVISIONES VARIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (493, 3, '2', '10', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (494, 3, '2', '10', '14', '1001', NULL, NULL, NULL, NULL, 'IVA DEBITO FISCAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (495, 3, '2', '10', '14', '1002', NULL, NULL, NULL, NULL, 'IVA POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (496, 3, '2', '10', '14', '1003', NULL, NULL, NULL, NULL, 'RETENCION 1RA CATEGORIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (497, 3, '2', '10', '14', '1004', NULL, NULL, NULL, NULL, 'RETENCION 2DA CATEGORIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (498, 3, '2', '10', '14', '1005', NULL, NULL, NULL, NULL, 'PPM POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (499, 3, '2', '10', '14', '2001', NULL, NULL, NULL, NULL, 'PROVISION IMPUESTO A LA RENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (500, 3, '2', '10', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A EMPLEADOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (501, 3, '2', '10', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (502, 3, '2', '10', '18', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CLASIFICADOS COMO MANTENIDOS PARA LA VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (503, 3, '2', '20', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS NO CORRIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (504, 3, '2', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (505, 3, '2', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS CUENTAS POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (506, 3, '2', '20', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (507, 3, '2', '20', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (508, 3, '2', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS DIFERIDOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (509, 3, '2', '20', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A LOS EMPLEADOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (510, 3, '2', '20', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (511, 3, '2', '30', '00', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO  ', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (512, 3, '2', '30', '10', '0000', NULL, NULL, NULL, NULL, 'CAPITAL EMITIDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (513, 3, '2', '30', '10', '0001', NULL, NULL, NULL, NULL, 'CAPITAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (514, 3, '2', '30', '11', '0000', NULL, NULL, NULL, NULL, 'GANANCIAS (PERDIDAS) ACUMULADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (515, 3, '2', '30', '11', '0001', NULL, NULL, NULL, NULL, 'RESULTADO ACUMULADO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (516, 3, '2', '30', '12', '0000', NULL, NULL, NULL, NULL, 'PRIMAS DE EMISION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (517, 3, '2', '30', '13', '0000', NULL, NULL, NULL, NULL, 'ACCIONES PROPIAS EN CARTERA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (518, 3, '2', '30', '14', '0000', NULL, NULL, NULL, NULL, 'OTRAS PARTICIPACIONES EN EL PATRIMONIO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (519, 3, '2', '30', '15', '0000', NULL, NULL, NULL, NULL, 'OTRAS RESERVAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (520, 3, '2', '30', '16', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO ATRIBUIBLE A PROPIETARIOS DE LA CONTROLADORA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (521, 3, '2', '30', '17', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACIONES NO CONTROLADORAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (522, 3, '3', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO GANANCIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (523, 3, '3', '10', '10', '0000', NULL, NULL, NULL, NULL, 'INGRESOS DE ACTIVIDADES ORDINARIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (524, 3, '3', '10', '10', '1001', NULL, NULL, NULL, NULL, 'VENTA DE GRUAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (525, 3, '3', '10', '10', '1002', NULL, NULL, NULL, NULL, 'VENTA DE ACCESORIAS DE GRUAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (526, 3, '3', '10', '10', '1003', NULL, NULL, NULL, NULL, 'VENTA DE PLATAFORMAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (527, 3, '3', '10', '10', '1004', NULL, NULL, NULL, NULL, 'VENTA DE REPUESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (528, 3, '3', '10', '10', '1005', NULL, NULL, NULL, NULL, 'VENTA DE SERVICIO TECNICO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (529, 3, '3', '10', '10', '1006', NULL, NULL, NULL, NULL, 'VENTA DE LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (530, 3, '3', '10', '10', '2001', NULL, NULL, NULL, NULL, 'ARRIENDOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (531, 3, '3', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS INGRESOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (532, 3, '3', '20', '10', '1001', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (533, 3, '3', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS GANANCIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (534, 3, '3', '20', '12', '0000', NULL, NULL, NULL, NULL, 'INGRESOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (535, 3, '4', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO PERDIDA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (536, 3, '4', '10', '00', '0000', NULL, NULL, NULL, NULL, 'COSTO DE VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (537, 3, '4', '10', '10', '1001', NULL, NULL, NULL, NULL, 'COSTO DE GRUAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (538, 3, '4', '10', '10', '1002', NULL, NULL, NULL, NULL, 'COSTO DE ACCESORIAS DE GRUAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (539, 3, '4', '10', '10', '1003', NULL, NULL, NULL, NULL, 'COSTO DE PLATAFORMAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (540, 3, '4', '10', '10', '1004', NULL, NULL, NULL, NULL, 'COSTO DE REPUESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (541, 3, '4', '10', '10', '1005', NULL, NULL, NULL, NULL, 'COSTO DE SERVICIO TECNICO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (542, 3, '4', '10', '10', '1006', NULL, NULL, NULL, NULL, 'COSTO DE LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (543, 3, '4', '10', '10', '2001', NULL, NULL, NULL, NULL, 'COSTO DE ARRIENDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (544, 3, '4', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS COSTOS DE EXPLOTACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (545, 3, '4', '20', '11', '0000', NULL, NULL, NULL, NULL, 'GASTOS DE ADMINISTRACION Y VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (546, 3, '4', '20', '11', '1001', NULL, NULL, NULL, NULL, 'REMUNERACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (547, 3, '4', '20', '11', '1002', NULL, NULL, NULL, NULL, 'COMISIONES POR VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (548, 3, '4', '20', '11', '1003', NULL, NULL, NULL, NULL, 'FINIQUITOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (549, 3, '4', '20', '11', '2001', NULL, NULL, NULL, NULL, 'ASESORIA INFORMATICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (550, 3, '4', '20', '11', '2002', NULL, NULL, NULL, NULL, 'ASESORIA COMEX', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (551, 3, '4', '20', '11', '2003', NULL, NULL, NULL, NULL, 'ASESORIA DE MARKETING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (552, 3, '4', '20', '11', '2004', NULL, NULL, NULL, NULL, 'ASESORIA LEGAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (553, 3, '4', '20', '11', '2005', NULL, NULL, NULL, NULL, 'ASESORIA CONTABLE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (554, 3, '4', '20', '11', '2006', NULL, NULL, NULL, NULL, 'ASESORIA TECNICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (555, 3, '4', '20', '11', '3001', NULL, NULL, NULL, NULL, 'GASTOS DE PUBLICIDAD', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (556, 3, '4', '20', '11', '3002', NULL, NULL, NULL, NULL, 'GASTOS DE REPRESENTACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (557, 3, '4', '20', '11', '3003', NULL, NULL, NULL, NULL, 'VIAJES Y ESTADIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (558, 3, '4', '20', '11', '3004', NULL, NULL, NULL, NULL, 'FERIAS Y STAND', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (559, 3, '4', '20', '11', '4001', NULL, NULL, NULL, NULL, 'ARRIENDO DE OFICINAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (560, 3, '4', '20', '11', '4002', NULL, NULL, NULL, NULL, 'COMBUSTIBLE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (561, 3, '4', '20', '11', '4003', NULL, NULL, NULL, NULL, 'GASTOS DE OFICINA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (562, 3, '4', '20', '11', '4004', NULL, NULL, NULL, NULL, 'MANTENCION DE VEHICULOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (563, 3, '4', '20', '11', '4005', NULL, NULL, NULL, NULL, 'TELEFONOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (564, 3, '4', '20', '11', '4006', NULL, NULL, NULL, NULL, 'AGUA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (565, 3, '4', '20', '11', '4007', NULL, NULL, NULL, NULL, 'ELECTRICIDAD', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (566, 3, '4', '20', '11', '4008', NULL, NULL, NULL, NULL, 'GASTOS DE IMPRENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (567, 3, '4', '20', '11', '5001', NULL, NULL, NULL, NULL, 'SERVICIO DE ASEO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (568, 3, '4', '20', '11', '5002', NULL, NULL, NULL, NULL, 'SERVICIO DE VIGILANCIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (569, 3, '4', '20', '11', '6001', NULL, NULL, NULL, NULL, 'SEGUROS DE CHEQUES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (570, 3, '4', '20', '11', '6002', NULL, NULL, NULL, NULL, 'SEGUROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (571, 3, '4', '20', '11', '7001', NULL, NULL, NULL, NULL, 'COLACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (572, 3, '4', '20', '11', '7002', NULL, NULL, NULL, NULL, 'CORRESPONDENCIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (573, 3, '4', '20', '11', '7003', NULL, NULL, NULL, NULL, 'ALARMA DE SEGURIDAD', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (574, 3, '4', '20', '11', '7004', NULL, NULL, NULL, NULL, 'TAG', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (575, 3, '4', '20', '11', '7005', NULL, NULL, NULL, NULL, 'ROPA DE TRABAJO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (576, 3, '4', '20', '11', '7006', NULL, NULL, NULL, NULL, 'GASTOS DE TV CABLE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (577, 3, '4', '20', '11', '7007', NULL, NULL, NULL, NULL, 'GASTOS DE DICOM', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (578, 3, '4', '20', '11', '7008', NULL, NULL, NULL, NULL, 'GASTOS DE DOMINIO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (579, 3, '4', '20', '11', '7009', NULL, NULL, NULL, NULL, 'FLETES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (580, 3, '4', '20', '11', '7010', NULL, NULL, NULL, NULL, 'GPS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (581, 3, '4', '20', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS GASTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (582, 3, '4', '20', '13', '0000', NULL, NULL, NULL, NULL, 'COSTOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (583, 3, '4', '20', '13', '1001', NULL, NULL, NULL, NULL, 'GASTOS POR LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (584, 3, '4', '20', '13', '1002', NULL, NULL, NULL, NULL, 'GASTOS BANCARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (585, 3, '4', '20', '13', '1003', NULL, NULL, NULL, NULL, 'GASTOS POR PROTESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (586, 3, '4', '20', '13', '2001', NULL, NULL, NULL, NULL, 'INTERESES BANCARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (587, 3, '4', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACION EN RESULTADO POR INVERSIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (588, 3, '4', '20', '15', '0000', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (589, 3, '4', '20', '15', '1001', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (590, 3, '4', '20', '16', '0000', NULL, NULL, NULL, NULL, 'RESULTADO POR UNIDADES DE REAJUSTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (591, 3, '4', '20', '16', '1001', NULL, NULL, NULL, NULL, 'REAJUSTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (592, 3, '4', '20', '17', '0000', NULL, NULL, NULL, NULL, 'GASTOS POR IMPUESTO A LA RENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (593, 3, '4', '20', '17', '1001', NULL, NULL, NULL, NULL, 'IMPUESTO A LA RENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (594, 3, '5', '00', '00', '0000', NULL, NULL, NULL, NULL, 'CUENTAS DE ORDEN Y TRASPASOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (595, 4, '1', '00', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (596, 4, '1', '10', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS CORRIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (597, 4, '1', '10', '10', '0000', NULL, NULL, NULL, NULL, 'EFECTIVO Y EQUIVALENTE AL EFECTIVO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (598, 4, '1', '10', '10', '1001', NULL, NULL, NULL, NULL, 'CAJA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (599, 4, '1', '10', '10', '1002', NULL, NULL, NULL, NULL, 'FONDO FIJO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (600, 4, '1', '10', '10', '2001', NULL, NULL, NULL, NULL, 'BANCO SANTANDER', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (601, 4, '1', '10', '10', '2002', NULL, NULL, NULL, NULL, 'BANCO DE CHILE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (602, 4, '1', '10', '10', '2003', NULL, NULL, NULL, NULL, 'BANCO BBVA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (603, 4, '1', '10', '10', '2004', NULL, NULL, NULL, NULL, 'BANCO BCI', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (604, 4, '1', '10', '10', '2005', NULL, NULL, NULL, NULL, 'BANCO ITAU', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (605, 4, '1', '10', '10', '2006', NULL, NULL, NULL, NULL, 'BANCO SECURITY', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (606, 4, '1', '10', '10', '2007', NULL, NULL, NULL, NULL, 'BANCO SANTANDER DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (607, 4, '1', '10', '10', '2008', NULL, NULL, NULL, NULL, 'BANCO DE CHILE DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (608, 4, '1', '10', '10', '2009', NULL, NULL, NULL, NULL, 'BANCO BBVA DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (609, 4, '1', '10', '10', '2010', NULL, NULL, NULL, NULL, 'BANCO BCI DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (610, 4, '1', '10', '10', '2011', NULL, NULL, NULL, NULL, 'BANCO ITAU DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (611, 4, '1', '10', '10', '2012', NULL, NULL, NULL, NULL, 'BANCO SECURITY DOLAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (612, 4, '1', '10', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (613, 4, '1', '10', '11', '0001', NULL, NULL, NULL, NULL, 'DEPOSITOS A PLAZO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (614, 4, '1', '10', '11', '1002', NULL, NULL, NULL, NULL, 'FONDOS MUTUOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (615, 4, '1', '10', '11', '1003', NULL, NULL, NULL, NULL, 'PACTOS RETROVENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (616, 4, '1', '10', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (617, 4, '1', '10', '13', '0000', NULL, NULL, NULL, NULL, 'DEUDORES COMERCIALES Y OTRAS CUENTAS POR COBRAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (618, 4, '1', '10', '13', '1001', NULL, NULL, NULL, NULL, 'CLIENTES NACIONALES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (619, 4, '1', '10', '13', '1002', NULL, NULL, NULL, NULL, 'CLIENTES EXTRANJEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (620, 4, '1', '10', '13', '1003', NULL, NULL, NULL, NULL, 'CHEQUES EN CARTERA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (621, 4, '1', '10', '13', '1004', NULL, NULL, NULL, NULL, 'TARJETA DE DEBITO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (622, 4, '1', '10', '13', '1005', NULL, NULL, NULL, NULL, 'TARJETA DE CREDITO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (623, 4, '1', '10', '13', '1006', NULL, NULL, NULL, NULL, 'CHEQUES PROTESTADOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (624, 4, '1', '10', '13', '1007', NULL, NULL, NULL, NULL, 'DOCUMENTOS PROTESTADOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (625, 4, '1', '10', '13', '2001', NULL, NULL, NULL, NULL, 'ESTIMACION DEUDORES INCOBRABLES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (626, 4, '1', '10', '13', '3001', NULL, NULL, NULL, NULL, 'FONDOS POR RENDIR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (627, 4, '1', '10', '13', '4001', NULL, NULL, NULL, NULL, 'PRESTAMOS AL PERSONAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (628, 4, '1', '10', '13', '5001', NULL, NULL, NULL, NULL, 'ANTICIPO DE SUELDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (629, 4, '1', '10', '13', '5002', NULL, NULL, NULL, NULL, 'ANTICIPO DE HONORARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (630, 4, '1', '10', '13', '5003', NULL, NULL, NULL, NULL, 'ANTICIPO A PROVEEDORES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (631, 4, '1', '10', '14', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (632, 4, '1', '10', '14', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA NACIONAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (633, 4, '1', '10', '14', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR EMPRESA RELACIONADA EXTRANJERA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (634, 4, '1', '10', '15', '0000', NULL, NULL, NULL, NULL, 'INVENTARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (635, 4, '1', '10', '15', '1001', NULL, NULL, NULL, NULL, 'EXISTENCIA EN TRANSITO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (636, 4, '1', '10', '15', '1002', NULL, NULL, NULL, NULL, 'EXISTENCIAS EN PROCESO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (637, 4, '1', '10', '15', '2001', NULL, NULL, NULL, NULL, 'EXISTENCIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (638, 4, '1', '10', '16', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (639, 4, '1', '10', '17', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (640, 4, '1', '10', '17', '1001', NULL, NULL, NULL, NULL, 'PAGOS PROVISIONALES MENSUALES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (641, 4, '1', '10', '17', '1002', NULL, NULL, NULL, NULL, 'IVA CREDITO FISCAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (642, 4, '1', '10', '17', '2001', NULL, NULL, NULL, NULL, 'OTROS IMPUESTOS POR RECUPERAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (643, 4, '1', '10', '19', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (644, 4, '1', '10', '19', '1001', NULL, NULL, NULL, NULL, 'ACTIVOS DISPONIBLES MANTENIDOS PARA LA VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (645, 4, '1', '10', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA DISTRIBUIR A PROPIETARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (646, 4, '1', '10', '21', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS MANTENIDOS PARA LA VENTA O A DISTRIBUIR A LOS PROPIETARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (647, 4, '1', '20', '00', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS NO CORRIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (648, 4, '1', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (649, 4, '1', '20', '10', '1001', NULL, NULL, NULL, NULL, 'SEGUROS PAGADOS POR ANTICIPADO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (650, 4, '1', '20', '10', '1002', NULL, NULL, NULL, NULL, 'ARRIENDOS PAGADOS POR ANTICIPADO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (651, 4, '1', '20', '10', '1003', NULL, NULL, NULL, NULL, 'OTROS GASTOS PAGADOS POR ANTICIPADO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (652, 4, '1', '20', '10', '1004', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (653, 4, '1', '20', '10', '2001', NULL, NULL, NULL, NULL, 'INTERESES DIFERIDOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (654, 4, '1', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTROS ACTIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (655, 4, '1', '20', '12', '0000', NULL, NULL, NULL, NULL, 'DERECHOS POR COBRAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (656, 4, '1', '20', '13', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR COBRAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (657, 4, '1', '20', '14', '0000', NULL, NULL, NULL, NULL, 'INVERSIONES POR METODO DE PARTICIPACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (658, 4, '1', '20', '15', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS INTANGIBLES DISTINTO A LA PLUSVALIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (659, 4, '1', '20', '16', '0000', NULL, NULL, NULL, NULL, 'PLUSVALIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (660, 4, '1', '20', '17', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES, PLANTAS Y EQUIPOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (661, 4, '1', '20', '17', '1001', NULL, NULL, NULL, NULL, 'TERRENOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (662, 4, '1', '20', '17', '2001', NULL, NULL, NULL, NULL, 'CONSTRUCCIONES E INTALACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (663, 4, '1', '20', '17', '3001', NULL, NULL, NULL, NULL, 'MUEBLES E UTILES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (664, 4, '1', '20', '17', '4001', NULL, NULL, NULL, NULL, 'VEHICULOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (665, 4, '1', '20', '17', '5001', NULL, NULL, NULL, NULL, 'EQUIPOS COMPUTACIONALES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (666, 4, '1', '20', '17', '6001', NULL, NULL, NULL, NULL, 'ACTIVOS EN LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (667, 4, '1', '20', '17', '7001', NULL, NULL, NULL, NULL, 'PROGRAMAS Y SOFTWARES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (668, 4, '1', '20', '17', '8001', NULL, NULL, NULL, NULL, 'DEPRECIACION ACUMULADA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (669, 4, '1', '20', '18', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS BIOLOGICOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (670, 4, '1', '20', '19', '0000', NULL, NULL, NULL, NULL, 'PROPIEDADES DE INVERSION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (671, 4, '1', '20', '20', '0000', NULL, NULL, NULL, NULL, 'ACTIVOS POR IMPUESTO DIFERIDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (672, 4, '2', '00', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (673, 4, '2', '10', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CORRIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (674, 4, '2', '10', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (675, 4, '2', '10', '10', '1001', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON BANCOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (676, 4, '2', '10', '10', '1002', NULL, NULL, NULL, NULL, 'LINEAS DE CREDITO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (677, 4, '2', '10', '10', '1003', NULL, NULL, NULL, NULL, 'OBLIGACIONES CON LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (678, 4, '2', '10', '11', '0000', NULL, NULL, NULL, NULL, 'CUENTAS COMERCIALES Y OTRAS CUENTAS POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (679, 4, '2', '10', '11', '1001', NULL, NULL, NULL, NULL, 'PROVEEDORES NACIONALES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (680, 4, '2', '10', '11', '1002', NULL, NULL, NULL, NULL, 'PROVEEDORES EXTRANJEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (681, 4, '2', '10', '11', '1003', NULL, NULL, NULL, NULL, 'CHEQUES POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (682, 4, '2', '10', '11', '1004', NULL, NULL, NULL, NULL, 'HONORARIOS POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (683, 4, '2', '10', '11', '1005', NULL, NULL, NULL, NULL, 'ANTICIPOS DE CLIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (684, 4, '2', '10', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (685, 4, '2', '10', '12', '1001', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA NACIONAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (686, 4, '2', '10', '12', '1002', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR ENTIDAD RELACIONADA EXTRANJERA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (687, 4, '2', '10', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (688, 4, '2', '10', '13', '1001', NULL, NULL, NULL, NULL, 'PROVISIONES POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (689, 4, '2', '10', '13', '2001', NULL, NULL, NULL, NULL, 'PROVISION DE VACACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (690, 4, '2', '10', '13', '2002', NULL, NULL, NULL, NULL, 'PROVISIONES VARIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (691, 4, '2', '10', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (692, 4, '2', '10', '14', '1001', NULL, NULL, NULL, NULL, 'IVA DEBITO FISCAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (693, 4, '2', '10', '14', '1002', NULL, NULL, NULL, NULL, 'IVA POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (694, 4, '2', '10', '14', '1003', NULL, NULL, NULL, NULL, 'RETENCION 1RA CATEGORIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (695, 4, '2', '10', '14', '1004', NULL, NULL, NULL, NULL, 'RETENCION 2DA CATEGORIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (696, 4, '2', '10', '14', '1005', NULL, NULL, NULL, NULL, 'PPM POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (697, 4, '2', '10', '14', '2001', NULL, NULL, NULL, NULL, 'PROVISION IMPUESTO A LA RENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (698, 4, '2', '10', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A EMPLEADOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (699, 4, '2', '10', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (700, 4, '2', '10', '18', '0000', NULL, NULL, NULL, NULL, 'PASIVOS CLASIFICADOS COMO MANTENIDOS PARA LA VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (701, 4, '2', '20', '00', '0000', NULL, NULL, NULL, NULL, 'PASIVOS NO CORRIENTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (702, 4, '2', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (703, 4, '2', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS CUENTAS POR PAGAR', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (704, 4, '2', '20', '12', '0000', NULL, NULL, NULL, NULL, 'CUENTAS POR PAGAR A ENTIDADES RELACIONADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (705, 4, '2', '20', '13', '0000', NULL, NULL, NULL, NULL, 'OTRAS PROVISIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (706, 4, '2', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PASIVOS POR IMPUESTOS DIFERIDOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (707, 4, '2', '20', '15', '0000', NULL, NULL, NULL, NULL, 'PROVISIONES POR BENEFICIOS A LOS EMPLEADOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (708, 4, '2', '20', '16', '0000', NULL, NULL, NULL, NULL, 'OTROS PASIVOS NO FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (709, 4, '2', '30', '00', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO  ', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (710, 4, '2', '30', '10', '0000', NULL, NULL, NULL, NULL, 'CAPITAL EMITIDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (711, 4, '2', '30', '10', '0001', NULL, NULL, NULL, NULL, 'CAPITAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (712, 4, '2', '30', '11', '0000', NULL, NULL, NULL, NULL, 'GANANCIAS (PERDIDAS) ACUMULADAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (713, 4, '2', '30', '11', '0001', NULL, NULL, NULL, NULL, 'RESULTADO ACUMULADO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (714, 4, '2', '30', '12', '0000', NULL, NULL, NULL, NULL, 'PRIMAS DE EMISION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (715, 4, '2', '30', '13', '0000', NULL, NULL, NULL, NULL, 'ACCIONES PROPIAS EN CARTERA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (716, 4, '2', '30', '14', '0000', NULL, NULL, NULL, NULL, 'OTRAS PARTICIPACIONES EN EL PATRIMONIO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (717, 4, '2', '30', '15', '0000', NULL, NULL, NULL, NULL, 'OTRAS RESERVAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (718, 4, '2', '30', '16', '0000', NULL, NULL, NULL, NULL, 'PATRIMONIO ATRIBUIBLE A PROPIETARIOS DE LA CONTROLADORA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (719, 4, '2', '30', '17', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACIONES NO CONTROLADORAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (720, 4, '3', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO GANANCIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (721, 4, '3', '10', '10', '0000', NULL, NULL, NULL, NULL, 'INGRESOS DE ACTIVIDADES ORDINARIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (722, 4, '3', '10', '10', '1001', NULL, NULL, NULL, NULL, 'VENTA DE GRUAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (723, 4, '3', '10', '10', '1002', NULL, NULL, NULL, NULL, 'VENTA DE ACCESORIAS DE GRUAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (724, 4, '3', '10', '10', '1003', NULL, NULL, NULL, NULL, 'VENTA DE PLATAFORMAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (725, 4, '3', '10', '10', '1004', NULL, NULL, NULL, NULL, 'VENTA DE REPUESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (726, 4, '3', '10', '10', '1005', NULL, NULL, NULL, NULL, 'VENTA DE SERVICIO TECNICO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (727, 4, '3', '10', '10', '1006', NULL, NULL, NULL, NULL, 'VENTA DE LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (728, 4, '3', '10', '10', '2001', NULL, NULL, NULL, NULL, 'ARRIENDOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (729, 4, '3', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS INGRESOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (730, 4, '3', '20', '10', '1001', NULL, NULL, NULL, NULL, 'GARANTIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (731, 4, '3', '20', '11', '0000', NULL, NULL, NULL, NULL, 'OTRAS GANANCIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (732, 4, '3', '20', '12', '0000', NULL, NULL, NULL, NULL, 'INGRESOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (733, 4, '4', '00', '00', '0000', NULL, NULL, NULL, NULL, 'RESULTADO PERDIDA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (734, 4, '4', '10', '00', '0000', NULL, NULL, NULL, NULL, 'COSTO DE VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (735, 4, '4', '10', '10', '1001', NULL, NULL, NULL, NULL, 'COSTO DE GRUAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (736, 4, '4', '10', '10', '1002', NULL, NULL, NULL, NULL, 'COSTO DE ACCESORIAS DE GRUAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (737, 4, '4', '10', '10', '1003', NULL, NULL, NULL, NULL, 'COSTO DE PLATAFORMAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (738, 4, '4', '10', '10', '1004', NULL, NULL, NULL, NULL, 'COSTO DE REPUESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (739, 4, '4', '10', '10', '1005', NULL, NULL, NULL, NULL, 'COSTO DE SERVICIO TECNICO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (740, 4, '4', '10', '10', '1006', NULL, NULL, NULL, NULL, 'COSTO DE LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (741, 4, '4', '10', '10', '2001', NULL, NULL, NULL, NULL, 'COSTO DE ARRIENDO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (742, 4, '4', '20', '10', '0000', NULL, NULL, NULL, NULL, 'OTROS COSTOS DE EXPLOTACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (743, 4, '4', '20', '11', '0000', NULL, NULL, NULL, NULL, 'GASTOS DE ADMINISTRACION Y VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (744, 4, '4', '20', '11', '1001', NULL, NULL, NULL, NULL, 'REMUNERACIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (745, 4, '4', '20', '11', '1002', NULL, NULL, NULL, NULL, 'COMISIONES POR VENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (746, 4, '4', '20', '11', '1003', NULL, NULL, NULL, NULL, 'FINIQUITOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (747, 4, '4', '20', '11', '2001', NULL, NULL, NULL, NULL, 'ASESORIA INFORMATICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (748, 4, '4', '20', '11', '2002', NULL, NULL, NULL, NULL, 'ASESORIA COMEX', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (749, 4, '4', '20', '11', '2003', NULL, NULL, NULL, NULL, 'ASESORIA DE MARKETING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (750, 4, '4', '20', '11', '2004', NULL, NULL, NULL, NULL, 'ASESORIA LEGAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (751, 4, '4', '20', '11', '2005', NULL, NULL, NULL, NULL, 'ASESORIA CONTABLE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (752, 4, '4', '20', '11', '2006', NULL, NULL, NULL, NULL, 'ASESORIA TECNICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (753, 4, '4', '20', '11', '3001', NULL, NULL, NULL, NULL, 'GASTOS DE PUBLICIDAD', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (754, 4, '4', '20', '11', '3002', NULL, NULL, NULL, NULL, 'GASTOS DE REPRESENTACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (755, 4, '4', '20', '11', '3003', NULL, NULL, NULL, NULL, 'VIAJES Y ESTADIAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (756, 4, '4', '20', '11', '3004', NULL, NULL, NULL, NULL, 'FERIAS Y STAND', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (757, 4, '4', '20', '11', '4001', NULL, NULL, NULL, NULL, 'ARRIENDO DE OFICINAS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (758, 4, '4', '20', '11', '4002', NULL, NULL, NULL, NULL, 'COMBUSTIBLE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (759, 4, '4', '20', '11', '4003', NULL, NULL, NULL, NULL, 'GASTOS DE OFICINA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (760, 4, '4', '20', '11', '4004', NULL, NULL, NULL, NULL, 'MANTENCION DE VEHICULOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (761, 4, '4', '20', '11', '4005', NULL, NULL, NULL, NULL, 'TELEFONOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (762, 4, '4', '20', '11', '4006', NULL, NULL, NULL, NULL, 'AGUA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (763, 4, '4', '20', '11', '4007', NULL, NULL, NULL, NULL, 'ELECTRICIDAD', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (764, 4, '4', '20', '11', '4008', NULL, NULL, NULL, NULL, 'GASTOS DE IMPRENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (765, 4, '4', '20', '11', '5001', NULL, NULL, NULL, NULL, 'SERVICIO DE ASEO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (766, 4, '4', '20', '11', '5002', NULL, NULL, NULL, NULL, 'SERVICIO DE VIGILANCIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (767, 4, '4', '20', '11', '6001', NULL, NULL, NULL, NULL, 'SEGUROS DE CHEQUES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (768, 4, '4', '20', '11', '6002', NULL, NULL, NULL, NULL, 'SEGUROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (769, 4, '4', '20', '11', '7001', NULL, NULL, NULL, NULL, 'COLACION', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (770, 4, '4', '20', '11', '7002', NULL, NULL, NULL, NULL, 'CORRESPONDENCIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (771, 4, '4', '20', '11', '7003', NULL, NULL, NULL, NULL, 'ALARMA DE SEGURIDAD', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (772, 4, '4', '20', '11', '7004', NULL, NULL, NULL, NULL, 'TAG', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (773, 4, '4', '20', '11', '7005', NULL, NULL, NULL, NULL, 'ROPA DE TRABAJO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (774, 4, '4', '20', '11', '7006', NULL, NULL, NULL, NULL, 'GASTOS DE TV CABLE', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (775, 4, '4', '20', '11', '7007', NULL, NULL, NULL, NULL, 'GASTOS DE DICOM', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (776, 4, '4', '20', '11', '7008', NULL, NULL, NULL, NULL, 'GASTOS DE DOMINIO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (777, 4, '4', '20', '11', '7009', NULL, NULL, NULL, NULL, 'FLETES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (778, 4, '4', '20', '11', '7010', NULL, NULL, NULL, NULL, 'GPS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (779, 4, '4', '20', '12', '0000', NULL, NULL, NULL, NULL, 'OTROS GASTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (780, 4, '4', '20', '13', '0000', NULL, NULL, NULL, NULL, 'COSTOS FINANCIEROS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (781, 4, '4', '20', '13', '1001', NULL, NULL, NULL, NULL, 'GASTOS POR LEASING', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (782, 4, '4', '20', '13', '1002', NULL, NULL, NULL, NULL, 'GASTOS BANCARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (783, 4, '4', '20', '13', '1003', NULL, NULL, NULL, NULL, 'GASTOS POR PROTESTOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (784, 4, '4', '20', '13', '2001', NULL, NULL, NULL, NULL, 'INTERESES BANCARIOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (785, 4, '4', '20', '14', '0000', NULL, NULL, NULL, NULL, 'PARTICIPACION EN RESULTADO POR INVERSIONES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (786, 4, '4', '20', '15', '0000', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (787, 4, '4', '20', '15', '1001', NULL, NULL, NULL, NULL, 'DIFERENCIA DE CAMBIO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (788, 4, '4', '20', '16', '0000', NULL, NULL, NULL, NULL, 'RESULTADO POR UNIDADES DE REAJUSTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (789, 4, '4', '20', '16', '1001', NULL, NULL, NULL, NULL, 'REAJUSTES', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (790, 4, '4', '20', '17', '0000', NULL, NULL, NULL, NULL, 'GASTOS POR IMPUESTO A LA RENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (791, 4, '4', '20', '17', '1001', NULL, NULL, NULL, NULL, 'IMPUESTO A LA RENTA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO planes_cuentas VALUES (792, 4, '5', '00', '00', '0000', NULL, NULL, NULL, NULL, 'CUENTAS DE ORDEN Y TRASPASOS', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);


--
-- Name: plcu_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('plcu_seq', 793, false);


--
-- Name: posh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('posh_seq', 1, false);


--
-- Name: prod_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('prod_seq', 18, false);


--
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO productos VALUES (1, 1, 1, 4, 9, 1, 'COCA COLA RETORNABLE 1 LT', '0001', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (2, 1, 1, 4, 9, 1, 'COCA COLA RETORNABLE 2 LT', '0002', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (3, 1, 1, 4, 9, 1, 'COCA COLA RETORNABLE 2.5 LT', '0003', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (4, 1, 1, 4, 9, 1, 'COCA COLA RETORNABLE 3 LT', '0004', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (5, 1, 1, 4, 9, 1, 'COCA COLA LIGHT RETORNABLE 1 LT', '0005', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (6, 1, 1, 4, 9, 1, 'COCA COLA LIGHT RETORNABLE 2 LT', '0006', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (7, 1, 1, 4, 9, 1, 'COCA COLA LIGHT RETORNABLE 2.5 LT', '0007', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (8, 1, 1, 4, 9, 1, 'COCA COLA LIGHT RETORNABLE 3 LT', '0008', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (9, 1, 1, 4, 9, 1, 'COCA COLA ZERO RETORNABLE 1 LT', '0009', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (10, 1, 1, 4, 9, 1, 'COCA COLA ZERO RETORNABLE 2 LT', '0010', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (11, 1, 1, 4, 9, 1, 'COCA COLA ZERO RETORNABLE 2.5 LT', '0011', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (12, 1, 1, 4, 9, 1, 'COCA COLA ZERO RETORNABLE 3 LT', '0012', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (13, 1, 1, 14, 3, 1, 'JAMÓN DE CERDO PF', '0013', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (14, 1, 1, 14, 3, 1, 'JAMÓN DE CERDO AHUMADO PF', '0014', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (15, 1, 1, 14, 3, 1, 'JAMÓN DE CERDO ACARAMELADO PF', '0015', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (16, 1, 1, 15, 9, 1, 'LIBRO DE RECETAS MASTER CHEF', '0016', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO productos VALUES (17, 1, 1, 5, 9, 1, 'PISCO CAPEL 35°', '0017', 'a', 'a', 'a', 1.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);


--
-- Name: prog_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('prog_seq', 99001, false);


--
-- Data for Name: programas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO programas VALUES (1000, NULL, 'Personales', NULL, 'Personales', 1);
INSERT INTO programas VALUES (1010, 1000, 'Mantención datos personales', 'personas/datos-personales', 'Mantención datos personales', 1);
INSERT INTO programas VALUES (1020, 1000, 'Cambio clave acceso', 'usuarios/cambio_contrasena', 'Cambio clave acceso', 2);
INSERT INTO programas VALUES (2000, NULL, 'Adm. sistema', NULL, 'Administracion sistema', 2);
INSERT INTO programas VALUES (2010, 2000, 'Mantención grupos empresariales', 'grupos-empresariales', 'Mantención grupos empresariales', 1);
INSERT INTO programas VALUES (2020, 2000, 'Mant. estados grupos empresariales', 'estados-grem', 'Mantención estados grupos empresariales', 2);
INSERT INTO programas VALUES (2030, 2000, 'Mant. estados registros', 'estados-registros', 'Mantención estados registros', 3);
INSERT INTO programas VALUES (2040, 2000, 'Mant. estados civiles', 'estados-civiles', 'Mantención estados civiles', 4);
INSERT INTO programas VALUES (2050, 2000, 'Mant. estados solics. servs. hono.', 'principales/en-construccion', 'Mantención estados solics. servs. hono.', 5);
INSERT INTO programas VALUES (2060, 2000, 'Mant. estados cotizacs. servs. hono.', 'principales/en-construccion', 'Mantención estados cotizacs. servs. hono.', 6);
INSERT INTO programas VALUES (2070, 2000, 'Mant. estados órdenes servs. hono.', 'principales/en-construccion', 'Mantención estados órdenes servs. hono.', 7);
INSERT INTO programas VALUES (2080, 2000, 'Mant. ests. pagos órds. servs. hono.', 'principales/en-construccion', 'Mantención ests. pagos órds. servs. hono.', 8);
INSERT INTO programas VALUES (2090, 2000, 'Mant. estados cotizaciones vtas.', 'estados-cotizaciones-vtas', 'Mantención estados cotizaciones vtas.', 9);
INSERT INTO programas VALUES (2100, 2000, 'Mant. estados notas vtas.', 'estados-notas-vtas', 'Mantención estados notas vtas.', 10);
INSERT INTO programas VALUES (2110, 2000, 'Mant. impuestos', 'impuestos', 'Mantención impuestos', 11);
INSERT INTO programas VALUES (2120, 2000, 'Mant. tipos formas pagos', 'tipos-formas-pagos', 'Mantención tipos formas pagos', 12);
INSERT INTO programas VALUES (2130, 2000, 'Mant. tipos clientes', 'tipos-clientes', 'Mantención tipos clientes', 13);
INSERT INTO programas VALUES (2140, 2000, 'Mant. tipos cotizaciones vtas.', 'tipos-cotizaciones-vtas', 'Mantención tipos cotizaciones vtas.', 14);
INSERT INTO programas VALUES (2150, 2000, 'Mant. tipos productos', 'tipos-productos', 'Mantención tipos productos', 15);
INSERT INTO programas VALUES (2160, 2000, 'Mant. tipos productos impuestos', 'tipos-productos-impuestos', 'Mantención tipos productos impuestos', 16);
INSERT INTO programas VALUES (2170, 2000, 'Mant. tipos servicios', 'tipos-servicios', 'Mantención tipos servicios', 17);
INSERT INTO programas VALUES (2180, 2000, 'Mant. unidades territoriales 1', 'unidades-territoriales-1', 'Mantención unidades territoriales 1', 18);
INSERT INTO programas VALUES (2190, 2000, 'Mant. unidades territoriales 2', 'unidades-territoriales-2', 'Mantención unidades territoriales 2', 19);
INSERT INTO programas VALUES (2200, 2000, 'Mant. unidades territoriales 3', 'unidades-territoriales-3', 'Mantención unidades territoriales 3', 20);
INSERT INTO programas VALUES (2210, 2000, 'Mant. estados ventas', 'estados-ventas', 'Mantención estados ventas', 21);
INSERT INTO programas VALUES (2220, 2000, 'Mant. origenes productos', 'origenes-productos', 'Mantención origenes productos', 22);
INSERT INTO programas VALUES (2230, 2000, 'Mant. tipos doctos. ventas', 'tipos-doctos-ventas', 'Mantención tipos doctos. ventas', 23);
INSERT INTO programas VALUES (2240, 2000, 'Mant. unidades medidas productos', 'unidades-medidas-productos', 'Mantención unidades medidas productos', 24);
INSERT INTO programas VALUES (2250, 2000, 'Mant. unidades medidas servicios', 'unidades-medidas-servicios', 'Mantención unidades medidas servicios', 25);
INSERT INTO programas VALUES (3000, NULL, 'Adm. holding', NULL, 'Administracion holding', 3);
INSERT INTO programas VALUES (3010, 3000, 'Mantención empresas', 'empresas', 'Mantención empresas', 1);
INSERT INTO programas VALUES (3020, 3000, 'Mantención personas', 'personas', 'Mantención personas', 2);
INSERT INTO programas VALUES (3030, 3000, 'Mantención usuarios', 'mant-usuarios', 'Mantención usuarios', 3);
INSERT INTO programas VALUES (3040, 3000, 'Mantención parámetros', 'parametros', 'Mantención parámetros', 4);
INSERT INTO programas VALUES (3050, 3000, 'Mantención plan de cuentas', 'principales/en-construccion', 'Mantención plan de cuentas', 5);
INSERT INTO programas VALUES (3060, 3000, 'Mantención rubros', 'rubros', 'Mantención rubros', 6);
INSERT INTO programas VALUES (3070, 3000, 'Mantención tipos documentos legales', 'TiposDocumentosLegales', 'Mantención tipos documentos legales', 7);
INSERT INTO programas VALUES (3080, 3000, 'Mantención estados documentos legales', 'estados-documentos-legales', 'Mantención estados documentos legales', 8);
INSERT INTO programas VALUES (3090, 3000, 'Mantención clientes', 'clientes', 'Mantención rubros', 9);
INSERT INTO programas VALUES (4000, NULL, 'Adm. empresa', NULL, 'Administracion empresa', 4);
INSERT INTO programas VALUES (4010, 4000, 'Mantención gerencias', 'gerencias', 'Mantención gerencias', 1);
INSERT INTO programas VALUES (4020, 4000, 'Mantención proyectos', 'proyectos', 'Mantención proyectos', 2);
INSERT INTO programas VALUES (4030, 4000, 'Mantención líneas de negocios', 'lineas-negocios', 'Mantención líneas de negocios', 3);
INSERT INTO programas VALUES (4040, 4000, 'Mantención centros costos', 'centros-costos', 'Mantención centros costos', 4);
INSERT INTO programas VALUES (4050, 4000, 'Mantención tareas', 'tareas', 'Mantención tareas', 5);
INSERT INTO programas VALUES (4060, 4000, 'Mantención productos', 'productos', 'Mantención productos', 6);
INSERT INTO programas VALUES (4070, 4000, 'Mantención servicios', 'servicios', 'Mantención servicios', 7);
INSERT INTO programas VALUES (5000, NULL, 'Legales', NULL, 'Legales', 5);
INSERT INTO programas VALUES (5010, 5000, 'Documentos legales', 'DocumentosLegales', 'Documentos legales', 1);
INSERT INTO programas VALUES (5020, 5000, 'Gráfica legales', 'DocumentosLegales/estadisticas', 'Gráfica legales', 2);
INSERT INTO programas VALUES (6000, NULL, 'Honorarios', NULL, 'Honorarios', 6);
INSERT INTO programas VALUES (6010, 6000, 'Honorarios 1', 'principales/en-construccion', 'Honorarios 1', 1);
INSERT INTO programas VALUES (6020, 6000, 'Honorarios 2', 'principales/en-construccion', 'Honorarios 2', 2);
INSERT INTO programas VALUES (6030, 6000, 'Honorarios 3', 'principales/en-construccion', 'Honorarios 3', 3);
INSERT INTO programas VALUES (6040, 6000, 'Honorarios 4', 'principales/en-construccion', 'Honorarios 4', 4);
INSERT INTO programas VALUES (6050, 6000, 'Honorarios 5', 'principales/en-construccion', 'Honorarios 5', 5);
INSERT INTO programas VALUES (7000, NULL, 'Rendiciones', NULL, 'Rendiciones', 7);
INSERT INTO programas VALUES (7010, 7000, 'Rendiciones 1', 'principales/en-construccion', 'Rendiciones 1', 1);
INSERT INTO programas VALUES (7020, 7000, 'Rendiciones 2', 'principales/en-construccion', 'Rendiciones 2', 2);
INSERT INTO programas VALUES (7030, 7000, 'Rendiciones 3', 'principales/en-construccion', 'Rendiciones 3', 3);
INSERT INTO programas VALUES (7040, 7000, 'Rendiciones 4', 'principales/en-construccion', 'Rendiciones 4', 4);
INSERT INTO programas VALUES (7050, 7000, 'Rendiciones 5', 'principales/en-construccion', 'Rendiciones 5', 5);
INSERT INTO programas VALUES (8000, NULL, 'Compras', NULL, 'Compras', 8);
INSERT INTO programas VALUES (8010, 8000, 'Compras 1', 'principales/en-construccion', 'Compras 1', 1);
INSERT INTO programas VALUES (8020, 8000, 'Compras 2', 'principales/en-construccion', 'Compras 2', 2);
INSERT INTO programas VALUES (8030, 8000, 'Compras 3', 'principales/en-construccion', 'Compras 3', 3);
INSERT INTO programas VALUES (8040, 8000, 'Compras 4', 'principales/en-construccion', 'Compras 4', 4);
INSERT INTO programas VALUES (8050, 8000, 'Compras 5', 'principales/en-construccion', 'Compras 5', 5);
INSERT INTO programas VALUES (9000, NULL, 'Ventas', NULL, 'Ventas', 9);
INSERT INTO programas VALUES (9010, 9000, 'Cotizaciones ventas', 'CotizacionesVentas', 'Cotizaciones ventas', 1);
INSERT INTO programas VALUES (9020, 9000, 'Notas ventas', 'NotasVentas', 'Notas ventas', 2);
INSERT INTO programas VALUES (9030, 9000, 'Ventas', 'Ventas', 'Ventas', 3);
INSERT INTO programas VALUES (9040, 9000, 'Ventas 4', 'principales/en-construccion', 'Ventas 4', 4);
INSERT INTO programas VALUES (9050, 9000, 'Ventas 5', 'principales/en-construccion', 'Ventas 5', 5);
INSERT INTO programas VALUES (10000, NULL, 'Contabilidad', NULL, 'Contabilidad', 10);
INSERT INTO programas VALUES (10010, 10000, 'Contabilidad 1', 'principales/en-construccion', 'Contabilidad 1', 1);
INSERT INTO programas VALUES (10020, 10000, 'Contabilidad 2', 'principales/en-construccion', 'Contabilidad 2', 2);
INSERT INTO programas VALUES (10030, 10000, 'Contabilidad 3', 'principales/en-construccion', 'Contabilidad 3', 3);
INSERT INTO programas VALUES (10040, 10000, 'Contabilidad 4', 'principales/en-construccion', 'Contabilidad 4', 4);
INSERT INTO programas VALUES (10050, 10000, 'Contabilidad 5', 'principales/en-construccion', 'Contabilidad 5', 5);
INSERT INTO programas VALUES (11000, NULL, 'Existencias', NULL, 'Existencias', 11);
INSERT INTO programas VALUES (11010, 11000, 'Mantención bodegas', 'bodegas', 'Mantención bodegas', 1);
INSERT INTO programas VALUES (11020, 11000, 'Mantención familias productos', 'familias_productos', 'Mantención familias productos', 2);
INSERT INTO programas VALUES (11030, 11000, 'Mantención sub familias productos', 'sub_familias_productos', 'Mantención sub familias productos', 3);
INSERT INTO programas VALUES (11040, 11000, 'Productos por bodega', 'bodegas_productos', 'Productos por bodega', 4);
INSERT INTO programas VALUES (99000, NULL, 'Cambiar emp./perf.', 'sel-perfil', 'Cambiar empresa/perfil', 999);


--
-- Name: proy_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('proy_seq', 55, false);


--
-- Data for Name: proyectos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO proyectos VALUES (1, 2, 'ALTO MAIPO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (2, 2, 'GRAN SANTIAGO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (3, 2, 'PARQUE INDUSTRIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (4, 2, 'CARCEL CONCESIONADA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (5, 2, 'FRUTICOLA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (6, 2, 'METRO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (7, 3, 'ALTO MAIPO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (8, 3, 'GRAN SANTIAGO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (9, 3, 'PARQUE INDUSTRIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (10, 3, 'CARCEL CONCESIONADA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (11, 3, 'FRUTICOLA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (12, 3, 'METRO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (13, 4, 'ALTO MAIPO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (14, 4, 'GRAN SANTIAGO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (15, 4, 'PARQUE INDUSTRIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (16, 4, 'CARCEL CONCESIONADA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (17, 4, 'FRUTICOLA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (18, 4, 'METRO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (19, 5, 'ALTO MAIPO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (20, 5, 'GRAN SANTIAGO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (21, 5, 'PARQUE INDUSTRIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (22, 5, 'CARCEL CONCESIONADA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (23, 5, 'FRUTICOLA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (24, 5, 'METRO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (25, 6, 'ALTO MAIPO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (26, 6, 'GRAN SANTIAGO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (27, 6, 'PARQUE INDUSTRIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (28, 6, 'CARCEL CONCESIONADA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (29, 6, 'FRUTICOLA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (30, 6, 'METRO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (31, 7, 'ALTO MAIPO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (32, 7, 'GRAN SANTIAGO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (33, 7, 'PARQUE INDUSTRIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (34, 7, 'CARCEL CONCESIONADA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (35, 7, 'FRUTICOLA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (36, 7, 'METRO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (37, 8, 'ALTO MAIPO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (38, 8, 'GRAN SANTIAGO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (39, 8, 'PARQUE INDUSTRIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (40, 8, 'CARCEL CONCESIONADA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (41, 8, 'FRUTICOLA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (42, 8, 'METRO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (43, 9, 'ALTO MAIPO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (44, 9, 'GRAN SANTIAGO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (45, 9, 'PARQUE INDUSTRIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (46, 9, 'CARCEL CONCESIONADA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (47, 9, 'FRUTICOLA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (48, 9, 'METRO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (49, 10, 'ALTO MAIPO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (50, 10, 'GRAN SANTIAGO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (51, 10, 'PARQUE INDUSTRIAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (52, 10, 'CARCEL CONCESIONADA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (53, 10, 'FRUTICOLA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO proyectos VALUES (54, 10, 'METRO', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);


--
-- Data for Name: prueba; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO prueba VALUES (1, 1);
INSERT INTO prueba VALUES (1, 2);
INSERT INTO prueba VALUES (1, 2);
INSERT INTO prueba VALUES (1, 3);
INSERT INTO prueba VALUES (1, 3);
INSERT INTO prueba VALUES (4, 1);
INSERT INTO prueba VALUES (4, 2);
INSERT INTO prueba VALUES (4, 2);
INSERT INTO prueba VALUES (4, 3);
INSERT INTO prueba VALUES (4, 4);
INSERT INTO prueba VALUES (5, 1);
INSERT INTO prueba VALUES (5, 2);
INSERT INTO prueba VALUES (5, 2);


--
-- Name: rubr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('rubr_seq', 38, false);


--
-- Data for Name: rubros; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO rubros VALUES (1, 1, 'OTRO');
INSERT INTO rubros VALUES (2, 1, 'CONSULTORÍA');
INSERT INTO rubros VALUES (3, 1, 'AUTOMOTRIZ');
INSERT INTO rubros VALUES (4, 1, 'INDUSTRIAL');
INSERT INTO rubros VALUES (5, 1, 'INVERSIONES');
INSERT INTO rubros VALUES (6, 1, 'AGRÍCOLA');
INSERT INTO rubros VALUES (7, 1, 'FARMACÉUTICO');
INSERT INTO rubros VALUES (8, 1, 'LOGÍSTICA');
INSERT INTO rubros VALUES (9, 1, 'AMASANDERÍA');
INSERT INTO rubros VALUES (10, 2, 'OTRO');
INSERT INTO rubros VALUES (11, 2, 'CONSULTORÍA');
INSERT INTO rubros VALUES (12, 2, 'AUTOMOTRIZ');
INSERT INTO rubros VALUES (13, 2, 'INDUSTRIAL');
INSERT INTO rubros VALUES (14, 2, 'INVERSIONES');
INSERT INTO rubros VALUES (15, 2, 'AGRÍCOLA');
INSERT INTO rubros VALUES (16, 2, 'FARMACÉUTICO');
INSERT INTO rubros VALUES (17, 2, 'LOGÍSTICA');
INSERT INTO rubros VALUES (18, 2, 'AMASANDERÍA');
INSERT INTO rubros VALUES (20, 3, 'OTRO');
INSERT INTO rubros VALUES (21, 3, 'CONSULTORÍA');
INSERT INTO rubros VALUES (22, 3, 'AUTOMOTRIZ');
INSERT INTO rubros VALUES (23, 3, 'INDUSTRIAL');
INSERT INTO rubros VALUES (24, 3, 'INVERSIONES');
INSERT INTO rubros VALUES (25, 3, 'AGRÍCOLA');
INSERT INTO rubros VALUES (26, 3, 'FARMACÉUTICO');
INSERT INTO rubros VALUES (27, 3, 'LOGÍSTICA');
INSERT INTO rubros VALUES (28, 3, 'AMASANDERÍA');
INSERT INTO rubros VALUES (29, 4, 'OTRO');
INSERT INTO rubros VALUES (30, 4, 'CONSULTORÍA');
INSERT INTO rubros VALUES (31, 4, 'AUTOMOTRIZ');
INSERT INTO rubros VALUES (32, 4, 'INDUSTRIAL');
INSERT INTO rubros VALUES (33, 4, 'INVERSIONES');
INSERT INTO rubros VALUES (34, 4, 'AGRÍCOLA');
INSERT INTO rubros VALUES (35, 4, 'FARMACÉUTICO');
INSERT INTO rubros VALUES (36, 4, 'LOGÍSTICA');
INSERT INTO rubros VALUES (37, 4, 'AMASANDERÍA');


--
-- Name: serv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('serv_seq', 7, false);


--
-- Data for Name: servicios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO servicios VALUES (1, 1, 1, 1, 'CONSULTOR JUNIOR', 0.50, 501, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO servicios VALUES (2, 1, 1, 1, 'CONSULTOR SENIOR', 1.00, 501, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO servicios VALUES (3, 1, 1, 1, 'JEFE DE PROYECTO', 1.50, 501, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO servicios VALUES (4, 1, 1, 1, 'GERENTE DE PROYECTO', 3.00, 501, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO servicios VALUES (5, 1, 2, 1, 'ASEO', 5000.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO servicios VALUES (6, 1, 2, 1, 'GUARDIA DE SEGURIDAD', 10000.00, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);


--
-- Name: sexo_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('sexo_seq', 3, false);


--
-- Data for Name: sexos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO sexos VALUES (1, 'M', 'MASCULINO');
INSERT INTO sexos VALUES (2, 'F', 'FEMENINO');


--
-- Name: sfpr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('sfpr_seq', 12, false);


--
-- Data for Name: solicitudes_servs_hono; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Name: sosh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('sosh_seq', 1, false);


--
-- Data for Name: sub_familias_productos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO sub_familias_productos VALUES (1, 1, '01', 'SUB FAMILIA GENÉRICA', 1, '2018-02-18 00:37:42.380033', NULL, NULL, NULL, NULL);
INSERT INTO sub_familias_productos VALUES (2, 2, '01', 'SUB FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO sub_familias_productos VALUES (3, 3, '01', 'SUB FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO sub_familias_productos VALUES (4, 4, '01', 'SUB FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO sub_familias_productos VALUES (5, 5, '01', 'SUB FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO sub_familias_productos VALUES (6, 6, '01', 'SUB FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO sub_familias_productos VALUES (7, 7, '01', 'SUB FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO sub_familias_productos VALUES (8, 8, '01', 'SUB FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO sub_familias_productos VALUES (9, 9, '01', 'SUB FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO sub_familias_productos VALUES (10, 10, '01', 'SUB FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO sub_familias_productos VALUES (11, 11, '01', 'SUB FAMILIA GENÉRICA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);


--
-- Data for Name: tablas_secuencias; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tablas_secuencias VALUES ('grupos_empresariales', 'grem_seq');
INSERT INTO tablas_secuencias VALUES ('empresas', 'empr_seq');
INSERT INTO tablas_secuencias VALUES ('parametros', 'para_seq');
INSERT INTO tablas_secuencias VALUES ('estados_grem', 'esge_seq');
INSERT INTO tablas_secuencias VALUES ('rubros', 'rubr_seq');
INSERT INTO tablas_secuencias VALUES ('estados_registros', 'esre_seq');
INSERT INTO tablas_secuencias VALUES ('valores_paises', 'vapa_seq');
INSERT INTO tablas_secuencias VALUES ('monedas', 'mone_seq');
INSERT INTO tablas_secuencias VALUES ('gerencias', 'gere_seq');
INSERT INTO tablas_secuencias VALUES ('proyectos', 'proy_seq');
INSERT INTO tablas_secuencias VALUES ('lineas_negocios', 'line_seq');
INSERT INTO tablas_secuencias VALUES ('centros_costos', 'ceco_seq');
INSERT INTO tablas_secuencias VALUES ('tareas', 'tare_seq');
INSERT INTO tablas_secuencias VALUES ('paises', 'pais_seq');
INSERT INTO tablas_secuencias VALUES ('personas', 'pers_seq');
INSERT INTO tablas_secuencias VALUES ('perfiles', 'perf_seq');
INSERT INTO tablas_secuencias VALUES ('estados_civiles', 'esci_seq');
INSERT INTO tablas_secuencias VALUES ('sexos', 'sexo_seq');
INSERT INTO tablas_secuencias VALUES ('programas', 'prog_seq');
INSERT INTO tablas_secuencias VALUES ('usuarios', 'usua_seq');
INSERT INTO tablas_secuencias VALUES ('usuarios_perfiles', 'uspe_seq');
INSERT INTO tablas_secuencias VALUES ('perfiles_programas', 'pepr_seq');
INSERT INTO tablas_secuencias VALUES ('planes_cuentas', 'plcu_seq');
INSERT INTO tablas_secuencias VALUES ('documentos_legales', 'dole_seq');
INSERT INTO tablas_secuencias VALUES ('tipos_documentos_legales', 'tidl_seq');
INSERT INTO tablas_secuencias VALUES ('estados_documentos_legales', 'esdl_seq');
INSERT INTO tablas_secuencias VALUES ('solicitudes_servs_hono', 'sosh_seq');
INSERT INTO tablas_secuencias VALUES ('estados_solics_servs_hono', 'essh_seq');
INSERT INTO tablas_secuencias VALUES ('cotizaciones_servs_hono', 'cosh_seq');
INSERT INTO tablas_secuencias VALUES ('doctos_cotizacs_servs_hono', 'dcsh_seq');
INSERT INTO tablas_secuencias VALUES ('estados_cotizacs_servs_hono', 'ecsh_seq');
INSERT INTO tablas_secuencias VALUES ('ordenes_servicios_hono', 'orsh_seq');
INSERT INTO tablas_secuencias VALUES ('doctos_ordenes_servs_hono', 'dosh_seq');
INSERT INTO tablas_secuencias VALUES ('estados_ordenes_servs_hono', 'eosh_seq');
INSERT INTO tablas_secuencias VALUES ('pagos_ordenes_servs_hono', 'posh_seq');
INSERT INTO tablas_secuencias VALUES ('estados_pagos_ords_servs_hono', 'epos_seq');
INSERT INTO tablas_secuencias VALUES ('tipos_formas_pagos', 'tifp_seq');
INSERT INTO tablas_secuencias VALUES ('unidades_territoriales_1', 'unt1_seq');
INSERT INTO tablas_secuencias VALUES ('unidades_territoriales_2', 'unt2_seq');
INSERT INTO tablas_secuencias VALUES ('unidades_territoriales_3', 'unt3_seq');
INSERT INTO tablas_secuencias VALUES ('tipos_clientes', 'ticl_seq');
INSERT INTO tablas_secuencias VALUES ('tipos_cotizaciones_vtas', 'ticv_seq');
INSERT INTO tablas_secuencias VALUES ('estados_cotizaciones_vtas', 'escv_seq');
INSERT INTO tablas_secuencias VALUES ('estados_notas_vtas', 'esnv_seq');
INSERT INTO tablas_secuencias VALUES ('estados_ventas', 'esve_seq');
INSERT INTO tablas_secuencias VALUES ('origenes_productos', 'orpr_seq');
INSERT INTO tablas_secuencias VALUES ('unidades_medidas_productos', 'unmp_seq');
INSERT INTO tablas_secuencias VALUES ('unidades_medidas_servicios', 'unms_seq');
INSERT INTO tablas_secuencias VALUES ('tipos_productos', 'tipr_seq');
INSERT INTO tablas_secuencias VALUES ('impuestos', 'impu_seq');
INSERT INTO tablas_secuencias VALUES ('tipos_productos_impuestos', 'tipi_seq');
INSERT INTO tablas_secuencias VALUES ('tipos_doctos_ventas', 'tidv_seq');
INSERT INTO tablas_secuencias VALUES ('tipos_servicios', 'tise_seq');
INSERT INTO tablas_secuencias VALUES ('clientes', 'clie_seq');
INSERT INTO tablas_secuencias VALUES ('documentos_ventas', 'dove_seq');
INSERT INTO tablas_secuencias VALUES ('detalles_doctos_vtas', 'dedv_seq');
INSERT INTO tablas_secuencias VALUES ('notas_ventas', 'nove_seq');
INSERT INTO tablas_secuencias VALUES ('detalles_notas_vtas', 'denv_seq');
INSERT INTO tablas_secuencias VALUES ('cotizaciones_ventas', 'cove_seq');
INSERT INTO tablas_secuencias VALUES ('detalles_cotizs_vtas', 'decv_seq');
INSERT INTO tablas_secuencias VALUES ('productos', 'prod_seq');
INSERT INTO tablas_secuencias VALUES ('servicios', 'serv_seq');
INSERT INTO tablas_secuencias VALUES ('dominios', 'domi_seq');
INSERT INTO tablas_secuencias VALUES ('valores_dominios', 'vado_seq');
INSERT INTO tablas_secuencias VALUES ('listas_precios', 'lipr_seq');
INSERT INTO tablas_secuencias VALUES ('detalles_listas_precios', 'delp_seq');
INSERT INTO tablas_secuencias VALUES ('familias_productos', 'fapr_seq');
INSERT INTO tablas_secuencias VALUES ('sub_familias_productos', 'sfpr_seq');
INSERT INTO tablas_secuencias VALUES ('descuentos', 'desu_seq');
INSERT INTO tablas_secuencias VALUES ('bodegas', 'bode_seq');
INSERT INTO tablas_secuencias VALUES ('bodegas_productos', 'bopr_seq');


--
-- Name: tare_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tare_seq', 37, false);


--
-- Data for Name: tareas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tareas VALUES (1, 2, 'TAREA PRINCIPAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (2, 2, 'TAREA SECUNDARIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (3, 2, 'OTRA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (4, 2, 'ULTIMA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (5, 3, 'TAREA PRINCIPAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (6, 3, 'TAREA SECUNDARIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (7, 3, 'OTRA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (8, 3, 'ULTIMA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (9, 4, 'TAREA PRINCIPAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (10, 4, 'TAREA SECUNDARIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (11, 4, 'OTRA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (12, 4, 'ULTIMA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (13, 5, 'TAREA PRINCIPAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (14, 5, 'TAREA SECUNDARIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (15, 5, 'OTRA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (16, 5, 'ULTIMA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (17, 6, 'TAREA PRINCIPAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (18, 6, 'TAREA SECUNDARIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (19, 6, 'OTRA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (20, 6, 'ULTIMA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (21, 7, 'TAREA PRINCIPAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (22, 7, 'TAREA SECUNDARIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (23, 7, 'OTRA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (24, 7, 'ULTIMA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (25, 8, 'TAREA PRINCIPAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (26, 8, 'TAREA SECUNDARIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (27, 8, 'OTRA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (28, 8, 'ULTIMA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (29, 9, 'TAREA PRINCIPAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (30, 9, 'TAREA SECUNDARIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (31, 9, 'OTRA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (32, 9, 'ULTIMA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (33, 10, 'TAREA PRINCIPAL', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (34, 10, 'TAREA SECUNDARIA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (35, 10, 'OTRA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tareas VALUES (36, 10, 'ULTIMA TAREA', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);


--
-- Name: ticl_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('ticl_seq', 3, false);


--
-- Name: ticv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('ticv_seq', 3, false);


--
-- Name: tidl_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tidl_seq', 17, false);


--
-- Name: tidv_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tidv_seq', 5, false);


--
-- Name: tifp_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tifp_seq', 7, false);


--
-- Name: timb_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('timb_seq', 6, false);


--
-- Name: tipi_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tipi_seq', 3, false);


--
-- Data for Name: tipos_clientes; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tipos_clientes VALUES (1, 'PERSONA NATURAL');
INSERT INTO tipos_clientes VALUES (2, 'EMPRESA');


--
-- Data for Name: tipos_cotizaciones_vtas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tipos_cotizaciones_vtas VALUES (1, 'PRESUPUESTO');
INSERT INTO tipos_cotizaciones_vtas VALUES (2, 'PROSPECTO');


--
-- Data for Name: tipos_doctos_ventas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tipos_doctos_ventas VALUES (1, 1, 'NO DEFINIDO', 'NODE', '0');
INSERT INTO tipos_doctos_ventas VALUES (2, 1, 'FACTURA ELECTRÓNICA', 'FAEA', '33');
INSERT INTO tipos_doctos_ventas VALUES (3, 1, 'NOTA DE CRÉDITO ELECTRÓNICA', 'NCEL', '61');
INSERT INTO tipos_doctos_ventas VALUES (4, 1, 'GUÍA DE DESPACHO ELECTRÓNICA', 'GDEL', '52');


--
-- Data for Name: tipos_documentos_legales; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tipos_documentos_legales VALUES (1, 1, 'CONSTITUCIÓN DE SOCIEDAD', 'CONST. SOC.', '#FF0000', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (2, 1, 'ACTA DE DIRECTORIO', 'ACTA DIR.', '#00FF00', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (3, 1, 'SESIÓN DE DIRECTORIO', 'SES. DIR.', '#0000FF', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (4, 1, 'CONTRATO DE ARRIENDO', 'CONT. ARR.', '#FFFFFF', 1, '2018-02-18 00:37:41.986427', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (5, 2, 'CONSTITUCIÓN DE SOCIEDAD', 'CONST. SOC.', '#FF0000', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (6, 2, 'ACTA DE DIRECTORIO', 'ACTA DIR.', '#00FF00', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (7, 2, 'SESIÓN DE DIRECTORIO', 'SES. DIR.', '#0000FF', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (8, 2, 'CONTRATO DE ARRIENDO', 'CONT. ARR.', '#FFFFFF', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (9, 3, 'CONSTITUCIÓN DE SOCIEDAD', 'CONST. SOC.', '#FF0000', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (10, 3, 'ACTA DE DIRECTORIO', 'ACTA DIR.', '#00FF00', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (11, 3, 'SESIÓN DE DIRECTORIO', 'SES. DIR.', '#0000FF', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (12, 3, 'CONTRATO DE ARRIENDO', 'CONT. ARR.', '#FFFFFF', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (13, 4, 'CONSTITUCIÓN DE SOCIEDAD', 'CONST. SOC.', '#FF0000', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (14, 4, 'ACTA DE DIRECTORIO', 'ACTA DIR.', '#00FF00', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (15, 4, 'SESIÓN DE DIRECTORIO', 'SES. DIR.', '#0000FF', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO tipos_documentos_legales VALUES (16, 4, 'CONTRATO DE ARRIENDO', 'CONT. ARR.', '#FFFFFF', 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);


--
-- Data for Name: tipos_formas_pagos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tipos_formas_pagos VALUES (1, 'EFECTIVO');
INSERT INTO tipos_formas_pagos VALUES (2, 'TARJETA CRÉDITO');
INSERT INTO tipos_formas_pagos VALUES (3, 'TARJETA DÉBITO');
INSERT INTO tipos_formas_pagos VALUES (4, 'CHEQUE');
INSERT INTO tipos_formas_pagos VALUES (5, 'LETRA');
INSERT INTO tipos_formas_pagos VALUES (6, 'VALE VISTA');


--
-- Data for Name: tipos_movimientos_bodegas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tipos_movimientos_bodegas VALUES (1, 'SALIDA POR VENTA', -1);
INSERT INTO tipos_movimientos_bodegas VALUES (2, 'ENTRADA POR ADQUISICIÓN', 1);
INSERT INTO tipos_movimientos_bodegas VALUES (3, 'SALIDA POR TRASPASO ENTRE BODEGAS', -1);
INSERT INTO tipos_movimientos_bodegas VALUES (4, 'ENTRADA POR TRASPASO ENTRE BODEGAS', 1);
INSERT INTO tipos_movimientos_bodegas VALUES (5, 'ENTRADA POR DEVOLUCIÓN', 1);


--
-- Data for Name: tipos_productos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tipos_productos VALUES (1, 'ARTICULOS DE ASEO', 'N');
INSERT INTO tipos_productos VALUES (2, 'ARTICULOS DE ESCRITORIO', 'N');
INSERT INTO tipos_productos VALUES (3, 'ARTICULOS DE PERFUMERÍA', 'N');
INSERT INTO tipos_productos VALUES (4, 'BEBIDAS GASEOSAS', 'N');
INSERT INTO tipos_productos VALUES (5, 'BABIDAS ALCOHÓLICAS', 'N');
INSERT INTO tipos_productos VALUES (6, 'CIGARRILLOS', 'N');
INSERT INTO tipos_productos VALUES (7, 'CARNE', 'N');
INSERT INTO tipos_productos VALUES (8, 'PETRÓLEO', 'N');
INSERT INTO tipos_productos VALUES (9, 'BENCINA', 'N');
INSERT INTO tipos_productos VALUES (10, 'PARAFINA', 'N');
INSERT INTO tipos_productos VALUES (11, 'ALIMENTOS NO PERECIBLES', 'N');
INSERT INTO tipos_productos VALUES (12, 'ALIMENTOS PERECIBLES FRUTAS', 'N');
INSERT INTO tipos_productos VALUES (13, 'ALIMENTOS PERECIBLES VERDURAS', 'N');
INSERT INTO tipos_productos VALUES (14, 'ALIMENTOS PERECIBLES OTROS', 'N');
INSERT INTO tipos_productos VALUES (15, 'LIBROS', 'S');


--
-- Data for Name: tipos_productos_impuestos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tipos_productos_impuestos VALUES (1, 4, 3);
INSERT INTO tipos_productos_impuestos VALUES (2, 5, 2);


--
-- Data for Name: tipos_servicios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO tipos_servicios VALUES (1, 'SERVICIOS PROFESIONALES', 'S');
INSERT INTO tipos_servicios VALUES (2, 'SERVICIOS NO PROFESIONALES', 'N');


--
-- Name: tipr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tipr_seq', 16, false);


--
-- Name: tise_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('tise_seq', 3, false);


--
-- Data for Name: unidades_medidas_productos; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO unidades_medidas_productos VALUES (1, 'MILÍGRAMOS', 'MG');
INSERT INTO unidades_medidas_productos VALUES (2, 'GRAMOS', 'GR');
INSERT INTO unidades_medidas_productos VALUES (3, 'KILÓGRAMOS', 'KG');
INSERT INTO unidades_medidas_productos VALUES (4, 'MILÍMETROS', 'MM');
INSERT INTO unidades_medidas_productos VALUES (5, 'CENTÍMETROS', 'CM');
INSERT INTO unidades_medidas_productos VALUES (6, 'METROS', 'MT');
INSERT INTO unidades_medidas_productos VALUES (7, 'MILÍLITROS', 'ML');
INSERT INTO unidades_medidas_productos VALUES (8, 'LITROS', 'LT');
INSERT INTO unidades_medidas_productos VALUES (9, 'UNIDADES', 'UN');


--
-- Data for Name: unidades_medidas_servicios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO unidades_medidas_servicios VALUES (1, 'HORAS HOMBRE', 'HH');


--
-- Data for Name: unidades_territoriales_1; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO unidades_territoriales_1 VALUES (1, 1, 'REGIÓN DE TARAPACÁ');
INSERT INTO unidades_territoriales_1 VALUES (2, 1, 'REGIÓN DE ANTOFAGASTA');
INSERT INTO unidades_territoriales_1 VALUES (3, 1, 'REGIÓN DE ATACAMA');
INSERT INTO unidades_territoriales_1 VALUES (4, 1, 'REGIÓN DE COQUIMBO');
INSERT INTO unidades_territoriales_1 VALUES (5, 1, 'REGIÓN DE VALPARAÍSO');
INSERT INTO unidades_territoriales_1 VALUES (6, 1, 'REGIÓN DEL LIBERTADOR GENERAL BERNARDO O''HIGGINS');
INSERT INTO unidades_territoriales_1 VALUES (7, 1, 'REGIÓN DEL MAULE');
INSERT INTO unidades_territoriales_1 VALUES (8, 1, 'REGIÓN DEL BIOBÍO');
INSERT INTO unidades_territoriales_1 VALUES (9, 1, 'REGIÓN DE LA ARAUCANÍA');
INSERT INTO unidades_territoriales_1 VALUES (10, 1, 'REGIÓN DE LOS LAGOS');
INSERT INTO unidades_territoriales_1 VALUES (11, 1, 'REGIÓN DE AISÉN DEL GENERAL CARLOS IBAÑEZ DEL CAMPO');
INSERT INTO unidades_territoriales_1 VALUES (12, 1, 'REGIÓN DE MAGALLANES Y DE LA ANTÁRTICA CHILENA');
INSERT INTO unidades_territoriales_1 VALUES (13, 1, 'REGIÓN METROPOLITANA DE SANTIAGO');
INSERT INTO unidades_territoriales_1 VALUES (14, 1, 'REGIÓN DE LOS RÍOS');
INSERT INTO unidades_territoriales_1 VALUES (15, 1, 'REGIÓN DE ARICA Y PARINACOTA');
INSERT INTO unidades_territoriales_1 VALUES (16, 1, 'REGIÓN DEL ÑUBLE');


--
-- Data for Name: unidades_territoriales_2; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO unidades_territoriales_2 VALUES (1, 1, 'IQUIQUE');
INSERT INTO unidades_territoriales_2 VALUES (2, 1, 'TAMARUGAL');
INSERT INTO unidades_territoriales_2 VALUES (3, 2, 'TOCOPILLA');
INSERT INTO unidades_territoriales_2 VALUES (4, 2, 'EL LOA');
INSERT INTO unidades_territoriales_2 VALUES (5, 2, 'ANTOFAGASTA');
INSERT INTO unidades_territoriales_2 VALUES (6, 3, 'CHAÑARAL');
INSERT INTO unidades_territoriales_2 VALUES (7, 3, 'COPIAPÓ');
INSERT INTO unidades_territoriales_2 VALUES (8, 3, 'HUASCO');
INSERT INTO unidades_territoriales_2 VALUES (9, 4, 'ELQUI');
INSERT INTO unidades_territoriales_2 VALUES (10, 4, 'LIMARI');
INSERT INTO unidades_territoriales_2 VALUES (11, 4, 'CHOAPA');
INSERT INTO unidades_territoriales_2 VALUES (12, 5, 'PETORCA');
INSERT INTO unidades_territoriales_2 VALUES (13, 5, 'SAN FELIPE DE ACONCAGUA');
INSERT INTO unidades_territoriales_2 VALUES (14, 5, 'QUILLOTA');
INSERT INTO unidades_territoriales_2 VALUES (15, 5, 'LOS ANDES');
INSERT INTO unidades_territoriales_2 VALUES (16, 5, 'VALPARAISO');
INSERT INTO unidades_territoriales_2 VALUES (17, 5, 'SAN ANTONIO');
INSERT INTO unidades_territoriales_2 VALUES (18, 5, 'ISLA DE PASCUA');
INSERT INTO unidades_territoriales_2 VALUES (19, 6, 'CACHAPOAL');
INSERT INTO unidades_territoriales_2 VALUES (20, 6, 'CARDENAL CARO');
INSERT INTO unidades_territoriales_2 VALUES (21, 6, 'COLCHAGUA');
INSERT INTO unidades_territoriales_2 VALUES (22, 7, 'CURICÓ');
INSERT INTO unidades_territoriales_2 VALUES (23, 7, 'TALCA');
INSERT INTO unidades_territoriales_2 VALUES (24, 7, 'CAUQUENES');
INSERT INTO unidades_territoriales_2 VALUES (25, 7, 'LINARES');
INSERT INTO unidades_territoriales_2 VALUES (26, 8, 'ÑUBLE');
INSERT INTO unidades_territoriales_2 VALUES (27, 8, 'CONCEPCIÓN');
INSERT INTO unidades_territoriales_2 VALUES (28, 8, 'BIOBÍO');
INSERT INTO unidades_territoriales_2 VALUES (29, 8, 'ARAUCO');
INSERT INTO unidades_territoriales_2 VALUES (30, 9, 'MALLECO');
INSERT INTO unidades_territoriales_2 VALUES (31, 9, 'CAUTIN');
INSERT INTO unidades_territoriales_2 VALUES (32, 10, 'OSORNO');
INSERT INTO unidades_territoriales_2 VALUES (33, 10, 'LLANQUIHUE');
INSERT INTO unidades_territoriales_2 VALUES (34, 10, 'CHILOE');
INSERT INTO unidades_territoriales_2 VALUES (35, 10, 'PALENA');
INSERT INTO unidades_territoriales_2 VALUES (36, 11, 'AISÉN');
INSERT INTO unidades_territoriales_2 VALUES (37, 11, 'COYHAIQUE');
INSERT INTO unidades_territoriales_2 VALUES (38, 11, 'GENERAL CARRERA');
INSERT INTO unidades_territoriales_2 VALUES (39, 11, 'CAPITAN PRAT');
INSERT INTO unidades_territoriales_2 VALUES (40, 12, 'ULTIMA ESPERANZA');
INSERT INTO unidades_territoriales_2 VALUES (41, 12, 'MAGALLANES');
INSERT INTO unidades_territoriales_2 VALUES (42, 12, 'TIERRA DEL FUEGO');
INSERT INTO unidades_territoriales_2 VALUES (43, 12, 'ANTARTICA CHILENA');
INSERT INTO unidades_territoriales_2 VALUES (44, 13, 'SANTIAGO');
INSERT INTO unidades_territoriales_2 VALUES (45, 13, 'CHACABUCO');
INSERT INTO unidades_territoriales_2 VALUES (46, 13, 'MELIPILLA');
INSERT INTO unidades_territoriales_2 VALUES (47, 13, 'TALAGANTE');
INSERT INTO unidades_territoriales_2 VALUES (48, 13, 'MAIPO');
INSERT INTO unidades_territoriales_2 VALUES (49, 13, 'CORDILLERA');
INSERT INTO unidades_territoriales_2 VALUES (50, 14, 'VALDIVIA');
INSERT INTO unidades_territoriales_2 VALUES (51, 14, 'RANCO');
INSERT INTO unidades_territoriales_2 VALUES (52, 15, 'PARINACOTA');
INSERT INTO unidades_territoriales_2 VALUES (53, 15, 'ARICA');
INSERT INTO unidades_territoriales_2 VALUES (54, 16, 'ITATA');
INSERT INTO unidades_territoriales_2 VALUES (55, 16, 'DIGUILLIN');
INSERT INTO unidades_territoriales_2 VALUES (56, 16, 'PUNILLA');


--
-- Data for Name: unidades_territoriales_3; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO unidades_territoriales_3 VALUES (1, 1, 'IQUIQUE');
INSERT INTO unidades_territoriales_3 VALUES (2, 1, 'ALTO HOSPICIO');
INSERT INTO unidades_territoriales_3 VALUES (3, 2, 'HUARA');
INSERT INTO unidades_territoriales_3 VALUES (4, 2, 'CAMIÑA');
INSERT INTO unidades_territoriales_3 VALUES (5, 2, 'COLCHANE');
INSERT INTO unidades_territoriales_3 VALUES (6, 2, 'POZO ALMONTE');
INSERT INTO unidades_territoriales_3 VALUES (7, 2, 'PICA');
INSERT INTO unidades_territoriales_3 VALUES (8, 3, 'TOCOPILLA');
INSERT INTO unidades_territoriales_3 VALUES (9, 3, 'MARIA ELENA');
INSERT INTO unidades_territoriales_3 VALUES (10, 4, 'CALAMA');
INSERT INTO unidades_territoriales_3 VALUES (11, 4, 'OLLAGÜE');
INSERT INTO unidades_territoriales_3 VALUES (12, 4, 'SAN PEDRO DE ATACAMA');
INSERT INTO unidades_territoriales_3 VALUES (13, 5, 'MEJILLONES');
INSERT INTO unidades_territoriales_3 VALUES (14, 5, 'SIERRA GORDA');
INSERT INTO unidades_territoriales_3 VALUES (15, 5, 'ANTOFAGASTA');
INSERT INTO unidades_territoriales_3 VALUES (16, 5, 'TALTAL');
INSERT INTO unidades_territoriales_3 VALUES (17, 6, 'CHAÑARAL');
INSERT INTO unidades_territoriales_3 VALUES (18, 6, 'DIEGO DE ALMAGRO');
INSERT INTO unidades_territoriales_3 VALUES (19, 7, 'CALDERA');
INSERT INTO unidades_territoriales_3 VALUES (20, 7, 'COPIAPÓ');
INSERT INTO unidades_territoriales_3 VALUES (21, 7, 'TIERRA AMARILLA');
INSERT INTO unidades_territoriales_3 VALUES (22, 8, 'HUASCO');
INSERT INTO unidades_territoriales_3 VALUES (23, 8, 'VALLENAR');
INSERT INTO unidades_territoriales_3 VALUES (24, 8, 'FREIRINA');
INSERT INTO unidades_territoriales_3 VALUES (25, 8, 'ALTO DEL CARMEN');
INSERT INTO unidades_territoriales_3 VALUES (26, 9, 'LA HIGUERA');
INSERT INTO unidades_territoriales_3 VALUES (27, 9, 'VICUÑA');
INSERT INTO unidades_territoriales_3 VALUES (28, 9, 'LA SERENA');
INSERT INTO unidades_territoriales_3 VALUES (29, 9, 'COQUIMBO');
INSERT INTO unidades_territoriales_3 VALUES (30, 9, 'ANDACOLLO');
INSERT INTO unidades_territoriales_3 VALUES (31, 9, 'PAIHUANO');
INSERT INTO unidades_territoriales_3 VALUES (32, 10, 'OVALLE');
INSERT INTO unidades_territoriales_3 VALUES (33, 10, 'RIO HURTADO');
INSERT INTO unidades_territoriales_3 VALUES (34, 10, 'PUNITAQUI');
INSERT INTO unidades_territoriales_3 VALUES (35, 10, 'MONTE PATRIA');
INSERT INTO unidades_territoriales_3 VALUES (36, 10, 'COMBARBALÁ');
INSERT INTO unidades_territoriales_3 VALUES (37, 11, 'CANELA');
INSERT INTO unidades_territoriales_3 VALUES (38, 11, 'ILLAPEL');
INSERT INTO unidades_territoriales_3 VALUES (39, 11, 'LOS VILOS');
INSERT INTO unidades_territoriales_3 VALUES (40, 11, 'SALAMANCA');
INSERT INTO unidades_territoriales_3 VALUES (41, 12, 'PETORCA');
INSERT INTO unidades_territoriales_3 VALUES (42, 12, 'LA LIGUA');
INSERT INTO unidades_territoriales_3 VALUES (43, 12, 'CABILDO');
INSERT INTO unidades_territoriales_3 VALUES (44, 12, 'PAPUDO');
INSERT INTO unidades_territoriales_3 VALUES (45, 12, 'ZAPALLAR');
INSERT INTO unidades_territoriales_3 VALUES (46, 13, 'PUTAENDO');
INSERT INTO unidades_territoriales_3 VALUES (47, 13, 'CATEMU');
INSERT INTO unidades_territoriales_3 VALUES (48, 13, 'SAN FELIPE');
INSERT INTO unidades_territoriales_3 VALUES (49, 13, 'SANTA MARIA');
INSERT INTO unidades_territoriales_3 VALUES (50, 13, 'PANQUEHUE');
INSERT INTO unidades_territoriales_3 VALUES (51, 13, 'LLAILLAY');
INSERT INTO unidades_territoriales_3 VALUES (52, 14, 'NOGALES');
INSERT INTO unidades_territoriales_3 VALUES (53, 14, 'LA CALERA');
INSERT INTO unidades_territoriales_3 VALUES (54, 14, 'LA CRUZ');
INSERT INTO unidades_territoriales_3 VALUES (55, 14, 'QUILLOTA');
INSERT INTO unidades_territoriales_3 VALUES (56, 14, 'HIJUELAS');
INSERT INTO unidades_territoriales_3 VALUES (57, 14, 'LIMACHE');
INSERT INTO unidades_territoriales_3 VALUES (58, 14, 'OLMUE');
INSERT INTO unidades_territoriales_3 VALUES (59, 15, 'SAN ESTEBAN');
INSERT INTO unidades_territoriales_3 VALUES (60, 15, 'RINCONADA');
INSERT INTO unidades_territoriales_3 VALUES (61, 15, 'CALLE LARGA');
INSERT INTO unidades_territoriales_3 VALUES (62, 15, 'LOS ANDES');
INSERT INTO unidades_territoriales_3 VALUES (63, 16, 'PUCHUNCAVI');
INSERT INTO unidades_territoriales_3 VALUES (64, 16, 'JUAN FERNANDEZ');
INSERT INTO unidades_territoriales_3 VALUES (65, 16, 'QUINTERO');
INSERT INTO unidades_territoriales_3 VALUES (66, 16, 'VINA DEL MAR');
INSERT INTO unidades_territoriales_3 VALUES (67, 16, 'VILLA ALEMANA');
INSERT INTO unidades_territoriales_3 VALUES (68, 16, 'VALPARAISO');
INSERT INTO unidades_territoriales_3 VALUES (69, 16, 'QUILPUE');
INSERT INTO unidades_territoriales_3 VALUES (70, 16, 'CASABLANCA');
INSERT INTO unidades_territoriales_3 VALUES (71, 16, 'CONCÓN');
INSERT INTO unidades_territoriales_3 VALUES (72, 17, 'ALGARROBO');
INSERT INTO unidades_territoriales_3 VALUES (73, 17, 'EL QUISCO');
INSERT INTO unidades_territoriales_3 VALUES (74, 17, 'EL TABO');
INSERT INTO unidades_territoriales_3 VALUES (75, 17, 'CARTAGENA');
INSERT INTO unidades_territoriales_3 VALUES (76, 17, 'SAN ANTONIO');
INSERT INTO unidades_territoriales_3 VALUES (77, 17, 'SANTO DOMINGO');
INSERT INTO unidades_territoriales_3 VALUES (78, 18, 'ISLA DE PASCUA');
INSERT INTO unidades_territoriales_3 VALUES (79, 19, 'MOSTAZAL');
INSERT INTO unidades_territoriales_3 VALUES (80, 19, 'GRANEROS');
INSERT INTO unidades_territoriales_3 VALUES (81, 19, 'CODEGUA');
INSERT INTO unidades_territoriales_3 VALUES (82, 19, 'RANCAGUA');
INSERT INTO unidades_territoriales_3 VALUES (83, 19, 'MACHALI');
INSERT INTO unidades_territoriales_3 VALUES (84, 19, 'LAS CABRAS');
INSERT INTO unidades_territoriales_3 VALUES (85, 19, 'COLTAUCO');
INSERT INTO unidades_territoriales_3 VALUES (86, 19, 'DONIHUE');
INSERT INTO unidades_territoriales_3 VALUES (87, 19, 'OLIVAR');
INSERT INTO unidades_territoriales_3 VALUES (88, 19, 'COINCO');
INSERT INTO unidades_territoriales_3 VALUES (89, 19, 'REQUINOA');
INSERT INTO unidades_territoriales_3 VALUES (90, 19, 'PEUMO');
INSERT INTO unidades_territoriales_3 VALUES (91, 19, 'QUINTA DE TILCOCO');
INSERT INTO unidades_territoriales_3 VALUES (92, 19, 'PICHIDEGUA');
INSERT INTO unidades_territoriales_3 VALUES (93, 19, 'SAN VICENTE');
INSERT INTO unidades_territoriales_3 VALUES (94, 19, 'MALLOA');
INSERT INTO unidades_territoriales_3 VALUES (95, 19, 'RENGO');
INSERT INTO unidades_territoriales_3 VALUES (96, 20, 'NAVIDAD');
INSERT INTO unidades_territoriales_3 VALUES (97, 20, 'LITUECHE');
INSERT INTO unidades_territoriales_3 VALUES (98, 20, 'LA ESTRELLA');
INSERT INTO unidades_territoriales_3 VALUES (99, 20, 'PICHILEMU');
INSERT INTO unidades_territoriales_3 VALUES (100, 20, 'MARCHIHUE');
INSERT INTO unidades_territoriales_3 VALUES (101, 20, 'PAREDONES');
INSERT INTO unidades_territoriales_3 VALUES (102, 21, 'PERALILLO');
INSERT INTO unidades_territoriales_3 VALUES (103, 21, 'PALMILLA');
INSERT INTO unidades_territoriales_3 VALUES (104, 21, 'SAN FERNANDO');
INSERT INTO unidades_territoriales_3 VALUES (105, 21, 'PUMANQUE');
INSERT INTO unidades_territoriales_3 VALUES (106, 21, 'SANTA CRUZ');
INSERT INTO unidades_territoriales_3 VALUES (107, 21, 'NANCAGUA');
INSERT INTO unidades_territoriales_3 VALUES (108, 21, 'PLACILLA');
INSERT INTO unidades_territoriales_3 VALUES (109, 21, 'LOLOL');
INSERT INTO unidades_territoriales_3 VALUES (110, 21, 'CHEPICA');
INSERT INTO unidades_territoriales_3 VALUES (111, 21, 'CHIMBARONGO');
INSERT INTO unidades_territoriales_3 VALUES (112, 22, 'TENO');
INSERT INTO unidades_territoriales_3 VALUES (113, 22, 'VICHUQUÉN');
INSERT INTO unidades_territoriales_3 VALUES (114, 22, 'HUALAÑE');
INSERT INTO unidades_territoriales_3 VALUES (115, 22, 'RAUCO');
INSERT INTO unidades_territoriales_3 VALUES (116, 22, 'CURICÓ');
INSERT INTO unidades_territoriales_3 VALUES (117, 22, 'ROMERAL');
INSERT INTO unidades_territoriales_3 VALUES (118, 22, 'LICANTÉN');
INSERT INTO unidades_territoriales_3 VALUES (119, 22, 'SAGRADA FAMILIA');
INSERT INTO unidades_territoriales_3 VALUES (120, 22, 'MOLINA');
INSERT INTO unidades_territoriales_3 VALUES (121, 23, 'CUREPTO');
INSERT INTO unidades_territoriales_3 VALUES (122, 23, 'RIO CLARO');
INSERT INTO unidades_territoriales_3 VALUES (123, 23, 'CONSTITUCIÓN');
INSERT INTO unidades_territoriales_3 VALUES (124, 23, 'PENCAHUE');
INSERT INTO unidades_territoriales_3 VALUES (125, 23, 'TALCA');
INSERT INTO unidades_territoriales_3 VALUES (126, 23, 'PELARCO');
INSERT INTO unidades_territoriales_3 VALUES (127, 23, 'SAN CLEMENTE');
INSERT INTO unidades_territoriales_3 VALUES (128, 23, 'MAULE');
INSERT INTO unidades_territoriales_3 VALUES (129, 23, 'EMPEDRADO');
INSERT INTO unidades_territoriales_3 VALUES (130, 23, 'SAN RAFAEL');
INSERT INTO unidades_territoriales_3 VALUES (131, 24, 'CHANCO');
INSERT INTO unidades_territoriales_3 VALUES (132, 24, 'CAUQUENES');
INSERT INTO unidades_territoriales_3 VALUES (133, 24, 'PELLUHUE');
INSERT INTO unidades_territoriales_3 VALUES (134, 25, 'SAN JAVIER');
INSERT INTO unidades_territoriales_3 VALUES (135, 25, 'VILLA ALEGRE');
INSERT INTO unidades_territoriales_3 VALUES (136, 25, 'YERBAS BUENAS');
INSERT INTO unidades_territoriales_3 VALUES (137, 25, 'COLBUN');
INSERT INTO unidades_territoriales_3 VALUES (138, 25, 'LINARES');
INSERT INTO unidades_territoriales_3 VALUES (139, 25, 'RETIRO');
INSERT INTO unidades_territoriales_3 VALUES (140, 25, 'LONGAVI');
INSERT INTO unidades_territoriales_3 VALUES (141, 25, 'PARRAL');
INSERT INTO unidades_territoriales_3 VALUES (163, 27, 'TOME');
INSERT INTO unidades_territoriales_3 VALUES (164, 27, 'FLORIDA');
INSERT INTO unidades_territoriales_3 VALUES (165, 27, 'TALCAHUANO');
INSERT INTO unidades_territoriales_3 VALUES (166, 27, 'HUALPÉN');
INSERT INTO unidades_territoriales_3 VALUES (167, 27, 'PENCO');
INSERT INTO unidades_territoriales_3 VALUES (168, 27, 'CONCEPCIÓN');
INSERT INTO unidades_territoriales_3 VALUES (169, 27, 'SAN PEDRO DE LA PAZ');
INSERT INTO unidades_territoriales_3 VALUES (170, 27, 'CHIGUAYANTE');
INSERT INTO unidades_territoriales_3 VALUES (171, 27, 'HUALQUI');
INSERT INTO unidades_territoriales_3 VALUES (172, 27, 'CORONEL');
INSERT INTO unidades_territoriales_3 VALUES (173, 27, 'LOTA');
INSERT INTO unidades_territoriales_3 VALUES (174, 27, 'SANTA JUANA');
INSERT INTO unidades_territoriales_3 VALUES (175, 27, 'YUMBEL');
INSERT INTO unidades_territoriales_3 VALUES (176, 28, 'CABRERO');
INSERT INTO unidades_territoriales_3 VALUES (177, 28, 'TUCAPEL');
INSERT INTO unidades_territoriales_3 VALUES (178, 28, 'ANTUCO');
INSERT INTO unidades_territoriales_3 VALUES (179, 28, 'SAN ROSENDO');
INSERT INTO unidades_territoriales_3 VALUES (180, 28, 'LAJA');
INSERT INTO unidades_territoriales_3 VALUES (181, 28, 'LOS ANGELES');
INSERT INTO unidades_territoriales_3 VALUES (182, 28, 'QUILLECO');
INSERT INTO unidades_territoriales_3 VALUES (183, 28, 'SANTA BÁRBARA');
INSERT INTO unidades_territoriales_3 VALUES (184, 28, 'ALTO BIOBÍO');
INSERT INTO unidades_territoriales_3 VALUES (185, 28, 'NACIMIENTO');
INSERT INTO unidades_territoriales_3 VALUES (186, 28, 'NEGRETE');
INSERT INTO unidades_territoriales_3 VALUES (187, 28, 'QUILACO');
INSERT INTO unidades_territoriales_3 VALUES (188, 28, 'MULCHÉN');
INSERT INTO unidades_territoriales_3 VALUES (189, 29, 'ARAUCO');
INSERT INTO unidades_territoriales_3 VALUES (190, 29, 'CURANILAHUE');
INSERT INTO unidades_territoriales_3 VALUES (191, 29, 'LEBU');
INSERT INTO unidades_territoriales_3 VALUES (192, 29, 'LOS ALAMOS');
INSERT INTO unidades_territoriales_3 VALUES (193, 29, 'CAÑETE');
INSERT INTO unidades_territoriales_3 VALUES (194, 29, 'CONTULMO');
INSERT INTO unidades_territoriales_3 VALUES (195, 29, 'TIRUA');
INSERT INTO unidades_territoriales_3 VALUES (196, 30, 'ANGOL');
INSERT INTO unidades_territoriales_3 VALUES (197, 30, 'RENAICO');
INSERT INTO unidades_territoriales_3 VALUES (198, 30, 'COLLIPULLI');
INSERT INTO unidades_territoriales_3 VALUES (199, 30, 'PURÉN');
INSERT INTO unidades_territoriales_3 VALUES (200, 30, 'LOS SAUCES');
INSERT INTO unidades_territoriales_3 VALUES (201, 30, 'ERCILLA');
INSERT INTO unidades_territoriales_3 VALUES (202, 30, 'LONQUIMAY');
INSERT INTO unidades_territoriales_3 VALUES (203, 30, 'LUMACO');
INSERT INTO unidades_territoriales_3 VALUES (204, 30, 'TRAIGUÉN');
INSERT INTO unidades_territoriales_3 VALUES (205, 30, 'VICTORIA');
INSERT INTO unidades_territoriales_3 VALUES (206, 30, 'CURACAUTIN');
INSERT INTO unidades_territoriales_3 VALUES (207, 31, 'GALVARINO');
INSERT INTO unidades_territoriales_3 VALUES (208, 31, 'PERQUENCO');
INSERT INTO unidades_territoriales_3 VALUES (209, 31, 'CARAHUE');
INSERT INTO unidades_territoriales_3 VALUES (210, 31, 'NUEVA IMPERIAL');
INSERT INTO unidades_territoriales_3 VALUES (211, 31, 'CHOLCHOL');
INSERT INTO unidades_territoriales_3 VALUES (212, 31, 'TEMUCO');
INSERT INTO unidades_territoriales_3 VALUES (213, 31, 'PADRE LAS CASAS');
INSERT INTO unidades_territoriales_3 VALUES (214, 31, 'LAUTARO');
INSERT INTO unidades_territoriales_3 VALUES (215, 31, 'VILCUN');
INSERT INTO unidades_territoriales_3 VALUES (216, 31, 'MELIPEUCO');
INSERT INTO unidades_territoriales_3 VALUES (217, 31, 'SAAVEDRA');
INSERT INTO unidades_territoriales_3 VALUES (218, 31, 'TEODORO SCHMIDT');
INSERT INTO unidades_territoriales_3 VALUES (219, 31, 'FREIRE');
INSERT INTO unidades_territoriales_3 VALUES (220, 31, 'CUNCO');
INSERT INTO unidades_territoriales_3 VALUES (221, 31, 'TOLTÉN');
INSERT INTO unidades_territoriales_3 VALUES (222, 31, 'PITRUFQUÉN');
INSERT INTO unidades_territoriales_3 VALUES (223, 31, 'GORBEA');
INSERT INTO unidades_territoriales_3 VALUES (224, 31, 'LONCOCHE');
INSERT INTO unidades_territoriales_3 VALUES (225, 31, 'VILLARRICA');
INSERT INTO unidades_territoriales_3 VALUES (226, 31, 'PUCÓN');
INSERT INTO unidades_territoriales_3 VALUES (227, 31, 'CURARREHUE');
INSERT INTO unidades_territoriales_3 VALUES (228, 32, 'SAN JUAN DE LA COSTA');
INSERT INTO unidades_territoriales_3 VALUES (229, 32, 'SAN PABLO');
INSERT INTO unidades_territoriales_3 VALUES (230, 32, 'OSORNO');
INSERT INTO unidades_territoriales_3 VALUES (231, 32, 'PUYEHUE');
INSERT INTO unidades_territoriales_3 VALUES (232, 32, 'RIO NEGRO');
INSERT INTO unidades_territoriales_3 VALUES (233, 32, 'PUERTO OCTAY');
INSERT INTO unidades_territoriales_3 VALUES (234, 32, 'PURRANQUE');
INSERT INTO unidades_territoriales_3 VALUES (235, 33, 'FRESIA');
INSERT INTO unidades_territoriales_3 VALUES (236, 33, 'FRUTILLAR');
INSERT INTO unidades_territoriales_3 VALUES (237, 33, 'PUERTO VARAS');
INSERT INTO unidades_territoriales_3 VALUES (238, 33, 'LLANQUIHUE');
INSERT INTO unidades_territoriales_3 VALUES (239, 33, 'LOS MUERMOS');
INSERT INTO unidades_territoriales_3 VALUES (240, 33, 'PUERTO MONTT');
INSERT INTO unidades_territoriales_3 VALUES (241, 33, 'COCHAMO');
INSERT INTO unidades_territoriales_3 VALUES (242, 33, 'MAULLIN');
INSERT INTO unidades_territoriales_3 VALUES (243, 33, 'CALBUCO');
INSERT INTO unidades_territoriales_3 VALUES (244, 34, 'ANCUD');
INSERT INTO unidades_territoriales_3 VALUES (245, 34, 'QUEMCHI');
INSERT INTO unidades_territoriales_3 VALUES (246, 34, 'DALCAHUE');
INSERT INTO unidades_territoriales_3 VALUES (247, 34, 'CASTRO');
INSERT INTO unidades_territoriales_3 VALUES (248, 34, 'CURACO DE VELEZ');
INSERT INTO unidades_territoriales_3 VALUES (249, 34, 'QUINCHAO');
INSERT INTO unidades_territoriales_3 VALUES (250, 34, 'CHONCHI');
INSERT INTO unidades_territoriales_3 VALUES (251, 34, 'PUQUELDÓN');
INSERT INTO unidades_territoriales_3 VALUES (252, 34, 'QUEILÉN');
INSERT INTO unidades_territoriales_3 VALUES (253, 34, 'QUELLÓN');
INSERT INTO unidades_territoriales_3 VALUES (254, 35, 'HUALAIHUE');
INSERT INTO unidades_territoriales_3 VALUES (255, 35, 'CHAITÉN');
INSERT INTO unidades_territoriales_3 VALUES (256, 35, 'FUTALEUFU');
INSERT INTO unidades_territoriales_3 VALUES (257, 35, 'PALENA');
INSERT INTO unidades_territoriales_3 VALUES (258, 36, 'GUAITECAS');
INSERT INTO unidades_territoriales_3 VALUES (259, 36, 'CISNES');
INSERT INTO unidades_territoriales_3 VALUES (260, 36, 'AISÉN');
INSERT INTO unidades_territoriales_3 VALUES (261, 37, 'LAGO VERDE');
INSERT INTO unidades_territoriales_3 VALUES (262, 37, 'COYHAIQUE');
INSERT INTO unidades_territoriales_3 VALUES (263, 38, 'RIO IBANEZ');
INSERT INTO unidades_territoriales_3 VALUES (264, 38, 'CHILE CHICO');
INSERT INTO unidades_territoriales_3 VALUES (265, 39, 'COCHRANE');
INSERT INTO unidades_territoriales_3 VALUES (266, 39, 'TORTEL');
INSERT INTO unidades_territoriales_3 VALUES (267, 39, 'O''HIGGINS');
INSERT INTO unidades_territoriales_3 VALUES (268, 40, 'NATALES');
INSERT INTO unidades_territoriales_3 VALUES (269, 40, 'TORRES DEL PAINE');
INSERT INTO unidades_territoriales_3 VALUES (270, 41, 'LAGUNA BLANCA');
INSERT INTO unidades_territoriales_3 VALUES (271, 41, 'SAN GREGORIO');
INSERT INTO unidades_territoriales_3 VALUES (272, 41, 'RIO VERDE');
INSERT INTO unidades_territoriales_3 VALUES (273, 41, 'PUNTA ARENAS');
INSERT INTO unidades_territoriales_3 VALUES (274, 42, 'PRIMAVERA');
INSERT INTO unidades_territoriales_3 VALUES (275, 42, 'PORVENIR');
INSERT INTO unidades_territoriales_3 VALUES (276, 42, 'TIMAUKEL');
INSERT INTO unidades_territoriales_3 VALUES (277, 43, 'CABO DE HORNOS');
INSERT INTO unidades_territoriales_3 VALUES (278, 43, 'ANTARTICA');
INSERT INTO unidades_territoriales_3 VALUES (279, 44, 'SANTIAGO');
INSERT INTO unidades_territoriales_3 VALUES (280, 44, 'CERRILLOS');
INSERT INTO unidades_territoriales_3 VALUES (281, 44, 'CERRO NAVIA');
INSERT INTO unidades_territoriales_3 VALUES (282, 44, 'CONCHALI');
INSERT INTO unidades_territoriales_3 VALUES (283, 44, 'EL BOSQUE');
INSERT INTO unidades_territoriales_3 VALUES (284, 44, 'ESTACION CENTRAL');
INSERT INTO unidades_territoriales_3 VALUES (285, 44, 'HUECHURABA');
INSERT INTO unidades_territoriales_3 VALUES (286, 44, 'INDEPENDENCIA');
INSERT INTO unidades_territoriales_3 VALUES (287, 44, 'LA CISTERNA');
INSERT INTO unidades_territoriales_3 VALUES (288, 44, 'LA FLORIDA');
INSERT INTO unidades_territoriales_3 VALUES (289, 44, 'LA GRANJA');
INSERT INTO unidades_territoriales_3 VALUES (290, 44, 'LA PINTANA');
INSERT INTO unidades_territoriales_3 VALUES (291, 44, 'LA REINA');
INSERT INTO unidades_territoriales_3 VALUES (292, 44, 'LAS CONDES');
INSERT INTO unidades_territoriales_3 VALUES (293, 44, 'LO BARNECHEA');
INSERT INTO unidades_territoriales_3 VALUES (294, 44, 'LO ESPEJO');
INSERT INTO unidades_territoriales_3 VALUES (295, 44, 'LO PRADO');
INSERT INTO unidades_territoriales_3 VALUES (296, 44, 'MACUL');
INSERT INTO unidades_territoriales_3 VALUES (297, 44, 'MAIPU');
INSERT INTO unidades_territoriales_3 VALUES (298, 44, 'ÑUÑOA');
INSERT INTO unidades_territoriales_3 VALUES (299, 44, 'PEDRO AGUIRRE CERDA');
INSERT INTO unidades_territoriales_3 VALUES (300, 44, 'PEÑALOLÉN');
INSERT INTO unidades_territoriales_3 VALUES (301, 44, 'PROVIDENCIA');
INSERT INTO unidades_territoriales_3 VALUES (302, 44, 'PUDAHUEL');
INSERT INTO unidades_territoriales_3 VALUES (303, 44, 'QUILICURA');
INSERT INTO unidades_territoriales_3 VALUES (304, 44, 'QUINTA NORMAL');
INSERT INTO unidades_territoriales_3 VALUES (305, 44, 'RECOLETA');
INSERT INTO unidades_territoriales_3 VALUES (306, 44, 'RENCA');
INSERT INTO unidades_territoriales_3 VALUES (307, 44, 'SAN JOAQUIN');
INSERT INTO unidades_territoriales_3 VALUES (308, 44, 'SAN MIGUEL');
INSERT INTO unidades_territoriales_3 VALUES (309, 44, 'SAN RAMÓN');
INSERT INTO unidades_territoriales_3 VALUES (310, 44, 'VITACURA');
INSERT INTO unidades_territoriales_3 VALUES (311, 45, 'TILTIL');
INSERT INTO unidades_territoriales_3 VALUES (312, 45, 'COLINA');
INSERT INTO unidades_territoriales_3 VALUES (313, 45, 'LAMPA');
INSERT INTO unidades_territoriales_3 VALUES (314, 46, 'CURACAVI');
INSERT INTO unidades_territoriales_3 VALUES (315, 46, 'MARIA PINTO');
INSERT INTO unidades_territoriales_3 VALUES (316, 46, 'MELIPILLA');
INSERT INTO unidades_territoriales_3 VALUES (317, 46, 'SAN PEDRO');
INSERT INTO unidades_territoriales_3 VALUES (318, 46, 'ALHUE');
INSERT INTO unidades_territoriales_3 VALUES (319, 47, 'PEÑAFLOR');
INSERT INTO unidades_territoriales_3 VALUES (320, 47, 'EL MONTE');
INSERT INTO unidades_territoriales_3 VALUES (321, 47, 'TALAGANTE');
INSERT INTO unidades_territoriales_3 VALUES (322, 47, 'ISLA DE MAIPO');
INSERT INTO unidades_territoriales_3 VALUES (323, 47, 'PADRE HURTADO');
INSERT INTO unidades_territoriales_3 VALUES (324, 48, 'CALERA DE TANGO');
INSERT INTO unidades_territoriales_3 VALUES (325, 48, 'SAN BERNARDO');
INSERT INTO unidades_territoriales_3 VALUES (326, 48, 'BUIN');
INSERT INTO unidades_territoriales_3 VALUES (327, 48, 'PAINE');
INSERT INTO unidades_territoriales_3 VALUES (328, 49, 'PUENTE ALTO');
INSERT INTO unidades_territoriales_3 VALUES (329, 49, 'PIRQUE');
INSERT INTO unidades_territoriales_3 VALUES (330, 49, 'SAN JOSE DE MAIPO');
INSERT INTO unidades_territoriales_3 VALUES (331, 50, 'MARIQUINA');
INSERT INTO unidades_territoriales_3 VALUES (332, 50, 'LANCO');
INSERT INTO unidades_territoriales_3 VALUES (333, 50, 'PANGUIPULLI');
INSERT INTO unidades_territoriales_3 VALUES (334, 50, 'MAFIL');
INSERT INTO unidades_territoriales_3 VALUES (335, 50, 'VALDIVIA');
INSERT INTO unidades_territoriales_3 VALUES (336, 50, 'LOS LAGOS');
INSERT INTO unidades_territoriales_3 VALUES (337, 50, 'CORRAL');
INSERT INTO unidades_territoriales_3 VALUES (338, 50, 'PAILLACO');
INSERT INTO unidades_territoriales_3 VALUES (339, 51, 'FUTRONO');
INSERT INTO unidades_territoriales_3 VALUES (340, 51, 'LA UNIÓN');
INSERT INTO unidades_territoriales_3 VALUES (341, 51, 'LAGO RANCO');
INSERT INTO unidades_territoriales_3 VALUES (342, 51, 'RIO BUENO');
INSERT INTO unidades_territoriales_3 VALUES (343, 52, 'GENERAL LAGOS');
INSERT INTO unidades_territoriales_3 VALUES (344, 52, 'PUTRE');
INSERT INTO unidades_territoriales_3 VALUES (345, 53, 'ARICA');
INSERT INTO unidades_territoriales_3 VALUES (346, 53, 'CAMARONES');
INSERT INTO unidades_territoriales_3 VALUES (347, 54, 'COBQUECURA');
INSERT INTO unidades_territoriales_3 VALUES (348, 54, 'COELEMU');
INSERT INTO unidades_territoriales_3 VALUES (349, 54, 'NINHUE');
INSERT INTO unidades_territoriales_3 VALUES (350, 54, 'PORTEZUELO');
INSERT INTO unidades_territoriales_3 VALUES (351, 54, 'QUIRIHUE');
INSERT INTO unidades_territoriales_3 VALUES (352, 54, 'RANQUIL');
INSERT INTO unidades_territoriales_3 VALUES (353, 54, 'TREGUACO');
INSERT INTO unidades_territoriales_3 VALUES (354, 55, 'BULNES');
INSERT INTO unidades_territoriales_3 VALUES (355, 55, 'CHILLAN VIEJO');
INSERT INTO unidades_territoriales_3 VALUES (356, 55, 'CHILLAN');
INSERT INTO unidades_territoriales_3 VALUES (357, 55, 'EL CARMEN');
INSERT INTO unidades_territoriales_3 VALUES (358, 55, 'PEMUCO');
INSERT INTO unidades_territoriales_3 VALUES (359, 55, 'PINTO');
INSERT INTO unidades_territoriales_3 VALUES (360, 55, 'QUILLÓN');
INSERT INTO unidades_territoriales_3 VALUES (361, 55, 'SAN IGNACIO');
INSERT INTO unidades_territoriales_3 VALUES (362, 55, 'YUNGAY');
INSERT INTO unidades_territoriales_3 VALUES (363, 56, 'COIHUECO');
INSERT INTO unidades_territoriales_3 VALUES (364, 56, 'ÑIQUÉN');
INSERT INTO unidades_territoriales_3 VALUES (365, 56, 'SAN CARLOS');
INSERT INTO unidades_territoriales_3 VALUES (366, 56, 'SAN FABIAN');
INSERT INTO unidades_territoriales_3 VALUES (367, 56, 'SAN NICOLAS');


--
-- Name: unmp_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('unmp_seq', 10, false);


--
-- Name: unms_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('unms_seq', 2, false);


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

SELECT pg_catalog.setval('uspe_seq', 1062, false);


--
-- Name: usua_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('usua_seq', 14, false);


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO usuarios VALUES (1, 'ADMIN', '12345', 1, 1, 1, '2018-02-18 00:37:42.028709', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (2, 'ROSILVA', '12345', 2, 1, 1, '2018-02-18 00:37:42.263371', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (3, 'SEAGUIRRE', '12345', 3, 1, 1, '2018-02-18 00:37:42.271702', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (4, 'JJMONSALVE', '12345', 4, 1, 1, '2018-02-18 00:37:42.280035', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (5, 'JABORZONE', '12345', 5, 1, 1, '2018-02-18 00:37:42.288308', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (6, 'ROCIFUENTES', '12345', 6, 1, 1, '2018-02-18 00:37:42.296699', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (7, 'RQUEZADAA', '12345', 7, 2, 1, '2018-02-18 00:37:42.305032', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (8, 'OSOLARM', '12345', 8, 1, 1, '2018-02-18 00:37:42.31333', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (9, 'NSALAZARG', '12345', 9, 1, 1, '2018-02-18 00:37:42.321697', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (10, 'CPALMAA', '12345', 10, 1, 1, '2018-02-18 00:37:42.371706', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (11, 'JCISTERNAF', '12345', 11, 1, 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (12, 'UAT', '12345', 12, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO usuarios VALUES (13, 'ULEGALES', '12345', 13, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);


--
-- Data for Name: usuarios_perfiles; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO usuarios_perfiles VALUES (1, 1, 1, NULL, NULL, 1, 1, '2018-02-18 00:37:51.292507', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (2, 2, 1, NULL, NULL, 1, 1, '2018-02-18 00:37:51.300919', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (3, 3, 1, NULL, NULL, 1, 1, '2018-02-18 00:37:51.350914', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (4, 4, 1, NULL, NULL, 1, 1, '2018-02-18 00:37:51.359239', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (5, 5, 1, NULL, NULL, 1, 1, '2018-02-18 00:37:51.367537', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (6, 6, 1, NULL, NULL, 1, 1, '2018-02-18 00:37:51.375921', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (7, 7, 1, NULL, NULL, 1, 1, '2018-02-18 00:37:51.3843', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (111, 11, 8, NULL, 2, 1, 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (12, 11, 12, NULL, 3, 1, 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (13, 11, 15, NULL, 4, 1, 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (14, 11, 17, NULL, 5, 1, 1, '2018-02-18 00:37:56.09919', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (515, 12, 272, NULL, 1, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (516, 2, 272, NULL, 1, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (517, 3, 272, NULL, 1, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (518, 4, 272, NULL, 1, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (519, 5, 272, NULL, 1, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (520, 6, 272, NULL, 1, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (521, 7, 272, NULL, 1, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1025, 13, 2023, NULL, 1, 1, 1, '2018-02-18 00:37:56.252656', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1026, 8, 1, NULL, NULL, 1, 1, '2018-02-18 00:37:56.294857', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1027, 8, 2, 3, NULL, 1, 1, '2018-02-18 00:37:56.303176', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1028, 8, 4, NULL, 7, 1, 1, '2018-02-18 00:37:56.311542', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1029, 8, 4, NULL, 9, 1, 1, '2018-02-18 00:37:56.319851', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1030, 8, 4, NULL, 10, 1, 1, '2018-02-18 00:37:56.328174', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1031, 8, 12, NULL, 6, 1, 1, '2018-02-18 00:37:56.336512', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1032, 8, 12, NULL, 7, 1, 1, '2018-02-18 00:37:56.344854', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1033, 8, 12, NULL, 10, 1, 1, '2018-02-18 00:37:56.394867', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1034, 8, 19, NULL, 6, 1, 1, '2018-02-18 00:37:56.403188', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1035, 8, 19, NULL, 8, 1, 1, '2018-02-18 00:37:56.41155', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1036, 8, 19, NULL, 9, 1, 1, '2018-02-18 00:37:56.419857', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1037, 8, 19, NULL, 10, 1, 1, '2018-02-18 00:37:56.428252', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1038, 9, 1, NULL, NULL, 1, 1, '2018-02-18 00:37:56.436497', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1039, 9, 2, 3, NULL, 1, 1, '2018-02-18 00:37:56.444919', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1040, 9, 4, NULL, 7, 1, 1, '2018-02-18 00:37:56.453252', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1041, 9, 4, NULL, 9, 1, 1, '2018-02-18 00:37:56.461558', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1042, 9, 4, NULL, 10, 1, 1, '2018-02-18 00:37:56.469919', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1043, 9, 12, NULL, 6, 1, 1, '2018-02-18 00:37:56.478252', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1044, 9, 12, NULL, 7, 1, 1, '2018-02-18 00:37:56.528237', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1045, 9, 12, NULL, 10, 1, 1, '2018-02-18 00:37:56.536494', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1046, 9, 19, NULL, 6, 1, 1, '2018-02-18 00:37:56.544914', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1047, 9, 19, NULL, 8, 1, 1, '2018-02-18 00:37:56.553251', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1048, 9, 19, NULL, 9, 1, 1, '2018-02-18 00:37:56.561646', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1049, 9, 19, NULL, 10, 1, 1, '2018-02-18 00:37:56.569981', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1050, 10, 1, NULL, NULL, 1, 1, '2018-02-18 00:37:56.57829', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1051, 10, 2, 3, NULL, 1, 1, '2018-02-18 00:37:56.586551', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1052, 10, 4, NULL, 7, 1, 1, '2018-02-18 00:37:56.595021', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1053, 10, 4, NULL, 9, 1, 1, '2018-02-18 00:37:56.603288', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1054, 10, 4, NULL, 10, 1, 1, '2018-02-18 00:37:56.611643', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1055, 10, 12, NULL, 6, 1, 1, '2018-02-18 00:37:56.661646', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1056, 10, 12, NULL, 7, 1, 1, '2018-02-18 00:37:56.669977', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1057, 10, 12, NULL, 10, 1, 1, '2018-02-18 00:37:56.678287', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1058, 10, 19, NULL, 6, 1, 1, '2018-02-18 00:37:56.686548', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1059, 10, 19, NULL, 8, 1, 1, '2018-02-18 00:37:56.695035', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1060, 10, 19, NULL, 9, 1, 1, '2018-02-18 00:37:56.703354', NULL, NULL, NULL, NULL);
INSERT INTO usuarios_perfiles VALUES (1061, 10, 19, NULL, 10, 1, 1, '2018-02-18 00:37:56.711699', NULL, NULL, NULL, NULL);


--
-- Name: vado_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('vado_seq', 1, false);


--
-- Data for Name: valores_dominios; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: valores_paises; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO valores_paises VALUES (1, 1, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUT', 1, '2018-02-18 00:37:42.388373', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (2, 1, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2018-02-18 00:37:42.39676', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (3, 1, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUT', 1, '2018-02-18 00:37:42.405079', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (4, 1, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2018-02-18 00:37:42.413391', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (5, 1, 'RETHON', 'RETENCIÓN HONORARIOS', '% RETENCIÓN DE HONORARIOS EN ESTE PAIS', '10', 1, '2018-02-18 00:37:42.421718', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (6, 1, 'NUMUNIT', 'NRO. UNIDADES TERRITORIALES', 'NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS', '3', 1, '2018-02-18 00:37:42.430053', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (7, 1, 'UNITER1', 'UNIDAD TERRITORIAL ORDEN 1', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 1', 'REGIÓN', 1, '2018-02-18 00:37:42.438482', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (8, 1, 'UNITER2', 'UNIDAD TERRITORIAL ORDEN 2', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 2', 'PROVINCIA', 1, '2018-02-18 00:37:42.44672', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (9, 1, 'UNITER3', 'UNIDAD TERRITORIAL ORDEN 3', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 3', 'COMUNA', 1, '2018-02-18 00:37:42.455054', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (10, 2, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'DNI', 1, '2018-02-18 00:37:42.505055', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (11, 2, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2018-02-18 00:37:42.513443', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (12, 2, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUT', 1, '2018-02-18 00:37:42.521715', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (13, 2, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2018-02-18 00:37:42.530087', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (14, 2, 'RETHON', 'RETENCIÓN HONORARIOS', '% RETENCIÓN DE HONORARIOS EN ESTE PAIS', '10', 1, '2018-02-18 00:37:42.538413', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (15, 2, 'NUMUNIT', 'NRO. UNIDADES TERRITORIALES', 'NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS', '3', 1, '2018-02-18 00:37:42.546715', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (16, 2, 'UNITER1', 'UNIDAD TERRITORIAL ORDEN 1', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 1', 'REGIÓN', 1, '2018-02-18 00:37:42.555114', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (17, 2, 'UNITER2', 'UNIDAD TERRITORIAL ORDEN 2', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 2', 'PROVINCIA', 1, '2018-02-18 00:37:42.563473', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (18, 2, 'UNITER3', 'UNIDAD TERRITORIAL ORDEN 3', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 3', 'COMUNA', 1, '2018-02-18 00:37:42.571792', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (19, 3, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2018-02-18 00:37:42.580112', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (20, 3, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2018-02-18 00:37:42.588431', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (21, 3, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2018-02-18 00:37:42.638449', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (22, 3, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2018-02-18 00:37:42.646774', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (23, 3, 'RETHON', 'RETENCIÓN HONORARIOS', '% RETENCIÓN DE HONORARIOS EN ESTE PAIS', '10', 1, '2018-02-18 00:37:42.655108', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (24, 3, 'NUMUNIT', 'NRO. UNIDADES TERRITORIALES', 'NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS', '3', 1, '2018-02-18 00:37:42.663438', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (25, 3, 'UNITER1', 'UNIDAD TERRITORIAL ORDEN 1', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 1', 'REGIÓN', 1, '2018-02-18 00:37:42.671775', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (26, 3, 'UNITER2', 'UNIDAD TERRITORIAL ORDEN 2', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 2', 'PROVINCIA', 1, '2018-02-18 00:37:42.680101', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (27, 3, 'UNITER3', 'UNIDAD TERRITORIAL ORDEN 3', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 3', 'COMUNA', 1, '2018-02-18 00:37:42.688424', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (28, 4, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2018-02-18 00:37:42.696773', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (29, 4, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2018-02-18 00:37:42.70509', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (30, 4, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2018-02-18 00:37:42.713434', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (31, 4, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2018-02-18 00:37:42.721834', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (32, 4, 'RETHON', 'RETENCIÓN HONORARIOS', '% RETENCIÓN DE HONORARIOS EN ESTE PAIS', '10', 1, '2018-02-18 00:37:42.771836', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (33, 4, 'NUMUNIT', 'NRO. UNIDADES TERRITORIALES', 'NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS', '3', 1, '2018-02-18 00:37:42.780164', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (34, 4, 'UNITER1', 'UNIDAD TERRITORIAL ORDEN 1', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 1', 'REGIÓN', 1, '2018-02-18 00:37:42.788454', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (35, 4, 'UNITER2', 'UNIDAD TERRITORIAL ORDEN 2', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 2', 'PROVINCIA', 1, '2018-02-18 00:37:42.796826', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (36, 4, 'UNITER3', 'UNIDAD TERRITORIAL ORDEN 3', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 3', 'COMUNA', 1, '2018-02-18 00:37:42.805157', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (37, 5, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2018-02-18 00:37:42.813511', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (38, 5, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2018-02-18 00:37:42.82183', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (39, 5, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2018-02-18 00:37:42.830158', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (40, 5, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2018-02-18 00:37:42.838454', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (41, 5, 'RETHON', 'RETENCIÓN HONORARIOS', '% RETENCIÓN DE HONORARIOS EN ESTE PAIS', '10', 1, '2018-02-18 00:37:42.846824', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (42, 5, 'NUMUNIT', 'NRO. UNIDADES TERRITORIALES', 'NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS', '3', 1, '2018-02-18 00:37:42.855158', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (43, 5, 'UNITER1', 'UNIDAD TERRITORIAL ORDEN 1', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 1', 'REGIÓN', 1, '2018-02-18 00:37:42.905166', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (44, 5, 'UNITER2', 'UNIDAD TERRITORIAL ORDEN 2', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 2', 'PROVINCIA', 1, '2018-02-18 00:37:42.913444', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (45, 5, 'UNITER3', 'UNIDAD TERRITORIAL ORDEN 3', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 3', 'COMUNA', 1, '2018-02-18 00:37:42.921933', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (46, 6, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2018-02-18 00:37:42.930214', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (47, 6, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2018-02-18 00:37:42.938582', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (48, 6, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2018-02-18 00:37:42.946925', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (49, 6, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2018-02-18 00:37:42.955218', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (50, 6, 'RETHON', 'RETENCIÓN HONORARIOS', '% RETENCIÓN DE HONORARIOS EN ESTE PAIS', '10', 1, '2018-02-18 00:37:42.963504', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (51, 6, 'NUMUNIT', 'NRO. UNIDADES TERRITORIALES', 'NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS', '3', 1, '2018-02-18 00:37:42.971927', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (52, 6, 'UNITER1', 'UNIDAD TERRITORIAL ORDEN 1', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 1', 'REGIÓN', 1, '2018-02-18 00:37:42.980255', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (53, 6, 'UNITER2', 'UNIDAD TERRITORIAL ORDEN 2', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 2', 'PROVINCIA', 1, '2018-02-18 00:37:42.988556', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (54, 6, 'UNITER3', 'UNIDAD TERRITORIAL ORDEN 3', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 3', 'COMUNA', 1, '2018-02-18 00:37:43.046915', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (55, 7, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2018-02-18 00:37:43.055244', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (56, 7, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2018-02-18 00:37:43.063619', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (57, 7, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2018-02-18 00:37:43.07192', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (58, 7, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2018-02-18 00:37:43.080238', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (59, 7, 'RETHON', 'RETENCIÓN HONORARIOS', '% RETENCIÓN DE HONORARIOS EN ESTE PAIS', '10', 1, '2018-02-18 00:37:43.088579', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (60, 7, 'NUMUNIT', 'NRO. UNIDADES TERRITORIALES', 'NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS', '3', 1, '2018-02-18 00:37:43.096983', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (61, 7, 'UNITER1', 'UNIDAD TERRITORIAL ORDEN 1', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 1', 'REGIÓN', 1, '2018-02-18 00:37:43.105305', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (62, 7, 'UNITER2', 'UNIDAD TERRITORIAL ORDEN 2', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 2', 'PROVINCIA', 1, '2018-02-18 00:37:43.113653', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (63, 7, 'UNITER3', 'UNIDAD TERRITORIAL ORDEN 3', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 3', 'COMUNA', 1, '2018-02-18 00:37:43.121969', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (64, 8, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2018-02-18 00:37:43.130303', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (65, 8, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2018-02-18 00:37:43.180311', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (66, 8, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2018-02-18 00:37:43.188633', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (67, 8, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2018-02-18 00:37:43.196978', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (68, 8, 'RETHON', 'RETENCIÓN HONORARIOS', '% RETENCIÓN DE HONORARIOS EN ESTE PAIS', '10', 1, '2018-02-18 00:37:43.2053', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (69, 8, 'NUMUNIT', 'NRO. UNIDADES TERRITORIALES', 'NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS', '3', 1, '2018-02-18 00:37:43.213646', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (70, 8, 'UNITER1', 'UNIDAD TERRITORIAL ORDEN 1', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 1', 'REGIÓN', 1, '2018-02-18 00:37:43.221981', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (71, 8, 'UNITER2', 'UNIDAD TERRITORIAL ORDEN 2', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 2', 'PROVINCIA', 1, '2018-02-18 00:37:43.230302', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (72, 8, 'UNITER3', 'UNIDAD TERRITORIAL ORDEN 3', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 3', 'COMUNA', 1, '2018-02-18 00:37:43.238648', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (73, 9, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2018-02-18 00:37:43.246974', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (74, 9, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2018-02-18 00:37:43.255395', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (75, 9, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2018-02-18 00:37:43.263717', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (76, 9, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2018-02-18 00:37:43.313721', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (77, 9, 'RETHON', 'RETENCIÓN HONORARIOS', '% RETENCIÓN DE HONORARIOS EN ESTE PAIS', '10', 1, '2018-02-18 00:37:43.322048', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (78, 9, 'NUMUNIT', 'NRO. UNIDADES TERRITORIALES', 'NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS', '3', 1, '2018-02-18 00:37:43.33038', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (79, 9, 'UNITER1', 'UNIDAD TERRITORIAL ORDEN 1', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 1', 'REGIÓN', 1, '2018-02-18 00:37:43.338705', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (80, 9, 'UNITER2', 'UNIDAD TERRITORIAL ORDEN 2', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 2', 'PROVINCIA', 1, '2018-02-18 00:37:43.347041', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (81, 9, 'UNITER3', 'UNIDAD TERRITORIAL ORDEN 3', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 3', 'COMUNA', 1, '2018-02-18 00:37:43.355393', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (82, 10, 'IDENTP1', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 1 TABLA PERSONAS', 'RUC', 1, '2018-02-18 00:37:43.363702', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (83, 10, 'IDENTP2', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'ETIQUETA IDENTIFICADOR 2 TABLA PERSONAS', 'DV', 1, '2018-02-18 00:37:43.372041', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (84, 10, 'IDENTE1', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 1 TABLA EMPRESAS', 'RUC', 1, '2018-02-18 00:37:43.380379', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (85, 10, 'IDENTE2', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'ETIQUETA IDENTIFICADOR 2 TABLA EMPRESAS', 'DV', 1, '2018-02-18 00:37:43.388707', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (86, 10, 'RETHON', 'RETENCIÓN HONORARIOS', '% RETENCIÓN DE HONORARIOS EN ESTE PAIS', '10', 1, '2018-02-18 00:37:43.397044', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (87, 10, 'NUMUNIT', 'NRO. UNIDADES TERRITORIALES', 'NRO. DE UNIDADES TERRITORIALES EN QUE SE DIVIDE EL PAIS', '3', 1, '2018-02-18 00:37:43.447047', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (88, 10, 'UNITER1', 'UNIDAD TERRITORIAL ORDEN 1', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 1', 'REGIÓN', 1, '2018-02-18 00:37:43.455399', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (89, 10, 'UNITER2', 'UNIDAD TERRITORIAL ORDEN 2', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 2', 'PROVINCIA', 1, '2018-02-18 00:37:43.46376', NULL, NULL, NULL, NULL);
INSERT INTO valores_paises VALUES (90, 10, 'UNITER3', 'UNIDAD TERRITORIAL ORDEN 3', 'NOMBRE UNIDAD TERRITORIAL DE ORDEN 3', 'COMUNA', 1, '2018-02-18 00:37:43.472083', NULL, NULL, NULL, NULL);


--
-- Name: vapa_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('vapa_seq', 91, false);


--
-- Name: vent_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('vent_seq', 2, false);


--
-- Data for Name: ventas; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO ventas VALUES (1, 1, 1, 1, 1, 1, 'PRUEBA', '2018-02-18 00:37:56.811766', NULL, NULL, NULL, NULL, NULL, 0, 3000, 570, 0.00000, 0, 3570, 1, 1, '2018-02-18 00:37:56.811766', NULL, NULL, NULL, NULL);


--
-- Name: bicp_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY bitacoras_cambios_precios
    ADD CONSTRAINT bicp_pk PRIMARY KEY (id);


--
-- Name: bode_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY bodegas
    ADD CONSTRAINT bode_pk PRIMARY KEY (id);


--
-- Name: bode_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY bodegas
    ADD CONSTRAINT bode_uk_01 UNIQUE (idempr, nombre);


--
-- Name: bopr_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY bodegas_productos
    ADD CONSTRAINT bopr_pk PRIMARY KEY (id);


--
-- Name: bopr_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY bodegas_productos
    ADD CONSTRAINT bopr_uk_01 UNIQUE (idbode, idprod);


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
    ADD CONSTRAINT dedv_uk_01 UNIQUE (idvent, correlativo);


--
-- Name: dedv_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY detalles_doctos_vtas
    ADD CONSTRAINT dedv_uk_02 UNIQUE (idvent, idprod, idserv);


--
-- Name: delp_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY detalles_listas_precios
    ADD CONSTRAINT delp_pk PRIMARY KEY (id);


--
-- Name: delp_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY detalles_listas_precios
    ADD CONSTRAINT delp_uk_01 UNIQUE (idlipr, idprod);


--
-- Name: demb_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY detalles_movtos_bodegas
    ADD CONSTRAINT demb_pk PRIMARY KEY (id);


--
-- Name: demb_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY detalles_movtos_bodegas
    ADD CONSTRAINT demb_uk_01 UNIQUE (idmobo, correlativo);


--
-- Name: demb_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY detalles_movtos_bodegas
    ADD CONSTRAINT demb_uk_02 UNIQUE (idmobo, idprod);


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
-- Name: desu_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY descuentos
    ADD CONSTRAINT desu_pk PRIMARY KEY (id);


--
-- Name: desu_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY descuentos
    ADD CONSTRAINT desu_uk_01 UNIQUE (idfapr, idsfpr, idprod);


--
-- Name: deve_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY detalles_ventas
    ADD CONSTRAINT deve_pk PRIMARY KEY (id);


--
-- Name: deve_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY detalles_ventas
    ADD CONSTRAINT deve_uk_01 UNIQUE (idvent, correlativo);


--
-- Name: deve_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY detalles_ventas
    ADD CONSTRAINT deve_uk_02 UNIQUE (idvent, idprod, idserv);


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
-- Name: fapr_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY familias_productos
    ADD CONSTRAINT fapr_pk PRIMARY KEY (id);


--
-- Name: fapr_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY familias_productos
    ADD CONSTRAINT fapr_uk_01 UNIQUE (idempr, cod_familia);


--
-- Name: fapr_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY familias_productos
    ADD CONSTRAINT fapr_uk_02 UNIQUE (idempr, descripcion);


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
-- Name: fpnv_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY formas_pagos_notas_ventas
    ADD CONSTRAINT fpnv_pk PRIMARY KEY (id);


--
-- Name: fpnv_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY formas_pagos_notas_ventas
    ADD CONSTRAINT fpnv_uk_01 UNIQUE (idnove, idtifp);


--
-- Name: fpve_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY formas_pagos_ventas
    ADD CONSTRAINT fpve_pk PRIMARY KEY (id);


--
-- Name: fpve_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY formas_pagos_ventas
    ADD CONSTRAINT fpve_uk_01 UNIQUE (idvent, idtifp);


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
-- Name: lipr_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY listas_precios
    ADD CONSTRAINT lipr_pk PRIMARY KEY (id);


--
-- Name: lipr_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY listas_precios
    ADD CONSTRAINT lipr_uk_01 UNIQUE (idempr, correlativo);


--
-- Name: mobo_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY movimientos_bodegas
    ADD CONSTRAINT mobo_pk PRIMARY KEY (id);


--
-- Name: mobo_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY movimientos_bodegas
    ADD CONSTRAINT mobo_uk_01 UNIQUE (idbode, correlativo);


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
-- Name: prod_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT prod_uk_02 UNIQUE (idempr, idsfpr, correlativoflia);


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
-- Name: sfpr_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY sub_familias_productos
    ADD CONSTRAINT sfpr_pk PRIMARY KEY (id);


--
-- Name: sfpr_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY sub_familias_productos
    ADD CONSTRAINT sfpr_uk_01 UNIQUE (idfapr, cod_sub_familia);


--
-- Name: sfpr_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY sub_familias_productos
    ADD CONSTRAINT sfpr_uk_02 UNIQUE (idfapr, descripcion);


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
-- Name: timb_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY tipos_movimientos_bodegas
    ADD CONSTRAINT timb_pk PRIMARY KEY (id);


--
-- Name: timb_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY tipos_movimientos_bodegas
    ADD CONSTRAINT timb_uk_01 UNIQUE (descripcion);


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
-- Name: vent_pk; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_pk PRIMARY KEY (id);


--
-- Name: vent_uk_01; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_uk_01 UNIQUE (idempr, idtidv, numero);


--
-- Name: vent_uk_02; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace:
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_uk_02 UNIQUE (idempr, idnove, idtidv);


--
-- Name: lipr_idx_01; Type: INDEX; Schema: public; Owner: admin; Tablespace:
--

CREATE UNIQUE INDEX lipr_idx_01 ON listas_precios USING btree (idempr, idesre) WHERE (idesre = (1)::numeric);


--
-- Name: p_idx; Type: INDEX; Schema: public; Owner: admin; Tablespace:
--

CREATE UNIQUE INDEX p_idx ON prueba USING btree (a, b) WHERE (b = (1)::numeric);


--
-- Name: trg_after_ins_empr; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_after_ins_empr AFTER INSERT ON empresas FOR EACH ROW EXECUTE PROCEDURE f_crear_datos_empresa();


--
-- Name: trg_after_ins_grem; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_after_ins_grem AFTER INSERT ON grupos_empresariales FOR EACH ROW EXECUTE PROCEDURE f_crear_datos_holding();


--
-- Name: trg_after_upd_cove; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_after_upd_cove AFTER UPDATE ON cotizaciones_ventas FOR EACH ROW EXECUTE PROCEDURE f_copiar_cove_a_nove();


--
-- Name: trg_after_upd_nove; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_after_upd_nove AFTER UPDATE ON notas_ventas FOR EACH ROW EXECUTE PROCEDURE f_copiar_nove_a_vent();


--
-- Name: trg_before_ins_cove; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_ins_cove BEFORE INSERT ON cotizaciones_ventas FOR EACH ROW EXECUTE PROCEDURE f_validar_cove_ins();


--
-- Name: trg_before_ins_dove; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_ins_dove BEFORE INSERT ON documentos_ventas FOR EACH ROW EXECUTE PROCEDURE f_validar_dove_ins();


--
-- Name: trg_before_ins_empr; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_ins_empr BEFORE INSERT ON empresas FOR EACH ROW EXECUTE PROCEDURE f_completar_rubro_empresa();


--
-- Name: trg_before_ins_nove; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_ins_nove BEFORE INSERT ON notas_ventas FOR EACH ROW EXECUTE PROCEDURE f_validar_nove_ins();


--
-- Name: trg_before_ins_upd_pers; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_ins_upd_pers BEFORE INSERT OR UPDATE ON personas FOR EACH ROW EXECUTE PROCEDURE f_validar_dv_pers();


--
-- Name: trg_before_ins_vent; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_ins_vent BEFORE INSERT ON ventas FOR EACH ROW EXECUTE PROCEDURE f_validar_vent_ins();


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
-- Name: trg_before_upd_vent; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_before_upd_vent BEFORE UPDATE ON ventas FOR EACH ROW EXECUTE PROCEDURE f_validar_vent();


--
-- Name: bicp_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY bitacoras_cambios_precios
    ADD CONSTRAINT bicp_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: bicp_fk_prod; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY bitacoras_cambios_precios
    ADD CONSTRAINT bicp_fk_prod FOREIGN KEY (idprod) REFERENCES productos(id);


--
-- Name: bode_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY bodegas
    ADD CONSTRAINT bode_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: bode_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY bodegas
    ADD CONSTRAINT bode_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: bode_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY bodegas
    ADD CONSTRAINT bode_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: bode_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY bodegas
    ADD CONSTRAINT bode_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: bopr_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY bodegas_productos
    ADD CONSTRAINT bopr_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: bopr_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY bodegas_productos
    ADD CONSTRAINT bopr_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: bopr_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY bodegas_productos
    ADD CONSTRAINT bopr_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: bopr_fk_bode; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY bodegas_productos
    ADD CONSTRAINT bopr_fk_bode FOREIGN KEY (idbode) REFERENCES bodegas(id);


--
-- Name: bopr_fk_prod; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY bodegas_productos
    ADD CONSTRAINT bopr_fk_prod FOREIGN KEY (idprod) REFERENCES productos(id);


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
-- Name: delp_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_listas_precios
    ADD CONSTRAINT delp_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: delp_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_listas_precios
    ADD CONSTRAINT delp_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: delp_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_listas_precios
    ADD CONSTRAINT delp_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: delp_fk_lipr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_listas_precios
    ADD CONSTRAINT delp_fk_lipr FOREIGN KEY (idlipr) REFERENCES listas_precios(id);


--
-- Name: delp_fk_prod; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_listas_precios
    ADD CONSTRAINT delp_fk_prod FOREIGN KEY (idprod) REFERENCES productos(id);


--
-- Name: demb_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_movtos_bodegas
    ADD CONSTRAINT demb_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: demb_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_movtos_bodegas
    ADD CONSTRAINT demb_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: demb_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_movtos_bodegas
    ADD CONSTRAINT demb_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: demb_fk_mobo; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_movtos_bodegas
    ADD CONSTRAINT demb_fk_mobo FOREIGN KEY (idmobo) REFERENCES movimientos_bodegas(id);


--
-- Name: demb_fk_prod; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_movtos_bodegas
    ADD CONSTRAINT demb_fk_prod FOREIGN KEY (idprod) REFERENCES productos(id);


--
-- Name: demb_fk_unmp; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_movtos_bodegas
    ADD CONSTRAINT demb_fk_unmp FOREIGN KEY (idunmp) REFERENCES unidades_medidas_productos(id);


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
-- Name: desu_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY descuentos
    ADD CONSTRAINT desu_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: desu_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY descuentos
    ADD CONSTRAINT desu_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: desu_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY descuentos
    ADD CONSTRAINT desu_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: desu_fk_esre; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY descuentos
    ADD CONSTRAINT desu_fk_esre FOREIGN KEY (idesre) REFERENCES estados_registros(id);


--
-- Name: desu_fk_fapr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY descuentos
    ADD CONSTRAINT desu_fk_fapr FOREIGN KEY (idfapr) REFERENCES familias_productos(id);


--
-- Name: desu_fk_prod; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY descuentos
    ADD CONSTRAINT desu_fk_prod FOREIGN KEY (idprod) REFERENCES productos(id);


--
-- Name: desu_fk_sfpr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY descuentos
    ADD CONSTRAINT desu_fk_sfpr FOREIGN KEY (idsfpr) REFERENCES sub_familias_productos(id);


--
-- Name: deve_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_ventas
    ADD CONSTRAINT deve_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: deve_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_ventas
    ADD CONSTRAINT deve_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: deve_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_ventas
    ADD CONSTRAINT deve_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: deve_fk_prod; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_ventas
    ADD CONSTRAINT deve_fk_prod FOREIGN KEY (idprod) REFERENCES productos(id);


--
-- Name: deve_fk_serv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_ventas
    ADD CONSTRAINT deve_fk_serv FOREIGN KEY (idserv) REFERENCES servicios(id);


--
-- Name: deve_fk_vent; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY detalles_ventas
    ADD CONSTRAINT deve_fk_vent FOREIGN KEY (idvent) REFERENCES ventas(id);


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
-- Name: fapr_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY familias_productos
    ADD CONSTRAINT fapr_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: fapr_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY familias_productos
    ADD CONSTRAINT fapr_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: fapr_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY familias_productos
    ADD CONSTRAINT fapr_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: fapr_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY familias_productos
    ADD CONSTRAINT fapr_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: fide_fk_fode; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY field_defs
    ADD CONSTRAINT fide_fk_fode FOREIGN KEY (form_id) REFERENCES form_defs(id);


--
-- Name: fpnv_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY formas_pagos_notas_ventas
    ADD CONSTRAINT fpnv_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: fpnv_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY formas_pagos_notas_ventas
    ADD CONSTRAINT fpnv_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: fpnv_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY formas_pagos_notas_ventas
    ADD CONSTRAINT fpnv_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: fpnv_fk_nove; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY formas_pagos_notas_ventas
    ADD CONSTRAINT fpnv_fk_nove FOREIGN KEY (idnove) REFERENCES notas_ventas(id);


--
-- Name: fpnv_fk_tifp; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY formas_pagos_notas_ventas
    ADD CONSTRAINT fpnv_fk_tifp FOREIGN KEY (idtifp) REFERENCES tipos_formas_pagos(id);


--
-- Name: fpve_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY formas_pagos_ventas
    ADD CONSTRAINT fpve_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: fpve_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY formas_pagos_ventas
    ADD CONSTRAINT fpve_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: fpve_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY formas_pagos_ventas
    ADD CONSTRAINT fpve_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: fpve_fk_tifp; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY formas_pagos_ventas
    ADD CONSTRAINT fpve_fk_tifp FOREIGN KEY (idtifp) REFERENCES tipos_formas_pagos(id);


--
-- Name: fpve_fk_vent; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY formas_pagos_ventas
    ADD CONSTRAINT fpve_fk_vent FOREIGN KEY (idvent) REFERENCES ventas(id);


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
-- Name: lipr_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY listas_precios
    ADD CONSTRAINT lipr_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: lipr_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY listas_precios
    ADD CONSTRAINT lipr_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: lipr_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY listas_precios
    ADD CONSTRAINT lipr_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: lipr_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY listas_precios
    ADD CONSTRAINT lipr_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: lipr_fk_esre; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY listas_precios
    ADD CONSTRAINT lipr_fk_esre FOREIGN KEY (idesre) REFERENCES estados_registros(id);


--
-- Name: mobo_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY movimientos_bodegas
    ADD CONSTRAINT mobo_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: mobo_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY movimientos_bodegas
    ADD CONSTRAINT mobo_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: mobo_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY movimientos_bodegas
    ADD CONSTRAINT mobo_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: mobo_fk_bode; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY movimientos_bodegas
    ADD CONSTRAINT mobo_fk_bode FOREIGN KEY (idbode) REFERENCES bodegas(id);


--
-- Name: mobo_fk_timb; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY movimientos_bodegas
    ADD CONSTRAINT mobo_fk_timb FOREIGN KEY (idtimb) REFERENCES tipos_movimientos_bodegas(id);


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
-- Name: prod_fk_esre; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT prod_fk_esre FOREIGN KEY (idesre) REFERENCES estados_registros(id);


--
-- Name: prod_fk_orpr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT prod_fk_orpr FOREIGN KEY (idorpr) REFERENCES origenes_productos(id);


--
-- Name: prod_fk_sfpr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT prod_fk_sfpr FOREIGN KEY (idsfpr) REFERENCES sub_familias_productos(id);


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
-- Name: sfpr_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY sub_familias_productos
    ADD CONSTRAINT sfpr_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: sfpr_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY sub_familias_productos
    ADD CONSTRAINT sfpr_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: sfpr_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY sub_familias_productos
    ADD CONSTRAINT sfpr_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: sfpr_fk_fapr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY sub_familias_productos
    ADD CONSTRAINT sfpr_fk_fapr FOREIGN KEY (idfapr) REFERENCES familias_productos(id);


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
-- Name: vent_fk1_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_fk1_usua FOREIGN KEY (idusuacrearegistro) REFERENCES usuarios(id);


--
-- Name: vent_fk2_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_fk2_usua FOREIGN KEY (idusuamodifregistro) REFERENCES usuarios(id);


--
-- Name: vent_fk3_usua; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_fk3_usua FOREIGN KEY (idusuaborraregistro) REFERENCES usuarios(id);


--
-- Name: vent_fk_ceco; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_fk_ceco FOREIGN KEY (idceco) REFERENCES centros_costos(id);


--
-- Name: vent_fk_clie; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_fk_clie FOREIGN KEY (idclie) REFERENCES clientes(id);


--
-- Name: vent_fk_empr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_fk_empr FOREIGN KEY (idempr) REFERENCES empresas(id);


--
-- Name: vent_fk_esve; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_fk_esve FOREIGN KEY (idesve) REFERENCES estados_ventas(id);


--
-- Name: vent_fk_gere; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_fk_gere FOREIGN KEY (idgere) REFERENCES gerencias(id);


--
-- Name: vent_fk_line; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_fk_line FOREIGN KEY (idline) REFERENCES lineas_negocios(id);


--
-- Name: vent_fk_nove; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_fk_nove FOREIGN KEY (idnove) REFERENCES notas_ventas(id);


--
-- Name: vent_fk_proy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_fk_proy FOREIGN KEY (idproy) REFERENCES proyectos(id);


--
-- Name: vent_fk_tare; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_fk_tare FOREIGN KEY (idtare) REFERENCES tareas(id);


--
-- Name: vent_fk_tidv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ventas
    ADD CONSTRAINT vent_fk_tidv FOREIGN KEY (idtidv) REFERENCES tipos_doctos_ventas(id);


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

