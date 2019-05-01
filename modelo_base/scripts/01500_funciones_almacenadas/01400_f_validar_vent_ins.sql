create or replace function f_validar_vent_ins() returns trigger as
$body$
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
$body$ LANGUAGE plpgsql;

\q

