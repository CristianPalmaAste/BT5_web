<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class PersonasController extends AppController{
   public function index() {
      $session = $this->request->session();
      $idgrem = $session->read("idgrem");

      $gre = $this->Personas->newEntity();

      if ($this->request->is('post')) {
         $gre = $this->Personas->patchEntity($gre, $this->request->data);
      }

      $cond = ["idgrem" => $idgrem, "idusuaborraregistro is" => null];

      if ($gre->id!=null)
         $cond["id"] = $gre->id;
      if ($gre->idgrem!=null)
         $cond["idgrem"] = $gre->idgrem;
      if ($gre->identificador1!=null)
         $cond["identificador1 like"] = $gre->identificador1."%";
      if ($gre->identificador2!=null)
         $cond["identificador2 like"] = $gre->identificador2."%";
      if ($gre->primernombre!=null)
         $cond["primernombre like"] = $gre->primernombre."%";
      if ($gre->segundonombre!=null)
         $cond["segundonombre like"] = $gre->segundonombre."%";
      if ($gre->apellidopaterno!=null)
         $cond["apellidopaterno like"] = $gre->apellidopaterno."%";
      if ($gre->apellidomaterno!=null)
         $cond["apellidomaterno like"] = $gre->apellidomaterno."%";
      if ($gre->email!=null)
         $cond["email like"] = $gre->email."%";
      if ($gre->fechanac!=null)
         $cond["fechanac like"] = $gre->fechanac."%";
      if ($gre->idesci!=null)
         $cond["idesci"] = $gre->idesci;
      if ($gre->idsexo!=null)
         $cond["idsexo"] = $gre->idsexo;
      if ($gre->idpais!=null)
         $cond["idpais"] = $gre->idpais;

      $Personas = $this->paginate($this->Personas->find('all')->where($cond));

      $this->set("registros", $Personas);
   }

   public function add() {
      $gre = $this->Personas->newEntity();
      $session = $this->request->session();
      $gre->idgrem = $session->read("idgrem");
      $gre->idesre = 1;
      $this->set("errors", []);

	   if ($this->request->is('post')) {
         $session = $this->request->session();

         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('pers_seq');");

         $results = $stmt ->fetchAll('assoc');

         $gre->id =  $results[0]["nextval"];
	      $gre = $this->Personas->patchEntity($gre, $this->request->data);

	      if ($this->Personas->save($gre)) {
            $this->Flash->success(__('Registro ha sido creado.'));
            return $this->redirect(['action' => 'index']);
	      }

         $this->set("errors", $gre->errors());
         $this->Flash->error(__('No se puede crear registro.'));
	   }

       $this->set('gre', $gre);

        $pais   = TableRegistry::get('Paises');
        $ecivil = TableRegistry::get('EstadosCiviles');
        $sexo   = TableRegistry::get('Sexos');

        $this->set("paises", $pais->obtNacionalidades());
        $this->set("eciviles", $ecivil->obtEstadosCiviles());
        $this->set("sexos"  , $sexo->obtSexos());

        $this->render("edit");
    }

   public function cvd($s) {
      $e = explode("/", $s);
      return $e[1]."/".$e[0]."/".$e[2];
   }

   public function edit($id=null) {
      $session = $this->request->session();

      $gre = $this->Personas->get($id);

      $gre->fechanac = $this->cvd($gre->fechanac);

      $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
         $this->request->data["idusuamodifregistro"] = $session->read("idusua");
         $this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');
	      $this->Personas->patchEntity($gre, $this->request->data);

	      if ($this->Personas->save($gre)) {
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

         $this->set("errors", $gre->errors());
         $this->Flash->error(__('No se puede modificar el registro.'));
	   }

	   $this->set('gre', $gre);

      $pais   = TableRegistry::get('Paises');
      $ecivil = TableRegistry::get('EstadosCiviles');
      $sexo   = TableRegistry::get('Sexos');

      $this->set("paises", $pais->obtNacionalidades());
      $this->set("eciviles", $ecivil->obtEstadosCiviles());
      $this->set("sexos"  , $sexo->obtSexos());
   }


   public function datosPersonales() {
      $session = $this->request->session();
      $id = $session->read("idpers");
      $persona = $this->Personas->get($id);

	   if ($this->request->is(['post', 'put'])) {
         $persona = $this->Personas->patchEntity($persona, $this->request->getData());
	      if ($this->Personas->save($persona)) {
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['controller' => 'principales', 'action' => 'home']);
	      }

         if( ! empty( $persona->errors() ) ){
            foreach( $persona->errors() as $field => $error ){
               $this->Flash->error( __(array_values( $error ) ) );
            }
         }else{
            $this->Flash->error(__('Los datos personales no han sido actualizados. Trate nuevamente.'));
         }
      }

      $pais   = TableRegistry::get('Paises');
      $ecivil = TableRegistry::get('EstadosCiviles');
      $sexo   = TableRegistry::get('Sexos');

      $this->set('persona', $persona);
      $this->set('rut', number_format($persona->identificador1,0,'','.').'-'.$persona->identificador2);
      $this->set("paises"  , $pais->obtNacionalidades());
      $this->set("eciviles", $ecivil->obtEstadosCiviles());
      $this->set("sexos"   , $sexo->obtSexos());
   }

   public function view($id=null){
      $session = $this->request->session();
      $persona = $this->Personas->get($id);
      $persona->fechanac = $this->cvd($persona->fechanac);

      $pais   = TableRegistry::get('Paises');
      $ecivil = TableRegistry::get('EstadosCiviles');
      $sexo   = TableRegistry::get('Sexos');

      $this->set('persona', $persona);
      $this->set("paises", $pais->obtNacionalidades());
      $this->set("eciviles", $ecivil->obtEstadosCiviles());
      $this->set("sexos"  , $sexo->obtSexos());
    }

    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->Personas->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');

       $this->Personas->save($registro);

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


       $rows = $this->Personas->find('all');

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
