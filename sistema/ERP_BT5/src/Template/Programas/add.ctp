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
            <i class="pe-7s-file"></i><h3>Programas</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i data-toggle="tooltip" title="Id." class="pe-7s-note" ></i></label>
         <?=$this->Form->text("id", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "id", 'placeholder' => 'Id.*']);?>

         <label for="titulo" class="stacked-label"><i data-toggle="tooltip" title="Título" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("titulo", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "titulo", 'placeholder' => 'Título*']);?>

         <label for="idprogpadre" class="stacked-label"><i data-toggle="tooltip" title="Id. programa padre" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("idprogpadre", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "idprogpadre", 'placeholder' => 'Id. programa padre*']);?>

         <label for="link" class="stacked-label"><i data-toggle="tooltip" title="Link" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("link", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "link", 'placeholder' => 'Link*']);?>

         <label for="etiqueta" class="stacked-label"><i data-toggle="tooltip" title="Etiqueta" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("etiqueta", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "etiqueta", 'placeholder' => 'Etiqueta*']);?>

         <label for="peso" class="stacked-label"><i data-toggle="tooltip" title="Peso" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("peso", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "peso", 'placeholder' => 'Peso*']);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Programas/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
