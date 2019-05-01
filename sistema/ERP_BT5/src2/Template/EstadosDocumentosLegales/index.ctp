<?php
/**
  * @var \App\View\AppView $this
  * @var \App\Model\Entity\EstadosDocumentosLegale[]|\Cake\Collection\CollectionInterface $estadosDocumentosLegales
  */
?>

<?php echo $this->BForm->formHeader( 'Estados Documentos Legales' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>estados-documentos-legales/add" class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo Estado de Documento Legal</a>
   </div>
</div>

<?php echo $this->BForm->initForm( 'Estados de Documentos Legales',array(
      $this->Paginator->sort('id','Id'),
      $this->Paginator->sort('descripcion','Descripción'),
      'Acciones'
      )
   );
?>

<?php foreach ($estadosDocumentosLegales as $estadosDocumentosLegale): ?>
   <tr>
   <td><?= h($estadosDocumentosLegale->id) ?></td>
   <td><?= h($estadosDocumentosLegale->descripcion) ?></td>
   <td>
         <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $estadosDocumentosLegale->id],['data-toggle'=>'tooltip','title'=>'Ver','escape' => false]) ?>
         <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $estadosDocumentosLegale->id],['data-toggle'=>'tooltip','title'=>'Editar','escape' => false]) ?>
         <?= $this->Html->link('<i class="pe-7f-trash"></i>', ['action' => 'delete', $estadosDocumentosLegale->id], array('confirm' => __('¿Está seguro que desea eliminar el documento ID {0}?', $estadosDocumentosLegale->id), 'escape' => false, 'title' => 'Eliminar')) ?>
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
