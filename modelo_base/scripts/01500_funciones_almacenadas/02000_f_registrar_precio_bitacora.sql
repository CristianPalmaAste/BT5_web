create or replace function f_registrar_precio_bitacora() returns trigger as
$body$
declare
  Vidfapr int;
begin
  if TG_OP = 'INSERT' then
    insert into bitacoras_cambios_precios values (nextval('bicp_seq')       -- id                       numeric(20,0)   not null
                                                 ,new.idprod                -- idprod                   numeric(20,0)   not null
                                                 ,new.preciounitario        -- preciounitario           numeric(20,0)   not null
                                                 ,new.idusuacrearegistro    -- idusuacrearegistro       numeric(20,0)   not null
                                                 ,current_timestamp         -- fechacrearegistro        timestamp       not null
                                                 )
    ;
  else
    insert into bitacoras_cambios_precios values (nextval('bicp_seq')       -- id                       numeric(20,0)   not null
                                                 ,new.idprod                -- idprod                   numeric(20,0)   not null
                                                 ,new.preciounitario        -- preciounitario           numeric(20,0)   not null
                                                 ,new.idusuamodifregistro   -- idusuacrearegistro       numeric(20,0)   not null
                                                 ,current_timestamp         -- fechacrearegistro        timestamp       not null
                                                 )
    ;
  end if;

  return new;
end;
$body$ LANGUAGE plpgsql;

\q
