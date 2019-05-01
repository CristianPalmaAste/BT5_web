<?= $this->Form->create($gre) ?>
 
<?php if (count($errors) > 0) {
?>
<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-9">
   <div class="panel panel-danger">
      <div class="panel-heading">Errores</div>

<?php

   foreach($errors as $key => $arr)
      foreach($arr as $k => $v)
          echo "<div class='panel-body'>$v</div>";
?>
      </div>
    <div>
</div>
<?php      }
?>

 <?php $gadgets= array("" => "", "input" => "input", "area" => "area", "select" => "select", "hidden" => "hidden");?> 

<div class="col-md-9">

    <h3>Definición de Formularios</h3>
 
   <table>
   <tr><td>Título</td><td><?=$this->Form->text("caption", ["size" => 50, "maxlength" => 50, "class" => "form-control", "id" => "caption", "placeholder" => "Título formulario"]);?></td></tr>
   <tr><td>Tabla</td><td><?=$this->Form->text("table_name", ["size" => 30, "maxlength" => 30, "class" => "form-control", "id" => "table_name", "placeholder" => "Nombre tabla", "readonly" => true]);?></td></tr>
   </table>


                    <table style="border:1px solid black;">
                        <tr><td>Etiqueta</td>
                            <td>Nombre</td>
                            <td>Gadget</td> 
                            <td>Size</td> 
                            <td>Mlength</td> 
                            <td>Rows</td>
                            <td>Cols</td>  
                            <td>Requerido</td>
                            <td>Readonly</td>
                            <td>Default</td>
                            <td>Dominio</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <?php $n=0;?>
                        <?php foreach($rows as $r): ?>
                  <tr><td><?=$this->Form->hidden("recno$n",  ["value" => $n]);?>
                          <?=$this->Form->hidden("id$n",     ["value" => $r->id, "id" => "id$n"]);?>
                          <?=$this->Form->hidden("forder$n", ["value" => $r->forder, "id" => "forder$n"]);?>
                            <?=$this->Form->text("caption$n", ["size" => 20, "maxlength" => 50, "class" => "form-control", "id" => "caption$n", "placeholder" => "Etiqueta", "value" => $r->caption]);?></td>
                            <td><?=$this->Form->text("name$n", ["size" => 20, "maxlength" => 50, "class" => "form-control", "id" => "name$n", "placeholder" => "Nombre", "value" => $r->name, "readonly" => true]);?></td>

                           
                            <td><?=$this->Form->select("gadget$n", $gadgets, ["class" => "form-control", "id" => "gadget$n", "value" => $r->gadget]);?></td>

                            <td><?=$this->Form->text("size$n", ["size" => 3, "maxlength" => 3, "class" => "form-control", "id" => "size$n", "placeholder" => "Size",    "value" => $r->size]);?></td>
                            <td><?=$this->Form->text("maxlength$n", ["size" => 3, "maxlength" => 3, "class" => "form-control", "id" => "maxlength$n", "placeholder" => "Maxlength",    "value" => $r->maxlength]);?></td>
                            <td><?=$this->Form->text("rows$n", ["size" => 3, "maxlength" => 3, "class" => "form-control", "id" => "rows$n", "placeholder" => "Rows",    "value" => $r->rows]);?></td>
                            <td><?=$this->Form->text("cols$n", ["size" => 3, "maxlength" => 3, "class" => "form-control", "id" => "cols$n", "placeholder" => "Cols",    "value" => $r->cols]);?></td>
                            <td><?php

                                if ($r->req=="N")
                                   echo $this->Form->select("req$n", ["Y"=>"Si", "N"=>"No"], ["class" => "form-control", "id" => "req$n", "placeholder" => "Req",    "value" => $r->req]);
                                else
                                   echo $this->Form->text("req$n", ["size" => 3, "class" => "form-control", "id" => "req$n", "placeholder" => "Req",    "value" => $r->req, "readonly" => true]);

                                ?></td>

                           <td><?=$this->Form->select("readonly$n", ["Y"=>"Si", "N"=>"No"], ["class" => "form-control", "id" => "readonly$n", "value" => $r->readonly]);?></td>
                           <td><?=$this->Form->text("default$n", ["size" => 25, "maxlength" => 250, "class" => "form-control", "id" => "default$n", "placeholder" => "Default",    "value" => $r->default]);?></td>
                           <td><?=$this->Form->select("selvalues$n", [], ["class" => "form-control", "id" => "selvalues$n", "value" => $r->selvalues]);?></td>

                           <td><a href="javascript:cmd_up(<?=$n?>);">Up</a></td>
                           <td><a href="javascript:cmd_down(<?=$n?>);">Down</a></td>
                        </tr>
                       
                        <?php $n++; ?>
                        <?php endforeach;?>
                        <tr><td><?= $this->Html->link('Nuevo campo', ['action' => 'newFld', $gre->id],array('escape' => false, 'title' => 'Nuevo Campo')) ?></td>
                            <td><?= $this->Form->button(__('Guardar'), ["class" => "form-control"]) ?></td></tr>
                  </table>
                 

