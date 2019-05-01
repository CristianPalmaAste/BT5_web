<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>usuarios</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "id", "readonly" => true]);?>
         <label for="username" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("username", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "username", "readonly" => true]);?>
         <label for="password" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("password", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "password", "readonly" => true]);?>
         <label for="idpers" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idpers", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "idpers", "readonly" => true]);?>
         <label for="idesre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idesre", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "idesre", "readonly" => true]);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Usuarios/index" class="btn dark inverse">Volver</a>
</div>
</div>

