<?php
/**
  * @var \App\View\AppView $this
  * @var \App\Model\Entity\CotizacionesVenta[]|\Cake\Collection\CollectionInterface $cotizacionesVentas
  */
?>

<?php echo $this->BForm->formHeader( 'Documentos de Ventas' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
<?php $nuevo = $this->request->webroot.$this->name.'/add'; ?>
   <?= $this->Form->button('<i class="pe-mi-add"></i> Nuevo Documento de Venta',[
      'type'=>'button',
      'onclick'=>"window.location.href='$nuevo'",
      'style'=>'width:100%;display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
   ])?>
</div>

<div class="col-md-8 text-center btn-vars__showcase">
   <?=$this->form->create('Documentos de Ventas')?>
   <?= $this->Form->input('searchBy', array(
         'type' => 'select',
         'label' => false,
         'style' => 'width:22%;display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;',
         'id' => 'searchBy',
         'class' => 'pull-left',
         'empty' => 'Buscar por...',
         'options' => $searchOptions
      )
   )?>
   <?php $limpiar = $this->request->webroot.$this->name; ?>
   <?= $this->Form->button('<i class="pe-mi-refresh"></i> Limpiar filtro',[
      'type'=>'button',
      'onclick'=>"window.location.href='$limpiar'",
      'style'=>'width:22%;display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
   ])?>

   <div class="main-search pull-right">
      <input type="text" placeholder="Buscar ..." id="search" name="search" class="pull-right uppper">
      <button>
         <i class="pe-7s-search"></i>
      </button>
   </div>

   <?=$this->Form->end()?>
</div>

<?php echo $this->BForm->initForm( 'Documentos de Ventas',array(
      $this->Paginator->sort('numero','Número'),
      $this->Paginator->sort('fechacotizacion','Fecha'),
	  $this->Paginator->sort('idclie','Cliente'),
      $this->Paginator->sort('idesve','Estado'),
	  $this->Paginator->sort('total','Total'),
      'Acciones'
      )
   );
?>

<?php foreach ($cotizaciones as $cotizacion): ?>
   <tr>
      <td align="right"><?= $cotizacion->numero ?></td>
      <td><?= $this->Time->format($cotizacion->fechacotizacion,'d/MM/Y') ?></td>
      <td><?= $cotizacion->cliente ?></td>
      <td align="center"><?= $cotizacion->estado ?></td>
	  <td align="right">$<?= number_format($cotizacion->total, 0, ",", ".") ?></td>
      <td>
         <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $cotizacion->id],array('escape' => false,'data-toggle'=>"tooltip", 'title'=>"Ver")) ?>
         <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $cotizacion->id],array('escape' => false,'data-toggle'=>"tooltip", 'title'=>"Editar")) ?>
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
        <p><?= $this->Paginator->counter(['format' => __('Página {{page}} de {{pages}}, mostrando {{current}} registro(s) de {{count}} en total')]) ?></p>
    </div>
    