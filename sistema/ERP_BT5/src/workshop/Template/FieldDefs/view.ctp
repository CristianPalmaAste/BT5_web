<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>NONAME</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "id", "readonly" => true]);?>
         <label for="form_id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("form_id", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "form_id", "readonly" => true]);?>
         <label for="forder" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("forder", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "forder", "readonly" => true]);?>
         <label for="name" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("name", ["size" => 30, "maxlength" => 30, "class" => "stacked-input", "id" => "name", "readonly" => true]);?>
         <label for="type" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("type", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "type", "readonly" => true]);?>
         <label for="len" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("len", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "len", "readonly" => true]);?>
         <label for="decim" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("decim", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "decim", "readonly" => true]);?>
         <label for="pk" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("pk", ["size" => 1, "maxlength" => 1, "class" => "stacked-input", "id" => "pk", "readonly" => true]);?>
         <label for="req" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("req", ["size" => 1, "maxlength" => 1, "class" => "stacked-input", "id" => "req", "readonly" => true]);?>
         <label for="caption" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("caption", ["size" => 50, "maxlength" => 50, "class" => "stacked-input", "id" => "caption", "readonly" => true]);?>
         <label for="gadget" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("gadget", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "gadget", "readonly" => true]);?>
         <label for="size" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("size", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "size", "readonly" => true]);?>
         <label for="maxlength" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("maxlength", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "maxlength", "readonly" => true]);?>
         <label for="rows" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("rows", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "rows", "readonly" => true]);?>
         <label for="cols" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("cols", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "cols", "readonly" => true]);?>
         <label for="selvalues" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("selvalues", ["size" => 500, "maxlength" => 500, "class" => "stacked-input", "id" => "selvalues", "readonly" => true]);?>
         <label for="sqlvalues" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("sqlvalues", ["size" => 500, "maxlength" => 500, "class" => "stacked-input", "id" => "sqlvalues", "readonly" => true]);?>
         <label for="visible" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("visible", ["size" => 1, "maxlength" => 1, "class" => "stacked-input", "id" => "visible", "readonly" => true]);?>
         <label for="readonly" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("readonly", ["size" => 1, "maxlength" => 1, "class" => "stacked-input", "id" => "readonly", "readonly" => true]);?>
         <label for="fld_type" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("fld_type", ["size" => 1, "maxlength" => 1, "class" => "stacked-input", "id" => "fld_type", "readonly" => true]);?>
         <label for="fld_offset" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("fld_offset", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "fld_offset", "readonly" => true]);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>FieldDefs/index" class="btn dark inverse">Volver</a>
</div>
</div>

