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
            <i class="pe-7s-file"></i><h3>usuarios_perfiles</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "id", "placeholder" => "id", 'placeholder' => 'id*']);?>
         <label for="idusua" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idusua", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idusua", "placeholder" => "idusua", 'placeholder' => 'idusua*']);?>
         <label for="idperf" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idperf", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idperf", "placeholder" => "idperf", 'placeholder' => 'idperf*']);?>
         <label for="idgrem" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idgrem", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idgrem", "placeholder" => "idgrem", 'placeholder' => 'idgrem']);?>
         <label for="idempr" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idempr", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idempr", "placeholder" => "idempr", 'placeholder' => 'idempr']);?>
         <label for="idesre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idesre", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idesre", "placeholder" => "idesre", 'placeholder' => 'idesre*']);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>UsuariosPerfiles/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
