<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Mantención de Centros de Costo</h3>
         </div>
      </header>

      <div class="widget__content">
         <!--<label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>-->
         <label for="id" class="stacked-label" style="width:100px">Id</label>
         <?=$this->Form->text("id", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "id", "readonly" => true, "style" => "width:584px"]);?>
         
         <?=$this->Form->hidden("idempr")?>

         <!--<label for="nombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>-->

        <label for="nombre" class="stacked-label" style="width:100px">Nombre</label>   
         <?=$this->Form->text("nombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "nombre", "readonly" => true, "style" => "width:584px"]);?>

     </div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>CentrosCostos/index" class="btn dark inverse">Volver</a>
</div>
</div>

