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
            <i class="pe-7s-file"></i><h3>Sub.Familias de Productos</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <label for="idfapr" class="stacked-label"><i data-toggle="tooltip" title="Nombre Familia" class="pe-7s-menu" ></i></label>
         <?=$this->Form->select("idfapr", $familias_productos, ["class" => "stacked-input", "id" => "idfapr", 'placeholder' => 'Familia*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="cod_sub_familia" class="stacked-label"><i data-toggle="tooltip" title="Código Sub Familia" class="pe-7s-note" ></i></label>
		 
		 <?php
		    $requerido = $accion=="edit";
		 ?>
         <?=$this->Form->text("cod_sub_familia", ["size" => 10, "maxlength" => 2, "class" => "stacked-input upper", "id" => "cod_sub_familia", 'placeholder' => 'Código*', 'required' => $requerido]);?>
         <label for="descripcion" class="stacked-label"><i data-toggle="tooltip" title="Nombre Sub Familia" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("descripcion", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "descripcion", 'placeholder' => 'Descripción*']);?>
		 <label for="idcuco" class="stacked-label"><i data-toggle="tooltip" title="Cuenta Contable" class="pe-7s-note" ></i></label>
         <?=$this->Form->select("idcuco", $cuentas_contables, ["class" => "stacked-input", "id" => "idcuco", 'placeholder' => 'Cuenta Contable*', 'style' => 'color:black;', 'required' => true,'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>SubFamiliasProductos/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
//$("#nombre").focus();

// Restricts input for each element in the set of matched elements to the given inputFilter.
(function($) {
  $.fn.inputFilter = function(inputFilter) {
    return this.on("input keydown keyup mousedown mouseup select contextmenu drop", function() {
      if (inputFilter(this.value)) {
        this.oldValue = this.value;
        this.oldSelectionStart = this.selectionStart;
        this.oldSelectionEnd = this.selectionEnd;
      } else if (this.hasOwnProperty("oldValue")) {
        this.value = this.oldValue;
        this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
      }
    });
  };
}(jQuery));

$(document).ready(function() {
  // Restrict input to digits by using a regular expression filter.
  $("#cod_sub_familia").inputFilter(function(value) {
    return /^\d*$/.test(value);
  });
});  
</script>
