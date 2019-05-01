<?= $this->Form->create($gre) ?>
 
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Productos</h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
         <?=$this->Form->hidden("idempr")?>
		 <label for="idsfpr" class="stacked-label"><i data-toggle="tooltip" title="Nombre de la Sub Familia" class="pe-7s-menu" ></i></label>
         <?=$this->Form->select("idfapr", $familias_productos, ["class" => "stacked-input", "id" => "idfapr", 'placeholder' => 'Familia*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;', "disabled" => ($gre->id!="")]);?>
         <label for="idsfpr" class="stacked-label"><i data-toggle="tooltip" title="Nombre de la Sub Familia" class="pe-7s-menu" ></i></label>
         <?=$this->Form->select("idsfpr", $sub_familias_productos, ["class" => "stacked-input", "id" => "idsfpr", 'placeholder' => 'Sub.Familia*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;', "disabled" => ($gre->id!="")]);?>
         <label for="correlativoflia" class="stacked-label"><i data-toggle="tooltip" title="Correlativo" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("correlativoflia", ["size" => 4, "maxlength" => 4, "class" => "stacked-input upper", "id" => "correlativoflia", 'placeholder' => 'Correlativo*', "readonly" => true]);?>		 
         <label for="nombre" class="stacked-label"><i data-toggle="tooltip" title="Nombre del Producto" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("nombre", ["size" => 60, "maxlength" => 60, "class" => "stacked-input upper", "id" => "nombre", 'placeholder' => 'Nombre*']);?>
         <label for="idunmp" class="stacked-label"><i data-toggle="tooltip" title="Unidad de Medida" class="pe-7s-menu" ></i></label>
         <?=$this->Form->select("idunmp", $unidades_medidas_productos, ["class" => "stacked-input", "id" => "idunmp", 'placeholder' => 'Unidad Medida*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>		 
         <label for="idtipr" class="stacked-label"><i data-toggle="tooltip" title="Tipo de Producto" class="pe-7s-menu"></i></label>
         <?=$this->Form->select("idtipr", $tipos_productos, ["class" => "stacked-input", "id" => "idtipr", 'placeholder' => 'Tipo Producto*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;', "required" => true]);?>
         <label for="idorpr" class="stacked-label"><i data-toggle="tooltip" title="Orígen del Producto" class="pe-7s-menu" ></i></label>
         <?=$this->Form->select("idorpr", $origenes_productos, ["class" => "stacked-input", "id" => "idorpr", 'placeholder' => 'Origen Producto*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
         <label for="sku" class="stacked-label"><i data-toggle="tooltip" title="SKU" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("sku", ["size" => 10, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "sku", 'placeholder' => 'Sku']);?>
         <label for="ean13" class="stacked-label"><i data-toggle="tooltip" title="EAN13" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("ean13", ["size" => 10, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "ean13", 'placeholder' => 'Ean13']);?>
         <label for="qr" class="stacked-label"><i data-toggle="tooltip" title="QR" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("qr", ["size" => 10, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "qr", 'placeholder' => 'Qr']);?>
         <label for="pesounitariokg" class="stacked-label"><i data-toggle="tooltip" title="Peso Unitario Kilo" class="pe-7s-note" ></i></label>
         <?=$this->Form->text("pesounitariokg", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "pesounitariokg", 'placeholder' => 'Peso Unit.Kg*']);?>
         <label for="idesre" class="stacked-label"><i data-toggle="tooltip" title="Estado del Producto" class="pe-7s-menu" ></i></label>
         <?=$this->Form->select("idesre", $estados_registros, ["class" => "stacked-input", "id" => "idesre", 'placeholder' => 'Estado*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Productos/index" class="btn dark inverse">Volver</a>
</div>
</div>

<?=$this->Html->script('valrut.js');?>
<?=$this->Html->script('valdate.js');?>
<script language="javascript">
$("#idsfpr").focus();

   document.getElementById("correlativoflia").onblur=function() {
	  if (!isNumber(this.value)) {
		 this.value="";
		 return;
	  }
	  
	  while (this.value.length < 4) this.value = "0" + this.value;
	  
	  
   }
   
   document.getElementById("pesounitariokg").onblur=function() {
	  if (!isNumber(this.value)) {
		 this.value="";
		 return;
	  }
	  
   }
   
   document.getElementById("idfapr").onchange = function() {
	  idfapr = document.getElementById("idfapr");
	  

	  
      if (idfapr.value=="")
         return;		  
	  
	  //alert(idfapr.value);
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>Productos/getSubfams/"+idfapr.value,
         success: function( result ) {
	     //alert(result);
		 
	     data = JSON.parse(result);
		 
         if (data.cuenta > 0) {
		
			//alert(data.subfam);
			
			idsfpr = document.getElementById("idsfpr");
			
			idsfpr.options=null;
			
			lista = data.subfam.split(";");
			
			var option = document.createElement("option");
            option.value = "";
            option.text  = "";
            idsfpr.appendChild(option);
			   
			for (i=0; i < lista.length; i++) {
			   e = lista[i].split("|");
			   
               var option = document.createElement("option");
               option.value = e[0];
               option.text  =  e[1];
               idsfpr.appendChild(option);
			}
						
	     }
         else {		 
		    	
			
		}
      }
     });
   }   
</script>
