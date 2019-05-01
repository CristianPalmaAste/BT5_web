create or replace function f_validar_cove() returns trigger as
$body$
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
$body$ LANGUAGE plpgsql;

\q

