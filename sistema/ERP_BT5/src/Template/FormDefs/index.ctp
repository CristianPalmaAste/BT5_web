<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/FormDefs/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Definición de formularios' ); ?>

<!--
<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>FormDefs/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
-->

<?php echo $this->BForm->initForm( 'Definición de Formularios',array(
        $this->Paginator->sort('caption', 'Título formulario'),
        $this->Paginator->sort('table_name', 'Nombre tabla'),
            'Acciones'
            )
            );
?>
<tr>
<td><?=$this->Form->text("caption", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "caption"]);?></td>
<td><?=$this->Form->text("table_name", ["size" => 20, "maxlength" => 20, "class" => "stacked-input", "id" => "table_name"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->caption)?></td>
         <td><?=h($g->table_name)?></td>
         <td align='center'>
            <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $g->id],array('escape' => false, 'title' => 'Ver')) ?>
            <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $g->id],array('escape' => false, 'title' => 'Editar')) ?>
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
