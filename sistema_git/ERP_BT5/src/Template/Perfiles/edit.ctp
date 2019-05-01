<?= $this->Form->create($gre) ?>
 
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
        <table>
        <tr><td><select name="menues" id="menues" class='stacked-input' style='width: calc(100% - 65px);display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;'>
                <?php foreach($progs as $p):?>
                     <option value='<?=$p["id"]?>'><?=$p["etiqueta"]?></option>
                <?php endforeach;?>
                </select>
            </td></tr>
        <tr><td><?php $n=0;?>
                <?php foreach($progs as $p):?>
                     <div id="lista<?=$p['id']?>" style="display:<?=($n>0?'none':'block')?>">
                        <table> 
                        <?php foreach($p["hijos"] as $h): ?>
                           <tr><td><input type='checkbox' name="programas[]" value='<?=$p["id"]?>.<?=$h["id"]?>' <?=$h["selected"]>0?"checked":""?>><?=$h["etiqueta"]?></td></tr>
                        <?php endforeach;?>
                        </table>
                     </div>
                <?php $n++?>
                <?php endforeach;?>
             </td></tr>
        </table>

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

   document.getElementById("menues").onchange=function() {
      lista = document.getElementById("menues");

      k = lista.value;

      for (i=0; i < lista.options.length; i++) 
         document.getElementById("lista"+lista.options[i].value).style.display="none";

      document.getElementById("lista"+k).style.display="block";
   }
      
</script>
