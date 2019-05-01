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
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->GruposEmpresariales->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->GruposEmpresariales->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        $cond = [];
        //$cond["idusuaborraregistro is"] = null;
        //$cond['idusuaborraregistro is']=null;
		//
        //if ($gre->id!=null) $cond["id"] = $gre->id;
		//if ($gre->nombre!=null) $cond["nombre like"] = $gre->nombre."%";
		//if ($gre->alias!=null) $cond["alias like"] = $gre->alias."%";
		//if ($gre->icono!=null) $cond["icono like"] = $gre->icono."%";
		//if ($gre->idpais!=null) $cond["idpais"] = $gre->idpais;
		//if ($gre->idesge!=null) $cond["idesge"] = $gre->idesge;

        $gremv  = TableRegistry::get('Gremv');
		
		//print_r($gremv->find('all')->where($cond));
		
        $GruposEmpresariales = $this->paginate($gremv->find('all')->where($cond));

        $this->set("registros", $GruposEmpresariales); 
    }

    public function add() {
       $session = $this->request->session();
	   
       $idgrem = $session->read("idgrem");

       $gre = $this->GruposEmpresariales->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
         
         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('grem_seq');");

         $results = $stmt ->fetchAll('assoc');

	     $gre = $this->GruposEmpresariales->patchEntity($gre, $this->request->data);
         $gre->id = $results[0]["nextval"];
		 
		 
		 $icono    = $_FILES["icono"]["name"];
		 $iconoemp = $_FILES["iconoemp"]["name"];
		 
//		 if ($icono="" || $iconoemp=="") {
//			$this->Flash->error(__('Debe ingresar los Íconos.')); 
//			
//        $this->set("gre", $gre);
//			
//			$pais  = TableRegistry::get('Paises');
//	        $egrem = TableRegistry::get('EstadosGrem');
//	        $rubros = TableRegistry::get('Rubros');
//	        
//            $this->set("paises", $pais->obtPaises());
//	        $this->set("egrems", $egrem->obtEstadosGrem());
//	        
//            $ecivil = TableRegistry::get('EstadosCiviles');
//            $sexo   = TableRegistry::get('Sexos');
//            
//            $this->set("eciviles", $ecivil->obtEstadosCiviles());
//            $this->set("sexos"  , $sexo->obtSexos());
//		     
//	        $this->set("rubros"  , $rubros->obtRubros($idgrem));
//	        
//	        $this->set("idgrem", $idgrem);
//	   
//			return;
//		 }

		 
         if ($_FILES["icono"]["name"]!="") {		  
	         //echo "Subo la imagen<br/>";
		     $this->UpLoadFile("icono");
			 
			 $gre->icono = $_FILES["icono"]["name"];
		  }
		  
		  if ($_FILES["iconoemp"]["name"]!="") {		  
	         //echo "Subo la imagen<br/>";
		     $this->UpLoadFile("iconoemp");
			 
			 $gre->iconoemp = $_FILES["iconoemp"]["name"];
		  }

		 try {
			 $conn->begin();
            			 
	     if (!$this->GruposEmpresariales->save($gre)) {
			foreach($gre->errors() as $key => $arr)
               foreach($arr as $k => $v)
                  $this->Flash->error(__($v));
				  
			$this->Flash->error(__('No se puede crear registro grupos empresariales.')); 
			throw new \Exception(__('No se puede crear registro grupos empresariales.')); 
		 }
		 else {
			  
			  $idgrem = $gre->id;
			  
			  $personas = TableRegistry::get('Personas');
			  
			  $pers = $personas->newEntity();
     
              $pers->idgrem             = $idgrem;
              $pers->identificador1     = str_replace(".", "", $gre->identificador1) ;
              $pers->identificador2     = $gre->identificador2 ;
              $pers->primernombre       = $gre->primernombre   ;
              $pers->segundonombre      = $gre->segundonombre  ;
              $pers->apellidopaterno    = $gre->apellidopaterno;
              $pers->apellidomaterno    = $gre->apellidomaterno;
              $pers->email              = $gre->email          ;
              $pers->fechanac           = $gre->fechanac       ;
              $pers->idesci             = $gre->idesci         ;
              $pers->idsexo             = $gre->idsexo         ;
              $pers->idpais             = $gre->idpais2         ;
			  $pers->idusuacrearegistro = $session->read("idusua");;
			  $pers->fechacrearegistro  = date('Y-m-d H:i:s');
			  
			 
			  if (!$personas->save($pers)) {
				 //print_r($pers); echo "<br/>"; 
				 foreach($pers->errors() as $key => $arr)
                    foreach($arr as $k => $v)
                       $this->Flash->error(__($v));
				 $this->Flash->error(__('No se puede crear registro personas.'));
				 throw new \Exception(__('No se puede crear registro personas.'));
			  }
			  else {
				 //echo "Persona creada<br/>"; return;
				 
			     $idpers = $pers->id;
			     
			     $usuarios = TableRegistry::get('Usuarios');
			        
                 //$conn = ConnectionManager::get('default');
                 
				 //echo "Voy a ejecutar la secuencia<br>";
                 $stmt = $conn->execute("SELECT NEXTVAL('usua_seq');");
				 //echo "secuencia_ejecutada<br>";
                 
                 $results = $stmt ->fetchAll('assoc');
			     
			     $usua = $usuarios->newEntity();
				 
				 
                 $usua->id                 = $results[0]["nextval"];;
                 $usua->username           = $gre->username;
                 $usua->password           = $gre->password;
                 $usua->idpers             = $idpers;
                 $usua->idesre             = 1;
			     $usua->idusuacrearegistro = $session->read("idusua");;
			     $usua->fechacrearegistro  = date('Y-m-d H:i:s'); 
				 
				 if (!$usuarios->save($usua)) {
					//print_r($usua); echo "<br/>";
					foreach($usua->errors() as $key => $arr)
                       foreach($arr as $k => $v)
                          $this->Flash->error(__($v));
						  
					$this->Flash->error(__('No se puede crear registro usuarios.'));
					throw new \Exception(__('No se puede crear registro usuarios.'));
				 }
				 else {
					//echo "Usuario creado<br/>";
					
					$idusua = $usua->id;		       
                      			
					   $empresas = TableRegistry::get('Empresas');
                        
                       $stmt = $conn->execute("SELECT NEXTVAL('empr_seq');");
                       
                       $results = $stmt ->fetchAll('assoc');
			           
			           $empresa = $empresas->newEntity();
				       
				       
                       $empresa->id                 = $results[0]["nextval"];     
                       $empresa->idgrem             = $idgrem;             
                       $empresa->idpais             = $gre->idpaisemp;
                       $empresa->idrubr             = $gre->idrubr;
                       $empresa->idesre             = 1;
                       $empresa->identificador1     = $gre->identificador1emp;
                       $empresa->identificador2     = $gre->identificador2emp;
                       $empresa->razonsocial        = $gre->razonsocial;
                       $empresa->nombrefantasia     = $gre->nombrefantasia;
					   
					   if ($_FILES["iconoemp"]["name"]!="") {		
                          $empresa->icono              = $gre->iconoemp;
					   }
					   
			           $empresa->idusuacrearegistro = $session->read("idusua");
			           $empresa->fechacrearegistro  = date('Y-m-d H:i:s');  
					   
					   //$this->UpLoadFile("iconoemp");						  
						
					   if (!$empresas->save($empresa)) {
						  //print_r($empresa); echo "<br/>"; 
						  foreach($empresa->errors() as $key => $arr)
                             foreach($arr as $k => $v)
                                $this->Flash->error(__($v));
						  $this->Flash->error(__('No se puede crear registro empresas.'));
						  throw new \Exception(__('No se puede crear registro empresas.'));
					   }
					   else {	
					      //echo "Empresa creada<br/>";
						  
					      $stmt = $conn->execute("SELECT NEXTVAL('uspe_seq');");
                    
                          $results = $stmt ->fetchAll('assoc');
						  
						  $usuaperfiles = TableRegistry::get('UsuariosPerfiles');
			              
			              $usuaperf = $usuaperfiles->newEntity();
				          				          
                          $usuaperf->id                 = $results[0]["nextval"];
                          $usuaperf->idusua             = $idusua;
                          $usuaperf->idperf             = 4;
                          //$usuaperf->idgrem             = $idgrem;
                          $usuaperf->idempr             = $empresa->id;
                          $usuaperf->idesre             = 1;
			              $usuaperf->idusuacrearegistro = $session->read("idusua");;
			              $usuaperf->fechacrearegistro  = date('Y-m-d H:i:s');      
						  
						  //print_r($usuaperf); return;
					 
					      if (!$usuaperfiles->save($usuaperf)) {
							 foreach($usuaperf->errors() as $key => $arr)
                                foreach($arr as $k => $v)
                                   $this->Flash->error(__($v));
								   
							 $this->Flash->error(__('No se puede crear registro usuarios_perfiles.')); 
							 throw new \Exception(__('No se puede crear registro usuarios_perfiles.')); 
						  }
						  else {
                             //echo "Perfiles creados";						
							 $conn->commit();
	                         $this->Flash->success(__('Registro ha sido creado.'));
	                         return $this->redirect(['controller' => 'usuarios', 'action' => 'logout']);
						  }
					   
					   
					}
				 }
			  }
	     }
		 
		    
		 }
		 catch(\Exception $ex) {
			
			//echo $ex;
			
			$conn->rollback();
		 }
	   }

       //$idgrem = $session->read("idgrem");
       //$idempr = $session->read("idempr");

	   $gre->idesge = 1;
	   $gre->idpais = 1;
	   $gre->idpais2= 1;
	   $gre->idesci = 1;
	   $gre->idsexo = 1;
	   $gre->idpaisemp=1;
	   $gre->idrubr=11;
       $this->set('gre', $gre);

       
       $pais  = TableRegistry::get('Paises');
	   $egrem = TableRegistry::get('EstadosGrem');
	   $rubros = TableRegistry::get('Rubros');
	   
       $this->set("paises", $pais->obtPaises());
	   $this->set("egrems", $egrem->obtEstadosGrem());
	   
       $ecivil = TableRegistry::get('EstadosCiviles');
       $sexo   = TableRegistry::get('Sexos');

       $this->set("eciviles", $ecivil->obtEstadosCiviles());
       $this->set("sexos"  , $sexo->obtSexos());
		
	   $this->set("rubros"  , $rubros->obtRubros($idgrem));
	   
	   $this->set("idgrem", $idgrem);
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->GruposEmpresariales->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {


          $this->request->data["idusuamodifregistro"] = $session->read("idusua");
          
          $this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');

	      $this->GruposEmpresariales->patchEntity($gre, $this->request->data);
		  
		  //print_r($gre->icono); return;
		  
		  //$icono = $gre->icono["name"];
		  $icono_old = $gre->icono_old;
		 

          if ($_FILES["icono"]["name"]!="") {		  
	         //echo "Subo la imagen<br/>";
		     $this->UpLoadFile("icono");
			 
			 $gre->icono = $_FILES["icono"]["name"];
		  }
		  else
			 $gre->icono = $icono_old;
		  
		  
		  //return;

	      if ($this->GruposEmpresariales->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          $this->set("errors", $gre->errors());
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);

       $pais  = TableRegistry::get('Paises');
           $egrem = TableRegistry::get('EstadosGrem');
       $this->set("paises", $pais->obtPaises());
           $this->set("egrems", $egrem->obtEstadosGrem());



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
       $session = $this->request->session();

       $registro = $this->GruposEmpresariales->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->GruposEmpresariales->save($registro);

       return $this->redirect(['action' => 'index']);

    }

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=grupos_empresariales.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Nombre')
->setCellValue('B1', 'Alias')
->setCellValue('C1', 'Ícono')
->setCellValue('D1', 'País')
->setCellValue('E1', 'Estado')
;

       $gremv  = TableRegistry::get('Gremv');
       $rows = $gremv->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->nombre)
