<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class ProductosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idempr = $session->read("idempr");
		
		$Productos = TableRegistry::get("prodv");

        $gre = $Productos->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $Productos->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        $cond = [];
        //$cond["idusuaborraregistro is"] = null;
        $cond['idempr']=$session->read('idempr');

       

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
if ($gre->idsfpr!=null) $cond["idsfpr"] = $gre->idsfpr;
if ($gre->idtipr!=null) $cond["idtipr"] = $gre->idtipr;
if ($gre->idunmp!=null) $cond["idunmp"] = $gre->idunmp;
if ($gre->idorpr!=null) $cond["idorpr"] = $gre->idorpr;
if ($gre->nombre!=null) $cond["nombre like"] = $gre->nombre."%";
if ($gre->correlativoflia!=null) $cond["correlativoflia like"] = $gre->correlativoflia."%";
if ($gre->sku!=null) $cond["sku like"] = $gre->sku."%";
if ($gre->ean13!=null) $cond["ean13 like"] = $gre->ean13."%";
if ($gre->qr!=null) $cond["qr like"] = $gre->qr."%";
if ($gre->pesounitariokg!=null) $cond["pesounitariokg"] = $gre->pesounitariokg;
if ($gre->idesre!=null) $cond["idesre"] = $gre->idesre;


        $Prods = $this->paginate($Productos->find('all')->where($cond));

		//print_r($Prods);
        $this->set("registros", $Prods); 
    }

    public function add() {
	   $this->render("edit");
	   
       $session = $this->request->session();
	   $idempr  = $session->read("idempr");

       $gre = $this->Productos->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

	     $gre = $this->Productos->patchEntity($gre, $this->request->data);
		 
		 $conn = ConnectionManager::get('default');

	     $sql = "select max(id) maximo from productos where idsfpr=".$gre->idsfpr;
   
	     $stmt = $conn->execute($sql);

         $results = $stmt ->fetchAll('assoc');
		 
		 if (count($results)> 0)
			$gre->correlativoflia = str_pad($results[0]["maximo"] + 1, 4, "0", STR_PAD_LEFT);
		 else
			$gre->correlativoflia = "0001";

	     if ($this->Productos->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.')); 

	   }
	   else {
		  $gre->idesre=1;
		  $gre->idorpr=1;
		  $gre->idunmp=9;
	   }
	   
	   $this->llenaFamilias($idempr);
       $this->set("sub_familias_productos", []);
       $this->llena_lista('tipos_productos', 'descripcion');
       $this->llena_lista('unidades_medidas_productos', 'descripcion');
       $this->llena_lista('origenes_productos', 'descripcion');
       $this->llena_lista('estados_registros', 'descripcion');


       //$gre->idempr = $session->read("idempr");
       $gre->idempr = $session->read("idempr");

       $this->set('gre', $gre);
	   
	   $this->render("edit");
    }

    public function edit($id=null) {
       $session = $this->request->session();
	   $idempr  = $session->read("idempr");
	   
       $gre = $this->Productos->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
		  
		  
	      $this->Productos->patchEntity($gre, $this->request->data);		  
		  
		  print_r($gre);
		  
	      if ($this->Productos->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   	   $this->llenaFamilias($idempr);
		   
		   
		   $sfam = TableRegistry::get("sub_familias_productos");
		   
		   
	   
	       $d = $sfam->get($gre->idsfpr);
		   
		   $gre->idfapr = $d->id;
		   
	  
	   
           $this->llenaSubFams($d->id);
		   //$this->set("sub_familias_productos", []);
           $this->llena_lista('tipos_productos', 'descripcion');
           $this->llena_lista('unidades_medidas_productos', 'descripcion');
           $this->llena_lista('origenes_productos', 'descripcion');
           $this->llena_lista('estados_registros', 'descripcion');

	   $this->set('gre', $gre);
    }
	
	function llenaSubFams($idfapr) {
	   $sfam = TableRegistry::get('sub_familias_productos');
	     
	   $r = $sfam->find('all')->where(['idfapr' => $idfapr])->order('descripcion');
	   
	   $l[""] = "";
	   foreach($r as $s) 
	      $l[$s["id"]] = $s["descripcion"];
		  
	   $this->set("sub_familias_productos", $l);
	}
	
	function llenaFamilias($idempr) {
	   //$fam  = TableRegistry::get('familias_productos');
	   
	   $f=[];
	   //$r = $fam->find('all')->where(['idempr' => $idempr])->order(["descripcion"]);
	   
	   //print_r($r);
	   
	   $conn = ConnectionManager::get('default');

	   $sql = "select * 
	           from   familias_productos 
			   where  idempr=$idempr 
			   and    id in (select idfapr from sub_familias_productos)
			   and    idusuaborraregistro is null
			   order by descripcion";
   
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
		 
	   
	   $f[""]="";
	   foreach($results as $s)
	      $f[$s["id"]] = $s["descripcion"];	   
		  
	   $this->set("familias_productos", $f);
	}

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->Productos->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);

       $sub_familia  = TableRegistry::get('SubFamiliasProductos');
       $this->set("sub_familias", $sub_familia->obtSubFamilias());

       $tipo_producto  = TableRegistry::get('TiposProductos');
       $this->set("tipos_productos", $tipo_producto -> obtTiposProductos());

       $unidad_medida  = TableRegistry::get('UnidadesMedidasProductos');
       $this->set("unidades_medidas", $unidad_medida -> obtUnidadesMedidasProductos());

       $origen_producto  = TableRegistry::get('OrigenesProductos');
       $this->set("origenes_productos", $origen_producto -> obtOrigenesProductos());

       $estado_producto  = TableRegistry::get('EstadosRegistros');
       $this->set("estados_productos", $estado_producto -> obtEstadosRegistros());


    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->Productos->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

	   try {
          $this->Productos->save($registro);
		  $this->Flash->success(__('Producto ha sido eliminado.'));
	   }
	   catch(\Exception $e) {
		  $this->Flash->success(__('Producto no ha podido ser eliminado.'));
	   }

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
	   
	   $l[""] = "";
	   foreach($lst as $r)
	      $l[$r["id"]] = $r[$fld];
	   
	   $this->set($tbl, $l);
	   
	}

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=productos.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Sub.Familia')
->setCellValue('B1', 'Tipo Producto')
->setCellValue('C1', 'Unidad Medida')
->setCellValue('D1', 'Origen Producto')
->setCellValue('E1', 'Nombre')
->setCellValue('F1', 'Correlativo')
->setCellValue('G1', 'Sku')
->setCellValue('H1', 'Ean13')
->setCellValue('I1', 'Qr')
->setCellValue('J1', 'Peso Unit.Kg')
->setCellValue('K1', 'Estado')
;

       $rows = $this->Productos->find('all')->where(['idempr' => $session->read('idempr')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->idsfpr)
->setCellValue("B$n", $r->idtipr)
->setCellValue("C$n", $r->idunmp)
->setCellValue("D$n", $r->idorpr)
->setCellValue("E$n", $r->nombre)
->setCellValue("F$n", $r->correlativoflia)
->setCellValue("G$n", $r->sku)
->setCellValue("H$n", $r->ean13)
->setCellValue("I$n", $r->qr)
->setCellValue("J$n", $r->pesounitariokg)
->setCellValue("K$n", $r->idesre)
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
	
	public function getSubfams($idfapr) {
       $this->render("excel");
	   
	   $conn = ConnectionManager::get('default');

	   $sql = "select * from sub_familias_productos where idfapr=$idfapr order by descripcion";
	   
	   //echo $sql."<hr/>";
   
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   //print_r($results);
	   
		 
	   if (count($results)==0) {
		   $b = new MiObjeto;
		   
		   $b->cuenta = 0;
	  	   
	       echo json_encode($b);    
 		   return;
	   }
	   
	   $b = new MiObjeto;
	   $b->cuenta=1;
	  	   
	   $l="";
	   foreach($results as $r) {
		  if ($l!="") $l .= ";";
		  
		  $l .=$r["id"]."|".$r["descripcion"];
	   }
	   	   
	   $b->subfam=$l;

	   echo json_encode($b);   
	}

    
}

class MiObjeto {
}
