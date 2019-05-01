set client_min_messages to warning;

/*************************************************************************************************************************/

drop view if exists persv
;

create or replace view persv as
select pers.id               id
      ,pers.idgrem           idgrem
      ,grem.alias            holding
      ,pers.identificador1   rut
      ,pers.identificador2   dv
      ,pers.primernombre     primernombre
      ,pers.segundonombre    segundonombre
      ,pers.apellidopaterno  apellidopaterno
      ,pers.apellidomaterno  apellidomaterno
      ,pers.email            email
      ,pers.fechanac         fechanac
      ,pers.idesci           idesci
      ,esci.descripcion      estadocivil
      ,pers.idsexo           idsexo
      ,sexo.descripcion      sexo
      ,pers.idpais           idpais
      ,pais.nacionalidad     nacionalidad
from                   personas             pers
       left       join grupos_empresariales grem on pers.idgrem = grem.id
       left outer join estados_civiles      esci on pers.idesci = esci.id
       left outer join sexos                sexo on pers.idsexo = sexo.id
       left outer join paises               pais on pers.idpais = pais.id
where  pers.idusuaborraregistro is null
and    grem.idusuaborraregistro is null
;

select *
from   persv
;

/*************************************************************************************************************************/

drop view if exists dolev
;

create or replace view dolev as
select dole.id               id
      ,dole.idempr           idempr
      ,empr.nombrefantasia   empresa
      ,dole.idtidl           idtidl
      ,tidl.descripcion      tipodocumentolegal
      ,dole.nombreoriginal   nombreoriginal
      ,dole.nombresistema    nombresistema
      ,dole.idesdl           idesdl
      ,esdl.descripcion      estadodocumentolegal
      ,dole.fecha            fecha
      ,dole.notaria          notaria
      ,dole.foja             foja
      ,dole.responsable      responsable
      ,dole.comentario       comentario
      ,dole.fechaaviso       fechaaviso
      ,dole.emailaviso       emailaviso
      ,dole.avisodado        avisodado
from             documentos_legales         dole
       left join empresas                   empr on dole.idempr = empr.id
       left join tipos_documentos_legales   tidl on dole.idtidl = tidl.id
       left join estados_documentos_legales esdl on dole.idesdl = esdl.id
where  empr.idusuaborraregistro is null
;

select *
from   dolev
;

/*************************************************************************************************************************/

drop view if exists gremv
;

create or replace view gremv as
select grem.id               id
      ,grem.nombre           nombre
      ,grem.alias            alias
      ,grem.icono            icono
      ,grem.idpais           idpais
      ,pais.nombre           pais
      ,grem.idesge           idesge
      ,esge.descripcion      estadoholding
from             grupos_empresariales grem
       left join paises               pais on grem.idpais = pais.id
       left join estados_grem         esge on grem.idesge = esge.id
where  grem.idusuaborraregistro is null
;

select *
from   gremv
;

/*************************************************************************************************************************/

drop view if exists emprv
;

create or replace view emprv as
select empr.id               id
      ,empr.idgrem           idgrem
      ,grem.nombre           holding
      ,empr.idpais           idpais
      ,pais.nombre           pais
      ,empr.idrubr           idrubr
      ,rubr.descripcion      rubro
      ,empr.idesre           idesre
      ,esre.descripcion      estadoregistro
      ,empr.identificador1   identificador1
      ,empr.identificador2   identificador2
      ,empr.razonsocial      razonsocial
      ,empr.nombrefantasia   nombrefantasia
      ,empr.icono            icono
from             empresas                empr
       left join grupos_empresariales    grem on empr.idgrem = grem.id
       left join paises                  pais on empr.idpais = pais.id
       left join rubros                  rubr on empr.idrubr = rubr.id
       left join estados_registros       esre on empr.idesre = esre.id
where  empr.idusuaborraregistro is null
and    grem.idusuaborraregistro is null
;

select *
from   emprv
;

