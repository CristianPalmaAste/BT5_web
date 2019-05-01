<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Event\Event;
use Cake\Datasource\ConnectionManager;
use Cake\Mailer\Email;

class UsuariosController extends AppController{
   public function initialize(){
      parent::initialize();
   }

   public function index(){
      $this->set('title', 'Acceso');
      $this->set("errores", []);

      $usuario = $this->Usuarios->newEntity();
      if ($this->request->is('post')) {
         $usuario = $this->Usuarios->patchEntity($usuario, $this->request->data);

         $conn = ConnectionManager::get('default');

         $username = strtoupper($usuario->username);
         $password = strtoupper($usuario->password);

         $stmt = $conn->execute("SELECT f_valida_usuario('$username', '$password') mensaje;");

         $results = $stmt ->fetchAll('assoc');

         $mensaje = $results[0]["mensaje"];

         if(substr($mensaje, 0, 1)=="N"){
            $this->Flash->set(substr($mensaje, 2),['class'=>'error']);
         }else{
            $usu = $this->Usuarios->find("all")->where("username='$username' and password='$password' and idusuaborraregistro is null")->toArray();

            $persona  = TableRegistry::get('Personas'); 

            $persData = $persona->get($usu[0]["idpers"]); 
            
			$empresa  = TableRegistry::get('Empresas'); 

            //return;

            $session = $this->request->session();
            $idusua  = $usu[0]["id"];

            $idpers  = $usu[0]["idpers"]; 
            
            //$persData= $usu->usuario_persona;

            $session->write('idusua',   $idusua);
            $session->write('idpers',   $idpers);
            $session->write('username', $usuario->username);
            $session->write('password', $usuario->password);
            $session->write('nombreCompleto', ucwords(strtolower($persData->primernombre.' '.$persData->segundonombre.' '.$persData->apellidopaterno.' '.$persData->apellidomaterno)));
            $session->write('nombreCorto', ucwords(strtolower($persData->primernombre.' '.$persData->apellidopaterno)));

            $uperfil = TableRegistry::get('Perfilamientov');
            $q = $uperfil->find('all')
               ->where(['username' => $username]);

            $q = $q->toArray();
			
			//print_r($q); return;

            //Vemos si tiene un solo perfil
            if (count($q)==1) {
               $idgrem = $q[0]["id_holding"];
               $idempr = $q[0]["id_empresa"];
               $idperf = $q[0]["id_perfil"];
			   
			   if ($idperf!="") $session->write('idperf', ltrim($idperf));
			   
			   if ($idgrem!="") $session->write('idgrem', ltrim($idgrem));
			   
			   if ($idempr!="") $session->write('idempr', ltrim($idempr));
			   			   
               $this->redirect(["controller" => "principales", "action" => "home"]);
               return;
               
            }else{
               $this->redirect(["controller" => "principales", "action" => "selPerfil"]);
               return;
            }
         }
      }
	  
	  //Aquí van las inicializaciones
   }

   public function recupContra() {
      $this->set('title', 'Cambio de Contraseña');
      $this->set("errores", []);

      $usuario = $this->Usuarios->newEntity();
      if ($this->request->is('post')) {
         $usuario = $this->Usuarios->patchEntity($usuario, $this->request->data);

         $usuario->username=strtoupper($usuario->username);


         $arr=$this->Usuarios->find('all')->where(["username" => $usuario->username]);

         foreach($arr as $r) {
            print_r($r);

            $email = new Email('default');
            $email->from(['solar2design@gmail.com' => 'My Site'])
            ->to('vchilem@gmail.com')
            ->subject('Recuperación de Contraseña')
            ->send('My message');


            $this->Flash->success(__('Nueva contraseña ha sido enviada a su correo.'));
	        return $this->redirect(['action' => 'index']);
         }


         $this->Flash->success(__('Usuario no encontrado.'));
         
      }
	  
	  
   }

   public function cambioContrasena() {
      //$this->set('title', 'Acceso');
      $this->set("errores", []);

      $session = $this->request->session();
      
      if (!$session->check("idusua")) {
         $this->redirect(["action" => "index"]);
         return;
      }

      $usuario = $this->Usuarios->newEntity();
      if ($this->request->is('post')) {
         $usuario = $this->Usuarios->patchEntity($usuario, $this->request->data);

         $usuario->username=strtoupper($usuario->username);
		 
		 //print_r($usuario); return;


         $arr=$this->Usuarios->find('all')->where(["username" => $usuario->username, "password" => $usuario->password, 'idusuaborraregistro is' => null]);

         //print_r($arr->toArray()); return;

         $data=array();
         foreach($arr as $r) {
            $data["id"] = $r->id;
            $data["username"]=$r->username;
            $data["password"]=$r->password;
         }

         if (count($data)==0) {
            $this->Flash->error(__('Combinación usuario/contraseña no encontrado.'));
         }
         else if ($usuario->password2!=$usuario->password3)          
            $this->Flash->error(__('Nueva contraseña y re-ingreso incorrectas.'));
         else if ($usuario->password==$usuario->password2)          
            $this->Flash->error(__('Nueva contraseña debe ser distinta a la antigua.'));
         else {
            $usu = $this->Usuarios->get($data["id"]);

            $usu->password=$usuario->password2;

            $this->Usuarios->save($usu);


            $this->Flash->success(__('Contraseña modificada.'));
	        $this->redirect(["action" => "logout"]); 
            return;
         }
      }
	  
	  $idusua = $session->read("idusua"); 
		 
	  //echo "Usuario: ".$idusua."<hr/>";
      $usuarios = $this->Usuarios->get($idusua);		 
		 
	  //print_r($usuarios);
		 
	  $this->set("Usuarios", $usuarios);
   }

   public function logout(){
      $session = $this->request->session();
      $session->delete("idusua");
      $session->destroy();
      $this->redirect(["controller" => "usuarios"]);
      return;
   }

   public function beforeFilter(Event $event){}
}
