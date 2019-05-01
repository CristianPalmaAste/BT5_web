<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class RubrosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->Rubros->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->Rubros->patchEntity($gre, $this->request->data);
        }             

        //print_r($session);
        $this->set("gre", $gre);
        $cond = [];
        //$cond["idusuaborraregistro is"] = null;
         $cond['idgrem']=$session->read('idgrem');
		 
		 
		//print_r($cond);

       

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idgrem!=null) $cond["idgrem"] = $gre->idgrem;
if ($gre->descripcion!=null) $cond["descripcion like"] = $gre->descripcion."%";

 
        $Rubros = $this->paginate($this->Rubros->find('all')->where($cond));

        $this->set("registros", $Rubros); 
    }

    public function add() {
       $session = $this->request->session();

       $gre = $this->Rubros->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
		   
		 $this->request->data["idgrem"] = $session->read("idgrem");
		 
		 print_r($this->request->data);
		 
 	     $gre = $this->Rubros->patchEntity($gre, $this->request->data);

	     if ($this->Rubros->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       $gre->idgrem = $session->read("idgrem");
       //$gre->idempr = $session->read("idempr");

       $this->set('gre', $gre);
	   
	   
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->Rubros->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->Rubros->patchEntity($gre, $this->request->data);

	      if ($this->Rubros->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          $this->set("errors", $gre->errors());
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);
	   
	   
    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->Rubros->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);
    }
    
    public function delete($id)
    {
	   try {	
	      $entity = $this->Rubros->get($id);
          $result = $this->Rubros->delete($entity);
       }
       catch(\Exception $e) {
		  return $this->redirect("/mensajes/index/Rubro, registro referenciado no se puede eliminar.");
       }		   

       return $this->redirect(['action' => 'index']);

    }
	
	public function llena_lista($tbl, $fld) {
	   $l = explode("_", $tbl);
	   
	   $t = "";
	   foreach($l as $p)
	      $t .= ucfirst(strtolower($p));
		  
	   $tabla = TableRegistry::get($t);
	   
	   $lst = $tabla->find('all')->order($fld);
	   
	   $l=[];
	   $l[] = "";
	   foreach($lst as $r)
	      $l[$r["id"]] = $r[$fld];
	   
	   $this->set($tbl, $l);
	   
	}

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=rubros.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Descripción')
;

       $rows = $this->Rubros->find('all')->where(['idgrem' => $session->read('idgrem')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->descripcion)
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
