<h3>Grupos Empresariales</h3>
<br/>


<?=$this->Form->create($gre, ["class" => "form-horizontal"]);?>

<?php if (count($errors) > 0) {
?>
<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-9">
<div class="panel panel-danger">
      <div class="panel-heading">Errores</div>

<?php

         foreach($errors as $key => $arr)
            foreach($arr as $k => $v)
               echo "<div class=\"panel-body\">$v</div>";
?>
    </div>
<div>
</div>
<?php      }
?>


<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-2">
      <label class="control-label" for="nombre">Nombre:</label>
   </div>
   <div class="col-sm-7">
      <?=$gre->nombre?>
   </div>
</div>

<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-2">
      <label class="control-label" for="alias">Alias:</label>
   </div>
   <div class="col-sm-7">
      <?=$gre->alias?>
   </div>
</div>


<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-2">
      <label class="control-label" for="icono">Icono:</label>
   </div>
   <div class="col-sm-7">
      <?=$gre->icono?>
   </div>
</div>

<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-2">
      <label class="control-label" for="idpais">País:</label>
   </div>
   <div class="col-sm-7">
      <?=$paises[$gre->idpais]?>
   </div>
</div>

<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-2">
      <label class="control-label" for="idesge">Estado:</label>
   </div>
   <div class="col-sm-7">
      <?=$egrem[$gre->idesge]?>
   </div>
</div>
 
<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-3">
      &nbsp;
   </div>
   <div class="col-sm-2">
      &nbsp;
   </div>
   <div class="col-sm-2">
      <?=$this->Html->link("Volver", "/grupos-empresariales", ["class" => "btn btn-default"]);?>
   </div>
</div>

<?=$this->Form->hidden("id")."\n";?> 
<?=$this->Form->end();?>

