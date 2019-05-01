<?= $this->Form->create($gre, ["id" => "frm"]) ?>

<div class="col-md-8">
   <article class="widget widget__form">
      <header class="widget__header">
         <div class="widget__title">
            <i class="pe-7s-file"></i><h3>Mantención de Usuarios</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="username" class="stacked-label data-toggle="tooltip" title="Nombre de Usuario""><i class="pe-7s-user" ></i></label>
         <?=$this->Form->text("username", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "username", "placeholder" => "Nombre Usuario", "readonly" => true]);?>
         <label for="password" class="stacked-label data-toggle="tooltip" title="Contraseña""><i class="pe-7s-lock" ></i></label>
         <?=$this->Form->text("password", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "password", "placeholder" => "Contraseña", "readonly" => true]);?>
         <label for="idpers" class="stacked-label data-toggle="tooltip" title="Nombre de Persona""><i class="pe-mi-contacts-2" ></i></label>
		 <?=$this->Form->text("idpers", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "idpers", "value" => $personas[$gre->idpers], "readonly" => true]);?>
         <label for="idesre" class="stacked-label" style="clear:both;" data-toggle="tooltip" title="Estado"><i class="pe-7s-check"></i></label>
		 <?=$this->Form->text("idesre", ["size" => 100, "maxlength" => 100, "class" => "stacked-input upper", "id" => "idesre", "value" => $estados[$gre->idesre], "readonly" => true]);?>

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

<!--<?= $this->Form->button(__('Guardar')) ?>-->
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
        
<?php echo $extrajs;?>      
</script>
