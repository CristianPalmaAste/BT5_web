<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>usuarios_perfiles</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "id", "readonly" => true, 'placeholder' => 'id']);?>
         <label for="idusua" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idusua", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idusua", "readonly" => true, 'placeholder' => 'idusua']);?>
         <label for="idperf" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idperf", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idperf", "readonly" => true, 'placeholder' => 'idperf']);?>
         <label for="idgrem" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idgrem", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idgrem", "readonly" => true, 'placeholder' => 'idgrem']);?>
         <label for="idempr" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idempr", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idempr", "readonly" => true, 'placeholder' => 'idempr']);?>
         <label for="idesre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idesre", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idesre", "readonly" => true, 'placeholder' => 'idesre']);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>UsuariosPerfiles/index" class="btn dark inverse">Volver</a>
</div>
</div>

