<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>valores_dominios</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "id", "readonly" => true, 'placeholder' => 'id']);?>
         <label for="iddomi" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("iddomi", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "iddomi", "readonly" => true, 'placeholder' => 'iddomi']);?>
         <label for="descripcion" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("descripcion", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "descripcion", "readonly" => true, 'placeholder' => 'descripcion']);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>ValoresDominios/index" class="btn dark inverse">Volver</a>
</div>
</div>

