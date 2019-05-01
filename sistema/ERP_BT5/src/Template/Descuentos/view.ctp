<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Descuentos </h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
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
                          <td>Familia:</td>
                           <td><?= $familias_productos[$gre['idfapr']]  ?></td>
                        <tr>
                        <tr>
                           <td>Sub Familia:</td>
                           <td><?= $sub_familias_productos[$gre['idsfpr']] ?></td>
                        <tr>
                           <td>Nombre del Producto:</td>
                           <td><?= $productos[$gre->idprod] ?></td>
                        <tr>
                           <td>% Descuento:</td>
                           <td><?= $gre['porcentajedescuento'] ?></td>
                        <tr>
                           <td>Monto de Descuento:</td>
                           <td><?= $gre['montodescuento'] ?></td>
                        <tr>
                        <tr>
                           <td>Estado del Producto:</td>
                           <td><?= $estados_registros[$gre['idesre']] ?></td>
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
<a href="<?=$this->request->webroot?>Descuentos/index" class="btn dark inverse">Volver</a>
</div>
</div>

