<?php

namespace App\Controller;

require_once(APP . 'Vendor' . DS . 'grid' . DS. 'grid.php');

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class ListasPreciosController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->ListasPrecios->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->ListasPrecios->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
        $cond['idempr']=$session->read('idempr');
		$cond['fechaborraregistro is'] = null;

        if ($gre->id!=null) $cond["id"] = $gre->id;
        if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
        if ($gre->correlativo!=null) $cond["correlativo"] = $gre->correlativo;
        if ($gre->fechainicio!=null) $cond["fechainicio like"] = $gre->fechainicio."%";
        if ($gre->fechafin!=null) $cond["fechafin like"] = $gre->fechafin."%";
        if ($gre->observaciones!=null) $cond["observaciones like"] = $gre->observaciones."%";
        if ($gre->idesre!=null) $cond["idesre"] = $gre->idesre;

		//print_r($cond);
 
        $ListasPrecios = $this->paginate($this->ListasPrecios->find('all')->where($cond));

        $this->set("registros", $ListasPrecios); 
		
		$this->llena_lista("estados_registros", "descripcion");
		
    }

    public function add() {
	   $this->render("edit");	
	   
       $session = $this->request->session();
	   $idempr  = $session->read("idempr");

       $gre = $this->ListasPrecios->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

	     $gre = $this->ListasPrecios->patchEntity($gre, $this->request->data);
		 
		 
	     $conn = ConnectionManager::get('default');
	   
          $stmt = $conn->execute("SELECT max(correlativo) numero from listas_precios where idempr=$idempr");

          $results = $stmt ->fetchAll('assoc');

	      if (count($results) > 0)
             $gre->correlativo =  $results[0]["numero"] + 1;
	      else
		     $gre->correlativo = 1;

		 try {
			 $conn->begin();
    	     if ($this->ListasPrecios->save($gre)) {
    			  $this->graba_detalle($gre->id);
    			  
    			  $conn->commit();
    			  
    	          $this->Flash->success(__('Registro ha sido creado.'));
    	          return $this->redirect(['action' => 'index']);
    	     } else {
			 	$this->set("errors", $gre->errors());
			 	throw new \Exception(__('No se puede crear el registro.'));
			 }
		 }
		 catch(\Exception $ex) {
			//echo $ex;
			$conn->rollback();
		 }

         foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.')); 

	   }
	   
	   $conn = ConnectionManager::get('default');
	   
       $stmt = $conn->execute("SELECT max(correlativo) numero from listas_precios where idempr=$idempr");

       $results = $stmt ->fetchAll('assoc');

	   if (count($results) > 0)
          $gre->correlativo =  $results[0]["numero"] + 1;
	   else
		  $gre->correlativo = 1;

       //$gre->idgrem = $session->read("idgrem");
       $gre->idempr = $session->read("idempr");
	   
	         
	   $grid = $this->setGrid();
	   
	   $this->set('grilla', $grid->show());
	   
	   $this->set('extrajs', $grid->genGridJs());
	   
	   $this->set('nRow', $grid->nRow + 1);
	                     
       $this->set('gre', $gre);
	   
	   $this->llena_lista("estados_registros", "descripcion");
	   
	   $this->render("edit");
    }

    public function edit($id=null) {
       $session = $this->request->session();
	   $idempr  = $session->read("idempr");
       
	   $gre = $this->ListasPrecios->get($id);
	   
	   $conn = ConnectionManager::get('default');

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {	   
	      $this->ListasPrecios->patchEntity($gre, $this->request->data);
		  
		  $gre->id = $id;
		  
		  try {
			  $conn->begin();
			  
    	      if ($this->ListasPrecios->save($gre)) {  			 
    			 $sql = "delete from detalles_listas_precios where idlipr=$id";
    			 $stmt = $conn->execute($sql);
    			 
    			 $this->graba_detalle($id); 
    			 
    			 $conn->commit();
    			 
    			 $this->Flash->success(__('Registro ha sido actualizado.'));
    			 
    	         return $this->redirect(['action' => 'index']);
    	      }else {
			 	$this->set("errors", $gre->errors());
			 	throw new \Exception(__('No se puede crear el registro.'));
			 }
		  }
		 catch(\Exception $ex) {
			//echo $ex;
			$conn->rollback();
		 }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               throw new \Exception(__($v));
			   
	      throw new \Exception(__('No se puede modificar el registro.'));

	   }
	   
	    $sql = "	select a.id idprod
	                 , c.cod_familia||b.cod_sub_familia||a.correlativoflia producto
					 , c.cod_familia||b.cod_sub_familia||a.correlativoflia||'#'||a.id
					 , a.nombre desprod2
					 , d.preciounitario  valorunitario
                from   productos a,
                       sub_familias_productos b,
                       familias_productos c,
					   detalles_listas_precios d
                where  b.idfapr=c.id
				and    b.id=a.idsfpr
				and    a.idempr=$idempr
				and    d.idlipr=$id
				and    a.id=d.idprod
                and    a.fechaborraregistro is null";
				
	   //echo $sql;
	   
       $stmt = $conn->execute($sql);
          
       $results = $stmt ->fetchAll('assoc');
	   
	   
	   $grid = $this->setGrid($results);
	   
	   $this->set('grilla', $grid->show());
	   
	   $this->set('extrajs', $grid->genGridJs());
	   
	   $this->set('nRow', $grid->nRow + 1);

	   $this->set('gre', $gre);
	   
	   $this->llena_lista("estados_registros", "descripcion");
    }
	
	public function graba_detalle($greid) {
		$det = TableRegistry::get('DetallesListasPrecios'); 
		$n=0;
		$nRow = 50;
		
		$allRows = $_REQUEST["allRows"];
		
		//echo $allRows."<br/>";
		
		$filas = explode("@@@", $allRows);
			
	    foreach($filas as $data) {
		   $e = explode("|", $data);
		   
		   $e = explode("|", $data);
		   
		   //print_r($e);
		   
		   $idprod              = $e[4];
		   $idlipr              = $greid;
		   $preciounitario      = $e[3];
		 	
		   $n++;
		   
		   $gre2 = $det->newEntity();
		   
		   $gre2->idlipr              = $idlipr;
           $gre2->idprod              = $idprod;
          
           $gre2->preciounitario      = $preciounitario;
		   
	
		   $det->save($gre2);
		   
		}
			
	    
	}
	
	public function setGrid($arr=[]) {
		
	   $session = $this->request->session();
	   $idempr  = $session->read("idempr");
	   
	   $productos = $this->listaProductos($idempr);
		
	 $grid = new miGrilla($arr);
	               
	 
				   
     $grid->addCol(['name' => 'producto', 
	                'caption' => 'Producto',    
					'size' => 8,  
					'type' => 'C',
					'required' => true,  
				   ]
				   );		

     $grid->addCol(['name' => 'desprod2', 
	                'caption' => 'Descripción',    
                    "gadget" => "hidden"
				   ]
				   );				   
			  
	 $grid->addCol(['name' => 'desprod', 
	                'caption' => 'Descripción',    
                    "gadget" => "select", 
					"selvalues" => $productos, 
				   ]
				   );
				   
	 $grid->addCol(['name' => 'valorunitario', 
	                'caption' => 'Precio',    
					'size' => 20,  
					'type' => 'N',
					'required' => true,  

				   ]
				   );
			  
	 $grid->addCol(['name' => 'idprod', 
	                'caption' => 'Producto',    
					'size' => 20,  
					'type' => 'N',
					'gadget' => 'hidden',  
				   ]
				   );			   
				   
	   return $grid;

	}
	
	function listaProductos($idempr) {   
	   $conn = ConnectionManager::get('default');
	   
	   //$idempr=1; $idbode=1;
       
	   $sql = "	select a.id
	                 , c.cod_familia||b.cod_sub_familia||a.correlativoflia producto
					 , a.nombre desprod
                from   productos a,
                       sub_familias_productos b,
                       familias_productos c
                where  b.idfapr=c.id
				and    a.idempr=$idempr
                and    a.idsfpr=b.id
                and    a.fechaborraregistro is null";
	   
       $stmt = $conn->execute($sql);
          
       $results = $stmt ->fetchAll('assoc');
	   
	   //echo $sql."<hr/>";
	   
	   $salida="";
	   
	   $l = [];
	   $l[""] = "Seleccione producto";
	   foreach($results as $r) {
		  $l[$r["producto"]."#".$r["id"]] = $r["desprod"];		  
	   }
	   
	   return $l;
    }
	
    public function view($id=null) {
	   $conn = ConnectionManager::get('default');	
       $session = $this->request->session();
	   $idempr  = $session->read("idempr");

       $gre = $this->ListasPrecios->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);
	   
	   
         $sql = "	select a.id idprod
	                 , c.cod_familia||b.cod_sub_familia||a.correlativoflia producto
					 , a.nombre desprod
					 , d.preciounitario  valorunitario
                from   productos a,
                       sub_familias_productos b,
                       familias_productos c,
					   detalles_listas_precios d
                where  b.idfapr=c.id
				and    b.id=a.idsfpr
				and    a.idempr=$idempr
				and    d.idlipr=$id
				and    a.id=d.idprod
                and    a.fechaborraregistro is null";
				
	   //echo $sql;
	   
       $stmt = $conn->execute($sql);
          
       $results = $stmt ->fetchAll('assoc');
	  	   
	   $this->llena_lista("estados_registros", "descripcion");
	   
	   $grid = $this->setGrid($results);
	   $grid->readonly = true;
	   
	   $this->set('grilla', $grid->show());
	   
	   $this->set('extrajs', $grid->genGridJs());
	   
	   $this->set('nRow', $grid->nRow + 1);
    }
    
    public function delete($id)
    {
	   //echo "Entre a delete<hr/>";
       $session = $this->request->session();

       $registro = $this->ListasPrecios->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->ListasPrecios->save($registro);

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
       header('Content-Disposition: attachment; filename=listas_precios.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Correlativo')
->setCellValue('B1', 'Fecha Inicio')
->setCellValue('C1', 'Fecha Fin')
->setCellValue('D1', 'Observaciones')
->setCellValue('E1', 'Estado')
;

       $rows = $this->ListasPrecios->find('all')->where(['idempr' => $session->read('idempr')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->correlativo)
->setCellValue("B$n", $r->fechainicio)
->setCellValue("C$n", $r->fechafin)
->setCellValue("D$n", $r->observaciones)
->setCellValue("E$n", $r->idesre)
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
	
	public function chkIdesre($idempr, $correlativo) {
       $this->render("excel");
	   
	   $arr = $this->ListasPrecios->find("all")->where(["idempr" => $idempr, "correlativo !=" => $correlativo, "idesre" => 1])->toArray();
	   
	   $b = new MiObjeto;
	   $b->correlativo = $correlativo;
	   
	   if (count($arr) > 0) {
          //print_r($arr[0]);
		  
		  $b->cuenta = 1;
		  $b->correlativo = $arr[0]["correlativo"];
	   }
	   else {
		  $b->cuenta = 0;
	   }
	   
	   echo json_encode($b);   
	}

    
}

class MiObjeto {
}

class miGrilla extends \Grid {
   public function preShowField($name, $r, $rows=array()) {
	  if ($name=="producto" && isset($rows["familia"])) {
		 $familia = $rows["familia"];
		 $sub_familia = $rows["sub_familia"];
		 $producto = $rows["producto"];
		 
		 $r->props["value"]= $familia.$sub_familia.$producto;
      }		  
	  return $r;
   }
}
