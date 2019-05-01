<?php
/**
  * @var \App\View\AppView $this
  */
?>
<nav class="large-3 medium-4 columns" id="actions-sidebar">
    <ul class="side-nav">
        <li class="heading"><?= __('Actions') ?></li>
        <li><?= $this->Form->postLink(
                __('Delete'),
                ['action' => 'delete', $cotizacionesVenta->id],
                ['confirm' => __('Are you sure you want to delete # {0}?', $cotizacionesVenta->id)]
            )
        ?></li>
        <li><?= $this->Html->link(__('List Cotizaciones Ventas'), ['action' => 'index']) ?></li>
    </ul>
</nav>
<div class="cotizacionesVentas form large-9 medium-8 columns content">
    <?= $this->Form->create($cotizacionesVenta) ?>
    <fieldset>
        <legend><?= __('Edit Cotizaciones Venta') ?></legend>
        <?php
            echo $this->Form->control('idempr');
            echo $this->Form->control('numero');
            echo $this->Form->control('idclie');
            echo $this->Form->control('descripcioncotizacion');
            echo $this->Form->control('idgere');
            echo $this->Form->control('idproy');
            echo $this->Form->control('idline');
            echo $this->Form->control('idceco');
            echo $this->Form->control('idtare');
            echo $this->Form->control('exento');
            echo $this->Form->control('afecto');
            echo $this->Form->control('impuestos');
            echo $this->Form->control('porcentajedescuento');
            echo $this->Form->control('montodescuento');
            echo $this->Form->control('total');
            echo $this->Form->control('diasvalidez');
            echo $this->Form->control('idescv');
            echo $this->Form->control('idusuacrearegistro');
            echo $this->Form->control('fechacrearegistro');
            echo $this->Form->control('idusuamodifregistro');
            echo $this->Form->control('fechamodifregistro');
            echo $this->Form->control('idusuaborraregistro');
            echo $this->Form->control('fechaborraregistro');
        ?>
    </fieldset>
    <?= $this->Form->button(__('Submit')) ?>
    <?= $this->Form->end() ?>
</div>
