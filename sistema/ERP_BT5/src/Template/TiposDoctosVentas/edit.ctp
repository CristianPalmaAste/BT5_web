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
            <i class="pe-7s-file"></i><h3>Tipos de Documentos de Venta</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idpais")?>
         <label for="descripcion" class="stacked-label"><i data-toggle="tooltip" title="Tipo Documento de Venta" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("descripcion", ["size" => 10, "maxlength" => 50, "class" => "stacked-input upper", "id" => "descripcion", "placeholder" => "descripcion", 'placeholder' => 'Descripción*']);?>
         <label for="descripcioncorta" class="stacked-label"><i data-toggle="tooltip" title="Nombre Corto" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("descripcioncorta", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "descripcioncorta", "placeholder" => "descripcioncorta", 'placeholder' => 'Descripción corta*']);?>
         <label for="codigooficial" class="stacked-label"><i data-toggle="tooltip" title="Código Oficial" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("codigooficial", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "codigooficial", "placeholder" => "codigooficial", 'placeholder' => 'Código oficial*']);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>TiposDoctosVentas/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
