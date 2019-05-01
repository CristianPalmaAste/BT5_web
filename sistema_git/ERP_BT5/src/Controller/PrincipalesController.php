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

      $usua = $this->Usuarios->get($idusua, ['contain' => ['UsuariosPerfiles.Perfiles','UsuarioPersona']])->toArray();
      $uspe = $this->UsuariosPerfiles->find('all',['contain' => ['Usuarios','Perfiles']])->where(['idusua' => $idusua])->toArray();

      $perfil = TableRegistry::get('UsuariosPerfiles');

      $q = $perfil->find("all")->where(['idusua' => $idusua])->order("idperf");

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

         $s = $perf->find("all")->where("id=$idperf")->toArray();

         $descripcion=$s[0]["descripcion"];

         $t = $per->find("all")->where(['id' => $idperf]);

         $t = $t->toArray();

         if ($idgrem!="")
            $gr = $gemp->find("all")->where(['id' => $idgrem])->order("id");
         else
            $gr = $gemp->find("all")->order("id");

         $gr = $gr->toArray();

         $grupos = [];

         foreach($gr as $rr) {
            $idgrem = $rr["id"];

            $empresas=[];
            $emps = $emp->find("all")->where(['idgrem' => $idgrem])->toArray();

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

   public function registrar($idperf, $idgrem, $idempr){
      $perf = TableRegistry::get('Perfiles');
      $empr = TableRegistry::get('Empresas');
      $p = $perf->find("all")->where(['id' => $idperf])->toArray();
      $e = $empr->find('all')->where(['id' => $idempr])->toArray();

      $session = $this->request->session();
      $session->write("idperf", $idperf);
      $session->write("idgrem", $idgrem);
      $session->write("idempr", $idempr);

      $session->write("empresa", $e[0]['nombrefantasia']);
      $session->write("empresa", $e[0]['razonsocial']);

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
