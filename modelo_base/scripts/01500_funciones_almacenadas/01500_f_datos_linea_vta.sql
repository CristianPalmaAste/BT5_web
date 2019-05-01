create or replace function f_datos_linea_vta (numeric
                                             ,numeric
                                             ,numeric
                                             ,numeric
                                             ,numeric
                                             ) returns numeric as
$$
declare
  Pidprod          numeric := $1;
  Pidserv          numeric := $2;
  Pcantidad        numeric := $3;
  Pmonto_dscto     numeric := $4;
  Pdato_deseado    numeric := $5;
  Vidpais          numeric;
  aux              numeric;
  Vpreciounitario  numeric;
  Vidtipr          numeric;
  Vidtise          numeric;
  Vestaexento      char(1);
  Vsub_total       numeric;
  Vvalor_impuesto  numeric;
  Veste_impuesto   numeric;
  Vimpuestos       numeric;
  C_impuestos_obligat_prod cursor for
    select valor
    from   impuestos
    where  idpais      = Vidpais
    and    obligatorio = 'S'
    and    Vestaexento = 'N'
    ;
  C_impuestos_especif_prod cursor for
    select impu.valor
    from   tipos_productos_impuestos tipi
          ,impuestos                 impu
    where  tipi.idimpu      = impu.id
    and    tipi.idtipr      = Vidtipr
    and    impu.obligatorio = 'N'
    and    impu.idpais      = Vidpais
    ;
  C_impuestos_serv cursor for
    select valor
    from   impuestos
    where  idpais      = Vidpais
    and    obligatorio = 'S'
    and    Vestaexento = 'N'
    ;
