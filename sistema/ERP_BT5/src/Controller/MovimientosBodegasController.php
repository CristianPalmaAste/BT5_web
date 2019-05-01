<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class MovimientosBodegasController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idempr = $session->read("idempr");

		$bodev = TableRegistry::get("bodev");
		
        $gre = $bodev->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $bodev->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        $cond = [];
        //$cond["idusuaborraregistro is"] = null;
		$cond["idempr"] = $idempr;
        
       

        if ($gre->id!=null) $cond["id"] = $gre->id;
        if ($gre->idbode!=null) $cond["idbode"] = $gre->idbode;
        if ($gre->correlativo!=null) $cond["correlativo"] = $gre->correlativo;
        if ($gre->idtimb!=null) $cond["idtimb"] = $gre->idtimb;
        if ($gre->fechamovto!=null) $cond["fechamovto like"] = $gre->fechamovto."%";
        if ($gre->descripcion!=null) $cond["descripcion like"] = $gre->descripcion."%";

 
        $movtos = $this->paginate($bodev->find('all')->where($cond));

        $this->set("registros", $movtos); 
        $this->llena_lista('bodegas', 'nombre');
        $this->llena_lista('tipos_movimientos_bodegas', 'descripcion');
    }


    public function view($id=null) {
       $session = $this->request->session();
       $idempr = $session->read("idempr");

	   $bodega = TableRegistry::get("Bodegas");
	   
	   /*
	   $conn = ConnectionManager::get('default');
	   
	   $sql = "select * from mobov where idbode=$id";
	   
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
       $this->set("errors", []); 
	   
	   $this->set("registros", $results);
        */
       
	   
	   $bodev = TableRegistry::get("mobov");
	  
	   $registros = $this->paginate($bodev->find('all')->where(["idbode" => $id])->order("fecha_movto desc"));
	   
	   $this->set("registros", $registros);
		
       //$gre = $bodev->newEntity();
	   
	   $gre = $bodega->get($id);
	   $this->set('gre', $gre);

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
       header('Content-Disposition: attachment; filename=movimientos_bodegas.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Bodega')
->setCellValue('B1', 'Correlativo')
->setCellValue('C1', 'Tipo de Movimiento')
->setCellValue('D1', 'Fecha Movto.')
->setCellValue('E1', 'Descripción')
;

       $rows = $mobov->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->idbode)
->setCellValue("B$n", $r->correlativo)
->setCellValue("C$n", $r->idtimb)
->setCellValue("D$n", $r->fechamovto)
->setCellValue("E$n", $r->descripcion)
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
