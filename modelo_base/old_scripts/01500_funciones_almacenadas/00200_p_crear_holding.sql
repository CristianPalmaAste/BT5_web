drop public synonym p_crear_holding;

spool p_crear_holding.txt

create or replace procedure p_crear_holding(Pnombre in     varchar2
                                           ,Palias  in     varchar2
                                           ,Picono  in     varchar2
                                           ) as
begin
  select gremseq.nextval
  into   Vidgrem
  from   dual
  ;
  insert into grupos_empresariales (id                       -- number(20,0)     not null
                                   ,nombre                   -- varchar2(100)    not null
                                   ,alias                    -- varchar2(10)     not null
                                   ,icono                    -- varchar2(100)    not null
                                   ,idesge                   -- number(20,0)     not null
                                   ,idusuacrearegistro       -- number(20,0)     not null
                                   ,fechacrearegistro        -- date             not null
                                   ,idusuamodifregistro      -- number(20,0)         null
                                   ,fechamodifregistro       -- date                 null
                                   ,idusuaborraregistro      -- number(20,0)         null
                                   ,fechaborraregistro       -- date                 null
                                   )
  values (Vidgrem                                -- id                       number(20,0)     not null
         ,Pnombre                                -- nombre                   varchar2(100)    not null
         ,Palias                                 -- alias                    varchar2(10)     not null
         ,Picono                                 -- icono                    varchar2(100)    not null
         ,1                                      -- idesge                   number(20,0)     not null
         ,Pidusuacrearegistro                    -- idusuacrearegistro       number(20,0)     not null
         ,sysdate                                -- fechacrearegistro        date             not null
         ,null                                   -- idusuamodifregistro      number(20,0)         null
         ,null                                   -- fechamodifregistro       date                 null
         ,null                                   -- idusuaborraregistro      number(20,0)         null
         ,null                                   -- fechaborraregistro       date                 null
         )
  ;

  insert into parametros values (paraseq.nextval, Vidgrem, 'LARGOMINCLAVE', 'LARGO MINIMO CLAVE USUARIOS', 'LARGO MINIMO EXIGIDO PARA LAS CLAVE DE LOS USUARIOS', '5', 1, sysdate, null, null, null, null);

  insert into rubros values (rubrseq.nextval, Vidgrem, 'CONSULTORÍA' );
  insert into rubros values (rubrseq.nextval, Vidgrem, 'AUTOMOTRIZ'  );
  insert into rubros values (rubrseq.nextval, Vidgrem, 'INDUSTRIAL'  );
  insert into rubros values (rubrseq.nextval, Vidgrem, 'INVERSIONES' );
  insert into rubros values (rubrseq.nextval, Vidgrem, 'AGRICOLA'    );
  insert into rubros values (rubrseq.nextval, Vidgrem, 'FARMACÉUTICO');
  insert into rubros values (rubrseq.nextval, Vidgrem, 'LOGÍSTICA'   );
  insert into rubros values (rubrseq.nextval, Vidgrem, 'AMASANDERÍA' );

end;
/
show error

grant all on p_crear_holding to public;

create public synonym p_crear_holding for p_crear_holding;

exit;
