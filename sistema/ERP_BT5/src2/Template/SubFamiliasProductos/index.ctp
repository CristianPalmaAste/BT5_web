<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/SubFamiliasProductos/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Sub.Familias de Productos' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>SubFamiliasProductos/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'Sub.Familias de Productos',array(
        $this->Paginator->sort('cod_familia', 'Código'),
        $this->Paginator->sort('idfapr', 'Familia'),
        $this->Paginator->sort('cod_sub_familia', 'Código'),
        $this->Paginator->sort('descripcion', 'Descripción'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("idfapr", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idfapr"]);?></td>
<td><?=$this->Form->text("cod_sub_familia", ["size" => 2, "maxlength" => 2, "class" => "stacked-input upper", "id" => "cod_sub_familia"]);?></td>
<td><?=$this->Form->text("descripcion", ["size" => 20, "maxlength" => 100, "class" => "stacked-input upper", "id" => "descripcion"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
	     <td><?=h($g->cod_familia)?></td> 
         <td><?=h($g->familia)?></td>
         <td><?=h($g->cod_sub_familia)?></td>
         <td><?=h($g->sub_familia)?></td>
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
