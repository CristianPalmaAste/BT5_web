drop trigger if exists trg_before_upd_cove on cotizaciones_ventas
;

drop trigger if exists trg_before_upd_nove on notas_ventas
;

select id from cove
;

select id from nove
;

select id from dove
;

delete from detalles_doctos_vtas
;

delete from documentos_ventas
;

delete from detalles_notas_vtas
;

delete from notas_ventas
;

update cotizaciones_ventas
set    idescv = 1
;

update cotizaciones_ventas
set    idescv = 2
;

update cotizaciones_ventas
set    idescv = 3
;

select id from cove
;

select id from nove
;

select id from dove
;

update notas_ventas
set    idesnv = 1
;

update notas_ventas
set    idesnv = 2
;

update notas_ventas
set    idesnv = 3
;

select id from cove
;

select id from nove
;

select id from dove
;

select *
from   cpalma
;
