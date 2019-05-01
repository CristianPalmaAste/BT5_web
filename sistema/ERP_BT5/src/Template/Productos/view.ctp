<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Productos</h3>
         </div>
      </header>
     <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idgrem")?>

         <div class="members__container">
            <div class="media message checked">
               <div class="media-body">
                  <h5 class="media-heading message__heading"></h5>
                  <p class="message__location">
                     <i class="pe-7s-date"></i> <?= $gre['nombre'] ?>
                  </p>
                  <input type="checkbox" class="btn-more-check" id="more1" checked>
                  <label class="c-btn--more" for="more1"></label>


                  <div class="message__details">
                     <table>
                        <tr>
                          <td>Sub Familia:</td>
                           <td><?= $sub_familias[$gre['idsfpr']]  ?></td>
                        <tr>
                        <tr>
                           <td>Tipo de Producto:</td>
                           <td><?= $tipos_productos[$gre['idtipr']] ?></td>
                        <tr>
                           <td>Unidad de Medida:</td>
                           <td><?= $unidades_medidas[$gre['idunmp']] ?></td>
                        <tr>
                           <td>Orígen del Producto:</td>
                           <td><?= $origenes_productos[$gre['idorpr']] ?></td>
                        <tr>
                           <td>Nombre del Producto:</td>
                           <td><?= $gre['nombre'] ?></td>
                        <tr>
                        <tr>
                           <td>Correlativo:</td>
                           <td><?= $gre['correlativoflia'] ?></td>
                        <tr>
                           <td>SKU:</td>
                           <td><?= $gre['sku'] ?></td>
                        <tr>
                        <tr>
                           <td>EAN13:</td>
                           <td><?= $gre['ean13'] ?></td>
                        <tr>
                        <tr>
                           <td>Código QR:</td>
                           <td><?= $gre['qr'] ?></td>
                        <tr>
                           <td>Peso Unitario Kg:</td>
                           <td><?= $gre['pesounitariokg'] ?></td>
                        <tr>
                        <tr>
                           <td>Estado del Producto:</td>
                           <td><?= $estados_productos[$gre['idesre']] ?></td>
                        <tr>

                  </table>
               </div>
            </div>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Productos/index" class="btn dark inverse">Volver</a>
</div>
</div>

