create or replace function f_validar_dv_pers() returns trigger as
$body$
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
$body$ LANGUAGE plpgsql;

\q

