<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class DetallesMovtosBodegasController extends AppController
{
	
	
    public function index()
   {
      $session = $this->request->session();
      $idgrem = $session->read("idgrem");
	  
	  $bode = $prove = TableRegistry::get("Bodegas");
	  	  
      $gre = $bode->newEntity();

      if ($this->request->is('post')) {
         $gre = $bode->patchEntity($gre, $this->request->data);
      }

        $this->set("gre", $gre);
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
      $cond['idempr']=$session->read('idempr');

      if ($gre->id!=null) $cond["id"] = $gre->id;
      if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
      if ($gre->nombre!=null) $cond["nombre like"] = $gre->nombre."%";

      $Bodegas = $this->paginate($bode->find('all')->where($cond));

      $this->set("registros", $Bodegas);
      $this->set('gre',$gre);
    }

    public function view($id=null) {
       $session = $this->request->session();
       $idgrem = $session->read("idgrem");

	   $bode = TableRegistry::get("Bodegas");
	   $dembv = TableRegistry::get("dembv");
	   $mobov = TableRegistry::get("mobov");
	   
       $gre = $bode->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);
	   
	   $mobov = TableRegistry::get("mobov");
	   
	   $results = $mobov->find('all')->where(["idbode" => $id]);
	   $lista=[];
	   foreach($results as $r)
	     $lista[] = $r["id"];
		 
	   if (count($lista)==0) $lista[] = -1;	 
	   
	   $cond = ["idmobo IN "=> $lista]; 
	   
	   $registros = $this->paginate($dembv->find('all')->where($cond)->order("id"));

       $this->set("registros", $registros); 

    }
    
    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=detalles_movtos_bodegas.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'id')
       ->setCellValue('B1', 'idmobo')
       ->setCellValue('C1', 'correlativo')
       ->setCellValue('D1', 'idprod')
       ->setCellValue('E1', 'cantidad')
       ->setCellValue('F1', 'idunmp')
       ;

       $rows = $this->DetallesMovtosBodegas->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->id)
->setCellValue("B$n", $r->idmobo)
->setCellValue("C$n", $r->correlativo)
->setCellValue("D$n", $r->idprod)
->setCellValue("E$n", $r->cantidad)
->setCellValue("F$n", $r->idunmp)
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