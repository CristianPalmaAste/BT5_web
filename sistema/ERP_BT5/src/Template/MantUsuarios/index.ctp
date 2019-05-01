<?=$this->Form->create('MantenedorUsuarios', ["class" => "form-horizontal", 'url' => '/Usuarios/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Mantenedor de Usuarios' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>MantUsuarios/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>

<?php echo $this->BForm->initForm( 'Mantenedor de Usuarios',array(
      $this->Paginator->sort('username', 'Usuario'),
      $this->Paginator->sort('nombre_persona', 'Nombre'),
      $this->Paginator->sort('estado_registro', 'Estado'),
      'Acciones'
   )
);
?>

<?php foreach($registros as $g):?>
      <tr>
         <td><?=h($g["username"])?></td>
         <td><?=h($g["nombre_persona"])?></td>
         <td><?=h($g["estado_registro"])?></td>
         <td align='center'>
            <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $g["id"]],array('escape' => false, 'title' => 'Ver')) ?>
            <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $g["id"]],array('escape' => false, 'title' => 'Editar')) ?>
            <?= $this->Html->link('<i class="pe-7f-trash"></i>', ['action' => 'delete', $g["id"]], array('confirm' => __('¿Está seguro que desea eliminar el documento ID {0}?', $g["id"]), 'escape' => false, 'title' => 'Eliminar')) ?>
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
