<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class UnidadesTerritorialesController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->UnidadesTerritoriales->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->UnidadesTerritoriales->patchEntity($gre, $this->request->data);
        }             

		$this->set("gre", $gre);
        
        $cond = [];
		//$cond["idusuaborraregistro is"] = null;
        
       
        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idpais!=null) $cond["idpais"] = $gre->idpais;
if ($gre->iduntepadre!=null) $cond["iduntepadre"] = $gre->iduntepadre;
if ($gre->nombre!=null) $cond["nombre like"] = $gre->nombre."%";
if ($gre->orden!=null) $cond["orden"] = $gre->orden;
if ($gre->profundidad!=null) $cond["profundidad"] = $gre->profundidad;

 
        $UnidadesTerritoriales = $this->paginate($this->UnidadesTerritoriales->find('all')->where($cond));

        $this->set("registros", $UnidadesTerritoriales); 
		
	    $tabla = TableRegistry::get("Paises");
	    $this->set("paises", $tabla->obtPaises());
    }

    public function add() {
       $session = $this->request->session();

       $gre = $this->UnidadesTerritoriales->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

	     $gre = $this->UnidadesTerritoriales->patchEntity($gre, $this->request->data);

	     if ($this->UnidadesTerritoriales->save($gre)) {
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
	   
	   $tabla = TableRegistry::get("Paises");
	   $this->set("paises", $tabla->obtPaises());
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->UnidadesTerritoriales->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->UnidadesTerritoriales->patchEntity($gre, $this->request->data);

	      if ($this->UnidadesTerritoriales->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);
	   
	   $tabla = TableRegistry::get("Paises");
	   $this->set("paises", $tabla->obtPaises());
    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->UnidadesTerritoriales->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);

    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->UnidadesTerritoriales->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->UnidadesTerritoriales->save($registro);

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
       header('Content-Disposition: attachment; filename=unidades_territoriales.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Id')
->setCellValue('B1', 'País')
->setCellValue('C1', 'U.Territorial Padre')
->setCellValue('D1', 'Nombre')
->setCellValue('E1', 'Órden')
->setCellValue('F1', 'Profundidad')
;

       $rows = $this->UnidadesTerritoriales->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->id)
->setCellValue("B$n", $r->idpais)
->setCellValue("C$n", $r->iduntepadre)
->setCellValue("D$n", $r->nombre)
->setCellValue("E$n", $r->orden)
->setCellValue("F$n", $r->profundidad)
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
