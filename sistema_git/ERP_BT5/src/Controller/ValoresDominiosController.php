<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class ValoresDominiosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->ValoresDominios->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->ValoresDominios->patchEntity($gre, $this->request->data);
        }             

        
        $cond = [];
                 $cond['idusuacrearegistro is']=null;

       

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->iddomi!=null) $cond["iddomi"] = $gre->iddomi;
if ($gre->descripcion!=null) $cond["descripcion like"] = $gre->descripcion."%";

 
        $ValoresDominios = $this->paginate($this->ValoresDominios->find('all')->where($cond));

        $this->set("registros", $ValoresDominios); 
    }

    public function add() {
       $this->render("edit");

       $session = $this->request->session();

       $gre = $this->ValoresDominios->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
         
         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('');");

         $results = $stmt ->fetchAll('assoc');

	     $gre = $this->ValoresDominios->patchEntity($gre, $this->request->data);
         $gre->id = $results[0]["nextval"];

	     if ($this->ValoresDominios->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       //$idgrem = $session->read("idgrem");
       //$idempr = $session->read("idempr");

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
       $gre = $this->ValoresDominios->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {


          $this->request->data["idusuamodifregistro"] = $session->read("idusua");
          
          $this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');

	      $this->ValoresDominios->patchEntity($gre, $this->request->data);

	      if ($this->ValoresDominios->save($gre)) {  
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

       $gre = $this->ValoresDominios->get($id);
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

       $registro = $this->ValoresDominios->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->ValoresDominios->save($registro);

       return $this->redirect(['action' => 'index']);

    }

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=valores_dominios.csv');
      
       $session = $this->request->session();

       // create a file pointer connected to the output stream
       $output = fopen('php://output', 'w');


       /*
       $egrem = TableRegistry::get('EstadosGrem');
       $pais  = TableRegistry::get('Paises');
       
       $paises = $pais->obtPaises();

       $egrem  = $egrem->obtEstadosGrem();
       */

       // output the column headings
       fputcsv($output, array('id','iddomi','descripcion'));


       $rows = $this->ValoresDominios->find('all'); 

       foreach($rows as $row) {
          $r['id'] = $row->id;
          $r['iddomi'] = $row->iddomi;
          $r['descripcion'] = $row->descripcion;

          fputcsv($output, $r);
       }

       $this->viewBuilder()->layout('custom');
    }

    
}
