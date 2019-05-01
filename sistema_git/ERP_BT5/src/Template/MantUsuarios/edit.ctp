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
            <i class="pe-7s-file"></i><h3>Mantención de Usuarios</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="username" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("username", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "username", "placeholder" => "Nombre Usuario"]);?>
         <label for="password" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("password", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "password", "placeholder" => "Contraseña", "required" => true]);?>
         <label for="idpers" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->select("idpers", $personas, ["class" => "stacked-input upper", "id" => "idpers", "placeholder" => "Persona", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'])?>
<label for="idesre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->select("idesre", $estados, ["class" => "stacked-input upper", "id" => "idesre", "placeholder" => "Estado", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;', "required" => true]);?>
 
         
<?=$this->Form->hidden("id")?>

<table>
<tr><td>Perfiles</td></tr>

<?php $n=0; ?>
<?php foreach($perfiles as $p): ?>

          <tr><td><input type="checkbox" name="idperfs[]"<?=(in_array($p->id, $profiles))?" checked":""?> value="<?=$p->id?>"><?=$p->descripcion?></td></tr>

<?php endforeach;?>
</table>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>MantUsuarios/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
