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
            <i class="pe-7s-file"></i><h3>Mantención de Personas</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="identificador1" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador1", ["size" => 11, "maxlength" => 11, "class" => "stacked-input upper", "id" => "identificador1", "placeholder" => "Rut"]);?>
         <label for="identificador2" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         
<?=$this->Form->text("identificador2", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "identificador2", "placeholder" => "Dv"]);?>

         <label for="primernombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("primernombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "primernombre", "placeholder" => "Primer nombre"]);?>
         <label for="segundonombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("segundonombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "segundonombre", "placeholder" => "Segundo nombre"]);?>
         <label for="apellidopaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidopaterno", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "apellidopaterno", "placeholder" => "Apellido paterno"]);?>
         <label for="apellidomaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidomaterno", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "apellidomaterno", "placeholder" => "Apellido materno"]);?>
         <label for="email" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("email", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "email", "placeholder" => "email"]);?>
         <label for="fechanac" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("fechanac", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fechanac", "placeholder" => "dd/mm/aa"]);?>
         <label for="idesci" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->select("idesci", $eciviles, ["class" => "stacked-input", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="idsexo" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->select("idsexo", $sexos, ["class" => "stacked-input", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="idpais" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->select("idpais", $paises, ["class" => "stacked-input", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>

<?=$this->Form->hidden("id")?>
<?=$this->Form->hidden("idgrem")?>

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
<a href="<?=$this->request->webroot?>Personas/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