/*************************************************************************************************************************/

drop view if exists uspev
;

create or replace view uspev as
select uspe.id               id
      ,uspe.idusua           idusua
      ,usua.username         username
      ,uspe.idperf           idperf
      ,perf.descripcion      perfil
      ,uspe.idgrem           idgrem
      ,grem.nombre           holding
      ,uspe.idempr           idempr
      ,empr.razonsocial      razonsocial
      ,uspe.idesre           idesre
      ,esre.descripcion      estadoregistro
from                   usuarios_perfiles    uspe
       left       join usuarios             usua on uspe.idusua = usua.id
       left       join perfiles             perf on uspe.idperf = perf.id
       left outer join grupos_empresariales grem on uspe.idgrem = grem.id
       left outer join empresas             empr on uspe.idempr = empr.id
       left       join estados_registros    esre on uspe.idesre = esre.id
where  uspe.idusuaborraregistro is null
and    usua.idusuaborraregistro is null
and    grem.idusuaborraregistro is null
and    empr.idusuaborraregistro is null
;

select *
from   uspev
;

/*************************************************************************************************************************/

drop view if exists peprv
;

create or replace view peprv as
select pepr.id               id
      ,pepr.idperf           idperf
      ,perf.descripcion      perfil
      ,pepr.idprog           idprog
      ,prog.titulo           programa
from             perfiles_programas pepr
       left join perfiles           perf on pepr.idperf = perf.id
       left join programas          prog on pepr.idprog = prog.id
where  pepr.idusuaborraregistro is null
;

select *
from   peprv
;

/*************************************************************************************************************************/

drop view if exists tipiv
;

create or replace view tipiv as
select tipi.id               id
      ,tipr.id               idtipr
      ,tipr.descripcion      tipo_producto
      ,impu.id               idimpu
      ,impu.descripcion      impuesto
      ,impu.descripcioncorta alias_impuesto
      ,impu.valor            valor
from                   tipos_productos_impuestos tipi
       left outer join tipos_productos           tipr on tipi.idtipr = tipr.id
       left outer join impuestos                 impu on tipi.idimpu = impu.id
;

select *
from   tipiv
;

/*************************************************************************************************************************/

drop view if exists cliev
;

create or replace view cliev as
select clie.id               id
      ,clie.idgrem           idgrem
      ,grem.alias            holding
      ,clie.idpais           idpais
      ,pais.nombre           pais
      ,clie.identificador1   identificador1
      ,clie.identificador2   identificador2
      ,clie.idticl           idticl
      ,ticl.descripcion      tipo_cliente
      ,clie.razonsocial      razonsocial
      ,clie.nombrefantasia   nombrefantasia
      ,clie.primernombre     primernombre
      ,clie.segundonombre    segundonombre
      ,clie.apellidopaterno  apellidopaterno
      ,clie.apellidomaterno  apellidomaterno
from                   clientes             clie
       left outer join grupos_empresariales grem on clie.idgrem = grem.id
       left outer join paises               pais on clie.idpais = pais.id
       left outer join tipos_clientes       ticl on clie.idticl = ticl.id
where  clie.idusuaborraregistro is null
and    grem.idusuaborraregistro is null
;

select *
from   cliev
;

/*************************************************************************************************************************/

drop view if exists prodv
;

create or replace view prodv as
select prod.id                        id
      ,prod.idempr                    idempr
      ,empr.nombrefantasia            empresa
      ,prod.idsfpr                    idsfpr
      ,sfpr.cod_sub_familia           sub_familia
      ,sfpr.descripcion               nombre_sub_familia
      ,sfpr.idfapr                    idfapr
      ,fapr.cod_familia               familia
      ,fapr.descripcion               nombre_familia
      ,prod.idtipr                    idtipr
      ,tipr.descripcion               tipo_producto
      ,prod.idunmp                    idunmp
      ,unmp.descripcion               unidad_de_medida
      ,unmp.descripcioncorta          alias_unidad_de_medida
      ,prod.idorpr                    idorpr
      ,orpr.descripcion               origen
      ,orpr.descripcioncorta          alias_origen
      ,prod.nombre                    nombre
      ,prod.correlativoflia           producto
      ,prod.sku                       sku
      ,prod.ean13                     ean13
      ,prod.qr                        qr
      ,prod.pesounitariokg            pesounitariokg
      ,prod.idesre                    idesre
      ,esre.descripcion               estado_regsitro
