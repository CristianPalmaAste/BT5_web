set client_min_messages to warning;

/*************************************************************************************************************************/

create table grupos_empresariales (
   id                       numeric(20,0)   not null
  ,nombre                   varchar(100)    not null
  ,alias                    varchar(10)     not null
  ,icono                    varchar(100)    not null
  ,idesge                   numeric(20,0)   not null
  ,idusuacrearegistro       numeric(20,0)   not null
  ,fechacrearegistro        timestamp       not null
  ,idusuamodifregistro      numeric(20,0)       null
  ,fechamodifregistro       timestamp           null
  ,idusuaborraregistro      numeric(20,0)       null
  ,fechaborraregistro       timestamp           null
)
;

alter table grupos_empresariales add constraint grem_pk primary key (id)
;

alter table grupos_empresariales add constraint grem_uk_01 unique (nombre)
;

alter table grupos_empresariales add constraint grem_uk_02 unique (alias)
;

/*************************************************************************************************************************/

create table empresas (
   id                       numeric(20,0)   not null
  ,idgrem                   numeric(20,0)   not null
  ,idpais                   numeric(20,0)   not null
  ,idrubr                   numeric(20,0)   not null
  ,identificador1           varchar(50)     not null
  ,identificador2           varchar(50)     not null
  ,razonsocial              varchar(100)    not null
  ,nombrefantasia           varchar(100)    not null
  ,icono                    varchar(100)    not null
  ,idusuacrearegistro       numeric(20,0)   not null
  ,fechacrearegistro        timestamp       not null
  ,idusuamodifregistro      numeric(20,0)       null
  ,fechamodifregistro       timestamp           null
  ,idusuaborraregistro      numeric(20,0)       null
  ,fechaborraregistro       timestamp           null
  ,xfld                     varchar(250)        null
)
;

alter table empresas add constraint empr_pk primary key (id)
;

alter table empresas add constraint empr_uk_01 unique (identificador1)
;

alter table empresas add constraint empr_uk_02 unique (idgrem, razonsocial)
;

alter table empresas add constraint empr_uk_03 unique (idgrem, nombrefantasia)
;

/*************************************************************************************************************************/

create table parametros (
   id                       numeric(20,0)   not null
  ,idgrem                   numeric(20,0)   not null
  ,nombrecorto              varchar(50)     not null
  ,nombrelargo              varchar(500)    not null
  ,descripcion              varchar(1000)   not null
  ,valor                    varchar(500)    not null
  ,idusuacrearegistro       numeric(20,0)   not null
  ,fechacrearegistro        timestamp       not null
  ,idusuamodifregistro      numeric(20,0)       null
  ,fechamodifregistro       timestamp           null
  ,idusuaborraregistro      numeric(20,0)       null
  ,fechaborraregistro       timestamp           null
)
;

alter table parametros add constraint para_pk primary key (id)
;

alter table parametros add constraint para_uk_01 unique (idgrem, nombrecorto)
;

alter table parametros add constraint para_uk_02 unique (idgrem, nombrelargo)
;

/*************************************************************************************************************************/

create table estados_grem (
   id                          numeric(20,0)     not null
  ,descripcion                 varchar(100)    not null
)
;

alter table estados_grem add constraint esge_pk primary key (id)
;

alter table estados_grem add constraint esge_uk_01 unique (descripcion)
;

/*************************************************************************************************************************/

create table rubros (
   id                          numeric(20,0)   not null
  ,idgrem                      numeric(20,0)   not null
  ,descripcion                 varchar(100)    not null
)
;

alter table rubros add constraint rubr_pk primary key (id)
;

alter table rubros add constraint rubr_uk_01 unique (idgrem, descripcion)
;

/*************************************************************************************************************************/

create table estados_registros (
   id                          numeric(20,0)   not null
  ,descripcion                 varchar(100)    not null
)
;

alter table estados_registros add constraint esre_pk primary key (id)
;

alter table estados_registros add constraint esre_uk_01 unique (descripcion)
;

/*************************************************************************************************************************/

