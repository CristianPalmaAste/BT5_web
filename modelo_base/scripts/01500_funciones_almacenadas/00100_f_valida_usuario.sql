create or replace function f_valida_usuario (Pusername varchar(100)
                                            ,Ppassword varchar(100)
                                            ) returns varchar(100) as
$$
declare
  aux  int;
  aux1 int;
  aux2 int;
  aux3 int;
begin
  -- Veo si existe el username
  select count(*)
  into   aux
  from   usuarios
  where  upper(username) = upper(Pusername)
  ;
  if aux = 0 then
    return('N:Usuario no existe');
  end if;
  --
  -- Veo si existe la combinacion username/password
  select count(*)
  into   aux
  from   usuarios
  where  upper(username) = upper(Pusername)
  and    password        = Ppassword
  ;
  if aux = 0 then
    return('N:Password inválida');
  end if;
  --
  -- Veo si el usuario esta activo
  select count(*)
  into   aux
  from   usuarios
  where  upper(username) = upper(Pusername)
  and    idesre          = 1
  ;
  if aux = 0 then
    return('N:Usuario no está activo');
  end if;
  --
  -- Veo si, entre las empresas o holding en las que tiene perfil, alguno esta activo
  select count(*)
  into   aux1
  from   usuarios          usua
        ,usuarios_perfiles uspe
        ,empresas          empr
  where  usua.id              = uspe.idusua
  and    uspe.idempr          = empr.id
  and    upper(usua.username) = upper(Pusername)
  and    empr.idesre          = 1
  and    uspe.idesre          = 1
  ;
  select count(*)
  into   aux2
  from   usuarios             usua
        ,usuarios_perfiles    uspe
        ,grupos_empresariales grem
  where  usua.id              = uspe.idusua
  and    uspe.idgrem          = grem.id
  and    upper(usua.username) = upper(Pusername)
  and    grem.idesge          = 1
  and    uspe.idesre          = 1
  ;
  select count(*)
  into   aux3
  from   usuarios             usua
        ,usuarios_perfiles    uspe
  where  usua.id              = uspe.idusua
  and    upper(usua.username) = upper(Pusername)
  and    uspe.idesre          = 1
  and    uspe.idperf          = 1                   -- usuario es administrador del sistema (ROSILVA, SEAGUIRRE, JJMONSALVE, etc.)
  ;
  if aux1 = 0 and aux2 = 0 and aux3 = 0 then
    return('N:Usuario no está asociado a ninguna empresa o holding activo');
  end if;
  --
  -- Si ha pasado todos los filtros anteriores, entonces quiere decir que es un usuario valido con clave valida
  -- en alguna empresa o holding activo
  return('S');
end;
$$ LANGUAGE plpgsql;

select f_valida_usuario('jsoto'    , '12345');
select f_valida_usuario('cpalmaa'  , 'aaaaa');
select f_valida_usuario('RQUEZADAA', '12345');
select f_valida_usuario('jperez'   , '12345');
select f_valida_usuario('iapino'   , '12345');
select f_valida_usuario('uat'      , '12345');

\q

