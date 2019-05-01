<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/Empresas/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'empresas' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>Empresas/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'empresas',array(
        $this->Paginator->sort('id', 'id'),
        $this->Paginator->sort('idgrem', 'idgrem'),
        $this->Paginator->sort('idpais', 'idpais'),
        $this->Paginator->sort('idrubr', 'idrubr'),
        $this->Paginator->sort('idesre', 'idesre'),
        $this->Paginator->sort('identificador1', 'identificador1'),
        $this->Paginator->sort('identificador2', 'identificador2'),
        $this->Paginator->sort('razonsocial', 'razonsocial'),
        $this->Paginator->sort('nombrefantasia', 'nombrefantasia'),
        $this->Paginator->sort('icono', 'icono'),
        $this->Paginator->sort('xfld', 'xfld'),
            'Acciones'
            )
            );
?>
<tr>
<td><?=$this->Form->text("id", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "id"]);?></td>
<td><?=$this->Form->text("idgrem", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "idgrem"]);?></td>
<td><?=$this->Form->text("idpais", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "idpais"]);?></td>
<td><?=$this->Form->text("idrubr", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "idrubr"]);?></td>
<td><?=$this->Form->text("idesre", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "idesre"]);?></td>
<td><?=$this->Form->text("identificador1", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "identificador1"]);?></td>
<td><?=$this->Form->text("identificador2", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "identificador2"]);?></td>
<td><?=$this->Form->text("razonsocial", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "razonsocial"]);?></td>
<td><?=$this->Form->text("nombrefantasia", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "nombrefantasia"]);?></td>
<td><?=$this->Form->text("icono", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "icono"]);?></td>
<td><?=$this->Form->text("xfld", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "xfld"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->id)?></td>
         <td><?=h($g->idgrem)?></td>
         <td><?=h($g->idpais)?></td>
         <td><?=h($g->idrubr)?></td>
         <td><?=h($g->idesre)?></td>
         <td><?=h($g->identificador1)?></td>
         <td><?=h($g->identificador2)?></td>
         <td><?=h($g->razonsocial)?></td>
         <td><?=h($g->nombrefantasia)?></td>
         <td><?=h($g->icono)?></td>
         <td><?=h($g->xfld)?></td>
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
