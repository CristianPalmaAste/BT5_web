<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;
use Cake\Log\Log;


class MantUsuariosController extends AppController
{
    public function index()
    {
        $this->Usuarios = TableRegistry::get('Usuarios');  
        $personas = TableRegistry::get('Personas'); 

        $session = $this->request->session();
        $idgrem = $session->read("idgrem");
        $idempr = $session->read("idempr");

        $gre = $this->Usuarios->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->Usuarios->patchEntity($gre, $this->request->data);
        }             

        $cond = ["idusuaborraregistro is" => null];

           if ($gre->id!=null)
      $cond["id"] = $gre->id;
   if ($gre->username!=null)
      $cond["username like"] = $gre->username."%";
   if ($gre->password!=null)
      $cond["password like"] = $gre->password."%";
   if ($gre->idpers!=null)
      $cond["idpers"] = $gre->idpers;
   if ($gre->idesre!=null)
      $cond["idesre"] = $gre->idesre;

 
        $Usuarios = $this->paginate($this->Usuarios->find('all')->where($cond));

        $this->set("registros", $Usuarios); 

        $arr = $personas->find('all')->where("idgrem=$idgrem")->order(["apellidopaterno","apellidomaterno","primernombre","segundonombre"]);

        $lista=[];
        foreach($arr as $r) 
           $lista[$r->id] = $r->apellidopaterno." ".$r->apellidomaterno." ".$r->primernombre." ".$r->segundonombre;

