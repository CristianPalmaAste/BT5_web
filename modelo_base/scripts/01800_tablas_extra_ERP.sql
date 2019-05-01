set client_min_messages to warning;

drop table if exists tablas_secuencias cascade;
drop table if exists field_defs;
drop table if exists form_defs;

drop sequence if exists fode_seq;
drop sequence if exists fide_seq;

/*************************************************************************************************************************/

-- Tabla para asociar nombre de tablas con la secuencia que puebla su primary key
-- No pertenece al ERP en si

create table tablas_secuencias (
   tabla                    varchar(1000)   not null
  ,secuencia                varchar(1000)   not null
)
;

alter table tablas_secuencias add constraint tase_pk primary key (tabla, secuencia)
;

/*************************************************************************************************************************/

create table form_defs (
   id                       numeric(11)     not null
  ,caption                  varchar(50)     not null
  ,table_name               varchar(30)     not null
  ,ins_allowed              varchar(1)      not null
  ,upd_allowed              varchar(1)      not null
  ,del_allowed              varchar(1)      not null
)
;

alter table form_defs add constraint fode_pk primary key (id)
;

create sequence fode_seq
;

/*************************************************************************************************************************/

create table field_defs (
   id                       numeric(11)     not null
  ,form_id                  numeric(11)     not null
  ,forder                   numeric(11)     not null
  ,name                     varchar(30)     not null
  ,type                     varchar(10)     not null
  ,len                      numeric(11)     not null
  ,decim                    numeric(11)     not null
  ,pk                       varchar(1)      not null
  ,req                      varchar(1)      not null
  ,caption                  varchar(50)     not null
  ,gadget                   varchar(10)     not null
  ,size                     numeric(11)     not null
  ,maxlength                numeric(11)     not null
  ,rows                     numeric(11)     not null
  ,cols                     numeric(11)     not null
  ,selvalues                varchar(500)        null default null
  ,sqlvalues                varchar(500)        null default null
  ,visible                  varchar(1)      not null
  ,readonly                 varchar(1)      not null
  ,fld_type                 varchar(1)      not null
  ,fld_offset               numeric(11)     not null
)
;

alter table field_defs add constraint fide_pk primary key (id)
;

alter table field_defs add constraint fide_fk_fode foreign key (form_id) references form_defs (id)
;

create sequence fide_seq
;

\q