->setCellValue("B$n", $r->alias)
->setCellValue("C$n", $r->icono)
->setCellValue("D$n", $r->pais)
->setCellValue("E$n", $r->estadoholding)
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

	
	public function chkNombre($nombre) {
	   $this->render("excel");
	   
	   $a = $this->GruposEmpresariales->find("all")->where(["nombre" => $nombre]);
	   
	   $n=0;
	   foreach($a as $x)
	      $n++;
	   
	   $b->cuenta = $n;
	   
	   echo json_encode($b);   
	}
	
	public function chkAlias($alias) {
	   $this->render("excel");
	   
	   $a = $this->GruposEmpresariales->find("all")->where(["alias" => $alias]);
	   
	   $n=0;
	   foreach($a as $x)
	      $n++;
	   
	   $b->cuenta = $n;
	   
	   echo json_encode($b);   
	}
	
	public function chkIdentificador1emp($identificador1emp) {
	   $this->render("excel");
	   
	   $identificador1emp = str_replace(".", "", $identificador1emp);
	   
	   $Empresas = TableRegistry::get('Empresas');
	   $a = $Empresas->find("all")->where(["identificador1" => $identificador1emp]);
	   
	   $n=0;
	   foreach($a as $x)
	      $n++;
	   
	   $b->cuenta = $n;
	   
	   echo json_encode($b);   
	}
	
	public function chkRazonsocial($idgrem, $razonsocial) {
	   $this->render("excel");
	   
	   $Empresas = TableRegistry::get('Empresas');
	   
	   $a = $Empresas->find("all")->where(["idgrem" => $idgrem, "razonsocial" => $razonsocial]);
	   
	   $n=0;
	   foreach($a as $x)
	      $n++;
	   
	   $b->cuenta = $n;
	   
	   echo json_encode($b);   
	}
	
	public function chkNombrefantasia($idgrem, $nombrefantasia) {
	   $this->render("excel");
	   
	   $Empresas = TableRegistry::get('Empresas');
	   
	   $a = $Empresas->find("all")->where(["idgrem" => $idgrem, "nombrefantasia" => $nombrefantasia]);
	   
	   $n=0;
	   foreach($a as $x)
	      $n++;
	   
	   $b->cuenta = $n;
	   
	   echo json_encode($b);   
	}
	
	public function chkUsername($username) {
	   $this->render("excel");
	   
	   $Usuarios = TableRegistry::get('Usuarios');
	   $a = $Usuarios->find("all")->where(["username" => $username]);
	   
	   $n=0;
	   foreach($a as $x)
	      $n++;
	   
	   $b->cuenta = $n;
	   
	   echo json_encode($b);   
	}
	
	public function chkIdentificador1($identificador1) {
	   $this->render("excel");
	   
	   $identificador1 = str_replace(".", "", $identificador1);
	   
	   $Personas= TableRegistry::get('Personas');
	   $a = $Personas->find("all")->where(["identificador1" => $identificador1]);
	   
	   $n=0;
	   foreach($a as $x)
	      $n++;
	   
	   $b->cuenta = $n;
	   
	   echo json_encode($b);   
	}
	
   function UpLoadFile($fileToUpload) {
   $target_dir = $_SERVER['DOCUMENT_ROOT'].$this->request->webroot."webroot/holdings/";

   $target_file = $target_dir . basename($_FILES[$fileToUpload]["name"]);
   
   $uploadOk = 1;
   $imageFileType = pathinfo($target_file,PATHINFO_EXTENSION);
   
//   echo "Extension: $imageFileType <br/>";
//   echo $target_file."<br/>";
//   echo $fileToUpLoad."<br/>";
   
   // Check if image file is a actual image or fake image
   if(isset($_POST["submit"])) {
       $check = getimagesize($_FILES[$fileToUpload]["tmp_name"]);
       if($check !== false) {
           //echo "El archivo es una imagen - " . $check["mime"] . ".<br/>";
           $uploadOk = 1;
       } else {
           //echo "El archivo no es una imagen.<br/>";
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
       //echo "Lo sentimos, su archivo es demasiado grande.<br/>";
       $uploadOk = 0;
       return false;
   }
   // Allow certain file formats
   if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
   && $imageFileType != "gif" ) {
       //echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
       $uploadOk = 0;
       return false;
   }
   // Check if $uploadOk is set to 0 by an error
   if ($uploadOk == 0) {
       //echo "Lo sentimos, su archivo no pudo subirse.<br/>";
       return false;
   // if everything is ok, try to upload file
   } else {
	   //echo $_FILES[$fileToUpload]["tmp_name"]."<hr/>";
	   
       if (move_uploaded_file($_FILES[$fileToUpload]["tmp_name"], $target_file)) {
           echo "El archivo ". basename( $_FILES[$fileToUpload]["name"]). " ha sido subido.<br/>";
           return true;
       } else {
           echo "Lo sentimos hubo un error subiendo su archivo!.<br/>";
           return false;
       }
   }

}//UpLoadFile


	
    
}
