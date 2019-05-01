<?php echo $this->Html->css('scroll'); ?>

<?= $this->Form->create($gre, ["id" => "frm", "method" => "post"]) ?> 

     <div class="widget__content">
	     <h1>Cotizaciones Ventas</h1><br/>
	     <table style="border:1px solid white;" border="1" cellspacing="1" cellpadding="1">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idempr", ["id" => "idempr"])?>
		 <input type="hidden" name="idgrem" id="idgrem" value="<?=$idgrem?>"/>
		 <tr><td>
         <label for="numero" >Número*</label></td>
		 <td>
         <?=$this->Form->text("numero", ["size" => 10, "maxlength" => 10, "class"=>"upper", "style"=>"color:black;", "id" => "numero", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 &nbsp;
		 <label for="fechacotizacion" >Fecha*</label>
		 &nbsp;
         <?=$this->Form->text("fechacotizacion", ["size" => 10, "maxlength" => 10, "class" => "stacked-input datepicker", "id" => "fechacotizacion", "placeholder" => "dd-mm-aaaa", "style" => "color:black;", "required" => true, "value" => $this->Time->format($gre->fechacotizacion,'d/MM/Y')]);?>		 		 
		 </td>
		 </tr>
		 <tr><td><label for="rutclie" >Cliente*</label></td>
		 </td>
		 <td>
         <?=$this->Form->text("rutclie", ["size" => 13, "maxlength" => 13, "class" => "stacked-input upper", "id" => "rutclie", "required" => true, "style" => "color:black;"]);?>
		 <?=$this->Form->select("razclie", $clientes, ["class" => "stacked-input", "id" => "razclie", "style" => "color:black;"]);?>
		 
		 <!--<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Nuevo</button>-->
		 </td>
		 </tr>
         <?=$this->Form->hidden("idclie", ["id" => "idclie"])?>
		 <tr><td valign="middle">
         <label for="descripcioncotizacion" >Descripción Cotizado*</i></label>
		 </td>
		 <td>
         <?=$this->Form->text("descripcioncotizacion", ["size" => 80, "maxlength" => 250, "class" => "stacked-input upper", "id" => "descripcioncotizacion", "style" => "color:black;"]);?>
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
         <label for="diasvalidez" >Días Validez*</label></td>
		 <td>
         <?=$this->Form->text("diasvalidez", ["size" => 10, "maxlength" => 4, "class" => "stacked-input upper", "id" => "diasvalidez", "style" => "color:black;text-align:right;"]);?>
		 &nbsp;
         <label for="idescv" >Estado</label>
		 &nbsp;
		 <?=$this->Form->select("idescv", $estados_cotizaciones_vtas, ["class" => "stacked-input upper", "id" => "idescv", "style" => "color:black;", "required" => true]);?>
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
         <label for="porcentajedescuento" >%Descto.</label></td>
		 <td>
         <?=$this->Form->text("porcentajedescuento0", ["size" => 10, "maxlength" => 7, "class" => "stacked-input upper", "id" => "porcentajedescuento0", "style" => "color:black;text-align:right;"]);?>
		 </td>
		 </tr>
		 <tr><td colspan='2' align="center">
		    		
			<?php echo $grilla;?>
			
		 <input type="hidden" id="nRow" value="<?=$nRow?>"/>
		 
		 </td></tr>
		 <tr><td>
         <label for="totallinea" >Sub.Total</label></td>
		 <td>
         <?=$this->Form->text("totallinea0", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "totallinea0", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <!--<tr><td>
         <label for="montodescuento" >Mto.Descto</label></td>
		 <td>
         <?=$this->Form->text("montodescuento", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "montodescuento", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 -->
		 <!--
		 <tr><td>
         <label for="montodescuento" >Neto</label></td>
		 <td>
         <?=$this->Form->text("neto", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "neto", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 -->
		 <tr><td>
         <label for="exento0" >Exento</label></td>
		 <td>
         <?=$this->Form->text("exento0", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "exento0", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="afecto0" >Afecto</label></td>
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
		 <input type="hidden" id="currentRow"/>
		 <input type="hidden" id="allRows" name="allRows"/>
		 
		 <input type="hidden" id="lProductos" name="lProductos" value="<?=$lProductos?>"/>
		 
		 
		 
<?= $this->Form->button(__('Guardar'), ["style" => "color:black;"]) ?>

         </td>
		 </tr>
         </table>
<?= $this->Form->end() ?>		
<div class="btn-group block">
<a href="<?=$this->request->webroot?>CotizacionesVentas/index" class="btn dark inverse">Volver</a>
</div> 
</div>

<!-- Modal  del cliente-->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Crear Cliente</h4>
      </div>
      <div class="modal-body">
        <p><table>
		      <tr><td>Tipo</td><td><?=$this->Form->select("idticl", $tipos_clientes, ["empty" => "Seleccione tipo de cliente", "class" => "stacked-input2", "id" => "idticl", 'placeholder' => 'Tipo cliente*', 'style' => 'color:black;']);?></td></tr>
			  <tr><td>Rut</td><td><?=$this->Form->text("identificador1", ["size" => 10, "maxlength" => 11, "class" => "stacked-input2 upper", "id" => "identificador1", "placeholder" => "identificador1", 'placeholder' => 'Rut*', 'style' => 'color:black;']);?>-
			                      <?=$this->Form->text("identificador2", ["size" => 10, "maxlength" => 1, "class" => "stacked-input2 upper", "id" => "identificador2", "placeholder" => "identificador2", 'placeholder' => 'Dv*', 'style' => 'color:black;']);?>
			  </td></tr>
			  <tr><td>Razón Social</td><td><?=$this->Form->text("razonsocial", ["size" => 60, "maxlength" => 60, "class" => "stacked-input2 upper", "id" => "razonsocial", "placeholder" => "razonsocial", 'placeholder' => 'Razón Social', 'style' => 'color:black;']);?></td></tr>
			  <tr><td>Nombre de Fantasía</td><td><?=$this->Form->text("nombrefantasia", ["size" => 60, "maxlength" => 60, "class" => "stacked-input2 upper", "id" => "nombrefantasia", "placeholder" => "nombrefantasia", 'placeholder' => 'Nombre de Fantasía', 'style' => 'color:black;']);?></td></tr>
			  <tr><td>Primer Nombre</td><td><?=$this->Form->text("primernombre", ["size" => 25, "maxlength" => 25, "class" => "stacked-input2 upper", "id" => "primernombre", "placeholder" => "primernombre", 'placeholder' => 'Primer Nombre', 'style' => 'color:black;']);?></td></tr>
			  <tr><td>Segundo Nombre</td><td><?=$this->Form->text("segundonombre", ["size" => 25, "maxlength" => 25, "class" => "stacked-input2 upper", "id" => "segundonombre", "placeholder" => "segundonombre", 'placeholder' => 'Segundo Nombre', 'style' => 'color:black;']);?></td></tr>
			  <tr><td>Apellido Paterno</td><td><?=$this->Form->text("apellidopaterno", ["size" => 30, "maxlength" => 30, "class" => "stacked-input2 upper", "id" => "apellidopaterno", "placeholder" => "apellidopaterno", 'placeholder' => 'Apellido Paterno', 'style' => 'color:black;']);?></td></tr>
			  <tr><td>Apellido Materno</td><td><?=$this->Form->text("apellidomaterno", ["size" => 30, "maxlength" => 30, "class" => "stacked-input2 upper", "id" => "apellidomaterno", "placeholder" => "apellidomaterno", 'placeholder' => 'Apellido Materno', 'style' => 'color:black;']);?></td></tr>
			  <tr><td>País</td><td><?=$this->Form->select("idpais", $paises, ["empty" => "Seleccione país", "class" => "stacked-input2", "id" => "idpais", 'placeholder' => 'País*']);?></td></tr>
		   </table>
		
		</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Grabar</button>
      </div>
    </div>

  </div>
</div>

<?=$this->Html->script('valrut.js');?>
<?=$this->Html->script('valdate.js');?>
<?=$this->Html->script('bootstrap3-typeahead.min.js');?>

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

   actLinea(0);
   
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
			   
			document.getElementById("descripcioncotizacion").focus();
			
			l = document.getElementById("razclie");
			
	     }
         else {		 
			rutclie.value="";
			razclie.value="";
		 }
      }
     });
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
   
   document.getElementById("razclie").onchange=function() {
	  //alert(this.value);
	  
	  e = this.value.split("|");
	  
      document.getElementById("idclie").value = e[1];
	  document.getElementById("rutclie").value = e[0];
	  
	  document.getElementById("descripcioncotizacion").focus();
   }
   
   document.getElementById("diasvalidez").onblur=function() {
	  if (!isInteger(this.value))
		 this.value="";
   }
   
   document.getElementById("porcentajedescuento0").onblur=function() {
	  
	  if (!isNumber(this.value))
		 this.value="0";
	 
      if (this.value*1.0 >= 100)
		 this.value="0";
   }
   
   function getO(sNombre) {
	  return document.getElementById(sNombre);
   }
   
   function actLinea(n) {
	  if (document.getElementById("producto")==null) return;
	  
	  cantidad            = document.getElementById("cantidad"           );
	  preciounitario      = document.getElementById("preciounitario"      );
	  precio              = Math.round(cantidad.value*preciounitario.value*1.0, 0);
	  desc_global         = document.getElementById("porcentajedescuento").value*1.0;
	  
	  if (cantidad==null) return;
	  
	  porcentajedescuento = document.getElementById("porcentajedescuento");
	  montodescuento      = document.getElementById("montodescuento"     );
	  afecto               = document.getElementById("afecto"     );
	  exento               = document.getElementById("exento"     );
	  impuestosobligats    = document.getElementById("impuestosobligats"          );
	  impuestosespecifs    = document.getElementById("impuestosespecifs"          );
	  totallinea           = document.getElementById("totallinea"           );
	  estaexento           = document.getElementById("estaexento"           );
	  
	  if (porcentajedescuento.value=="") porcentajedescuento.value=0;
	  
	  	  	  
	  montodescuento.value = Math.round(1.0*precio*(1.0*porcentajedescuento.value/100.0), 0);
	  
	  p = 1.0*precio - 1.0*montodescuento.value;
	  
	  
	  
	  if (estaexento.value=="S") {
	     afecto.value=0;
	  
	     exento.value=Math.round(precio*1.0-montodescuento.value*1.0, 0);
		 
		 exento.value=Math.round(exento.value*(1.0-desc_global/100.0), 0)
	  }
	  else {
		 afecto.value=Math.round(precio*1.0-montodescuento.value*1.0, 0);
		 afecto.value=Math.round(afecto.value*(1.0-desc_global/100.0), 0)
	  
	     exento.value=0;
	  }
	  
	  ila  = document.getElementById("ila").value;
	  iaba = document.getElementById("iaba").value;
	  iva  = document.getElementById("iva").value;
	  
	  //alert(ila+" "+iaba+" "+iva);
	  
	  impuestosobligats.value = Math.round(1.0*afecto.value*iva/100, 0);
	  
	  impuestosespecifs.value = Math.round(1.0*afecto.value*(ila*1.0+iaba*1.0)/100, 0);
	  
	  totallinea.value = 1.0*afecto.value + 1.0*exento.value + 1.0*impuestosobligats.value + 1.0*impuestosespecifs.value;
	  
	  //nRow = document.getElementById("nRow").value;
		 
      //totallinea        = document.getElementById("totallinea"       );
      ////montodescuento    = document.getElementById("montodescuento"   );
      ////neto              = document.getElementById("neto"             );
      //exento            = document.getElementById("exento"           );
      //afecto            = document.getElementById("afecto"           );
      //impuestosobligats = document.getElementById("impuestosobligats");
      //impuestosespecifs = document.getElementById("impuestosespecifs");
      //total             = document.getElementById("total"            );
	  
	  
	  //totallinea.value        = 0;
	  //montodescuento.value    = 0;
	  //neto.value              = 0;
	  //exento.value            = 0;
	  //afecto.value            = 0;
	  //impuestosobligats.value = 0;
	  //impuestosespecifs.value = 0;
	  //total.value             = 0;
	  	
//for (i=0; i < nRow; i++) 
//   if (document.getElementById("producto"+i)!=null) {
//	 
//	//totallinea.value        = 1.0*totallinea.value        + 1.0*document.getElementById("totallinea"+i).value;
//      //montodescuento.value    = 1.0*montodescuento.value    + 1.0*0;
//      //neto.value              = 1.0*neto.value              + 1.0*document.getElementById("totallinea"+i).value;
//      exento.value            = 1.0*exento.value            + 1.0*document.getElementById("exento"+i).value;
//      afecto.value            = 1.0*afecto.value            + 1.0*document.getElementById("afecto"+i).value;
//	
//	//neto.value              = 1.0*neto.value + 1.0*document.getElementById("exento"+i).value 
//	//                                         + 1.0*document.getElementById("afecto"+i).value;
//											 
//	totallinea.value             = 1.0*totallinea.value + 1.0*document.getElementById("exento"+i).value 
//	                                         + 1.0*document.getElementById("afecto"+i).value;
//   
//      impuestosobligats.value = 1.0*impuestosobligats.value + 1.0*document.getElementById("impuestosobligats"+i).value;
//      impuestosespecifs.value = 1.0*impuestosespecifs.value + 1.0*document.getElementById("impuestosespecifs"+i).value;
//      total.value             = 1.0*total.value             + 1.0*document.getElementById("totallinea"+i).value; 
//
//	     }
	  
 
   }
   
   function ob_cantidad() {
	  v = document.getElementById("cantidad");
	  
	  if (!isNumber(v.value))
		 v.value="";
	 
	  actLinea(0);
   }
   
   function ob_producto() {
	  //alert("ob_producto");
	  
	  idprod = document.getElementById("producto");
	  idempr = document.getElementById("idempr").value;
	  idbode = document.getElementById("idbode").value;
	  
      if (idprod.value=="" || idprod.value.length!=8) {
		 document.getElementById("producto").value=""; 
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
	  
	  //alert(tabla.rows.length-1);
	  
	  for (i=2; i < tabla.rows.length; i++) {
		 //alert(i);
		 
         data = document.getElementById("data"+i).value;
		 
		 //alert(data);

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
			   
			   //alert(e[1]+", "+data.id);
			   
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
			
			document.getElementById("cantidad").focus();
			document.getElementById("cantidad").select();
			
			pdescto = document.getElementById("porcentajedescuento");
			
			if (pdescto==null || pdescto.value=="")
			   pdescto.value = data.maxdescto;
			
			
			//actLinea(n);
	     }
         else {		 
		    alert("Producto: '"+idprod.value+"' no ha sido encontrado!");
			
			document.getElementById("producto").value=""; 
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
   
   function ob_porcentajedescuento() {
	  v      = document.getElementById("porcentajedescuento");
	  cantidad            = document.getElementById("cantidad"           );
	  preciounitario      = document.getElementById("preciounitario"      );
	  precio              = Math.round(cantidad.value*preciounitario.value*1.0, 2);
	  maxdescto           = document.getElementById("maxdescto").value;
	  
	  //alert(maxdescto);
	  
	  if (!isNumber(v.value))
		 v.value="";
	 
	  if (v.value*1.0 > maxdescto*1.0)
		 v.value = maxdescto;
	 	 
	  document.getElementById("montodescuento").value = Math.round(1.0*precio*v.value/100.0, 2);
	 
	  actLinea(0);
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

   
