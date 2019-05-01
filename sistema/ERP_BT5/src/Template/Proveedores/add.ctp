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
            <i class="pe-7s-file"></i><h3>Proveedores</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->select("id", $0, ["class" => "stacked-input", "id" => "id", 'placeholder' => 'id*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="idgrem" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->select("idgrem", $0, ["class" => "stacked-input", "id" => "idgrem", 'placeholder' => 'idgrem*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="idpais" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->select("idpais", $paises, ["class" => "stacked-input", "id" => "idpais", 'placeholder' => 'País*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="identificador1" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador1", ["size" => 10, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador1", 'placeholder' => 'Rut*']);?>
         <label for="identificador2" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador2", ["size" => 10, "maxlength" => 50, "class" => "stacked-input upper", "id" => "identificador2", 'placeholder' => 'Dv*']);?>
         <label for="idtipp" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idtipp", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idtipp", 'placeholder' => 'Tipo Proveedor*']);?>
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

<script language="javascript">
$("#nombre").focus();
</script>
