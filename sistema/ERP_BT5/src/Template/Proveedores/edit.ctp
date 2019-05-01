<?= $this->Form->create($gre, ["id" => "frm"]) ?>
 
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
            <i class="pe-7s-file"></i><h3>Proveedores</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id", ["id" => "id", "value" => $gre->id]);?>
         <?=$this->Form->hidden("idgrem", ["id" => "idgrem", "value" => $gre->idgrem]);?>
         <label for="idpais" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->select("idpais", $paises, ["class" => "stacked-input", "id" => "idpais", 'placeholder' => 'País*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="identificador1" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador1", ["size" => 10, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador1", 'placeholder' => 'Rut*']);?>
         <label for="identificador2" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador2", ["size" => 10, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador2", 'placeholder' => 'Dv*']);?>
         <label for="idtipp" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->select("idtipp", $tipos_proveedores, ["class" => "stacked-input", "id" => "idtipp", 'placeholder' => 'Tipo de proveedor*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="razonsocial" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("razonsocial", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "razonsocial", 'placeholder' => 'Razón Social']);?>
         <label for="nombrefantasia" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombrefantasia", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "nombrefantasia", 'placeholder' => 'Nombre de Fantasía']);?>
         <label for="primernombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("primernombre", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "primernombre", 'placeholder' => 'Primer Nombre']);?>
         <label for="segundonombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("segundonombre", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "segundonombre", 'placeholder' => 'Segundo Nombre']);?>
         <label for="apellidopaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidopaterno", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "apellidopaterno", 'placeholder' => 'Apellido Paterno']);?>
         <label for="apellidomaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidomaterno", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "apellidomaterno", 'placeholder' => 'Apellido Materno']);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Proveedores/index" class="btn dark inverse">Volver</a>
</div>
</div>

<?=$this->Html->script('valrut.js');?>

<script language="javascript">
$("#idpais").focus();

   rut=document.getElementById("identificador1");

   //alert(rut.value);

   rut.value = disp_no(clean_no(rut.value));
   
   document.getElementById("identificador2").onblur=function() {
      this.value=this.value.toUpperCase();

      rut = document.getElementById("identificador1").value;

      if (!check_rut(rut, this.value)) {
         alert("Rut incorrecto!");
      }
   }
   
   document.getElementById("idtipp").onchange=function() {
	  primernombre    = document.getElementById("primernombre"   );
	  segundonombre   = document.getElementById("segundonombre"   );
	  apellidopaterno = document.getElementById("apellidopaterno");
	  apellidomaterno = document.getElementById("apellidomaterno");
	  razonsocial     = document.getElementById("razonsocial");
	  nombrefantasia  = document.getElementById("nombrefantasia");
	  
	  if (this.value==1) {
		 razonsocial.value    = null;
		 nombrefantasia.value = null;
	  }
	  else {
		 primernombre.value    = null;
	     segundonombre.value   = null;
	     apellidopaterno.value = null;
	     apellidomaterno.value = null; 
	  }
   }

   document.getElementById("frm").onsubmit=function() {
	  idtipp=document.getElementById("idtipp");
	  
	  if (idtipp.value=="") {
		 alert("¡Debe ingresar el Tipo de Empresa!");
		 idtipp.select();
		 idtipp.focus();
		 return false;
	  }
		 
	  primernombre    = document.getElementById("primernombre"   );
	  segundonombre   = document.getElementById("segundonombre"   );
	  apellidopaterno = document.getElementById("apellidopaterno");
	  apellidomaterno = document.getElementById("apellidomaterno");
	  razonsocial     = document.getElementById("razonsocial");
	  nombrefantasia  = document.getElementById("nombrefantasia");
		 
	  if (idtipp.value==1) {
		  razonsocial.value   =null;
		  nombrefantasia.value=null;
		 
		 if (apellidopaterno.value=="") {
			alert("¡Debe ingresar el Apellido Paterno!");
			apellidopaterno.select();
			apellidopaterno.focus();
			return false;
		 }
		 
		 if (apellidomaterno.value=="") {
			alert("¡Debe ingresar el Apellido Materno!");
			apellidomaterno.select();
			apellidomaterno.focus();
			return false;
		 }
		 
		 if (primernombre.value=="") {
			alert("¡Debe ingresar el Primer Nombre!");
			primernombre.select();
			primernombre.focus();
			return false;
		 }
		 
	  }
	  else {
		 primernombre.value    = null;
	     segundonombre.value   = null;
	     apellidopaterno.value = null;
	     apellidomaterno.value = null;
	  
		 if (razonsocial.value=="") {
			alert("¡Debe ingresar la Razón Social!");
			razonsocial.select();
			razonsocial.focus();
			return false;
		 }
		 
		 if (nombrefantasia.value=="") {
			alert("¡Debe ingresar el Nombre de Fantasía!");
			nombrefantasia.select();
			nombrefantasia.focus();
			return false;
		 }
	  }
	  
	  rut=document.getElementById("identificador1");

      rut.value = clean_no(rut.value);
	  
	  return true;
   }
</script>
