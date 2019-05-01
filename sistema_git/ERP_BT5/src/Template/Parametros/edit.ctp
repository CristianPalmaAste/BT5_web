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
            <i class="pe-7s-file"></i><h3>Mantención de Parámetros</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idgrem")?>
         <label for="nombrecorto" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombrecorto", ["size" => 10, "maxlength" => 50, "class" => "stacked-input upper", "id" => "nombrecorto", "placeholder" => "nombrecorto", 'placeholder' => 'Nombre corto']);?>
         <label for="nombrelargo" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombrelargo", ["size" => 10, "maxlength" => 500, "class" => "stacked-input upper", "id" => "nombrelargo", "placeholder" => "nombrelargo", 'placeholder' => 'Nombre largo']);?>
         <label for="descripcion" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("descripcion", ["size" => 10, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "descripcion", "placeholder" => "descripcion", 'placeholder' => 'Descripcion']);?>
         <label for="valor" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("valor", ["size" => 10, "maxlength" => 500, "class" => "stacked-input upper", "id" => "valor", "placeholder" => "valor", 'placeholder' => 'Valor']);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Parametros/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
