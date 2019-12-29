<?=  $this->Form->create() ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Contabilización ventas</h3>
         </div>
      </header>
      <div class="media-body">
    <h5 class="media-heading message__heading"></h5>
    <p class="message__location">
    <i class="pe-7s-date"></i>Grupo Empresarial: <?= $empresa ?>
    </p>
    <p class="message__location">
      <i ></i>
    </p>
    <p class="message__location">
      <i class="pe-7s-date"></i>Empresa: <?= $empresa_pa ?>
    </p>
    <p class="message__location">
      <i ></i>
    </p>
    </div>
    <script>
    function validaNumericos(event) {
      if(event.charCode >= 48 && event.charCode <= 57){
          return true;
      }
      return false;
    }
    </script>
      <div class="widget__content">
         <?=$this->Form->hidden("mes")?>


       <label for="fecha" class="stacked-label" data-toggle="tooltip" title="Fecha" ><i class="pe-7s-note" ></i></label>
       <?=$this->Form->text("fecha", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fecha", "type"=> "date",'placeholder' => 'Fecha*', "value" => date("Y-m-d"), "style" => "color:black;", "required" => true]);?>







       <?= $this->Form->button(__('Ejecutar contabilización automática ventas para la fecha seleccionada')) ?>
</div>
</article>
</div>
<?= $this->Form->end() ?>
<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>principales/home" class="btn dark inverse">Volver</a>
</div>
</div>
<script language="javascript">
$("#nombre").focus();
</script>
