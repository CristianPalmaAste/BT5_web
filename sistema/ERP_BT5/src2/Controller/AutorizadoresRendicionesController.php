<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class AutorizadoresRendicionesController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->AutorizadoresRendiciones->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->AutorizadoresRendiciones->patchEntity($gre, $this->request->data);
        }             

		$this->set("gre", $gre);
        
        $cond = [];
		$cond["idusuaborraregistro is"] = null;
        $cond['idempr']=$session->read('idempr');

       
        if ($gre->id!=null) $cond["id"] = $gre->id;
        if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
        if ($gre->idperfautorizador!=null) $cond["idperfautorizador"] = $gre->idperfautorizador;
        if ($gre->idperfautorizado!=null) $cond["idperfautorizado"] = $gre->idperfautorizado;

 
        $AutorizadoresRendiciones = $this->paginate($this->AutorizadoresRendiciones->find('all')
		                            ->where($cond));

		//debug($AutorizadoresRendiciones);
		
        $this->set("registros", $AutorizadoresRendiciones); 
		
		$idempr=$session->read('idempr');
		$this->llena_usuarios($idempr);
    }

    public function add() {
	   $this->render("edit");
       $session = $this->request->session();
       $idempr=$session->read('idempr');
	   
       $this->set("modo", "new");

       $this->set("errors", []); 
	   
	   $gre = $this->AutorizadoresRendiciones->newEntity();

	   if ($this->request->is('post')) {

	     $sel = $_REQUEST["seleccionados"];
		 $e    = explode(";", $sel);
		 
		 $ar = TableRegistry::get('AutorizadoresRendiciones');
		 foreach($e as $idperfautorizado) {		 
			$gre = $this->AutorizadoresRendiciones->newEntity();
			
	        $gre = $ar->patchEntity($gre, $this->request->data);
		    
		    $gre->idempr = $idempr;
			$gre->idperfautorizador = $_REQUEST["idperfautorizador"];
		    $gre->idperfautorizado = $idperfautorizado;
			
			//debug($gre);
			
		    $ar->save($gre);
			
			unset($gre);
			
            
//	        if ($this->AutorizadoresRendiciones->save($gre)) {
//	             $this->Flash->success(__('Registro ha sido creado.'));
//	             return $this->redirect(['action' => 'index']);
//	        }
//            
//            foreach($gre->errors() as $key => $arr)
//               foreach($arr as $k => $v)
//                  $this->Flash->error(__($v));
//            
//	        $this->Flash->error(__('No se puede crear registro.')); 
		 }
		 
		 return $this->redirect(['action' => 'index']);

	   }

       //$gre->idgrem = $session->read("idgrem");
       $gre->idempr = $session->read("idempr");
	   
       $this->set('gre', $gre);
	   
	   $this->llena_usuarios($idempr);
	   
	   $this->llena_perfiles_nuevos($idempr);
	   $this->llena_perfiles_libres($idempr);
	   
	   $this->set("sels", []);
	   
	   $this->render("edit");
    }

    public function edit($id=null) {
       $session = $this->request->session();
	   $idempr=$session->read('idempr');
	   
	   $this->set("modo", "edit");
	   
       $gre = $this->AutorizadoresRendiciones->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
		 $conn = ConnectionManager::get('default');
		
         $sql = "delete from autorizadores_rendiciones where idempr=$idempr and idperfautorizador=".$gre->idperfautorizador;
	     $stmt = $conn->execute($sql);
	   
	     $sel = $_REQUEST["seleccionados"];
		 $e    = explode(";", $sel);
		 
		 $ar = TableRegistry::get('AutorizadoresRendiciones');
		 foreach($e as $idperfautorizado) {		 
			$gre2 = $this->AutorizadoresRendiciones->newEntity();
			
	        $gre2 = $ar->patchEntity($gre2, $this->request->data);
		    
		    $gre2->idempr = $idempr;
			$gre2->idperfautorizador = $_REQUEST["idperfautorizador"];
		    $gre2->idperfautorizado = $idperfautorizado;
			
			//debug($gre2);
			
		    $ar->save($gre2);
			
			unset($gre2);
			
            
//	        if ($this->AutorizadoresRendiciones->save($gre)) {
//	             $this->Flash->success(__('Registro ha sido creado.'));
//	             return $this->redirect(['action' => 'index']);
//	        }
//            
//            foreach($gre->errors() as $key => $arr)
//               foreach($arr as $k => $v)
//                  $this->Flash->error(__($v));
//            
//	        $this->Flash->error(__('No se puede crear registro.')); 
		 }
		 
		 return $this->redirect(['action' => 'index']);

	   }

	   $this->set('gre', $gre);
	   
	   $this->llena_usuarios($idempr);
	   
	   $this->llena_perfiles_libres($idempr, $gre->idperfautorizador);
	   $this->llena_perfiles_sel($idempr, $gre->idperfautorizador);
	   
    }
	
	public function graba_detalle($lista) {
	   $e = explode(";", $lista);
	   
	   
		
	}

    public function view($id=null) {
       $session = $this->request->session();
	   $idempr=$session->read('idempr');
	   
	   $this->set("modo", "edit");
	   
       $gre = $this->AutorizadoresRendiciones->get($id);

       $this->set("errors", []);

	   $this->set('gre', $gre);
	   
	   $this->llena_usuarios($idempr);
	   
	   $this->llena_perfiles_libres($idempr, $gre->idperfautorizador);
	   $this->llena_perfiles_sel($idempr, $gre->idperfautorizador);
    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->AutorizadoresRendiciones->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->AutorizadoresRendiciones->save($registro);

       return $this->redirect(['action' => 'index']);

    }
	
	public function llena_lista($tbl, $fld, $fEmpty=true) {
	   $l = explode("_", $tbl);
	   
	   $t = "";
	   foreach($l as $p)
	      $t .= ucfirst(strtolower($p));
		  
	   $tabla = TableRegistry::get($t);
	   
	   $lst = $tabla->find('all')->order($fld);
	   
	   $l=[];
	   
	   if ($fEmpty) $l[] = "";
	   foreach($lst as $r)
	      $l[$r["id"]] = $r[$fld];
	   
	   $this->set($tbl, $l);
	   
	}
	
	public function llena_usuarios($idempr) {
		
       $conn = ConnectionManager::get('default');
		
       $sql = "select * from perfiles";
	   $stmt = $conn->execute($sql);
	   
       $results = $stmt ->fetchAll('assoc');	   
	   
	   $personas=array();
	   foreach($results as $r) {
		  $personas[$r["id"]] = $r["descripcion"];
	   }
	   
	   //print_r($personas);
	   
	   $this->set("usuarios", $personas);		
	}
	
	public function llena_perfiles_libres($idempr, $idperfautorizador=null) {
		
       $conn = ConnectionManager::get('default');
	   
	   if ($idperfautorizador==null)
		  $sql = "select * from perfiles order by descripcion"; 
	   else
          $sql = "select * from perfiles where id not in (select idperfautorizado from autorizadores_rendiciones where idempr=$idempr and idperfautorizador=$idperfautorizador) order by descripcion";
	  
	   $stmt = $conn->execute($sql);
	   
	   //debug($sql);
	   
       $results = $stmt ->fetchAll('assoc');	   
	   
	   $personas=array();
	   foreach($results as $r) {
		  $personas[$r["id"]] = $r["descripcion"];
	   }
	   
	   //print_r($personas);
	   
	   $this->set("perfiles_libres", $personas);		
	}
	
	public function llena_perfiles_sel($idempr, $idperfautorizador) {
		
       $conn = ConnectionManager::get('default');
		
       $sql = "select * from perfiles where id in (select idperfautorizado from autorizadores_rendiciones where idempr=$idempr and idperfautorizador=$idperfautorizador) order by descripcion";
	   $stmt = $conn->execute($sql);
	   
       $results = $stmt ->fetchAll('assoc');	   
	   
	   $personas=array();
	   foreach($results as $r) {
		  $personas[$r["id"]] = $r["descripcion"];
	   }
	   
	   //print_r($personas);
	   
	   $this->set("sels", $personas);		
	}
	
	public function llena_perfiles_nuevos($idempr) {
		
       $conn = ConnectionManager::get('default');
		
       $sql = "select * from perfiles where id not in (select idperfautorizador from autorizadores_rendiciones where idempr=$idempr) order by descripcion";
	   $stmt = $conn->execute($sql);
	   
       $results = $stmt ->fetchAll('assoc');	   
	   
	   $personas=array();
	   foreach($results as $r) {
		  $personas[$r["id"]] = $r["descripcion"];
	   }
	   
	   //print_r($personas);
	   
	   $this->set("perfiles_nuevos", $personas);		
	}
	
	

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=autorizadores_rendiciones.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Id')
->setCellValue('B1', 'Perfil Autorizador')
->setCellValue('C1', 'Perfil Autorizados')
;

       $rows = $this->AutorizadoresRendiciones->find('all')->where(['idempr' => $session->read('idempr')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->id)
->setCellValue("B$n", $r->idperfautorizador)
->setCellValue("C$n", $r->idperfautorizado)
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
