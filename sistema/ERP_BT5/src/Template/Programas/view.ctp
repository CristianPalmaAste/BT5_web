<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Programas</h3>
         </div>
      </header>
<div class="members__container">
            <div class="media message checked">
               <div class="media-body">
                  <h5 class="media-heading message__heading"></h5>
                  <p class="message__location">
                     <i class="pe-7s-date"></i> <?= $gre['titulo'] ?>
                  </p>
                  <input type="checkbox" class="btn-more-check" id="more1" checked>
                  <label class="c-btn--more" for="more1"></label>


                  <div class="message__details">
                     <table>
                        <tr>
                          <td>Id:</td>
                           <td><?= $gre['id']  ?></td>
                        <tr>
                           <td>Programa padre:</td>
                           <td><?= $gre['idprogpadre'] ?></td>
                        <tr>
                           <td>Título:</td>
                           <td><?= $gre['titulo'] ?></td>
                        <tr>
                           <td>Link:</td>
                           <td><?= $gre['link'] ?></td>
                        <tr>
                           <td>Etiqueta:</td>
                           <td><?= $gre['etiqueta'] ?></td>
                        <tr>
                           <td>Peso:</td>
                           <td><?= $gre['peso'] ?></td>
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
<a href="<?=$this->request->webroot?>Programas/index" class="btn dark inverse">Volver</a>
</div>
</div>

