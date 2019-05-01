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
            <i class="pe-7s-file"></i><h3>empresas</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "id", "placeholder" => "id"]);?>
         <label for="idgrem" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idgrem", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "idgrem", "placeholder" => "idgrem"]);?>
         <label for="idpais" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idpais", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "idpais", "placeholder" => "idpais"]);?>
         <label for="idrubr" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idrubr", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "idrubr", "placeholder" => "idrubr"]);?>
         <label for="idesre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idesre", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "idesre", "placeholder" => "idesre"]);?>
         <label for="identificador1" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador1", ["size" => 50, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador1", "placeholder" => "identificador1"]);?>
         <label for="identificador2" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador2", ["size" => 50, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador2", "placeholder" => "identificador2"]);?>
         <label for="razonsocial" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("razonsocial", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "razonsocial", "placeholder" => "razonsocial"]);?>
         <label for="nombrefantasia" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombrefantasia", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "nombrefantasia", "placeholder" => "nombrefantasia"]);?>
         <label for="icono" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("icono", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "icono", "placeholder" => "icono"]);?>
         <label for="xfld" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("xfld", ["size" => 250, "maxlength" => 250, "class" => "stacked-input upper", "id" => "xfld", "placeholder" => "xfld"]);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Empresas/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
