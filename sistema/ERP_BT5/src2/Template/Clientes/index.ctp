<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/Clientes/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Clientes' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>Clientes/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'Clientes',array(
        $this->Paginator->sort('idticl', 'Tipo cliente'),
        $this->Paginator->sort('identificador1', 'Rut'),
        $this->Paginator->sort('identificador2', 'Dv'),        
        $this->Paginator->sort('razonsocial', 'Razón Social'),
        $this->Paginator->sort('nombrefantasia', 'Nombre de Fantasía'),
        $this->Paginator->sort('primernombre', 'Primer Nombre'),
        $this->Paginator->sort('segundonombre', 'Segundo Nombre'),
        $this->Paginator->sort('apellidopaterno', 'Apellido Paterno'),
        $this->Paginator->sort('apellidomaterno', 'Apellido Materno'),
		$this->Paginator->sort('idpais', 'País'),
            'Acciones'
            )
            );
?>
<!--<tr>
<td><?=$this->Form->text("idpais", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idpais"]);?></td>
<td><?=$this->Form->text("identificador1", ["size" => 20, "maxlength" => 11, "class" => "stacked-input upper", "id" => "identificador1"]);?></td>
<td><?=$this->Form->text("identificador2", ["size" => 20, "maxlength" => 1, "class" => "stacked-input upper", "id" => "identificador2"]);?></td>
<td><?=$this->Form->text("idticl", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "idticl"]);?></td>
<td><?=$this->Form->text("razonsocial", ["size" => 20, "maxlength" => 60, "class" => "stacked-input upper", "id" => "razonsocial"]);?></td>
<td><?=$this->Form->text("nombrefantasia", ["size" => 20, "maxlength" => 60, "class" => "stacked-input upper", "id" => "nombrefantasia"]);?></td>
<td><?=$this->Form->text("primernombre", ["size" => 20, "maxlength" => 25, "class" => "stacked-input upper", "id" => "primernombre"]);?></td>
<td><?=$this->Form->text("segundonombre", ["size" => 20, "maxlength" => 25, "class" => "stacked-input upper", "id" => "segundonombre"]);?></td>
<td><?=$this->Form->text("apellidopaterno", ["size" => 20, "maxlength" => 30, "class" => "stacked-input upper", "id" => "apellidopaterno"]);?></td>
<td><?=$this->Form->text("apellidomaterno", ["size" => 20, "maxlength" => 30, "class" => "stacked-input upper", "id" => "apellidomaterno"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>-->
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($tipos_clientes[$g->idticl])?></td>
         <td><?=h(number_format($g->identificador1, 0, ",", "."))?></td>
         <td><?=h($g->identificador2)?></td>         
         <td><?=h($g->razonsocial)?></td>
         <td><?=h($g->nombrefantasia)?></td>
         <td><?=h($g->primernombre)?></td>
         <td><?=h($g->segundonombre)?></td>
         <td><?=h($g->apellidopaterno)?></td>
         <td><?=h($g->apellidomaterno)?></td>
		 <td><?=h($paises[$g->idpais])?></td>
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
