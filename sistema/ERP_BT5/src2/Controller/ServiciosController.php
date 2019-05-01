<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class ServiciosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->Servicios->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->Servicios->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
        $cond['idempr']=$session->read('idempr');

       

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
if ($gre->idtise!=null) $cond["idtise"] = $gre->idtise;
if ($gre->idunms!=null) $cond["idunms"] = $gre->idunms;
if ($gre->nombre!=null) $cond["nombre like"] = $gre->nombre."%";
if ($gre->preciounitario!=null) $cond["preciounitario"] = $gre->preciounitario;

 
        $Servicios = $this->paginate($this->Servicios->find('all')->where($cond));

        $this->set("registros", $Servicios); 
		
	    $this->llena_lista('tipos_servicios', 'descripcion');
        $this->llena_lista('unidades_medidas_servicios', 'descripcion');
		$this->llena_lista('monedas', 'nombre');
    }

    public function add() {
       $session = $this->request->session();

       $gre = $this->Servicios->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
		 
		 $this->request->data["idempr"] = $session->read("idempr");
		 
 	     $gre = $this->Servicios->patchEntity($gre, $this->request->data);

	     if ($this->Servicios->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

	  $this->llena_lista('tipos_servicios', 'descripcion');
          $this->llena_lista('unidades_medidas_servicios', 'descripcion');
          $this->llena_lista('monedas', 'nombre');

       //$gre->idgrem = $session->read("idgrem");
       $gre->idempr = $session->read("idempr");
	   
	   //print_r($gre);

       $this->set('gre', $gre);
	   

    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->Servicios->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->Servicios->patchEntity($gre, $this->request->data);

	      if ($this->Servicios->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          $this->set("errors", $gre->errors());
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);
	   
	      $this->llena_lista('tipos_servicios', 'descripcion');
   $this->llena_lista('unidades_medidas_servicios', 'descripcion');
       $this->llena_lista('monedas', 'nombre');

    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->Servicios->get($id);
       $this->set("errors", []); 
       $this->llena_lista('tipos_servicios', 'descripcion');
       $this->llena_lista('unidades_medidas_servicios', 'descripcion');
       $this->llena_lista('monedas', 'nombre');

       $this->set('gre', $gre);
    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->Servicios->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

	   try {
       $this->Servicios->save($registro);
	   $this->Flash->success(__('Servicio ha sido eleminado.'));
	   }
	   catch(\Exception $e) {
		  $this->Flash->success(__('Servicio no ha podido ser eleminado.'));
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
       header('Content-Disposition: attachment; filename=servicios.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Tipo')
->setCellValue('B1', 'Unidad de Medida')
->setCellValue('C1', 'Nombre')
->setCellValue('D1', 'Valor Unitarios')
;

       $rows = $this->Servicios->find('all')->where(['idempr' => $session->read('idempr')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->idtise)
->setCellValue("B$n", $r->idunms)
->setCellValue("C$n", $r->nombre)
->setCellValue("D$n", $r->preciounitario)
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
