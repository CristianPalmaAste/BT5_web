<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Bitácora de Cambios de Precios</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id", ["value" => $r["id"]])?>
		 <label for="cod_prod_alfanum" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("cod_prod_alfanum", ["value" => $r["cod_prod_alfanum"], 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'])?>
         <label for="producto" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("producto", ["value" => $r["nombre"], 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'])?>
         <!--<label for="preciounitario" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("preciounitario", ["value" => "$".number_format($r["preciounitario"], 0, ",", "."), 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
		 -->

     </div>

</article>

<table class="table">
<thead>
<tr>
    <th width="50%">Fecha de Cambio</th>
    <th width="50%">Precio Unitario</th>
</tr>
</thead>
<tbody>
<?php foreach($registros as $r): ?>
   <tr><td><?=$r["fecha_cambio"]?></td>
       <td><?="$".number_format($r["preciounitario"], 0, ",", ".")?></td>
   </tr>
<?php endforeach;?>
</tbody>
</table>

<div class="paginator">
   <ul class="pagination">
      <?= $this->Paginator->first('<< ' . __('Primero')) ?>
      <?= $this->Paginator->prev('< ' . __('Anterior')) ?>
      <?= $this->Paginator->numbers() ?>
      <?= $this->Paginator->next(__('Siguiente') . ' >') ?>
      <?= $this->Paginator->last(__('Último') . ' >>') ?>
    </ul>
<p><?=$this->Paginator->counter('Página {{page}} de {{pages}}') ?></p>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>BitacorasCambiosPrecios/index" class="btn dark inverse">Volver</a>
</div>
</div>

