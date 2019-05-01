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

        
        $cond = [];
        //$cond['idusuacrearegistro is']=null;
		//
        //if ($gre->id!=null) $cond["id"] = $gre->id;
		//if ($gre->nombre!=null) $cond["nombre like"] = $gre->nombre."%";
		//if ($gre->alias!=null) $cond["alias like"] = $gre->alias."%";
		//if ($gre->icono!=null) $cond["icono like"] = $gre->icono."%";
		//if ($gre->idpais!=null) $cond["idpais"] = $gre->idpais;
		//if ($gre->idesge!=null) $cond["idesge"] = $gre->idesge;

 
        $GruposEmpresariales = $this->paginate($this->GruposEmpresariales->find('all')->where($cond));

        $this->set("registros", $GruposEmpresariales); 
    }

    public function add() {
       $session = $this->request->session();

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

	     if ($this->GruposEmpresariales->save($gre)) {
			  $idgrem = $gre->id;
			  
			  $personas = TableRegistry::get('Personas');
			  
			  $pers = $personas->newEntity();
     
              $pers->idgrem             = $idgrem;
              $pers->identificador1     = $gre->identificador1 ;
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
			  
			 
			  if ($personas->save($pers)) {
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
				 
				 if ($usuarios->save($usua)) {
					//echo "Usuario creado<br/>";
					
					$idusua = $usua->id;
			     
			        $usuaperfiles = TableRegistry::get('UsuariosPerfiles');
			           
                    //$conn = ConnectionManager::get('default');
                    
                    $stmt = $conn->execute("SELECT NEXTVAL('uspe_seq');");
                    
                    $results = $stmt ->fetchAll('assoc');
			        
			        $usuaperf = $usuaperfiles->newEntity();
				    
				    
                    $usuaperf->id                 = $results[0]["nextval"];
                    $usuaperf->idusua             = $idusua;
                    $usuaperf->idperf             = 2;
                    $usuaperf->idgrem             = $idgrem;
                    //$usuaperf->idempr             = ;
                    $usuaperf->idesre             = 1;
			        $usuaperf->idusuacrearegistro = $session->read("idusua");;
			        $usuaperf->fechacrearegistro  = date('Y-m-d H:i:s');  
					 
					if ($usuaperfiles->save($usuaperf)) {
                       //echo "Perfiles creados<br/>";						
	                   $this->Flash->success(__('Registro ha sido creado.'));
	                   return $this->redirect(['controller' => 'usuarios', 'action' => 'logout']);
					}
				 }
			  }
	     }

         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       //$idgrem = $session->read("idgrem");
       //$idempr = $session->read("idempr");

	   $gre->idesge = 1;
	   $gre->idpais = 1;
	   $gre->idpais2= 1;
	   $gre->idesci = 1;
	   $gre->idsexo = 1;
       $this->set('gre', $gre);

       
       $pais  = TableRegistry::get('Paises');
	   $egrem = TableRegistry::get('EstadosGrem');
       $this->set("paises", $pais->obtPaises());
	   $this->set("egrems", $egrem->obtEstadosGrem());
	   
        $ecivil = TableRegistry::get('EstadosCiviles');
        $sexo   = TableRegistry::get('Sexos');

        $this->set("eciviles", $ecivil->obtEstadosCiviles());
        $this->set("sexos"  , $sexo->obtSexos());
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->GruposEmpresariales->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {


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

       $rows = $this->GruposEmpresariales->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->nombre)
->setCellValue("B$n", $r->alias)
->setCellValue("C$n", $r->icono)
->setCellValue("D$n", $r->idpais)
->setCellValue("E$n", $r->idesge)
;

          $n++;
       }

       // Renombrar hoja
       $objPHPExcel->getActiveSheet()->setTitle('Simple');


       // Setea hoja 0
       $objPHPExcel->setActiveSheetIndex(0);

       $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
       $objWriter->save('php://output');

       $this->viewBuilder()->layout('custom');
    }

    
}
