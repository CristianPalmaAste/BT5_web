<?= $this->Form->create($gre, ["id" => "frm", "name" => "frm"]) ?>
 
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Autorizadores de Requisiciones</h3>
         </div>
      </header>
	  
<?=$this->Form->hidden("id")?>
<?=$this->Form->hidden("idempr", ["id" => "idempr"])?>	  

	  <div class="row">
         <div class="col-lg-2">
          <label for='idperfautorizador' >Autorizador*</label>
		 </div>
		 <div class="col-lg-4">
		 <?php if ($modo=="new"): ?>
         <?=$this->Form->select("idperfautorizador", $perfiles_nuevos, ["class" => "stacked-input", "id" => "idperfautorizador", 'placeholder' => 'Perfil Autorizador*', 'style' => 'color:black;']);?>
		 <?php else: ?>
		 <?=$this->Form->hidden("idperfautorizador");?>
		 <?=$usuarios[$gre->idperfautorizador]?>
		 <?php endif; ?>
		 </div>
		 <div class="col-lg-6">
		 </div>
      </div>
	  <div class="row" style="padding:10px">
	     <div class="col-lg-12>&nbsp;</div>
	  </div>

      <div class="row">
	     <div class="col-lg-2">
		 </div>
         <div class="col-lg-4" style="padding-bottom:5px">	  
            Disponibles
		 </div> 	
		 <div class="col-lg-1">
         </div>		 
		 <div class="col-lg-4" style="padding-bottom:5px">	  
            Seleccionados
		 </div>
	  </div>
	  
	  <div class="row">
  	     <div class="col-lg-2">
		 </div>

	     <div class="col-lg-4">
		   <select id="dispon" size="12" style="color:black; width:300px" ondblclick="move(document.frm.dispon, document.frm.sels);">
		   
           <?php foreach($perfiles_libres as $key => $val):?>
		      <option value="<?=$key?>"><?=$val?></option>
		   <?php endforeach;?>
           </select>
		 </div>
		 <div class="col-lg-1">
		    <br/><br/><br/><br/>
		    <input type="button" id="mover" onclick="move(document.frm.dispon, document.frm.sels);" value=">>" style="color:black"/><br/><br/> 
            <input type="button" id="quitar" onclick="move(document.frm.sels, document.frm.dispon);" value="<<" style="color:black"/>
			
		 </div>
		 <div class="col-lg-4">
		   <select id="sels" size="12" style="color:black; width:300px" ondblclick="move(document.frm.sels, document.frm.dispon);">
           <?php foreach($sels as $key => $val):?>
		      <option value="<?=$key?>"><?=$val?></option>
		   <?php endforeach;?>
           </select>
		 </div>
      </div>

<?= $this->Form->button(__('Guardar')) ?>



<input type="hidden" name="seleccionados" id="seleccionados"/>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>AutorizadoresRequisiciones/index" class="btn dark inverse">Volver</a>
</div>


<script language="javascript">
$("#idperfautorizador").focus();

   function move(dispon, sels) {
	  if (dispon.selectedIndex < 0) return;
	  
	  //Lo agrego
	  var option = document.createElement("option");
      option.value = dispon.value;
      option.text = dispon.options[dispon.selectedIndex].text;
      sels.appendChild(option);
	  
	  //Lo borro
	  dispon.options[dispon.selectedIndex] = null;
   }
   
   document.getElementById("frm").onsubmit=function() {	  
	  lista="";
	  sels = document.getElementById("sels");
	  
	  n = 0;
	  for (i=0; i < sels.length; i++)  {
		n = n + 1;
	    lista = lista + (lista!=""?";":"") + sels.options[i].value;
	  }
		  
	  if (n==0) {
		 alert("¡No ha seleccionado usuarios!");
	     return false;
	  }
	  
	  //alert(lista);
	  
	  document.getElementById("seleccionados").value=lista;
	  
	  return true;
   }
</script>
