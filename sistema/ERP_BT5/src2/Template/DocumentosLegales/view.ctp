<?php
/**
  * @var \App\View\AppView $this
  * @var \App\Model\Entity\DocumentosLegale $documentosLegale
  */
?>

<div class="col-md-6">
   <article class="widget">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Vista de Documento Legal</h3>
         </div>
      </header>

      <div class="widget__content">
         <div class="members__container">
            <div class="media message checked">
               <div class="media-body">
                  <h4 class="media-heading message__heading"><?= $documento['nombreoriginal'] ?></h4>
                  <p class="message__location">
                     <i class="pe-7s-date"></i><?= $documento['fecha'] ?>
                  </p>
                  <input type="checkbox" class="btn-more-check" id="more1" checked>
                  <label class="c-btn--more" for="more1"></label>

                  <div class="message__details">
                     <table>
                        <tr>
                           <td>Tipo de Documento:</td>
                           <td><?= $documento['ti_do_le_d']['descripcion']?></td>
                        </tr>
                        <tr>
                           <td>Estado Documento:</td>
                           <td><?= $documento['es_do_le_d']['descripcion']?></td>
                        </tr>
                        <tr>
                           <td>Notaría:</td>
                           <td><?= h($documento['notaria']) ?></td>
                        </tr>
                        <tr>
                           <td>Foja:</td>
                           <td><?= h($documento['foja']) ?></td>
                        </tr>
                        <tr>
                           <td>Usuario Responsable:</td>
                           <td><?= h($documento['responsable']) ?></td>
                        </tr>
                        <tr>
                           <td>Archivo:</td>
                           <td>
                              <i class="pe-7s-cloud-download"></i>&nbsp;<?= $this->Html->link($documento['nombreoriginal'], $basePath.$documento['nombresistema'],array('target'=>'_blank','style'=>'color:#FFFFFF;text-decoration: underline;')) ?>
                           </td>
                        </tr>
                        <tr>
                           <td>Fecha de Aviso:</td>
                           <td><?= $documento['fechaaviso'] ?></td>
                        </tr>
                        <tr>
                           <td>Comentario:</td>
                           <td><?= h($documento['comentario']) ?></td>
                        </tr>
                        <tr>
                           <td>Extra:</td>
                           <td><?= h($documento['xfld']) ?></td>
                        </tr>
                  </table>
                  </div>
               </div>
            </div>
         </div>
      </div>

      <div class="col-md-6 text-center btn-vars__showcase">
         <div class="btn-group block">
            <a href="<?=$this->request->webroot.$this->name?>" class="btn dark inverse">Volver</a>
         </div>
      </div>
   </article>
</div>
