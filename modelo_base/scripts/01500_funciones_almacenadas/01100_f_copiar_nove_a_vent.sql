create or replace function f_copiar_nove_a_vent() returns trigger as
$body$
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
  Vimpuestosobligats        numeric;
  Vimpuestosespecifs        numeric;
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
          ,impuestosobligats
          ,impuestosespecifs
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
                       ,idbode                   -- numeric(20,0)   not null
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
                       ,impuestosobligats        -- numeric(20,0)   not null
                       ,impuestosespecifs        -- numeric(20,0)   not null
                       ,porcentajedescuento      -- numeric(20,2)   not null
                       ,montodescuento           -- numeric(20,2)   not null
                       ,total                    -- numeric(20,0)   not null
                       ,idesve                   -- numeric(20,0)   not null
                       ,idusuavendedor           -- numeric(20,0)   not null
                       ,idusuacrearegistro       -- numeric(20,0)   not null
                       ,fechacrearegistro        -- timestamp       not null
                       ,idusuamodifregistro      -- numeric(20,0)       null
                       ,fechamodifregistro       -- timestamp           null
                       ,idusuaborraregistro      -- numeric(20,0)       null
                       ,fechaborraregistro       -- timestamp           null
                       )
    values (Vidvent                       -- id                       numeric(20,0)   not null
           ,new.idempr                    -- idempr                   numeric(20,0)   not null
           ,new.idbode                    -- idbode                   numeric(20,0)   not null
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
           ,new.impuestosobligats         -- impuestosobligats        numeric(20,0)   not null
           ,new.impuestosespecifs         -- impuestosespecifs        numeric(20,0)   not null
           ,new.porcentajedescuento       -- porcentajedescuento      numeric(20,2)   not null
           ,new.montodescuento            -- montodescuento           numeric(20,2)   not null
           ,new.total                     -- total                    numeric(20,0)   not null
           ,1                             -- idesve                   numeric(20,0)   not null
           ,new.idusuavendedor            -- idusuavendedor           numeric(20,0)   not null
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
                       ,Vimpuestosobligats
                       ,Vimpuestosespecifs
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
                                  ,impuestosobligats        -- numeric(20,2)   not null
                                  ,impuestosespecifs        -- numeric(20,2)   not null
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
             ,Vimpuestosobligats                   -- impuestosobligats        numeric(20,2)   not null
             ,Vimpuestosespecifs                   -- impuestosespecifs        numeric(20,2)   not null
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
$body$ LANGUAGE plpgsql;

\q

