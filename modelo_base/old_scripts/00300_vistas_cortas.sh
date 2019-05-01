grep "primary" 00200_tablas.sql | \
awk '
BEGIN{
  printf "set client_min_messages to warning;\n\n"
}
{
  printf "create or replace view %s as select * from %s;\n", substr($6,1,4), $3
}
END{
  printf "\n\n\\q\n"
}' > 00310_vistas_cortas.sql
