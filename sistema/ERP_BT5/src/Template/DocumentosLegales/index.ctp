<?php
/**
  * @var \App\View\AppView $this
  * @var \App\Model\Entity\DocumentosLegale[]|\Cake\Collection\CollectionInterface $documentosLegales
  */
?>

<?php echo $this->BForm->formHeader( 'Documentos Legales' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
<?php $nuevo = $this->request->webroot.$this->name.'/add'; ?>
   <?= $this->Form->button('<i class="pe-mi-add"></i> Nuevo Documento Legal',[
      'type'=>'button',
      'onclick'=>"window.location.href='$nuevo'",
      'style'=>'width:100%;display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
   ])?>
</div>

<div class="col-md-8 text-center btn-vars__showcase">
   <?=$this->form->create('DocumentosLegales')?>
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

<?php echo $this->BForm->initForm( 'Documentos Legales',array(
      $this->Paginator->sort('fecha','Fecha'),
      $this->Paginator->sort('tipodocumentolegal','Tipo Documento'),
      $this->Paginator->sort('estadodocumentolegal','Estado Documento'),
      $this->Paginator->sort('notaria','Notaría'),
      $this->Paginator->sort('foja','Foja'),
      $this->Paginator->sort('responsable','Responsable'),
      $this->Paginator->sort('nombreoriginal','Nombre Original'),
      $this->Paginator->sort('fechaaviso','Fecha Aviso'),
      'Acciones'
      )
   );
?>

<?php foreach ($documentosLegales as $documento): ?>
   <tr>
      <td><?= $this->Time->format($documento->fecha,'d-MM-Y') ?></td>
      <td><?= $documento->tipodocumentolegal ?></td>
      <td><?= $documento->estadodocumentolegal ?></td>
      <td><?= h($documento->notaria) ?></td>
      <td><?= h($documento->foja) ?></td>
      <td><?= h($documento->responsable) ?></td>
      <td><?= $this->Html->link($documento['nombreoriginal'], $basePath.$documento['nombresistema'],array('target'=>'_blank','style'=>'color:#FFFFFF;text-decoration: underline;')) ?></td>
      <td><?= $this->Time->format($documento->fechaaviso,'d-MM-Y') ?></td>
      <td>
         <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $documento->id],array('escape' => false,'data-toggle'=>"tooltip", 'title'=>"Ver")) ?>
         <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $documento->id],array('escape' => false,'data-toggle'=>"tooltip", 'title'=>"Editar")) ?>
         <?= $this->Html->link('<i class="pe-7f-trash"></i>', ['action' => 'delete', $documento->id], array('confirm' => __('¿Está seguro que desea eliminar el documento ID {0}?', $documento->id), 'escape' => false, 'title' => 'Eliminar')) ?>
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
