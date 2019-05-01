<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class TiposServiciosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->TiposServicios->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->TiposServicios->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        $cond = [];       

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->descripcion!=null) $cond["descripcion like"] = $gre->descripcion."%";
if ($gre->estaexento!=null) $cond["estaexento like"] = $gre->estaexento."%";

 
        $TiposServicios = $this->paginate($this->TiposServicios->find('all')->where($cond));

        $this->set("registros", $TiposServicios); 
    }

    public function add() {
       $this->render("edit");

       $session = $this->request->session();

       $gre = $this->TiposServicios->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
 	     $gre = $this->TiposServicios->patchEntity($gre, $this->request->data);

	     if ($this->TiposServicios->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       //$gre->idgrem = $session->read("idgrem");
       //$gre->idempr = $session->read("idempr");

       $this->set('gre', $gre);
	   
	   
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->TiposServicios->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->TiposServicios->patchEntity($gre, $this->request->data);

	      if ($this->TiposServicios->save($gre)) {  
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

       $gre = $this->TiposServicios->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);
    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->TiposServicios->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->TiposServicios->save($registro);

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
       header('Content-Disposition: attachment; filename=tipos_servicios.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Descripción')
->setCellValue('B1', 'Está exento')
;

       $rows = $this->TiposServicios->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->descripcion)
->setCellValue("B$n", $r->estaexento)
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
