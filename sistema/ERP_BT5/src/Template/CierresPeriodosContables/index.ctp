<?=  $this->Form->create() ?>
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Cierres Periodos Contables</h3>
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
         <p class="message__location">
            <i class="pe-7s-date"></i>Período contable abierto: <?= $periodo_abierto ?>
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
       <label for="mes" class="stacked-label" data-toggle="tooltip" title="Mes" ><i class="pe-7s-note" ></i></label>
         <?=$this->Form->select("mes", array('0' => 'Seleccione Mes *', '1' => 'Enero', '2' => 'Febrero','3'=>'Marzo','4'=>'Abril','5'=>'Mayo'
                                      ,'6'=>'Junio','7'=>'Julio','8'=>'Agosto','9'=>'Septiembre','10'=>'Octubre','11'=>'Noviembre','12'=>'Diciembre'), ["class" => "stacked-input upper", "id" => "mes", "placeholder" => "mes", 'placeholder' => 'Mes*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
       <label for="anno" class="stacked-label" data-toggle="tooltip" title="Año" ><i class="pe-7s-note" ></i></label>
       <?=$this->Form->text("anno", ["size" => 4, "maxlength" => 4, "class" => "stacked-input upper", "id" => "anno", "onkeypress"=> "return validaNumericos(event)",'placeholder' => 'Año*']);?>
<?= $this->Form->button(__('Ejecutar cierre')) ?>
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
