grep "primary key" 00200_tablas.sql | \
awk '
BEGIN{
  printf "set client_min_messages to warning;\n\n"
}
{
  printf "drop sequence if exists %s_seq;\n", substr($6,1,4)
}
END{
  printf "\n\n\\q\n"
}' > 00710_drop_secuencias.sql

grep "primary key" 00200_tablas.sql | \
awk '
BEGIN{
  printf "set client_min_messages to warning;\n\n"
}
{
  printf "select XXXcreate sequence %s_seq start with XXX || (case when MAX(ID) is null then 0 else MAX(ID) end)+1 from %s;\n", substr($6,1,4), $3
}
END{
  printf "\n\n\\q\n"
}' > paso

sed "1,$ s/XXX/'/g" paso > 00720_create_secuencias_1.sql

\rm paso 2> /dev/null

psql -d erp_bt5 -U erp_bt5 < 00720_create_secuencias_1.sql > paso

grep "create sequence" paso | sed '1,$ s/^ //g' | sed '1,$ s/$/;/g' | awk '{print $0}END{printf "\n\\q\n"}' > 00730_create_secuencias_2.sql

psql -d erp_bt5 -U erp_bt5 < 00710_drop_secuencias.sql     >  00740_create_secuencias.txt
psql -d erp_bt5 -U erp_bt5 < 00730_create_secuencias_2.sql >> 00740_create_secuencias.txt