create table valores_paises (
   id                         numeric(20,0)   not null
  ,idpais                     numeric(20,0)   not null
  ,nombrecorto                varchar(10)     not null
  ,nombrelargo                varchar(500)    not null
  ,descripcion                varchar(1000)   not null
  ,valor                      varchar(1000)   not null
  ,idusuacrearegistro         numeric(20,0)   not null
  ,fechacrearegistro          timestamp       not null
  ,idusuamodifregistro        numeric(20,0)       null
  ,fechamodifregistro         timestamp           null
  ,idusuaborraregistro        numeric(20,0)       null
  ,fechaborraregistro         timestamp           null
)
;

alter table valores_paises add constraint vapa_pk primary key (id)
;

alter table valores_paises add constraint vapa_uk_01 unique (idpais, nombrecorto)
;

alter table valores_paises add constraint vapa_uk_02 unique (idpais, nombrelargo)
;

/*************************************************************************************************************************/

create table monedas (
   id                         numeric(20,0)   not null
  ,nombre                     varchar(100)    not null
  ,nombrecorto                varchar(10)     not null
)
;

alter table monedas add constraint mone_pk primary key (id)
;

alter table monedas add constraint mone_uk_01 unique (nombre)
;

alter table monedas add constraint mone_uk_02 unique (nombrecorto)
;

/*************************************************************************************************************************/

create table paises (
   id                         numeric(20,0)   not null
  ,nombre                     varchar(100)    not null
  ,idmone                     numeric(20,0)   not null
  ,nacionalidad               varchar(100)    not null
)
;

alter table paises add constraint pais_pk primary key (id)
;

alter table paises add constraint pais_uk_01 unique (nombre)
;

alter table paises add constraint pais_uk_02 unique (idmone)
;

alter table paises add constraint pais_uk_03 unique (nacionalidad)
;

/*************************************************************************************************************************/

create table personas (
   id                       numeric(20,0)   not null
  ,idgrem                   numeric(20,0)   not null
  ,identificador1           varchar(50)     not null
  ,identificador2           varchar(50)     not null
  ,primernombre             varchar(100)    not null
  ,segundonombre            varchar(100)        null
  ,apellidopaterno          varchar(100)    not null
  ,apellidomaterno          varchar(100)    not null
  ,email                    varchar(100)        null
  ,fechanac                 date                null
  ,idesci                   numeric(20,0)       null
  ,idsexo                   numeric(20,0)       null
  ,idpais                   numeric(20,0)       null
  ,idusuacrearegistro       numeric(20,0)   not null
  ,fechacrearegistro        timestamp       not null
  ,idusuamodifregistro      numeric(20,0)       null
  ,fechamodifregistro       timestamp           null
  ,idusuaborraregistro      numeric(20,0)       null
  ,fechaborraregistro       timestamp           null
)
;

alter table personas add constraint pers_pk primary key (id)
;

alter table personas add constraint pers_uk_01 unique (idgrem, identificador1)
;

/*************************************************************************************************************************/

create table perfiles (
   id                          numeric(20,0)   not null
  ,descripcion                 varchar(100)    not null
)
;

alter table perfiles add constraint perf_pk primary key (id)
;

alter table perfiles add constraint perf_uk_01 unique (descripcion)
;

/*************************************************************************************************************************/

create table estados_civiles (
   id                          numeric(20,0)   not null
  ,alias                       varchar(1)      not null
  ,descripcion                 varchar(100)    not null
)
;

alter table estados_civiles add constraint esci_pk primary key (id)
;

alter table estados_civiles add constraint esci_uk_01 unique (alias)
;

alter table estados_civiles add constraint esci_uk_02 unique (descripcion)
;

/*************************************************************************************************************************/

create table sexos (
   id                          numeric(20,0)   not null
  ,alias                       varchar(1)      not null
  ,descripcion                 varchar(100)    not null
)
;

alter table sexos add constraint sexo_pk primary key (id)
;

alter table sexos add constraint sexo_uk_01 unique (alias)
;

alter table sexos add constraint sexo_uk_02 unique (descripcion)
;

/*************************************************************************************************************************/

