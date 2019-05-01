<?= $this->Form->create($gre, ["id" => "frm", "method" => "post"]) ?>
    <div class="widget__content">
	     <h1>Listas de Precios</h1><br/>
	     <table style="border:1px solid white;" border="1" cellspacing="1" cellpadding="1">
         <?=$this->Form->hidden("id", ["id" => "id"])?>
</td></tr>
         <?=$this->Form->hidden("idempr", ["id" => "idempr"])?>
</td></tr>
<tr><td><label for='correlativo' >Correlativo*</label></td><td><?=$this->Form->text("correlativo", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "correlativo", 'style' => 'color:black;text-align:right;', 'readonly' => true]);?>
</td></tr>
<tr><td><label for='fechainicio' >Fecha Inicio*</label></td>
    <td><?=$this->Form->text("fechainicio", ["size" => 10, "maxlength" => 10, "class" => "stacked-input datepicker", "placeholder" => "dd-mm-aaaa", "id" => "fechainicio", "style" => "color:black;", "required" => true, "value" => $this->Time->format($gre->fechainicio,'d/MM/Y')]);?>
</td></tr>
<tr><td><label for='fechafin' >Fecha Fin</label></td>
<td><?=$this->Form->text("fechafin", ["size" => 10, "maxlength" => 10, "class" => "stacked-input datepicker", "placeholder" => "dd-mm-aaaa", "id" => "fechafin", "style" => "color:black;", "value" => $this->Time->format($gre->fechafin,'d/MM/Y')]);?>
</td></tr>
<tr><td><label for='observaciones' >Observaciones*</label></td><td><?=$this->Form->text("observaciones", ["size" => 50, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "observaciones", 'style' => 'color:black;']);?>
</td></tr>
<tr><td><label for='idesre' >Estado*</label></td><td><?=$this->Form->select("idesre", $estados_registros, ["class" => "stacked-input upper", "id" => "idesre", 'placeholder' => 'Estado*', 'style' => 'color:black;']);?>
</td></tr>
<tr><td colspan='2' align='center'><?php echo $grilla;?></td></tr>
<input type='hidden' id='nRow' value='<?=$nRow?>'/>
<input type='hidden' id='currentRow'/>
<input type='hidden' id='allRows' name='allRows'/>

<tr><td colspan='2' align='right'><?= $this->Form->button(__('Guardar'), ['style' => 'color:black']) ?></td></tr>
</table>

</div>



<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>ListasPrecios/index" class="btn dark inverse">Volver</a>
</div>
</div>

<?=$this->Html->script('valrut.js');?>
<?=$this->Html->script('valdate.js');?>

<script language="javascript">
$("#nombre").focus();

  document.getElementById("producto").onblur=function() {
	 //alert(this.value);
	 
	 
	 l = document.getElementById("desprod");
	 
	 currentRow = document.getElementById("currentRow").value;
	 
	 
	 if (this.value=="") {
		l.selectedIdex=0;
		return;
	 }
	 
	 l = document.getElementById("desprod");
	 
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
		 
		 if (this.value==e[0] && currentRow!=i) 
			 nVeces++;

         //alert(e[0]);		 
	  }
	  
	  if (nVeces > 0) {
		 //Ya ha sido ingresado
		 alert("Producto: '"+this.value+"' ya ha sido ingresado!");
		 this.value="";
		 return;
	  }
	 
	 l = document.getElementById("desprod");
	 
	 for (i=0; i < l.options.length; i++) {
		e = l.options[i].value.split("#");
		
		if (this.value==e[0]) {
		   document.getElementById("idprod").value = e[1];
		   l.selectedIndex = i;
		   document.getElementById("valorunitario").focus();
		   return;		   
		}
	 }
	 
	 document.getElementById("idprod").value = "";
	 l.selectedIndex=0;
	 this.value="";
	 
  }

  document.getElementById("desprod").onchange=function() {
	 if (this.value=="") return;
	 
	 e = this.value.split("#");
	 
	 document.getElementById("producto").value = e[0];
	 document.getElementById("idprod").value = e[1];
	 
	 document.getElementById("producto").focus();
  }
  
  document.getElementById("valorunitario").onblur=function() {
	 if (!isNumber(this.value))
		this.value="";
  }
  
  document.getElementById("idesre").onchange=function() {
	 idempr = document.getElementById("idempr").value;
	 correlativo = document.getElementById("correlativo").value;
	 idesre = this.value;
	 
	 if (idesre==2) return;
	 
	 //alert(idesre);
	 
	 l = document.getElementById("idesre");
	 
	 if (l.selectedIndex==0) return;
	 
	 $.ajax({
         url: "<?=$this->request->webroot?>ListasPrecios/chkIdesre/"+idempr+"/"+correlativo,
         success: function( result ) {
	     data = JSON.parse(result);
		 
		 //alert(data.cuenta);
		 if (data.cuenta==0) {
			for(i=0; i < l.options.length; i++)
			   if (l.options[i].value==1) 
				   l.selectedIndex= i;
	     }
		 else 
         {
		 if (data.cuenta > 0 && data.correlativo==correlativo) {
			for(i=0; i < l.options.length; i++)
			   if (l.options[i].value==1) 
				   l.selectedIndex= i;
	     }
		 else {
			for(i=0; i < l.options.length; i++)
			   if (l.options[i].value==2) 
				   l.selectedIndex= i;
		 }
		 }
      }
     });
	  
  }
  
  document.getElementById('frm').onsubmit=function() {
	  tbl = document.getElementById('mitabla');  
	  
	  
	  allRows='';
	  
	  for (i=2; i < tbl.rows.length; i++) {
		 if (allRows!='') allRows = allRows + '@@@';
		 
		 allRows = allRows + document.getElementById('data'+i).value;		 		  
	  }
	  
	  document.getElementById('allRows').value = allRows;
	  
	  //alert(allRows);
		  
	  
	  return true;
   }
   
   
      
<?php echo $extrajs;?></script>