from                   productos                  prod
       left outer join empresas                   empr on prod.idempr = empr.id
       left outer join sub_familias_productos     sfpr on prod.idsfpr = sfpr.id
       left outer join familias_productos         fapr on sfpr.idfapr = fapr.id
       left outer join tipos_productos            tipr on prod.idtipr = tipr.id
       left outer join unidades_medidas_productos unmp on prod.idunmp = unmp.id
       left outer join origenes_productos         orpr on prod.idorpr = orpr.id
       left outer join estados_registros          esre on prod.idesre = esre.id
where  prod.idusuaborraregistro is null
and    empr.idusuaborraregistro is null
;

select *
from   prodv
;

/*************************************************************************************************************************/

drop view if exists servv
;

create or replace view servv as
select serv.id                id
      ,serv.idempr            idempr
      ,empr.nombrefantasia    empresa
      ,serv.idtise            idtise
      ,tise.descripcion       tipo_servicio
      ,serv.idunms            idunms
      ,unms.descripcion       unidad_medida_servicio
      ,unms.descripcioncorta  alias_unidad_medida_servicio
      ,serv.nombre            nombre
      ,serv.preciounitario    preciounitario
      ,serv.idmone            idmone
      ,mone.nombre            moneda
      ,mone.nombrecorto       alias_moneda
from                   servicios                  serv
       left outer join empresas                   empr on serv.idempr = empr.id
       left outer join tipos_servicios            tise on serv.idtise = tise.id
       left outer join unidades_medidas_servicios unms on serv.idunms = unms.id
       left outer join monedas                    mone on serv.idmone = mone.id
where  serv.idusuaborraregistro is null
and    empr.idusuaborraregistro is null
;

select *
from   servv
;

/*************************************************************************************************************************/

drop view if exists covev
;

create or replace view covev as
select cove.id                                                                                                                     id
      ,cove.idempr                                                                                                                 idempr
      ,empr.nombrefantasia                                                                                                         empresa
      ,cove.numero                                                                                                                 numero_cotiz
      ,cove.idclie                                                                                                                 idclie
      ,coalesce(clie.nombrefantasia,' ') || ' ' || coalesce(clie.primernombre,' ') || ' ' || coalesce(clie.apellidopaterno,' ')    cliente
      ,cove.descripcioncotizacion                                                                                                  desc_cotiz
      ,cove.idgere                                                                                                                 idgere
      ,gere.nombre                                                                                                                 gerencia
      ,cove.idproy                                                                                                                 idproy
      ,proy.nombre                                                                                                                 proyecto
      ,cove.idline                                                                                                                 idline
      ,line.nombre                                                                                                                 linea_negocio
      ,cove.idceco                                                                                                                 idceco
      ,ceco.nombre                                                                                                                 centro_costo
      ,cove.idtare                                                                                                                 idtare
      ,tare.nombre                                                                                                                 tarea
      ,cove.exento                                                                                                                 exento
      ,cove.afecto                                                                                                                 afecto
      ,cove.impuestosobligats                                                                                                      impuestosobligats
      ,cove.impuestosespecifs                                                                                                      impuestosespecifs
      ,cove.porcentajedescuento                                                                                                    porcentajedescuento
      ,cove.montodescuento                                                                                                         montodescuento
      ,cove.total                                                                                                                  total
      ,cove.diasvalidez                                                                                                            diasvalidez
      ,cove.idescv                                                                                                                 idescv
      ,escv.descripcion                                                                                                            estado_cotiz
