create or replace function f_dv_rut_cl (varchar) returns char as
$$
declare
  suma    int := 0;
  factor  int := 2;
  rut_aux int := $1;
  dig     int;
  dv      int;
begin
  while(rut_aux > 0) loop
    dig := rut_aux % 10;
    if (factor = 8) then
      factor := 2;
    end if;
    suma    := suma + (dig * factor);
    rut_aux := rut_aux / 10;
    factor  := factor + 1;
  end loop;
  dv := 11 - (suma % 11);
  if    (dv = 10) then
    return 'K';
  elsif (dv = 11) then
    return 0;
  else
    return dv;
  end if;
end;
$$ LANGUAGE plpgsql;

select f_dv_rut_cl('10917721');
select f_dv_rut_cl('13047104');
select f_dv_rut_cl('4709176' );
select f_dv_rut_cl('21878885');
select f_dv_rut_cl('8643038' );

