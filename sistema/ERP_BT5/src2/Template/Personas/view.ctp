<?= $this->Form->create($persona) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Vista de Personas</h3>
         </div>
      </header>

      <div class="widget__content">
         <div class="members__container">
            <div class="media message checked">
               <div class="media-body">
                  <h5 class="media-heading message__heading"></h5>
                  <p class="message__location">
                     <i class="pe-7s-date"></i><?= $persona['primernombre'] ?> <?= $persona['apellidopaterno'] ?>
                  </p>
  
                  <input type="checkbox" class="btn-more-check" id="more1" checked>
                  <label class="c-btn--more" for="more1"></label>



                  <div class="message__details">
                     <table>
                        <tr>
                           <td>Rut:</td>
                           <td><?= $persona['identificador1'] ?>-<?= $persona['identificador2'] ?></td>
                        <tr>
                        <tr>
                          <td>Primer Nombre:</td>
                           <td><?= $persona['primernombre']  ?></td>
                        <tr>
                        <tr>
                          <td>Segundo Nombre:</td>
                           <td><?= $persona['segundonombre'] ?></td>
                        <tr>
                        <tr>
                          <td>Apellido Paterno:</td>
                           <td><?= $persona['apellidopaterno'] ?></td>
                        <tr>
                        <tr>
                           <td>Apellido Materno:</td>
                           <td><?= $persona['apellidomaterno'] ?></td>
                        <tr>
                        <tr>
                           <td>Correo Electrónico:</td>
                           <td><?= $persona['email'] ?></td>
                        <tr>
                        <tr>
                          <td>Fecha Naciemiento:</td>
                           <td><?= $persona['fechanac']  ?></td>
                        <tr>

                        <tr>
                          <td>Estado Civíl:</td>
                           <td><?= $eciviles[$persona['idesci'] ]  ?></td>
                        <tr] >
                        <tr>
                          <td>Género:</td>
                           <td><?= $sexos[$persona['idsexo']] ?></td>
                        <tr>
                        <tr>
                          <td>Nacionalidad:</td>
                           <td><?= $paises[$persona['idpais']] ?></td>
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
<a href="<?=$this->request->webroot?>Personas/index" class="btn dark inverse">Volver</a>
</div>
</div>

