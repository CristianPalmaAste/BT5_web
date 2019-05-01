<?= $this->Form->create($gre, ["id" => "frm", "method" => "post"]) ?> 

<div class="container">

<h1>Aprobación de Cotizaciones</h1>

<table class="table">
   <thead>
   <tr>
       <td colspan="center">&nbsp;</td>
       <td colspan="center">Número</td>
       <td colspan="center">Fecha</td>
	   <td colspan="center">Cliente</td>	   
	   <td colspan="center">Validez días</td>
	   <td colspan="center">Total</td>
	   <td colspan="center">Estado</td>
	</tr>
   </thead>
   
   <tbody>
<?php $nRow=0; ?>   
<?php foreach ($cotizaciones as $cotizacion): ?>
   <tr>      
      <td><input type="checkbox" name="doctos" value="<?=$cotizacion->id?>"/></td>
      <td align="right"><?= $cotizacion->numero ?></td>
      <td><?= $this->Time->format($cotizacion->fechacotizacion,'d/MM/Y') ?></td>
      <td><?= $cotizacion->cliente ?></td>
      <td align="right"><?= $cotizacion->diasvalidez ?></td>
	  <td align="right">$<?= number_format($cotizacion->total, 0, ",", ".") ?></td>
	  <td align="center"><?= $cotizacion->estado ?></td>      
   </tr>
   <input type="hidden" name="id<?=$nRow?>" id="id<?=$nRow?>" value="<?=$cotizacion->id?>"/>
   <input type="hidden" name="old_idescv<?=$nRow?>" id="old_idescv<?=$nRow?>" value="<?=$cotizacion->idescv?>"/>
   <?php $nRow++; ?>  
<?php endforeach; ?>
</tbody>
</table>

<input type="hidden" name="nRow" id="nRow" value="<?=$nRow ?>"/>

<button type="submit" class="btn btn-primary" style="float:center;" id="cambiarEstados">Aceptar</button>

<div class="btn-group block">
<a href="<?=$this->request->webroot?>CotizacionesVentas/index" class="btn dark inverse">Volver</a>
</div> 
</div>
<input type="hidden" name="lista" id="lista"/>

<script language="javascript">
  document.getElementById("frm").onsubmit=function() {
	 doctos = document.getElementsByName("doctos");

	 nCuenta=0;
	 
	 lista="";
	 for (i=0; i < doctos.length; i++)
		if (doctos[i].checked) {
		   nCuenta++;
		   
		   if (lista!="") lista = lista + ",";
		   
		   lista = lista + doctos[i].value;
		}
		
	 document.getElementById("lista").value = lista;	
	
	 if (nCuenta==0) {
		alert("¡Ningún documento seleccionado!");
		return false;
	 }

     //alert(lista);	 
  	 
	 return true;
  }
</script>
</frm>