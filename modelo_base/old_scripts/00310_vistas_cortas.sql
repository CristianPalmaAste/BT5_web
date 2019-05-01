set client_min_messages to warning;

create or replace view grem as select * from grupos_empresariales;
create or replace view empr as select * from empresas;
create or replace view para as select * from parametros;
create or replace view esge as select * from estados_grem;
create or replace view rubr as select * from rubros;
create or replace view esre as select * from estados_registros;
create or replace view vapa as select * from valores_paises;
create or replace view mone as select * from monedas;
create or replace view pais as select * from paises;
create or replace view pers as select * from personas;
create or replace view perf as select * from perfiles;
create or replace view esci as select * from estados_civiles;
create or replace view sexo as select * from sexos;
create or replace view prog as select * from programas;
create or replace view usua as select * from usuarios;
create or replace view uspe as select * from usuarios_perfiles;
create or replace view pepr as select * from perfiles_programas;


\q
