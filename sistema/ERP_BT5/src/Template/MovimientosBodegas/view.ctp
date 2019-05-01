<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Movimientos de Bodegas</h3>
         </div>
      </header>

         <div class="members__container">
            <div class="media message checked">
               <div class="media-body">
                  <h5 class="media-heading message__heading"></h5>
                  <p class="message__location">
                     <i class="pe-7s-date"></i> <?= $gre['nombre'] ?>
                  </p>
                  <input type="checkbox" class="btn-more-check" id="more1" checked>
                  <label class="c-btn--more" for="more1"></label>


                  <div class="message__details">
                     <table>
                        <tr>
                          <td>Correlativo Interno:</td>
                           <td><?= $gre['id']  ?><input type="hidden" name="id" value="<?= $gre["id"]?>"/></td>
                        <tr>
                        <tr>
                           <td>Nombre Bodega:</td>
                           <td><?= $gre['nombre'] ?></td>
                        <tr>

                  </table>
               </div>
            </div>

</div>

</article>

<table class="table">
<thead>
<tr>
    <th width="50%">Fecha</th>
    <th width="50%">Tipo de Movimiento</th>
	<th width="50%">Entradas</th>
	<th width="50%">Salidas</th>
</tr>
</thead>
<tbody>
<?php foreach($registros as $r): ?>
   <tr><td><?=$r["fecha_movto"]?></td>
       <td><?=$r["movto_bodega"]?></td>
	   <?php if ($r["movto_bodega"]=="COMPRA"):?>
          <td><?=number_format($r["cantidad"], 0, ",", ".")?></td>
		  <td>&nbsp;</td>
	   <?php else: ?>
	      <td>&nbsp;</td>	
          <td><?=number_format($r["cantidad"], 0, ",", ".")?></td>   
	   <?php endif; ?>
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
<a href="<?=$this->request->webroot?>DetallesMovtosBodegas/index" class="btn dark inverse">Volver</a>
</div>
</div>

