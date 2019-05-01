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
            <i class="pe-7s-file"></i><h3>Creación nuevo campo</h3>
         </div>
      </header>

      <?php 
          $tipos = ["character" => "character", "numeric" => "numeric", "date" => "date"];
      ?>

      <div class="widget__content">                  
         <label for="name" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("name", ["size" => 30, "maxlength" => 30, "class" => "stacked-input upper", "id" => "name", "placeholder" => "Nombre"]);?>

         <label for="type" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->select("type", $tipos, ["class" => "form-control", "id" => "type"])?>

         <label for="len" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("len", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "len", "placeholder" => "Largo"]);?>
         <label for="decim" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("decim", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "decim", "placeholder" => "decimales"]);?>
         <label for="pk" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("pk", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "pk", "placeholder" => "Primary Key"]);?>
         <label for="req" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("req", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "req", "placeholder" => "Requerido"]);?>
         <label for="caption" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("caption", ["size" => 50, "maxlength" => 50, "class" => "stacked-input upper", "id" => "caption", "placeholder" => "Título"]);?>
         <label for="gadget" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("gadget", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "gadget", "placeholder" => "Gadget"]);?>
         <label for="size" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("size", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "size", "placeholder" => "Size"]);?>
         <label for="maxlength" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("maxlength", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "maxlength", "placeholder" => "Maxlength"]);?>
         <label for="rows" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("rows", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "rows", "placeholder" => "Rows"]);?>
         <label for="cols" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("cols", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "cols", "placeholder" => "Cols"]);?>
         <label for="selvalues" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("selvalues", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "selvalues", "placeholder" => "selvalues"]);?>
      
         <label for="readonly" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("readonly", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "readonly", "placeholder" => "Readonly"]);?>
         <label for="fld_type" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("fld_type", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "fld_type", "placeholder" => "fld_type"]);?>
         <label for="fld_offset" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("fld_offset", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fld_offset", "placeholder" => "fld_offset"]);?>


         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("form_id")?>
         <?=$this->Form->hidden("forder")?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>FormDefs/edit/<?=$gre->form_id?>" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
