<?= $this->Html->script('jquery.Rut'); ?>
<?= $this->Html->script('jquery.validate'); ?>

<script>
   function alertaRut(){
      alert('RUT incorrecto');
      $("#rut").focus();
   }

   $(document).ready(function(){
      $('#rut').Rut({
         on_error: function(){
            alertaRut();
         },
         format_on: 'keyup'
      });

      $("#rut").on('blur',function(e){
         var rut = $("#rut").val();
         var id1 = rut.substr(0,rut.length-2);
         var id2 = rut.substr(rut.length-1);
         id1 = id1.replace(/\./g,'');
         $("#identificador1").val(id1);
         $("#identificador2").val(id2);
         var i1 = $("#identificador1").val();
         var i2 = $("#identificador2").val();

         console.log(i1);
         console.log(i2);

      });
   });
</script>

<?php echo $this->BForm->formHeader( 'Personas' ); ?>

<?= $this->Form->create($persona) ?>

<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-id"></i><h3>Datos Personales</h3>
         </div>
      </header>


      <?=$this->Form->text("identificador1", ["type" => "hidden",'id'=>'identificador1']) ?>
      <?=$this->Form->text("identificador2", ["type" => "hidden",'id'=>'identificador2']) ?>

      <div class="widget__content">
         <label for="rut" class="stacked-label" data-toggle="tooltip" title="RUT/Identificador único [SÓLO LECTURA]"><i class="pe-mi-id"></i></label>
         <?=$this->Form->text("rut", ["style"=>"color:#c0c000","size" => 12, "maxlength" => 12, "class" => "stacked-input disabled", "id" => "rut", "placeholder" => "RUT",'value'=>$rut,'disabled'=>true]);?>
         <label for="primernombre" class="stacked-label" data-toggle="tooltip" title="Primer nombre"><i class="pe-mi-contacts-2"></i></label>
         <?=$this->Form->text("primernombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "primernombre", "placeholder" => "primernombre"]);?>
         <label for="segundonombre" class="stacked-label" data-toggle="tooltip" title="Segundo nombre"><i class="pe-mi-contacts-2" ></i></label>
         <?=$this->Form->text("segundonombre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "segundonombre", "placeholder" => "segundonombre"]);?>
         <label for="apellidopaterno" class="stacked-label" data-toggle="tooltip" title="Apellido paterno"><i class="pe-mi-contacts-2" ></i></label>
         <?=$this->Form->text("apellidopaterno", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "apellidopaterno", "placeholder" => "apellidopaterno"]);?>
         <label for="apellidomaterno" class="stacked-label" data-toggle="tooltip" title="Apellido materno"><i class="pe-mi-contacts-2" ></i></label>
         <?=$this->Form->text("apellidomaterno", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "apellidomaterno", "placeholder" => "apellidomaterno"]);?>
         <label for="email" class="stacked-label" data-toggle="tooltip" title="Correo electrónico"><i class="pe-mi-mail"></i></label>
         <?=$this->Form->text("email", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "email", "placeholder" => "email"]);?>
         <label for="fechanac" class="stacked-label" data-toggle="tooltip" title="Fecha de nacimiento"><i class="pe-mi-calendar"></i></label>
         <?= $this->Form->input(
            'fechanac',
            array(
               'type' => 'text',
               'label' => false,
               'class' => 'stacked-input datepicker',
               'id' => 'fechanac',
               'placeholder' => 'Fecha de nacimiento',
               'value' => $this->Time->format($persona->fechanac,'d-MM-Y')
            )
         ) ?>
         <label for="idesci" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Estado civil"><i class="pe-mi-love"></i></label>
         <?php echo $this->Form->input(
            'idesci',
            array(
               'type' => 'select',
               'placeholder' => 'Estado Civil',
               'empty' => 'Estado Civil',
               'options' => $eciviles,
               'label' => false,
               'id' => 'idesci',
               'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
            )
         );?>
         <label for="idsexo" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Sexo"><i class="pe-mi-sex"></i></label>
         <?php echo $this->Form->input(
            'idsexo',
            array(
               'type' => 'select',
               'placeholder' => 'Sexo',
               'empty' => 'Sexo',
               'options' => $sexos,
               'label' => false,
               'id' => 'idsexo',
               'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
            )
         );?>
         <label for="idpais" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Nacionalidad"><i class="pe-mi-flag-1"></i></label>
         <?php echo $this->Form->input(
            'idpais',
            array(
               'type' => 'select',
               'placeholder' => 'Nacionalidad',
               'empty' => 'Nacionalidad',
               'options' => $paises,
               'label' => false,
               'id' => 'idpais',
               'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'
            )
         );?>

         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idgrem")?>
         <?= $this->Form->button(__('Guardar')) ?>

      </div>
   </article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>principales/home" class="btn dark inverse">Volver</a>
   </div>
</div>
