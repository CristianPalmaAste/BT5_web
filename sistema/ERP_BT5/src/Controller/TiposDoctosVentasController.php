<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class TiposDoctosVentasController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->TiposDoctosVentas->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->TiposDoctosVentas->patchEntity($gre, $this->request->data);
        }             

        
        $this->set("gre", $gre);
        $cond = [];      

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idpais!=null) $cond["idpais"] = $gre->idpais;
if ($gre->descripcion!=null) $cond["descripcion like"] = $gre->descripcion."%";
if ($gre->descripcioncorta!=null) $cond["descripcioncorta like"] = $gre->descripcioncorta."%";
if ($gre->codigooficial!=null) $cond["codigooficial like"] = $gre->codigooficial."%";

 
        $TiposDoctosVentas = $this->paginate($this->TiposDoctosVentas->find('all')->where($cond));

        $this->set("registros", $TiposDoctosVentas); 
    }

    public function add() {
       $this->render("edit");

       $session = $this->request->session();

       $gre = $this->TiposDoctosVentas->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
 	     $gre = $this->TiposDoctosVentas->patchEntity($gre, $this->request->data);

	     if ($this->TiposDoctosVentas->save($gre)) {
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
       $gre = $this->TiposDoctosVentas->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->TiposDoctosVentas->patchEntity($gre, $this->request->data);
		  
		  $gre->idpais=1;

	      if ($this->TiposDoctosVentas->save($gre)) {  
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

       $gre = $this->TiposDoctosVentas->get($id);
       $this->set("errors", []); 
       $this->llena_lista('paises', 'nombre');
	   $this->set('gre', $gre);
    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->TiposDoctosVentas->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->TiposDoctosVentas->save($registro);

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
       header('Content-Disposition: attachment; filename=tipos_doctos_ventas.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Descripción')
->setCellValue('B1', 'Descripción corta')
->setCellValue('C1', 'Código oficial')
;

       $rows = $this->TiposDoctosVentas->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->descripcion)
->setCellValue("B$n", $r->descripcioncorta)
->setCellValue("C$n", $r->codigooficial)
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
