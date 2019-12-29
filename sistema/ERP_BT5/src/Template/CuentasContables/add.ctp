<?=  $this->Form->create($gre) ?>
  
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Agregar Cuentas Contables</h3>
         </div>
      </header>
      <div class="media-body">
	     <h5 class="media-heading message__heading"></h5>
		 <p class="message__location">
		    <i class="pe-7s-date"></i>Grupo Empresarial: <?= $empresa ?>
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
         <?=$this->Form->hidden("id")?>
     
       <?php 
       for($i = 1; $i <= $para_valor; $i++){?>
          <label for="Segmento<?php echo $i;?>" class="stacked-label" data-toggle="tooltip" title="Segmento<?php echo $i;?>" ><i class="pe-7s-note" ></i></label>
          <?php  
	          if ($para1 == $i && $para1 != 0){?>
	             <?=$this->Form->text("segmento1", ["size" => $para1, "maxlength" => $para1, "class" => "stacked-input upper", "id" => "segmento1",  "onkeypress"=> "return validaNumericos(event)","placeholder" => "Segmento1", 'placeholder' => 'Segmento1*']);?>
	          <?php } 
	          if($para2 ==  $i && $para2 != 0){?>
	             <?=$this->Form->text("segmento2", ["size" => $para2, "maxlength" => $para2, "class" => "stacked-input upper", "id" => "segmento2",  "onkeypress"=> "return validaNumericos(event)","placeholder" => "Segmento2", 'placeholder' => 'Segmento2*']);?>
	          <?php } 
	          if($para3 ==  $i && $para3 != 0){?>
	             <?=$this->Form->text("segmento3", ["size" => $para3, "maxlength" => $para3, "class" => "stacked-input upper", "id" => "segmento3",  "onkeypress"=> "return validaNumericos(event)","placeholder" => "Segmento3", 'placeholder' => 'Segmento3*']);?>
	          <?php } 
	          if($para4 ==  $i && $para4 != 0){?>
	             <?=$this->Form->text("segmento4", ["size" => $para4, "maxlength" => $para4, "class" => "stacked-input upper", "id" => "segmento4",  "onkeypress"=> "return validaNumericos(event)","placeholder" => "Segmento4", 'placeholder' => 'Segmento4*']);?>
	          <?php } 
	          if($para5 ==  $i && $para5 != 0){?>
	             <?=$this->Form->text("segmento5", ["size" => $para5, "maxlength" => $para5, "class" => "stacked-input upper", "id" => "segmento5",  "onkeypress"=> "return validaNumericos(event)","placeholder" => "Segmento5", 'placeholder' => 'Segmento5*']);?>
	          <?php } 
	          if($para6 ==  $i && $para6 != 0){?>
	             <?=$this->Form->text("segmento6", ["size" => $para6, "maxlength" => $para6, "class" => "stacked-input upper", "id" => "segmento6",  "onkeypress"=> "return validaNumericos(event)","placeholder" => "Segmento6", 'placeholder' => 'Segmento6*']);?>
	          <?php } 
	          if($para7 ==  $i && $para7 != 0){?>
	             <?=$this->Form->text("segmento7", ["size" => $para7, "maxlength" => $para7, "class" => "stacked-input upper", "id" => "segmento7",  "onkeypress"=> "return validaNumericos(event)","placeholder" => "Segmento7", 'placeholder' => 'Segmento7*']);?>
	          <?php } 
	          if($para8 ==  $i && $para8 != 0){?>
	             <?=$this->Form->text("segmento8", ["size" => $para8, "maxlength" => $para8, "class" => "stacked-input upper", "id" => "segmento8",  "onkeypress"=> "return validaNumericos(event)","placeholder" => "Segmento8", 'placeholder' => 'Segmento8*']);?>
	          <?php } 
	          ?>
       <?php } ?>
       <label for="Descripción" class="stacked-label" data-toggle="tooltip" title="Nombre Cuenta" ><i class="pe-7s-note" ></i></label>
       <?=$this->Form->text("descripcion", ["size" => 10, "maxlength" => 50, "class" => "stacked-input upper", "id" => "descripcion",'placeholder' => 'Descripción*']);?>
       <label for="idticc" class="stacked-label"><i data-toggle="tooltip" title="Tipo Cuenta" class="pe-7s-menu" ></i></label>
       <?=$this->Form->select("idticc", $tipos_cuentas_contables, ["class" => "stacked-input", "id" => "idticc",'placeholder' => 'Tipo Cuenta Contable*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         
         
         
                          
<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>CuentasContables/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();
</script>
