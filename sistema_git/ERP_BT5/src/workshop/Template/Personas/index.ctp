<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/Personas/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Mantención de Personas' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>Personas/add" title='Nuevo registro' class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'Mantención de Personas',array(
        $this->Paginator->sort('id', 'id'),
        $this->Paginator->sort('idgrem', 'idgrem'),
        $this->Paginator->sort('identificador1', 'identificador1'),
        $this->Paginator->sort('identificador2', 'identificador2'),
        $this->Paginator->sort('primernombre', 'primernombre'),
        $this->Paginator->sort('segundonombre', 'segundonombre'),
        $this->Paginator->sort('apellidopaterno', 'apellidopaterno'),
        $this->Paginator->sort('apellidomaterno', 'apellidomaterno'),
        $this->Paginator->sort('email', 'email'),
        $this->Paginator->sort('fechanac', 'fechanac'),
        $this->Paginator->sort('idesci', 'idesci'),
        $this->Paginator->sort('idsexo', 'idsexo'),
        $this->Paginator->sort('idpais', 'idpais'),
            'Acciones'
            )
            );
?>
<tr>
<td><?=$this->Form->text("id", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "id"]);?></td>
<td><?=$this->Form->text("idgrem", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "idgrem"]);?></td>
<td><?=$this->Form->text("identificador1", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "identificador1"]);?></td>
<td><?=$this->Form->text("identificador2", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "identificador2"]);?></td>
<td><?=$this->Form->text("primernombre", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "primernombre"]);?></td>
<td><?=$this->Form->text("segundonombre", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "segundonombre"]);?></td>
<td><?=$this->Form->text("apellidopaterno", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "apellidopaterno"]);?></td>
<td><?=$this->Form->text("apellidomaterno", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "apellidomaterno"]);?></td>
<td><?=$this->Form->text("email", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper", "id" => "email"]);?></td>
<td><?=$this->Form->text("fechanac", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "fechanac"]);?></td>
<td><?=$this->Form->text("idesci", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "idesci"]);?></td>
<td><?=$this->Form->text("idsexo", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "idsexo"]);?></td>
<td><?=$this->Form->text("idpais", ["size" => 5, "maxlength" => 5, "class" => "stacked-input upper", "id" => "idpais"]);?></td>
<td align='center'><button type='submit' class='btn btn-default'>Filtrar</button>/<?=$this->Html->link('Limpiar', ['action' => 'index'])?></td>
</tr>
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->id)?></td>
         <td><?=h($g->idgrem)?></td>
         <td><?=h($g->identificador1)?></td>
         <td><?=h($g->identificador2)?></td>
         <td><?=h($g->primernombre)?></td>
         <td><?=h($g->segundonombre)?></td>
         <td><?=h($g->apellidopaterno)?></td>
         <td><?=h($g->apellidomaterno)?></td>
         <td><?=h($g->email)?></td>
         <td><?=h($g->fechanac)?></td>
         <td><?=h($g->idesci)?></td>
         <td><?=h($g->idsexo)?></td>
         <td><?=h($g->idpais)?></td>
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
