<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class FondosARendirController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");
		$idempr = $session->read("idempr");

        $gre = $this->FondosARendir->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->FondosARendir->patchEntity($gre, $this->request->data);
        }             

		$this->set("gre", $gre);
        
        $cond = [];
		$cond["idusuaborraregistro is"] = null;
        $cond['idempr']=$session->read('idempr');

       
        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
if ($gre->correlativo!=null) $cond["correlativo"] = $gre->correlativo;
if ($gre->monto!=null) $cond["monto"] = $gre->monto;
if ($gre->idgere!=null) $cond["idgere"] = $gre->idgere;
if ($gre->idproy!=null) $cond["idproy"] = $gre->idproy;
if ($gre->idline!=null) $cond["idline"] = $gre->idline;
if ($gre->idceco!=null) $cond["idceco"] = $gre->idceco;
if ($gre->idtare!=null) $cond["idtare"] = $gre->idtare;

 
        $FondosARendir = $this->paginate($this->FondosARendir->find('all')->where($cond));

        $this->set("registros", $FondosARendir); 
		
		$this->llena_lista('gerencias', 'nombre', $idempr);
        $this->llena_lista('proyectos', 'nombre', $idempr);
        $this->llena_lista('lineas_negocios', 'nombre', $idempr);
        $this->llena_lista('centros_costos', 'nombre', $idempr);
        $this->llena_lista('tareas', 'nombre', $idempr);
	    $this->llena_lista('productos', 'nombre', $idempr);
        $this->llena_lista('estados_notas_vtas', 'descripcion');
	    $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	    $this->llena_lista('bodegas', 'nombre', $idempr);	
    }

    public function add() {
		$this->render("edit");
		
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");
		$idempr = $session->read("idempr");

       $gre = $this->FondosARendir->newEntity();
	   
	   $conn = ConnectionManager::get('default');

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
		 $gre = $this->FondosARendir->patchEntity($gre, $this->request->data);
		   
		 $sql = "select max(correlativo) correlativo from fondos_a_rendir where idempr=$idempr";
              
	     $stmt = $conn->execute($sql);

         $r = $stmt ->fetchAll('assoc');
		 
		 if (count($r)==0)
			$gre->correlativo = 1;
	     else
			$gre->correlativo = $r[0]["correlativo"] + 1;
		
	     if ($this->FondosARendir->save($gre)) {
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
	   
	   $this->llena_lista('gerencias', 'nombre', $idempr);
       $this->llena_lista('proyectos', 'nombre', $idempr);
       $this->llena_lista('lineas_negocios', 'nombre', $idempr);
       $this->llena_lista('centros_costos', 'nombre', $idempr);
       $this->llena_lista('tareas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);
       $this->llena_lista('estados_notas_vtas', 'descripcion');
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('bodegas', 'nombre', $idempr);	
	   
	   $this->render("edit");
    }

    public function edit($id=null) {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");
		$idempr = $session->read("idempr");
		
       $gre = $this->FondosARendir->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->FondosARendir->patchEntity($gre, $this->request->data);

	      if ($this->FondosARendir->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);
	   
	   $this->llena_lista('gerencias', 'nombre', $idempr);
       $this->llena_lista('proyectos', 'nombre', $idempr);
       $this->llena_lista('lineas_negocios', 'nombre', $idempr);
       $this->llena_lista('centros_costos', 'nombre', $idempr);
       $this->llena_lista('tareas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);
       $this->llena_lista('estados_notas_vtas', 'descripcion');
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('bodegas', 'nombre', $idempr);	
    }
	
	public function setGrid($arr=[]) {
		
	}

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->FondosARendir->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);

    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->FondosARendir->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->FondosARendir->save($registro);

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
       header('Content-Disposition: attachment; filename=fondos_a_rendir.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Correlativo')
->setCellValue('B1', 'Monto')
->setCellValue('C1', 'Gerencia')
->setCellValue('D1', 'Proyecto')
->setCellValue('E1', 'Línea de negocios')
->setCellValue('F1', 'Centro de costos')
->setCellValue('G1', 'Tarea')
;

       $rows = $this->FondosARendir->find('all')->where(['idempr' => $session->read('idempr')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->correlativo)
->setCellValue("B$n", $r->monto)
->setCellValue("C$n", $r->idgere)
->setCellValue("D$n", $r->idproy)
->setCellValue("E$n", $r->idline)
->setCellValue("F$n", $r->idceco)
->setCellValue("G$n", $r->idtare)
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


