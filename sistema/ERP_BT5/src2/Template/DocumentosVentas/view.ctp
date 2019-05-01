<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>documentos_ventas</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "id", "readonly" => true, 'placeholder' => 'id']);?>
         <label for="idempr" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idempr", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idempr", "readonly" => true, 'placeholder' => 'idempr']);?>
         <label for="idnove" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idnove", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idnove", "readonly" => true, 'placeholder' => 'idnove']);?>
         <label for="idtidv" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idtidv", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idtidv", "readonly" => true, 'placeholder' => 'idtidv']);?>
         <label for="numero" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("numero", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "numero", "readonly" => true, 'placeholder' => 'numero']);?>
         <label for="idclie" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idclie", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idclie", "readonly" => true, 'placeholder' => 'idclie']);?>
         <label for="descripciondoctoventa" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("descripciondoctoventa", ["size" => 1000, "maxlength" => 1000, "class" => "stacked-input", "id" => "descripciondoctoventa", "readonly" => true, 'placeholder' => 'descripciondoctoventa']);?>
         <label for="idgere" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idgere", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idgere", "readonly" => true, 'placeholder' => 'idgere']);?>
         <label for="idproy" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idproy", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idproy", "readonly" => true, 'placeholder' => 'idproy']);?>
         <label for="idline" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idline", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idline", "readonly" => true, 'placeholder' => 'idline']);?>
         <label for="idceco" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idceco", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idceco", "readonly" => true, 'placeholder' => 'idceco']);?>
         <label for="idtare" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idtare", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idtare", "readonly" => true, 'placeholder' => 'idtare']);?>
         <label for="subtotal" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("subtotal", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "subtotal", "readonly" => true, 'placeholder' => 'subtotal']);?>
         <label for="porcentajedescuento" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("porcentajedescuento", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "porcentajedescuento", "readonly" => true, 'placeholder' => 'porcentajedescuento']);?>
         <label for="montodescuento" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("montodescuento", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "montodescuento", "readonly" => true, 'placeholder' => 'montodescuento']);?>
         <label for="valorimpuestos" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("valorimpuestos", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "valorimpuestos", "readonly" => true, 'placeholder' => 'valorimpuestos']);?>
         <label for="total" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("total", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "total", "readonly" => true, 'placeholder' => 'total']);?>
         <label for="idesve" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("idesve", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "idesve", "readonly" => true, 'placeholder' => 'idesve']);?>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>DocumentosVentas/index" class="btn dark inverse">Volver</a>
</div>
</div>

