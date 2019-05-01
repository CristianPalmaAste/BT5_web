egrep "create table|primary key" 00200_tablas.sql                      | \
awk '{
  if ($1 == "create"){
    Vtabla = "XXX" $3 "XXX"
    printf "insert into tablas_secuencias values (%-35s, ",Vtabla
  }
  else{
    printf "XXX%s_seqXXX);\n",substr($6,1,4)
  }
}'                                                                     | \
sed "1,$ s/XXX/'/g"                                                    | \
grep -v "^'de_seq');"                                                  | \
grep -v tase_seq                                                       > 01910_poblar_tase.sql
