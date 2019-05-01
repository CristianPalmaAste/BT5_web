<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/GruposEmpresariales/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Mantención de Grupos Empresariales' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>GruposEmpresariales/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'Mantención de Grupos Empresariales',array(
        $this->Paginator->sort('nombre', 'Nombre'),
        $this->Paginator->sort('alias', 'Alias'),
        $this->Paginator->sort('icono', 'Ícono'),
        $this->Paginator->sort('pais', 'País'),
        $this->Paginator->sort('estadoholding', 'Estado'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("nombre", ["size" => 20, "maxlength" => 100, "class" => "stacked-input upper", "id" => "nombre"]);?></td>
<td><?=$this->Form->text("alias", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "alias"]);?></td>
<td><?=$this->Form->text("icono", ["size" => 20, "maxlength" => 100, "class" => "stacked-input upper", "id" => "icono"]);?></td>
<td><?=$this->Form->text("pais", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idpais"]);?></td>
<td><?=$this->Form->text("estadoholding", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idesge"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->nombre)?></td>
         <td><?=h($g->alias)?></td>
         <td><?=h($g->icono)?></td>
         <td><?=h($g->pais)?></td>
         <td><?=h($g->estadoholding)?></td>
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
