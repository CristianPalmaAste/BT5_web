<?php
/**
  * @var \App\View\AppView $this
  */
?>

<?= $this->Form->create($documento,['enctype' => 'multipart/form-data','type'=>'POST']) ?>

<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Actualización de Documento Legal</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="input-1" class="stacked-label" data-toggle="tooltip" title="Fecha del Documento"><i class="pe-7s-date"></i></label>
         <?= $this->Form->input(
            'fecha',
            array(
               'type' => 'text',
               'label' => false,
               'class' => 'stacked-input datepicker',
               'id' => 'fecha',
               'placeholder' => 'Fecha documento',
               'value' => $this->Time->format($documento->fecha,'d-MM-Y')
            )
         ) ?>

         <label for="input-2" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Tipo de Documento"><i class="pe-7f-menu"></i></label>
         <?php echo $this->Form->input(
            'idtidl',
            array(
               'type' => 'select',
               'placeholder' => 'Tipo de Documento',
               'options' => $tiposDocumentos,
               'option' => $documento->idtidl,
               'label' => false,
               'id' => 'idtidl',
               'style' => 'width: calc(100% - 65px);display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
            )
         );?>

         <label for="input-2" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Estado del Documento"><i class="pe-7s-edit"></i></label>
         <?php echo $this->Form->input(
            'idesdl',
            array(
               'type' => 'select',
               'options' => $estadosDocumentos,
               'option' => $documento->idesdl,
               'label' => false,
               'id' => 'idesdl',
               'style' => 'width: calc(100% - 65px);display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
            )
         );?>

         <input type="hidden" name="idempr" value="<?=$documento->idempr?>">
         <input type="hidden" name="avisodado" value="<?=$documento->avisodado?>">
         <input type="hidden" name="nombreoriginal" value="<?=$documento->nombreoriginal?>">
         <input type="hidden" name="nombresistema" value="<?=$documento->nombresistema?>">

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

         <label class="full-label" style="clear:both;" data-toggle="tooltip" title="Archivo">
            <input type="file" name="fileupload" id="file-att">
            <i class="pe-7f-paperclip"></i><span class="label"><?=$documento->nombreoriginal?></span>
         </label>

         <label for="fechaaviso" class="stacked-label" data-toggle="tooltip" title="Fecha de Aviso"><i class="pe-7s-date"></i></label>
         <?= $this->Form->input(
            'fechaaviso',
            array(
               'type' => 'text',
               'label' => false,
               'value' => $this->Time->format($documento->fechaaviso,'d-MM-Y'),
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

         <?= $this->Form->button('<i class="pe-7s-diskette"></i> Guardar') ?>
         <?php $volver = $this->request->webroot.$this->name; ?>
         <?= $this->Form->button('<i class="pe-7f-back"></i> Volver',['type'=>'button','onclick'=>"window.location.href='$volver'",'style'=>'margin-top:50px;']) ?>
      </div>
   </article>
</div>

<?= $this->Form->end() ?>

