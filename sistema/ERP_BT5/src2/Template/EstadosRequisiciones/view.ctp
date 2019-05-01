<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Estados Requisiciones</h3>
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
                           <td>Descripción estado:</td>
                           <td><?= $gre['descripcion'] ?></td>
                        <tr>

                  </table>
               </div>
            </div>

</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>EstadosRequisiciones/index" class="btn dark inverse">Volver</a>
</div>
</div>

