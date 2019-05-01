<?php
/**
  * @var \App\View\AppView $this
  */
?>

<?= $this->Html->css("syronex-colorpicker.css") ?>
<?= $this->Html->script('syronex-colorpicker') ?>

<script type="text/javascript">
   $(document).ready(function(){
      $('#colorPicker').colorPicker({
         defaultColor:<?=$selectedIndex?>,
         color:[<?=$colores?>],
         click:function(c){
            $('#color').val(c);
         }
      });
   });
</script>

<?php echo $this->BForm->formHeader( 'Tipos Documentos Legales' ); ?>

<?= $this->Form->create($tiposDocumentosLegale) ?>

<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Actualización de Tipo de Documento Legal</h3>
         </div>
      </header>
      <div class="widget__content">
         <label for="input-1" class="stacked-label" data-toggle="tooltip" title="Descripción del Tipo de Documento"><i class="pe-7s-note"></i></label>
         <input type="text" class="stacked-input upper" name="descripcion" id="input-1" size="50" maxlength="100" placeholder="Descripción del Tipo de Documento" value="<?=$tiposDocumentosLegale->descripcion ?>">
         <label for="input-2" class="stacked-label" data-toggle="tooltip" title="Descripción corta del Tipo de Documento"><i class="pe-7s-scissors"></i></label>
         <input type="text" class="stacked-input upper" name="descripcioncorta" id="input-2" size="15" maxlength="15" placeholder="Descripción corta del Tipo de Documento" value="<?=$tiposDocumentosLegale->descripcioncorta ?>">
         <label for="color" class="stacked-label" data-toggle="tooltip" title="Color del documento"><i class="pe-7s-paint-bucket"></i></label>
         <div id="colorPicker" name="colorPicker"></div>
         <input type="hidden" name="color" id="color" value="<?=$tiposDocumentosLegale->color?>">
         <input type="hidden" name="id" value="<?=$tiposDocumentosLegale->id?>">
         <input type="hidden" name="idgrem" value="<?=$tiposDocumentosLegale->idgrem?>">
         <?= $this->Form->button(__('Guardar')) ?>
      </div>
   </article>
</div>

<?= $this->Form->end() ?>


<div class="col-md-6 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>tipos-documentos-Legales/index" class="btn dark inverse">Volver</a>
   </div>
</div>
