<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class EmpresasController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->Empresas->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->Empresas->patchEntity($gre, $this->request->data);
        }             

        $cond = [/*"idgrem" => $idgrem,*/ "idusuaborraregistro is" => null];

           if ($gre->id!=null)
      $cond["id"] = $gre->id;
   if ($gre->idgrem!=null)
      $cond["idgrem"] = $gre->idgrem;
   if ($gre->idpais!=null)
      $cond["idpais"] = $gre->idpais;
   if ($gre->idrubr!=null)
      $cond["idrubr"] = $gre->idrubr;
   if ($gre->idesre!=null)
      $cond["idesre"] = $gre->idesre;
   if ($gre->identificador1!=null)
      $cond["identificador1 like"] = $gre->identificador1."%";
   if ($gre->identificador2!=null)
      $cond["identificador2 like"] = $gre->identificador2."%";
   if ($gre->razonsocial!=null)
      $cond["razonsocial like"] = $gre->razonsocial."%";
   if ($gre->nombrefantasia!=null)
      $cond["nombrefantasia like"] = $gre->nombrefantasia."%";
   if ($gre->icono!=null)
      $cond["icono like"] = $gre->icono."%";
   if ($gre->xfld!=null)
      $cond["xfld like"] = $gre->xfld."%";

 
        $Empresas = $this->paginate($this->Empresas->find('all')->where($cond));

        $this->set("registros", $Empresas); 
    }

    public function add() {
       $this->render("edit");
       $session = $this->request->session();

       $gre = $this->Empresas->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
        
         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('empr_seq');");

         $results = $stmt ->fetchAll('assoc');

	     $gre = $this->Empresas->patchEntity($gre, $this->request->data);

         $gre->id = $results[0]["nextval"]; 
         $gre->idgrem = $session->read("idgrem");
         $gre->idesre = 1;

         //print_r($gre); return;

	     if ($this->Empresas->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       $this->set('gre', $gre);

        $rubro = TableRegistry::get('Rubros');
        $pais   = TableRegistry::get('Paises');
        $ecivil = TableRegistry::get('EstadosCiviles');

        $this->set("paises", $pais->obtPaises());
        $this->set("eciviles", $ecivil->obtEstadosCiviles());
        $this->set("rubros", $rubro->obtRubros($session->read("idgrem")));

        $this->render("edit");
    }

    public function edit($id=null) {
       $session = $this->request->session();

       $gre = $this->Empresas->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {

          $this->request->data["idusuamodifregistro"] = $session->read("idusua");
          
          $this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');

	      $this->Empresas->patchEntity($gre, $this->request->data);

	      if ($this->Empresas->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          $this->set("errors", $gre->errors());
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);

       $rubro = TableRegistry::get('Rubros');
       $pais   = TableRegistry::get('Paises');
       $ecivil = TableRegistry::get('EstadosCiviles');

       $this->set("paises", $pais->obtPaises());
       $this->set("eciviles", $ecivil->obtEstadosCiviles());
       $this->set("rubros", $rubro->obtRubros($session->read("idgrem")));
    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->Empresas->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);

      
       $rubro = TableRegistry::get('Rubros');
       $pais   = TableRegistry::get('Paises');
       $ecivil = TableRegistry::get('EstadosCiviles');

       $this->set("paises", $pais->obtPaises());
       $this->set("eciviles", $ecivil->obtEstadosCiviles());
       $this->set("rubros", $rubro->obtRubros($session->read("idgrem")));

    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->Empresas->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->Empresas->save($registro);

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


       $rows = $this->Empresas->find('all'); 

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
