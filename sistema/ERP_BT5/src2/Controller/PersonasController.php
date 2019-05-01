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

        $this->set("gre", $gre);
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
	  $this->render("edit");
      $gre = $this->Personas->newEntity();
      $session = $this->request->session();
      $idgrem = $session->read("idgrem");
   
      $this->set("errors", []);

	   if ($this->request->is('post')) {
         $session = $this->request->session();

         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('pers_seq');");

         $results = $stmt ->fetchAll('assoc');

         $gre->id =  $results[0]["nextval"];
		 $gre->idgrem = $idgrem;
		 
	      $gre = $this->Personas->patchEntity($gre, $this->request->data);
		  
		  //print_r($gre); return;

		  try {
	         if ($this->Personas->save($gre)) {
               $this->Flash->success(__('Registro ha sido creado.'));
               return $this->redirect(['action' => 'index']);
			 }
			 else {
				foreach($gre->errors() as $key => $arr)
                   foreach($arr as $k => $v)
                       $this->Flash->error(__($v)); 
					   
			    $this->Flash->error(__('No se puede crear registro.'));		   
			 }
	      }
		  catch(\Exception $e) {		  
             foreach($gre->errors() as $key => $arr)
                foreach($arr as $k => $v)
                    $this->Flash->error(__($v));
			   
             $this->Flash->error(__('No se puede crear registro.'));
		  }
	   }

	   $gre->idesre = 1;
	   $gre->idgrem = $idgrem;
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

         foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
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
       header('Content-Disposition: attachment; filename=personas.xlsx');
      
       $session = $this->request->session();
	   $idgrem  = $session->read("idgrem");

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Holding')			
                                           ->setCellValue('B1', 'Rut')				
                                           ->setCellValue('C1', 'Dv')				
                                           ->setCellValue('D1', 'Primer Nombre')	
                                           ->setCellValue('E1', 'Segundo Nombre')	
                                           ->setCellValue('F1', 'Apellido Paterno')	
                                           ->setCellValue('G1', 'Apellido Materno')	
                                           ->setCellValue('H1', 'E-Mail')			
                                           ->setCellValue('I1', 'Fec/Nacimiento')		
                                           ->setCellValue('J1', 'Estado Civil')			
                                           ->setCellValue('K1', 'Sexo')			
                                           ->setCellValue('L1', 'Nacionalidad')
;

       $tbl  = TableRegistry::get('Persv');
	   
       $rows = $tbl->find('all')->where(['idgrem' => $idgrem]);  

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->holding)			
                                              ->setCellValue("B$n", $r->rut)				
                                              ->setCellValue("C$n", $r->dv)				
                                              ->setCellValue("D$n", $r->primernombre)	
                                              ->setCellValue("E$n", $r->segundonombre)	
                                              ->setCellValue("F$n", $r->apellidopaterno)	
                                              ->setCellValue("G$n", $r->apellidomaterno)	
                                              ->setCellValue("H$n", $r->email)			
                                              ->setCellValue("I$n", $r->fechanac)		
                                              ->setCellValue("J$n", $r->estadocivil)			
                                              ->setCellValue("K$n", $r->sexo)			
                                              ->setCellValue("L$n", $r->nacionalidad)
;

          $n++;
       }

       // Renombrar hoja
       $objPHPExcel->getActiveSheet()->setTitle('Simple');


       // Setea hoja 0
       $objPHPExcel->setActiveSheetIndex(0);

       $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
       $objWriter->save('php://output');

       $this->viewBuilder()->layout('custom');
    }
}
