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
         <label for="nombre" class="stacked-label" data-toggle="tooltip" title="Nombre Grupo Empresarial"><i class="pe-7s-note" ></i></label>
         <?=$this->Form->text("nombre", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "nombre", "placeholder" => "nombre", 'placeholder' => 'Nombre*']);?>
         <label for="alias" class="stacked-label" data-toggle="tooltip" title="Alias del Grupo Empresarial"><i class="pe-7s-note" ></i></label>
         <?=$this->Form->text("alias", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "alias", "placeholder" => "alias", 'placeholder' => 'Alias*']);?>

		 <label class="full-label" style="clear:both;" data-toggle="tooltip" title="Icono">
            <input type="file" name="icono" id="icono">
            <i class="pe-7f-paperclip"></i><span class="label"></span>
         </label>
		 <div id="iconoPreview"></div>	 
		 
         <label for="idpais" class="stacked-label" data-toggle="tooltip" title="País"><i class="pe-mi-flag-1" ></i></label>
         <?=$this->Form->select("idpais", $paises, ["class" => "stacked-input upper", "id" => "idpais", "placeholder" => "idpais", 'placeholder' => 'País*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="idesge" class="stacked-label" data-toggle="tooltip" title="Estado"><i class="pe-7f-menu" ></i></label>	 
         <?=$this->Form->select("idesge", $egrems, ["class" => "stacked-input upper", "id" => "idesge", "placeholder" => "idesge", 'placeholder' => 'Estado*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
		 
		 <label></label><label></label>
		 
		  <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Empresa</h3>
         </div>
        </header>
		 
		 <label for="identificador1emp" class="stacked-label" data-toggle="tooltip" title="RUT, sin Dígito Verificador"><i class="pe-mi-id" ></i></label>
         <?=$this->Form->text("identificador1emp", ["size" => 50, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador1emp", "placeholder" => "Rut"]);?>
         <label for="identificador2emp" class="stacked-label data-toggle="tooltip" title="Dígito Verificador""><i class="pe-mi-id" ></i></label>
         <?=$this->Form->text("identificador2emp", ["size" => 50, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador2emp", "placeholder" => "Dv"]);?>
         <label for="razonsocial" class="stacked-label data-toggle="tooltip" title="Razón Social""><i class="pe-7s-note" ></i></label>
         <?=$this->Form->text("razonsocial", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "razonsocial", "placeholder" => "Razón social"]);?>
         <label for="nombrefantasia" class="stacked-label data-toggle="tooltip" title="Nombre de Fantasía""><i class="pe-7s-note" ></i></label>
         <?=$this->Form->text("nombrefantasia", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "nombrefantasia", "placeholder" => "Nombre fantasía"]);?>
		 
		  
		 <label class="full-label" style="clear:both;" data-toggle="tooltip" title="Icono">
            <input type="file" name="iconoemp" id="iconoemp">
            <i class="pe-7f-paperclip"></i><span class="label"></span>
         </label>
		 <div id="iconoempPreview"></div>
		 
         <label for="idpais" class="stacked-label data-toggle="tooltip" title="País""><i class="pe-mi-flag-1" ></i></label>
         <?=$this->Form->select("idpaisemp", $paises, ["class" => "stacked-input upper", "id" => "idpaisemp", "placeholder" => "idpais", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:both;']);?>
         <input type="hidden" id="idgrem" value="<?php echo $idgrem;?>"/>

<label for="idrubr" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Rubro"><i class="pe-7f-menu"></i></label>


<?=$this->Form->select("idrubr", $rubros,["class" => "stacked-input upper", "id" => "idrubr", "placeholder" => "idrubr", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:both;']);?>


		 <label></label><label></label>
		 
		 <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Administrador Cliente</h3>
         </div>
      </header>
	  
	     <label for="username" class="stacked-label data-toggle="tooltip" title="Nombre de Usuario""><i class="pe-7s-user" ></i></label>
         <?=$this->Form->text("username", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "username", "placeholder" => "Nombre Usuario*", "required" => true]);?>
         <label for="password" class="stacked-label data-toggle="tooltip" title="Contraseña""><i class="pe-7s-lock" ></i></label>
         <?=$this->Form->text("password", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "password", "placeholder" => "Contraseña*", "required" => true]);?>

				 
         <label for="identificador1" class="stacked-label data-toggle="tooltip" title="RUT, sin Dígito Verificador"><i class="pe-mi-id" ></i></label>
         <?=$this->Form->text("identificador1", ["size" => 11, "maxlength" => 11, "class" => "stacked-input upper", "id" => "identificador1", "placeholder" => "Rut*", "required" => true]);?>
         <label for="identificador2" class="stacked-label data-toggle="tooltip" title="Dígito Verificador"><i class="pe-mi-id" ></i></label>
         
         <?=$this->Form->text("identificador2", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "identificador2", "placeholder" => "Dv*", "required" => true]);?>

         <label for="primernombre" class="stacked-label data-toggle="tooltip" title="Primer Nombre"><i class="pe-mi-contacts-2" ></i></label>
         <?=$this->Form->text("primernombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "primernombre", "placeholder" => "Primer nombre*", "required" => true]);?>
         <label for="segundonombre" class="stacked-label data-toggle="tooltip" title="Segundo Nombre"><i class="pe-mi-contacts-2" ></i></label>
         <?=$this->Form->text("segundonombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "segundonombre", "placeholder" => "Segundo nombre"]);?>
         <label for="apellidopaterno" class="stacked-label data-toggle="tooltip" title="Apellido Paterno"><i class="pe-mi-contacts-2" ></i></label>
         <?=$this->Form->text("apellidopaterno", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "apellidopaterno", "placeholder" => "Apellido paterno*", "required" => true]);?>
         <label for="apellidomaterno" class="stacked-label data-toggle="tooltip" title="Apellido Materno"><i class="pe-mi-contacts-2" ></i></label>
         <?=$this->Form->text("apellidomaterno", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "apellidomaterno", "placeholder" => "Apellido materno*", "required" => true]);?>
         <label for="email" class="stacked-label data-toggle="tooltip" title="E-mail"><i class="pe-mi-mail" ></i></label>
         <?=$this->Form->text("email", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "email", "placeholder" => "E-mail*", "required" => true]);?>
         <label for="fechanac" class="stacked-label data-toggle="tooltip" title="Fecha de Nacimiento"><i class="pe-mi-calendar" ></i></label>
<?= $this->Form->input(
            'fechanac',
            array(
               'type' => 'text',
               'label' => false,
               'class' => 'stacked-input datepicker',
               'id' => 'fechanac',
               'placeholder' => 'dd/mm/aa',
            )
         ) ?>
<label for="idesci" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Estado Civil"><i class="pe-mi-love"></i></label>
         <?=$this->Form->select("idesci", $eciviles, ["class" => "stacked-input", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;', "required" => true]);?>
<label for="idsexo" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Género"><i class="pe-mi-sex"></i></label>
         <?=$this->Form->select("idsexo", $sexos, ["class" => "stacked-input", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;', "required" => true]);?>
<label for="idpais2" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="País"><i class="pe-mi-flag-1"></i></label>
         <?=$this->Form->select("idpais2", $paises, ["class" => "stacked-input", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;', "required" => true]);?>

<?= $this->Form->hidden("idpers")?>
<?= $this->Form->hidden("idusua")?>
<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?=$this->Html->script('valrut.js');?>

<script language=javascript>
   rut=document.getElementById("identificador1");
   rut.value = disp_no(clean_no(rut.value));
   
   rut2=document.getElementById("identificador1emp");
   rut2.value = disp_no(clean_no(rut.value));

   document.getElementById("identificador1").onblur=function() {
      if (!isInteger(clean_no(this.value))) {
         this.value="";
         return;
      }

      this.value = disp_no(clean_no(this.value));
           
   }

   document.getElementById("identificador2").onblur=function() {
      this.value=this.value.toUpperCase();

      rut = document.getElementById("identificador1");

      if (!check_rut(rut.value, this.value)) {
		 rut.value="";
		 this.value="";
         alert("Rut incorrecto!");
      }


   }
   
   document.getElementById("identificador1emp").onblur=function() {
      if (!isInteger(clean_no(this.value))) {
         this.value="";
         return;
      }

      this.value = disp_no(clean_no(this.value));
           
   }

   document.getElementById("identificador2emp").onblur=function() {
      this.value=this.value.toUpperCase();

      rut = document.getElementById("identificador1emp");

      if (!check_rut(rut.value, this.value)) {
		 rut.value="";
		 this.value="";
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
                  document.getElementById('iconoPreview').innerHTML = '<img src="'+e.target.result+'" width="130px"/>';
              };
              reader.readAsDataURL(fileInput.files[0]);
          }
      }
   }
   
   document.getElementById("iconoemp").onchange = function(){
      var fileInput = document.getElementById('iconoemp');
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
                  document.getElementById('iconoempPreview').innerHTML = '<img src="'+e.target.result+'" width="130px"/>';
              };
              reader.readAsDataURL(fileInput.files[0]);
          }
      }
   }

   document.getElementById("frm").onsubmit=function() {
      rut = document.getElementById("identificador1");
	  rut2 = document.getElementById("identificador1emp");
	  
	  rut.value = clean_no(rut.value);
      rut2.value = clean_no(rut2.value);
	  
      return true;
   }
   
   document.getElementById("nombre").onblur=function() {
	  nombre = document.getElementById("nombre");
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>GruposEmpresariales/chkNombre/"+nombre.value,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
			alert("Nombre "+nombre.value+" ya ha sido utilizado");
			nombre.value="";
		 }
      }
     });
   }
   
   document.getElementById("alias").onblur=function() {
	  alias = document.getElementById("alias");
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>GruposEmpresariales/chkAlias/"+alias.value,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
			alert("Alias "+alias.value+" ya ha sido utilizado");
			alias.value="";
		 }
      }
     });
   }
   
   document.getElementById("razonsocial").onblur=function() {
      idgrem      = document.getElementById("idgrem");
	  razonsocial = document.getElementById("razonsocial");
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>GruposEmpresariales/chkRazonsocial/"+idgrem.value+"/"+razonsocial.value,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
			alert("Razón social "+razonsocial.value+" ya ha sido utilizada");
			razonsocial.value="";
		 }
      }
     });
   }
   
   document.getElementById("identificador1emp").onblur=function() {
      idgrem      = document.getElementById("idgrem");
	  identificador1emp = document.getElementById("identificador1emp");
	  
	  identificador1emp.value = disp_no(clean_no(identificador1emp.value));
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>GruposEmpresariales/chkIdentificador1emp/"+identificador1emp.value,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
			alert("Rut "+identificador1emp.value+" ya ha sido utilizado");
			identificador1emp.value="";
		 }
      }
     });
   }
   
   document.getElementById("nombrefantasia").onblur=function() {
      idgrem      = document.getElementById("idgrem");
	  nombrefantasia = document.getElementById("nombrefantasia");
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>GruposEmpresariales/chkNombrefantasia/"+idgrem.value+"/"+nombrefantasia.value,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
			alert("Nombre de fantasía "+nombrefantasia.value+" ya ha sido utilizado");
			nombrefantasia.value="";
		 }
      }
     });
   }
   
   document.getElementById("username").onblur=function() {
	  username = document.getElementById("username");
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>GruposEmpresariales/chkUsername/"+username.value,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
			alert("Nombre de usuario "+username.value+" ya ha sido utilizado");
			username.value="";
		 }
      }
     });
   }
   
   document.getElementById("identificador1").onblur=function() {
      idgrem      = document.getElementById("idgrem");
	  identificador1 = document.getElementById("identificador1");
	  
	  identificador1.value = disp_no(clean_no(identificador1.value));
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>GruposEmpresariales/chkIdentificador1/"+identificador1.value,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
			alert("Rut "+identificador1.value+" ya ha sido utilizado");
			identificador1.value="";
		 }
      }
     });
   }

</script>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>GruposEmpresariales/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
