<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class DescuentosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");
		$idempr = $session->read("idempr");

        $gre = $this->Descuentos->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->Descuentos->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        $cond = [];
        $cond["descuentos.idusuaborraregistro is"] = null;
        
       

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idfapr!=null) $cond["idfapr"] = $gre->idfapr;
if ($gre->idsfpr!=null) $cond["idsfpr"] = $gre->idsfpr;
if ($gre->idprod!=null) $cond["idprod"] = $gre->idprod;
if ($gre->porcentajedescuento!=null) $cond["porcentajedescuento"] = $gre->porcentajedescuento;
if ($gre->montodescuento!=null) $cond["montodescuento"] = $gre->montodescuento;
if ($gre->idesre!=null) $cond["idesre"] = $gre->idesre;

        $fam = TableRegistry::get("FamiliasProductos"); 
		
		$arr = $fam->find("all")->where(["idempr" => $idempr, "idusuaborraregistro is" => null]);
		
		$fams=[];
		
		foreach($arr as $r) 
		   $fams[] = $r["id"];
		   
		$cond["descuentos.idfapr IN"] = $fams;
 
        $Descuentos = $this->paginate($this->Descuentos->find('all')->where($cond));

		//print_r($Descuentos->toArray());
		
        $this->set("registros", $Descuentos); 
		
           $this->llena_lista("familias_productos", "descripcion", $idempr);
           $this->llena_lista('sub_familias_productos', 'descripcion');
           $this->llena_lista('productos', 'nombre');
           $this->llena_lista('estados_registros', 'descripcion');

    }

    public function add() {
	   $this->render("edit");
	   
	   $this->set("modo", "add");
	
       $session = $this->request->session();

       $gre = $this->Descuentos->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

	     $gre = $this->Descuentos->patchEntity($gre, $this->request->data);
		 
		 $desc = TableRegistry::get('Descuentos');	   
		 
		  $idfapr =$_REQUEST["idfapr"];
		  $idsfpr =$_REQUEST["idsfpr"];
		  $idprod =isset($_REQUEST["idprod"])?$_REQUEST["idprod"]:"";
		  
		  $this->set("idsfpr", $idsfpr);
		  $this->set("idprod", $idprod);
		  
		  $cond=[];

		  $cond["idfapr"] = $idfapr;
		  
		  if ($idsfpr!="") 
			 $cond["idsfpr"] = $idsfpr;
		  
		  if ($idprod!="") 
			 $cond["idprod"] = $idprod;		  
		 
		  $arr = $desc->find("all")->where($cond);
		  
		  $cuenta=0;
		  foreach($arr as $r)
		     $cuenta++;
		 
	      $this->Descuentos->patchEntity($gre, $this->request->data);

		  if ($cuenta > 0) {
             $this->Flash->error(__("Combinación ya ha sido usada."));
		  }
		  else if ($this->Descuentos->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.')); 

	   }
	   else {
		  $gre->idesre = 1;
		  $gre->porcentajedescuento=0;
		  
		  $this->set('sub_familias_productos', []);
	   }

       //$gre->idgrem = $session->read("idgrem");
       //$gre->idempr = $session->read("idempr");
       $idgrem = $session->read("idgrem");
       $idempr = $session->read("idempr");
       $this->llena_lista("familias_productos", "descripcion", $idempr);
       //$this->llena_lista('sub_familias_productos', 'descripcion');
	   //$this->set('sub_familias_productos', []);
       //$this->llena_lista('productos', 'nombre');
	   $this->set("productos", []);
       $this->llena_lista('estados_registros', 'descripcion');
	   
	   if (isset($_REQUEST["idfapr"])) {
		  $idfapr = $_REQUEST["idfapr"];
		  
	      $sfam = TableRegistry::get("SubFamiliasProductos");
	      
          $lst = $sfam->find('all')->where(["idfapr" => $idfapr, "idusuaborraregistro is" => null])->order("descripcion");
	      
	      $l=[];
	      $l[""] = "";
	      foreach($lst as $r)
	         $l[$r["id"]] = $r["descripcion"];
	      
	      $this->set("sub_familias_productos", $l);
	   }

       $this->set('gre', $gre);
	   $this->render("edit");
    }

    public function edit($id=null) {
	   $this->set("modo", "edit");
	
       $session = $this->request->session();
       $gre = $this->Descuentos->get($id);	   

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
		   
		  $gre = $this->Descuentos->patchEntity($gre, $this->request->data);
		  //print_r($gre); 
		  
		  //return;
		  
	      if ($this->Descuentos->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));
	   }
	   
       $idgrem = $session->read("idgrem");
       $idempr = $session->read("idempr");
       $this->llena_lista("familias_productos", "descripcion", $idempr);
       $this->llena_lista('sub_familias_productos', 'descripcion');
       $this->llena_lista('productos', 'nombre');
       $this->llena_lista('estados_registros', 'descripcion');

	   $this->set('gre', $gre);
    }

    public function view($id=null) {
       $session = $this->request->session();
       $idgrem = $session->read("idgrem");
       $idempr = $session->read("idempr");

       $gre = $this->Descuentos->get($id);
       $this->set("errors", []); 
           $this->llena_lista("familias_productos", "descripcion", $idempr);
           $this->llena_lista('sub_familias_productos', 'descripcion');
           $this->llena_lista('productos', 'nombre');
           $this->llena_lista('estados_registros', 'descripcion');

	   $this->set('gre', $gre);

    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->Descuentos->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->Descuentos->save($registro);

       return $this->redirect(['action' => 'index']);

    }
	
	
	public function llena_lista($tbl, $fld, $idempr="") {
	   $l = explode("_", $tbl);
	   
	   $t = "";
	   foreach($l as $p)
	      $t .= ucfirst(strtolower($p));
		  
	   $tabla = TableRegistry::get($t);
	   
	   if ($idempr!="")
		  $lst = $tabla->find('all')->where(["idempr" => $idempr, "idusuaborraregistro is" => null])->order($fld); 
	   else
	      $lst = $tabla->find('all')->where(["idusuaborraregistro is" => null])->order($fld);
	   
	   $l=[];
	   $l[""] = "";
	   foreach($lst as $r)
	      $l[$r["id"]] = $r[$fld];
	   
	   $this->set($tbl, $l);
	   
	}

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=descuentos.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Familia')
->setCellValue('B1', 'Sub.Familia')
->setCellValue('C1', 'Producto')
->setCellValue('D1', '%Descuento')
->setCellValue('E1', 'Mto.Descto')
->setCellValue('F1', 'Estado')
;

       $rows = $this->Descuentos->find('all'); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->idfapr)
