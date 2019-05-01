<?= $this->Form->create($gre, ["id" => "frm"]) ?>

<?php if (count($errors) > 0) :
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
<?php endif ?>

<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Mantención de Usuarios</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="username" class="stacked-label data-toggle="tooltip" title="Nombre de Usuario""><i class="pe-7s-user" ></i></label>
         <?=$this->Form->text("username", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "username", "placeholder" => "Nombre Usuario"]);?>
         <label for="password" class="stacked-label data-toggle="tooltip" title="Contraseña""><i class="pe-7s-lock" ></i></label>
         <?=$this->Form->text("password", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "password", "placeholder" => "Contraseña", "required" => true]);?>
         <label for="idpers" class="stacked-label data-toggle="tooltip" title="Nombre de Persona""><i class="pe-mi-contacts-2" ></i></label>
         <?=$this->Form->select("idpers", $personas, ["class" => "stacked-input upper", "id" => "idpers", "placeholder" => "Persona", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;', 'required' => true])?>
         <label for="idesre" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Estado"><i class="pe-7s-check"></i></label>
         <?=$this->Form->select("idesre", $estados, ["class" => "stacked-input upper", "id" => "idesre", "placeholder" => "Estado", 'style' => 'width: calc(100% - 65px);display: inline-block;height: 65px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;', "required" => true]);?>

<?=$this->Form->hidden("id")?>

<table>
<tr><td colspan='2' align="center">
		    		
			<?=$grilla?>
			
</td></tr>
		 

</table>

		 <input type="hidden" id="currentRow"/>
		 <input type="hidden" id="nRow"/>
		 <input type="hidden" id="allRows" name="allRows"/>
		 
		 <!--<input type="hidden" id="lProductos" name="lProductos" value="<?=$lProductos?>"/>-->

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>MantUsuarios/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
   $("#username").focus();
   
   document.getElementById("frm").onsubmit=function() {
	  tbl = document.getElementById("mitabla");
	    
	  allRows="";
	  
	  if (tbl.rows.length <= 2) {
		 alert("¡Debe ingresar al menos un par empresa/perfil!");
		 return false;
	  }
	  
	  for (i=2; i < tbl.rows.length; i++) {
		 if (allRows!="") allRows = allRows + "@@@";
		 
		 allRows = allRows + document.getElementById("data"+i).value;		 		  
	  }
	  
	  document.getElementById("allRows").value = allRows;
		  
	  
	  return true;
   }
   
   document.getElementById("empresa").onchange = function() {
	  document.getElementById("idempr").value = this.value;
   }
   
   document.getElementById("perfil").onchange = function() {
	  document.getElementById("idperf").value = this.value;
	  
	  if (this.value=="") return;
	  
	  
	  emp = document.getElementById("empresa");
	  
      nVeces=0;
	  
	  if (document.getElementById("currentRow")==null)
	     currentRow = 0;
      else
         currentRow = document.getElementById("currentRow").value;
		
	  tabla = document.getElementById("mitabla");
	  
	  for (j=0; j < emp.options.length; j++) 
	     for (i=2; i < tabla.rows.length; i++) {
			
            data = document.getElementById("data"+i).value;
         
            e    = data.split("|");
			
			//alert(emp.options[j].value+"-"+e[0]+"-"+e[1]);
		    
		    if ((emp.options[j].value==e[2] && this.value==e[3]) && currentRow!=i) nVeces++;
         
            //alert(e[0]);		 
	     }
	  
	  if (nVeces > 0) {
		 //Ya ha sido ingresado
		 alert("¡Registro ya ha sido ingresado!");
		 this.selectedIndex=0;
		 return;
	  }
	  

   }   
        
<?php echo $extrajs;?>      
</script>
