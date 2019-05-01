<h3>Mantención de Personas</h3>
<br/>

<?=$this->Form->create($emp, ["class" => "form-horizontal"]);?>
<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="idgrem">Grupo Empresarial:</label>
   </div>
   <div class="col-sm-4">
        <label class="control-label"><?=$nombreGrupo?></label>
   </div>
</div>
<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="identificador1">Rut:</label>
   </div>
   <div class="col-sm-2">
        <?=$this->Form->text("identificador1", ["class" => "form-control", "size" => 10, "maxlength" => 10]);?>
   </div>
   <div class="col-sm-1">
        <?=$this->Form->text("identificador2", ["class" => "form-control", "size" => 1, "maxlength" => 1]);?>
   </div>
</div>
<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="primernombre">Primer nombre:</label>
   </div>
   <div class="col-sm-6">
        <?=$this->Form->text("primernombre", ["class" => "form-control", "size" => 50, "maxlength" => 100]);?>
   </div>
</div>

<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="segundonombre">Segundo nombre:</label>
   </div>
   <div class="col-sm-6">
        <?=$this->Form->text("segundonombre", ["class" => "form-control", "size" => 50, "maxlength" => 100]);?>
   </div>
</div>

<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="apellidopaterno">Apellido paterno:</label>
   </div>
   <div class="col-sm-6">
        <?=$this->Form->text("apellidopaterno", ["class" => "form-control", "size" => 50, "maxlength" => 100]);?>
   </div>
</div>

<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="apellidomaterno">Apellido materno:</label>
   </div>
   <div class="col-sm-6">
        <?=$this->Form->text("apellidomaterno", ["class" => "form-control", "size" => 50, "maxlength" => 100]);?>
   </div>
</div>

<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="email">E-Mail:</label>
   </div>
   <div class="col-sm-6">
        <?=$this->Form->text("email", ["class" => "form-control", "size" => 50, "maxlength" => 100]);?>
   </div>
</div>

<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="fechanac">Fecha nacimiento:</label>
   </div>
   <div class="col-sm-4">
        <?=$this->Form->text("fechanac", ["class" => "form-control", "size" => 50, "maxlength" => 100, "type" => "date"]);?>
   </div>
</div>

<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="idesci">Estado Civil:</label>
   </div>
   <div class="col-sm-4">
      <?=$this->Form->select("idesci", $eciviles, ["class" => "form-control"]);?>
   </div>
</div>

<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="idsexo">Sexo:</label>
   </div>
   <div class="col-sm-4">
      <?=$this->Form->select("idsexo", $sexos, ["class" => "form-control"]);?>
   </div>
</div>

<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="idpais">Nacionalidad:</label>
   </div>
   <div class="col-sm-4">
      <?=$this->Form->select("idpais", $paises, ["class" => "form-control"]);?>
   </div>
</div>


<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-3">
      &nbsp;
   </div>
   <div class="col-sm-2">
      <button type="submit" class="btn btn-default">Grabar</button> 
   </div>
   <div class="col-sm-2">
      <?=$this->Html->link("Listado", "/personas", ["class" => "btn btn-default"]);?>
   </div>
</div>



<?=$this->Form->hidden("id")."\n";?>
<?=$this->Form->hidden("idgrem")."\n";?>
 
<?=$this->Form->end();?>

