<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class BodegasProductosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");
		$idempr = $session->read("idempr");

        $gre = $this->BodegasProductos->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->BodegasProductos->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
        
       

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idbode!=null) $cond["idbode"] = $gre->idbode;
if ($gre->idprod!=null) $cond["idprod"] = $gre->idprod;
if ($gre->stock!=null) $cond["stock"] = $gre->stock;

        $bodegas  = TableRegistry::get('Bodegas');
		
		$bod = [];
		
		$arr =$bodegas->find("all")->where(["idempr" => $idempr]);
		
		foreach($arr as $r)
		   $bod[] = $r["id"];
		   
		$cond["idbode IN"] = $bod;
 
        $BodegasProductos = $this->paginate($this->BodegasProductos->find('all')->where($cond));

        $this->set("registros", $BodegasProductos); 
		
		$this->llena_lista('bodegas', 'nombre');
		$this->llena_lista('productos', 'nombre');
    }

    public function add() {
       $session = $this->request->session();
	   $idempr = $session->read("idempr");

       $gre = $this->BodegasProductos->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

	     $gre = $this->BodegasProductos->patchEntity($gre, $this->request->data);

	     if ($this->BodegasProductos->save($gre)) {
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
	   
	   $this->llena_lista('bodegas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);	   
    }

    public function edit($id=null) {
       $session = $this->request->session();
	   $idempr = $session->read("idempr");
	   
       $gre = $this->BodegasProductos->get($id);
	   

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->BodegasProductos->patchEntity($gre, $this->request->data);

	      if ($this->BodegasProductos->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);
	   $this->llena_lista('bodegas', 'nombre');
	   $this->llena_lista('productos', 'nombre');	   
    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->BodegasProductos->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);
           $this->llena_lista('bodegas', 'nombre');
           $this->llena_lista('productos', 'nombre');


    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->BodegasProductos->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->BodegasProductos->save($registro);

       return $this->redirect(['action' => 'index']);

    }
	
	public function llena_lista($tbl, $fld, $idempr="") {
	   $l = explode("_", $tbl);
	   
	   $t = "";
	   foreach($l as $p)
	      $t .= ucfirst(strtolower($p));
		  
	   $tabla = TableRegistry::get($t);
	   
	   if ($idempr!="")
		  $lst = $tabla->find('all')->where(["idempr" => $idempr])->order($fld); 
	   else
	      $lst = $tabla->find('all')->order($fld);
	   
	   $l=[];
	   $l[""] = "";
	   foreach($lst as $r)
	      $l[$r["id"]] = $r[$fld];
	   
	   $this->set($tbl, $l);
	   
	}

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=bodegas_productos.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Bodega')
->setCellValue('B1', 'Producto')
->setCellValue('C1', 'Stock')
;

       $rows = $this->BodegasProductos->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->idbode)
->setCellValue("B$n", $r->idprod)
->setCellValue("C$n", $r->stock)
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
