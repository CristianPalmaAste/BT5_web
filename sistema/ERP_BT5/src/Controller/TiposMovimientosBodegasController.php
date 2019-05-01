<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class TiposMovimientosBodegasController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->TiposMovimientosBodegas->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->TiposMovimientosBodegas->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        $cond = [];     

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->descripcion!=null) $cond["descripcion like"] = $gre->descripcion."%";
if ($gre->signo!=null) $cond["signo"] = $gre->signo;

 
        $TiposMovimientosBodegas = $this->paginate($this->TiposMovimientosBodegas->find('all')->where($cond));

        $this->set("registros", $TiposMovimientosBodegas); 
		
		$this->set("signos", [1 => 'Positivo', -1 => 'Negativo']); 
    }

    public function add() {
	   $this->render("edit");
	   
       $session = $this->request->session();

       $gre = $this->TiposMovimientosBodegas->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

	     $gre = $this->TiposMovimientosBodegas->patchEntity($gre, $this->request->data);

	     if ($this->TiposMovimientosBodegas->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.')); 

	   }
	   else
	      $gre->signo=1;

       $this->set('gre', $gre);
	   $this->set("signos", [1 => 'Positivo', -1 => 'Negativo']); 
	   
	   $this->render("edit");
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->TiposMovimientosBodegas->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->TiposMovimientosBodegas->patchEntity($gre, $this->request->data);

	      if ($this->TiposMovimientosBodegas->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);
	   $this->set("signos", [1 => 'Positivo', -1 => 'Negativo']); 
    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->TiposMovimientosBodegas->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);

    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->TiposMovimientosBodegas->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->TiposMovimientosBodegas->save($registro);

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

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=tipos_movimientos_bodegas.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Id')
->setCellValue('B1', 'Descripción')
->setCellValue('C1', 'Signo')
;

       $rows = $this->TiposMovimientosBodegas->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->id)
->setCellValue("B$n", $r->descripcion)
->setCellValue("C$n", $r->signo)
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
