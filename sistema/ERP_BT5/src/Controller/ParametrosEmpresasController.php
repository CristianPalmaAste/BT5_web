<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class ParametrosEmpresasController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->ParametrosEmpresas->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->ParametrosEmpresas->patchEntity($gre, $this->request->data);
        }             
		
		$this->set("gre", $gre);
		$cond["idusuaborraregistro is"] = null;

       
        $cond['idempr']=$session->read('idempr');

       

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
if ($gre->nombrecorto!=null) $cond["nombrecorto like"] = $gre->nombrecorto."%";
if ($gre->nombrelargo!=null) $cond["nombrelargo like"] = $gre->nombrelargo."%";
if ($gre->descripcion!=null) $cond["descripcion like"] = $gre->descripcion."%";
if ($gre->valor!=null) $cond["valor like"] = $gre->valor."%";

 
        $ParametrosEmpresas = $this->paginate($this->ParametrosEmpresas->find('all')->where($cond));

        $this->set("registros", $ParametrosEmpresas); 
    }

    public function add() {
       $session = $this->request->session();

       $gre = $this->ParametrosEmpresas->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

	     $gre = $this->ParametrosEmpresas->patchEntity($gre, $this->request->data);

	     if ($this->ParametrosEmpresas->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.')); 

	   }

       //$gre->idgrem = $session->read("idgrem");
       $gre->idempr = $session->read("idempr");

       $this->set('gre', $gre);
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->ParametrosEmpresas->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->ParametrosEmpresas->patchEntity($gre, $this->request->data);

	      if ($this->ParametrosEmpresas->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);
    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->ParametrosEmpresas->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);

    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->ParametrosEmpresas->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

	   try {
          $this->ParametrosEmpresas->save($registro);
		  
		  $this->Flash->success(__('Parámetro empresa ha sido eliminado.'));
	   }
       catch(\Exception $e) {
		  $this->Flash->success(__('Parámetro empresa ha podido ser eliminado.'));
       }		   

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
       header('Content-Disposition: attachment; filename=parametros_empresas.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Nombre Corto')
->setCellValue('B1', 'Nombre Largo')
->setCellValue('C1', 'Descripción')
->setCellValue('D1', 'Valor')
;

       $rows = $this->ParametrosEmpresas->find('all')->where(['idempr' => $session->read('idempr')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->nombrecorto)
->setCellValue("B$n", $r->nombrelargo)
->setCellValue("C$n", $r->descripcion)
->setCellValue("D$n", $r->valor)
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
