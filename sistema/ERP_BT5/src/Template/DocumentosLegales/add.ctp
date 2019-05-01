<?php
/**
  * @var \App\View\AppView $this
  */
?>

<?= $this->Form->create($documentosLegale,['enctype' => 'multipart/form-data','id'=>'formADD']) ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Nuevo de Documento Legal</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="fecha" class="stacked-label" data-toggle="tooltip" title="Fecha del documento"><i class="pe-7s-date"></i></label>
         <?= $this->Form->input(
            'fecha',
            array(
               'type' => 'text',
               'label' => false,
               'class' => 'stacked-input datepicker',
               'id' => 'fecha',
               'placeholder' => 'Fecha documento'
            )
         ) ?>
         <label for="idtidl" class="stacked-label" data-toggle="tooltip" title="Tipo de documento"><i class="pe-7f-menu"></i></label>
         <?php echo $this->Form->input(
            'idtidl',
            array(
               'type' => 'select',
               'placeholder' => 'Tipo de Documento',
               'empty' => 'Tipo de Documento',
               'options' => $tiposDocumentos,
               'label' => false,
               'id' => 'idtidl',
               'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
            )
         );?>

         <label for="idesdl" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Estado del documento"><i class="pe-7f-menu"></i></label>
         <?php echo $this->Form->input(
            'idesdl',
            array(
               'type' => 'select',
               'placeholder' => 'Estado del Documento',
               'empty' => 'Estado del Documento',
               'options' => $estadosDocumentos,
               'default' => 1,
               'label' => false,
               'id' => 'idesdl',
               'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
            )
         );?>

         <input type="hidden" name="idempr" value="<?=$idEmpr?>">
         <input type="hidden" name="avisodado" value="N">
         <input type="hidden" name="nombreoriginal" value="">
         <input type="hidden" name="nombresistema" value="">

         <label for="notaria" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Notaría"><i class="pe-7s-hammer"></i></label>
         <?= $this->Form->input(
            'notaria',
            array(
               'type' => 'text',
               'label' => false,
               'class' => 'stacked-input upper',
               'id' => 'notaria',
               'placeholder' => 'Notaría'
            )
         ) ?>

         <label for="foja" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Foja"><i class="pe-7s-wallet"></i></label>
         <?= $this->Form->input(
            'foja',
            array(
               'type' => 'text',
               'label' => false,
               'class' => 'stacked-input upper',
               'id' => 'foja',
               'placeholder' => 'Foja'
            )
         ) ?>

         <label for="responsable" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Responsable"><i class="pe-7s-id"></i></label>
         <?= $this->Form->input(
            'responsable',
            array(
               'type' => 'text',
               'label' => false,
               'class' => 'stacked-input upper',
               'id' => 'responsable',
               'placeholder' => 'Responsable'
            )
         ) ?>

         <label for="comentario" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Comentario"><i class="pe-7s-comment"></i></label>
         <?= $this->Form->input(
            'comentario',
            array(
               'type' => 'text',
               'label' => false,
               'class' => 'stacked-input upper',
               'id' => 'comentario',
               'placeholder' => 'Comentario'
            )
         ) ?>

         <label class="full-label" style="clear:both;" data-toggle="tooltip" title="Archivo Legal">
            <input type="file" name="fileupload" id="file-att" placeholder="Archivo" class='stacked-input' />
            <i class="pe-7f-paperclip"></i><span class="label">Archivo</span>
         </label>

         <label for="fechaaviso" class="stacked-label" data-toggle="tooltip" title="Fecha de Aviso"><i class="pe-7s-date"></i></label>
         <?= $this->Form->input(
            'fechaaviso',
            array(
               'type' => 'text',
               'label' => false,
               'class' => 'stacked-input datepicker',
               'id' => 'fechaaviso',
               'placeholder' => 'Fecha Aviso'
            )
         ) ?>

         <label for="emailaviso" class="stacked-label" data-toggle="tooltip" title="Correo de Aviso"><i class="pe-7s-mail"></i></label>
         <?= $this->Form->input(
            'emailaviso',
            array(
               'type' => 'text',
               'label' => false,
               'class' => 'stacked-input upper',
               'id' => 'emailaviso',
               'placeholder' => 'Correo Aviso'
            )
         ) ?>

         <label for="xfld" class="stacked-label" data-toggle="tooltip" title="Extra"><i class="pe-7s-box2"></i></label>
         <?= $this->Form->input(
            'xfld',
            array(
               'type' => 'text',
               'label' => false,
               'class' => 'stacked-input upper',
               'id' => 'xfld',
               'placeholder' => 'Extra'
            )
         ) ?>

         <?= $this->Form->button(__('Guardar')) ?>
      </div>
      <?php $volver = $this->request->webroot.$this->name; ?>
      <?= $this->Form->button('<i class="pe-7f-back"></i> Volver',['type'=>'button','onclick'=>"window.location.href='$volver'",'style'=>'margin-top:50px;']) ?>
</article>
</div>

<?= $this->Form->end() ?>
