<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class CentrosCostosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->CentrosCostos->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->CentrosCostos->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
        $cond['idempr']=$session->read('idempr');

       

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
if ($gre->nombre!=null) $cond["nombre like"] = $gre->nombre."%";

 
        $CentrosCostos = $this->paginate($this->CentrosCostos->find('all')->where($cond));

        $this->set("registros", $CentrosCostos); 
    }

    public function add() {
       $this->render("edit");

       $session = $this->request->session();

       $gre = $this->CentrosCostos->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
 	     $gre = $this->CentrosCostos->patchEntity($gre, $this->request->data);
		 
		 $gre->idempr = $session->read("idempr");

	     if ($this->CentrosCostos->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       //$gre->idgrem = $session->read("idgrem");
       $gre->idempr = $session->read("idempr");

       $this->set('gre', $gre);
	   
	   $this->render("edit");
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->CentrosCostos->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->CentrosCostos->patchEntity($gre, $this->request->data);

	      if ($this->CentrosCostos->save($gre)) {  
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

       $gre = $this->CentrosCostos->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);
    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->CentrosCostos->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

	   try {
       $this->CentrosCostos->save($registro);
	   $this->Flash->success(__('Centro de Costo ha sido eliminado.'));
	   }
	   catch(\Exception $e) {
		  $this->Flash->success(__('Centro de Costo no ha podido ser eliminado.'));
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
       header('Content-Disposition: attachment; filename=centros_costos.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Nombre')
;

       $rows = $this->CentrosCostos->find('all')->where(['idempr' => $session->read('idempr')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->nombre)
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
