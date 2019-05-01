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
</td></tr>
         <?=$this->Form->hidden("idempr", ["id" => "idempr"])?>
</td></tr>
<?=$this->Form->text("correlativo", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "correlativo", 'placeholder' => 'Correlativo*']);?>
</td></tr>
<?=$this->Form->text("monto", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "monto", 'placeholder' => 'Monto*']);?>
</td></tr>
<?=$this->Form->select("idgere", $gerencias, ["class" => "stacked-input", "id" => "idgere", 'placeholder' => 'Gerencia', 'style' => 'color:black;']);?>
</td></tr>
<?=$this->Form->select("idproy", $proyectos, ["class" => "stacked-input", "id" => "idproy", 'placeholder' => 'Proyecto', 'style' => 'color:black;']);?>
</td></tr>
<?=$this->Form->select("idline", $lineas_negocios, ["class" => "stacked-input", "id" => "idline", 'placeholder' => 'Línea de negocios', 'style' => 'color:black;']);?>
</td></tr>
<?=$this->Form->select("idceco", $centros_costos, ["class" => "stacked-input", "id" => "idceco", 'placeholder' => 'Centro de costos', 'style' => 'color:black;']);?>
</td></tr>
<?=$this->Form->select("idtare", $tareas, ["class" => "stacked-input", "id" => "idtare", 'placeholder' => 'Tarea', 'style' => 'color:black;']);?>
</td></tr>

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
