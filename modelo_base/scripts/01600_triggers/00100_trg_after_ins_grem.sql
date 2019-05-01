create trigger trg_after_ins_grem after insert on grupos_empresariales
for each row
execute procedure f_crear_datos_holding()
;

\q

