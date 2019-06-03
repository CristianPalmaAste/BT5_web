<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class ClientesController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->Clientes->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->Clientes->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
		 $cond["idusuaborraregistro is"] = null;
         $cond['idgrem']=$session->read('idgrem');

       

        if ($gre->id!=null) $cond["id"] = $gre->id;
        if ($gre->idgrem!=null) $cond["idgrem"] = $gre->idgrem;
        if ($gre->idpais!=null) $cond["idpais"] = $gre->idpais;
        if ($gre->identificador1!=null) $cond["identificador1 like"] = $gre->identificador1."%";
        if ($gre->identificador2!=null) $cond["identificador2 like"] = $gre->identificador2."%";
        if ($gre->idticl!=null) $cond["idticl"] = $gre->idticl;
        if ($gre->razonsocial!=null) $cond["razonsocial like"] = $gre->razonsocial."%";
        if ($gre->nombrefantasia!=null) $cond["nombrefantasia like"] = $gre->nombrefantasia."%";
        if ($gre->primernombre!=null) $cond["primernombre like"] = $gre->primernombre."%";
        if ($gre->segundonombre!=null) $cond["segundonombre like"] = $gre->segundonombre."%";
        if ($gre->apellidopaterno!=null) $cond["apellidopaterno like"] = $gre->apellidopaterno."%";
        if ($gre->apellidomaterno!=null) $cond["apellidomaterno like"] = $gre->apellidomaterno."%";


        
 
        $Clientes = $this->paginate($this->Clientes->find('all')->where($cond));
		
				
        $this->set("registros", $Clientes); 
		
		$this->llena_lista('paises', 'nombre', false);
		$this->llena_lista('tipos_clientes', 'descripcion', false);
    }

    public function add() {
	   $this->render("edit");
	   
       $session = $this->request->session();

       $gre = $this->Clientes->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post') || $this->request->is('put')) {
		 $this->request->data["idgrem"] = $session->read("idgrem");
		 
	     $gre = $this->Clientes->patchEntity($gre, $this->request->data);
		 
	     if ($this->Clientes->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

		 foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
         //$this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }
	   else
		  $gre->idticl = 1;

       $gre->idgrem = $session->read("idgrem");
       //$gre->idempr = $session->read("idempr");

       $this->set('gre', $gre);
	   
	   $this->llena_lista('paises', 'nombre', false);
       $this->llena_lista('tipos_clientes', 'descripcion', false);


       /*
       $pais  = TableRegistry::get('Paises');
       $rubro = TableRegistry::get('Rubros');
       $gemp  = TableRegistry::get('GruposEmpresariales'); 

       $session = $this->request->session();

       $d = $gemp->get($session->read("idgrem"));

       $this->set("nombreGrupo", $d->nombre);

       $gre->idgrem = $session->read("idgrem");
 
       $this->set('emp', $gre);

        $this->set("paises", $pais->obtPaises());

        $this->set("rubros", $rubro->obtRubros($session->read("idgrem")));
        $this->set("gemp"  , $gemp->obtGruposEmpresariales());
        */
		
		$this->render("edit");
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->Clientes->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {

	      $this->Clientes->patchEntity($gre, $this->request->data);

	      if ($this->Clientes->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);
	   
	   $this->llena_lista('paises', 'nombre', false);
       $this->llena_lista('tipos_clientes', 'descripcion', false);


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

       $gre = $this->Clientes->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);

       $pais  = TableRegistry::get('Paises');
       $this->set("paises", $pais->obtPaises());
       $tipo_cliente  = TableRegistry::get('TiposClientes');

       $this->set("tipos_clientes", $tipo_cliente->obtTiposClientes());


       /*
       $egrem = TableRegistry::get('EstadosGrem');
       $pais  = TableRegistry::get('Paises');
       
       $this->set("paises", $pais->obtPaises());

       $this->set("egrem", $egrem->obtEstadosGrem());
       */

    }
    
    public function delete($id)
    {
	   $this->render("index");
	   
       $session = $this->request->session();

       $registro = $this->Clientes->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

	   //print_r($registro);
	   
       $this->Clientes->save($registro);
	   
	   //return;

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
       header('Content-Disposition: attachment; filename=clientes.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'País')
->setCellValue('B1', 'Rut')
->setCellValue('C1', 'Dv')
->setCellValue('D1', 'Tipo cliente')
->setCellValue('E1', 'Razón Social')
->setCellValue('F1', 'Nombre de Fantasía')
->setCellValue('G1', 'Primer Nombre')
->setCellValue('H1', 'Segundo Nombre')
->setCellValue('I1', 'Apellido Paterno')
->setCellValue('J1', 'Apellido Materno')
;

       $rows = $this->Clientes->find('all')->where(['idgrem' => $session->read('idgrem')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->idpais)
->setCellValue("B$n", $r->identificador1)
->setCellValue("C$n", $r->identificador2)
->setCellValue("D$n", $r->idticl)
->setCellValue("E$n", $r->razonsocial)
->setCellValue("F$n", $r->nombrefantasia)
->setCellValue("G$n", $r->primernombre)
->setCellValue("H$n", $r->segundonombre)
->setCellValue("I$n", $r->apellidopaterno)
->setCellValue("J$n", $r->apellidomaterno)
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
