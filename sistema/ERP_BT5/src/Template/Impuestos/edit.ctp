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
            <i class="pe-7s-file"></i><h3>Impuestos</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idpais", ['value' => $gre->idpais])?>
         <label for="descripcion" class="stacked-label" data-toggle="tooltip" title="Nombre del Impuesto"><i class="pe-7s-note" ></i></label>
         <?=$this->Form->text("descripcion", ["size" => 10, "maxlength" => 50, "class" => "stacked-input upper", "id" => "descripcion", "placeholder" => "descripcion", 'placeholder' => 'Descripción*']);?>
         <label for="descripcioncorta" class="stacked-label" data-toggle="tooltip" title="Nombre Corto del Impuesto"><i class="pe-7s-note" ></i></label>
         <?=$this->Form->text("descripcioncorta", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "descripcioncorta", "placeholder" => "descripcioncorta", 'placeholder' => 'Descripcion corta*']);?>
         <label for="obligatorio" class="stacked-label" data-toggle="tooltip" title="Es Obligatorio? Si/No"><i class="pe-7s-note" ></i></label>
         <?=$this->Form->select("obligatorio", ["" => "Seleccione", "S" => "Sí", "N" => "No"], ["class" => "stacked-input", "id" => "obligatorio", 'placeholder' => 'Obligatorio*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;', 'value' => $gre->obligatorio]);?>
         <label for="valor" class="stacked-label" data-toggle="tooltip" title="Valor del Impuesto"><i class="pe-7s-note" ></i></label>
         <?=$this->Form->text("valor", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "valor", "placeholder" => "valor", 'placeholder' => 'Valor*', 'value' => $gre->valor]);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Impuestos/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
