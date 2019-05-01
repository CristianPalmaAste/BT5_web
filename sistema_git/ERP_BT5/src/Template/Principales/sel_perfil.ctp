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
         <div class="main-logo"><img src="<?=$this->request->webroot?>img/bt5_logo_small.png"></div>
      </div>
   </div>
</header>

<section class="content">
   <header class="main-header">
      <div class="main-header__nav">
         <h1 class="main-header__title">
            <i class="pe-7s-menu"></i>
            <span>Selecci&oacute;n de Perfil y Empresa</span>
         </h1>
      </div>
   </header>

   <?php for($i=0; $i < count($perfiles); $i++): ?>
   <?php $key=$perfiles[$i]["idperf"];
      $val=$perfiles[$i]["descripcion"];
      $grupos=$perfiles[$i]["grupos"];
   ?>
   <div class="row">
      <div class="col-md-7">
         <article class="widget">
            <header class="widget__header">
               <div class="widget__title">
                  <i class="pe-7g-user"></i>
                  <h3><?=$val?></h3>
               </div>
            </header>

            <?php foreach($grupos as $g): ?>
            <?php $empresas=$g["empresas"];?>

            <div class="widget__content">
               <div class="members__container">
                  <!--div class="media message checked"-->
                     <div class="media-body">
                        <p class="message__location">&nbsp;</p>
                        <div class="message__details">
                           <div class="dropdown open">
                              <button class="btn btn-block dark inverse dropdown-toggle" type="button" id="dropdownMenu<?=$g['id']?>" data-toggle="dropdown">GRUPO EMPRESARIAL <?=$g["nombre"]?>
                                 <span class="caret">
                                    <i class="pe-7g-arrow2-down"></i>
                                 </span>
                              </button>
                              <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu<?=$g['id']?>">
                                 <?php foreach($empresas as $e):?>
                                 <li role="presentation"><a role="menuitem" tabindex="-1" href="<?=$this->request->webroot. 'principales/registrar/'.$key.'/'.$g['id'].'/'.$e['id'];?>"><?=$e["razonsocial"]?></a></li>
                                 <?php endforeach;?>
                              </ul>
                           </div>
                        </div>
                     </div>
                  <!--/div-->
               </div>
            </div>
            <?php endforeach;?>
         </article>
      </div>
   </div>
   <?php endfor; ?>
</section>