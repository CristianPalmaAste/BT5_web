create trigger trg_after_upd_vent after update on ventas
for each row
execute procedure f_rebajar_stock()
;

\q

