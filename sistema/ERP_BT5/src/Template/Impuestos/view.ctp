<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Impuestos</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idpais")?>
         <div class="members__container">
            <div class="media message checked">
               <div class="media-body">
                  <h5 class="media-heading message__heading"></h5>
                  <p class="message__location">
                     <i class="pe-7s-date"></i><?= $gre['descripcion'] ?>
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
                           <td>Nombre del Impuesto:</td>
                           <td><?= $gre['descripcion'] ?></td>
                        <tr>
                           <td>Nombre Corto del Impuesto:</td>
                           <td><?= $gre['descripcioncorta'] ?></td>
                        <tr>
                           <td>Es obligatorio?:</td>
                           <td><?= $gre['obligatorio'] ?></td>
                        <tr>
                           <td>Valor del Impuesto:</td>
                           <td><?= $gre['valor'] ?></td>
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
<a href="<?=$this->request->webroot?>Impuestos/index" class="btn dark inverse">Volver</a>
</div>
</div>

