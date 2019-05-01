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
            <i class="pe-7s-file"></i><h3>Mantención de Personas</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "id", "placeholder" => "id"]);?>
         <label for="idgrem" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idgrem", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "idgrem", "placeholder" => "idgrem"]);?>
         <label for="identificador1" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador1", ["size" => 50, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador1", "placeholder" => "identificador1"]);?>
         <label for="identificador2" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador2", ["size" => 50, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador2", "placeholder" => "identificador2"]);?>
         <label for="primernombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("primernombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "primernombre", "placeholder" => "primernombre"]);?>
         <label for="segundonombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("segundonombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "segundonombre", "placeholder" => "segundonombre"]);?>
         <label for="apellidopaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidopaterno", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "apellidopaterno", "placeholder" => "apellidopaterno"]);?>
         <label for="apellidomaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidomaterno", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "apellidomaterno", "placeholder" => "apellidomaterno"]);?>
         <label for="email" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("email", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "email", "placeholder" => "email"]);?>
         <label for="fechanac" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("fechanac", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fechanac", "placeholder" => "fechanac"]);?>
         <label for="idesci" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idesci", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "idesci", "placeholder" => "idesci"]);?>
         <label for="idsexo" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idsexo", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "idsexo", "placeholder" => "idsexo"]);?>
         <label for="idpais" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idpais", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "idpais", "placeholder" => "idpais"]);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Personas/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
