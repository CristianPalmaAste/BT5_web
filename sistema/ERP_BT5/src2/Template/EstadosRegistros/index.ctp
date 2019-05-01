<?=$this->Form->create('EstadosRegistros', ["class" => "form-horizontal", 'url' => '/EstadosRegistros/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Mantención de Estados de los Registros' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
</div>
<?php echo $this->BForm->initForm( 'Mantención de Estados de los Registros',array(
      $this->Paginator->sort('descripcion', 'Descripción'),
      'Acciones'
      )
   );
?>

<?php foreach ($registros as $estadoRegistro): ?>
   <tr>
   <td><?= h($estadoRegistro->descripcion) ?></td>
   <td>
      <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $estadoRegistro->id],['data-toggle'=>'tooltip','title'=>'Ver','escape' => false]) ?>
      <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $estadoRegistro->id],['data-toggle'=>'tooltip','title'=>'Editar','escape' => false]) ?>
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
