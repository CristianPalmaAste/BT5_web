<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/Requisiciones/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Recepciones de Compras' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>RecepcionesCompras/indexOrdenesCompras" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
  
</div>
<?php echo $this->BForm->initForm( 'Recepciones de Compras',array(        
        $this->Paginator->sort('correlativo', 'Correlativo'),
		$this->Paginator->sort('fechacrearegistro', 'Fecha'),
        $this->Paginator->sort('idprov', 'Proveedor'),        
        $this->Paginator->sort('idBode', 'Bodega'),
        //$this->Paginator->sort('idceco', 'Centro de Costo'),
        //$this->Paginator->sort('idtare', 'Tarea'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("idtire", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idtire"]);?></td>
<td><?=$this->Form->text("correlativo", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "correlativo"]);?></td>
<td><?=$this->Form->text("idusuasolicitareq", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idusuasolicitareq"]);?></td>

<td><?=$this->Form->text("idgere", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idgere"]);?></td>
<td><?=$this->Form->text("idproy", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idproy"]);?></td>
<td><?=$this->Form->text("idline", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idline"]);?></td>
<td><?=$this->Form->text("idceco", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idceco"]);?></td>
<td><?=$this->Form->text("idtare", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idtare"]);?></td>

<td><?=$this->Form->text("idereq", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idereq"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
         
         <td><?=h($g->correlativo)?></td>
		  <td><?php
		       $d = new DateTime($g->fechacrearegistro);
			   
			   echo $d->format("d/m/Y");
			   ?>
		 </td>
         <td><?=$g->idprov==null?"&nbsp;":h($proveedores[$g->idprov])?></td>
		 <td><?=h($bodegas[$g->idbode])?></td>
		 
         
         <td align='center'>
            <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $g->id],array('escape' => false, 'title' => 'Ver')) ?>
            <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $g->id],array('escape' => false, 'title' => 'Editar')) ?>

			<?php if ($g->idesoc==1): ?>
            <?php    echo $this->Html->link('Cerrar Orden', ['action' => 'cerrar', $g->id], array('confirm' => __('¿Está seguro que desea cerrar la órden de compra {0}?', $g->correlativo), 'escape' => false, 'title' => 'Cerrar')) ?>
			<?php endif; ?>
			
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
