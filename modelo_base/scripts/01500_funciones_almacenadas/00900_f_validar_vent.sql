create or replace function f_validar_vent() returns trigger as
$body$
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
$body$ LANGUAGE plpgsql;

\q

