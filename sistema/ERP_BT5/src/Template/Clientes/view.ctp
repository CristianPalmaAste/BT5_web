<?= $this->Form->create($gre) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Clientes</h3>
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
                     <i class="pe-7s-date"></i> Cliente RUT: <?= number_format($gre['identificador1'],0, ",", ".") ?> - <?= $gre['identificador2'] ?>
                  </p>
                  <input type="checkbox" class="btn-more-check" id="more1" checked>
                  <label class="c-btn--more" for="more1"></label>



                  <div class="message__details">
                     <table>
                        <tr>
                          <td>Tipo de Cliente:</td>
                           <td><?= $tipos_clientes[$gre['idticl']]  ?></td>
                        <tr>
                        <tr>
                           <td>País:</td>
                           <td><?= $paises[$gre['idpais']] ?></td>
                        <tr>
                           <td>RUT:</td>
                           <td><?= number_format($gre['identificador1'],0, ",", ".") ?> - <?= $gre['identificador2'] ?></td>
                        <tr>
                           <td>Razón Social:</td>
                           <td><?= $gre['razonsocial'] ?></td>
                        <tr>
                           <td>Nombre de Fantasía:</td>
                           <td><?= $gre['nombrefantasia'] ?></td>
                        <tr>
                        <tr>
                           <td>Primer Nombre:</td>
                           <td><?= $gre['primernombre'] ?></td>
                        <tr>
                           <td>Segundo Nombre:</td>
                           <td><?= $gre['segundonombre'] ?></td>
                        <tr>
                        <tr>
                           <td>Apellido Paterno:</td>
                           <td><?= $gre['apellidopaterno'] ?></td>
                        <tr>
                           <td>Apellido Materno:</td>
                           <td><?= $gre['apellidomaterno'] ?></td>
                        <tr>

                  </table>
               </div>
            </div>


</div>

</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Clientes/index" class="btn dark inverse">Volver</a>
</div>
</div>

