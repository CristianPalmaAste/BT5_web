<style>
#chartdiv {
  width: 100%;
  height: 500px;
}
tr.odd td{
   color:#000000;
}
tr.even td{
   color:#000000;
}
</style>

<script>
/**
 * amCharts Plugin: handle empty pie chart
 */

var dataSet = <?php echo $jsonStats?>;

$(document).ready(function() {
    $('#example').DataTable( {
        data: dataSet,
        paging:   false,
        //ordering: false,
        info:     false,
        searching:false,
        order: [ 1, "desc" ],
        columns: [
            { title: "Tipo de Documento" },
            { title: "N° de documentos por tipo" },
            { title: "%" }
        ]
    } );
} );

AmCharts.addInitHandler(function(chart) {
   if (chart.dataProvider === undefined || chart.dataProvider.length === 0) {
      <?php echo $statsHtml?>
      chart.labelsEnabled = true;
      //alert(chart.data);
   }
},["pie"]);

var chart = AmCharts.makeChart("chartdiv", {
   "type": "pie",
   "theme": "light2",
   "colors": [],
   "dataProvider": [],
   "data" : dataSet,
   "titleField": "title",
   "valueField": "value",
   "urlField": "urlField",
   "colorField": "colorField",
   "labelRadius": 5,
   "color": "#FFFFFF",
   "radius": "25%",
   "innerRadius": "40%",
   "depth3D": 15,
   "angle": 15,
   "labelText": "[[title]]: [[percents]]%\n[[value]] documento(s)",
   "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%, )</span>",
});
</script>

<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>

<header class="main-header">
   <div class="main-header__nav">
      <h1 class="main-header__title">
         <i class="pe-7s-graph2"></i>
         <span>Gráficas</span>
      </h1>
   </div>
</header>

<div class="row">
   <div class="col-md-5">
      <article class="widget">
         <header class="widget__header">
            <div class="widget__title">
               <i class="pe-7s-graph"></i><h3>Documentos Legales por Tipo</h3>
            </div>
         </header>
         <div class="widget__content filled widget-ui">
            <div class="row">
               <div class="col-md-12 text-center">
                  <div id="chartdiv" style="width: 100%; height: 362px;"></div>
               </div>
            </div>
         </div>
      </article>
   </div>
</div>
<div class="row">
   <div class="col-md-5">
      <article class="widget">
         <header class="widget__header">
            <div class="widget__title">
               <i class="pe-7s-graph3"></i><h3>Tabla Estadística</h3>
            </div>
         </header>
         <div class="widget__content filled widget-ui">
            <div class="row">
               <table id="example" class="display" width="100%"></table>
            </div>
         </div>
      </article>
   </div>

</div>
