<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Líneas de Negocios</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idempr")?>
         <div class="members__container">
            <div class="media message checked">
               <div class="media-body">
                  <h5 class="media-heading message__heading"></h5>
                  <p class="message__location">
                     <i class="pe-7s-date"></i><?= $gre['nombre'] ?>
                  </p>
                  <input type="checkbox" class="btn-more-check" id="more1" checked>
                  <label class="c-btn--more" for="more1"></label>



                  <div class="message__details">
                     <table>
                        <tr>
                           <td>Identificador Interno:</td>
                           <td><?= $gre['id'] ?></td>
                        <tr>
                        <tr>
                          <td>Nombre de la Línea de Negocio:</td>
                           <td><?= $gre['nombre']  ?></td>
                        <tr>
                        </tr>
                  </table>
               </div>
            </div>
         </div>
      </div>


</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>LineasNegocios/index" class="btn dark inverse">Volver</a>
</div>
</div>

