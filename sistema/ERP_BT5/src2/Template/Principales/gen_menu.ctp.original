<?php
$session = $this->request->session();
$idperf  = $session->read("idperf");
if( $idperf > 0 ){
   $idusua      = $session->read("idusua");
   $nombreCorto = $session->read("nombreCorto");
?>
<div class="wrapper">
   <aside class="sidebar">
      <div class="user-info">
         <figure class="rounded-image profile__img">
            <img class="media-object" src="<?=$this->request->webroot?>img/profile_<?=$idusua?>.jpg" alt="user">
         </figure>
         <h2 class="user-info__name"><?=$nombreCorto?></h2>
         <h3 class="user-info__role">Admin Manager</h3>
         <ul class="user-info__numbers">
         </ul>
      </div>

      <ul class="main-nav">
      <?php foreach( $menu as $idProgPadre => $titulo ): ?>
         <li class="main-nav--collapsible">
            <a class="main-nav__link" href="/principales/gen-menu/<?=$idProgPadre?>" onclick="return false;">
               <span class="main-nav__icon"><i class="pe-7f-monitor"></i></span>
               <?=$titulo?><span class="badge badge--line badge--blue"><?=count($subMenu[$idProgPadre])?></span>
            </a>
            <ul class="main-nav__submenu">
            <?php foreach( $subMenu[$idProgPadre] as $idPP => $infoMenu ): ?>
               <li>
                  <?=$this->Html->link($infoMenu['titulo'], '/usuarios/logout', ['class' => 'nav-link']);?>
               </li>
            <?php endforeach; ?>
            </ul>
         </li>
      <?php endforeach; ?>
      </ul>
   </aside>
<?php
}
?>



