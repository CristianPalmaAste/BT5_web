create trigger trg_before_upd_vent before update on ventas
for each row
execute procedure f_validar_vent()
;

\q

