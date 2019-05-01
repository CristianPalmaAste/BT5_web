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
            <i class="pe-7s-file"></i><h3>Mantención de Centros de Costo</h3>
         </div>
      </header>

      <div class="widget__content22">
         <label for="id" class="stacked-label" style="width:100px">Id</label>
         <?=$this->Form->text("id", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "id", "placeholder" => "Id", "readonly" => true, "style" => "width:584px"]);?>
         <?=$this->Form->hidden("idempr")?>
         <label for="nombre" class="stacked-label" style="width:100px">Nombre</label>
         <?=$this->Form->text("nombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "nombre", "placeholder" => "Nombre", "style" => "width:584px"]);?>

         <?= $this->Form->button(__('Guardar')) ?>
      </div>

   </article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>CentrosCostos/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
