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
		$this->render("edit");
        $session = $this->request->session();
        $idempr = $session->read("idempr");

		$mobo = TableRegistry::get("mobov_dembv");
		
		$gre = $mobo->newEntity();
		
		$cond=[];
		$cond=["idempr" => $idempr];
		
		if ($this->request->is('post')) {
		   $gre = $mobo->patchEntity($gre, $this->request->data);
		   
		   $cond["cod_prod_alfanum"] = $gre->producto;
		   if ($gre->idbode!="") $cond["idbode"] = $gre->idbode;
		}
		else {
		   $gre->producto="";
		   $gre->idbode="";
		   $gre->fecini=date("Y-m-d");
		   $gre->fecfin=date("Y-m-d");
		   
		   $cond["cod_prod_alfanum"]="XXXXXXXX";
		}
		
        $this->set("gre", $gre); 
		$this->set("grilla", ""); 
		$this->set("idprod", ""); 
        $this->llena_lista('bodegas', 'nombre', true);
		$this->llena_productos('prodv',   'nombre', true);
        //$this->llena_lista('tipos_movimientos_bodegas', 'descripcion');
		
		
		
	    $cond["fecha_movto >="] = $gre->fecini;
		$cond["fecha_movto <="] = $gre->fecfin;
	
	    //print_r($cond);
		
		$Requisiciones = $this->paginate($mobo->find('all')->where($cond));

        $this->set("registros", $Requisiciones); 
		
		$this->render("edit");
    }

	public function llena_lista($tbl, $fld, $fEmpty=true) {
	   $session = $this->request->session();
       $idempr = $session->read("idempr");
	   
	   $l = explode("_", $tbl);
	   
	   $t = "";
	   foreach($l as $p)
	      $t .= ucfirst(strtolower($p));
		  
	   $tabla = TableRegistry::get($t);
	   
	   $lst = $tabla->find('all')->where(["idempr" => $idempr])->order($fld);
	   
	   $l=[];
	   
	   if ($fEmpty) $l[""] = "";
	   foreach($lst as $r)
	      $l[$r["id"]] = $r[$fld];
	   
	   $this->set($tbl, $l);
	   
	}
	
	public function llena_productos($tbl, $fld, $fEmpty=true) {
	   $session = $this->request->session();
       $idempr = $session->read("idempr");
	   
	   $l = explode("_", $tbl);
	   
	   $t = "";
	   foreach($l as $p)
	      $t .= ucfirst(strtolower($p));
		  
	   $tabla = TableRegistry::get($t);
	   
	   $lst = $tabla->find('all')->where(["idempr" => $idempr])->order("cod_prod_alfanum");
	   
	   $l=[];
	   
	   if ($fEmpty) $l[""] = "";
	   foreach($lst as $r)
	      $l[$r["cod_prod_alfanum"]."-".$r["id"]] = $r[$fld];
	   
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
