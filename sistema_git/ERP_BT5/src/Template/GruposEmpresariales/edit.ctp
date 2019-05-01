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
               echo "<div class=\"panel-body\">$v</div>";
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
            <i class="pe-7s-file"></i><h3>Grupos Empresariales</h3>
         </div>
      </header>

      <div class="widget__content">
         <label for="nombre" class="stacked-label"><i class="pe-7s-hammer" ></i></label>
         <?=$this->Form->text("nombre", ["size" => 50, "maxlength" => 100, "class" => "stacked-input upper", "id" => "nombre", "placeholder" => "Nombre"]);?>
         <label for="alias" class="stacked-label"><i class="pe-7s-wallet" ></i></label>
         <?=$this->Form->text("alias", ["size" => 10, "maxlength" => 10, "class" => "stacked-input upper","id" => "alias", "placeholder" => "Alias"]);?>
         <label for="icono" class="stacked-label"><i class="pe-7s-id"     ></i></label>
         <?=$this->Form->text("icono", ["size" => 20, "maxlength" => 20, "class" => "stacked-input upper","id" => "icono", "placeholder" => "Ícono"]);?>
         <label for="idpais" class="stacked-label"><i class="pe-7s-id"     ></i></label>
         <?=$this->Form->select("idpais", $paises, ["class" => "input select required", "id" => "idpais", "style" => "width: calc(100% - 65px);display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;"]);?>
         <label for="idesge" class="stacked-label"><i class="pe-7s-comment"></i></label>
         <?=$this->Form->select("idesge", $egrem, ["class" => "input select required", "id" => "idesge", "style" => "width: calc(100% - 65px);display: inline-block;height: 64px;text-color:rgb(255,255,255);background-color:rgba(0, 0, 0, 0.25);clear:right;"]);?>


 
         <?= $this->Form->button(__('Guardar')) ?>
      </div>
         <?=$this->Form->hidden("id");?>
   </article>
</div>

<?= $this->Form->end() ?>

<div class="col-md-6 text-center btn-vars__showcase">
   <div class="btn-group block">
      <a href="<?=$this->request->webroot?>grupos-empresariales/index" class="btn dark inverse">Volver</a>
   </div>
</div>

<script language="javascript">
   $("#nombre").focus();

   $(function() {
       $('.upper').keyup(function() {
           this.value = this.value.toUpperCase();
       });
   });
</script>

