<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class PerfilesController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->Perfiles->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->Perfiles->patchEntity($gre, $this->request->data);
        }             

        //$cond = [/*"idgrem" => $idgrem,*/ "idusuaborraregistro is" => null];
        $cond = [];

           if ($gre->id!=null)
      $cond["id"] = $gre->id;
   if ($gre->descripcion!=null)
      $cond["descripcion like"] = $gre->descripcion."%";

 
        $Perfiles = $this->paginate($this->Perfiles->find('all')->where($cond));

        $this->set("registros", $Perfiles); 
    }

    public function add() {
       $session = $this->request->session();

       $gre = $this->Perfiles->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
         
         //$this->request->data["idusuacrearegistro"] = $session->read("idusua");

         //$this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('perf_seq');");

         $results = $stmt ->fetchAll('assoc');

	     $gre = $this->Perfiles->patchEntity($gre, $this->request->data);
         $gre->id = $results[0]["nextval"];

	     if ($this->Perfiles->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       $this->set('gre', $gre);

       $this->render("edit");
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->Perfiles->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {


          //$this->request->data["idusuamodifregistro"] = $session->read("idusua");
          
          //$this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');

	      $this->Perfiles->patchEntity($gre, $this->request->data);

	      if ($this->Perfiles->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          $this->set("errors", $gre->errors());
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);

       $conn = ConnectionManager::get('default');

       $programas = TableRegistry::get('Programas');

       $progs = $programas->find('all')->where(["idprogpadre is" => null])->order("peso");

       $ll = [];
       foreach($progs as $p) {
          $rr = $programas->find('all')->where(["idprogpadre" => $p->id])->order("peso");

          $d = [];

          foreach($rr as $r) {
             $stmt = $conn->execute("select count(*) cuenta from perfiles_programas where idperf=$p->id and idprog=$r->id");
             $results = $stmt ->fetchAll('assoc');

             $d[] = ["id" => $r->id, "etiqueta" => $r->etiqueta, "selected" => $results[0]["cuenta"]];
          }
       
          $ll[] = ["id" => $p->id, "etiqueta" => $p->etiqueta, "hijos" => $d];
       }
       
       $this->set("progs", $ll);
    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->Perfiles->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);
    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->Perfiles->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->Perfiles->save($registro);

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


       $rows = $this->Perfiles->find('all'); 

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
