<h3>Mantención de gerencias</h3>
<br/>

<?=$this->Form->create($emp, ["class" => "form-horizontal"]);?>

<div class="row" style="padding-bottom:5px;" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="id">id:</label>
   </div>
   <div class="col-sm-6">
        <?=$this->Form->text("id", ["class" => "form-control", "size" => 50, "maxlength" => 100]);?>
   </div>
</div>
<div class="row" style="padding-bottom:5px;" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="idempr">idempr:</label>
   </div>
   <div class="col-sm-6">
        <?=$this->Form->text("idempr", ["class" => "form-control", "size" => 50, "maxlength" => 100]);?>
   </div>
</div>
<div class="row" style="padding-bottom:5px;" style="padding-bottom:5px;">
   <div class="col-sm-3">
      <label class="control-label" for="nombre">nombre:</label>
   </div>
   <div class="col-sm-6">
        <?=$this->Form->text("nombre", ["class" => "form-control", "size" => 50, "maxlength" => 100]);?>
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
      <?=$this->Html->link("Listado", "/Gerencias", ["class" => "btn btn-default"]);?>
   </div>
</div>


<!--<?=$this->Form->hidden("id")?>
 <?=$this->Form->hidden("idgrem")?>
-->
<?=$this->Form->end()?>
