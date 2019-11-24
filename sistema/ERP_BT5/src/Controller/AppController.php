<?php
/**
 * CakePHP(tm) : Rapid Development Framework (http://cakephp.org)
 * Copyright (c) Cake Software Foundation, Inc. (http://cakefoundation.org)
 *
 * Licensed under The MIT License
 * For full copyright and license information, please see the LICENSE.txt
 * Redistributions of files must retain the above copyright notice.
 *
 * @copyright Copyright (c) Cake Software Foundation, Inc. (http://cakefoundation.org)
 * @link      http://cakephp.org CakePHP(tm) Project
 * @since     0.2.9
 * @license   http://www.opensource.org/licenses/mit-license.php MIT License
 */
namespace App\Controller;

use Cake\Controller\Controller;
use Cake\Event\Event;
use Cake\ORM\TableRegistry;

use Cake\I18n\Time;
use Cake\Database\Type;
Time::$defaultLocale = 'es-CL';
Time::setToStringFormat('dd-MM-YYYY');
Type::build('datetime')->useLocaleParser();

/**
 * Application Controller
 *
 * Add your application-wide methods in the class below, your controllers
 * will inherit them.
 *
 * @link http://book.cakephp.org/3.0/en/controllers.html#the-app-controller
 */
class AppController extends Controller{

   /**
   * Initialization hook method.
   *
   * Use this method to add common initialization code like loading components.
   *
   * e.g. `$this->loadComponent('Security');`
   *
   * @return void
   */
   public function initialize(){
      parent::initialize();

      $this->loadComponent('RequestHandler');
      $this->loadComponent('Flash');

      /*
      * Enable the following components for recommended CakePHP security settings.
      * see http://book.cakephp.org/3.0/en/controllers/components/security.html
      */
      //$this->loadComponent('Security');
      //$this->loadComponent('Csrf');

      $session = $this->request->session();
	  $idgrem = $session->read("idgrem");
	  $idusua = $session->read("idusua");
	  
	  //echo "Usuario: '$idusua'<br/>";

      if($session->check("idusua")){
         $this->genMenu();
      }

   }

   public function translateAccents( $text ){
      $unwanted_array = array( 'Š'=>'S', 'š'=>'s', 'Ž'=>'Z', 'ž'=>'z', 'À'=>'A', 'Á'=>'A', 'Â'=>'A', 'Ã'=>'A', 'Ä'=>'A', 'Å'=>'A', 'Æ'=>'A', 'Ç'=>'C', 'È'=>'E', 'É'=>'E',
      'Ê'=>'E', 'Ë'=>'E', 'Ì'=>'I', 'Í'=>'I', 'Î'=>'I', 'Ï'=>'I', 'Ñ'=>'N', 'Ò'=>'O', 'Ó'=>'O', 'Ô'=>'O', 'Õ'=>'O', 'Ö'=>'O', 'Ø'=>'O', 'Ù'=>'U',
      'Ú'=>'U', 'Û'=>'U', 'Ü'=>'U', 'Ý'=>'Y', 'Þ'=>'B', 'ß'=>'Ss', 'à'=>'a', 'á'=>'a', 'â'=>'a', 'ã'=>'a', 'ä'=>'a', 'å'=>'a', 'æ'=>'a', 'ç'=>'c',
      'è'=>'e', 'é'=>'e', 'ê'=>'e', 'ë'=>'e', 'ì'=>'i', 'í'=>'i', 'î'=>'i', 'ï'=>'i', 'ð'=>'o', 'ñ'=>'n', 'ò'=>'o', 'ó'=>'o', 'ô'=>'o', 'õ'=>'o',
      'ö'=>'o', 'ø'=>'o', 'ù'=>'u', 'ú'=>'u', 'û'=>'u', 'ý'=>'y', 'þ'=>'b', 'ÿ'=>'y' );
      return strtr( $text, $unwanted_array );
   }

   public function genMenu($idMenuActivo=null){
      $session = $this->request->session();
	  $idusua = $session->read("idusua");

      if ($session->check("idusua"))
         $this->set("connected", true);
      else
         $this->redirect(["controller" => "usuarios"]);

      $idperf = $session->read("idperf");
	  
	  $idusua = $session->read("idusua");
	  
	  if ($idperf=="") return;
	  
	  //echo "Perfil: ".$idperf." ".$idusua."<br/>";return;
	  
	  /*
	  $usuaperf = TableRegistry::get('UsuariosPerfiles');
	  
	  $results = $usuaperf->find('all')->where(["idusua" => $idusua])->toArray();
	  
	  if (count($results)==1) {
		 $idempr=$results[0]["idempr"];
		 $idgrem=$results[0]["idgrem"];
		 
		 $this->redirect("/principales/registrar/$idperf/$idgrem/$idempr");
		 return;
	  }
	  */
	  
	  

      $per  = TableRegistry::get('PerfilesProgramas');
      $prog = TableRegistry::get('Programas');

      $q = $per->find("all")->where(["idperf" => $idperf]);
	  $programas=[];
	  
	  foreach($q as $r)
	     $programas[] = $r["idprog"];

      $menu = [];
      $subMenu = [];
	  
	  $pp = $prog->find('all')->where(["id IN" => $programas])->order('peso');

	  //print_r($programas);
	  //print_r($pp); return;
	  
      foreach($pp as $s) {
		 //echo $s["id"]."<hr/>";
         $idprog = $s["id"];

         //$s = $prog->find("all")->where(["id" => $idprog])->order(["peso"])->toArray();

         if ($s["idprogpadre"]!=""){
            $subMenu[$s["idprogpadre"]][$idprog] = ["idprog" => $idprog, "titulo" => $s["titulo"], "idprogpadre" => $s["idprogpadre"], 'link' => $s["link"]];
            if( $this->request->url == $s[0]['link'] ){
               $idMenuActivo = $s["idprogpadre"];
            }
         }else{
            $menu[$idprog] = $s["titulo"];
         }
      }
	  //print_r($menu);
	  //print_r($subMenu);
	  //return;

      if ($idMenuActivo==null) {
         $this->set("idMenuActivo", 0);
      }else{
         $this->set("idMenuActivo", $idMenuActivo);
      }

      $this->set("subMenu", $subMenu);
      $this->set("menu", $menu);
   }


   /**
   * Before render callback.
   *
   * @param \Cake\Event\Event $event The beforeRender event.
   * @return \Cake\Network\Response|null|void
   */
   public function beforeRender(Event $event)
   {
      if (!array_key_exists('_serialize', $this->viewVars) &&
         in_array($this->response->type(), ['application/json', 'application/xml'])
      ) {
         $this->set('_serialize', true);
      }
	  
   }

   public function beforeFilter(Event $event) {
      parent::beforeFilter($event);

      $session = $this->request->session();

      if (!$session->check("idusua")){
         $this->redirect(["controller" => "usuarios"]);
      }
   }
}
