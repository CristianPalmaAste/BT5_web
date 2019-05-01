<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Mantención de Clientes</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idgrem")?>
         <label for="identificador1" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador1", ["size" => 50, "maxlength" => 50, "class" => "stacked-input", "id" => "identificador1", "readonly" => true, 'placeholder' => 'Rut']);?>
         <label for="identificador2" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("identificador2", ["size" => 50, "maxlength" => 50, "class" => "stacked-input", "id" => "identificador2", "readonly" => true, 'placeholder' => 'Dv']);?>
         <label for="idticl" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idticl", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idticl", "readonly" => true, 'placeholder' => 'Tipo ']);?>
         <label for="razonsocial" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("razonsocial", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "razonsocial", "readonly" => true, 'placeholder' => 'Razón social']);?>
         <label for="nombrefantasia" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombrefantasia", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "nombrefantasia", "readonly" => true, 'placeholder' => 'Nombre fantasía']);?>
         <label for="primernombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("primernombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "primernombre", "readonly" => true, 'placeholder' => 'Primer nombre']);?>
         <label for="segundonombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("segundonombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "segundonombre", "readonly" => true, 'placeholder' => 'Segundo nombre']);?>
         <label for="apellidopaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidopaterno", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "apellidopaterno", "readonly" => true, 'placeholder' => 'Apellido paterno']);?>
         <label for="apellidomaterno" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("apellidomaterno", ["size" => 100, "maxlength" => 100, "class" => "stacked-input", "id" => "apellidomaterno", "readonly" => true, 'placeholder' => 'Apellido materno']);?>
         <label for="idpais" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idpais", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idpais", "readonly" => true, 'placeholder' => 'País']);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Clientes/index" class="btn dark inverse">Volver</a>
</div>
</div>

