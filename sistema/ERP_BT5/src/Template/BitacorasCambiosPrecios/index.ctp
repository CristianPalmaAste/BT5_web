<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/BitacorasCambiosPrecios/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Bitácora de Cambios de Precios' ); ?>


<?php echo $this->BForm->initForm( 'Bitácora de Cambios de Precios',array(
        $this->Paginator->sort('cod_prod_alfanum', 'Producto'),
        $this->Paginator->sort('nombre', 'Descripción'),
        $this->Paginator->sort('preciounitario', 'Precio Unitario'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("producto", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "producto"]);?></td>
<td><?=$this->Form->text("preciounitario", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "preciounitario"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
	     <td><?=h($g->cod_prod_alfanum)?></td>
         <td><?=h($g->nombre)?></td>
         <td><?=h($g->preciounitario)?></td>
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
