create or replace function f_crear_datos_empresa() returns trigger as
$body$
declare
  Vidfapr int;
begin
  insert into parametros_empresas values (nextval('paem_seq'), new.id, 'MAXDSCTOPERM', 'MÁXIMO DESCUENTO PERMITIDO (%)', 'MÁXIMO DESCUENTO PERMITIDO (EXPRESADO EN PORCENTAJE) EN UNA VENTA DE ESTA EMPRESA', '10' , 1, current_timestamp, null, null, null, null);

  insert into bodegas values (nextval('bode_seq'), new.id, 'BODEGA CENTRAL', 1, current_timestamp, null, null, null, null);

  select nextval('fapr_seq')
  into   Vidfapr
  ;

  insert into familias_productos values (Vidfapr, new.id, '01', 'FAMILIA GENÉRICA', 1, current_timestamp, null, null, null, null);

  insert into sub_familias_productos values (nextval('sfpr_seq'), Vidfapr, '01', 'SUB FAMILIA GENÉRICA', 1, current_timestamp, null, null, null, null);

  return new;
end;
$body$ LANGUAGE plpgsql;

\q

