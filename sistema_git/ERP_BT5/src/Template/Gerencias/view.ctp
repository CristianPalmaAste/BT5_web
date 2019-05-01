<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Mantención de Gerencias</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "id", "readonly" => true, 'placeholder' => 'id']);?>
         <?=$this->Form->hidden("idempr")?>
         <label for="nombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "nombre", "readonly" => true, 'placeholder' => 'Nombre']);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Gerencias/index" class="btn dark inverse">Volver</a>
</div>
</div>