        $this->set("personas", $lista);
    }

    public function add() {
       $this->render("edit");

       $session = $this->request->session();
       $idgrem = $session->read("idgrem");
       $idempr = $session->read("idempr");

       $this->Usuarios = TableRegistry::get('Usuarios'); 

       $gre = $this->Usuarios->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('usua_seq');");

         $results = $stmt ->fetchAll('assoc');

         $this->request->data["id"] = $results[0]["nextval"];

         //print_r($this->request);

	     $gre = $this->Usuarios->patchEntity($gre, $this->request->data);
         $gre->id = $results[0]["nextval"];
         $gre->idgrem = $idgrem;

         $idperfs = $_REQUEST["idperfs"];

         //print_r($idperfs); return;

	     if ($this->Usuarios->save($gre)) {

             $tbl = TableRegistry::get('UsuariosPerfiles'); 

             foreach($idperfs as $p) {
                $gg = $tbl->newEntity();

                $stmt = $conn->execute("SELECT NEXTVAL('uspe_seq')");

                $results = $stmt ->fetchAll('assoc');

                $gg->id     = $results[0]["nextval"];
                $gg->idusua = $gre->id;
                $gg->idperf = $p;
                
                if ($gg->idperf==1) {
                   $gg->idgrem = null; 
                   $gg->idempr = null;
                }
                else if ($gg->idperf==2) {
                   $gg->idgrem = $gre->idgrem; 
                   $gg->idempr = null;
                }
                else {
                   $gg->idgrem = null; 
                   $gg->idempr = $idempr;
                }
                   
                $gg->idesre = 1;
                $gg->idusuacrearegistro = $session->read("idusua");
                $gg->fechacrearegistro  = date('Y-m-d H:i:s');

                //print_r($gg);

                $tbl->save($gg); 
             }


	        $this->Flash->success(__('Registro ha sido creado.'));
	        return $this->redirect(['action' => 'index']);
	     }

         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));
	   }

       $gre->idgrem=$idgrem;
       $gre->idesre=1;

       $this->set('gre', $gre);

        $personas  = TableRegistry::get('Personas'); 
        $arr = $personas->find('all')->where("idgrem=$idgrem")->order(["apellidopaterno","apellidomaterno","primernombre","segundonombre"]);

        $lista=[];
        $lista[]="Seleccione persona";
        foreach($arr as $r) 
           $lista[$r->id] = $r->apellidopaterno." ".$r->apellidomaterno." ".$r->primernombre." ".$r->segundonombre;

        $this->set("personas", $lista);

        

        $estados  = TableRegistry::get('EstadosRegistros'); 
        $arr2 = $estados->find('all')->order("descripcion");

        $lista2=[];
        $lista2[]="Seleccione";
        foreach($arr2 as $rr) 
           $lista2[$rr->id] = $rr->descripcion;

        //print_r($lista2);

        $this->set("estados", $lista2);

        $perfiles  = TableRegistry::get('Perfiles'); 
        $arr2 = $perfiles->find('all')->order("descripcion");
        $lista2=[];
        $lista2[]="Seleccione";
        foreach($arr2 as $rr) 
           $lista2[$rr->id] = $rr->descripcion;

        //print_r($lista2);

        $this->set("perfiles", $arr2);

        $profiles  = TableRegistry::get('UsuariosPerfiles'); 
        $arr2 = $profiles->find('all')->where(["idusua" => $id])->order("id");

        //print_r($arr2);
 
        $lista2=[];
        foreach($arr2 as $rr) 
           $lista2[] = $rr->idperf;

        $this->set("profiles", $lista2);



        $this->render("edit");
        
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $idgrem = $session->read("idgrem");
       $idempr = $session->read("idempr");

       $this->Usuarios = TableRegistry::get('Usuarios');  

       $gre = $this->Usuarios->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
          $this->request->data["idusuamodifregistro"] = $session->read("idusua");
          
          $this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');

	      $this->Usuarios->patchEntity($gre, $this->request->data);

          $idperfs = $_REQUEST["idperfs"]; 

          //print_r($idperfs); return;

	      if ($this->Usuarios->save($gre)) {  
             $conn = ConnectionManager::get('default');

             $stmt = $conn->execute("delete from usuarios_perfiles where idusua=$id");

             $tbl = TableRegistry::get('UsuariosPerfiles'); 

             foreach($idperfs as $p) {
                $gg = $tbl->newEntity();

                $stmt = $conn->execute("SELECT NEXTVAL('uspe_seq')");

                $results = $stmt ->fetchAll('assoc');

                $gg->id     = $results[0]["nextval"];
                $gg->idusua = $gre->id;
                $gg->idperf = $p;
                //$gg->idgrem = $gre->idgrem; 
                //$gg->idempr = $idempr;
                $gg->idesre = 1;

                if ($gg->idperf==1) {
                   $gg->idgrem = null; 
                   $gg->idempr = null;
                }
                else if ($gg->idperf==2) {
                   $gg->idgrem = $gre->idgrem; 
                   $gg->idempr = null;
                }
                else {
                   $gg->idgrem = null; 
                   $gg->idempr = $idempr;
                }

                //print_r($gg);

                $gg->idusuacrearegistro = $session->read("idusua");
                $gg->fechacrearegistro  = date('Y-m-d H:i:s');

                $tbl->save($gg); 
             }

             //return;

	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          $this->set("errors", $gre->errors());
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);

        $personas  = TableRegistry::get('Personas'); 
        $arr = $personas->find('all')->where("idgrem=$idgrem")->order(["apellidopaterno","apellidomaterno","primernombre","segundonombre"]);

        $lista=[];
        foreach($arr as $r) 
           $lista[$r->id] = $r->apellidopaterno." ".$r->apellidomaterno." ".$r->primernombre." ".$r->segundonombre;

        $this->set("personas", $lista);

        $estados  = TableRegistry::get('EstadosRegistros'); 
        $arr = $estados->find('all')->order("descripcion");

        $lista=[];
        foreach($arr as $r) 
           $lista[$r->id] = $r->descripcion;

        $this->set("estados", $lista);

        $perfiles  = TableRegistry::get('Perfiles'); 
        $arr2 = $perfiles->find('all')->order("descripcion");
        $lista2=[];
        $lista2[]="Seleccione";
        foreach($arr2 as $rr) 
           $lista2[$rr->id] = $rr->descripcion;

        //print_r($lista2);

        $this->set("perfiles", $arr2);

        $profiles  = TableRegistry::get('UsuariosPerfiles'); 
        $arr2 = $profiles->find('all')->where(["idusua" => $id])->order("id");

        //print_r($arr2);
 
        $lista2=[];
        foreach($arr2 as $rr) 
           $lista2[] = $rr->idperf;

        $this->set("profiles", $lista2);

    }

    public function view($id=null) {
       $gre = $this->Usuarios->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);

       /*
       $egrem = TableRegistry::get('EstadosGrem');
       $pais  = TableRegistry::get('Paises');
       
       $this->set("paises", $pais->obtPaises());

       $this->set("egrem", $egrem->obtEstadosGrem());
       */

    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->Usuarios->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->Usuarios->save($registro);

       return $this->redirect(['action' => 'index']);

    }

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=datos.csv');

       // create a file pointer connected to the output stream
       $output = fopen('php://output', 'w');


       $egrem = TableRegistry::get('EstadosGrem');
       $pais  = TableRegistry::get('Paises');
       
       $paises = $pais->obtPaises();

       $egrem  = $egrem->obtEstadosGrem();

       // output the column headings
       fputcsv($output, array('Nombre', 'Alias', 'Icono', 'País', 'Estado'));


       $rows = $this->Usuarios->find('all'); 

       foreach($rows as $row) {
          $r['nombre'] = $row->nombre;
          $r['alias']  = $row->alias;
          $r['icono']  = $row->icono;
          $r['pais']   = $paises[$row->idpais];
          $r['estado'] = $egrem[$row->idesge];
          fputcsv($output, $r);
       }

       $this->viewBuilder()->layout('custom');
    }

    
}
