grep "create table" 00200_tablas.sql | \
awk '
BEGIN{
  printf "set client_min_messages to warning;\n\n"
}
{
  printf "drop table if exists %-30s cascade;\n", $3
}
END{
  printf "\n\n\\q\n"
}' > 00110_drop_table.sql
