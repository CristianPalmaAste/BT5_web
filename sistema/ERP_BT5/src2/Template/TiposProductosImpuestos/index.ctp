<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/TiposProductosImpuestos/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Tipos de producto tipo de impuesto' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>TiposProductosImpuestos/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'Tipos de producto tipo de impuesto',array(
        $this->Paginator->sort('idtipr', 'Tipo de producto'),
        $this->Paginator->sort('idimpu', 'Tipo de impuesto'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("idtipr", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idtipr"]);?></td>
<td><?=$this->Form->text("idimpu", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idimpu"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($tipos_productos[$g->idtipr])?></td>
         <td><?=h($impuestos[$g->idimpu])?></td>
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
