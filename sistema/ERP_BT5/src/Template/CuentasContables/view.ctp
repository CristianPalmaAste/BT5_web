<?= $this->Form->create() ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Cuentas Contables</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <div class="members__container">
            <div class="media message checked">
               <div class="media-body">
                  <h5 class="media-heading message__heading"></h5>
                  <p class="message__location">
                     <i class="pe-7s-date"></i>Grupo Empresarial: <?= $empresa ?>
                  </p>
                  <input type="checkbox" class="btn-more-check" id="more1" checked>
                  <label class="c-btn--more" for="more1"></label>



                  <div class="message__details">
                     <table>
                        <tr>
                          <td>Cuenta:</td>
                           <td><?php echo $results[0]['cuenta_desplegable'];?></td>
                        <tr>
                         <tr>
                          <td>Tipo Cuenta:</td>
                           <td><?= $results[0]['tipo_cuenta_contable']  ?></td>
                        <tr>
                        <tr>
                          <td>Nombre Cuenta:</td>
                           <td><?= $results[0]['descripcion']  ?></td>
                        <tr>
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
<a href="<?=$this->request->webroot?>CuentasContables/index" class="btn dark inverse">Volver</a>
</div>
</div>

