<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class BitacorasCambiosPreciosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idempr = $session->read("idempr");

		$bicp = $prove = TableRegistry::get("prodv");
		
        $gre = $bicp->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $bicp->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
		
        $cond = ["idempr" => $idempr];   

        //print_r($cond);		
		

        if ($gre->id!=null) $cond["id"] = $gre->id;
        if ($gre->idprod!=null) $cond["idprod"] = $gre->idprod;
        if ($gre->preciounitario!=null) $cond["preciounitario"] = $gre->preciounitario;

 
        $BitacorasCambiosPrecios = $this->paginate($bicp->find('all')->where($cond));
		
		//print_r($BitacorasCambiosPrecios);

        $this->set("registros", $BitacorasCambiosPrecios); 
    }

    public function view($id=null) {
	   $session = $this->request->session();
       $idempr = $session->read("idempr");
	   
	   $bicp = $prove = TableRegistry::get("Prodv");
		
       $gre = $bicp->newEntity();

	   $conn = ConnectionManager::get('default');
	   
	   $sql = "select * from prodv where id=$id";
	   
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
       $this->set("errors", []); 

	   $this->set('gre', $gre);
	   
	   $this->set('r', $results[0]);
	   
	   $bicp = $prove = TableRegistry::get("bicpv");
	   
	   $cond = ["idempr" => $idempr, "idprod" => $id];   
	   
	   $BitacorasCambiosPrecios = $this->paginate($bicp->find('all')->where($cond)->order("fecha_cambio desc"));
		
	   //print_r($BitacorasCambiosPrecios);

       $this->set("registros", $BitacorasCambiosPrecios); 

    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->BitacorasCambiosPrecios->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->BitacorasCambiosPrecios->save($registro);

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
       header('Content-Disposition: attachment; filename=bitacoras_cambios_precios.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Producto')
->setCellValue('B1', 'Precio Unitario')
;

       $rows = $this->BitacorasCambiosPrecios->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->idprod)
->setCellValue("B$n", $r->preciounitario)
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
