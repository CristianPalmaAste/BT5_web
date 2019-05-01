create or replace function f_rebajar_stock() returns trigger as
$body$
declare
  Vidmobo        numeric(20,0);
  Vcorrelativo   numeric(20,0);
  Vidprod        numeric(20,0);
  Vcantidad      numeric(20,5);
  Vidunmp        numeric(20,0);
  C_detalle_venta cursor for
    select correlativo
          ,idprod
          ,cantidad
    from   detalles_ventas
    where  idvent = new.id
    and    idserv is null
    ;
begin
  if old.idesve = 1 and new.idesve = 2 then
    select nextval('mobo_seq')
    into   Vidmobo
    ;
    select max(correlativo)
    into   Vcorrelativo
    from   movimientos_bodegas
    where  idbode = new.idbode
    ;
    if Vcorrelativo is null then
      Vcorrelativo := 1;
    else
      Vcorrelativo := Vcorrelativo + 1;
    end if;
    insert into movimientos_bodegas (id                       -- numeric(20,0)   not null
                                    ,idbode                   -- numeric(20,0)   not null
                                    ,correlativo              -- numeric(20,0)   not null
                                    ,idtimb                   -- numeric(20,0)   not null
                                    ,fechamovto               -- date            not null
                                    ,descripcion              -- varchar(100)    not null
                                    ,idusuacrearegistro       -- numeric(20,0)   not null
                                    ,fechacrearegistro        -- timestamp       not null
                                    ,idusuamodifregistro      -- numeric(20,0)       null
                                    ,fechamodifregistro       -- timestamp           null
                                    ,idusuaborraregistro      -- numeric(20,0)       null
                                    ,fechaborraregistro       -- timestamp           null
                                    )
    values(Vidmobo                  -- id                       numeric(20,0)   not null
          ,new.idbode               -- idbode                   numeric(20,0)   not null
          ,Vcorrelativo             -- correlativo              numeric(20,0)   not null
          ,1                        -- idtimb                   numeric(20,0)   not null
          ,current_date             -- fechamovto               date            not null
          ,'VENTA'                  -- descripcion              varchar(100)    not null
          ,new.idusuamodifregistro  -- idusuacrearegistro       numeric(20,0)   not null
          ,current_timestamp        -- fechacrearegistro        timestamp       not null
          ,null                     -- idusuamodifregistro      numeric(20,0)       null
          ,null                     -- fechamodifregistro       timestamp           null
          ,null                     -- idusuaborraregistro      numeric(20,0)       null
          ,null                     -- fechaborraregistro       timestamp           null
          )
    ;
    open C_detalle_venta;
    loop
      fetch C_detalle_venta into Vcorrelativo
                                ,Vidprod
                                ,Vcantidad
                                ;
      exit when not found;
      select idunmp
      into   Vidunmp
      from   productos
      where  id = Vidprod
      ;
      insert into detalles_movtos_bodegas (id                       -- numeric(20,0)   not null
                                          ,idmobo                   -- numeric(20,0)   not null
                                          ,correlativo              -- numeric(20,0)   not null
                                          ,idprod                   -- numeric(20,0)   not null
                                          ,cantidad                 -- numeric(20,0)   not null
                                          ,idunmp                   -- numeric(20,0)   not null
                                          ,idusuacrearegistro       -- numeric(20,0)   not null
                                          ,fechacrearegistro        -- timestamp       not null
                                          ,idusuamodifregistro      -- numeric(20,0)       null
                                          ,fechamodifregistro       -- timestamp           null
                                          ,idusuaborraregistro      -- numeric(20,0)       null
                                          ,fechaborraregistro       -- timestamp           null
                                          )
      values(nextval('demb_seq')      -- id                       numeric(20,0)   not null
            ,Vidmobo                  -- idmobo                   numeric(20,0)   not null
            ,Vcorrelativo             -- correlativo              numeric(20,0)   not null
            ,Vidprod                  -- idprod                   numeric(20,0)   not null
            ,Vcantidad                -- cantidad                 numeric(20,0)   not null
            ,Vidunmp                  -- idunmp                   numeric(20,0)   not null
            ,new.idusuamodifregistro  -- idusuacrearegistro       numeric(20,0)   not null
            ,current_timestamp        -- fechacrearegistro        timestamp       not null
            ,null                     -- idusuamodifregistro      numeric(20,0)       null
            ,null                     -- fechamodifregistro       timestamp           null
            ,null                     -- idusuaborraregistro      numeric(20,0)       null
            ,null                     -- fechaborraregistro       timestamp           null
            )
      ;
      update bodegas_productos
      set    stock  = stock - Vcantidad
      where  idbode = new.idbode
      and    idprod = Vidprod
      ;
    end loop;
    close C_detalle_venta;
  end if;

  return new;
end;
$body$ LANGUAGE plpgsql;

\q
