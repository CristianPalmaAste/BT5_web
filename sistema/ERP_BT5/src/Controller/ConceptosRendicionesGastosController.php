<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class ConceptosRendicionesGastosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->ConceptosRendicionesGastos->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->ConceptosRendicionesGastos->patchEntity($gre, $this->request->data);
        }             

		$this->set("gre", $gre);
        
        $cond = [];
		$cond["idusuaborraregistro is"] = null;
         $cond['idgrem']=$session->read('idgrem');

       
        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idgrem!=null) $cond["idgrem"] = $gre->idgrem;
if ($gre->descripcion!=null) $cond["descripcion like"] = $gre->descripcion."%";
if ($gre->idcuco!=null) $cond["idcuco"] = $gre->idcuco;

 
        $ConceptosRendicionesGastos = $this->paginate($this->ConceptosRendicionesGastos->find('all')->where($cond));

        $this->set("registros", $ConceptosRendicionesGastos); 
		
		$this->llena_cuentas($idgrem);
    }

    public function add() {
	   $this->render("edit");
	   
       $session = $this->request->session();

       $gre = $this->ConceptosRendicionesGastos->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

	     $gre = $this->ConceptosRendicionesGastos->patchEntity($gre, $this->request->data);

	     if ($this->ConceptosRendicionesGastos->save($gre)) {
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
	   
	   $this->llena_cuentas($gre->idgrem);
	   $this->render("edit");
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->ConceptosRendicionesGastos->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->ConceptosRendicionesGastos->patchEntity($gre, $this->request->data);

	      if ($this->ConceptosRendicionesGastos->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);
	   
	   $this->llena_cuentas($gre->idgrem);
    }
	
	public function setGrid($arr=[]) {
		
	}

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->ConceptosRendicionesGastos->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);

    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->ConceptosRendicionesGastos->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->ConceptosRendicionesGastos->save($registro);

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
	
	public function llena_cuentas($idgrem) {
       $tabla = TableRegistry::get("cuentas_contables");
	   
	   $lst = $tabla->find('all')->where(["idgrem" => $idgrem, "imputable" => "S"])->order("descripcion");
	      
	   $l[""] = "";
	   foreach($lst as $r)
	      $l[$r["id"]] = $r["descripcion"];
	   
	   $this->set("cuentas_contables", $l);	
    }		  

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=conceptos_rendiciones_gastos.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Id')
->setCellValue('B1', 'Descripción')
->setCellValue('C1', 'Cuenta Contable')
;

       $rows = $this->ConceptosRendicionesGastos->find('all')->where(['idgrem' => $session->read('idgrem')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->id)
->setCellValue("B$n", $r->descripcion)
->setCellValue("C$n", $r->idcuco)
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
