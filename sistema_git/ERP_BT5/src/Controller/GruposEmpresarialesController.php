<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class GruposEmpresarialesController extends AppController
{
    public function index()
    {
        $gre = $this->GruposEmpresariales->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->GruposEmpresariales->patchEntity($gre, $this->request->data);
        }             

        $cond = ["idusuaborraregistro is" => null];

        if ($gre->id!=null)
           $cond["id"] = $gre->id;

        if ($gre->nombre!=null)
           $cond["nombre like"] = $gre->nombre."%";

        if ($gre->alias!=null)
           $cond["alias like"] = $gre->alias."%";

        if ($gre->estado!=null)
           $cond["estado"] = $gre->estado;

 
        $grupos = $this->paginate($this->GruposEmpresariales->find('all')->where($cond));
        $this->set("registros", $grupos); 

        $egrem = TableRegistry::get('EstadosGrem');

        $pais  = TableRegistry::get('Paises');
       
        $this->set("paises", $pais->obtPaises());

        $l = $egrem->obtEstadosGrem();

        $l[""] = "Todos";

        $this->set("egrem", $l);

        
        $this->set("gre", $gre);
    }

    public function add() {
        $this->render("edit");
        $this->set("errors", []); 

        $gre = $this->GruposEmpresariales->newEntity();

	    if ($this->request->is('post')) {
         $session = $this->request->session();

         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('grem_seq');");

         $results = $stmt ->fetchAll('assoc');

         $this->request->data["id"] = $results[0]["nextval"];

	       $gre = $this->GruposEmpresariales->patchEntity($gre, $this->request->data);

	       if ($this->GruposEmpresariales->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	       }


           $this->set("errors", $gre->errors());

	       $this->Flash->error(__('No se puede crear registro.'));

	    }

	    $this->set('gre', $gre);

        $egrem = TableRegistry::get('EstadosGrem');
        $pais  = TableRegistry::get('Paises');
       
        $this->set("paises", $pais->obtPaises());

        $this->set("egrem", $egrem->obtEstadosGrem());

        $this->render("edit");
    }

    public function edit($id=null) {
       $gre = $this->GruposEmpresariales->get($id);
       $this->set("errors", []); 

	   if ($this->request->is(['post', 'put'])) {
          $session = $this->request->session();

          $this->request->data["idusuamodifregistro"] = $session->read("idusua");
          
          $this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');


	      $this->GruposEmpresariales->patchEntity($gre, $this->request->data);

	      if ($this->GruposEmpresariales->save($gre)) {
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          $this->set("errors", $gre->errors()); 

	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);

       $egrem = TableRegistry::get('EstadosGrem');
       $pais  = TableRegistry::get('Paises');
       
       $this->set("paises", $pais->obtPaises());

       $this->set("egrem", $egrem->obtEstadosGrem());

    }

    public function view($id=null) {
       $gre = $this->GruposEmpresariales->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);

       $egrem = TableRegistry::get('EstadosGrem');
       $pais  = TableRegistry::get('Paises');
       
       $this->set("paises", $pais->obtPaises());

       $this->set("egrem", $egrem->obtEstadosGrem());

    }
    
    public function delete($id)
    {
       //$this->request->allowMethod(['post', 'delete']);     

       $session = $this->request->session();

       $ge = $this->GruposEmpresariales->get($id);

       $ge->idusuaborraregistro = $session->read("idusua");
       $ge->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->GruposEmpresariales->save($ge);

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


       $rows = $this->GruposEmpresariales->find('all'); 

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
