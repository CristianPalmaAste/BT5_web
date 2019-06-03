<?= $this->Form->create($gre, ["id" => "frm"]) ?>
 
<?php if (count($errors) > 0) {
?>
<div class="row" style="padding-bottom:5px;">
   <div class="col-sm-9">
   <div class="panel panel-danger">
      <div class="panel-heading">Errores</div>

<?php

   foreach($errors as $key => $arr)
      foreach($arr as $k => $v)
          echo "<div class='panel-body'>$v</div>";
?>
      </div>
    <div>
</div>
<?php      }
?>

 
	  <h1>Requisiciones</h1><br/>
         <?=$this->Form->hidden("id", ["id" => "id"])?>
         <?=$this->Form->hidden("idempr", ["id" => "idempr"])?>
		 
	  <table style="border:1px solid white;" border="2" cellspacing="1" cellpadding="1">
        <tr><td><label for='correlativo' >Correlativo*</label></td>
        <td><?=$this->Form->text("correlativo", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "correlativo", 'placeholder' => 'Correlativo*', 'style' => 'color:black;text-align:right', 'readonly' => true]);?></td></tr>
        <tr><td><label for='idtire' >Tipo de Requisición*</label></td><td><?=$this->Form->select("idtire", $tipos_requisiciones, ["class" => "stacked-input", "id" => "idtire", 'placeholder' => 'Tipo de Requisición*', 'style' => 'color:black;']);?></td></tr>

         <tr><td><label for='idusuasolicitareq' >Usuario Solicitante*</label></td><td><?=$this->Form->select("idusuasolicitareq", $usuarios, ["class" => "stacked-input upper", "id" => "idusuasolicitareq", 'placeholder' => 'Usuario Solicitante*', 'style' => 'color:black;']);?></td></tr>
		 <tr><td><label for="idgere" >Gerencia</label></td>
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
<tr><td><label for='idereq' >Estado Requisición*</label></td><td><?=$this->Form->hidden("idereq") ?>
                 <?php echo $estados_requisiciones[$gre->idereq]; ?>
</td></tr>
<tr><td><label for='idereq' >Razón Rechazo</label></td><td><?=$this->Form->text("razonrechazo", ["class" => "stacked-input", "id" => "idereq", 'style' => 'color:black;', 'size' => 65, 'readonly' => true]);?>
</td></tr>

 <tr><td colspan='2' align="center">
		    		
			<?=$grilla?>
			
		 <input type="hidden" id="nRow" value="<?=$nRow?>"/>
		 
		 </td></tr>

<tr><td colspan='2' align='right'><button type='submit' class='ninguna' style="color:black">Grabar</button></td></tr>
</table>
		 <input type="hidden" id="currentRow"/>
		 <input type="hidden" id="allRows" name="allRows"/>
		 <input type="hidden" id="lProductos" name="lProductos" value="<?=$lProductos?>"/>
		 <input type="hidden" id="lServicios" name="lServicios" value="<?=$lServicios?>"/>
		 
<?= $this->Form->end() ?>
<div class="col-md-8 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Requisiciones/index" class="btn dark inverse">Volver</a>
</div>
</div>

<?=$this->Html->script('valrut.js');?>
<?=$this->Html->script('valdate.js');?>

