<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class ImpuestosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->Impuestos->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->Impuestos->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        $cond = [];
      

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idpais!=null) $cond["idpais"] = $gre->idpais;
if ($gre->descripcion!=null) $cond["descripcion like"] = $gre->descripcion."%";
if ($gre->descripcioncorta!=null) $cond["descripcioncorta like"] = $gre->descripcioncorta."%";
if ($gre->obligatorio!=null) $cond["obligatorio like"] = $gre->obligatorio."%";
if ($gre->valor!=null) $cond["valor"] = $gre->valor;

 
        $Impuestos = $this->paginate($this->Impuestos->find('all')->where($cond));

        $this->set("registros", $Impuestos); 
    }

    public function add() {
       $this->render("edit");

       $session = $this->request->session();

       $gre = $this->Impuestos->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
 	     $gre = $this->Impuestos->patchEntity($gre, $this->request->data);
		 
		 $gre->idpais=1;

	     if ($this->Impuestos->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

		 //print_r($gre->errors());
		 
         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       //$gre->idgrem = $session->read("idgrem");
       //$gre->idempr = $session->read("idempr");

	   $gre->idpais=1; //CHILE
	   $gre->obligatorio="N"; //CHILE
	   $gre->valor=0;
	   
       $this->set('gre', $gre);
	   
	   
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->Impuestos->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->Impuestos->patchEntity($gre, $this->request->data);

	      if ($this->Impuestos->save($gre)) {  
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

       $gre = $this->Impuestos->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);
    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->Impuestos->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->Impuestos->save($registro);

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
       header('Content-Disposition: attachment; filename=impuestos.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Descripción')
->setCellValue('B1', 'Descripcion corta')
->setCellValue('C1', 'Obligatorio')
->setCellValue('D1', 'Valor')
;

       $rows = $this->Impuestos->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->descripcion)
->setCellValue("B$n", $r->descripcioncorta)
->setCellValue("C$n", $r->obligatorio)
->setCellValue("D$n", $r->valor)
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
