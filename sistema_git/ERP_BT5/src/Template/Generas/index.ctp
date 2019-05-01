<h3>Generas: Generador de código</h3>
<br/>


<div class="table-responsive">
<table class="table">

  <thead>
   <tr>
      <th >Seleccionar Tabla</th>
   </tr>
   </thead>

   <tbody>

<?php foreach($tablas as $g):?>
   <tr>
     <td style="background:white">
<?= $this->Html->link($g["table_name"], ['action' => 'gen_app', $g["table_name"]],array('escape' => false, 'title' => 'Generar')) ?>
</td>
   </tr>
<?php endforeach;?>



   </tbody>
</table>

<script language="javascript">
   function muestra() {
      tabla = document.getElementById("tabla");

      if (tabla.selectedIndex >=0)
         alert(tabla.value);
   }
</script>

</div>
