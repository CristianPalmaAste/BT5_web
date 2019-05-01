delete from empresas
where  id in (998, 999)
;

insert into empresas (id                       -- numeric(20,0)   not null
                     ,idgrem                   -- numeric(20,0)   not null
                     ,idpais                   -- numeric(20,0)   not null
                     ,idesre                   -- numeric(20,0)   not null
                     ,identificador1           -- varchar(50)     not null
                     ,identificador2           -- varchar(50)     not null
                     ,razonsocial              -- varchar(100)    not null
                     ,nombrefantasia           -- varchar(100)    not null
                     ,icono                    -- varchar(100)    not null
                     ,idusuacrearegistro       -- numeric(20,0)   not null
                     ,fechacrearegistro        -- timestamp       not null
                     )
values(998               -- id                       numeric(20,0)   not null
      ,2                 -- idgrem                   numeric(20,0)   not null
      ,1                 -- idpais                   numeric(20,0)   not null
      ,1                 -- idesre                   numeric(20,0)   not null
      ,'4709176'         -- identificador1           varchar(50)     not null
      ,'8'               -- identificador2           varchar(50)     not null
      ,'VEAM'            -- razonsocial              varchar(100)    not null
      ,'VEAM'            -- nombrefantasia           varchar(100)    not null
      ,'a.jpg'           -- icono                    varchar(100)    not null
      ,1                 -- idusuacrearegistro       numeric(20,0)   not null
      ,current_timestamp -- fechacrearegistro        timestamp       not null
      )
;

insert into empresas (id                       -- numeric(20,0)   not null
                     ,idgrem                   -- numeric(20,0)   not null
                     ,idpais                   -- numeric(20,0)   not null
                     ,idesre                   -- numeric(20,0)   not null
                     ,identificador1           -- varchar(50)     not null
                     ,identificador2           -- varchar(50)     not null
                     ,razonsocial              -- varchar(100)    not null
                     ,nombrefantasia           -- varchar(100)    not null
                     ,icono                    -- varchar(100)    not null
                     ,idusuacrearegistro       -- numeric(20,0)   not null
                     ,fechacrearegistro        -- timestamp       not null
                     )
values(999               -- id                       numeric(20,0)   not null
      ,2                 -- idgrem                   numeric(20,0)   not null
      ,1                 -- idpais                   numeric(20,0)   not null
      ,1                 -- idesre                   numeric(20,0)   not null
      ,'21878885'        -- identificador1           varchar(50)     not null
      ,'8'               -- identificador2           varchar(50)     not null
      ,'NAPM'            -- razonsocial              varchar(100)    not null
      ,'NAPM'            -- nombrefantasia           varchar(100)    not null
      ,'a.jpg'           -- icono                    varchar(100)    not null
      ,1                 -- idusuacrearegistro       numeric(20,0)   not null
      ,current_timestamp -- fechacrearegistro        timestamp       not null
      )
;

\q