from                   cotizaciones_ventas        cove
       left outer join empresas                   empr on cove.idempr = empr.id
       left outer join clientes                   clie on cove.idclie = clie.id
       left outer join gerencias                  gere on cove.idgere = gere.id
       left outer join proyectos                  proy on cove.idproy = proy.id
       left outer join lineas_negocios            line on cove.idline = line.id
       left outer join centros_costos             ceco on cove.idceco = ceco.id
       left outer join tareas                     tare on cove.idtare = tare.id
       left outer join estados_cotizaciones_vtas  escv on cove.idescv = escv.id
where  cove.idusuaborraregistro is null
;

select *
from   covev
;

/*************************************************************************************************************************/

drop view if exists novev
;

create or replace view novev as
select nove.id                                                                                                                     id
      ,nove.idempr                                                                                                                 idempr
      ,empr.nombrefantasia                                                                                                         empresa
      ,nove.idcove                                                                                                                 idcove
      ,cove.numero                                                                                                                 numero_cotizacion
      ,nove.numero                                                                                                                 numero_nota_venta
      ,nove.idclie                                                                                                                 idclie
      ,coalesce(clie.nombrefantasia,' ') || ' ' || coalesce(clie.primernombre,' ') || ' ' || coalesce(clie.apellidopaterno,' ')    cliente
      ,nove.descripcionnotaventa                                                                                                   descripcion_nota_venta
      ,nove.fechanotaventa                                                                                                         fecha_nota_venta
      ,nove.idgere                                                                                                                 idgere
      ,gere.nombre                                                                                                                 gerencia
      ,nove.idproy                                                                                                                 idproy
      ,proy.nombre                                                                                                                 proyecto
      ,nove.idline                                                                                                                 idline
      ,line.nombre                                                                                                                 linea_negocio
      ,nove.idceco                                                                                                                 idceco
      ,ceco.nombre                                                                                                                 centro_costo
      ,nove.idtare                                                                                                                 idtare
      ,tare.nombre                                                                                                                 tarea
      ,nove.exento                                                                                                                 exento
      ,nove.afecto                                                                                                                 afecto
      ,nove.impuestosobligats                                                                                                      impuestosobligats
      ,nove.impuestosespecifs                                                                                                      impuestosespecifs
      ,nove.porcentajedescuento                                                                                                    porc_descto
      ,nove.montodescuento                                                                                                         monto_descto
      ,nove.total                                                                                                                  total
      ,nove.idesnv                                                                                                                 idesnv
      ,esnv.descripcion                                                                                                            estado_nota_venta
from                   notas_ventas            nove
       left outer join empresas                empr on nove.idempr = empr.id
       left outer join cotizaciones_ventas     cove on nove.idcove = cove.id
       left outer join clientes                clie on nove.idclie = clie.id
       left outer join gerencias               gere on nove.idgere = gere.id
       left outer join proyectos               proy on nove.idproy = proy.id
       left outer join lineas_negocios         line on nove.idline = line.id
       left outer join centros_costos          ceco on nove.idceco = ceco.id
       left outer join tareas                  tare on nove.idtare = tare.id
       left outer join estados_notas_vtas      esnv on nove.idesnv = esnv.id
where  nove.idusuaborraregistro is null
;

select *
from   novev
;

/*************************************************************************************************************************/

drop view if exists ventv
;

