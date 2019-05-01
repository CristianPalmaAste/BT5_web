<?php
/**
  * @var \App\View\AppView $this
  * @var \App\Model\Entity\DocumentosLegale[]|\Cake\Collection\CollectionInterface $documentosLegales
  */
?>

<?=$this->Form->create($gre, ["class" => "form-horizontal", 'url' => '/grupos-empresariales/index', 'novalidate' => true]);?>
<?php echo $this->BForm->formHeader( 'Grupos Empresariales' ); ?>

<div class="col-md-4 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>grupos-empresariales/add" class="btn dark"><i class="pe-7s-plus"></i>&nbsp; Nuevo</a>
   </div>
</div>

<?php echo $this->BForm->initForm( 'Grupos Empresariales',array(
      $this->Paginator->sort('nombre', 'Nombre'),
      $this->Paginator->sort('alias',  'Alias'),
      $this->Paginator->sort('icono',  'Icono'),
      $this->Paginator->sort('idpais', 'País'),
      $this->Paginator->sort('idesge', 'Estado'),
      'Acciones'
      )
   );
?>

    <tr>
      
      <td align="left"><?=$this->Form->text("nombre", ["size" => 25, "maxlength" => 100, "class" => "stacked-input upper"]);?></td>
      <td align="left"><?=$this->Form->text("alias", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper"]);?></td>
      <td align="left"><?=$this->Form->text("icono", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper"]);?></td>  
      <td align="left"><?=$this->Form->select("idpais", $paises, []);?></td>
      <td align="left"><?=$this->Form->select("idesge", $egrem, []);?></td>
      <td align="center"><button type="submit" class="btn btn-default">Filtrar</button>/<?=$this->Html->link('Limpiar', ["action" => "index"])?></td>
   </tr>

<?php foreach ($registros as $r): ?>
   <tr>
      <td><?= $r->nombre ?></td>
      <td><?= $r->alias ?></td>
      <td><?= h($r->icono) ?></td>
      <td><?= h($paises[$r->idpais]) ?></td>
      <td><?= h($egrem[$r->idesge]) ?></td>
      <td>
         <?= $this->Html->link('<i class="pe-7s-look"></i>', ['action' => 'view', $r->id],array('escape' => false)) ?>
         <?= $this->Html->link('<i class="pe-7s-note"></i>', ['action' => 'edit', $r->id],array('escape' => false)) ?>
         <?= $this->Form->postLink('<i class="pe-7f-trash"></i>',
               ['action' => 'delete',$r->id,],
               ['confirm' => __('¿Está seguro que desea eliminar el documento ID {0}?', $r->id),'escape' => false]
            )
         ?>
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
<script language="javascript">
   $(function() {
       $('.upper').keyup(function() {
           this.value = this.value.toUpperCase();
       });
   });
</script>

