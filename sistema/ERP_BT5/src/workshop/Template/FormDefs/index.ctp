<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/FormDefs/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'NONAME' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>FormDefs/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'NONAME',array(
        $this->Paginator->sort('id', 'id'),
        $this->Paginator->sort('caption', 'caption'),
        $this->Paginator->sort('table_name', 'table_name'),
        $this->Paginator->sort('ins_allowed', 'ins_allowed'),
        $this->Paginator->sort('upd_allowed', 'upd_allowed'),
        $this->Paginator->sort('del_allowed', 'del_allowed'),
            'Acciones'
            )
            );
?>
<tr>
<td><?=$this->Form->text("id", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "id"]);?></td>
<td><?=$this->Form->text("caption", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "caption"]);?></td>
<td><?=$this->Form->text("table_name", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "table_name"]);?></td>
<td><?=$this->Form->text("ins_allowed", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "ins_allowed"]);?></td>
<td><?=$this->Form->text("upd_allowed", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "upd_allowed"]);?></td>
<td><?=$this->Form->text("del_allowed", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "del_allowed"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->id)?></td>
         <td><?=h($g->caption)?></td>
         <td><?=h($g->table_name)?></td>
         <td><?=h($g->ins_allowed)?></td>
         <td><?=h($g->upd_allowed)?></td>
         <td><?=h($g->del_allowed)?></td>
         <td align='center'>
            <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $g->id],array('escape' => false, 'title' => 'Ver')) ?>
            <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $g->id],array('escape' => false, 'title' => 'Editar')) ?>
            <?= $this->Form->postLink('<i class="pe-7f-trash"></i>',
                                       ['action' => 'delete',$g->id,],
                                       ['confirm' => __('¿Está seguro que desea eliminar el documento ID {0}?', $g->id),'escape' => false, 'title' => 'Eliminar']
                                      )?>
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