begin
  /*
    Esta función debe ser invocada con (Pidprod o Pidserv), solo uno de los 2, y con Pcantidad y Pmonto_dscto (el cual puede ser 0)
    Además, un parámetro extra que indica qué dato es el que se desea obtener, a saber:

    1: precio de venta (del producto o servicio)
    2: total exento
    3: total afecto
    4: impuestos obligatorios
    5: impuestos específicos
  */
  if (Pidprod is null and Pidserv is null) or Pcantidad is null or Pmonto_dscto is null or Pdato_deseado is null then
    return(0);
  end if;
  if Pidprod is not null and Pidserv is not null then
    return(0);
  end if;
  if Pdato_deseado not in (1, 2, 3, 4, 5) then
    return(0);
  end if;
  if Pidprod is not null then
    select count(*)
    into   aux
    from   productos
    where  id = Pidprod
    ;
    if aux = 0 then
      return(0);
    end if;
    select idtipr
    into   Vidtipr
    from   productos
    where  id = Pidprod
    ;
    select delp.preciounitario
    into   Vpreciounitario
    from   detalles_listas_precios delp
          ,listas_precios          lipr
    where  delp.idlipr = lipr.id
    and    delp.idprod = Pidprod
    and    lipr.idesre = 1
    ;
    if Vpreciounitario is null then
      Vpreciounitario := 0;
    end if;
    if Pdato_deseado = 1 then
      return(Vpreciounitario);
    end if;
    select estaexento
    into   Vestaexento
    from   tipos_productos
    where  id = Vidtipr
    ;
    if Pdato_deseado in (2, 3) then
      if Vestaexento = 'S' then
        if Pdato_deseado = 2 then
          return(Pcantidad*Vpreciounitario - Pmonto_dscto);
        else
          return(0);
        end if;
      else
        if Pdato_deseado = 2 then
          return(0);
        else
          return(Pcantidad*Vpreciounitario - Pmonto_dscto);
        end if;
      end if;
    end if;
    select grem.idpais
    into   Vidpais
    from   grupos_empresariales grem
          ,empresas             empr
          ,productos            prod
    where  grem.id = empr.idgrem
    and    empr.id = prod.idempr
    and    prod.id = Pidprod
    ;
    Vsub_total := Pcantidad*Vpreciounitario - Pmonto_dscto;
    Vimpuestos := 0;
    if Pdato_deseado = 4 then
      open C_impuestos_obligat_prod;
      loop
        fetch C_impuestos_obligat_prod into Vvalor_impuesto;
        exit when not found;
        Veste_impuesto := round((Vsub_total * Vvalor_impuesto) / 100);
        Vimpuestos     := Vimpuestos + Veste_impuesto;
      end loop;
      close C_impuestos_obligat_prod;
      return(Vimpuestos);
    else /* Pdato_deseado = 5 */
      open C_impuestos_especif_prod;
      loop
        fetch C_impuestos_especif_prod into Vvalor_impuesto;
        exit when not found;
        Veste_impuesto := round((Vsub_total * Vvalor_impuesto) / 100);
        Vimpuestos     := Vimpuestos + Veste_impuesto;
      end loop;
      close C_impuestos_especif_prod;
      return(Vimpuestos);
    end if;
  else /* servicio */
    select count(*)
    into   aux
    from   servicios
    where  id = Pidserv
    ;
    if aux = 0 then
      return(0);
    end if;
    select preciounitario
          ,idtise
    into   Vpreciounitario
          ,Vidtise
    from   servicios
    where  id = Pidserv
    ;
    if Pdato_deseado = 1 then
      return(Vpreciounitario);
    end if;
    select estaexento
    into   Vestaexento
    from   tipos_servicios
    where  id = Vidtise
    ;
    if Pdato_deseado in (2, 3) then
      if Vestaexento = 'S' then
        if Pdato_deseado = 2 then
          return(Pcantidad*Vpreciounitario - Pmonto_dscto);
        else
          return(0);
        end if;
      else
        if Pdato_deseado = 2 then
          return(0);
        else
          return(Pcantidad*Vpreciounitario - Pmonto_dscto);
        end if;
      end if;
    end if;
    if Pdato_deseado = 4 then
      select grem.idpais
      into   Vidpais
      from   grupos_empresariales grem
            ,empresas             empr
            ,servicios            serv
      where  grem.id = empr.idgrem
      and    empr.id = serv.idempr
      and    serv.id = Pidserv
      ;
      Vsub_total := Pcantidad*Vpreciounitario - Pmonto_dscto;
      Vimpuestos := 0;
      open C_impuestos_serv;
      loop
        fetch C_impuestos_serv into Vvalor_impuesto;
        exit when not found;
        Veste_impuesto := round((Vsub_total * Vvalor_impuesto) / 100);
        Vimpuestos     := Vimpuestos + Veste_impuesto;
      end loop;
      close C_impuestos_serv;
      return(Vimpuestos);
    end if;
  end if;
  return(0);
end;
$$ LANGUAGE plpgsql;

select 'precio vta prod 16    : ' || f_datos_linea_vta(16, null, 0, 0  , 1);
select 'exento prod 16        : ' || f_datos_linea_vta(16, null, 5, 100, 2);
select 'afecto prod 16        : ' || f_datos_linea_vta(16, null, 5, 100, 3);
select 'imptos oblig prod 16  : ' || f_datos_linea_vta(16, null, 5, 100, 4);
select 'imptos especif prod 16: ' || f_datos_linea_vta(16, null, 5, 100, 5);

\q

select f_datos_linea_vta(16  , null, 1, 100, 1);
select f_datos_linea_vta(17  , null, 1, 100, 1);
select f_datos_linea_vta(null, 1   , 5, 100, 1);

select 'precio venta serv 1: ' || f_datos_linea_vta(null, 5, 0, 0  , 1);
select 'exento serv 1: '       || f_datos_linea_vta(null, 5, 5, 100, 2);
select 'afecto serv 1: '       || f_datos_linea_vta(null, 5, 5, 100, 3);
select 'impuestos serv 1: '    || f_datos_linea_vta(null, 5, 5, 100, 4);

