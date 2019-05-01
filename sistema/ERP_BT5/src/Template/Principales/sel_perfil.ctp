<header class="top-bar">
   <ul class="profile">
      <li>
         <a href="<?=$this->request->webroot?>usuarios/logout" class="btn-circle btn-sm">
            <i class="pe-7f-power"></i>
            <span class="badge badge--blue"></span>
         </a>
      </li>
   </ul>
   <div class="topFill">&nbsp;</div>
   <div class="main-brand">
      <div class="main-brand__container">
         <div class="main-logo"><img src="<?=$this->request->webroot?>img/gestio_logo_small.png"></div>
      </div>
   </div>
</header>

<section class="content">
   <header class="main-header">
      <div class="main-header__nav">
         <h1 class="main-header__title">
            <i class="pe-7s-menu"></i>
            <span>Selecci&oacute;n de Perfiles</span>
         </h1>
      </div>
   </header>

   <div class="row">
      <div class="col-md-3"></div>
      <div class="col-md-6">
         <div class="widget__content table-responsive">
            <table class='table table-striped media-table'>
               <thead>
                  <th>Grupo Empresarial</th>
                  <th>Empresa</th>
                  <th>Perfil</th>
               </thead>
               <tbody>
            <?php foreach($perfiles as $p): ?>
                  <tr class="spacer"></tr>
            <?php
               $enlace = $this->request->webroot."principales/registrar/".trim($p["idperf"])."/".trim($p["idgrem"])."/".trim($p["idempr"]);
            ?>
                  <tr>
                     <td><?=$p["holding"]?></td>
                     <td><?=$p["empresa"]?></td>
                     <td><a style="color:#FFFFFF;text-decoration: underline;font-size:18px;" href="<?=$enlace?>"><?=$p["perfil"]?></a></td>
                  </tr>
               <?php endforeach;?>
               </tbody>
            </table>
         </div>

      </div>
      <div class="col-md-3"></div>
   </div>
</section>