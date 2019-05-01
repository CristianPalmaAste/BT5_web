<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/Bodegas/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Detalles Movimientos Bodega' ); ?>

<!--
<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>Bodegas/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nueva Bodega</a>
   </div>
</div>
-->


<?php echo $this->BForm->initForm( 'Bodegas',array($this->Paginator->sort('id','Id'), 
                                                   $this->Paginator->sort('nombre', 'Nombre'),'Acciones'));?>

<!--
<?=$this->Form->text("id", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "id"]);?>
<?=$this->Form->text("nombre", ["size" => 20, "maxlength" => 200, "class" => "stacked-input upper", "id" => "nombre"]);?>
<?=$this->Html->link('Limpiar', ['action' => 'index'])?>
</tr>-->
<?php foreach($registros as $g):?>
      <tr>
	     <td><?=h($g->id)?></td>
         <td><?=h($g->nombre)?></td>
         <td align='center'>
            <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $g->id],array('escape' => false, 'title' => 'Ver')) ?>
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