->setCellValue("B$n", $r->idsfpr)
->setCellValue("C$n", $r->idprod)
->setCellValue("D$n", $r->porcentajedescuento)
->setCellValue("E$n", $r->montodescuento)
->setCellValue("F$n", $r->idesre)
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

	public function buscaSubfam($idfapr) {
	   $this->render("excel");
	   $session = $this->request->session();
	   
       $idempr = $session->read("idempr");

	   $subfam = TableRegistry::get('SubFamiliasProductos');
	   
	   $r = $subfam->find('all')->where(['idfapr' => $idfapr])->order('descripcion');
	   
	   $o=new MiObjeto;
	   
	   $o->cuenta = count($r);
	   $o->lista  = $r;
	   
	   echo json_encode($o);
	   
	}
	
	public function buscaProds($idsfpr) {
	   $this->render("excel");

	   $prods = TableRegistry::get('Productos');
	   
	   $r = $prods->find('all')->where(['idsfpr' => $idsfpr])->order('nombre');
	   
	   $l = [];
	   foreach($r as $s)
	      $l[] = ["id" => $s["id"], "nombre" => $s["nombre"]];
	   
	   $o=new MiObjeto;
	   
	   $o->cuenta = count($r);
	   $o->lista  = $l;
	   
	   echo json_encode($o);
	}
    
}

class MiObjeto {
}