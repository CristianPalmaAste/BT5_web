create or replace function f_datos_producto (numeric
                                            ,numeric
                                            ) returns varchar as
$$
declare
  Pidprod                    numeric := $1;
  Pdato_deseado              numeric := $2;
  Vcod_familia               varchar(1000);
  Vcod_sub_familia           varchar(1000);
  Vunidad_medida_producto    varchar(1000);
  Vorigen_producto           varchar(1000);
  Vnombre_producto           varchar(1000);
  Vpreciounitario            numeric;
  Vporcentajedescuento       numeric;
  Vidfapr                    numeric;
  Vidsfpr                    numeric;
begin
  /*

     Esta función retorna los sgtes. datos de un producto:

     Flag   Dato retornado
     ----   -----------------
       1    familia
       2    sub familia
       3    unidad de medida
       4    origen
       5    nombre
       6    precio
       7    descuento (expresado como %)

  */
  if Pdato_deseado not between 1 and 7 then
    return(null);
  end if;
  if    Pdato_deseado between 1 and 5 then
    select fapr.cod_familia
          ,sfpr.cod_sub_familia
          ,unmp.descripcioncorta
          ,orpr.descripcioncorta
          ,prod.nombre
    into   Vcod_familia
          ,Vcod_sub_familia
          ,Vunidad_medida_producto
          ,Vorigen_producto
          ,Vnombre_producto
    from   productos                  prod
          ,sub_familias_productos     sfpr
          ,familias_productos         fapr
          ,unidades_medidas_productos unmp
          ,origenes_productos         orpr
    where  prod.idsfpr = sfpr.id
    and    sfpr.idfapr = fapr.id
    and    prod.idunmp = unmp.id
    and    prod.idorpr = orpr.id
    and    prod.id     = Pidprod
    ;
    if    Pdato_deseado = 1 then
      return(Vcod_familia);
    elsif Pdato_deseado = 2 then
      return(Vcod_sub_familia);
    elsif Pdato_deseado = 3 then
      return(Vunidad_medida_producto);
    elsif Pdato_deseado = 4 then
      return(Vorigen_producto);
    elsif Pdato_deseado = 5 then
      return(Vnombre_producto);
    end if;
  elsif Pdato_deseado = 6 then
    select delp.preciounitario
    into   Vpreciounitario
    from   listas_precios          lipr
          ,detalles_listas_precios delp
    where  lipr.id     = delp.idlipr
    and    lipr.idesre = 1
    and    delp.idprod = Pidprod
    ;
    return(Vpreciounitario);
  elsif Pdato_deseado = 7 then
    select porcentajedescuento
    into   Vporcentajedescuento
    from   descuentos
    where  idprod = Pidprod
    and    idesre = 1
    ;
    if Vporcentajedescuento is not null then
      return(Vporcentajedescuento);
    else
      select sfpr.idfapr
            ,sfpr.id
      into   Vidfapr
            ,Vidsfpr
      from   productos              prod
            ,sub_familias_productos sfpr
      where  prod.idsfpr = sfpr.id
      and    prod.id     = Pidprod
      ;
      select porcentajedescuento
      into   Vporcentajedescuento
      from   descuentos
      where  idsfpr = Vidsfpr
      and    idesre = 1
      ;
      if Vporcentajedescuento is not null then
        return(Vporcentajedescuento);
      else
        select porcentajedescuento
        into   Vporcentajedescuento
        from   descuentos
        where  idfapr = Vidfapr
        and    idesre = 1
        ;
        if Vporcentajedescuento is not null then
          return(Vporcentajedescuento);
        else
          return(0);
        end if;
      end if;
    end if;
  else
    return('-----');
  end if;
end;
$$ LANGUAGE plpgsql;

select f_datos_producto(1,0);
select f_datos_producto(1,1);
select f_datos_producto(1,2);
select f_datos_producto(1,3);
select f_datos_producto(1,4);
select f_datos_producto(1,5);
select f_datos_producto(1,6);
select f_datos_producto(1,7);
select f_datos_producto(1,8);

