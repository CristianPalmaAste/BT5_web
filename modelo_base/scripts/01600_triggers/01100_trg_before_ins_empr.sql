create trigger trg_before_ins_empr before insert on empresas
for each row
execute procedure f_completar_rubro_empresa()
;

\q

