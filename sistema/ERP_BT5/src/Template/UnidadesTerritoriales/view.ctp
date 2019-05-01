<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Unidades Territoriales</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "id", "readonly" => true, 'placeholder' => 'Id']);?>
         <label for="idpais" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idpais", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idpais", "readonly" => true, 'placeholder' => 'País']);?>
         <label for="iduntepadre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("iduntepadre", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "iduntepadre", "readonly" => true, 'placeholder' => 'U.Territorial Padre']);?>
         <label for="nombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "nombre", "readonly" => true, 'placeholder' => 'Nombre']);?>
         <label for="orden" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("orden", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "orden", "readonly" => true, 'placeholder' => 'Órden']);?>
         <label for="profundidad" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("profundidad", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "profundidad", "readonly" => true, 'placeholder' => 'Profundidad']);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>UnidadesTerritoriales/index" class="btn dark inverse">Volver</a>
</div>
</div>

