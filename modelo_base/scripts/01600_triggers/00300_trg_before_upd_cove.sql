create trigger trg_before_upd_cove before update on cotizaciones_ventas
for each row
execute procedure f_validar_cove()
;

\q

