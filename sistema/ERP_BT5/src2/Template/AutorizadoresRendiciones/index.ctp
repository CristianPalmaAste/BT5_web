<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/AutorizadoresRendiciones/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Autorizadores de Rendiciones' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>AutorizadoresRendiciones/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'Autorizadores de Rendiciones',array(
        $this->Paginator->sort('id', 'Id'),
        $this->Paginator->sort('idperfautorizador', 'Perfil Autorizador'),
        $this->Paginator->sort('idperfautorizado', 'Perfil Autorizados'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("id", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "id"]);?></td>
<td><?=$this->Form->text("idperfautorizador", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idperfautorizador"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->id)?></td>
         <td><?=h($usuarios[$g->idperfautorizador])?></td>
		 <td><?=h($usuarios[$g->idperfautorizado])?></td>
         <td align='center'>
            <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $g->id],array('escape' => false, 'title' => 'Ver')) ?>
            <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $g->id],array('escape' => false, 'title' => 'Editar')) ?>
            <?= $this->Html->link('<i class="pe-7f-trash"></i>', ['action' => 'delete', $g->id], array('confirm' => __('¿Está seguro que desea eliminar el documento ID {0}?', $g->id), 'escape' => false, 'title' => 'Eliminar')) ?>         </td>
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