<?=$this->Form->hidden("nrows", ["value" => $n, "id" => "nrows"])?>
<?=$this->Form->hidden("id")?>
<?=$this->Form->hidden("ins_allowed")?>
<?=$this->Form->hidden("upd_allowed")?>
<?=$this->Form->hidden("del_allowed")?>

<?= $this->Form->end() ?>
</div>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>FormDefs/index" class="btn dark inverse">Volver</a>
</div>
</div>


<script language="javascript">
   var campos = ["id", "caption", "name", "gadget", "size", "maxlength", "rows", "cols", "req", "selvalues", "readonly", "default"];

   function getval(id) {
      return document.getElementById(id).value;
   }

   function setval(id, val) {
      document.getElementById(id).value=val;
   }

   function cmd_up(n) {
      //alert("cmd_up");

      if (n > 0) {
         id         = getval("id"+n);
         caption    = getval("caption"+n);
         name       = getval("name"+n);
         gadget     = getval("gadget"+n);
         size       = getval("size"+n);
         maxlength  = getval("maxlength"+n);
         rows       = getval("rows"+n);
         cols       = getval("cols"+n);
         req        = getval("req"+n);
         selvalues  = getval("selvalues"+n);
         readonly   = getval("readonly"+n);
         default    = getval("default"+n);

         //alert("Valores seleccionados!"); 

         k = n -1;

         for(i=0; i < campos.length; i++) {
            nombre = campos[i];

            //alert(nombre+n);

            document.getElementById(nombre+n).value = document.getElementById(nombre+k).value;
         } 

         n = k;
         setval("id"+n, id);
         setval("caption"+n,caption);
         setval("name"+n,name);
         setval("gadget"+n,gadget);
         setval("size"+n,size);
         setval("maxlength"+n,maxlength);
         setval("rows"+n,rows);
         setval("cols"+n,cols);
         setval("req"+n,req);
         setval("selvalues"+n,selvalues);
         setval("readonly"+n,readonly);
         setval("default"+n,default);
      }
   }

   function cmd_down(n) {
      //alert("cmd_up");
         
      nrows = getval("nrows");

      if (n < nrows - 1) {
         id         = getval("id"+n);
         caption    = getval("caption"+n);
         name       = getval("name"+n);
         gadget     = getval("gadget"+n);
         size       = getval("size"+n);
         maxlength  = getval("maxlength"+n);
         rows       = getval("rows"+n);
         cols       = getval("cols"+n);
         req        = getval("req"+n);
         selvalues  = getval("selvalues"+n);
         readonly   = getval("readonly"+n);
         default    = getval("default"+n);

         //alert("Valores seleccionados!"); 

         k = n + 1;

         for(i=0; i < campos.length; i++) {
            nombre = campos[i];

            //alert(nombre+n);

            document.getElementById(nombre+n).value = document.getElementById(nombre+k).value;
         } 

         n = k;
         setval("id"+n, id);
         setval("caption"+n,caption);
         setval("name"+n,name);
         setval("gadget"+n,gadget);
         setval("size"+n,size);
         setval("maxlength"+n,maxlength);
         setval("rows"+n,rows);
         setval("cols"+n,cols);
         setval("req"+n,req);
         setval("selvalues"+n,selvalues);
         setval("readonly"+n,readonly);
         setval("default"+n,default);
      }
   }
</script>
