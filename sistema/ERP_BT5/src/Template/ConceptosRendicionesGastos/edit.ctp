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
            <i class="pe-7s-file"></i><h3>Conceptos de Rendiciones y Gastos</h3>
         </div>
      </header>

      <div class="widget__content">
<?=$this->Form->text("id", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "id", 'placeholder' => 'Id*', 'readonly' => true]);?>
</td></tr>
         <?=$this->Form->hidden("idgrem", ["id" => "idgrem"])?>
</td></tr>
<?=$this->Form->text("descripcion", ["size" => 10, "maxlength" => 500, "class" => "stacked-input upper", "id" => "descripcion", 'placeholder' => 'Descripción*']);?>
</td></tr>
<?=$this->Form->select("idcuco", $cuentas_contables, ["class" => "stacked-input", "id" => "idcuco", 'placeholder' => 'Cuenta Contable*', 'style' => 'color:black;']);?>
</td></tr>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>ConceptosRendicionesGastos/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
