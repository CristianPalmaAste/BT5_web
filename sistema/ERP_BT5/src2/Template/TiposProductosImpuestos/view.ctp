<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Tipos de producto tipo de impuesto</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <label for="idtipr" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idtipr", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idtipr", "readonly" => true, 'placeholder' => 'Tipo de producto']);?>
         <label for="idimpu" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idimpu", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idimpu", "readonly" => true, 'placeholder' => 'Tipo de impuesto']);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>TiposProductosImpuestos/index" class="btn dark inverse">Volver</a>
</div>
</div>

