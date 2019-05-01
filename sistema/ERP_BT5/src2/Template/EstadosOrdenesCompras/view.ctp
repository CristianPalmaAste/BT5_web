<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Estados Ordenes de Compra</h3>
         </div>
      </header>

 <div class="members__container">
            <div class="media message checked">
               <div class="media-body">
                  <h5 class="media-heading message__heading"></h5>
                  <p class="message__location">
                     <i class="pe-7s-date"></i> <?= $gre['descripcion'] ?>
                  </p>
                  <input type="checkbox" class="btn-more-check" id="more1" checked>
                  <label class="c-btn--more" for="more1"></label>


                  <div class="message__details">
                     <table>
                        <tr>
                          <td>Correlativo interno:</td>
                           <td><?= $gre['id']  ?></td>
                        <tr>
                        <tr>
                           <td>Descripción:</td>
                           <td><?= $gre['descripcion'] ?></td>

                  </table>
               </div>
            </div>

</div>
</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>EstadosOrdenesCompras/index" class="btn dark inverse">Volver</a>
</div>
</div>

