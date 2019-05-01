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
            <i class="pe-7s-file"></i><h3>Mantención de Empresas</h3>
         </div>
      </header>

      <div class="widget__content">

         
         <label for="identificador1" class="stacked-label" data-toggle="tooltip" title="RUT, sin Dígito Verificador"><i class="pe-mi-id" ></i></label>
         <?=$this->Form->text("identificador1", ["size" => 50, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador1", "placeholder" => "Rut"]);?>
         <label for="identificador2" class="stacked-label data-toggle="tooltip" title="Dígito Verificador""><i class="pe-mi-id" ></i></label>
         <?=$this->Form->text("identificador2", ["size" => 50, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador2", "placeholder" => "Dv"]);?>
         <label for="razonsocial" class="stacked-label data-toggle="tooltip" title="Razón Social""><i class="pe-7s-note" ></i></label>
         <?=$this->Form->text("razonsocial", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "razonsocial", "placeholder" => "Razón social"]);?>
         <label for="nombrefantasia" class="stacked-label data-toggle="tooltip" title="Nombre de Fantasía""><i class="pe-7s-note" ></i></label>
         <?=$this->Form->text("nombrefantasia", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "nombrefantasia", "placeholder" => "Nombre fantasía"]);?>
		 
         <label class="full-label" style="clear:both;" data-toggle="tooltip" title="Icono">
            <input type="file" name="icono" id="icono">
            <i class="pe-7f-paperclip"></i><span class="label"></span>
         </label>
		 <div id="iconoPreview"><img src="<?=$this->request->webroot."webroot/holdings/".$gre->icono?>" /></div>	 
		 <input type="hidden" name="icono_old" value="<?=$gre->icono?>"/>
        
         <label for="idpais" class="stacked-label data-toggle="tooltip" title="País""><i class="pe-mi-flag-1" ></i></label>
         <?=$this->Form->select("idpais", $paises, ["class" => "stacked-input upper", "id" => "idpais", "placeholder" => "idpais", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:both;']);?>


<label for="idrubr" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Rubro"><i class="pe-7f-menu"></i></label>


<?=$this->Form->select("idrubr", $rubros,["class" => "stacked-input upper", "id" => "idrubr", "placeholder" => "idrubr", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:both;']);?>


         <?=$this->Form->hidden("idesre");?>   
         <?=$this->Form->hidden("id");?>         
         <?=$this->Form->hidden("idgrem");?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?=$this->Html->script('valrut.js');?>

<script language=javascript>
   rut=document.getElementById("identificador1");

   //alert(rut.value);

   rut.value = disp_no(rut.value);

   document.getElementById("identificador1").onblur=function() {
      if (!isInteger(clean_no(this.value))) {
         this.value="";
         return;
      }

      this.value = disp_no(clean_no(this.value));
           
   }

   document.getElementById("identificador2").onblur=function() {
      this.value=this.value.toUpperCase();

      rut = document.getElementById("identificador1").value;

      if (!check_rut(rut, this.value)) {
         alert("Rut incorrecto!");
      }


   }
   
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

   document.getElementById("frm").onsubmit=function() {

      rut = document.getElementById("identificador1");
      dv  = document.getElementById("identificador2");

      rut.value = clean_no(rut.value);

      if (!check_rut(rut.value, dv.value)) {
         alert("Rut incorrecto!");
         return false;
      }
      else
         return true;
   }

</script>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Empresas/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
