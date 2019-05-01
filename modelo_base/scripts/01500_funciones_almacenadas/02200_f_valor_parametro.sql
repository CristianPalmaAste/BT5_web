create or replace function f_valor_parametro (Porigen_parametro numeric
                                             ,Pidgrem_o_idempr  numeric
                                             ,Pnombre_parametro varchar(100)
                                            ) returns varchar(500) as
$$
declare
  Vvalor  varchar(500);
begin
  /* El parámetro Porigen_parametro representa de cuál de las 2 tablas de parámetros se desea
     obtener el dato:
     1 = tabla parametros (asociada a todo un grem)
     2 = tabla parametros_empresas (asociada a toda una empr)

   Pnombre_parametro es el nombre corto del parámetro para el
   cual se desea obtener su valor

  */
  if    Porigen_parametro = 1 then
    select valor
    into   Vvalor
    from   parametros
    where  idgrem      = Pidgrem_o_idempr
    and    nombrecorto = Pnombre_parametro
    ;
    return(Vvalor);
  elsif Porigen_parametro = 2 then
    select valor
    into   Vvalor
    from   parametros_empresas
    where  idempr      = Pidgrem_o_idempr
    and    nombrecorto = Pnombre_parametro
    ;
    return(Vvalor);
  else
    return('');
  end if;
end;
$$ LANGUAGE plpgsql;

select f_valor_parametro(1, 1, 'LARGOMINCLAVE');
select f_valor_parametro(1, 2, 'VALIDEZCOTI'  );
select f_valor_parametro(1, 3, 'CADUCNV'      );
select f_valor_parametro(2, 5, 'MAXDSCTOPERM' );
