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
         <label for="caption" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("caption", ["size" => 50, "maxlength" => 50, "class" => "stacked-input", "id" => "caption", "readonly" => true]);?>
         <label for="table_name" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("table_name", ["size" => 30, "maxlength" => 30, "class" => "stacked-input", "id" => "table_name", "readonly" => true]);?>
         <label for="ins_allowed" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("ins_allowed", ["size" => 1, "maxlength" => 1, "class" => "stacked-input", "id" => "ins_allowed", "readonly" => true]);?>
         <label for="upd_allowed" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("upd_allowed", ["size" => 1, "maxlength" => 1, "class" => "stacked-input", "id" => "upd_allowed", "readonly" => true]);?>
         <label for="del_allowed" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("del_allowed", ["size" => 1, "maxlength" => 1, "class" => "stacked-input", "id" => "del_allowed", "readonly" => true]);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>FormDefs/index" class="btn dark inverse">Volver</a>
</div>
</div>