create table programas (
   id                        numeric(20,0)   not null
  ,idprogpadre               numeric(20,0)       null
  ,titulo                    varchar(100)    not null
  ,link                      varchar(100)        null
  ,etiqueta                  varchar(100)    not null
  ,peso                      numeric(20,0)   not null
)
;

alter table programas add constraint prog_pk primary key (id)
;

alter table programas add constraint prog_uk_01 unique (idprogpadre, peso)
;

/*************************************************************************************************************************/

create table usuarios (
   id                       numeric(20,0)   not null
  ,username                 varchar(100)    not null
  ,password                 varchar(100)    not null
  ,idpers                   numeric(20,0)   not null
  ,idesre                   numeric(20,0)   not null
  ,idusuacrearegistro       numeric(20,0)   not null
  ,fechacrearegistro        timestamp       not null
  ,idusuamodifregistro      numeric(20,0)       null
  ,fechamodifregistro       timestamp           null
  ,idusuaborraregistro      numeric(20,0)       null
  ,fechaborraregistro       timestamp           null
)
;

alter table usuarios add constraint usua_pk primary key (id)
;

alter table usuarios add constraint usua_uk_01 unique (username)
;

/*************************************************************************************************************************/

create table usuarios_perfiles (
   id                       numeric(20,0)     not null
  ,idusua                   numeric(20,0)     not null
  ,idperf                   numeric(20,0)     not null
  ,idgrem                   numeric(20,0)         null
  ,idempr                   numeric(20,0)         null
  ,idesre                   numeric(20,0)     not null
  ,idusuacrearegistro       numeric(20,0)     not null
  ,fechacrearegistro        timestamp         not null
  ,idusuamodifregistro      numeric(20,0)         null
  ,fechamodifregistro       timestamp             null
  ,idusuaborraregistro      numeric(20,0)         null
  ,fechaborraregistro       timestamp             null
)
;

/*
   La opcionalidad de los campos grem_id y empr_id se debe a que algunos perfiles pueden no estar asociados a holding ni a empresa. Esto sera controlado a
   traves de una check constraint que luego se declara. La asociacion entre perfiles y holding/empresas es la sgte.:

   Perfil administrador ERP: no asociado ni a holding ni a empresa
   Perfil administrador holding: acociado a un holding
   Todos los demas perfiles estan asociados a una empresa
*/

alter table usuarios_perfiles add constraint uspe_pk primary key (id)
;

alter table usuarios_perfiles add constraint uspe_uk_01 unique (idusua, idperf, idgrem)
;

alter table usuarios_perfiles add constraint uspe_uk_02 unique (idusua, idperf, idempr)
;

alter table usuarios_perfiles add constraint uspe_chk_01 check (   (idperf = 1           and idgrem is     null and idempr is     null)
                                                                or
                                                                   (idperf = 2           and idgrem is not null and idempr is     null)
                                                                or
                                                                   (idperf not in (1, 2) and idgrem is     null and idempr is not null)
                                                               )
;

/*************************************************************************************************************************/

create table perfiles_programas (
   id                       numeric(20,0)     not null
  ,idperf                   numeric(20,0)     not null
  ,idprog                   numeric(20,0)     not null
  ,idusuacrearegistro       numeric(20,0)     not null
  ,fechacrearegistro        timestamp         not null
  ,idusuamodifregistro      numeric(20,0)         null
  ,fechamodifregistro       timestamp             null
  ,idusuaborraregistro      numeric(20,0)         null
  ,fechaborraregistro       timestamp             null
)
;

alter table perfiles_programas add constraint pepr_pk primary key (id)
;

alter table perfiles_programas add constraint pepr_uk_01 unique (idperf, idprog)
;

/*************************************************************************************************************************/

-- Seccion foreign keys

alter table perfiles_programas   add constraint pepr_fk_perf  foreign key (idperf)                references perfiles             (id);
alter table perfiles_programas   add constraint pepr_fk_prog  foreign key (idprog)                references programas            (id);

alter table paises               add constraint pais_fk_mone  foreign key (idmone)                references monedas              (id);

