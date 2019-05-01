<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/ListasPrecios/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Listas de Precios' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
<?php $nuevo = $this->request->webroot.$this->name.'/add'; ?>
   <?= $this->Form->button('<i class="pe-mi-add"></i> Nueva Lista',[
      'type'=>'button',
      'onclick'=>"window.location.href='$nuevo'",
      'style'=>'width:100%;display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
   ])?>
</div>

<div class="col-md-8 text-center btn-vars__showcase">
   <?=$this->form->create('Ventas')?>
   <?= $this->Form->input('searchBy', array(
         'type' => 'select',
         'label' => false,
         'style' => 'width:22%;display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;',
         'id' => 'searchBy',
         'class' => 'pull-left',
         'empty' => 'Buscar por...',
         'options' => isset($searchOptions)?$searchOptions:[]
      )
   )?>
   <?php $limpiar = $this->request->webroot.$this->name; ?>
   <?= $this->Form->button('<i class="pe-mi-refresh"></i> Limpiar filtro',[
      'type'=>'button',
      'onclick'=>"window.location.href='$limpiar'",
      'style'=>'width:22%;display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
   ])?>

   <div class="main-search pull-right">
      <input type="text" placeholder="Buscar ..." id="search" name="search" class="pull-right uppper">
      <button>
         <i class="pe-7s-search"></i>
      </button>
   </div>

   <?=$this->Form->end()?>
</div>

<!--
<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>ListasPrecios/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
-->
<?php echo $this->BForm->initForm( 'Listas de Precios',array(
        $this->Paginator->sort('correlativo', 'Correlativo'),
        $this->Paginator->sort('fechainicio', 'Fecha Inicio'),
        $this->Paginator->sort('fechafin', 'Fecha Fin'),
        $this->Paginator->sort('observaciones', 'Observaciones'),
        $this->Paginator->sort('idesre', 'Estado'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("correlativo", ["size" => 20, "maxlength" => 10, "class" => "stacked-input upper", "id" => "correlativo"]);?></td>
<td><?=$this->Form->text("fechainicio", ["size" => 0, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fechainicio"]);?></td>
<td><?=$this->Form->text("fechafin", ["size" => 0, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fechafin"]);?></td>
<td><?=$this->Form->text("observaciones", ["size" => 20, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "observaciones"]);?></td>
<td><?=$this->Form->text("idesre", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idesre"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->correlativo)?></td>
         <td><?=h($g->fechainicio)?></td>
         <td><?=h($g->fechafin)?></td>
         <td><?=h($g->observaciones)?></td>
         <td><?=h($estados_registros[$g->idesre])?></td>
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
