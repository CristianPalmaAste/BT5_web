<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/MovimientosBodegas/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Movimientos de Bodegas' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>MovimientosBodegas/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'Movimientos de Bodegas',array(
        $this->Paginator->sort('id', 'Bodega'),
        $this->Paginator->sort('Bodega', 'Nombre'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("idbode", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idbode"]);?></td>
<td><?=$this->Form->text("correlativo", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "correlativo"]);?></td>
<td><?=$this->Form->text("idtimb", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idtimb"]);?></td>
<td><?=$this->Form->text("fechamovto", ["size" => 0, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fechamovto"]);?></td>
<td><?=$this->Form->text("descripcion", ["size" => 20, "maxlength" => 100, "class" => "stacked-input upper", "id" => "descripcion"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->id)?></td>
         <td><?=h($g->bodega)?></td>
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
