<?php
/**
  * @var \App\View\AppView $this
  * @var \App\Model\Entity\EstadosDocumentosLegales $estadosDocumentosLegale
  */
?>

<?php echo $this->BForm->formHeader( 'Estados Documentos Legales' ); ?>

<div class="col-md-6">
   <article class="widget">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Vista de Estado de Documento Legal</h3>
         </div>
      </header>

      <div class="widget__content">
         <div class="members__container">
            <div class="media message checked">
               <div class="media-body">
                  <h4 class="media-heading message__heading"><?= $estadosDocumentosLegale['descripcion'] ?></h4>
                  <p class="message__location">&nbsp;</p>
                  <input type="checkbox" class="btn-more-check" id="more1" checked>
                  <label class="c-btn--more" for="more1"></label>

                  <div class="message__details">
                     <table>
                        <tr>
                           <td>Nombre del estado de documento:</td>
                           <td><?= h($estadosDocumentosLegale->descripcion) ?></td>
                        </tr>
                     </table>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <div class="col-md-6 text-center btn-vars__showcase">
         <div class="btn-group block">
            <a href="<?=$this->request->webroot?>estados-documentos-Legales/index" class="btn dark inverse">Volver</a>
         </div>
      </div>
   </article>
</div>