alter table grupos_empresariales add constraint grem_fk1_esge foreign key (idesge)                references estados_grem         (id);
alter table grupos_empresariales add constraint grem_fk1_usua foreign key (idusuacrearegistro)    references usuarios             (id);
alter table grupos_empresariales add constraint grem_fk2_usua foreign key (idusuamodifregistro)   references usuarios             (id);
alter table grupos_empresariales add constraint grem_fk3_usua foreign key (idusuaborraregistro)   references usuarios             (id);

alter table rubros               add constraint rubr_fk_grem  foreign key (idgrem)                references grupos_empresariales (id);

alter table empresas             add constraint empr_fk_grem  foreign key (idgrem)                references grupos_empresariales (id);
alter table empresas             add constraint empr_fk_pais  foreign key (idpais)                references paises               (id);
alter table empresas             add constraint empr_fk_rubr  foreign key (idrubr)                references rubros               (id);
alter table empresas             add constraint empr_fk1_usua foreign key (idusuacrearegistro)    references usuarios             (id);
alter table empresas             add constraint empr_fk2_usua foreign key (idusuamodifregistro)   references usuarios             (id);
alter table empresas             add constraint empr_fk3_usua foreign key (idusuaborraregistro)   references usuarios             (id);

alter table parametros           add constraint para_fk_grem  foreign key (idgrem)                references grupos_empresariales (id);
alter table parametros           add constraint para_fk1_usua foreign key (idusuacrearegistro)    references usuarios             (id);
alter table parametros           add constraint para_fk2_usua foreign key (idusuamodifregistro)   references usuarios             (id);
alter table parametros           add constraint para_fk3_usua foreign key (idusuaborraregistro)   references usuarios             (id);

alter table personas             add constraint pers_fk_grem  foreign key (idgrem)                references grupos_empresariales (id);
alter table personas             add constraint pers_fk_esci  foreign key (idesci)                references estados_civiles      (id);
alter table personas             add constraint pers_fk_sexo  foreign key (idsexo)                references sexos                (id);
alter table personas             add constraint pers_fk_pais  foreign key (idpais)                references paises               (id);
alter table personas             add constraint pers_fk1_usua foreign key (idusuacrearegistro)    references usuarios             (id);
alter table personas             add constraint pers_fk2_usua foreign key (idusuamodifregistro)   references usuarios             (id);
alter table personas             add constraint pers_fk3_usua foreign key (idusuaborraregistro)   references usuarios             (id);

alter table programas            add constraint prog_fk_prog  foreign key (idprogpadre)           references programas            (id);

alter table usuarios             add constraint usua_fk_esre  foreign key (idesre)                references estados_registros    (id);
alter table usuarios             add constraint usua_fk1_usua foreign key (idusuacrearegistro)    references usuarios             (id);
alter table usuarios             add constraint usua_fk2_usua foreign key (idusuamodifregistro)   references usuarios             (id);
alter table usuarios             add constraint usua_fk3_usua foreign key (idusuaborraregistro)   references usuarios             (id);

alter table usuarios_perfiles    add constraint uspe_fk_usua  foreign key (idusua)                references usuarios             (id);
alter table usuarios_perfiles    add constraint uspe_fk_perf  foreign key (idperf)                references perfiles             (id);
alter table usuarios_perfiles    add constraint uspe_fk_grem  foreign key (idgrem)                references grupos_empresariales (id);
alter table usuarios_perfiles    add constraint uspe_fk_empr  foreign key (idempr)                references empresas             (id);
alter table usuarios_perfiles    add constraint uspe_fk_esre  foreign key (idesre)                references estados_registros    (id);
alter table usuarios_perfiles    add constraint uspe_fk1_usua foreign key (idusuacrearegistro)    references usuarios             (id);
alter table usuarios_perfiles    add constraint uspe_fk2_usua foreign key (idusuamodifregistro)   references usuarios             (id);
alter table usuarios_perfiles    add constraint uspe_fk3_usua foreign key (idusuaborraregistro)   references usuarios             (id);

alter table valores_paises       add constraint vapa_fk_pais  foreign key (idpais)                references paises               (id);

\q
