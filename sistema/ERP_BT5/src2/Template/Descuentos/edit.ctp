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

 
<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Descuentos </h3>
         </div>
      </header>

      <div class="widget__content">
         <?=$this->Form->hidden("id")?>
		 
		 <?php if ($modo=="add"): ?>
            <label for="idfapr" class="stacked-label"><i data-toggle="tooltip" title="Familia de Productos" class="pe-7s-menu" ></i></label>
            <?=$this->Form->select("idfapr", $familias_productos, ["class" => "stacked-input", "id" => "idfapr", 'placeholder' => 'Familia', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
		    <label for="idsfpr" class="stacked-label"><i data-toggle="tooltip" title="Sub-Familia de Productos" class="pe-7s-menu" ></i></label>
            <?=$this->Form->select("idsfpr", $sub_familias_productos, ["class" => "stacked-input", "id" => "idsfpr", 'placeholder' => 'Familia', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
            <label for="idprod" class="stacked-label"><i data-toggle="tooltip" title="Producto" class="pe-7s-menu" ></i></label>
            <?=$this->Form->select("idprod", $productos, ["class" => "stacked-input", "id" => "idprod", 'placeholder' => 'Producto', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>
		 <?php else: ?>
            <label for="idfapr" class="stacked-label"><i data-toggle="tooltip" title="Familia de Productos" class="pe-7s-menu" ></i></label>
            <?=$this->Form->hidden("idfapr", ["id" => "idfapr", "value" => $gre->idfapr]);?>
			<?=$this->Form->text("idfapr_des", ["class" => "stacked-input", "id" => "idfapr_des", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;', "readonly" => true, "value" => $familias_productos[$gre->idfapr]]);?>
			
		    <label for="idsfpr" class="stacked-label"><i data-toggle="tooltip" title="Sub-Familia de Productos" class="pe-7s-menu" ></i></label>
            <?=$this->Form->hidden("idsfpr", ["id" => "idsfpr", "value" => $gre->idsfpr]);?>
			<?=$this->Form->text("idsfpr_des", ["class" => "stacked-input", "id" => "idsfpr_des", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;', "readonly" => true, "value" => $sub_familias_productos[$gre->idsfpr]]);?>
			
            <label for="idprod" class="stacked-label"><i data-toggle="tooltip" title="Producto" class="pe-7s-menu" ></i></label>
            <?=$this->Form->hidden("idprod", ["id" => "idprod", "value" => $gre->idprod]);?>
			<?=$this->Form->text("idprod_des", ["class" => "stacked-input", "id" => "idprod_des", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;', "readonly" => true, "value" => $productos[$gre->idprod]]);?>
		 <?php endif; ?>
         
		 <label for="porcentajedescuento" class="stacked-label"><i data-toggle="tooltip" title="% Descuento" class="pe-7s-menu" ></i></label>
         <?=$this->Form->text("porcentajedescuento", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "porcentajedescuento", 'placeholder' => '%Descuento']);?>
         <label for="idesre" class="stacked-label"><i data-toggle="tooltip" title="Estado" class="pe-7s-menu" ></i></label>
         <?=$this->Form->select("idesre", $estados_registros, ["class" => "stacked-input", "id" => "idesre", 'placeholder' => 'Estado*', 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;']);?>


<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Descuentos/index" class="btn dark inverse">Volver</a>
</div>
</div>

<?=$this->Html->script('valrut.js');?>
<?=$this->Html->script('valdate.js');?>

<script language="javascript">
$("#idfapr").focus();

   document.getElementById("porcentajedescuento").onblur=function() {
	  if (!isNumber(this.value)) this.value="";
   }

   <?php if ($modo=="add"): ?>
   document.getElementById("idfapr").onchange=function() {
	  if (this.value=="") {
		 this.selectedIndex=0;
		 
		 document.getElementById("idsfpr").options.length=0;
		 document.getElementById("idsfpr").selectedIndex=0;
		 
		 document.getElementById("idprod").options.length=0;
		 document.getElementById("idprod").selectedIndex=0;
		 
		 return;
	  }
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>Descuentos/buscaSubfam/"+this.value,
         success: function( result ) {
	     data = JSON.parse(result);
		 l = document.getElementById("idsfpr");
		 
		 l.options.length=0;
		 
         if (data.cuenta > 0) {
    		var option = document.createElement("option");
            option.text = "";
   	 	    option.value= "";
            l.add(option);
   		 
   		    for (i=0; i < data.lista.length; i++) {
                var option = document.createElement("option");
                option.text = data.lista[i].descripcion;
   		  	    option.value= data.lista[i].id;
		  	    
                l.add(option);
   		    }
   		    
   		    l.selectedIndex=0;

	     }
         else {		 
		    l.options.length=0;
		}
      }
     });
   }
   
   document.getElementById("idsfpr").onchange=function() {
	  if (this.value=="") {
		 this.selectedIndex=0;
		 
		 document.getElementById("idprod").options.length=0;
		 document.getElementById("idprod").selectedIndex=0;
		  
         return;
	  }
	  
	  $.ajax({
         url: "<?=$this->request->webroot?>Descuentos/buscaProds/"+this.value,
         success: function( result ) {
	     data = JSON.parse(result);
		 l = document.getElementById("idprod");
		 
		 //alert("Volví");
		 
		 l.options.length=0;
		 
         if (data.cuenta > 0) {
    		var option = document.createElement("option");
            option.text = "";
   	 	    option.value= "";
            l.add(option);
   		 
   		    for (i=0; i < data.lista.length; i++) {
                var option = document.createElement("option");
                option.text = data.lista[i].nombre;
   		  	    option.value= data.lista[i].id;
		  	    
                l.add(option);
   		    }
   		    
   		    l.selectedIndex=0;

	     }
         else {		 
		    l.options.length=0;
		}
      }
     });
   }
 
   
   document.getElementById("frm").onsubmit=function() {
	  idfapr = document.getElementById("idfapr");
	  idsfpr = document.getElementById("idsfpr");
	  idprod = document.getElementById("idprod");
	  porcentajedescuento = document.getElementById("porcentajedescuento");
	  
	  if (porcentajedescuento.value=="")
		  porcentajedescuento.value=0;
	  
	  porcentajedescuento.value=porcentajedescuento.value*1.0;
	  
	  if (porcentajedescuento.value <=0) {
		 alert("¡Debe ingresar un porcentaje de descuento!");
		 porcentajedescuento.focus();
		 porcentajedescuento.select();
		 
		 return false;
	  }
      else if (idfapr.selectedIndex > 0 && idsfpr.selectedIndex > 0 && idprod.selectedIndex > 0)
		 return true;
	  else if (idfapr.selectedIndex > 0 && idsfpr.selectedIndex > 0)
		 return true;
	  else if (idfapr.selectedIndex > 0)
		 return true; 
	  else
		 return false;
   }
   <?php else: ?>

   document.getElementById("frm").onsubmit=function() {
	  porcentajedescuento = document.getElementById("porcentajedescuento");
	  
	  if (porcentajedescuento.value=="")
		  porcentajedescuento.value=0;
	  
	  porcentajedescuento.value=porcentajedescuento.value*1.0;
	  
	  if (porcentajedescuento.value <=0) {
		 alert("¡Debe ingresar un porcentaje de descuento!");
		 porcentajedescuento.focus();
		 porcentajedescuento.select();
		 
		 return false;
	  }

	  return true;
   }   
   <?php endif; ?>

</script>
