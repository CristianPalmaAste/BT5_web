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

        $this->set("gre", $gre);
        $cond = ["idgrem" => $idgrem, "idusuaborraregistro is" => null];

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
		 
		 if ($_FILES["icono"]["name"]!="") {		  
	        //echo "Subo la imagen<br/>";
		    $this->UpLoadFile("icono");
			 
		    $gre->icono = $_FILES["icono"]["name"];
	     }

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
		  
		  
		  $icono_old = $gre->icono_old;
		 
		  if ($_FILES["icono"]["name"]!="") {		  
	         //echo "Subo la imagen<br/>";
		     $this->UpLoadFile("icono");
			 
			 $gre->icono = $_FILES["icono"]["name"];
		  }
		  else 
			 $gre->icono = $icono_old;
		  

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
	   $this->set("icono_old", $gre->icono);
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

	   try {
         $this->Empresas->save($registro);
		 $this->Flash->success(__('Empresa ha sido eliminada.'));
	   }
	   catch(\Exception $e) {
		  $this->Flash->success(__('Empresa no ha podido ser eliminada.'));
	   }

       return $this->redirect(['action' => 'index']);

    }

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=empresas.xlsx');
      
       $session = $this->request->session();
       $idgrem = $session->read("idgrem");

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)
                     ->setCellValue('A1', 'Holding')			
                     ->setCellValue('B1', 'Rut')
                     ->setCellValue('C1', 'Dv')
                     ->setCellValue('D1', 'Razón Social')	  
                     ->setCellValue('E1', 'Nombre de Fantasía')
                     ->setCellValue('F1', 'Ícono')
                     ->setCellValue('G1', 'País')			
                     ->setCellValue('H1', 'Rubro')			
                     ->setCellValue('I1', 'Estado Registro')
;

       $emprv  = TableRegistry::get('Emprv');
       $rows = $emprv->find('all')->where(['idgrem' => $idgrem]);

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->holding)			
                                              ->setCellValue("B$n", $r->identificador1)
                                              ->setCellValue("C$n", $r->identificador2)
                                              ->setCellValue("D$n", $r->razonsocial)	  
                                              ->setCellValue("E$n", $r->nombrefantasia)
                                              ->setCellValue("F$n", $r->icono)
                                              ->setCellValue("G$n", $r->pais)			
                                              ->setCellValue("H$n", $r->rubro)			
                                              ->setCellValue("I$n", $r->estadoregistro)
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

   function UpLoadFile($fileToUpload) {
   $target_dir = $_SERVER['DOCUMENT_ROOT'].$this->request->webroot."webroot/holdings/";

   $target_file = $target_dir . basename($_FILES[$fileToUpload]["name"]);
   
   $uploadOk = 1;
   $imageFileType = pathinfo($target_file,PATHINFO_EXTENSION);
   
   //echo "Extension: $imageFileType <br/>";
   // Check if image file is a actual image or fake image
   if(isset($_POST["submit"])) {
       $check = getimagesize($_FILES[$fileToUpload]["tmp_name"]);
       if($check !== false) {
           echo "El archivo es una imagen - " . $check["mime"] . ".<br/>";
           $uploadOk = 1;
       } else {
           echo "El archivo no es una imagen.<br/>";
           $uploadOk = 0;
           return false;
       }
   }
   // Check if file already exists
   //if (file_exists($target_file)) {
   //    echo "Lo sentimos, su archivo \"".$_FILES[$fileToUpload]["name"]."\" ya existe!.<br/>";
   //    $uploadOk = 0;
   //    return false;
   //}
   // Check file size
   if ($_FILES[$fileToUpload]["size"] > 2500000) {
       echo "Lo sentimos, su archivo es demasiado grande.<br/>";
       $uploadOk = 0;
       return false;
   }
   // Allow certain file formats
   if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
   && $imageFileType != "gif" ) {
       echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
       $uploadOk = 0;
       return false;
   }
   // Check if $uploadOk is set to 0 by an error
   if ($uploadOk == 0) {
       echo "Lo sentimos, su archivo no pudo subirse.<br/>";
       return false;
   // if everything is ok, try to upload file
   } else {
	   echo $_FILES[$fileToUpload]["tmp_name"]."<hr/>";
	   
       if (move_uploaded_file($_FILES[$fileToUpload]["tmp_name"], $target_file)) {
           echo "El archivo ". basename( $_FILES[$fileToUpload]["name"]). " ha sido subido.<br/>";
           return true;
       } else {
           echo "Lo sentimos hubo un error subiendo su archivo!.<br/>";
           return false;
       }
   }    
}

}
