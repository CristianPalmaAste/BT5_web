<?php
namespace App\View\Helper;

use Cake\View\Helper;

class BFormHelper extends Helper{
   public function initForm( $text = null, $cols = null ){
      $html = '';
      if( $cols != null ){
         $html = "
         <div class='row'>
         <div class='col-md-12'>
            <article class='widget widget__form'>
               <header class='widget__header'>
                  <div class='widget__title'>
                     <i class='pe-7s-menu'></i><h3>$text</h3>
                  </div>
               </header>

               <div class='widget__content table-responsive'>
                  <table class='table table-striped media-table'>
                     <thead>
                        <tr>";
         foreach( $cols as $col ){
            $html .= "<th>$col</th>";
         }
            $html .= "
                        </tr>
                     </thead>
                     <tbody>
                        <tr class='spacer'></tr>
         ";
      }
      return $html;
   }
   public function closeForm(){
      $html = "
                     </tbody>
                  </table>
               </div>
            </article>
            </div>
            </div>
            ";
      return $html;
   }

   public function formHeader( $titulo = null, $icon = 'pe-7f-note2' ){
      $html = '';
      if( $titulo != null ){
         $html .= "
            <header class='main-header'>
               <div class='main-header__nav'>
                  <h1 class='main-header__title'>
                     <i class='$icon'></i>
                     <span>$titulo</span>
                  </h1>
               </div>
            </header>
         ";
      }
      return $html;
   }
}
