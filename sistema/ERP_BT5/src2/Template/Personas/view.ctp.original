<?= $this->Form->create($persona) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Mantención de Personas</h3>
         </div>
      </header>

      <div class="widget__content">

         <label for="identificador1" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador1", ["size" => 50, "maxlength" => 50, "class" => "stacked-input", "id" => "identificador1", "readonly" => true]);?>
         <label for="identificador2" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador2", ["size" => 50, "maxlength" => 50, "class" => "stacked-input", "id" => "identificador2", "readonly" => true]);?>
         <label for="primernombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("primernombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "primernombre", "readonly" => true]);?>
         <label for="segundonombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("segundonombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "segundonombre", "readonly" => true]);?>
         <label for="apellidopaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidopaterno", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "apellidopaterno", "readonly" => true]);?>
         <label for="apellidomaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidomaterno", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "apellidomaterno", "readonly" => true]);?>
         <label for="email" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("email", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "email", "readonly" => true]);?>
         <label for="fechanac" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("fechanac", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "fechanac", "readonly" => true]);?>
         <label for="idesci" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idesci", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "idesci", "readonly" => true, "value" => $eciviles[$persona->idesci]]);?>
         <label for="idsexo" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idsexo", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "idsexo", "readonly" => true, "value" => $sexos[$persona->idsexo]]);?>
         <label for="idpais" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idpais", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "idpais", "readonly" => true, "value" => $paises[$persona->idpais]]);?>


         <?=$this->Form->hidden("id");?>
         <?=$this->Form->hidden("idgrem");?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Personas/index" class="btn dark inverse">Volver</a>
</div>
</div>