create or replace view ventv as
select vent.id                                                                                                                     id
      ,vent.idempr                                                                                                                 idempr
      ,empr.nombrefantasia                                                                                                         empresa
      ,vent.idnove                                                                                                                 idnove
      ,nove.numero                                                                                                                 numero_nota_venta
      ,vent.idtidv                                                                                                                 idtidv
      ,tidv.descripcion                                                                                                            tipo_docto_venta
      ,vent.numero                                                                                                                 folio_docto_venta
      ,vent.idclie                                                                                                                 idclie
      ,coalesce(clie.nombrefantasia,' ') || ' ' || coalesce(clie.primernombre,' ') || ' ' || coalesce(clie.apellidopaterno,' ')    cliente
      ,vent.descripcionventa                                                                                                       descripcion_venta
      ,vent.fechaventa                                                                                                             fecha_venta
      ,vent.idgere                                                                                                                 idgere
      ,gere.nombre                                                                                                                 gerencia
      ,vent.idproy                                                                                                                 idproy
      ,proy.nombre                                                                                                                 proyecto
      ,vent.idline                                                                                                                 idline
      ,line.nombre                                                                                                                 linea_negocio
      ,vent.idceco                                                                                                                 idceco
      ,ceco.nombre                                                                                                                 centro_costo
      ,vent.idtare                                                                                                                 idtare
      ,tare.nombre                                                                                                                 tarea
      ,vent.exento                                                                                                                 exento
      ,vent.afecto                                                                                                                 afecto
      ,vent.impuestosobligats                                                                                                      impuestosobligats
      ,vent.impuestosespecifs                                                                                                      impuestosespecifs
      ,vent.porcentajedescuento                                                                                                    porc_descto
      ,vent.montodescuento                                                                                                         monto_descto
      ,vent.total                                                                                                                  total
      ,vent.idesve                                                                                                                 idesve
      ,esve.descripcion                                                                                                            estado_venta
from                   ventas                  vent
       left outer join empresas                empr on vent.idempr = empr.id
       left outer join notas_ventas            nove on vent.idnove = nove.id
       left outer join tipos_doctos_ventas     tidv on vent.idtidv = tidv.id
       left outer join clientes                clie on vent.idclie = clie.id
       left outer join gerencias               gere on vent.idgere = gere.id
       left outer join proyectos               proy on vent.idproy = proy.id
       left outer join lineas_negocios         line on vent.idline = line.id
       left outer join centros_costos          ceco on vent.idceco = ceco.id
       left outer join tareas                  tare on vent.idtare = tare.id
       left outer join estados_ventas          esve on vent.idesve = esve.id
where  vent.idusuaborraregistro is null
;

select *
from   ventv
;

/*************************************************************************************************************************/

drop view if exists faprv
;

create or replace view faprv as
select fapr.id               id
      ,fapr.idempr           idempr
      ,empr.nombrefantasia   empresa
      ,fapr.cod_familia      cod_familia
      ,fapr.descripcion      descripcion
from                   familias_productos         fapr
       left outer join empresas                   empr on fapr.idempr = empr.id
where  fapr.idusuaborraregistro is null
;

select *
from   faprv
;

/*************************************************************************************************************************/

drop view if exists sfprv
;

create or replace view sfprv as
select sfpr.id                       id
      ,sfpr.idfapr                   idfapr
      ,fapr.cod_familia              cod_familia
      ,fapr.descripcion              familia
      ,sfpr.cod_sub_familia          cod_sub_familia
      ,sfpr.descripcion              sub_familia
      ,fapr.idempr                   idempr
      ,empr.nombrefantasia           empresa
from                   sub_familias_productos         sfpr
       left outer join familias_productos             fapr on sfpr.idfapr = fapr.id
       left outer join empresas                       empr on fapr.idempr = empr.id
where  sfpr.idusuaborraregistro is null
;

select *
from   sfprv
;

/*************************************************************************************************************************/

drop view if exists bodev
;

create or replace view bodev as
select bode.id                  id
      ,bode.idempr              idempr
      ,empr.nombrefantasia      empresa
      ,bode.nombre              bodega
from                   bodegas                   bode
       left outer join empresas                  empr on bode.idempr = empr.id
where  bode.idusuaborraregistro is null
;

select *
from   bodev
;

/*************************************************************************************************************************/

drop view if exists boprv
;

