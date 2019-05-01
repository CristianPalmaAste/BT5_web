create trigger trg_after_ins_empr after insert on empresas
for each row
execute procedure f_crear_datos_empresa()
;

\q

