create or replace function f_limpia(varchar) returns char as
$$
declare
  Ventrada varchar(1000);
  Vsalida  varchar(1000);
begin
  Ventrada := $1;
  Vsalida  := replace(
              replace(
              replace(
              replace(
              replace(
              replace(
              replace(
              replace(
              replace(
              replace(
              replace(
              replace(Ventrada, 'á', 'a')
                              , 'é', 'e')
                              , 'í', 'i')
                              , 'ó', 'o')
                              , 'ú', 'u')
                              , 'Á', 'A')
                              , 'É', 'E')
                              , 'Í', 'I')
                              , 'Ó', 'O')
                              , 'Ú', 'U')
                              , 'ñ', 'n')
                              , 'Ñ', 'Ñ')
              ;
  return(Vsalida);
end;
$$ LANGUAGE plpgsql;

select f_limpia('hola');
select f_limpia('CHAO');
select f_limpia('áéíóú');
select f_limpia('ÁÉÍÓÚ');

