set client_min_messages to warning;

drop view if exists perfilamientov
;

create or replace view perfilamientov as
select null               id_holding
      ,'--'               holding
      ,null               id_empresa
      ,'--'               empresa
      ,perf.id            id_perfil
      ,perf.descripcion   perfil
      ,usua.username      username
      ,usua.id            idusua
      ,pers.id            idpers
from   personas          pers
      ,usuarios          usua
      ,usuarios_perfiles uspe
      ,perfiles          perf
where  pers.id                  = usua.idpers
and    usua.id                  = uspe.idusua
and    uspe.idperf              = perf.id
and    uspe.idgrem              is null
and    uspe.idempr              is null
and    perf.id                  = 1
and    pers.idusuaborraregistro is null
and    usua.idusuaborraregistro is null
and    uspe.idusuaborraregistro is null
union
select to_char(grem.id,'9999999999')
      ,grem.nombre
      ,null
      ,'--'
      ,perf.id
      ,perf.descripcion
      ,usua.username
      ,usua.id
      ,pers.id
from   personas             pers
      ,usuarios             usua
      ,usuarios_perfiles    uspe
      ,perfiles             perf
      ,grupos_empresariales grem
where  pers.id                  = usua.idpers
and    usua.id                  = uspe.idusua
and    uspe.idperf              = perf.id
and    uspe.idgrem              = grem.id
and    uspe.idgrem              is not null
and    uspe.idempr              is null
and    perf.id                  = 2
and    pers.idusuaborraregistro is null
and    usua.idusuaborraregistro is null
and    uspe.idusuaborraregistro is null
and    grem.idesge              = 1
union
select to_char(grem.id,'9999999999')
      ,grem.nombre
      ,to_char(empr.id,'9999999999')
      ,empr.nombrefantasia
      ,perf.id
      ,perf.descripcion
      ,usua.username
      ,usua.id
      ,pers.id
from   personas             pers
      ,usuarios             usua
      ,usuarios_perfiles    uspe
      ,perfiles             perf
      ,empresas             empr
      ,grupos_empresariales grem
where  pers.id                  = usua.idpers
and    usua.id                  = uspe.idusua
and    uspe.idperf              = perf.id
and    uspe.idempr              = empr.id
and    empr.idgrem              = grem.id
and    uspe.idgrem              is null
and    uspe.idempr              is not null
and    perf.id                  not in (1,2)
and    pers.idusuaborraregistro is null
and    usua.idusuaborraregistro is null
and    uspe.idusuaborraregistro is null
and    empr.idesre              = 1
and    grem.idesge              = 1
order  by 2,4,6
;

select *
from   perfilamientov
;

\q
