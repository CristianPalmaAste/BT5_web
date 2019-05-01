<?php echo $this->Html->css('scroll'); ?>

<?= $this->Form->create($gre, ["id" => "frm", "method" => "post"]) ?> 

     <div class="widget__content">
	     <h1>Ventas</h1><br/>
	     <table style="border:1px solid white;" border="1" cellspacing="1" cellpadding="1">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idempr", ["id" => "idempr"])?>
		 <input type="hidden" name="idgrem" id="idgrem" value="<?=$idgrem?>"/>
		 <tr><td>
         <label for="tidv" >Documento*</label></td>
		 <td>
		 <?=$this->Form->select("idtidv", $tipos_doctos_ventas, [ "id" => "idtidv", 'placeholder' => 'Documento',"style" => "color:black;", "required" => true]);?>
		 &nbsp;
		 <label for="numero" >Número*</label>
		 &nbsp;
         <?=$this->Form->text("numero", ["size" => 10, "maxlength" => 10, "class"=>"upper", "style"=>"color:black;", "id" => "numero", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 &nbsp;
		 <label for="fechaventa" >Fecha*</label>
		 &nbsp;
         <?=$this->Form->text("fechaventa", ["size" => 10, "maxlength" => 10, "class" => "stacked-input datepicker", "placeholder" => "dd-mm-aaaa", "id" => "fechaventa", "style" => "color:black;", "required" => true, "value" => $this->Time->format($gre->fechaventa,'d/MM/Y')]);?>
		 
		  &nbsp;
		 <label for="nrocotiz" >Nota de Venta</label>
		 &nbsp;
         <?=$this->Form->text("nronota", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "nronota", "style" => "color:black;", "readonly" => true]);?>

		 </td>
		 </tr>
		 <tr><td><label for="rutclie" >Cliente*</label></td>
		 </td>
		 <td>
         <?=$this->Form->text("rutclie", ["size" => 13, "maxlength" => 13, "class" => "stacked-input upper", "id" => "rutclie", "required" => true, "style" => "color:black;"]);?>
		 <?=$this->Form->select("razclie", $clientes, ["class" => "stacked-input", "id" => "razclie", "style" => "color:black;"]);?>
		 </td>
		 </tr>
         <?=$this->Form->hidden("idclie", ["id" => "idclie"])?>
		 <tr><td valign="middle">
         <label for="descripcionventa" >Descripción Venta*</i></label>
		 </td>
		 <td>
         <?=$this->Form->text("descripcionventa", ["size" => 80, "maxlength" => 250, "class" => "stacked-input upper", "id" => "descripcionventa", "style" => "color:black;"]);?>
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
         <label for="idesve" >Estado</label>
		 </td><td>
		 <?=$this->Form->select("idesve", $estados_ventas, ["class" => "stacked-input upper", "id" => "idesve", "style" => "color:black;", "required" => true]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="idusuavendedor" >Vendedor</i></label></td>
		 <td>
         <?=$this->Form->select("idusuavendedor", $vendedores, [ "id" => "idusuavendedor", 'placeholder' => 'Vendedor',  "style" => "color:black;", "required" => true]);?>
		 </td>
		 </tr>
		  <tr><td>
         <label for="idbode" >Bodega</i></label></td>
		 <td>
         <?=$this->Form->select("idbode", $bodegas, [ "id" => "idbode", 'placeholder' => 'Bodega',  "style" => "color:black;"]);?>
		 <?=$this->Form->hidden("idbode0", [ "id" => "idbode0"]);?>
		 </td>
		 </tr>
		 <tr>
		 <td>
         <label for="porcentajedescuento0" >%Descto.</label></td>
		 <td>
         <?=$this->Form->text("porcentajedescuento0", ["size" => 10, "maxlength" => 7, "class" => "stacked-input upper", "id" => "porcentajedescuento0", "style" => "color:black;text-align:right;"]);?>
		 </td>
		 </tr>
		 <tr><td colspan='2' align="center">
		    		
			<?=$grilla?>
			
		 <input type="hidden" id="nRow" value="<?=$nRow?>"/>
		 
		 </td></tr>
		 <tr><td>
         <label for="totallinea" >Sub.Total</label></td>
		 <td>
         <?=$this->Form->text("totallinea0", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "totallinea0", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <!--
		 <tr><td>
         <label for="montodescuento0" >Mto.Descto</label></td>
		 <td>
         <?=$this->Form->text("montodescuento0", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "montodescuento0", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="montodescuento1" >Neto</label></td>
		 <td>
         <?=$this->Form->text("neto0", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "neto0", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 -->
		 <tr><td>
         <label for="montodescuento1" >Exento</label></td>
		 <td>
         <?=$this->Form->text("exento0", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "exento0", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="montodescuento1" >Afecto</label></td>
		 <td>
         <?=$this->Form->text("afecto0", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "afecto0", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="impuestosobligats" >Impto.Obligat.</i></label></td>
		 <td>
         <?=$this->Form->text("impuestosobligats0", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "impuestosobligats0", "style" => "color:black;text-align:right;", "readonly" => true, "value" => $gre->impuestosobligats]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="impuestosespecifs" >Impto.Específico</i></label></td>
		 <td>
         <?=$this->Form->text("impuestosespecifs0", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "impuestosespecifs0", "style" => "color:black;text-align:right;", "readonly" => true, "value" => $gre->impuestosobligats]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="total" >Total</i></label></td>
		 <td>
         <?=$this->Form->text("total", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "total", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
         <tr><td colspan='2' align='center'>
<?= $this->Form->button(__('Guardar'), ["style" => "color:black;"]) ?>

         </td>
		 </tr>
         </table>
		 <input type="hidden" id="currentRow"/>
		 <input type="hidden" id="allRows" name="allRows"/>
		 
		 <input type="hidden" id="lProductos" name="lProductos" value="<?=$lProductos?>"/>
		 
<?= $this->Form->end() ?>		
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Ventas/index" class="btn dark inverse">Volver</a>
</div> 
</div>



<!--
<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Ventas/index" class="btn dark inverse">Volver</a>
</div>
</div>
-->
<?=$this->Html->script('valrut.js');?>
<?=$this->Html->script('valdate.js');?>

<script language="javascript">
//$("#nombre").focus();

   updateTotals();
   
   rutclie = document.getElementById("rutclie");
   
   if (rutclie!=null && rutclie.value!="") {
	  
   }
   
   idclie=document.getElementById("idclie").value;  
   l = document.getElementById("razclie");
			
   for (i=0; i < l.length; i++) {
      e = l.options[i].value.split("|");
      
      if (e[1]==idclie) {
   	     l.selectedIndex=i;
   	     break;
      }
   }
   
   lProductos = document.getElementById("lProductos").value;
   
   if (lProductos!="") {
	  l = document.getElementById("desproducto");
	  
	  for (i=0; i < l.options.length; i++)
		 l.options[i] = null;  
	 
	  option = document.createElement("option");
      option.text = "Seleccione producto";
	  option.value= "";
      l.add(option);		 
	 
	  lista = lProductos.split("@@@");
	  
	  for (i=0; i < lista.length; i++) {
		 e = lista[i].split("&&&");
		 
		 option = document.createElement("option");
         option.text = e[1];
		 option.value= e[0];
         l.add(option);		 
	  }
	  
	  l.selectedIndex=0;
   }   
  
   document.getElementById("fechaventa").onblur=function() {
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
		 alert("¡Rut inválido!");
		 rutclie.value="";
		 razclie.value="";
		 return;
	  }
	  
	  rutclie.value=disp_no(rut)+"-"+dv;
	  
	  //alert(idgrem.value+"/"+rut+"/"+dv);
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>CotizacionesVentas/chkRutclie/"+idgrem.value+"/"+rut+"/"+dv,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
			//razclie.value = data.rutclie; 
			document.getElementById("idclie").value = data.idclie;
			
			l = document.getElementById("razclie");
			
			for (i=0; i < l.length; i++) {
			   e = l.options[i].value.split("|");
			   
			   if (e[1]==data.idclie) {
				  l.selectedIndex=i;
				  break;
			   }
			}
			   
			document.getElementById("descripcionventa").focus();
			
			l = document.getElementById("razclie");
			
	     }
         else {		 
			rutclie.value="";
			razclie.value="";
		 }
      }
     });
   }
   
   document.getElementById("razclie").onchange=function() {
	  //alert(this.value);
	  
	  e = this.value.split("|");
	  
      document.getElementById("idclie").value = e[1];
	  document.getElementById("rutclie").value = e[0];
	  
	  document.getElementById("descripcionventa").focus();
   }
   
   document.getElementById("idbode").onchange=function() {
	  idempr  = document.getElementById("idempr").value; 
      idbode  = this.value;
	  idbode0 = document.getElementById("idbode0").value; 
	  
	  
	  //idempr = 1;
	  //idbode = 1;
	  
	  if (this.idbode=="") {
		 return;
	  }
	  
	  if (idbode0!="" && idbode!=idbode0) {
		 //Borrado de detalle
		 tbl = document.getElementById("mitabla");
		 for (i=tbl.rows.length - 1; i > 1; i--) 
			tbl.deleteRow(i);
		 updateTotals();
	  }
	  
	  l = document.getElementById("desproducto");
	  
	  for (i=0; i < l.options.length; i++)
		 l.options[i] = null;  
	 
	  l.options.length=0;
	 
	  $.ajax({
         url: "<?=$this->request->webroot?>CotizacionesVentas/getProducts/"+idempr+"/"+idbode,
         success: function( result ) {
	     data = JSON.parse(result);
		 
		 var option = document.createElement("option");
         option.text = "Seleccione producto";
		 option.value= "";
         l.add(option);
		 
		 for (i=0; i < data.length; i++) {
            var option = document.createElement("option");
            option.text = data[i].desprod;
			option.value= data[i].producto+"#"+data[i].id;
            l.add(option);
		 }
		 
		 l.selectedIndex=0;
      }
     });
   }
   
   document.getElementById("idbode").onfocus=function() {
	  document.getElementById("idbode0").value=this.value;
   }

   
//   document.getElementById("diasvalidez").onblur=function() {
//	  if (!isInteger(this.value))
//		 this.value="";
//   }
   
   document.getElementById("porcentajedescuento0").onblur=function() {
	  
	  if (!isNumber(this.value))
		 this.value="0";
	 
      if (this.value*1.0 >= 100)
		 this.value="0";
	 
	  actLinea();
   }
   
   function getO(sNombre) {
	  return document.getElementById(sNombre);
   }
   
   function actLinea() {
	  if (document.getElementById("producto")==null) return;
	  
	  cantidad            = document.getElementById("cantidad"           );
	  preciounitario      = document.getElementById("preciounitario"      );	  
	  desc_global         = 1 - (document.getElementById("porcentajedescuento0").value*1.0)/100.0;
	  precio              = Math.round(cantidad.value*preciounitario.value*1.0*desc_global, 0);
	  
	  if (cantidad==null) return;
	  
	  porcentajedescuento1 = document.getElementById("porcentajedescuento1");
	  porcentajedescuento2 = document.getElementById("porcentajedescuento2");
	  montodescuento1      = document.getElementById("montodescuento1"     );
	  montodescuento2      = document.getElementById("montodescuento2"     );
	  afecto               = document.getElementById("afecto"     );
	  exento               = document.getElementById("exento"     );
	  impuestosobligats    = document.getElementById("impuestosobligats"          );
	  impuestosespecifs    = document.getElementById("impuestosespecifs"          );
	  totallinea           = document.getElementById("totallinea"           );
	  estaexento           = document.getElementById("estaexento"           );
	  
	  if (porcentajedescuento1.value=="") porcentajedescuento1.value=0;
	  
	  if (porcentajedescuento2.value=="") porcentajedescuento2.value=0;
	  	  
	  montodescuento1.value = Math.round(1.0*precio*(1.0*porcentajedescuento1.value/100.0), 0);
	  
	  p = 1.0*precio - 1.0*montodescuento1.value;
	  
	  montodescuento2.value = Math.round(1.0*p*(1.0*porcentajedescuento2.value/100.0), 0);
	  
	  if (estaexento.value=="S") {
	     afecto.value=0;
	  
	     exento.value=Math.round(precio*1.0-montodescuento1.value*1.0-montodescuento2.value, 0);
		 
		 exento.value=Math.round(exento.value*desc_global, 0)
	  }
	  else {
		 //alert(precio+" "+montodescuento1.value+" "+montodescuento2.value);
		 afecto.value=Math.round(precio*1.0-montodescuento1.value*1.0-montodescuento2.value, 0);
		 
		 //alert(afecto.value);
		 
		 afecto.value=Math.round(afecto.value*desc_global, 0)
		 
		 //alert(afecto.value);
	  
	     exento.value=0;
	  }
	  
	  ila  = document.getElementById("ila").value;
	  iaba = document.getElementById("iaba").value;
	  iva  = document.getElementById("iva").value;
	  
	  //alert(ila+" "+iaba+" "+iva);
	  
	  impuestosobligats.value = Math.round(1.0*afecto.value*iva/100, 0);
	  
	  impuestosespecifs.value = Math.round(1.0*afecto.value*(ila*1.0+iaba*1.0)/100, 0);
	  
	  totallinea.value = 1.0*afecto.value + 1.0*exento.value + 1.0*impuestosobligats.value + 1.0*impuestosespecifs.value;
	  
	  nRow = document.getElementById("nRow").value;  
 
   }
   
   function ob_cantidad() {
	  v = document.getElementById("cantidad");
	  
	  stock = document.getElementById("stock").value;
	  
	  if (!isNumber(v.value))
		 v.value="";
	 
	  if (v.value=="") {
		 return;
	  }
	  
	  //alert(v.value+" - "+stock);
	  
	  if (v.value*1.0 > stock*1.0) v.value=stock*1.0;
	 
	  actLinea();
   }
   
   function ob_producto() {
	  idprod = document.getElementById("producto");
	  idempr = document.getElementById("idempr").value;
	  idbode = document.getElementById("idbode").value;
	  
	  //alert(idbode);
	  
      if (idprod.value=="" || idprod.value.length!=8) {
		 document.getElementById("idprod").value="";
         return;		  
	  }
	 
	  if (idbode=="") {
		 alert("¡Debe ingresar la bodega!");
		 document.getElementById("idbode").focus();
		 return;
	  }
	  
	 
      //Chequeamos que el producto no este repetido
      nVeces=0;
	  if (document.getElementById("currentRow")==null)
	     currentRow = 0;
      else
         currentRow = document.getElementById("currentRow").value;
	  
	  tabla = document.getElementById("mitabla");
	  
	  for (i=2; i < tabla.rows.length; i++) {
         data = document.getElementById("data"+i).value;

         e    = data.split("|");
		 
		 if (idprod.value==e[0] && currentRow!=i) nVeces++;

         //alert(e[0]);		 
	  }
	  
	  if (nVeces > 0) {
		 //Ya ha sido ingresado
		 alert("Producto: '"+idprod.value+"' ya ha sido ingresado!");
		 idprod.value="";
		 return;
	  }
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>CotizacionesVentas/chkIdprod/"+idempr+"/"+idprod.value+"/"+idbode,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
			//alert("A pasar valores"); 
			cantidad = document.getElementById("cantidad").value;
			
			if (cantidad=="") cantidad=0;
			
			l = document.getElementById("desproducto"); 
			
			for(i=0; i < l.options.length; i++) {
			   e = l.options[i].value.split("#");
			   
			   if (e[1]==data.id) {
				  l.selectedIndex=i;
				  break;
			   }
			}
			
			document.getElementById("preciounitario").value=data.preciounitario; 
			document.getElementById("idunmp").value=data.idunmp; 
			//document.getElementById("precio").value=data.preciounitario*cantidad; 
			document.getElementById("idprod").value=data.id; 
			document.getElementById("estaexento").value=data.estaexento; 
			
			document.getElementById("iva").value =data.iva;
			document.getElementById("ila").value =data.ila;
			document.getElementById("iaba").value=data.iaba;
			document.getElementById("maxdescto").value=data.maxdescto;
			
			document.getElementById("stock").value=data.stock;
			//document.getElementById("cantidad").value=data.maxdescto;
			
			
			document.getElementById("cantidad").focus();
			document.getElementById("cantidad").select();
			
			pdescto = document.getElementById("porcentajedescuento");
			
			if (pdescto==null || pdescto.value=="")
			   pdescto.value = data.maxdescto;
			
			
			//actLinea(n);
	     }
         else {		 
		    alert("Producto: '"+idprod.value+"' no ha sido encontrado!");
			
		    document.getElementById("desproducto").selectedIndex=0; 
			document.getElementById("preciounitario").value=""; 
			document.getElementById("idunmp").value=""; 		 
			//document.getElementById("precio").value=""; 
			document.getElementById("idprod").value=""; 
			document.getElementById("iva").value =0;
			document.getElementById("ila").value =0;
			document.getElementById("iaba").value=0;
			
			
			
		}
      }
     });
   }
   
   document.getElementById("desproducto").onchange=function() {
	  //alert(this.value);
	  
	  if (this.value=="") return;
	  
	  e = this.value.split("#");
	  
      document.getElementById("idprod").value = e[1];
	  document.getElementById("producto").value = e[0];
	  
	  document.getElementById("producto").focus();
   }
      
   function ob_porcentajedescuento1() {
	  v      = document.getElementById("porcentajedescuento1");
	  cantidad            = document.getElementById("cantidad"           );
	  preciounitario      = document.getElementById("preciounitario"      );
	  precio              = Math.round(cantidad.value*preciounitario.value*1.0, 2);
	  maxdescto           = document.getElementById("maxdescto").value;
	  
	  //alert(maxdescto);
	  
	  if (!isNumber(v.value))
		 v.value="";
	 
	  if (v.value*1.0 > maxdescto*1.0)
		 v.value = maxdescto;
	 	 
	  document.getElementById("montodescuento1").value = Math.round(1.0*precio*v.value/100.0, 2);
	 
	  actLinea();
   }
   
   function ob_porcentajedescuento2() {
	  descto1= document.getElementById("porcentajedescuento1");
	  monto1 = document.getElementById("montodescuento2");
	  
	  v              = document.getElementById("porcentajedescuento2");
	  cantidad       = document.getElementById("cantidad"           );
	  preciounitario = document.getElementById("preciounitario"      );
	  precio         = Math.round(cantidad.value*preciounitario.value*1.0, 0);
	  
	  if (!isNumber(v.value))
		 v.value="";
	 
	  descto = descto1.value*1.0+v.value*1;
	  
	  if (1.0*descto >= 100.0) {
		 alert("¡Descuento no puede superar al 100%!");
		 v.value=0;
		 //return;
	  }
	  
	  monto2 = (1.0*precio.value-monto1*1.0)*(1-v.value/100.00);
	  	 
	  document.getElementById("montodescuento2").value = Math.round(1.0*monto2, 0);
	 
	  actLinea();
   }
 
   function ob_montodescuento2() {
	  v      = document.getElementById("montodescuento2");
	  cantidad            = document.getElementById("cantidad"           );
	  preciounitario      = document.getElementById("preciounitario"      );
	  precio              = Math.round(cantidad.value*preciounitario.value*1.0, 2);
	  
	  if (!isNumber(v.value))
		 v.value="";
	 
	  document.getElementById("porcentajedescuento2").value = Math.round(100*v.value/(1.0*precio), 2);
	  
	  porc1 = document.getElementById("porcentajedescuento1").value;
	  porc2 = document.getElementById("porcentajedescuento2");
	  
	  if (1.0*porc1+1.0*porc2.value >= 100.0) {
		 alert("¡Descuento no puede superar al 100%!");
		 porc2.value=0;
		 document.getElementById("montodescuento2").value = 0;
		 
	  }
	 
	  actLinea();
   }
   
   document.getElementById("frm").onsubmit=function() {
	  tbl = document.getElementById("mitabla");
	  
	  total = document.getElementById("total").value;
	  
	  if (total*1.0 <=0) {
		 alert("¡Debe ingresar algún producto en el documento!");
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
        
<?php echo $extrajs;?>      
</script>

