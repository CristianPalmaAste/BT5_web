<?php echo $this->Html->css('scroll'); ?>

<?= $this->Form->create($gre, ["id" => "frm", "method" => "post"]) ?> 

     <div class="widget__content">
	     <h1>Notas de Ventas</h1><br/>
	     <table style="border:1px solid white;" border="1" cellspacing="1" cellpadding="1">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idempr", ["id" => "idempr"])?>
		 <input type="hidden" name="idgrem" id="idgrem" value="<?=$idgrem?>"/>
		 <tr><td>
         <label for="numero" >Número*</label></td>
		 <td>
         <?=$this->Form->text("numero", ["size" => 10, "maxlength" => 10, "class"=>"upper", "style"=>"color:black;", "id" => "numero", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 &nbsp;
		 <label for="fechanotaventa" >Fecha*</label>
		 &nbsp;
         <?=$this->Form->text("fechanotaventa", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fechanotaventa", "style" => "color:black;", "required" => true, "value" => $this->Time->format($gre->fechanotaventa,'d/MM/Y'), "readonly" => true]);?>
 		 &nbsp;
		 <label for="nrocotiz" >Número de Cotización*</label>
		 &nbsp;
         <?=$this->Form->text("nrocotiz", ["size" => 10, "maxlength" => 10, "class" => "stacked-input", "id" => "nrocotiz", "style" => "color:black;", "readonly" => true]);?>

		 </td>
		 </tr>
		 <tr><td><label for="rutclie" >Cliente*</label></td>
		 </td>
		 <td>
         <?=$this->Form->text("rutclie", ["size" => 13, "maxlength" => 13, "class" => "stacked-input upper", "id" => "rutclie", "required" => true, "style" => "color:black;", "readonly" => true]);?>
		 <?=$this->Form->text("razclie", ["size" => 45, "maxlength" => 45, "class" => "stacked-input upper", "id" => "razclie", "readonly" => true, "style" => "color:black;"]);?>
		 </td>
		 </tr>
         <?=$this->Form->hidden("idclie", ["id" => "idclie"])?>
		 <tr><td valign="middle">
         <label for="descripcionnotaventa" >Descripción Nota*</i></label>
		 </td>
		 <td>
         <?=$this->Form->text("descripcionnotaventa", ["size" => 80, "maxlength" => 250, "class" => "stacked-input upper", "id" => "descripcionnotaventa", "style" => "color:black;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="idgere" >Gerencia</label></td>
		 <td>
         <input type="text" id="idgere" size="15" value="<?=$gerencias[$gre->idgere]?>" readonly style="color:black"/>
		 &nbsp; <label>Proyecto</label>
		 &nbsp;
         <input type="text" id="idproy" size="15" value="<?=$proyectos[$gre->idproy]?>" readonly style="color:black"/>
		 </td>
		 </tr>
		 <tr><td>
         <label for="idline" >Línea de negocios</i></label></td>
		 <td>
         <input type="text" id="idline" size="15" value="<?=$lineas_negocios[$gre->idline]?>" readonly style="color:black"/>
		 &nbsp;
         <label for="idceco" >Centro de Costo</label>&nbsp;
         <input type="text" id="idceco" size="15" value="<?=$centros_costos[$gre->idceco]?>" readonly style="color:black"/>
		 </td>
		 </tr>
		 <tr><td>
         <label for="idtare" >Tarea</i></label></td>
		 <td>
         <input type="text" id="idtare" size="15" value="<?=$tareas[$gre->idtare]?>" readonly style="color:black"/>
		 </td>
		 </tr>
		 <tr><td>
         <label for="idescv" >Estado</label>
		 </td><td>
         <?=$this->Form->hidden("idesnv");?>
		 <?=$this->Form->text("estado", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "estado", "style" => "color:black;", "value" => $estados_notas_vtas[$gre->idesnv] , "readonly" => true]);?>
		 </td>
		 </tr>
		  <tr><td>
         <label for="idusuavendedor" >Vendedor</i></label></td>
		 <td>
         <input type="text" id="idusuavendedor" size="15" value="<?=$vendedores[$gre->idusuavendedor]?>" readonly style="color:black"/>
		 </td>
		 </tr>
         <tr><td>
         <label for="idbode" >Bodega</i></label></td>
		 <td>
		 <input type="text" id="idbode" size="15" value="<?=$bodegas[$gre->idbode]?>" readonly style="color:black"/>
		 </td>
		 </tr>
		 <tr>
		 <td>
         <label for="porcentajedescuento" >%Descto.</label></td>
		 <td>
         <?=$this->Form->text("porcentajedescuento", ["size" => 10, "maxlength" => 7, "class" => "stacked-input upper", "id" => "porcentajedescuento", "style" => "color:black;text-align:right;"]);?>
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
         <label for="montodescuento1" >Mto.Descto</label></td>
		 <td>
         <?=$this->Form->text("montodescuento", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "montodescuento", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="montodescuento1" >Neto</label></td>
		 <td>
         <?=$this->Form->text("neto", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "neto", "style" => "color:black;text-align:right;", "readonly" => true]);?>
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
         <tr><td colspan='2' align='right'>
         </td>
		 </tr>
         </table>
<?= $this->Form->end() ?>		
<div class="btn-group block">
<a href="<?=$this->request->webroot?>NotasVentas/index" class="btn dark inverse">Volver</a>
</div> 
</div>



<!--
<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>CotizacionesVentas/index" class="btn dark inverse">Volver</a>
</div>
</div>
-->
<?=$this->Html->script('valrut.js');?>
<?=$this->Html->script('valdate.js');?>

<script language="javascript">
   rutclie = document.getElementById("rutclie");
   
   rutclie.value = disp_no(<?=$gre->rut?>)+"-"+'<?=$gre->dv?>';
   
   updateTotals();
   
   <?php echo $extrajs;?>   
</script>