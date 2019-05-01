<?php
/**
  * @var \App\View\AppView $this
  * @var \App\Model\Entity\CotizacionesVenta[]|\Cake\Collection\CollectionInterface $cotizacionesVentas
  */
?>

<?php echo $this->BForm->formHeader( 'Cotizaciones' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
<?php $nuevo = $this->request->webroot.$this->name.'/add'; ?>
   <?= $this->Form->button('<i class="pe-mi-add"></i> Nueva Cotización',[
      'type'=>'button',
      'onclick'=>"window.location.href='$nuevo'",
      'style'=>'width:100%;display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
   ])?>
</div>

<div class="col-md-8 text-center btn-vars__showcase">
   <?=$this->form->create('CotizacionesVentas')?>
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

<?php echo $this->BForm->initForm( 'Cotizaciones',array(
      $this->Paginator->sort('numero_cotiz','Número'),
      $this->Paginator->sort('empresa','Empresa'),
      $this->Paginator->sort('cliente','Cliente'),
      $this->Paginator->sort('estado_cotiz','Estado'),
      $this->Paginator->sort('diasvalidez','Validez'),
      'Acciones'
      )
   );
?>

<?php foreach ($cotizaciones as $cotizacion): ?>
   <tr>
      <td><?= $cotizacion->numero_cotiz ?></td>
      <td><?= $cotizacion->empresa ?></td>
      <td><?= $cotizacion->cliente ?></td>
      <td><?= $cotizacion->estado_cotiz ?></td>
      <td><?= $cotizacion->diasvalidez ?></td>
      <td>
         <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $cotizacion->id],array('escape' => false,'data-toggle'=>"tooltip", 'title'=>"Ver")) ?>
         <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $cotizacion->id],array('escape' => false,'data-toggle'=>"tooltip", 'title'=>"Editar")) ?>
         <?= $this->Form->postLink('<i class="pe-7f-trash"></i>',
               ['action' => 'delete',$cotizacion->id,],
               ['confirm' => __('¿Está seguro que desea eliminar la cotización {0}?',$cotizacion->numero_cotiz),'escape' => false,'data-toggle'=>"tooltip", 'title'=>"Eliminar"]
            )
         ?>
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
    