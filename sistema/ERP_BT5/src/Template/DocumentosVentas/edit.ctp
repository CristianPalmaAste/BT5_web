<?= $this->Form->create($gre, ["id" => "frm", "method" => "post"]) ?> 

     <div class="widget__content">
	     <h1>Documentos de Ventas</h1><br/>
	     <table style="border:1px solid white;" border="1" cellspacing="1" cellpadding="1">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idempr")?>
		 <input type="hidden" name="idgrem" id="idgrem" value="<?=$idgrem?>"/>
		  <tr><td>
		 <label for="numero" >Documento*</label>
		 </td>
		 <td>
		 <?=$this->Form->select("idtidv", $tipos_doctos_ventas, [ "id" => "idtidv", 'placeholder' => 'Documento', "style" => "color:black;", "required" => true]);?>
		 &nbsp;
         <label for="numero" >Número*</label>
		 &nbsp;
         <?=$this->Form->text("numero", ["size" => 10, "maxlength" => 10, "class"=>"upper", "style"=>"color:black;", "id" => "numero", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 &nbsp;
		 <label for="fechacotizacion" >Fecha*</label>
		 &nbsp;
         <?=$this->Form->text("fechacotizacion", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fechacotizacion", "style" => "color:black;", "required" => true]);?>
		 &nbsp;
		 <label for="num_cotiz" >Nota de Venta</label>
		 &nbsp;
         <?=$this->Form->text("num_cotiz", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "num_cotiz", "style" => "color:black;text-align:right;", "readonly" => true, "value" => $num_cotiz]);?>

		 </td>
		 </tr>
		 
		 <tr><td><label for="rutclie" >Cliente*</label></td>
		 </td>
		 <td>
         <?=$this->Form->text("rutclie", ["size" => 13, "maxlength" => 13, "class" => "stacked-input upper", "id" => "rutclie", "required" => true, "style" => "color:black;"]);?>
		 <?=$this->Form->text("razclie", ["size" => 45, "maxlength" => 45, "class" => "stacked-input upper", "id" => "razclie", "readonly" => true, "style" => "color:black;"]);?>
		 </td>
		 </tr>
         <?=$this->Form->hidden("idclie", ["id" => "idclie"])?>
		 <tr><td valign="middle">
         <label for="descripciondoctoventa" >Descripción Cotizado*</i></label>
		 </td>
		 <td>
         <?=$this->Form->text("descripciondoctoventa", ["size" => 80, "maxlength" => 250, "class" => "stacked-input upper", "id" => "descripciondoctoventa", "style" => "color:black;"]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="idgere" >Gerencia</label></td>
		 <td>
         <?=$this->Form->select("idgere", $gerencias, [ "id" => "idgere", 'placeholder' => 'Gerencia', "style" => "color:black;"]);?>
		 &nbsp; <label>Proyecto</label>
		 &nbsp;
         <?=$this->Form->select("idproy", $proyectos, [ "id" => "idproy", 'placeholder' => 'Proyecto', "style" => "color:black;"]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="idline" >Línea de negocios</i></label></td>
		 <td>
         <?=$this->Form->select("idline", $lineas_negocios, [ "id" => "idline", 'placeholder' => 'Línea de negocios', "style" => "color:black;"]);?>
		 &nbsp;
         <label for="idceco" >Centro de Costo</label>&nbsp;
         <?=$this->Form->select("idceco", $centros_costos, [ "id" => "idceco", 'placeholder' => 'Centro de Costo',"style" => "color:black;"]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="idtare" >Tarea</i></label></td>
		 <td>
         <?=$this->Form->select("idtare", $tareas, [ "id" => "idtare", 'placeholder' => 'Tarea',  "style" => "color:black;"]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="iddove" >Estado</label></td>
		 <td>
         <?=$this->Form->hidden("iddove");?>
		 <?=$this->Form->text("estado", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "estado", "style" => "color:black;", "value" => $estados_ventas[$gre->idesve] , "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td colspan='2' align="center">
		    <!--<table style="border:1px solid white;" class="fixed_headers">-->
			<table style="border:1px solid white;">
			   <thead>
			   <tr><td align="center">Cant.</td>
			       <td align="center">Producto</td>
				   <td align="center">U.Medida</td>
				   <td align="center">P.Unit.</td>
				   <td align="center">Precio</td>
				   <td align="center">%Descto.</td>
				   <td align="center">Mto.Descto.</td>
				   <td align="center">Impuestos</td>
				   <td align="center">Sub.Total</td>
				   
			   </tr>
			   </thead>
			   <tbody>
			   
			   <?php $nRow=0;?>
			   <?php foreach($detalle as $d):?>
			   <tr><td><input type="text" name="cantidad<?=$nRow?>" size="10" maxlength="10" value="<?=$d["cantidad"]?>" id="cantidad<?=$nRow?>" style="color:black;text-align:right" onblur="ob_cantidad(<?=$nRow?>);"/></td>
			   
			       <td><select name="idprod<?=$nRow?>" id="idprod<?=$nRow?>" style="color:black;" onchange="oc_idprod(<?=$nRow?>);">
					   <?php foreach($productos as $key => $value):?>
					   <?php if ($key==$d["idprod"]) 
						        $sSelected=" SELECTED"; 
							 else 
								$sSelected="";
					   ?>
					   <option value="<?=$key?>"<?=$sSelected?>><?=$value?></option>
					   <?php endforeach;?>
				       </select>
				   </td>
				   
				   <td><?=$this->Form->text("idunmp".$nRow, ["size" => 7, "class" => "stacked-input upper", "id" => "idunmp".$nRow, "style" => "color:black;", "readonly" => true, "value" => $d["idunmp"]]);?></td>
				   <td><?=$this->Form->text("valorunitario".$nRow,       ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "valorunitario".$nRow, "style" => "color:black;text-align:right;", "readonly" => true, "value" => $d["preciounitario"]]);?></td>
				   <td><?=$this->Form->text("precio".$nRow,              ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "precio".$nRow, "style" => "color:black;text-align:right;", "readonly" => true, "value" => $d["precio"]]);?></td>
				   <td><input type="text" name="porcentajedescuento<?=$nRow?>" value="<?=$d["porcentajedescuento"]?>" size="10" maxlength="10" id="porcentajedescuento<?=$nRow?>" style="color:black;text-align:right" onblur="ob_porcentajedescuento(<?=$nRow?>);"/></td>
				   <td><input type="text" name="montodescuento<?=$nRow?>"      value="<?=$d["montodescuento"]?>" size="10" maxlength="10" id="montodescuento<?=$nRow?>" style="color:black;text-align:right" onblur="ob_montodescuento(<?=$nRow?>);"/></td>
				   <td><?=$this->Form->text("impuestos".$nRow,           ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "impuestos".$nRow, "style" => "color:black;text-align:right;", "value" => $d["impuestos"]]);?></td>
				   <td><?=$this->Form->text("totallinea".$nRow,            ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "totallinea".$nRow, "style" => "color:black;text-align:right;", "value" => $d["totallinea"]]);?></td>
				   
			   </tr>
			   <?php $nRow++;?>
			   <?php endforeach;?>
			   
			   <?php while($nRow <9):?>
			   <tr><td><input type="text" name="cantidad<?=$nRow?>" size="10" maxlength="10" id="cantidad<?=$nRow?>" style="color:black;text-align:right" onblur="ob_cantidad(<?=$nRow?>);"/></td>
			   
			       <td><select name="idprod<?=$nRow?>" id="idprod<?=$nRow?>" style="color:black;" onchange="oc_idprod(<?=$nRow?>);">
					   <?php foreach($productos as $key => $value):?>
					   <option value="<?=$key?>"><?=$value?></option>
					   <?php endforeach;?>
				       </select>
				   </td>
				   
				   <td><?=$this->Form->text("idunmp".$nRow, ["size" => 7, "class" => "stacked-input upper", "id" => "idunmp".$nRow, "style" => "color:black;", "readonly" => true]);?></td>
				   <td><?=$this->Form->text("valorunitario".$nRow,       ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "valorunitario".$nRow, "style" => "color:black;text-align:right;", "readonly" => true]);?></td>
				   <td><?=$this->Form->text("precio".$nRow,              ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "precio".$nRow, "style" => "color:black;text-align:right;", "readonly" => true]);?></td>
				   <td><input type="text" name="porcentajedescuento<?=$nRow?>" size="10" maxlength="10" id="porcentajedescuento<?=$nRow?>" style="color:black;text-align:right" onblur="ob_porcentajedescuento(<?=$nRow?>);"/></td>
				   <td><input type="text" name="montodescuento<?=$nRow?>"      size="10" maxlength="10" id="montodescuento<?=$nRow?>" style="color:black;text-align:right" onblur="ob_montodescuento(<?=$nRow?>);"/></td>
				   <td><?=$this->Form->text("impuestos".$nRow,           ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "impuestos".$nRow, "style" => "color:black;text-align:right;"]);?></td>
				   <td><?=$this->Form->text("totallinea".$nRow,            ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "totallinea".$nRow, "style" => "color:black;text-align:right;"]);?></td>
				   
			   </tr>
			   <?php $nRow++;?>
			   <?php endwhile;?>
			  </tbody> 
			</table>
			
		 <input type="hidden" id="nRow" value="<?=$nRow?>"/>
		 
		 </td></tr>
		 <tr><td>
         <label for="totallinea" >Neto</label></td>
		 <td>
         <?=$this->Form->text("totallinea", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "totallinea", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="porcentajedescuento" >%Descto.</label></td>
		 <td>
         <?=$this->Form->text("porcentajedescuento", ["size" => 10, "maxlength" => 7, "class" => "stacked-input upper", "id" => "porcentajedescuento", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="montodescuento" >Mto.Descto</label></td>
		 <td>
         <?=$this->Form->text("montodescuento", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "montodescuento", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="impuestos" >Valor Imptos.</i></label></td>
		 <td>
         <?=$this->Form->text("impuestos", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "impuestos", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="total" >Total</i></label></td>
		 <td>
         <?=$this->Form->text("total", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "total", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
         <tr><td colspan='2' align='right'>
<?= $this->Form->button(__('Guardar'), ["style" => "color:black;"]) ?>

         </td>
		 </tr>
         </table>
<?= $this->Form->end() ?>		
<div class="btn-group block">
<a href="<?=$this->request->webroot?>DocumentosVentas/index" class="btn dark inverse">Volver</a>
</div> 
</div>



<!--
<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>DocumentosVentas/index" class="btn dark inverse">Volver</a>
</div>
</div>
-->
<?=$this->Html->script('valrut.js');?>
<?=$this->Html->script('valdate.js');?>

<script language="javascript">
//$("#nombre").focus();
   document.getElementById("fechacotizacion").onblur=function() {
	  //alert(this.value);
	  
	  if (!valid_date(this))
		 this.value="";
   }
   
   document.getElementById("rutclie").onblur=function() {
	  idgrem = document.getElementById("idgrem"); 
	  rutclie = document.getElementById("rutclie");
	  razclie = document.getElementById("razclie");
	  
	  rut = rutclie.value.toUpperCase();
	  
	  dv = rut.substr(rut.length-1);
	  
	  rut = clean_no(rut.substr(0, rut.length-1));
	  
      if (rut.length==0) {
		 rutclie.value="";
		 return;
	  }
	  
	  if (!check_rut(rut, dv)) {
		 rutclie.value="";
		 return;
	  }
	  
	  //alert(idgrem.value+"/"+rut+"/"+dv);
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>CotizacionesVentas/chkRutclie/"+idgrem.value+"/"+rut+"/"+dv,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
			razclie.value = data.razclie; 
			document.getElementById("idclie").value = data.idclie;
			document.getElementById("descripciondoctoventa").focus();
	     }
         else {		 
			rutclie.value="";
			razclie.value="";
		 }
      }
     });
   }
   
   function actLinea(n) {
	  cantidad            = document.getElementById("cantidad"+n           );
	  valorunitario       = document.getElementById("valorunitario"+n      );
	  precio              = document.getElementById("precio"+n             );
	  porcentajedescuento = document.getElementById("porcentajedescuento"+n);
	  montodescuento      = document.getElementById("montodescuento"+n     );
	  impuestos           = document.getElementById("impuestos"+n          );
	  totallinea            = document.getElementById("totallinea"+n           );

      if (cantidad.value!="" && valorunitario.value!="") {
		 precio.value = Math.round(cantidad.value*valorunitario.value, 0);

         if (porcentajedescuento.value=="")
            porcentajedescuento.value=0;
		
         //montodescuento.value = Math.round(precio.value*porcentajedescuento.value/100, 0);		
		 
		 if (impuestos.value=="") impuestos.value=0;
		 
		 totallinea.value = Math.round(precio.value - montodescuento.value);
		 
		 Stotallinea            = 0;
		 Sporcentajedescuento = 0;
		 Smontodescuento      = 0;
		 Simpuestos      = 0;
		 Stotal               = 0; 
		 
		 nRow = document.getElementById("nRow").value;
		 
		 for (i=0; i < nRow; i++) {
			n = i;
		    cantidad            = document.getElementById("cantidad"+n           );
	        valorunitario       = document.getElementById("valorunitario"+n      );
	        precio              = document.getElementById("precio"+n             );
	        porcentajedescuento = document.getElementById("porcentajedescuento"+n);
	        montodescuento      = document.getElementById("montodescuento"+n     );
	        impuestos           = document.getElementById("impuestos"+n          );
	        totallinea            = document.getElementById("totallinea"+n           );
			
			if (cantidad.value!="" && valorunitario.value!="") {
			   Stotallinea = Stotallinea + 1.0*precio.value;
			   
               Smontodescuento = Smontodescuento + 1.0*montodescuento.value;			
			   
			   //Sporcentajedescuento = Sporcentajedescuento + 1.0*porcentajedescuento.value;

               Stotal = Stotal + 1.0*totallinea.value;			   
				
			}
			
		 }
		 
		 document.getElementById("totallinea"           ).value = 1.0*Stotallinea;		 
		 document.getElementById("porcentajedescuento").value = 1.0*Sporcentajedescuento;
		 document.getElementById("montodescuento"     ).value = 1.0*Smontodescuento;     
		 document.getElementById("impuestos"     ).value = 1.0*Simpuestos;     
		 document.getElementById("total"              ).value = 1.0*Stotal;               
      }		  
   }
   
   function ob_cantidad(n) {
	  v = document.getElementById("cantidad"+n);
	  
	  if (!isNumber(v.value))
		 v.value="";
	 
	  if (v.value=="") {
		 return;
	  }
	 
	  actLinea(n);
   }
   
   function oc_idprod(n) {
	  idprod = document.getElementById("idprod"+n);

      if (idprod.value=="")
         return;		  
	  //alert(idgrem.value+"/"+rut+"/"+dv);
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>CotizacionesVentas/chkIdprod/"+idprod.value,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
			//alert("A pasra valores"); 
			cantidad = document.getElementById("cantidad" + n).value;
			
			if (cantidad=="") cantidad=0;
			
			document.getElementById("valorunitario"+n).value=data.valorunitario; 
			document.getElementById("idunmp"+n).value=data.idunmp; 
			document.getElementById("precio"+n).value=data.valorunitario*cantidad; 
			
			actLinea(n);
	     }
         else {		 
			document.getElementById("valorunitario"+n).value=""; 
			document.getElementById("idunmp"+n).value=""; 		 }
      }
     });
   }
   
   function ob_porcentajedescuento(n) {
	  v      = document.getElementById("porcentajedescuento"+n);
	  monto  = document.getElementById("montodescuento"+n);
	  precio = document.getElementById("precio"+n);
	  
	  if (!isNumber(v.value))
		 v.value="";
	 
	  if (v.value > 100) v.value=100;
	  
	  if (precio.value > 0)
	     monto.value = Math.round(1.0*precio.value*v.value/100, 2);
	  else {
		 porc.value=0;
		 monto.value=0;
	  }
	  
	  actLinea(n);
   }
   
   function ob_montodescuento(n) {
	  v      = document.getElementById("montodescuento"+n);
	  precio = document.getElementById("precio"+n);
	  porc   = document.getElementById("porcentajedescuento"+n);
	  
	  if (!isNumber(v.value))
		 v.value="";
	 
	  if (v.value=="") {
		 return;
	  }
	  
	  if (v.value*1.0 > precio.value*1.0)
		 v.value=0;
	 
	  //alert(precio.value+" "+v.value);
	  
	  if (precio.value > 0)
	     porc.value = Math.round(100.0*v.value/precio.value*1.0, 2);
	  else {
		 porc.value=0;
		 v.value   =0;
	  }
	 
	  actLinea(n);
   }
   
   document.getElementById("frm").onsubmit=function() {
	  total = document.getElementById("total");
	  
	  if (total.value*1.0==0) {
		 alert("¡No se puede crear documento con total cero!");
		 return false;
	  }
	  
	  return true;
   }
</script>
