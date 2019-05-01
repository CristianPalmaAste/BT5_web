create trigger trg_after_upd_cove after update on cotizaciones_ventas
for each row
execute procedure f_copiar_cove_a_nove()
;

\q

