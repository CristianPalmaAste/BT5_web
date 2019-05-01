<?= $this->Form->create($gre, ["id" => "frm", "method" => "post", 'enctype' => 'multipart/form-data']) ?>
 
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
            <i class="pe-7s-file"></i><h3>Mantención de Grupos Empresariales</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <label for="nombre" class="stacked-label"  data-toggle="tooltip" title="Nombre Grupo Empresarial"><i class="pe-7s-note" ></i></label>
         <?=$this->Form->text("nombre", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "nombre", "placeholder" => "nombre", 'placeholder' => 'Nombre*']);?>
         <label for="alias" class="stacked-label data-toggle="tooltip" title="Alias del Grupo Empresarial""><i class="pe-7s-note" ></i></label>
         <?=$this->Form->text("alias", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "alias", "placeholder" => "alias", 'placeholder' => 'Alias*']);?>
		 
		 <label class="full-label" style="clear:both;" data-toggle="tooltip" title="Icono">
            <input type="file" name="icono" id="icono">
            <i class="pe-7f-paperclip"></i><span class="label"></span>
         </label>
		 <div id="iconoPreview"><img src="<?=$this->request->webroot."webroot/holdings/".$gre->icono?>" /></div>	 
		 <input type="hidden" name="icono_old" value="<?=$gre->icono?>"/>
		 
    
         <label for="idpais" class="stacked-label" data-toggle="tooltip" title="País"><i class="pe-mi-flag-1" ></i></label>
         <?=$this->Form->select("idpais", $paises, ["class" => "stacked-input upper", "id" => "idpais", "placeholder" => "idpais", 'placeholder' => 'País*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="idesge" class="stacked-label" data-toggle="tooltip" title="Estado"><i class="pe-7f-menu" ></i></label>
         <?=$this->Form->select("idesge", $egrems, ["class" => "stacked-input upper", "id" => "idesge", "placeholder" => "idesge", 'placeholder' => 'Estado*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>GruposEmpresariales/index" class="btn dark inverse">Volver</a>
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
