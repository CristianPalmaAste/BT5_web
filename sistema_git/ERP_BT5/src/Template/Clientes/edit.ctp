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
            <i class="pe-7s-file"></i><h3>Mantención de Clientes</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idgrem")?>
         <label for="identificador1" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador1", ["size" => 10, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador1", "placeholder" => "identificador1", 'placeholder' => 'Rut']);?>
         <label for="identificador2" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador2", ["size" => 10, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador2", "placeholder" => "identificador2", 'placeholder' => 'Dv']);?>
         <label for="idticl" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idticl", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idticl", "placeholder" => "idticl", 'placeholder' => 'Tipo ']);?>
         <label for="razonsocial" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("razonsocial", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "razonsocial", "placeholder" => "razonsocial", 'placeholder' => 'Razón social']);?>
         <label for="nombrefantasia" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombrefantasia", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "nombrefantasia", "placeholder" => "nombrefantasia", 'placeholder' => 'Nombre fantasía']);?>
         <label for="primernombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("primernombre", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "primernombre", "placeholder" => "primernombre", 'placeholder' => 'Primer nombre']);?>
         <label for="segundonombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("segundonombre", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "segundonombre", "placeholder" => "segundonombre", 'placeholder' => 'Segundo nombre']);?>
         <label for="apellidopaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidopaterno", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "apellidopaterno", "placeholder" => "apellidopaterno", 'placeholder' => 'Apellido paterno']);?>
         <label for="apellidomaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidomaterno", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "apellidomaterno", "placeholder" => "apellidomaterno", 'placeholder' => 'Apellido materno']);?>
         <label for="idpais" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idpais", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idpais", "placeholder" => "idpais", 'placeholder' => 'País']);?>

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

<script language="javascript">
$("#nombre").focus();
</script>
