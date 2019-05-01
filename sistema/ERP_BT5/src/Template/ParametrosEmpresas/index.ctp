<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/ParametrosEmpresas/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Parámetros por Empresa' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>ParametrosEmpresas/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'Parámetros por Empresa',array(
        $this->Paginator->sort('nombrecorto', 'Nombre Corto'),
        $this->Paginator->sort('nombrelargo', 'Nombre Largo'),
        $this->Paginator->sort('descripcion', 'Descripción'),
        $this->Paginator->sort('valor', 'Valor'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("nombrecorto", ["size" => 20, "maxlength" => 50, "class" => "stacked-input upper", "id" => "nombrecorto"]);?></td>
<td><?=$this->Form->text("nombrelargo", ["size" => 20, "maxlength" => 500, "class" => "stacked-input upper", "id" => "nombrelargo"]);?></td>
<td><?=$this->Form->text("descripcion", ["size" => 20, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "descripcion"]);?></td>
<td><?=$this->Form->text("valor", ["size" => 20, "maxlength" => 10, "class" => "stacked-input upper", "id" => "valor"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->nombrecorto)?></td>
         <td><?=h($g->nombrelargo)?></td>
         <td><?=h($g->descripcion)?></td>
         <td><?=h($g->valor)?></td>
         <td align='center'>
            <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $g->id],array('escape' => false, 'title' => 'Ver')) ?>
            <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $g->id],array('escape' => false, 'title' => 'Editar')) ?>
            <?= $this->Html->link('<i class="pe-7f-trash"></i>', ['action' => 'delete', $g->id], array('confirm' => __('¿Está seguro que desea eliminar el documento ID {0}?', $g->id), 'escape' => false, 'title' => 'Eliminar')) ?>
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