create or replace view boprv as
select bopr.id               id
      ,bode.idempr           idempr
      ,empr.nombrefantasia   empresa
      ,bopr.idbode           idbode
      ,bode.nombre           bodega
      ,bopr.idprod           idprod
      ,prod.nombre           producto
      ,bopr.stock            stock
      ,prod.idunmp           idunmp
      ,unmp.descripcioncorta unidad_medida
from                   bodegas_productos          bopr
       left outer join bodegas                    bode on bopr.idbode = bode.id
       left outer join empresas                   empr on bode.idempr = empr.id
       left outer join productos                  prod on bopr.idprod = prod.id
       left outer join unidades_medidas_productos unmp on prod.idunmp = unmp.id
where  bopr.idusuaborraregistro is null
;

select *
from   boprv
;

/*************************************************************************************************************************/

drop view if exists liprv
;

create or replace view liprv as
select lipr.id               id
      ,lipr.idempr           idempr
      ,empr.nombrefantasia   empresa
      ,lipr.correlativo      correlativo
      ,lipr.fechainicio      fechainicio
      ,lipr.fechafin         fechafin
      ,lipr.observaciones    observaciones
      ,lipr.idesre           idesre
      ,esre.descripcion      estado_regsitro
from                   listas_precios          lipr
       left outer join empresas                empr on lipr.idempr = empr.id
       left outer join estados_registros       esre on lipr.idesre = esre.id
where  lipr.idusuaborraregistro is null
;

select *
from   liprv
;

/*************************************************************************************************************************/

drop view if exists delpv
;

create or replace view delpv as
select delp.id                                           id
      ,delp.idlipr                                       idlipr
      ,lipr.correlativo || ' - ' || lipr.observaciones   lista_precio
      ,lipr.idempr                                       idempr
      ,empr.nombrefantasia                               empresa
      ,delp.idprod                                       idprod
      ,prod.nombre                                       producto
      ,delp.preciounitario                               preciounitario
from                   detalles_listas_precios delp
       left outer join listas_precios          lipr on delp.idlipr = lipr.id
       left outer join empresas                empr on lipr.idempr = empr.id
       left outer join productos               prod on delp.idprod = prod.id
where  delp.idusuaborraregistro is null
;

select *
from   delpv
;

/*************************************************************************************************************************/

drop view if exists desuv
;

create or replace view desuv as
select desu.id                                            id
      ,desu.idfapr                                        idfapr
      ,fapr.cod_familia                                   cod_familia
      ,fapr.descripcion                                   familia
      ,desu.idsfpr                                        idsfpr
      ,fapr2.cod_familia || sfpr.cod_sub_familia          cod_sub_familia
      ,fapr2.descripcion || ' - ' || sfpr.descripcion     sub_familia
      ,desu.idprod                                        idprod
      ,prod.nombre                                        producto
      ,desu.porcentajedescuento                           porcentajedescuento
      ,desu.idesre                                        idesre
      ,esre.descripcion                                   estado_regsitro
from                   descuentos              desu
       left outer join familias_productos      fapr  on desu.idfapr = fapr.id
       left outer join sub_familias_productos  sfpr  on desu.idsfpr = sfpr.id
       left outer join familias_productos      fapr2 on sfpr.idfapr = fapr2.id
       left outer join empresas                empr  on fapr.idempr = empr.id
       left outer join productos               prod  on desu.idprod = prod.id
       left outer join estados_registros       esre  on desu.idesre = esre.id
where  desu.idusuaborraregistro is null
;

select *
from   desuv
order  by 1
;

\q



Más adelante:

/*************************************************************************************************************************/

drop view if exists XXXXv
;

create or replace view XXXXv as
select XXXX.id               id
from                   YYYYY                   XXXX
       left outer join ZZZZZ                   zzzz on XXXX.idzzzz = zzzz.id
where  xxxx.idusuaborraregistro is null
;

select *
from   XXXXv
order  by 1
;

soshv
idsov
orshv
poshv

