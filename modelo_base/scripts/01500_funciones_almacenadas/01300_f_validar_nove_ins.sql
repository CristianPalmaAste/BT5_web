create or replace function f_validar_nove_ins() returns trigger as
$body$
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
$body$ LANGUAGE plpgsql;

\q

