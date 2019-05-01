<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>empresas</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "id", "readonly" => true]);?>
         <label for="idgrem" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idgrem", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "idgrem", "readonly" => true]);?>
         <label for="idpais" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idpais", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "idpais", "readonly" => true]);?>
         <label for="idrubr" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idrubr", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "idrubr", "readonly" => true]);?>
         <label for="idesre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idesre", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "idesre", "readonly" => true]);?>
         <label for="identificador1" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador1", ["size" => 50, "maxlength" => 50, "class" => "stacked-input", "id" => "identificador1", "readonly" => true]);?>
         <label for="identificador2" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador2", ["size" => 50, "maxlength" => 50, "class" => "stacked-input", "id" => "identificador2", "readonly" => true]);?>
         <label for="razonsocial" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("razonsocial", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "razonsocial", "readonly" => true]);?>
         <label for="nombrefantasia" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombrefantasia", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "nombrefantasia", "readonly" => true]);?>
         <label for="icono" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("icono", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "icono", "readonly" => true]);?>
         <label for="xfld" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("xfld", ["size" => 250, "maxlength" => 250, "class" => "stacked-input", "id" => "xfld", "readonly" => true]);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Empresas/index" class="btn dark inverse">Volver</a>
</div>
</div>

