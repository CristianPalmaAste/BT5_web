create trigger trg_before_ins_nove before insert on notas_ventas
for each row
execute procedure f_validar_nove_ins()
;

\q

