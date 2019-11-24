<?php echo $this->Html->css('scroll'); ?>
<?php echo $this->Html->css('modal');?>

<?= $this->Form->create($gre, ["id" => "frm", "method" => "post"]) ?> 

     <div class="widget__content">
	     <h1>Asientos Contables</h1><br/>
	     <table style="border:1px solid white;" border="1" cellspacing="1" cellpadding="1">
         <?=$this->Form->hidden("id")?>
		 <input type="hidden" name="idgrem" id="idgrem" value="<?=$idgrem?>"/>
		 <tr><td>
         <label for="numero_asiento" >Número*</label></td>
		 <td>
         <?=$this->Form->text("numero_asiento", ["size" => 10, "maxlength" => 10, "class"=>"up", "style"=>"color:black;", "id" => "numero_asiento", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 &nbsp;
		 <label for="fecha_asiento" >Fecha*</label>
		 &nbsp;
         <?=$this->Form->text("fecha_asiento", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "placeholder" => "dd-mm-aaaa", "id" => "fecha_asiento", "style" => "color:black;", "required" => true, "type"=>"date"]);?>
		 &nbsp;
		 <label for="idtiac" >Tipo*</label>
		 &nbsp;
         <?=$this->Form->select("idtiac", $tipos_asientos_contables, ["class" => "stacked-input upper", "id" => "idtiac", "style" => "color:black;", "required" => true]);?>
		 </td>
		 </tr>
		 <tr><td><label for="glosa" >Glosa*</label></td>
		 </td>
		 <td>
         <?=$this->Form->text("glosa", ["size" => 60, "maxlength" => 100, "class" => "stacked-input upper", "id" => "glosa", "required" => true, "style" => "color:black;"]);?>
           </td>
		 </tr>
		 <tr>
		 <td>
         <label for="reversible" >Reversible</label>
		  </td><td>
		 <?=$this->Form->select("reversible", $reversibles, ["class" => "stacked-input upper", "id" => "reversibles", "style" => "color:black;", "required" => true]);?>
		 </td>
		 </tr>
		 <tr>
		 <td>
         <label for="idesac" >Estado</label>
		  </td><td>
		 <?=$this->Form->select("idesac", $estados_asientos_contables, ["class" => "stacked-input upper", "id" => "idesac", "style" => "color:black;", "required" => true, "disabled" => true]);?>
		 </td>
		 </tr>
		 <tr><td colspan='2' align="center">
		    		
			<?=$grilla?>
			
		 <input type="hidden" id="nRow" value="<?=$nRow?>"/>
		 
		 </td></tr>
		 
		 <tr>
		     <td>&nbsp;</td>
	         <td>
			 TOTALES IGUALES&nbsp;
		     <input type="text" id="sdebcmp" name="sdebcmp" value="<?=$sdebcmp?>" size=12 maxlength=12 readonly style="color:white;text-align:right;background-color:rgba(0, 0, 0, 0.25);"/>
             &nbsp;

			 <input type="text" id="shabcmp" name="shabcmp" value="<?=$shabcmp?>" size=12 maxlength=12 readonly style="color:white;text-align:right;background-color:rgba(0, 0, 0, 0.25);"/>
		     </td>
		 </tr>

         <tr><td colspan='2'>
		   <table width=100%>
		   <tr>
		   <td>
		   <input type="text" id="descta" size="60" readonly style="color:white;background-color:rgba(0, 0, 0, 0.25);"/>
		   </td>
		   <td align="right">
           <?= $this->Form->button(__('Guardar'), ["style" => "color:black;"]) ?>
           </td>
		   </tr>
		   </table>
         </td>
		 </tr>
         </table>
		 <input type="hidden" id="currentRow"/>
		 <input type="hidden" id="allRows" name="allRows"/>
		 
		 <input type="hidden" id="lProductos" name="lProductos" value="<?=$lProductos?>"/>
		 
		 <input type="hidden" id="SEPNIVELES"  name="SEPNIVELES"   value="<?=$SEPNIVELES ?>"/>
		 <input type="hidden" id="FORMATOCTAS" name="FORMATOCTAS"  value="<?=$FORMATOCTAS?>"/>
		 <input type="hidden" id="LARGOSEGM1"  name="LARGOSEGM1"   value="<?=$LARGOSEGM1 ?>"/>
		 <input type="hidden" id="LARGOSEGM2"  name="LARGOSEGM2"   value="<?=$LARGOSEGM2 ?>"/>
		 <input type="hidden" id="LARGOSEGM3"  name="LARGOSEGM3"   value="<?=$LARGOSEGM3 ?>"/>
		 <input type="hidden" id="LARGOSEGM4"  name="LARGOSEGM4"   value="<?=$LARGOSEGM4 ?>"/>
		 <input type="hidden" id="LARGOSEGM5"  name="LARGOSEGM5"   value="<?=$LARGOSEGM5 ?>"/>
		 <input type="hidden" id="LARGOSEGM6"  name="LARGOSEGM6"   value="<?=$LARGOSEGM6 ?>"/>
		 <input type="hidden" id="LARGOSEGM7"  name="LARGOSEGM7"   value="<?=$LARGOSEGM7 ?>"/>
		 <input type="hidden" id="LARGOSEGM8"  name="LARGOSEGM8"   value="<?=$LARGOSEGM8 ?>"/>
		 
<?= $this->Form->end() ?>		
<div class="btn-group block">
<a href="<?=$this->request->webroot?>AsientosContables/index" class="btn dark inverse">Volver</a>
</div> 
</div>



<!--
<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>AsientosContables/index" class="btn dark inverse">Volver</a>
</div>
</div>
-->

<!-- Trigger/Open The Modal--> 
<div id="myModal" class="modal">

<!--<button id="myBtn">Open Modal</button>-->

  <!-- Modal content -->
  <div class="modal-content">
    <span class="close">&times;</span>
    <p>Buscador de Cuentas</p><br
	<p>
	 <div class="row">
	    <div class="col-lg-1">
		  Buscar
		</div>
		
		<div class="col-lg-3">
		   <input type="text" id="sTexto" size="20" class="form-control UPPER" style="color:black"/>
		</div>

	    <div class="col-lg-1">
		   <button id="bCuentas" class="btn btn-primary">Aceptar</button>
		</div>

	 </div>
	 
	 <br/>
	 
	 <div class="row">
	    <div class="col">
		   Cuentas
		   </select>
		</div>
	 </div>
	 
	 <div class="row">
	    <div class="col">
		   <select id="listaCuentas" class="form-control" size="12">
		   </select>
		</div>
	 </div>
	 
	 </p>
	
  </div>

</div>


<?=$this->Html->script('valrut.js');?>
<?=$this->Html->script('valdate.js');?>

<script>   
// Get the modal
var modal = document.getElementById("myModal");

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
btn.onclick = function() {
  modal.style.display = "block";
  
  document.getElementById("listaCuentas").options.length=0;
  document.getElementById("sTexto").value="";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}   
   
   document.getElementById("frm").onsubmit=function() {
     tbl = document.getElementById("mitabla");
     
     if (tbl.rows.length < 3) {
		alert("¡Asiento debe tener dos línea de detalle como mínimo!");
		
		return false;
	 }
	 
	 sdebcmp = document.getElementById("sdebcmp").value;
	 shabcmp = document.getElementById("shabcmp").value;
	 
	 if (sdebcmp!=shabcmp) {
		alert("¡Asiento no está cuadrado!");
		return false;
	 }
     
     allRows="";
     
     for (i=2; i < tbl.rows.length; i++) {
   	    if (allRows!="") allRows = allRows + "@@@";
   	 
   	    allRows = allRows + document.getElementById("data"+i).value;		 		  
     }
     
     document.getElementById("allRows").value = allRows;
   	  
     
	 return true;
   }
      
      var lonCuenta= 0; 	  
      var niveles = new Array();
	  
	  for (i=1; i <= 8; i++) {
		 n = document.getElementById("LARGOSEGM"+i).value*1.0;
		 
		 //alert("Valor de n: "+n);
		 
		 if (n==0) break;
		 
		 lonCuenta = lonCuenta + n;
		 niveles[niveles.length]=n;
	  }
	  
	  //alert(lonCuenta+" "+niveles.length);
	  
	  var sepCuenta=document.getElementById("SEPNIVELES").value;
	  
	  cuenta = document.getElementById("cuenta");
	  cuenta.size=lonCuenta + niveles.length - 1;
	  cuenta.maxLength=lonCuenta + niveles.length - 1;
	  //cuenta.focus();
	  
	  //function isDigit(c) {
	  //	 return c >= "0" && c <= "9";
	  //}
	  
	  document.getElementById("cuenta").onfocus=function() {
		 cuenta = document.getElementById("cuenta");
    	  
    	  s = "";
    	  for(i=0; i < cuenta.value.length; i++) {
    	     if (isDigit(cuenta.value.charAt(i)))
    			s = s + cuenta.value.charAt(i);
    	  }
		  
		  cuenta.value=s;
		  cuenta.select();		  
	  }
	  
	  document.getElementById("cuenta").onblur=function() {
		  idgrem = document.getElementById("idgrem").value; 
		  
    	  cuenta = document.getElementById("cuenta");
		  
		  if (cuenta.value.length==0) return;
    	  
    	  s = "";
    	  for(i=0; i < cuenta.value.length; i++) {
    	     if (isDigit(cuenta.value.charAt(i)))
    			s = s + cuenta.value.charAt(i);
    	  }
		  
		  if (s.length!=lonCuenta) {
			 alert("¡La cuenta debe tener '"+lonCuenta+"' dígitos numéricos!");
			 cuenta.value="";
			 cuenta.select();
			 cuenta.focus();
			 return;
		  }
			  
		  
		  fmto="";
		  fmtoPos=0;
		  for (i=0; i < niveles.length; i++) {
			 if (fmto.length!=0) fmto = fmto+sepCuenta;
			 
			 fmto = fmto + s.substr(fmtoPos, niveles[i]);
			 
			 //console.log(fmtoPos+" "+niveles[i]);
			 
			 fmtoPos = fmtoPos + niveles[i];
		  }
		  
		  cuenta.value=fmto;		  
		  
	  $.ajax({
         url: "<?=$this->request->webroot?>AsientosContables/buscaCuenta/"+idgrem+"/"+cuenta.value,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
		    document.getElementById("descta").value=data.descripcion;
			document.getElementById("glosadet").focus();
			document.getElementById("idcuco").value = data.idcuco;
	     }
         else {		 
		    alert("Cuenta: '"+cuenta.value+"' no encontrada!");
			cuenta.value="";
			document.getElementById("descta").value="";
		}
      }
     });
	  }	
	  
	 document.getElementById("debcmp").onblur = function() {
		if (this.value=="") this.value="0";
		
		if (!isInteger(this.value)) {
		   alert("¡Valor incorrecto '"+this.value+"'!");
		   
		   this.value="0";
		}
		
		if (this.value*1.0 > 0)
		   document.getElementById("habcmp").value="0";
	 }
	 
	 document.getElementById("habcmp").onblur = function() {
	   
		if (this.value=="") this.value="0";
		
		if (!isInteger(this.value)) {
		   alert("¡Valor incorrecto '"+this.value+"'!");
		   
		   this.value="0";
		}
		
		if (this.value*1.0 > 0)
		   document.getElementById("debcmp").value="0";
	 }
	 
	 function extraVal() {
		debcmp=document.getElementById("debcmp").value;
		habcmp=document.getElementById("habcmp").value;
		
		if (debcmp*1.0==0 && habcmp*1.0==0) {
		   alert("¡Debe ingresar una cantidad mayor a cero en el Debe o en el Haber!");
		   
		   return false;
		}
		
		return true;
	 }
	 
	  document.getElementById("bCuentas").onclick=function() {
		  idgrem = document.getElementById("idgrem").value; 
		  sTexto = document.getElementById("sTexto").value;
		  
		  //if (sTexto=="") {
		//	 alert("¡Debe ingresar un patrón de búsqueda!");
		//	 return;
		//  }
		  
		  
	  $.ajax({
         url: "<?=$this->request->webroot?>AsientosContables/busqCuentas/"+idgrem+"/"+sTexto,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
			cuentas = data.cuentas.split("@@");

			listaCuentas.options.length=0;
			
			for (i=0; i < cuentas.length; i++) {
			   e = cuentas[i].split("|");
			   var option = document.createElement("option");
               option.text = e[1];
			   option.value = e[0];
               listaCuentas.add(option);
		    }
	     }
         else {		 
		    alert("¡No se encontraron cuentas!");
			cuenta.value="";
			document.getElementById("descta").value="";
		}
      }
     });
	  }	
	 
	 document.getElementById("listaCuentas").ondblclick=function() {
		modal.style.display = "none";
		document.getElementById("cuenta").value=this.value;
		document.getElementById("cuenta").select();
	 }
	 
	 document.getElementById("sTexto").onkeyup=function() {
		this.value = this.value.toUpperCase();
	 }
	  
<?php echo $extrajs;?>      
</script>

