create trigger trg_after_ins_upd_delp after insert or update on detalles_listas_precios
for each row
execute procedure f_registrar_precio_bitacora()
;

\q

