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
            <i class="pe-7s-file"></i><h3>Fondos a Rendir</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id", ["id" => "id"])?>

         <?=$this->Form->hidden("idempr", ["id" => "idempr"])?>
<label for="correlativo" class="stacked-label"><i data-toggle="tooltip" title="Correlativo" class="pe-7s-menu" ></i></label>
<?=$this->Form->text("correlativo", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "correlativo", 'placeholder' => 'Correlativo*', 'readonly' => true]);?>
<label for="monto" class="stacked-label"><i data-toggle="tooltip" title="Monto $" class="pe-7s-menu" ></i></label>
<?=$this->Form->text("monto", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "monto", 'placeholder' => 'Monto*']);?>

<label for="idgere" class="stacked-label"><i data-toggle="tooltip" title="Gerencia" class="pe-7s-menu" ></i></label>
<?=$this->Form->select("idgere", $gerencias, ["class" => "stacked-input", "id" => "idgere", 'placeholder' => 'Gerencia', 'style' => 'color:black;','style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>

<label for="idproy" class="stacked-label"><i data-toggle="tooltip" title="Proyecto" class="pe-7s-menu" ></i></label>
<?=$this->Form->select("idproy", $proyectos, ["class" => "stacked-input", "id" => "idproy", 'placeholder' => 'Proyecto', 'style' => 'color:black;','style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>

<label for="idline" class="stacked-label"><i data-toggle="tooltip" title="Línea" class="pe-7s-menu" ></i></label>
<?=$this->Form->select("idline", $lineas_negocios, ["class" => "stacked-input", "id" => "idline", 'placeholder' => 'Línea de negocios', 'style' => 'color:black;','style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>

<label for="idceco" class="stacked-label"><i data-toggle="tooltip" title="Centro de Costo" class="pe-7s-menu" ></i></label>
<?=$this->Form->select("idceco", $centros_costos, ["class" => "stacked-input", "id" => "idceco", 'placeholder' => 'Centro de costos', 'style' => 'color:black;','style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>

<label for="idtare" class="stacked-label"><i data-toggle="tooltip" title="Tarea" class="pe-7s-menu" ></i></label>
<?=$this->Form->select("idtare", $tareas, ["class" => "stacked-input", "id" => "idtare", 'placeholder' => 'Tarea', 'style' => 'color:black;','style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>


<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>FondosARendir/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
