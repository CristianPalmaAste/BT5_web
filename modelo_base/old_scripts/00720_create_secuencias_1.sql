set client_min_messages to warning;

select 'create sequence grem_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from grupos_empresariales;
select 'create sequence empr_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from empresas;
select 'create sequence para_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from parametros;
select 'create sequence esge_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from estados_grem;
select 'create sequence rubr_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from rubros;
select 'create sequence esre_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from estados_registros;
select 'create sequence vapa_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from valores_paises;
select 'create sequence mone_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from monedas;
select 'create sequence pais_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from paises;
select 'create sequence pers_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from personas;
select 'create sequence perf_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from perfiles;
select 'create sequence esci_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from estados_civiles;
select 'create sequence sexo_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from sexos;
select 'create sequence prog_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from programas;
select 'create sequence usua_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from usuarios;
select 'create sequence uspe_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from usuarios_perfiles;
select 'create sequence pepr_seq start with ' || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from perfiles_programas;


\q
