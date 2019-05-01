<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/Productos/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Productos' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>Productos/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'Productos',array(
        $this->Paginator->sort('idsfpr', 'Sub.Familia'),
        $this->Paginator->sort('tipo_producto', 'Tipo Producto'),
        $this->Paginator->sort('unid_medida', 'Unidad Medida'),
        $this->Paginator->sort('orden', 'Origen Producto'),
        $this->Paginator->sort('nombre', 'Nombre'),
        $this->Paginator->sort('correlativoflia', 'Correlativo'),
        $this->Paginator->sort('sku', 'Sku'),
        $this->Paginator->sort('ean13', 'Ean13'),
        $this->Paginator->sort('qr', 'Qr'),
        $this->Paginator->sort('pesounitariokg', 'Peso Unit.Kg'),
        $this->Paginator->sort('estado_registro', 'Estado'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("idsfpr", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idsfpr"]);?></td>
<td><?=$this->Form->text("idtipr", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idtipr"]);?></td>
<td><?=$this->Form->text("idunmp", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idunmp"]);?></td>
<td><?=$this->Form->text("idorpr", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idorpr"]);?></td>
<td><?=$this->Form->text("nombre", ["size" => 20, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "nombre"]);?></td>
<td><?=$this->Form->text("correlativoflia", ["size" => 4, "maxlength" => 4, "class" => "stacked-input upper", "id" => "correlativoflia"]);?></td>
<td><?=$this->Form->text("sku", ["size" => 20, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "sku"]);?></td>
<td><?=$this->Form->text("ean13", ["size" => 20, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "ean13"]);?></td>
<td><?=$this->Form->text("qr", ["size" => 20, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "qr"]);?></td>
<td><?=$this->Form->text("pesounitariokg", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "pesounitariokg"]);?></td>
<td><?=$this->Form->text("estado_registro", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idesre"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->nombre_sub_familia)?></td>
         <td><?=h($g->tipo_producto)?></td>
         <td><?=h($g->alias_unidad_de_medida)?></td>
         <td><?=h($g->origen)?></td>
         <td><?=h($g->nombre)?></td>
         <td><?=h($g->correlativoflia)?></td>
         <td><?=h($g->sku)?></td>
         <td><?=h($g->ean13)?></td>
         <td><?=h($g->qr)?></td>
         <td><?=h($g->pesounitariokg)?></td>
         <td><?=h($g->estado_regsitro)?></td>
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
