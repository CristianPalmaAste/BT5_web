<?php
/**
  * @var \App\View\AppView $this
  * @var \App\Model\Entity\TiposDocumentosLegale[]|\Cake\Collection\CollectionInterface $tiposDocumentosLegales
  */
?>

<?php echo $this->BForm->formHeader( 'Tipos Documentos Legales' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>tipos-documentos-legales/add" class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo Tipo de Documento Legal</a>
   </div>
</div>

<?php echo $this->BForm->initForm( 'Tipos de Documentos Legales',array(
      $this->Paginator->sort('descripcion','Descripción'),
      'Color',
      'Acciones'
      )
   );
?>

<?php foreach ($tiposDocumentosLegales as $tiposDocumentosLegale): ?>
   <tr>
   <td><?= h($tiposDocumentosLegale->descripcion) ?></td>
   <td><span style="background:<?=$tiposDocumentosLegale->color?>;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
   <td>
         <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $tiposDocumentosLegale->id],['data-toggle'=>'tooltip','title'=>'Ver','escape' => false]) ?>
         <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $tiposDocumentosLegale->id],['data-toggle'=>'tooltip','title'=>'Editar','escape' => false]) ?>
         <?= $this->Html->link('<i class="pe-7f-trash"></i>', ['action' => 'delete', $tiposDocumentosLegale->id], array('confirm' => __('¿Está seguro que desea eliminar el documento ID {0}?', $tiposDocumentosLegale->id), 'escape' => false, 'title' => 'Eliminar')) ?>
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
