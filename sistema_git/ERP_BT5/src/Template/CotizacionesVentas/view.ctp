<?php
/**
  * @var \App\View\AppView $this
  * @var \App\Model\Entity\CotizacionesVenta $cotizacionesVenta
  */
?>
<nav class="large-3 medium-4 columns" id="actions-sidebar">
    <ul class="side-nav">
        <li class="heading"><?= __('Actions') ?></li>
        <li><?= $this->Html->link(__('Edit Cotizaciones Venta'), ['action' => 'edit', $cotizacionesVenta->id]) ?> </li>
        <li><?= $this->Form->postLink(__('Delete Cotizaciones Venta'), ['action' => 'delete', $cotizacionesVenta->id], ['confirm' => __('Are you sure you want to delete # {0}?', $cotizacionesVenta->id)]) ?> </li>
        <li><?= $this->Html->link(__('List Cotizaciones Ventas'), ['action' => 'index']) ?> </li>
        <li><?= $this->Html->link(__('New Cotizaciones Venta'), ['action' => 'add']) ?> </li>
    </ul>
</nav>
<div class="cotizacionesVentas view large-9 medium-8 columns content">
    <h3><?= h($cotizacionesVenta->id) ?></h3>
    <table class="vertical-table">
        <tr>
            <th scope="row"><?= __('Descripcioncotizacion') ?></th>
            <td><?= h($cotizacionesVenta->descripcioncotizacion) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Id') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->id) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Idempr') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->idempr) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Numero') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->numero) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Idclie') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->idclie) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Idgere') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->idgere) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Idproy') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->idproy) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Idline') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->idline) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Idceco') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->idceco) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Idtare') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->idtare) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Exento') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->exento) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Afecto') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->afecto) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Impuestos') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->impuestos) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Porcentajedescuento') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->porcentajedescuento) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Montodescuento') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->montodescuento) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Total') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->total) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Diasvalidez') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->diasvalidez) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Idescv') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->idescv) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Idusuacrearegistro') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->idusuacrearegistro) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Idusuamodifregistro') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->idusuamodifregistro) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Idusuaborraregistro') ?></th>
            <td><?= $this->Number->format($cotizacionesVenta->idusuaborraregistro) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Fechacrearegistro') ?></th>
            <td><?= h($cotizacionesVenta->fechacrearegistro) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Fechamodifregistro') ?></th>
            <td><?= h($cotizacionesVenta->fechamodifregistro) ?></td>
        </tr>
        <tr>
            <th scope="row"><?= __('Fechaborraregistro') ?></th>
            <td><?= h($cotizacionesVenta->fechaborraregistro) ?></td>
        </tr>
    </table>
</div>
