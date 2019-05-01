select * from nove
;

select * from vent
;

update cotizaciones_ventas
set    idescv = 2
;

update cotizaciones_ventas
set    idescv = 3
;

insert into formas_pagos_notas_ventas values (1                     -- id                       numeric(20,0)   not null
                                             ,1                     -- idnove                   numeric(20,0)   not null
                                             ,1                     -- idtifp                   numeric(20,0)   not null
                                             ,1000                  -- monto                    numeric(20,0)   not null
                                             ,1                     -- idusuacrearegistro       numeric(20,0)   not null
                                             ,current_timestamp     -- fechacrearegistro        timestamp       not null
                                             ,null                  -- idusuamodifregistro      numeric(20,0)       null
                                             ,null                  -- fechamodifregistro       timestamp           null
                                             ,null                  -- idusuaborraregistro      numeric(20,0)       null
                                             ,null                  -- fechaborraregistro       timestamp           null
                                             )
;

insert into formas_pagos_notas_ventas values (2                     -- id                       numeric(20,0)   not null
                                             ,1                     -- idnove                   numeric(20,0)   not null
                                             ,2                     -- idtifp                   numeric(20,0)   not null
                                             ,1500                  -- monto                    numeric(20,0)   not null
                                             ,1                     -- idusuacrearegistro       numeric(20,0)   not null
                                             ,current_timestamp     -- fechacrearegistro        timestamp       not null
                                             ,null                  -- idusuamodifregistro      numeric(20,0)       null
                                             ,null                  -- fechamodifregistro       timestamp           null
                                             ,null                  -- idusuaborraregistro      numeric(20,0)       null
                                             ,null                  -- fechaborraregistro       timestamp           null
                                             )
;

insert into formas_pagos_notas_ventas values (3                     -- id                       numeric(20,0)   not null
                                             ,1                     -- idnove                   numeric(20,0)   not null
                                             ,3                     -- idtifp                   numeric(20,0)   not null
                                             ,1070                  -- monto                    numeric(20,0)   not null
                                             ,1                     -- idusuacrearegistro       numeric(20,0)   not null
                                             ,current_timestamp     -- fechacrearegistro        timestamp       not null
                                             ,null                  -- idusuamodifregistro      numeric(20,0)       null
                                             ,null                  -- fechamodifregistro       timestamp           null
                                             ,null                  -- idusuaborraregistro      numeric(20,0)       null
                                             ,null                  -- fechaborraregistro       timestamp           null
                                             )
;

update notas_ventas
set    idesnv = 2
;

update notas_ventas
set    idesnv = 3
;

select idtidv, numero, idclie, descripcionventa, exento, afecto, impuestos, porcentajedescuento, montodescuento, total, idesve
from   vent
;

select id, idvent, correlativo, idprod, idserv, preciounitario, cantidad, porcentajedescuento, montodescuento, exento, afecto, impuestos, totallinea
from   deve
;

select id, idvent, idtifp, monto
from   fpve
;

