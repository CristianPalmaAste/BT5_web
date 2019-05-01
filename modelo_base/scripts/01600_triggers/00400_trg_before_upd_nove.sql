create trigger trg_before_upd_nove before update on notas_ventas
for each row
execute procedure f_validar_nove()
;

\q

