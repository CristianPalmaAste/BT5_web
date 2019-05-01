<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class FamiliasProductosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->FamiliasProductos->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->FamiliasProductos->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
        $cond['idempr']=$session->read('idempr');

       

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
if ($gre->cod_familia!=null) $cond["cod_familia like"] = $gre->cod_familia."%";
if ($gre->descripcion!=null) $cond["descripcion like"] = $gre->descripcion."%";

 
        $FamiliasProductos = $this->paginate($this->FamiliasProductos->find('all')->where($cond));

        $this->set("registros", $FamiliasProductos); 
    }

    public function add() {
       $session = $this->request->session();

       $gre = $this->FamiliasProductos->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

	     $gre = $this->FamiliasProductos->patchEntity($gre, $this->request->data);

	     if ($this->FamiliasProductos->save($gre)) {
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
       $gre = $this->FamiliasProductos->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->FamiliasProductos->patchEntity($gre, $this->request->data);

	      if ($this->FamiliasProductos->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);

       /*
       $pais  = TableRegistry::get('Paises');
       $rubro = TableRegistry::get('Rubros');
       $gemp  = TableRegistry::get('GruposEmpresariales'); 

       $d = $gemp->get($gre->idgrem);

       $this->set("nombreGrupo", $d->nombre);

       $this->set("paises", $pais->obtPaises());

       $session = $this->request->session();

       $this->set("rubros", $rubro->obtRubros($session->read("idgrem")));
       $this->set("gemp"  , $gemp->obtGruposEmpresariales());
       */
    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->FamiliasProductos->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);

    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->FamiliasProductos->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->FamiliasProductos->save($registro);

       return $this->redirect(['action' => 'index']);

    }

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=familias_productos.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Código')
->setCellValue('B1', 'Descripción')
;

       $rows = $this->FamiliasProductos->find('all')->where(['idempr' => $session->read('idempr')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->cod_familia)
->setCellValue("B$n", $r->descripcion)
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
