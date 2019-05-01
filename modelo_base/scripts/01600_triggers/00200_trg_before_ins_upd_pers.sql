create trigger trg_before_ins_upd_pers before insert or update on personas
for each row
execute procedure f_validar_dv_pers()
;

\q

