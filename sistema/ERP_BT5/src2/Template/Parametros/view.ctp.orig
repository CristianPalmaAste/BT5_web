<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Mantención de Parámetros</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idgrem")?>
         <label for="nombrecorto" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombrecorto", ["size" => 50, "maxlength" => 50, "class" => "stacked-input", "id" => "nombrecorto", "readonly" => true, 'placeholder' => 'Nombre corto']);?>
         <label for="nombrelargo" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombrelargo", ["size" => 500, "maxlength" => 500, "class" => "stacked-input", "id" => "nombrelargo", "readonly" => true, 'placeholder' => 'Nombre largo']);?>
         <label for="descripcion" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("descripcion", ["size" => 1000, "maxlength" => 1000, "class" => "stacked-input", "id" => "descripcion", "readonly" => true, 'placeholder' => 'Descripcion']);?>
         <label for="valor" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("valor", ["size" => 500, "maxlength" => 500, "class" => "stacked-input", "id" => "valor", "readonly" => true, 'placeholder' => 'Valor']);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Parametros/index" class="btn dark inverse">Volver</a>
</div>
</div>

