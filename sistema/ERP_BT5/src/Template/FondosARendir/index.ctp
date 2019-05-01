<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/FondosARendir/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Fondos a Rendir' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>FondosARendir/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'Fondos a Rendir',array(
        $this->Paginator->sort('correlativo', 'Correlativo'),
        $this->Paginator->sort('monto', 'Monto'),
        $this->Paginator->sort('idgere', 'Gerencia'),
        $this->Paginator->sort('idproy', 'Proyecto'),
        $this->Paginator->sort('idline', 'Línea de negocios'),
        $this->Paginator->sort('idceco', 'Centro de costos'),
        $this->Paginator->sort('idtare', 'Tarea'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("correlativo", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "correlativo"]);?></td>
<td><?=$this->Form->text("monto", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "monto"]);?></td>
<td><?=$this->Form->text("idgere", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idgere"]);?></td>
<td><?=$this->Form->text("idproy", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idproy"]);?></td>
<td><?=$this->Form->text("idline", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idline"]);?></td>
<td><?=$this->Form->text("idceco", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idceco"]);?></td>
<td><?=$this->Form->text("idtare", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idtare"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->correlativo)?></td>
         <td><?=h($g->monto)?></td>
         <td><?=h($gerencias[$g->idgere])?></td>
         <td><?=h($proyectos[$g->idproy])?></td>
         <td><?=h($lineas_negocios[$g->idline])?></td>
         <td><?=h($centros_costos[$g->idceco])?></td>
         <td><?=h($tareas[$g->idtare])?></td>
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
