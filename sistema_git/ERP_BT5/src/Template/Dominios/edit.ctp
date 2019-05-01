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
            <i class="pe-7s-file"></i><h3>Mantención de Dominios</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="id" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("id", ["size" => 10, "maxlength" => 20, "class" => "stacked-input upper", "id" => "id", "placeholder" => "id", 'placeholder' => 'Id', "readonly" => true]);?>
         <label for="descripcion" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("descripcion", ["size" => 10, "maxlength" => 100, "class" => "stacked-input upper", "id" => "descripcion", "placeholder" => "descripcion", 'placeholder' => 'Descripción']);?>

<table border="1">
<tr><td><select id="lista" name="lista" size="10" style="width:250px" class="form-control">
        <?php foreach($lista as $l): ?>
        <option value='<?=$l->id?>'><?=$l->descripcion?></option> 
        <?php endforeach;?>
        </select>
    </td>
    <td><button>Up</button></td>
    <td valign="_top"><input type="text" id="val" name="val" size="20" maxlength="40"/></td>
    <td><button type="button" id="agregar">Agregar</button></td>
</tr>
</table>

<?= $this->Form->button(__('Guardar')) ?>
</div>

</article>
</div>

<input type="hidden" name="milista" id="milista"/>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
<div class="btn-group block">
<a href="<?=$this->request->webroot?>Dominios/index" class="btn dark inverse">Volver</a>
</div>
</div>

<script language="javascript">
$("#descripcion").focus();

   document.getElementById("agregar").onclick=function() {
      val = document.getElementById("val");

      if (val.value=="") return;

      select = document.getElementById("lista");

      select.options[select.options.length] = new Option(val.value, select.options.length);
 
      val.value="";
      val.focus();
   }

   document.getElementById("frm").onsubmit=function() {
      milista="";

      lista = document.getElementById("lista");

      for (i=0; i < lista.options.length; i++) {
         if (milista!="") milista = milista + "|";

         milista = milista + lista.options[i].text;
         
      }

      //alert(milista);
      document.getElementById("milista").value = milista;
      return true;
   }


</script>
