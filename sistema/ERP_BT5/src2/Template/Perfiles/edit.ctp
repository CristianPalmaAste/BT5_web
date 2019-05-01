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
            <i class="pe-7s-file"></i><h3>Mantención de Perfiles</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "id", "placeholder" => "Id", 'readonly' => true]);?>
         <label for="descripcion" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("descripcion", ["size" => 50, "maxlength" => 100, "class" => "stacked-input upper", "id" => "descripcion", "placeholder" => "Descripción"]);?>

        <label for="menues" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
        <table border="1" style="border:1px solid white;padding:10px;">
		<tr><td>Disponibles</td>
		    <td></td>
			<td>Seleccionados</td>
		</tr>
        <tr><td><select name="origen" id="origen" size="15" style="color:black">
                <?php foreach($programas as $key => $val):?>
                     <option value='<?=$key?>'><?=$val?></option>
                <?php endforeach;?>
                </select>
            </td>
			<td style="vertical-align:middle;padding:10px"><table  border="1">
			    <tr><td><input type='button' value='>>' id="envia"   style='color:black;'></td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td><input type='button' value='<<' id="remueve" style='color:black;'></td></tr>
			    </table>
            </td>
			<td>
			<select name="destino" id="destino" size="15" style="color:black">
                <?php foreach($seleccionado as $key => $val):?>
                     <option value='<?=$key?>'><?=$val?></option>
                <?php endforeach;?>
                </select>
			</td>
		</tr>
			
        </table>
<input type="hidden" name="listap" id="listap"/>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Perfiles/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#nombre").focus();

      
   document.getElementById("envia").onclick=function() {
	  origen = document.getElementById("origen");
	  destino = document.getElementById("destino");
	  
	  mueveListas(origen, destino);
   }
   
   document.getElementById("remueve").onclick=function() {
	  origen = document.getElementById("origen");
	  destino = document.getElementById("destino");
	  
	  mueveListas(destino, origen);
   }
   
   function mueveListas(source, dest) {
	  i = source.selectedIndex;
	  
	  if (i >=0) {
	     v = source.options[i].value;
	     t = source.options[i].text;
		 
		 //alert(v+","+t);
		 
		 var option = document.createElement("option");
         option.text = t;
		 option.value = v;
		 
         dest.add(option);
		 
		 source.remove(source.selectedIndex)
	  }
   }
   
   document.getElementById("frm").onsubmit=function() {
	  listap = "";
	  destino = document.getElementById("destino");
	  
	  for (i=0; i < destino.options.length; i++) {
		 if (listap!="") listap = listap + "|";
		 
		 listap = listap + destino.options[i].value;
	  }
	  
	  document.getElementById("listap").value = listap;
   }
   
</script>
