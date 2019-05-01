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
            <i class="pe-7s-file"></i><h3>usuarios</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "id", "placeholder" => "id"]);?>
         <label for="username" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("username", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "username", "placeholder" => "username"]);?>
         <label for="password" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("password", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "password", "placeholder" => "password"]);?>
         <label for="idpers" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idpers", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "idpers", "placeholder" => "idpers"]);?>
         <label for="idesre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idesre", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "idesre", "placeholder" => "idesre"]);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Usuarios/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
