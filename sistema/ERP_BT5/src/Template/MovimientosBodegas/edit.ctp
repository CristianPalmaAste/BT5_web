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
            <i class="pe-7s-file"></i><h3>Movimientos de Bodegas</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <label for="idbode" class="stacked-label"><i data-toggle="tooltip" title="Bodega" class="pe-7s-menu" ></i></label>
         <?=$this->Form->select("idbode", $bodegas, ["class" => "stacked-input", "id" => "idbode", 'placeholder' => 'Bodega*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="correlativo" class="stacked-label"><i data-toggle="tooltip" title="Correlativo" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("correlativo", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "correlativo", 'placeholder' => 'Correlativo*']);?>
         <label for="idtimb" class="stacked-label"><i data-toggle="tooltip" title="Tipo de Movimiento" class="pe-7s-menu" ></i></label>
         <?=$this->Form->select("idtimb", $tipos_movimientos_bodegas, ["class" => "stacked-input", "id" => "idtimb", 'placeholder' => 'Tipo de Movimiento*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="fechamovto" class="stacked-label"><i data-toggle="tooltip" title="Fecha Movimiento (dd-mm-aaaa)" class="pe-mi-calendar" ></i></label>
         <?=$this->Form->text("fechamovto", ["size" => 10, "maxlength" => 10, "class" => "stacked-input datepicker", "id" => "fechamovto", 'placeholder' => 'Fecha Movto.*']);?>
         <label for="descripcion" class="stacked-label"><i data-toggle="tooltip" title="Descripción" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("descripcion", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "descripcion", 'placeholder' => 'Descripción*']);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>MovimientosBodegas/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
