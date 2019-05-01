<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/BodegasProductos/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Bodegas y Productos' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>BodegasProductos/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'Bodegas y Productos',array(
        $this->Paginator->sort('idbode', 'Bodega'),
        $this->Paginator->sort('idprod', 'Producto'),
        $this->Paginator->sort('stock', 'Stock'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("idbode", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idbode"]);?></td>
<td><?=$this->Form->text("idprod", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idprod"]);?></td>
<td><?=$this->Form->text("stock", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "stock"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($bodegas[$g->idbode])?></td>
         <td><?=h($productos[$g->idprod])?></td>
         <td><?=h($g->stock)?></td>
         <td align='center'>
            <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $g->id],array('escape' => false, 'title' => 'Ver')) ?>
            <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $g->id],array('escape' => false, 'title' => 'Editar')) ?>
            <?= $this->Html->link('<i class="pe-7f-trash"></i>', ['action' => 'delete', $g->id], array('confirm' => __('¿Está seguro que desea eliminar el documento ID {0}?', $g->id), 'escape' => false, 'title' => 'Eliminar')) ?>
         </td>
     </tr>
     <tr class='spacer'></tr>
<?php endforeach; ?>

<?php echo $this->BForm->closeForm(); ?>
<div class="paginator">
   <ul class="pagination">
      <?= $this->Paginator->first('<< ' . __('Primero')) ?>
      <?= $this->Paginator->prev('< ' . __('Anterior')) ?>
      <?= $this->Paginator->numbers() ?>
      <?= $this->Paginator->next(__('Siguiente') . ' >') ?>
      <?= $this->Paginator->last(__('Último') . ' >>') ?>
    </ul>
<p><?=$this->Paginator->counter('Página {{page}} de {{pages}}') ?></p>
<?php echo $this->Html->image("excel.png", [
                       "alt" => "Bajada a excel",
                       'url' => ['action' => 'excel']
                       ]);
?>
</div>
<?=$this->Form->end();?>
