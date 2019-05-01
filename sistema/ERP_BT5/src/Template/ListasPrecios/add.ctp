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

 
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Listas de Precios</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id", ["id" => "id"])?>
</td></tr>
         <?=$this->Form->hidden("idempr", ["id" => "idempr"])?>
</td></tr>
<tr><td><label for='correlativo' >Correlativo**</label></td><td><?=$this->Form->text("correlativo", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "correlativo", 'placeholder' => 'Correlativo*', 'style' => 'color:black;']);?>
</td></tr>
<tr><td><label for='fechainicio' >Fecha Inicio**</label></td><td><?=$this->Form->text("fechainicio", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fechainicio", 'placeholder' => 'Fecha Inicio*', 'style' => 'color:black;']);?>
</td></tr>
<tr><td><label for='fechafin' >Fecha Fin*</label></td><td><?=$this->Form->text("fechafin", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fechafin", 'placeholder' => 'Fecha Fin', 'style' => 'color:black;']);?>
</td></tr>
<tr><td><label for='observaciones' >Observaciones**</label></td><td><?=$this->Form->text("observaciones", ["size" => 10, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "observaciones", 'placeholder' => 'Observaciones*', 'style' => 'color:black;']);?>
</td></tr>
<tr><td><label for='idesre' >Estado**</label></td><td><?=$this->Form->text("idesre", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idesre", 'placeholder' => 'Estado*', 'style' => 'color:black;']);?>
</td></tr>
<tr><td colspan='2' align='center'><?php echo $grilla;?></td></tr>
<input type='hidden' id='nRow' value='<?=$nRow?>'/>
<input type='hidden' id='currentRow'/>
<input type='hidden' id='allRows' name='allRows'/>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>ListasPrecios/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
  document.getElementById('frm').onsubmit=function() {
	  tbl = document.getElementById('mitabla');
	  
	  total = document.getElementById('total').value;
	  
	  if (total*1.0 <=0) {
		 alert('¡Debe ingresar algún producto en el documento!');
		 return false;
	  }
	  
	  allRows='';
	  
	  for (i=2; i < tbl.rows.length; i++) {
		 if (allRows!='') allRows = allRows + '@@@';
		 
		 allRows = allRows + document.getElementById('data'+i).value;		 		  
	  }
	  
	  document.getElementById('allRows').value = allRows;
		  
	  
	  return true;
   }
      
<?php echo $extrajs;?></script>
