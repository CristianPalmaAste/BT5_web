<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Comunas</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <label for="idunt2" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idunt2", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idunt2", "readonly" => true, 'placeholder' => 'Provincia']);?>
         <label for="nombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "nombre", "readonly" => true, 'placeholder' => 'Nombre']);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>UnidadesTerritoriales3/index" class="btn dark inverse">Volver</a>
</div>
</div>

