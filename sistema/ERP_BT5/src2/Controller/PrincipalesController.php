<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;

class PrincipalesController extends AppController{
   public function initialize(){
      parent::initialize();
      $this->loadModel('Usuarios');
      $this->loadModel('Perfiles');
      $this->loadModel('UsuariosPerfiles');
   }

   public function index(){
      $session = $this->request->session();

      if (!$session->check("username")) {
         $this->redirect(["controller" => "usuarios"]);
         return;
      }
   }

   public function selPerfil() {
      $session = $this->request->session();

      if (!$session->check("idusua")) {
         $this->redirect(["controller" => "usuarios"]);
         return;
      }

      $idusua = $session->read("idusua");
      $session->delete("idperf");
      $session->delete("idgrem");
      $session->delete("idempr");

      $usuario = TableRegistry::get('Usuarios');
      $perfil = TableRegistry::get('Perfilamientov');

      $username = $usuario->get($idusua)->username;

      //$usua = $this->Usuarios->get($idusua, ['contain' => ['UsuariosPerfiles.Perfiles','UsuarioPersona']])->toArray();
      //$uspe = $this->UsuariosPerfiles->find('all',['contain' => ['Usuarios','Perfiles']])->where(['idusua' => $idusua])->toArray();

      $q = $perfil->find("all")->where(['username' => $username])->order("id_perfil");


      $l=[];
	  foreach($q as $p) {
		 $l[] = ["idgrem" => $p->id_holding, "holding" => $p->holding,
		         "idempr" => $p->id_empresa, "empresa" => $p->empresa,
				 "idperf" => $p->id_perfil,  "perfil"  => $p->perfil
				];
	  }

      $this->set("perfiles", $l);
   }

   public function selPerfilOld() {
      $session = $this->request->session();

      if (!$session->check("idusua")) {
         $this->redirect(["controller" => "usuarios"]);
         return;
      }

      $idusua = $session->read("idusua");
      $session->delete("idperf");
      $session->delete("idgrem");
      $session->delete("idempr");
      $perfil = TableRegistry::get('UsuariosPerfiles');

      $q = $perfil->find("all")->where(['idusua' => $idusua, 'idusuaborraregistro is' => null])->order("idperf");

      $q = $q->toArray();

      $arreglo=array();

      $per= TableRegistry::get('Perfiles');

      $gemp = TableRegistry::get('GruposEmpresariales');

      $emp = TableRegistry::get('Empresas');

      $perf = TableRegistry::get('Perfiles');

      foreach($q as $r) {
         $idperf=$r["idperf"];
         $idgrem=$r["idgrem"];
         $idempr=$r["idempr"];

		 if ($idgrem=="" && $idempr!="") {
			$e = $emp->get($idempr);

			$idgrem = $e->idgrem;
		 }

         $s = $perf->find("all")->where(['id' => $idperf])->toArray();

         $descripcion=$s[0]["descripcion"];

         $t = $per->find("all")->where(['id' => $idperf]);

         $t = $t->toArray();

         if ($idgrem!="")
            $gr = $gemp->find("all")->where(['id' => $idgrem, 'idusuaborraregistro is' => null])->order("id");
         else
            $gr = $gemp->find("all")->where(['idusuaborraregistro is' => null])->order("id");

         $gr = $gr->toArray();

		 //print_r($gr); return;
		 
         $grupos = [];

         foreach($gr as $rr) {
            $idgrem = $rr["id"];

            $empresas=[];
            $emps = $emp->find("all")->where(['idgrem' => $idgrem, 'idusuaborraregistro is' => null])->toArray();

            foreach($emps as $e) {
               $empresas[] = [
                     'id'           => $e['id'],
                     'razonsocial'  => $e['razonsocial']
               ];
            }

            $grupos[] = [
                  "id" => $rr["id"],
                  "nombre" => $rr["nombre"],
                  "empresas" => $empresas
               ];
         }

         $arreglo[] = ['idperf' => $idperf, 'descripcion' => $descripcion, 'grupos' => $grupos];

      }

      $this->set("perfiles", $arreglo);
  }

   public function registrar($idperf, $idgrem=null, $idempr=null){
      $perf = TableRegistry::get('Perfiles');
      $empr = TableRegistry::get('Empresas');
      $p = $perf->find("all")->where(['id' => $idperf])->toArray();

      if ($idempr!=null){
         $e = $empr->find('all')->where(['id' => $idempr])->toArray();
      }

      $session = $this->request->session();
      $session->write("idperf", ltrim($idperf));
      $session->write("idgrem", ltrim($idgrem));

      if ($idempr!=null) {
         $session->write("idempr", ltrim($idempr));
         //$session->write("empresa", $e[0]['nombrefantasia']);
         $session->write("empresa", $e[0]['razonsocial']);
      }else{
         $session->write("idempr", null);
         $session->write("empresa", null);
      }

      $session->write("perfil", ucwords(strtolower($p[0]['descripcion'])));

      $this->redirect(['action' => 'home']);
   }

   public function home($mensaje=null){
   }

   public function genMenu($idmenu=null) {
	   parent::genMenu($idmenu);
   }

   public function enConstruccion(){}
}
