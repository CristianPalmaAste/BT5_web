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

 
	  <h1>Cotizaciones Compras</h1><br/>
         <?=$this->Form->hidden("idempr", ["id" => "idempr"])?>
		 <?=$this->Form->hidden("idorco", ["id" => "idorco"])?>
		 <?=$this->Form->hidden("idrequ", ["id" => "idrequ"])?>
		 <?=$this->Form->hidden("nombreoriginal", ["id" => "nombreoriginal"])?>
		 <?=$this->Form->hidden("nombresistema",  ["id" => "nombresistema"])?>
		 
	  <table style="border:1px solid white;" border="2" cellspacing="1" cellpadding="1">
        <tr><td><label for='correlativo' >Id*</label></td>
        <td><?=$this->Form->text("id", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "id", 'style' => 'color:black;text-align:right', 'readonly' => true]);?>
		&nbsp;&nbsp;<label for='correlativo' >Requisición</label>&nbsp;
		
		<?=$this->Form->text("requisicion_no", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "requisicion_no", 'style' => 'color:black;text-align:right', 'readonly' => true]);?>
		
        &nbsp;&nbsp;<label for='correlativo' >Orden de Compra</label>&nbsp;
		
		<?=$this->Form->text("oc_no", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "oc_no", 'style' => 'color:black;text-align:right', 'readonly' => true]);?>
		
		</td></tr>
		
		<tr><td><label for='idprov' >Fecha</label></td>
		<td><?=$this->Form->text("fecha", ["size" => 15, "maxlength" => 20, "class" => "stacked-input upper", "id" => "fecha", 'style' => 'color:black;', 'readonly' => true]);?></td></tr>
		
        <tr><td><label for='idprov' >Proveedor*</label></td>
		<td><?=$this->Form->select("idprov", $proveedores, [ "id" => "idprov", "style" => "color:black;", "disabled" => true]);?>
		</td>
		</tr>
		
		<tr><td><label for='idprov' >Observaciones</label></td>
		<td><?=$this->Form->text("observaciones", ["size" => 100, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "observaciones", 'style' => 'color:black;', 'readonly' => true ]);?></td></tr>
			      

 <tr><td colspan='2' align="center">

<table class="table table-bordered" id='mitabla' border='1' style='border:1px solid white;'>
<tr>
<th>Producto</th>
<th>Descripción</th>
<th>U.Med.</th>
<th>Servicio</th>
<th>Descripción</th>
<th>U.Med.</th>
<th>Otro insumo</th>
<th>Cantidad</th>
<th>Precio Unitario</th>
</tr>

<?php $i=0; ?>
<?php foreach($rows as $r): ?>
<tr>
<td><?=$r["producto"]?></td>
<td><?=$r["desproducto"]?></td>
<td><?=$r["idunmp"]?></td>
<td align='right'><?=$r["idserv"]?></td>
<td><?=$r["desservicio"]?></td>
<td><?=$r["idunms"]?></td>
<td><?=$r["otroinsumo"]?></td>
<td align='right'><?=$r["cantidad"]?></td>
<td align='right'><input type="text" id="preciounitario<?=$i?>" name="preciounitario<?=$i?>" value="<?=$r["preciounitario"]?>" size="11" maxlength="11" style="color:black; text-align:right" readonly/></td>
<input type='hidden' id='idprod<?=$i?>' name='idprod<?=$i?>' value='<?=$r["idprod"]?>'/>
<input type='hidden' id='idserv<?=$i?>' name='idserv<?=$i?>' value='<?=$r["idserv"]?>'/>
<input type='hidden' id='otroinsumo<?=$i?>' name='otroinsumo<?=$i?>' value='<?=$r["otroinsumo"]?>'/>
<input type='hidden' id='cantidad<?=$i?>' name='cantidad<?=$i?>' value='<?=$r["cantidad"]?>'/>
</tr>
<?php $i=$i + 1;?>
<?php endforeach; ?>
<input type="hidden" id="nRows" name="nRows" value="<?=$i?>"/>
</table>

		 
<?= $this->Form->end() ?>
<div class="col-md-8 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>CotizacionesCompras/index" class="btn dark inverse">Volver</a>
</div>
</div>

<?=$this->Html->script('valrut.js');?>
<?=$this->Html->script('valdate.js');?>

<script language="javascript">

      
   
</script>
