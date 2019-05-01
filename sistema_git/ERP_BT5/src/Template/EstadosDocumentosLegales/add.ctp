<?php
/**
  * @var \App\View\AppView $this
  */
?>

<?php echo $this->BForm->formHeader( 'Estados Documentos Legales' ); ?>

<?= $this->Form->create($estadosDocumentosLegale) ?>

<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Nuevo Estado de Documento Legal</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="input-1" class="stacked-label" data-toggle="tooltip" title="Descripción del Estado de Documento"><i class="pe-7s-note"></i></label>
         <input type="text" class="stacked-input upper" name="descripcion" id="input-1" placeholder="Descripción del Estado de Documento">
         <input type="hidden" name="id" value="">
         <input type="hidden" name="idgrem" value="<?=$idgrem?>">
         <input type="hidden" name="idusuacrearegistro" value="<?=$idusua?>">

         <?= $this->Form->button(__('Guardar')) ?>
      </div>
   </article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>estados-documentos-Legales/index" class="btn dark inverse">Volver</a>
   </div>
</div>


