<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class ProveedoresController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");
		$idempr = $session->read("idempr");
		
		$prove = TableRegistry::get("Provv");

        $gre = $prove->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $prove->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        
        $cond = [];
        //$cond["idusuaborraregistro is"] = null;
         $cond['idgrem']=$session->read('idgrem');

       

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idgrem!=null) $cond["idgrem"] = $gre->idgrem;
if ($gre->idpais!=null) $cond["idpais"] = $gre->idpais;
if ($gre->identificador1!=null) $cond["identificador1 like"] = $gre->identificador1."%";
if ($gre->identificador2!=null) $cond["identificador2 like"] = $gre->identificador2."%";
if ($gre->idtipp!=null) $cond["idtipp"] = $gre->idtipp;
if ($gre->razonsocial!=null) $cond["razonsocial like"] = $gre->razonsocial."%";
if ($gre->nombrefantasia!=null) $cond["nombrefantasia like"] = $gre->nombrefantasia."%";
if ($gre->primernombre!=null) $cond["primernombre like"] = $gre->primernombre."%";
if ($gre->segundonombre!=null) $cond["segundonombre like"] = $gre->segundonombre."%";
if ($gre->apellidopaterno!=null) $cond["apellidopaterno like"] = $gre->apellidopaterno."%";
if ($gre->apellidomaterno!=null) $cond["apellidomaterno like"] = $gre->apellidomaterno."%";

 
        $Proveedores = $this->paginate($prove->find('all')->where($cond));

        $this->set("registros", $Proveedores); 
		
	   //$this->llena_lista('gerencias', 'nombre', $idempr);
       //$this->llena_lista('proyectos', 'nombre', $idempr);
       //$this->llena_lista('lineas_negocios', 'nombre', $idempr);
       //$this->llena_lista('centros_costos', 'nombre', $idempr);
       //$this->llena_lista('tareas', 'nombre', $idempr);
	   //$this->llena_lista('productos', 'nombre', $idempr);
       //$this->llena_lista('estados_notas_vtas', 'descripcion');
	   //$this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   //$this->llena_lista('bodegas', 'nombre', $idempr);		
       //$this->llena_lista('tipos_requisiciones', 'descripcion');	 
       //$this->llena_lista('estados_requisiciones', 'descripcion');	 	   
	   $this->llena_lista('paises', 'nombre');	 	   

    }

    public function add() {
	   $this->render("edit");
       $session = $this->request->session();

       $gre = $this->Proveedores->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

	     $gre = $this->Proveedores->patchEntity($gre, $this->request->data);
		 
		 if ($gre->idtipp==1) {
			unset($gre->razonsocial   );
			unset($gre->nombrefantasia);
		 }
		 else {
			unset($gre->primernombre   );
			unset($gre->segundonombre  );
			unset($gre->apellidopaterno);
			unset($gre->apellidomaterno);
			
		 }

	     if ($this->Proveedores->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.')); 

	   } else {
	     $gre->idpais=1;
		 $gre->idtipp=2;
	   }

       $gre->idgrem = $session->read("idgrem");
       //$gre->idempr = $session->read("idempr");

       $this->set('gre', $gre);
	   $this->llena_lista('paises', 'nombre');	 
	   $this->llena_lista('tipos_proveedores', 'descripcion');	 
	   
	   $this->render("edit");
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->Proveedores->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->Proveedores->patchEntity($gre, $this->request->data);
		  
		 if ($gre->idtipp==1) {
			unset($gre->razonsocial   );
			unset($gre->nombrefantasia);
		 }
		 else {
			unset($gre->primernombre   );
			unset($gre->segundonombre  );
			unset($gre->apellidopaterno);
			unset($gre->apellidomaterno);
			
		 }

	      if ($this->Proveedores->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);
	   
	   $this->llena_lista('paises', 'nombre');	 
	   $this->llena_lista('tipos_proveedores', 'descripcion');	 
    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->Proveedores->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);

    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->Proveedores->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->Proveedores->save($registro);

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
       header('Content-Disposition: attachment; filename=proveedores.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'id')
->setCellValue('B1', 'idgrem')
->setCellValue('C1', 'País')
->setCellValue('D1', 'Rut')
->setCellValue('E1', 'Dv')
->setCellValue('F1', 'Tipo Proveedor')
->setCellValue('G1', 'Razón Social')
->setCellValue('H1', 'Nombre de Fantasía')
->setCellValue('I1', 'Primer Nombre')
->setCellValue('J1', 'Segundo Nombre')
->setCellValue('K1', 'Apellido Paterno')
->setCellValue('L1', 'Apellido Materno')
;

       $rows = $this->Proveedores->find('all')->where(['idgrem' => $session->read('idgrem')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->id)
->setCellValue("B$n", $r->idgrem)
->setCellValue("C$n", $r->idpais)
->setCellValue("D$n", $r->identificador1)
->setCellValue("E$n", $r->identificador2)
->setCellValue("F$n", $r->idtipp)
->setCellValue("G$n", $r->razonsocial)
->setCellValue("H$n", $r->nombrefantasia)
->setCellValue("I$n", $r->primernombre)
->setCellValue("J$n", $r->segundonombre)
->setCellValue("K$n", $r->apellidopaterno)
->setCellValue("L$n", $r->apellidomaterno)
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
