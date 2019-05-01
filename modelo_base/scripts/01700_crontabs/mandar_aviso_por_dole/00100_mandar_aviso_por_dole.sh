clear

. /home/cpalma/git/bt5/BT5/00300_erp_bt5/.config_pruebas_bt5

\rm /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/arch_*.txt 2> /dev/null

psql -d $DBNAME -U $USUARIO_DB  < /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/00200_ejecutar_f_mandar_aviso_por_dole.sql \
                                > /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/00210_ejecutar_f_mandar_aviso_por_dole.txt \
                               2> /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/00220_ejecutar_f_mandar_aviso_por_dole.txt

grep "^YYYYY_" /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/00220_ejecutar_f_mandar_aviso_por_dole.txt | \
awk '
BEGIN{
  nro_arch = 0
}
{
  if (substr($0,7,2) == "10"){
    nro_arch = nro_arch + 1
    printf "mail -s XXX%sXXX ",substr($0,9,1000)
  }
  else{
    if (substr($0,7,2) == "20"){
    printf "%s < /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/arch_%d.txt",substr($0,9,1000),nro_arch
    }
    else{
      printf "\n"
    }
  }
}' | sed '1,$ s/XXX/"/g' > /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/00400_mandar_mails.sh

grep "^YYYYY_" /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/00220_ejecutar_f_mandar_aviso_por_dole.txt | \
awk '
BEGIN{
  nro_arch = 0
}
{
  if (substr($0,7,2) == "30"){
    nro_arch = nro_arch + 1
    printf "echo XXX%sXXX         >  /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/arch_%d.txt\n",substr($0,9,1000),nro_arch
    printf "echo XXX XXX          >> /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/arch_%d.txt\n",nro_arch
    printf "echo XXXAtte.,XXX     >> /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/arch_%d.txt\n",nro_arch
    printf "echo XXXGestio ERPXXX >> /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/arch_%d.txt\n",nro_arch
  }
}' | sed '1,$ s/XXX/"/g' > /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/00300_generar_archs,sh

chmod 755 /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/00300_generar_archs,sh

chmod 755 /home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/00400_mandar_mails.sh

/home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/00300_generar_archs,sh

/home/cpalma/git/bt5/BT5/00300_erp_bt5/01700_crontabs/mandar_aviso_por_dole/00400_mandar_mails.sh
