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
            <i class="pe-7s-file"></i><h3>NONAME</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "id", "placeholder" => "id"]);?>
         <label for="caption" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("caption", ["size" => 50, "maxlength" => 50, "class" => "stacked-input upper", "id" => "caption", "placeholder" => "caption"]);?>
         <label for="table_name" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("table_name", ["size" => 30, "maxlength" => 30, "class" => "stacked-input upper", "id" => "table_name", "placeholder" => "table_name"]);?>
         <label for="ins_allowed" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("ins_allowed", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "ins_allowed", "placeholder" => "ins_allowed"]);?>
         <label for="upd_allowed" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("upd_allowed", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "upd_allowed", "placeholder" => "upd_allowed"]);?>
         <label for="del_allowed" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("del_allowed", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "del_allowed", "placeholder" => "del_allowed"]);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>FormDefs/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
