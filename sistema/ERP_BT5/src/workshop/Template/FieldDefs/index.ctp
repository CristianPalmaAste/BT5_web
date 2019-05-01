<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/FieldDefs/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'NONAME' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>FieldDefs/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'NONAME',array(
        $this->Paginator->sort('id', 'id'),
        $this->Paginator->sort('form_id', 'form_id'),
        $this->Paginator->sort('forder', 'forder'),
        $this->Paginator->sort('name', 'name'),
        $this->Paginator->sort('type', 'type'),
        $this->Paginator->sort('len', 'len'),
        $this->Paginator->sort('decim', 'decim'),
        $this->Paginator->sort('pk', 'pk'),
        $this->Paginator->sort('req', 'req'),
        $this->Paginator->sort('caption', 'caption'),
        $this->Paginator->sort('gadget', 'gadget'),
        $this->Paginator->sort('size', 'size'),
        $this->Paginator->sort('maxlength', 'maxlength'),
        $this->Paginator->sort('rows', 'rows'),
        $this->Paginator->sort('cols', 'cols'),
        $this->Paginator->sort('selvalues', 'selvalues'),
        $this->Paginator->sort('sqlvalues', 'sqlvalues'),
        $this->Paginator->sort('visible', 'visible'),
        $this->Paginator->sort('readonly', 'readonly'),
        $this->Paginator->sort('fld_type', 'fld_type'),
        $this->Paginator->sort('fld_offset', 'fld_offset'),
            'Acciones'
            )
            );
?>
<tr>
<td><?=$this->Form->text("id", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "id"]);?></td>
<td><?=$this->Form->text("form_id", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "form_id"]);?></td>
<td><?=$this->Form->text("forder", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "forder"]);?></td>
<td><?=$this->Form->text("name", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "name"]);?></td>
<td><?=$this->Form->text("type", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "type"]);?></td>
<td><?=$this->Form->text("len", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "len"]);?></td>
<td><?=$this->Form->text("decim", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "decim"]);?></td>
<td><?=$this->Form->text("pk", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "pk"]);?></td>
<td><?=$this->Form->text("req", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "req"]);?></td>
<td><?=$this->Form->text("caption", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "caption"]);?></td>
<td><?=$this->Form->text("gadget", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "gadget"]);?></td>
<td><?=$this->Form->text("size", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "size"]);?></td>
<td><?=$this->Form->text("maxlength", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "maxlength"]);?></td>
<td><?=$this->Form->text("rows", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "rows"]);?></td>
<td><?=$this->Form->text("cols", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "cols"]);?></td>
<td><?=$this->Form->text("selvalues", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "selvalues"]);?></td>
<td><?=$this->Form->text("sqlvalues", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "sqlvalues"]);?></td>
<td><?=$this->Form->text("visible", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "visible"]);?></td>
<td><?=$this->Form->text("readonly", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "readonly"]);?></td>
<td><?=$this->Form->text("fld_type", ["size" => 1, "maxlength" => 1, "class" => "stacked-input upper", "id" => "fld_type"]);?></td>
<td><?=$this->Form->text("fld_offset", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "fld_offset"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->id)?></td>
         <td><?=h($g->form_id)?></td>
         <td><?=h($g->forder)?></td>
         <td><?=h($g->name)?></td>
         <td><?=h($g->type)?></td>
         <td><?=h($g->len)?></td>
         <td><?=h($g->decim)?></td>
         <td><?=h($g->pk)?></td>
         <td><?=h($g->req)?></td>
         <td><?=h($g->caption)?></td>
         <td><?=h($g->gadget)?></td>
         <td><?=h($g->size)?></td>
         <td><?=h($g->maxlength)?></td>
         <td><?=h($g->rows)?></td>
         <td><?=h($g->cols)?></td>
         <td><?=h($g->selvalues)?></td>
         <td><?=h($g->sqlvalues)?></td>
         <td><?=h($g->visible)?></td>
         <td><?=h($g->readonly)?></td>
         <td><?=h($g->fld_type)?></td>
         <td><?=h($g->fld_offset)?></td>
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
