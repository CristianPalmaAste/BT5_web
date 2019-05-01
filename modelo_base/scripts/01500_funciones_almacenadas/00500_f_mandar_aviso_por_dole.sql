create or replace function f_mandar_aviso_por_dole () returns varchar(1) as
$$
declare
  C_doles_por_avisar cursor for
    select dole.emailaviso
          ,dole.nombreoriginal
          ,to_char(dole.fechaaviso,'dd-mm-yyyy') 
          ,tidl.descripcion
          ,dole.id
    from   documentos_legales       dole
          ,tipos_documentos_legales tidl
    where  dole.idtidl     = tidl.id
    and    dole.fechaaviso is not null
    and    dole.avisodado  = 'N'
    and    dole.fechaaviso <= current_timestamp
    ;
  Vemailaviso              varchar(100);
  Vnombreoriginal          varchar(100);
  Vfechaaviso              varchar(100);
  Vtidl_descripcion        varchar(100);
  Vlinea                   varchar(1000);
  Viddole                  numeric;
begin
  open C_doles_por_avisar;
  loop
    fetch C_doles_por_avisar into Vemailaviso
                                 ,Vnombreoriginal
                                 ,Vfechaaviso
                                 ,Vtidl_descripcion
                                 ,Viddole
                                 ;
    exit when not found;
    Vlinea :=    chr(10)
              || 'YYYYY_10' || 'Aviso documento legal'
              || chr(10)
              || 'YYYYY_20' || Vemailaviso
              || chr(10)
              || 'YYYYY_30' || 'El documento ' || Vnombreoriginal || ' de tipo ' || Vtidl_descripcion || ', tenia fecha de aviso ' || Vfechaaviso
              ;
    raise notice 'XXXXX'
    using hint = Vlinea;
    update documentos_legales
    set    avisodado  = 'S'
    where  id         = Viddole
    ;
  end loop;
  close C_doles_por_avisar;
  return('S');
end;
$$ LANGUAGE plpgsql;

\q

