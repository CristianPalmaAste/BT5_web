create or replace function f_stock_producto (numeric
                                            ,numeric
                                            ,numeric
                                            ) returns numeric as
$$
declare
  Pidprod          numeric := $1;
  Pidbode          numeric := $2;
  Pdato_deseado    numeric := $3;
  aux              numeric;
  Vstock           numeric;
  Vreservado_nove  numeric;
  Vreservado_vent  numeric;
begin
  /*
     Esta función retorna el stock de un producto, siendo el stock el

       a) disponible físicamente
       b) disponible para venta
       c) "reservado" (por una nota de venta o una venta)

     Explicación:
     Supóngase que se tiene físicamente 100 unidades de un producto. Eso es lo que tengo realmente.
     Pero hay una nota de venta CREADA o EMITIDA que está haciendo referencia a este producto, por ej., 5 unidades
     Entonces no tengo 100 unidades disponibles para venta, sólo tego 95, porque 5 están "comprometidas" en esa
     nota de venta
     Íden con ventas en estado CREADA
     Una venta que pasa a CERRADA rebaja inmediatamente del stock

     Entonces, respecto de este producto se podría pedir:

       1) disponible físicamente                       : 100
       2) disponible para venta                        : 95
       3) reservado (por una nota de venta o una venta): 5

     Nota: más adelante habrá que incluir solicitudes de traspaso entre bodegas, esto es, si hay una solicitud de
           traspaso entre bodegas creada o cerrada, entonces los prpductos involucrados en esa solicitud están
           "reservados". Se deberían sumar al caso c) antes señalado

  */
  if Pidprod is null or Pdato_deseado is null then
    return(0);
  end if;
  if Pdato_deseado not in (1, 2, 3) then
    return(0);
  end if;
  select count(*)
  into   aux
  from   productos
  where  id = Pidprod
  ;
  if aux = 0 then
    return(0);
  end if;
  select stock
  into   Vstock
  from   bodegas_productos
  where  idbode = Pidbode
  and    idprod = Pidprod
  ;
  if Pdato_deseado = 1 then
    return(Vstock);
  end if;
  select sum(denv.cantidad)
  into   Vreservado_nove
  from   notas_ventas        nove
        ,detalles_notas_vtas denv
  where  nove.id     = denv.idnove
  and    nove.idesnv in (1, 2)
  and    nove.idbode = Pidbode
  and    denv.idprod = Pidprod
  ;
  if Vreservado_nove is null then
    Vreservado_nove := 0;
  end if;
  select sum(deve.cantidad)
  into   Vreservado_vent
  from   ventas          vent
        ,detalles_ventas deve
  where  vent.id     = deve.idvent
  and    vent.idesve = 1
  and    vent.idbode = Pidbode
  and    deve.idprod = Pidprod
  ;
  if Vreservado_vent is null then
    Vreservado_vent := 0;
  end if;
  if Pdato_deseado = 2 then
    return(Vstock - (Vreservado_nove + Vreservado_vent));
  else
    return(Vreservado_nove + Vreservado_vent);
  end if;
end;
$$ LANGUAGE plpgsql;

select 'stock físico prod 1               : ' || f_stock_producto(1, 1, 1);
select 'stock disponible para venta prod 1: ' || f_stock_producto(1, 1, 2);
select 'stock reservado prod 1            : ' || f_stock_producto(1, 1, 3);
