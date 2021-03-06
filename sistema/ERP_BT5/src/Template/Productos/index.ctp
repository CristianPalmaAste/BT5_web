<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/Productos/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Productos' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>Productos/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'Productos',array(
        $this->Paginator->sort('cod_prod_alfanum', 'Código'),
        $this->Paginator->sort('nombre', 'Descripción'),
        $this->Paginator->sort('nombre_familia', 'Familia'),
        $this->Paginator->sort('nombre_sub_familia', 'Sub.Familia'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("cod_prod_alfanum", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "cod_prod_alfanum"]);?></td>
<td><?=$this->Form->text("nombre", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "nombre"]);?></td>
<td><?=$this->Form->text("nombre_familia", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "nombre_familia"]);?></td>
<td><?=$this->Form->text("nombre_sub_familia", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "nombre_sub_familia"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->cod_prod_alfanum)?></td>
         <td><?=h($g->nombre)?></td>
         <td><?=h($g->nombre_familia)?></td>
         <td><?=h($g->nombre_sub_familia)?></td>
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