<script language="javascript">
$("#nombre").focus();
   
   lProductos = document.getElementById("lProductos").value;
   
   if (lProductos!="") {
	  l = document.getElementById("desproducto");
	  
	  for (i=0; i < l.options.length; i++)
		 l.options[i] = null;  
	 
	  option = document.createElement("option");
      option.text = "";
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
   
   lServicios = document.getElementById("lServicios").value;
   
   if (lProductos!="") {
	  l = document.getElementById("desservicio");
	  
	  for (i=0; i < l.options.length; i++)
		 l.options[i] = null;  
	 
	  option = document.createElement("option");
      option.text = "";
	  option.value= "";
      l.add(option);		 
	 
	  lista = lServicios.split("@@@");
	  
	  for (i=0; i < lista.length; i++) {
		 e = lista[i].split("&&&");
		 
		 option = document.createElement("option");
         option.text = e[1];
		 option.value= e[0];
         l.add(option);		 
	  }
	  
	  l.selectedIndex=0;
   }   
   
   

   document.getElementById("desproducto").onchange=function() {
	  if (this.value=="")  {
		 document.getElementById("producto").value="";
		 document.getElementById("idprod").value="";
		 return;
	  }
	  
	  e = this.value.split("#");
	  
	  document.getElementById("producto").value = e[0];
	  document.getElementById("idprod").value = e[1];
	  
	  document.getElementById("idserv").value="";
	  document.getElementById("desservicio").selectedIndex=0;
	  
	  document.getElementById("otroinsumo").value="";

      document.getElementById("idunms").value="";
	  
	  document.getElementById("producto").focus();
		 
   }
   
   document.getElementById("desservicio").onchange=function() {
	  if (this.value=="")  {
		 document.getElementById("idserv").value="";
		 return;
	  }
	  
	  document.getElementById("idserv").value = this.value;
	  document.getElementById("producto").value = "";
	  document.getElementById("idprod").value = "";
	  document.getElementById("desproducto").selectedIndex=0;
	  
	  document.getElementById("otroinsumo").value="";

      document.getElementById("idunmp").value="";
	  
	  document.getElementById("idserv").focus();
		 
   }
   
   document.getElementById("otroinsumo").onchange=function() {
	  if (this.value=="")  {
		 
		 return;
	  }
	  
	  document.getElementById("idserv").value = "";
	  document.getElementById("desservicio").selectedIndex=0;
	  document.getElementById("producto").value = "";
	  document.getElementById("idprod").value = "";
	  document.getElementById("desproducto").selectedIndex=0;

      document.getElementById("idunmp").value="";
      document.getElementById("idunms").value="";
	  
	  document.getElementById("cantidad").focus();
		 
   }
   
   document.getElementById("cantidad").onblur=function () {
	  if (this.value=="") return;
	  
	  if (!isNumber(this.value)) this.value="";
   }
   
   
   document.getElementById("frm").onsubmit=function() {
	  //alert("onsubmit");
	  
	  tbl = document.getElementById("mitabla");
	  
	  //alert(tbl.rows.length);
	  
	  if (tbl.rows.length < 3) {
		 alert("¡Debe ingresar alguna línea en el documento!");
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
   
   document.getElementById("producto").onblur = function() {
	  idprod = document.getElementById("producto");
	  idempr = document.getElementById("idempr").value;
	  
	  //alert(idbode);
	  
      if (idprod.value=="" || idprod.value.length!=8)
         return;		  
	  
	  //Chequeamos que el producto no este repetido
      nVeces=0;
	  
	  tabla = document.getElementById("mitabla");
	  
	  for (i=2; i < tabla.rows.length; i++) {
         data = document.getElementById("data"+i).value;

         e    = data.split("|");
		 
		 if (idprod.value==e[0]) nVeces++;

         //alert(e[0]);		 
	  }
	  
	  if (nVeces > 0) {
		 //Ya ha sido ingresado
		 alert("Producto: '"+idprod.value+"' ya ha sido ingresado!");
		 idprod.value="";
         document.getElementById("desproducto").selectedIndex=0;
         document.getElementById("idunmp").value="";
		 return;
	  }
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>Requisiciones/chkIdprod/"+idempr+"/"+idprod.value,
         success: function( result ) {
	     //alert(result);
		 
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
		
			l = document.getElementById("desproducto"); 
			
			for(i=0; i < l.options.length; i++) {
			   e = l.options[i].value.split("#");
			   
			   if (e[1]==data.id) {
				  l.selectedIndex=data.id;
				  break;
			   }
			}
						
			document.getElementById("idunmp").value=data.idunmp; 
	     }
         else {		 
		    alert("Producto: '"+idprod.value+"' no ha sido encontrado!");
			
		    document.getElementById("desproducto").selectedIndex=0; 
			
			document.getElementById("idunmp").value=""; 		 		
			
		}
      }
     });
   }
   
   document.getElementById("idserv").onblur = function() {  
	  idserv = this.value;
	  
      if (idserv=="" || idserv.length<=0)
         return;		  
	 
	  if (!isNumber(idserv)) {
		 document.getElementById("idserv").value="";
		 return;
	  }
	  
	  //Chequeamos que el producto no este repetido
      nVeces=0;
	  
	  tabla = document.getElementById("mitabla");
	  
	  for (i=2; i < tabla.rows.length; i++) {
         data = document.getElementById("data"+i).value;

         e    = data.split("|");

         //alert(e[4]+", "+this.value);
         
		 
		 if (this.value==e[4]) nVeces++;

         //alert(e[0]);		 
	  }
	  
	  if (nVeces > 0) {
		 //Ya ha sido ingresado
		 alert("Servicio: '"+this.value+"' ya ha sido ingresado!");
		 this.value="";
         document.getElementById("desservicio").selectedIndex=0;
         document.getElementById("idunms").value="";
		 return;
	  }
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>Requisiciones/chkIdserv/"+idserv,
         success: function( result ) {
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
		
			l = document.getElementById("desservicio"); 
			l.selectedIndex=idserv;
						
			document.getElementById("idunms").value=data.idunms; 
	     }
         else {		 
		    alert("Servicio: '"+idserv+"' no ha sido encontrado!");
			
		    document.getElementById("desservicio").selectedIndex=0; 
			
			document.getElementById("idunms").value=""; 		 		
			
		}
      }
     });
   }   
   
   
   
   function validRow(data) {
	  producto   = document.getElementById("producto").value;
	  idserv     = document.getElementById("idserv").value;
	  otroinsumo = document.getElementById("otroinsumo").value;
	  cantidad   = document.getElementById("cantidad").value;
	  
	  if (producto=="" && idserv=="" && otroinsumo=="") {
		 alert("¡Debe ingresar Producto o Servicio u otro insumo!");
		 return false;
	  }
	  
	  if (cantidad*1.0 <= 0) return false;
		 
	  return true;
   }
        
<?php echo $extrajs;?>      
</script>
