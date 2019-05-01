create or replace function f_poblar_fode_fide () returns varchar(1) as
$$
declare
  Vidfode                      numeric;
  Vtablename                   varchar(100);
  Vordinal_position            numeric;
  Vcolumn_name                 varchar(100);
  Vdata_type                   varchar(100);
  Adata_type                   varchar(100);
  Vcharacter_maximum_length    numeric;
  Vnumeric_precision           numeric;
  Vis_nullable                 varchar(100);
  Vrequerido                   varchar(100);
  Vlargo                       numeric;
  Vpk                          varchar(100);
  C_tablas cursor for
    select table_name
    from   information_schema.tables
    where  table_schema = 'public'
    and    table_type   = 'BASE TABLE'
    and    table_name   not in ('tablas_secuencias', 'field_defs', 'form_defs')
and table_name in ('tipos_movimientos_bodegas', 'movimientos_bodegas', 'detalles_movtos_bodegas', 'descuentos', 'bitacoras_cambios_precios')
    order  by 1
    ;
  C_columnas cursor for
    select ordinal_position
          ,column_name
          ,data_type
          ,character_maximum_length
          ,numeric_precision
          ,is_nullable
    from   information_schema.columns
    where  table_schema = 'public'
    and    table_name   = Vtablename
    and    column_name  not in ('idusuacrearegistro', 'fechacrearegistro'  , 'idusuamodifregistro'
                               ,'fechamodifregistro', 'idusuaborraregistro', 'fechaborraregistro'
                               ,'xfld'
                               )
    order  by 1
    ;
begin
--  delete from field_defs;
--  delete from form_defs;
  open C_tablas;
  loop
    fetch C_tablas into Vtablename
                        ;
    exit when not found;
    Vidfode := nextval('fode_seq');
    insert into form_defs values (Vidfode                    -- id                       numeric(11)     not null
                                 ,Vtablename                 -- caption                  varchar(50)     not null
                                 ,Vtablename                 -- table_name               varchar(30)     not null
                                 ,'Y'                        -- ins_allowed              varchar(1)      not null
                                 ,'Y'                        -- upd_allowed              varchar(1)      not null
                                 ,'Y'                        -- del_allowed              varchar(1)      not null
                                 )
    ;
    open C_columnas;
    loop
      fetch C_columnas into Vordinal_position
                           ,Vcolumn_name
                           ,Vdata_type
                           ,Vcharacter_maximum_length
                           ,Vnumeric_precision
                           ,Vis_nullable
                           ;
      exit when not found;
      Adata_type := trim(substr(Vdata_type,1,10));
      if    Adata_type = 'character' then
        Vlargo := Vcharacter_maximum_length;
      elsif Vdata_type = 'numeric' then
        Vlargo := Vnumeric_precision;
      else
        Vlargo := 0;
      end if;
      if Vis_nullable = 'NO' then
        Vrequerido := 'Y';
      else
        Vrequerido := 'N';
      end if;
      if Vordinal_position = 1 then
        Vpk := 'Y';
      else
        Vpk := 'N';
      end if;
      insert into field_defs values (nextval('fide_seq')            -- id                       numeric(11)     not null
                                    ,Vidfode                        -- form_id                  numeric(11)     not null
                                    ,Vordinal_position              -- forder                   numeric(11)     not null
                                    ,Vcolumn_name                   -- name                     varchar(30)     not null
                                    ,Adata_type                     -- type                     varchar(10)     not null
                                    ,Vlargo                         -- len                      numeric(11)     not null
                                    ,0                              -- decim                    numeric(11)     not null
                                    ,Vpk                            -- pk                       varchar(1)      not null
                                    ,Vrequerido                     -- req                      varchar(1)      not null
                                    ,Vcolumn_name                   -- caption                  varchar(50)     not null
                                    ,'input'                        -- gadget                   varchar(10)     not null
                                    ,Vlargo                         -- size                     numeric(11)     not null
                                    ,Vlargo                         -- maxlength                numeric(11)     not null
                                    ,5                              -- rows                     numeric(11)     not null
                                    ,60                             -- cols                     numeric(11)     not null
                                    ,''                             -- selvalues                varchar(500)        null
                                    ,''                             -- sqlvalues                varchar(500)        null
                                    ,'Y'                            -- visible                  varchar(1)      not null
                                    ,'N'                            -- readonly                 varchar(1)      not null
                                    ,'P'                            -- fld_type                 varchar(1)      not null
                                    ,-1                             -- fld_offset               numeric(11)     not null
                                    )
      ;
    end loop;
    close C_columnas;
  end loop;
  close C_tablas;
  return('S');
end;
$$ LANGUAGE plpgsql;

select f_poblar_fode_fide();

\q

