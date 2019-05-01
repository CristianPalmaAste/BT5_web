<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class TiposProductosImpuestosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->TiposProductosImpuestos->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->TiposProductosImpuestos->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        $cond = [];    

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idtipr!=null) $cond["idtipr"] = $gre->idtipr;
if ($gre->idimpu!=null) $cond["idimpu"] = $gre->idimpu;

 
        $TiposProductosImpuestos = $this->paginate($this->TiposProductosImpuestos->find('all')->where($cond));

        $this->set("registros", $TiposProductosImpuestos); 
		
		$this->llena_lista('tipos_productos', 'descripcion');
        $this->llena_lista('impuestos', 'descripcion');
    }

    public function add() {
       //$this->render("edit");

       $session = $this->request->session();

       $gre = $this->TiposProductosImpuestos->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
 	     $gre = $this->TiposProductosImpuestos->patchEntity($gre, $this->request->data);

	     if ($this->TiposProductosImpuestos->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       //$gre->idgrem = $session->read("idgrem");
       //$gre->idempr = $session->read("idempr");

       $this->set('gre', $gre);
	   
	   $this->llena_lista('tipos_productos', 'descripcion');
       $this->llena_lista('impuestos', 'descripcion');

    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->TiposProductosImpuestos->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->TiposProductosImpuestos->patchEntity($gre, $this->request->data);

	      if ($this->TiposProductosImpuestos->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          $this->set("errors", $gre->errors());
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);
	   
	      $this->llena_lista('tipos_productos', 'descripcion');
   $this->llena_lista('impuestos', 'descripcion');

    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->TiposProductosImpuestos->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);
    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->TiposProductosImpuestos->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->TiposProductosImpuestos->save($registro);

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
       header('Content-Disposition: attachment; filename=tipos_productos_impuestos.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Tipo de producto')
->setCellValue('B1', 'Tipo de impuesto')
;

       $rows = $this->TiposProductosImpuestos->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->idtipr)
->setCellValue("B$n", $r->idimpu)
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
