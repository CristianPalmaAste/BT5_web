<?= $this->Form->create($gre, ["id" => "frm", "type" => "post"]) ?>
 
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
            <i class="pe-7s-file"></i><h3>Clientes</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idgrem")?>
         <label for="idticl" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->select("idticl", $tipos_clientes, ["empty" => "Seleccione tipo de cliente", "class" => "stacked-input", "id" => "idticl", 'placeholder' => 'Tipo cliente*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
		 
         <label for="identificador1" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador1", ["size" => 10, "maxlength" => 11, "class" => "stacked-input upper", "id" => "identificador1", "placeholder" => "identificador1", 'placeholder' => 'Rut*']);?>
         <label for="identificador2" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador2", ["size" => 10, "maxlength" => 1, "class" => "stacked-input upper", "id" => "identificador2", "placeholder" => "identificador2", 'placeholder' => 'Dv*']);?>
         <label for="razonsocial" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("razonsocial", ["size" => 10, "maxlength" => 60, "class" => "stacked-input upper", "id" => "razonsocial", "placeholder" => "razonsocial", 'placeholder' => 'Razón Social']);?>
         <label for="nombrefantasia" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombrefantasia", ["size" => 10, "maxlength" => 60, "class" => "stacked-input upper", "id" => "nombrefantasia", "placeholder" => "nombrefantasia", 'placeholder' => 'Nombre de Fantasía']);?>
         <label for="primernombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("primernombre", ["size" => 10, "maxlength" => 25, "class" => "stacked-input upper", "id" => "primernombre", "placeholder" => "primernombre", 'placeholder' => 'Primer Nombre']);?>
         <label for="segundonombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("segundonombre", ["size" => 10, "maxlength" => 25, "class" => "stacked-input upper", "id" => "segundonombre", "placeholder" => "segundonombre", 'placeholder' => 'Segundo Nombre']);?>
         <label for="apellidopaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidopaterno", ["size" => 10, "maxlength" => 30, "class" => "stacked-input upper", "id" => "apellidopaterno", "placeholder" => "apellidopaterno", 'placeholder' => 'Apellido Paterno']);?>
         <label for="apellidomaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidomaterno", ["size" => 10, "maxlength" => 30, "class" => "stacked-input upper", "id" => "apellidomaterno", "placeholder" => "apellidomaterno", 'placeholder' => 'Apellido Materno']);?>
         <label for="idpais" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->select("idpais", $paises, ["empty" => "Seleccione país", "class" => "stacked-input", "id" => "idpais", 'placeholder' => 'País*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Clientes/index" class="btn dark inverse">Volver</a>
</div>
</div>

<?=$this->Html->script('valrut.js');?>

<script language="javascript">
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
   
   document.getElementById("idticl").onchange = function () {
      //alert("idticl:" +this.value);
	   
	  if (this.value==1) {	 
		 document.getElementById("razonsocial").value="";
		 document.getElementById("nombrefantasia").value="";
	  }
	  else {
		 document.getElementById("primernombre").value="";
		 document.getElementById("segundonombre").value="";
		 document.getElementById("apellidopaterno").value="";
		 document.getElementById("apellidomaterno").value="";
	  }
   }
   
   document.getElementById("frm").onsubmit = function () {
	  rut = document.getElementById("identificador1").value;
	  dv  = document.getElementById("identificador2").value;

      if (!check_rut(rut, dv)) {
         alert("Rut incorrecto!");
		 
		 return false;
      }
	  
	  rut = document.getElementById("identificador1");
	  rut.value = clean_no(rut.value);
	  
	  idticl = document.getElementById("idticl").value;
	  
	  if (idticl==1) {	 
		 document.getElementById("razonsocial").value="";
		 document.getElementById("nombrefantasia").value="";
		 
		 primernombre    = document.getElementById("primernombre");
		 segundonombre   = document.getElementById("segundonombre");
		 apellidopaterno = document.getElementById("apellidopaterno");
		 apellidomaterno = document.getElementById("apellidomaterno");
		 
	     if (primernombre.value=="") { alert("Debe ingresar el Primer Nombre!"); return false; }
	  
	     //if (segundonombre.value=="") { alert("Debe ingresar el Segundo Nombre!"); return false; }
	  
	     if (apellidopaterno.value=="") { alert("Debe ingresar el Apellido Paterno!"); return false; }
	  
	     if (apellidomaterno.value=="") { alert("Debe ingresar el Apellido Materno!"); return false; }
		 
	  }
	  else {
		 razonsocial    = document.getElementById("razonsocial");
         nombrefantasia = document.getElementById("nombrefantasia");
		 
		 document.getElementById("primernombre").value="";
		 document.getElementById("segundonombre").value="";
		 document.getElementById("apellidopaterno").value="";
		 document.getElementById("apellidomaterno").value="";
	 
         if (razonsocial.value=="") { alert("Debe ingresar la Razón Social!"); return false; } 		 
		 
		 if (nombrefantasia.value=="") { alert("Debe ingresar el Nombre de Fantasía!"); return false; }
	  }	  
	  
	  return true;
   }
</script>
