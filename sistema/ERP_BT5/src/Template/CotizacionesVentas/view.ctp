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
         <?=$this->Form->text("fechacotizacion", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "fechacotizacion", "style" => "color:black;", "required" => true, "value" => $this->Time->format($gre->fechacotizacion,'d/MM/Y'), "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td><label for="rutclie" >Cliente*</label></td>
		 </td>
		 <td>
         <?=$this->Form->text("rutclie", ["size" => 13, "maxlength" => 13, "class" => "stacked-input upper", "id" => "rutclie", "required" => true, "style" => "color:black;", "readonly" => true]);?>
		 <?=$this->Form->text("razclie", ["size" => 45, "maxlength" => 45, "class" => "stacked-input upper", "id" => "razclie", "readonly" => true, "style" => "color:black;", "readonly" => true]);?>
		 </td>
		 </tr>
         <?=$this->Form->hidden("idclie", ["id" => "idclie"])?>
		 <tr><td valign="middle">
         <label for="descripcioncotizacion" >Descripción Cotizado*</i></label>
		 </td>
		 <td>
         <?=$this->Form->text("descripcioncotizacion", ["size" => 80, "maxlength" => 250, "class" => "stacked-input upper", "id" => "descripcioncotizacion", "style" => "color:black;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="idgere" >Gerencia</label></td>
		 <td>
         <input type="text id="idgere" size="15" value="<?=$gerencias[$gre->idgere]?>" readonly style="color:black"/>
		 &nbsp; <label>Proyecto</label>
		 &nbsp;
         <input type="text id="idproy" size="15" value="<?=$proyectos[$gre->idproy]?>" readonly style="color:black"/>
		 </td>
		 </tr>
		 <tr><td>
         <label for="idline" >Línea de negocios</i></label></td>
		 <td>
         <input type="text id="idline" size="15" value="<?=$lineas_negocios[$gre->idline]?>" readonly style="color:black"/>
		 &nbsp;
         <label for="idceco" >Centro de Costo</label>&nbsp;
         <input type="text id="idceco" size="15" value="<?=$centros_costos[$gre->idceco]?>" readonly style="color:black"/>
		 </td>
		 </tr>
		 <tr><td>
         <label for="idtare" >Tarea</i></label></td>
		 <td>
         <input type="text id="idtare" size="15" value="<?=$tareas[$gre->idtare]?>" readonly style="color:black"/>
		 </td>
		 </tr>
		 <tr><td>
         <label for="diasvalidez" >Días Validez*</label></td>
		 <td>
         <?=$this->Form->text("diasvalidez", ["size" => 10, "maxlength" => 4, "class" => "stacked-input upper", "id" => "diasvalidez", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 &nbsp;
         <label for="idescv" >Estado</label>
		 &nbsp;
         <?=$this->Form->hidden("idesnv");?>
		 <?=$this->Form->text("estado", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "estado", "style" => "color:black;", "value" => $estados_cotizaciones_vtas[$gre->idescv] , "readonly" => true]);?>
		 </td>
		 </tr>
		  <tr><td>
         <label for="idusuavendedor" >Vendedor</i></label></td>
		 <td>
         <input type="text id="idusuavendedor" size="15" value="<?=$vendedores[$gre->idusuavendedor]?>" readonly style="color:black"/>
		 </td>
		 </tr>
		 </tr>
		 <tr><td>
         <label for="idbode" >Bodega</i></label></td>
		 <td>
         <input type="text id="idbode" size="15" value="<?=$bodegas[$gre->idbode]?>" readonly style="color:black"/>
		 </td>
		 </tr>
		 <tr>
		 <td>
         <label for="porcentajedescuento" >%Descto.</label></td>
		 <td>
         <?=$this->Form->text("porcentajedescuento", ["size" => 10, "maxlength" => 7, "class" => "stacked-input upper", "id" => "porcentajedescuento", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td colspan='2' align="center">
		    		
			<?=$grilla?>
			
		 <input type="hidden" id="nRow" value="<?=$nRow?>"/>
		 
		 </td></tr>
		 <tr><td>
         <label for="totallinea" >Sub.Total</label></td>
		 <td>
         <?=$this->Form->text("totallinea0", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "totallinea0", "style" => "color:black;text-align:right;", "readonly" => true, "readonly" => true]);?>
		 </td>
		 </tr>
		 <!--<tr><td>
         <label for="montodescuento" >Mto.Descto</label></td>
		 <td>
         <?=$this->Form->text("montodescuento0", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "montodescuento0", "style" => "color:black;text-align:right;", "readonly" => true, "readonly" => true]);?>
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
         <label for="montodescuento" >Exento</label></td>
		 <td>
         <?=$this->Form->text("exento0", ["size" => 10, "maxlength" => 12, "class" => "stacked-input upper", "id" => "exento0", "style" => "color:black;text-align:right;", "readonly" => true]);?>
		 </td>
		 </tr>
		 <tr><td>
         <label for="montodescuento" >Afecto</label></td>
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

<script language="javascript">
   updateTotals();
   
   rutclie = document.getElementById("rutclie");
   
   rutclie.value = disp_no(<?=$gre->rut?>)+"-"+'<?=$gre->dv?>';
   
   <?php echo $extrajs;?>   
</script>

