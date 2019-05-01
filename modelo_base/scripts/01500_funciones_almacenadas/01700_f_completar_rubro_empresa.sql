create or replace function f_completar_rubro_empresa() returns trigger as
$body$
declare
  Vidrubr numeric;
begin
  if new.idrubr is null then
    select min(id)
    into   Vidrubr
    from   rubros
    where  idgrem = new.idgrem
    ;
    new.idrubr := Vidrubr;
  end if;
  return new;
end;
$body$ LANGUAGE plpgsql;

\q

