<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class BodegasController extends AppController
{
   public function index()
   {
      $session = $this->request->session();
      $idgrem = $session->read("idgrem");

      $gre = $this->Bodegas->newEntity();

      if ($this->request->is('post')) {
         $gre = $this->Bodegas->patchEntity($gre, $this->request->data);
      }

        $this->set("gre", $gre);
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
      $cond['idempr']=$session->read('idempr');

      if ($gre->id!=null) $cond["id"] = $gre->id;
      if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
      if ($gre->nombre!=null) $cond["nombre like"] = $gre->nombre."%";

      $Bodegas = $this->paginate($this->Bodegas->find('all')->where($cond));

      $this->set("registros", $Bodegas);
      $this->set('gre',$gre);
    }

   public function add() {
	  $this->render("edit");
	  
      $session = $this->request->session();
      $gre = $this->Bodegas->newEntity();

      $this->set("errors", []);

	   if ($this->request->is('post')) {
         $gre = $this->Bodegas->patchEntity($gre, $this->request->data);

         if ($this->Bodegas->save($gre)) {
            $this->Flash->success(__('Registro ha sido creado.'));
            return $this->redirect(['action' => 'index']);
         }

         foreach($gre->errors() as $key => $arr){
            foreach($arr as $k => $v){
               $this->Flash->error(__($v));
            }
         }

         $this->Flash->error(__('No se puede crear registro.'));
      }

      $gre->idempr = $session->read("idempr");

      $this->set('gre', $gre);
	  
	  $this->render("edit");
   }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->Bodegas->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->Bodegas->patchEntity($gre, $this->request->data);

	      if ($this->Bodegas->save($gre)) {
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
      $gre = $this->Bodegas->get($id);
      $this->set("errors", []);
      $this->set('gre', $gre);
   }

   public function delete($id)
   {
      $session = $this->request->session();

      //$this->request->allowMethod(['post', 'delete']);

      $bodega = $this->Bodegas->get($id);

	  try {
         if ($this->Bodegas->delete($bodega)) {
             $this->Flash->success(__('La bodega ha sido eliminada.'));
         } else {
             $this->Flash->error(__('La bodega no ha podido ser eliminada.'));
         }
	  }
	  catch(\Exception $ex) {
		  $this->Flash->error(__('La bodega no ha podido ser eliminada.')); 
	  }

      return $this->redirect(['action' => 'index']);

    }

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=bodegas.xlsx');

       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');

       $objPHPExcel = new \PHPExcel();

       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Id')->setCellValue('B1', 'Nombre');

       $rows = $this->Bodegas->find('all')->where(['idempr' => $session->read('idempr')]);

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->id)->setCellValue("B$n", $r->nombre);
          $n++;
       }

       $objPHPExcel->getActiveSheet()->setTitle('Simple');

       $objPHPExcel->setActiveSheetIndex(0);

       $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
       $objWriter->save('php://output');

       $this->viewBuilder()->layout('custom');
    }
}
