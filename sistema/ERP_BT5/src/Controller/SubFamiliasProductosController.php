<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class SubFamiliasProductosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");
		$idempr = $session->read("idempr");

		$SubFam = TableRegistry::get("sfprv");
        $gre = $SubFam->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $SubFam->patchEntity($gre, $this->request->data);
        }             
		
        $this->set("gre", $gre);

        
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
        
       

        if ($gre->id!=null) $cond["id"] = $gre->id;
        if ($gre->idfapr!=null) $cond["idfapr"] = $gre->idfapr;
        if ($gre->cod_sub_familia!=null) $cond["cod_sub_familia like"] = $gre->cod_sub_familia."%";
        if ($gre->descripcion!=null) $cond["descripcion like"] = $gre->descripcion."%";
		
		$familias = TableRegistry::get("FamiliasProductos");
		
		$arr = $familias->find("all")->where(["idempr" => $idempr]);
				
		$ids = [];
		
		foreach($arr as $r) {
		   $ids[] = $r->id;
		}
		
		//print_r($ids); return;
		
		
		$cond = ["idfapr IN" => $ids];
				 
        $SubFamiliasProductos = $this->paginate($SubFam->find('all')->where($cond));

        $this->set("registros", $SubFamiliasProductos); 
		
		$this->llena_lista('familias_productos', 'descripcion', $idempr);
    }

    public function add() {
	   $this->render("edit");
	   
       $session = $this->request->session();
       $idempr = $session->read("idempr");
       $idgrem = $session->read("idgrem");

	   
       $gre = $this->SubFamiliasProductos->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

	     $gre = $this->SubFamiliasProductos->patchEntity($gre, $this->request->data);

	     if ($this->SubFamiliasProductos->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.')); 

	   }

       //$gre->idgrem = $session->read("idgrem");
       //$gre->idempr = $session->read("idempr");

       $this->set('gre', $gre);
	   
	   $this->llena_lista('familias_productos', 'descripcion', $idempr);
	   
	   $this->llena_cuentas($idgrem);
	   
	   $this->set("accion", "add");
	   
	   $this->render("edit");
    }

    public function edit($id=null) {
       $session = $this->request->session();
	   $idempr = $session->read("idempr");
	   $idgrem = $session->read("idgrem");
	   
       $gre = $this->SubFamiliasProductos->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->SubFamiliasProductos->patchEntity($gre, $this->request->data);

	      if ($this->SubFamiliasProductos->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);
	   
	   $this->llena_lista('familias_productos', 'descripcion', $idempr);
	   $this->llena_cuentas($idgrem);
	   
	   $this->set("accion", "edit");
    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->SubFamiliasProductos->get($id);
       $this->llena_lista('familias_productos', 'descripcion');
       $this->set("errors", []); 

	   $this->set('gre', $gre);

    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->SubFamiliasProductos->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->SubFamiliasProductos->save($registro);

       return $this->redirect(['action' => 'index']);

    }
	
	public function llena_lista($tbl, $fld, $idempr) {
	   $l = explode("_", $tbl);
	   
	   $t = "";
	   foreach($l as $p)
	      $t .= ucfirst(strtolower($p));
		  
	   $tabla = TableRegistry::get($t);
	   
	   $lst = $tabla->find('all')->where(["idempr" => $idempr, "idusuaborraregistro is" => null])->order($fld);
	   
	   $l=[];
	   
	   $l[""] = "";
	   foreach($lst as $r)
	      $l[$r["id"]] = $r[$fld];
	   
	   $this->set($tbl, $l);
	   
	}
	
	public function llena_cuentas($idgrem) {
       $tabla = TableRegistry::get("cuentas_contables");
	   
	   $lst = $tabla->find('all')->where(["idgrem" => $idgrem, "imputable" => "S"])->order("descripcion");
	      
	   $l[""] = "";
	   foreach($lst as $r)
	      $l[$r["id"]] = $r["descripcion"];
	   
	   $this->set("cuentas_contables", $l);	
    }	

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=sub_familias_productos.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Familia')
->setCellValue('B1', 'Código')
->setCellValue('C1', 'Descripción')
;

       $rows = $this->SubFamiliasProductos->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->idfapr)
->setCellValue("B$n", $r->cod_sub_familia)
->setCellValue("C$n", $r->descripcion)
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
