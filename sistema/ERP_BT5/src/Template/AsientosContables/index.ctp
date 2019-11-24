<?php
/**
  * @var \App\View\AppView $this
  * @var \App\Model\Entity\CotizacionesVenta[]|\Cake\Collection\CollectionInterface $registroesVentas
  */
?>

<?php echo $this->BForm->formHeader( 'Asientos Contables' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
<?php $nuevo = $this->request->webroot.$this->name.'/add'; ?>
   <?= $this->Form->button('<i class="pe-mi-add"></i> Nuevo Asiento Contable',[
      'type'=>'button',
      'onclick'=>"window.location.href='$nuevo'",
      'style'=>'width:100%;display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
   ])?>
</div>

<div class="col-md-8 text-center btn-vars__showcase">
   <?=$this->form->create('AsientosContables')?>
   <?= $this->Form->input('searchBy', array(
         'type' => 'select',
         'label' => false,
         'style' => 'width:22%;display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;',
         'id' => 'searchBy',
         'class' => 'pull-left',
         'empty' => 'Buscar por...',
         'options' => isset($searchOptions)?$searchOptions:[]
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

<?php echo $this->BForm->initForm( 'Asientos Contables',array(
      $this->Paginator->sort('numero_asiento','Número'),
      $this->Paginator->sort('fecha_asiento','Fecha'),
	  $this->Paginator->sort('glosa','Glosa'),
	  $this->Paginator->sort('idtiac','Tipo'),
      $this->Paginator->sort('idesac','Estado'),
      'Acciones'
      )
   );
?>

<?php foreach ($registros as $registro): ?>
   <tr>
      <td align="right"><?= $registro->numero_asiento ?></td>
      <td><?= $this->Time->format($registro->fecha_asiento,'d/MM/Y') ?></td>
	  <td><?= $registro->glosa ?></td>
      <td><?= $tipos_asientos_contables[$registro->idtiac] ?></td>
      <td align="center"><?= $estados_asientos_contables[$registro->idesac]?></td>
      <td>
         <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $registro->id],array('escape' => false,'data-toggle'=>"tooltip", 'title'=>"Ver")) ?>
         <?php echo $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $registro->id],array('escape' => false,'data-toggle'=>"tooltip", 'title'=>"Editar")); ?>
         <?php if ($registro->idesnv==1) echo $this->Html->link('<i class="pe-7f-trash"></i>', ['action' => 'delete', $registro->id], array('confirm' => __('¿Está seguro que desea eliminar el documento ID {0}?', $registro->id), 'escape' => false, 'title' => 'Eliminar')); ?>
		 <?php if ($registro->idesnv==1) echo $this->Html->link('Cerrar Docto.', ['action' => 'cerrar', $registro->id], array('confirm' => __('¿Está seguro que desea cerrar el documento ID {0}?', $registro->id), 'escape' => false, 'title' => 'Cerrar Docto.')); ?>
 		 <?php if ($registro->idesnv==2) echo $this->Html->link('Emitir Docto.', ['action' => 'emitir', $registro->id], array('confirm' => __('¿Está seguro que desea emitir el documento ID {0}?', $registro->id), 'escape' => false, 'title' => 'Emitir Docto.')); ?>
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
    