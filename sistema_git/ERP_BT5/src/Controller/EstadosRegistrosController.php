<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class EstadosRegistrosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->EstadosRegistros->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->EstadosRegistros->patchEntity($gre, $this->request->data);
        }             

        //$cond = [/*"idgrem" => $idgrem,*/ "idusuaborraregistro is" => null];
        $cond = [];

           if ($gre->id!=null)
      $cond["id"] = $gre->id;
   if ($gre->descripcion!=null)
      $cond["descripcion like"] = $gre->descripcion."%";

 
        $EstadosRegistros = $this->paginate($this->EstadosRegistros->find('all')->where($cond));

        $this->set("registros", $EstadosRegistros); 
    }

    public function add() {
       $session = $this->request->session();

       $gre = $this->EstadosRegistros->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
         
         //$this->request->data["idusuacrearegistro"] = $session->read("idusua");

         //$this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('esre_seq');");

         $results = $stmt ->fetchAll('assoc');

	     $gre = $this->EstadosRegistros->patchEntity($gre, $this->request->data);
         $gre->id = $results[0]["nextval"];

	     if ($this->EstadosRegistros->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       $this->set('gre', $gre);

       /*
       $pais  = TableRegistry::get('Paises');
       $rubro = TableRegistry::get('Rubros');
       $gemp  = TableRegistry::get('GruposEmpresariales'); 

       $session = $this->request->session();

       $d = $gemp->get($session->read("idgrem"));

       $this->set("nombreGrupo", $d->nombre);

       $gre->idgrem = $session->read("idgrem");
 
       $this->set('emp', $gre);

        $this->set("paises", $pais->obtPaises());

        $this->set("rubros", $rubro->obtRubros($session->read("idgrem")));
        $this->set("gemp"  , $gemp->obtGruposEmpresariales());
        */

        $this->render("edit");
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->EstadosRegistros->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {


          //$this->request->data["idusuamodifregistro"] = $session->read("idusua");
          
          //$this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');

	      $this->EstadosRegistros->patchEntity($gre, $this->request->data);

	      if ($this->EstadosRegistros->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          $this->set("errors", $gre->errors());
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);

       /*
       $pais  = TableRegistry::get('Paises');
       $rubro = TableRegistry::get('Rubros');
       $gemp  = TableRegistry::get('GruposEmpresariales'); 

       $d = $gemp->get($gre->idgrem);

       $this->set("nombreGrupo", $d->nombre);

       $this->set("paises", $pais->obtPaises());

       $session = $this->request->session();

       $this->set("rubros", $rubro->obtRubros($session->read("idgrem")));
       $this->set("gemp"  , $gemp->obtGruposEmpresariales());
       */
    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->EstadosRegistros->get($id);
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

       $registro = $this->EstadosRegistros->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->EstadosRegistros->save($registro);

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


       $rows = $this->EstadosRegistros->find('all'); 

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
