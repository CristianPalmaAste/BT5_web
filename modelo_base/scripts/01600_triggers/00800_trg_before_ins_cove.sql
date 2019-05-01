create trigger trg_before_ins_cove before insert on cotizaciones_ventas
for each row
execute procedure f_validar_cove_ins()
;

\q

