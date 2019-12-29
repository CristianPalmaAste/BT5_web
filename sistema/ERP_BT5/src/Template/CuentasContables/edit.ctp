﻿<?= $this->Form->create($cuentasContable, ["id" => "frm", "method" => "post", 'enctype' => 'multipart/form-data']) ?>
 
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
            <i class="pe-7s-file"></i><h3>Editar Cuentas Contables</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <div class="media-body">
	     <h5 class="media-heading message__heading"></h5>
		 <p class="message__location">
		    <i class="pe-7s-date"></i>Grupo Empresarial: <?= $empresa ?>
	     </p>
	  </div>
	  
	  <label for="Nombre Cuenta" class="stacked-label" data-toggle="tooltip" title="Cuenta" ><i class="pe-7f-menu" ></i></label>
         <?=$this->Form->text("cuenta_desplegable", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "cuenta_desplegable", "placeholder" => "Nombre Cuenta", 'placeholder' => 'Nombre Cuenta*']);?>
		 
		<label for="Descripción" class="stacked-label" data-toggle="tooltip" title="Nombre Cuenta" ><i class="pe-7s-note" ></i></label>
         <?=$this->Form->text("descripcion", ["size" => 10, "maxlength" => 50, "class" => "stacked-input upper", "id" => "descripcion", "placeholder" => "Descripción", 'placeholder' => 'Descripción*']);?>
		 
    
         <label for="idticc" class="stacked-label" data-toggle="tooltip" title="Tipo Cuenta"><i class="pe-7s-note" ></i></label>
         <?=$this->Form->select("idticc", $tipos_cuentas_contables, ["class" => "stacked-input upper", "id" => "idticc", "placeholder" => "idticc", 'placeholder' => 'Tipo Cuenta Contable*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         
<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>CuentasContables/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();

    document.getElementById("icono").onchange = function(){
      var fileInput = document.getElementById('icono');
      var filePath = fileInput.value;
	  
	  //alert(filePath);
	  
      var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
      if(!allowedExtensions.exec(filePath)){
          alert('Por favor subir solo archivos con extensiones .jpeg/.jpg/.png/.gif.');
          fileInput.value = '';
      }else{
          //Image preview
	  	//alert(fileInput.files[0]);
          if (fileInput.files && fileInput.files[0]) {
              var reader = new FileReader();
              reader.onload = function(e) {
                  document.getElementById('iconoPreview').innerHTML = '<img src="'+e.target.result+'"/>';
              };
              reader.readAsDataURL(fileInput.files[0]);
          }
      }
   }
   
</script>
