create or replace function f_validar_cove_ins() returns trigger as
$body$
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
$body$ LANGUAGE plpgsql;

\q

