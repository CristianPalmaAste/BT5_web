<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/paises/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Mantención de paises' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>paises/add" class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>
<?php echo $this->BForm->initForm( 'Grupos Empresariales',array(
        $this->Paginator->sort('id', 'id'),
        $this->Paginator->sort('nombre', 'nombre'),
        $this->Paginator->sort('idmone', 'idmone'),
        $this->Paginator->sort('nacionalidad', 'nacionalidad'),
            'Acciones'
            )
            );
<?php foreach($registros as $g):?>

      <tr>
         <td><?=h($g->id)?></td>
         <td><?=h($g->nombre)?></td>
         <td><?=h($g->idmone)?></td>
         <td><?=h($g->nacionalidad)?></td>
         <td align='center'>
<div class="paginator">
   <ul class="pagination">
      <?= $this->Paginator->first('<< ' . __('Primero')) ?>
      <?= $this->Paginator->prev('< ' . __('Anterior')) ?>
      <?= $this->Paginator->numbers() ?>
      <?= $this->Paginator->next(__('Siguiente') . ' >') ?>
      <?= $this->Paginator->last(__('Último') . ' >>') ?>
    </ul>
<p><?=$this->Paginator->counter('Página {{page}} de {{pages}}') ?></p>
</div>
<?=$this->Form->end();?>
