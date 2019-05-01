create trigger trg_before_ins_vent before insert on ventas
for each row
execute procedure f_validar_vent_ins()
;

\q

