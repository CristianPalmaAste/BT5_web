<?= $this->Form->create($gre) ?>
 


 
	  <h1>Movimientos de Bodega</h1><br/>

		 
	  <table style="border:1px solid white;" border="2" cellspacing="1" cellpadding="1">
        <tr><td><label for='producto' >Producto*</label></td>
        <td><?=$this->Form->text("producto", ["size" => 8, "maxlength" => 8, "class" => "stacked-input upper", "id" => "producto", 'style' => 'color:black;', 'required' => true]);?>
		<?=$this->Form->select("prodv", $prodv, ["class" => "stacked-input", "id" => "prodv", 'style' => 'color:black;']);?>
		</td></tr>
        <tr><td><label for='idtire' >Bodega</label></td>
		<td><?=$this->Form->select("idbode", $bodegas, ["class" => "stacked-input", "id" => "idbode", 'style' => 'color:black;']);?></td></tr>

         <tr><td><label for='fecini' >Fecha Inicio</label></td>
		 <td><?=$this->Form->text("fecini", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fecini", 'style' => 'color:black;', "type" => "date"]);?></td></tr>
		 <tr><td><label for='fecfin' >Fecha Fin</label></td>
		 <td><?=$this->Form->text("fecfin", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fecfin", 'style' => 'color:black;', "type" => "date"]);?></td></tr>

 <tr><td colspan='2' align="center">
		    		
			<?=$grilla?>
			
		 <input type="hidden" id="idprod" value="<?=$idprod?>"/>
		 
		 </td></tr>

<tr><td colspan='2' align='right'><button type='submit' class='ninguna' style="color:black">Consultar</button></td></tr>
<tr><td colspan='2'>
<table class="table">
	      <thead>
	      <th>Fecha     </th>
		  <th>Bodega    </th>
		  <th>Movimiento</th>
		  <th>Entradas</th>
		  <th>Salidas</th>
		  </thead>
		  

       
		  <?php $n=0;?>
		  <?php foreach($registros as $r): ?>
		  <?php $n++; $s=$r["fecha_movto"]; ?>
		   <tr>
	          <td><?=substr($s, 8,2)."/".substr($s, 5,2)."/".substr($s,0,4)?></td>
		      <td><?=$r["bodega"]?></td>
		      <td><?=$r["movto_bodega"]?></td>
			  
			  <?php if ($r["movto_bodega"]=="COMPRA"):?>
			  <td align="right"><?=$r["cantidad"]?></td>
			  <td>&nbsp;</td>
			  <?php else:?>
			  <td>&nbsp;</td>	
			  <td style="text-align:righ;"><?=$r["cantidad"]?></td>
			  <?php endif;?>
		   </tr>  
		  
		  <?php endforeach;?>
		  
		  <?php if ($n==0):?>
		     <td colspan="5"><?php if ($gre->producto!="") echo "¡No se encontró información!."; ?></td>
		  <?php endif;?>
	      
</table>
    </td>
</tr>	
</table>
<?= $this->Form->button(__('Guardar'), ["id" => "btnGuardar"]) ?>

<div class="paginator">
   <ul class="pagination">
      <?= $this->Paginator->first('<< ' . __('Primero')) ?>
      <?= $this->Paginator->prev('< ' . __('Anterior')) ?>
      <?= $this->Paginator->numbers() ?>
      <?= $this->Paginator->next(__('Siguiente') . ' >') ?>
      <?= $this->Paginator->last(__('Último') . ' >>') ?>
    </ul>
<p><?=$this->Paginator->counter('Página {{page}} de {{pages}}') ?></p>
</div>


<?= $this->Form->end() ?>
<!--
<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>MovimientosBodegas/index" class="btn dark inverse">Volver</a>
</div>
</div>
-->

<script language="javascript">
$("#producto").focus();

   document.getElementById("btnGuardar").style.display="none";
   
   document.getElementById("prodv").onchange=function() {
	  //alert(this.value);
	  
	  e = this.value.split("-");
	  
	  document.getElementById("producto").value = e[0];
	  document.getElementById("idprod").value = e[1];
   }
   
   document.getElementById("producto").onchange=function() {
	  //alert(this.value);
	  l = document.getElementById("prodv");
	  
	  for (i=0; i < l.options.length; i++) {
		 e = l.options[i].value.split("-");
		 
		 if (this.value==e[0]) {
			document.getElementById("producto").value = e[0];
	        document.getElementById("idprod").value = e[1];
			
			l.selectedIndex = i;
			return;
		 }
	  }
	  	  
	  alert("¡Producto no encontrado!");
	  
	  l.selectedIndex=0;
	  this.value="";
	  this.select();
	  this.focus();
   }
</script>
