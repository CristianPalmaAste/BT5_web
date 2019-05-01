<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class GenerasController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $conn = ConnectionManager::get('default');

        $sql = "SELECT table_name ".
               "FROM information_schema.tables ".
               "WHERE table_type = 'BASE TABLE' ".
               "AND table_schema NOT IN ('pg_catalog', 'information_schema') ".
               "order by table_name";

         $stmt = $conn->execute($sql);

         $results = $stmt ->fetchAll('assoc');

        //print_r($results);

        $this->set("tablas", $results); 
    }

    public function genApp($tbl_name) {

        $controlFields=array('idusuacrearegistro',
        'fechacrearegistro',
        'idusuamodifregistro',
        'fechamodifregistro',
        'idusuaborraregistro',
        'fechaborraregistro');

        $e = explode("_", $tbl_name);

        $v = "";
        foreach($e as $ee)
           $v .= ucfirst(strtolower($ee));

        $conn = ConnectionManager::get('default');

        $sql = "SELECT count(*) cuenta ".
               "FROM information_schema.columns ".
               "WHERE table_schema = ('public')  ".
               "and   column_name='idusuacrearegistro' ".
               "and   table_name not like 'pg_%' ".
               "and   table_name in ('$tbl_name') ".
               "and   udt_catalog = 'erp_bt5' ";

        $stmt = $conn->execute($sql);

        $results = $stmt ->fetchAll('assoc');

        if ($results[0]["cuenta"] > 0)
           $hay_idusuacrearegistro=true;
        else
           $hay_idusuacrearegistro=false;


        $sql = "select * from field_defs where form_id = (select id from form_defs where table_name='$tbl_name') order by forder";

         $stmt = $conn->execute($sql);

         $results = $stmt ->fetchAll('assoc');

        //print_r($results);

        $path = "/var/www/html/erpbt5/sistema/ERP_BT5/src/workshop";

        $path2 = "/var/www/html/erpbt5/sistema/ERP_BT5/src"; 

        $f = file($path."/Pattern/controller.lay");

        //print_r($f);

        $hay_idgrem=false;
        $hay_idempr=false;
        

        $ss = "";
        foreach($results as $r) {
           $name = $r["name"];
           $data_type = $r["type"];

           if ($name=="idgrem") $hay_idgrem = true;

           if ($name=="idempr") $hay_idempr = true;

           if ($name=="idusuacrearegistro") $hay_idusuacrearegistro = true;

           if (!in_array($name, $controlFields)) {
              $ss .= "if (\$gre->$name!=null)";

              if ($data_type=="numeric")
                 $ss .= " \$cond[\"$name\"] = \$gre->$name;\n"; 
              else
                 $ss .= " \$cond[\"$name like\"] = \$gre->$name.\"%\";\n";
           }
        }

        $lista="";
 
        if ($hay_idgrem) $lista .= " \$cond['idgrem']=\$session->read('idgrem');\n";

        if ($hay_idempr) $lista .= "\$cond['idempr']=\$session->read('idempr');\n";

        if ($hay_idusuacrearegistro) $lista .= "         \$cond['idusuacrearegistro is']=null;\n"; 

        $tbl  = TableRegistry::get('TablasSecuencias');

        $rseq = $tbl->find('all')->where(["tabla" => $tbl_name]);

        foreach($rseq as $seq)
           $sequence = $seq["secuencia"];
         
        $cols="";
        $col_values="";
        $datos_excel="";
        $letra="A";

        foreach($results as $r) {
          $name = $r["name"];
          $caption = $r["caption"];
          $gadget = $r["gadget"];

          //echo "Gadget: $gadget<br/>";

          if (!in_array($name, $controlFields) && $gadget!="hidden") {
             if ($cols!="") $cols .= ",";
 
             
             $cols .= "'$caption'";

             $letter = $letra;
             $letra2 = $letra."1";
             $col_values  .= "->setCellValue('$letra2', '$caption')\n";
             $datos_excel .= "->setCellValue(\"$letter\$n\", \$r->$name)\n";
            
             $letra = chr(ord($letra)+1); 
             
          }
        }

        for($i=0; $i < count($f); $i++) {
           $f[$i] = str_replace('{{controller}}', $v, $f[$i]);
           $f[$i] = str_replace('{{fields}}',     $ss, $f[$i]);
           $f[$i] = str_replace('{{sequence}}',   $sequence, $f[$i]);
           $f[$i] = str_replace('{{headdings}}',  $cols, $f[$i]);
           $f[$i] = str_replace('{{columnas_excel}}', $col_values, $f[$i]);
           $f[$i] = str_replace('{{table_name}}', $tbl_name, $f[$i]);
           $f[$i] = str_replace('{{datos_excel}}', $datos_excel, $f[$i]);

           if ($hay_idusuacrearegistro) {
              $f[$i] = str_replace('{{audi}}', "", $f[$i]); 
           }
           else {
              $f[$i] = str_replace('{{audi}}', '//', $f[$i]); 
           }

           if ($hay_idgrem)
              $f[$i] = str_replace('{{idgrem}}', '', $f[$i]); 
           else
              $f[$i] = str_replace('{{idgrem}}', '//', $f[$i]); 

           if ($hay_idempr)
              $f[$i] = str_replace('{{idempr}}', '', $f[$i]); 
           else
              $f[$i] = str_replace('{{idempr}}', '//', $f[$i]); 

           $f[$i] = str_replace('{{cond}}', $lista, $f[$i]);

           if ($hay_idgrem) 
              $f[$i] = str_replace('{{where_excel}}', "->where(['idgrem' => \$session->read('idgrem')])", $f[$i]);
           else if ($hay_idempr) 
              $f[$i] = str_replace('{{where_excel}}', "->where(['idempr' => \$session->read('idempr')])", $f[$i]);     
           else
              $f[$i] = str_replace('{{where_excel}}', "", $f[$i]);
        }

        $file = $path2."/Controller/".$v."Controller.php";

        echo "Generando: $file<hr/>";

        //foreach($f as $linea) {
        //   echo $linea;
        //}

        if (!is_file($file)) {
           echo "Voy a escribir controlador<hr/>";

           $fd = fopen($file, "w");

           foreach($f as $linea) {
              fputs($fd, $linea);
           }

           fclose($fd);
        }

        
        $tbl  = TableRegistry::get('FormDefs');

        $rseq = $tbl->find('all')->where(["table_name" => $tbl_name]);

        $form_caption="NONAME";
        foreach($rseq as $seq)
           $form_caption = $seq["caption"];

        //index.ctp
 
        //echo "index.ctp<hr/>";

        $s = "<?=\$this->Form->create(\$gre, [\"class\" => \"form-horizontal\", 'url' => '/$v/index', 'novalidate' => true]);?>\n".
             "<?php echo \$this->BForm->formHeader( '$form_caption' ); ?>\n".
             "\n".
             "<div class=\"col-md-4 text-center btn-vars__showcase\">\n".
             "   <div class=\"btn-group block\">\n".
             "      <a href=\"<?=\$this->request->webroot?>$v/add\" title='Nuevo registro' class=\"btn dark\"><i class=\"pe-7s-plus\"></i>&nbsp; Nuevo</a>\n".
             "   </div>\n".
             "</div>\n".
             "<?php echo \$this->BForm->initForm( '$form_caption',array(\n";

       foreach($results as $r) {
          $name = $r["name"];
          $caption = $r["caption"];
          $gadget = $r["gadget"];

          //echo "Gadget: $gadget<br/>";

          if (!in_array($name, $controlFields) && $gadget!="hidden")
             $s.= "        \$this->Paginator->sort('$name', '$caption'),\n";
       }

       $s .= "            'Acciones'\n".
             "            )\n".
             "            );\n".
             "?>\n";

       $s.= "<!--<tr>\n";
       foreach($results as $r) {
          //print_r($r);

          $name = $r["name"];
          $size = $r["len"];
          $maxlength = $r["maxlength"];
          $gadget = $r["gadget"];  

          if ($size=="") $size=5;

          if ($size>20) $size=20;

          if (!in_array($name, $controlFields) && $gadget!="hidden") {
             $s .= "<td><?=\$this->Form->text(\"$name\", [\"size\" => $size, \"maxlength\" => $maxlength, \"class\" => \"stacked-input upper\", \"id\" => \"$name\"]);?></td>\n";
             
          }
          
       }

       $s .= "<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=\$this->Html->link('Limpiar', ['action' => 'index'])?></td>\n";
       $s.= "</tr>-->\n";
       $s.= "<?php foreach(\$registros as \$g):?>\n".
            "\n".
            "      <tr>\n";

       foreach($results as $r) {
          $name = $r["name"];
          $gadget = $r["gadget"];

          if (!in_array($name, $controlFields) && $gadget!="hidden")
             $s.= "         <td><?=h(\$g->$name)?></td>\n";
       }

       //echo "Voy a completar<hr/>";

       $s.= "         <td align='center'>\n".
            "            <?= \$this->Html->link('<i class=\"pe-7s-look\"></i>', ['action' => 'view', \$g->id],array('escape' => false, 'title' => 'Ver')) ?>\n".
            "            <?= \$this->Html->link('<i class=\"pe-7s-note\"></i>', ['action' => 'edit', \$g->id],array('escape' => false, 'title' => 'Editar')) ?>\n".
            "            <?= \$this->Form->postLink('<i class=\"pe-7f-trash\"></i>',\n".
            "                                       ['action' => 'delete',\$g->id,],\n".
            "                                       ['confirm' => __('¿Está seguro que desea eliminar el documento ID {0}?', \$g->id),'escape' => false, 'title' => 'Eliminar']\n".
            "                                      )?>\n".
            "         </td>\n". 
            "     </tr>\n".
            "     <tr class='spacer'></tr>\n".
            "<?php endforeach; ?>\n".
            "\n".
            "<?php echo \$this->BForm->closeForm(); ?>\n";
       

       $s   .= "<div class=\"paginator\">\n".
               "   <ul class=\"pagination\">\n".
               "      <?= \$this->Paginator->first('<< ' . __('Primero')) ?>\n".
               "      <?= \$this->Paginator->prev('< ' . __('Anterior')) ?>\n".
               "      <?= \$this->Paginator->numbers() ?>\n".
               "      <?= \$this->Paginator->next(__('Siguiente') . ' >') ?>\n".
               "      <?= \$this->Paginator->last(__('Último') . ' >>') ?>\n".
               "    </ul>\n".
               "<p><?=\$this->Paginator->counter('Página {{page}} de {{pages}}') ?></p>\n".
               "<?php echo \$this->Html->image(\"excel.png\", [\n".
               "                       \"alt\" => \"Bajada a excel\",\n".
               "                       'url' => ['action' => 'excel']\n".
               "                       ]);\n".
               "?>\n".
               "</div>\n".
               "<?=\$this->Form->end();?>\n";



       if (!is_dir($path2."/Template/".$v)) mkdir($path2."/Template/".$v);

       $file = $path2."/Template/".$v."/index.ctp";

       echo "Generando: $file<hr/>";

       if (!is_file($file)) {
          $fd = fopen($file, "w");

          fputs($fd, $s);

          fclose($fd);
       }


       //edit.ctp

       $s  = "<?= \$this->Form->create(\$gre) ?>\n".
             " \n".
             "<?php if (count(\$errors) > 0) {\n".
             "?>\n".
             "<div class=\"row\" style=\"padding-bottom:5px;\">\n".
             "   <div class=\"col-sm-9\">\n".
             "   <div class=\"panel panel-danger\">\n".
             "      <div class=\"panel-heading\">Errores</div>\n".
             "\n".
             "<?php\n".
             "\n".
             "   foreach(\$errors as \$key => \$arr)\n".
             "      foreach(\$arr as \$k => \$v)\n".
             "          echo \"<div class='panel-body'>\$v</div>\";\n".
             "?>\n".
             "      </div>\n".
             "    <div>\n".
             "</div>\n".
             "<?php      }\n".
             "?>\n".
             "\n".
             " \n".
             "<div class=\"col-md-8\">\n".
             "   <article class=\"widget widget__form\">\n".
             "      <header class=\"widget__header\">\n".
             "         <div class=\"widget__title\">\n".
             "            <i class=\"pe-7s-file\"></i><h3>$form_caption</h3>\n".
             "         </div>\n".
             "      </header>\n".
             "\n".
             "      <div class=\"widget__content\">\n";

             foreach($results as $r) {
                //print_r($r);

                $name = $r["name"];
                $size = $r["length"];
                $maxlength = $r["maxlength"];
                $caption = $r["caption"];
                $gadget=$r["gadget"];

                if ($size=="") $size=10;

                if (!in_array($name, $controlFields)) {
                   if ($gadget=="hidden")
                   $s .= "         <?=\$this->Form->hidden(\"$name\")?>\n";
                   else
                   $s .= "         <label for=\"$name\" class=\"stacked-label\"><i class=\"pe-7s-hammer\" ></i></label>\n".
                         "         <?=\$this->Form->text(\"$name\", [\"size\" => $size, \"maxlength\" => $maxlength, \"class\" => \"stacked-input upper\", \"id\" => \"$name\", \"placeholder\" => \"$name\", 'placeholder' => '$caption']);?>\n";
                }
             }

             $s .= "\n".      
             "<?= \$this->Form->button(__('Guardar')) ?>\n".
             "</div>\n".
             "\n".
             "</article>\n".
             "</div>\n".
             "\n".
             "<?= \$this->Form->end() ?>\n".
             "\n".
             "<div class=\"col-md-6 text-center btn-vars__showcase\">\n".
             "<div class=\"btn-group block\">\n".
             "<a href=\"<?=\$this->request->webroot?>$v/index\" class=\"btn dark inverse\">Volver</a>\n".
             "</div>\n".
             "</div>\n".
             "\n".
             "<script language=\"javascript\">\n".
             "\$(\"#nombre\").focus();\n".
             "</script>\n";

      $file = $path2."/Template/".$v."/edit.ctp";

      echo "Generando: $file<hr/>";

      if (!is_file($file)) {
         $fd = fopen($file, "w");

         fputs($fd, $s);

         fclose($fd);
      }

      //edit.ctp

       $s  = "<?= \$this->Form->create(\$gre) ?>\n".
             "<div class=\"col-md-8\">\n".
             "   <article class=\"widget widget__form\">\n".
             "      <header class=\"widget__header\">\n".
             "         <div class=\"widget__title\">\n".
             "            <i class=\"pe-7s-file\"></i><h3>$form_caption</h3>\n".
             "         </div>\n".
             "      </header>\n".
             "\n".
             "      <div class=\"widget__content\">\n";

             foreach($results as $r) {
                //print_r($r);

                $name = $r["name"];
                $size = $r["len"];
                $maxlength=$r["maxlength"];
                $caption=$r["caption"];
                $gadget = $r["gadget"];

                if ($size=="") $size=10;

                if (!in_array($name, $controlFields)) {
                   if ($gadget=="hidden") 
                   $s .= "         <?=\$this->Form->hidden(\"$name\")?>\n";
                 
                   else
                   $s .= "         <label for=\"$name\" class=\"stacked-label\"><i class=\"pe-7s-hammer\" ></i></label>\n".
                         "         <?=\$this->Form->text(\"$name\", [\"size\" => $size, \"maxlength\" => $size, \"class\" => \"stacked-input\", \"id\" => \"$name\", \"readonly\" => true, 'placeholder' => '$caption']);?>\n";
                }
             }

             $s .= "\n".      
             "</div>\n".
             "\n".
             "</article>\n".
             "</div>\n".
             "\n".
             "<?= \$this->Form->end() ?>\n".
             "\n".
             "<div class=\"col-md-6 text-center btn-vars__showcase\">\n".
             "<div class=\"btn-group block\">\n".
             "<a href=\"<?=\$this->request->webroot?>$v/index\" class=\"btn dark inverse\">Volver</a>\n".
             "</div>\n".
             "</div>\n".
             "\n";

      $file = $path2."/Template/".$v."/view.ctp";

      echo "Generando: $file<hr/>";

      if (!is_file($file)) {
         $fd = fopen($file, "w");

         fputs($fd, $s);

         fclose($fd);
      }


      $fd = fopen($path2."/Template/".$v."/excel.ctp", "w");
      fclose($fd);

      //Table
      $s = "<?php\n";
      $s.= "namespace App\Model\Table;\n";
      $s.= "\n";
      $s.= "use Cake\ORM\Table;\n";
      $s.= "use Cake\ORM\RulesChecker;\n";
      $s.= "use Cake\Validation\Validator;\n";
      $s.= "\n";
      $s.= "class ".$v."Table extends Table\n";
      $s.= "{\n";
      $s.= "    public function initialize(array \$config)\n";
      $s.= "    {\n";
      $s.= "       \n";
      $s.= "    }\n";
      $s.= "\n";
      $s.= "    public function validationDefault(Validator \$validator)\n";
      $s.= "    {\n";
      $s.= "        \$validator\n";
      foreach($results as $r) {
         $name = $r["name"];
         $caption = $r["caption"];

         if (!in_array($name, $controlFields)) { 
            $s.= "        ->requirePresence(\"$name\")\n";
            $s.= "        ->notEmpty(\"$name\", \"'$caption': debe ingresar un valor en este campo.\")\n";
         }
      }

      $s.= "        ;\n";
      $s.= "\n";
      $s.= "        return \$validator;\n";
      $s.= "    }\n";

      $sql = "select i.relname as index_name,
                     a.attname as column_name
              from
                     pg_class t,
                     pg_class i,
                     pg_index ix,
                     pg_attribute a
              where
                     t.oid = ix.indrelid
                     and i.oid = ix.indexrelid
                     and a.attrelid = t.oid
                     and a.attnum = ANY(ix.indkey)
                     and t.relkind = 'r'
                     and t.relname like '$tbl_name'
              order by
                     t.relname,
                     i.relname";

      

      $stmt = $conn->execute($sql);

      $results = $stmt ->fetchAll('assoc');

      $s .= "\n    public function buildRules(RulesChecker \$rules) {\n";

      $d=[];
      foreach($results as $r)
         $d[$r["index_name"]][] = $r["column_name"]; 

      //print_r($d);
      foreach($d as $key => $arr) {
         $lista="";
         foreach($arr as $ar) {
            if ($lista!="") $lista .= ",";

            $lista .= "'".$ar."'";
         }

         $s .= "        \$rules->add(\$rules->isUnique([$lista], 'Rut ya ha sido usado.'));\n"; 
      }

      $s.= "\n        return \$rules;\n";
      $s.= "    }\n";
      $s.= "}\n";

      $file = $path2."/Model/Table/".$v."Table.php";

      echo "Generando Table: $file<hr/>";

      //echo $s;

      if (!is_file($file)) {
         $fd = fopen($file, "w");
         fputs($fd, $s);
         fclose($fd);
      }

    }   
}
