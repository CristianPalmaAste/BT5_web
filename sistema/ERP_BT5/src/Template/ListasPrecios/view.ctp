<?= $this->Form->create($gre, ["id" => "frm", "method" => "post"]) ?>
    <div class="widget__content">
	     <h1>Listas de Precios</h1><br/>
	     <table style="border:1px solid white;" border="1" cellspacing="1" cellpadding="1">
         <?=$this->Form->hidden("id", ["id" => "id"])?>
</td></tr>
         <?=$this->Form->hidden("idempr", ["id" => "idempr", "readonly" => true])?>
</td></tr>
<tr><td><label for='correlativo' >Correlativo*</label></td><td><?=$this->Form->text("correlativo", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper", "id" => "correlativo", 'style' => 'color:black;text-align:right;', 'readonly' => true]);?>
</td></tr>
<tr><td><label for='fechainicio' >Fecha Inicio*</label></td>
    <td><?=$this->Form->text("fechainicio", ["size" => 10, "maxlength" => 10, "class" => "stacked-input datepicker", "placeholder" => "dd-mm-aaaa", "id" => "fechainicio", "style" => "color:black;", "value" => $this->Time->format($gre->fechainicio,'d/MM/Y'), "readonly" => true]);?>
</td></tr>
<tr><td><label for='fechafin' >Fecha Fin</label></td>
<td><?=$this->Form->text("fechafin", ["size" => 10, "maxlength" => 10, "class" => "stacked-input datepicker", "placeholder" => "dd-mm-aaaa", "id" => "fechafin", "style" => "color:black;", "value" => $this->Time->format($gre->fechafin,'d/MM/Y'), "readonly" => true]);?>
</td></tr>
<tr><td><label for='observaciones' >Observaciones*</label></td><td><?=$this->Form->text("observaciones", ["size" => 50, "maxlength" => 1000, "class" => "stacked-input upper", "id" => "observaciones", 'style' => 'color:black;', "readonly" => true]);?>
</td></tr>
<tr><td><label for='idesre' >Estado*</label></td><td><?=$estados_registros[$gre->idesre]?>
</td></tr>
<tr><td colspan='2' align='center'><?php echo $grilla;?></td></tr>
<input type='hidden' id='nRow' value='<?=$nRow?>'/>
<input type='hidden' id='currentRow'/>
<input type='hidden' id='allRows' name='allRows'/>
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

      
<?php echo $extrajs;?></script>
