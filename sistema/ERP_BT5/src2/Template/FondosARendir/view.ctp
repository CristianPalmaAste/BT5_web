<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Fondos a Rendir</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idempr")?>
         <label for="correlativo" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("correlativo", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "correlativo", "readonly" => true, 'placeholder' => 'Correlativo']);?>
         <label for="monto" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("monto", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "monto", "readonly" => true, 'placeholder' => 'Monto']);?>
         <label for="idgere" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idgere", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idgere", "readonly" => true, 'placeholder' => 'Gerencia']);?>
         <label for="idproy" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idproy", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idproy", "readonly" => true, 'placeholder' => 'Proyecto']);?>
         <label for="idline" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idline", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idline", "readonly" => true, 'placeholder' => 'Línea de negocios']);?>
         <label for="idceco" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idceco", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idceco", "readonly" => true, 'placeholder' => 'Centro de costos']);?>
         <label for="idtare" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idtare", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idtare", "readonly" => true, 'placeholder' => 'Tarea']);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>FondosARendir/index" class="btn dark inverse">Volver</a>
</div>
</div>

