create or replace function f_validar_nove() returns trigger as
$body$
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
$body$ LANGUAGE plpgsql;

\q

