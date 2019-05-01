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
            <i class="pe-7s-file"></i><h3>Servicios</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idempr")?>
         <label for="idtise" class="stacked-label"><i data-toggle="tooltip" title="Tipo de Servicio" class="pe-7s-menu" ></i></label>
         <?=$this->Form->select("idtise", $tipos_servicios, ["class" => "stacked-input", "id" => "idtise", 'placeholder' => 'Tipo*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="idunms" class="stacked-label"><i data-toggle="tooltip" title="Unidad de Medida" class="pe-7s-menu" ></i></label>
         <?=$this->Form->select("idunms", $unidades_medidas_servicios, ["class" => "stacked-input", "id" => "idunms", 'placeholder' => 'Unidad de Medida*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="nombre" class="stacked-label"><i data-toggle="tooltip" title="Nombre de Servicio" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("nombre", ["size" => 10, "maxlength" => 120, "class" => "stacked-input upper", "id" => "nombre", "placeholder" => "nombre", 'placeholder' => 'Nombre*']);?>
         <label for="preciounitario" class="stacked-label"><i data-toggle="tooltip" title="Valor Unitario" class="pe-7s-cash" ></i></label>
         <?=$this->Form->text("preciounitario", ["size" => 10, "maxlength" => 11, "class" => "stacked-input upper", "id" => "preciounitario", "placeholder" => "preciounitario", 'placeholder' => 'Valor Unitarios*']);?>
         <label for="moneda" class="stacked-label"><i data-toggle="tooltip" title="Moneda" class="pe-7s-piggy" ></i></label>
         <?=$this->Form->select("idmone", $monedas, ["class" => "stacked-input", "id" => "idmone", 'placeholder' => 'Moneda*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Servicios/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
