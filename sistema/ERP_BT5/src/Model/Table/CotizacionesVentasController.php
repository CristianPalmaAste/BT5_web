<?php

namespace App\Controller;

require_once(APP . 'Vendor' . DS . 'grid' . DS. 'grid.php');

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class CotizacionesVentasController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");
		
		$idgrem = 1;

        $gre = $this->CotizacionesVentas->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->CotizacionesVentas->patchEntity($gre, $this->request->data);
        }             
        
        $cond = [];
        $cond['idempr']=$session->read('idempr');
		
		$cond['idempr']=1;

        if ($gre->id!=null) $cond["id"]         = $gre->id;
        if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
        if ($gre->numero!=null) $cond["numero"] = $gre->numero;
        if ($gre->idclie!=null) $cond["idclie"] = $gre->idclie;
        if ($gre->descripcioncotizacion!=null) $cond["descripcioncotizacion like"] = $gre->descripcioncotizacion."%";
        if ($gre->idgere!=null) $cond["idgere"] = $gre->idgere;
        if ($gre->idproy!=null) $cond["idproy"] = $gre->idproy;
        if ($gre->idline!=null) $cond["idline"] = $gre->idline;
        if ($gre->idceco!=null) $cond["idceco"] = $gre->idceco;
        if ($gre->idtare!=null) $cond["idtare"] = $gre->idtare;
        //if ($gre->totallinea!=null) $cond["totallinea"] = $gre->totallinea;
        //if ($gre->porcentajedescuento!=null) $cond["porcentajedescuento"] = $gre->porcentajedescuento;
        //if ($gre->montodescuento!=null) $cond["montodescuento"] = $gre->montodescuento;
        //if ($gre->impuestosobligats!=null) $cond["impuestosobligats"] = $gre->impuestosobligats;
        //if ($gre->total!=null) $cond["total"] = $gre->total;
        //if ($gre->diasvalidez!=null) $cond["diasvalidez"] = $gre->diasvalidez;
        //if ($gre->idescv!=null) $cond["idescv"] = $gre->idescv;

		//print_r($cond);
		
		$est = TableRegistry::get('EstadosCotizacionesVtas'); 
		
		$clie = TableRegistry::get('Clientes'); 
 
        $CotizacionesVentas = $this->paginate($this->CotizacionesVentas->find('all')->where($cond));
		
		foreach($CotizacionesVentas as $c) {
		   $e = $est->get($c->idescv);

           $c->estado = $e->descripcion;		   
		   
		   $cli = $clie->get($c->idclie);
		   
		   if ($cli->razonsocial=="") {
			  $c->cliente = $cli->apellidopaterno ." ".
			                $cli->apellidomaterno ." ".
							$cli->primernombre ." ".
							$cli->segundonombre ." ";
		   }
		   else {
			  $c->cliente = $cli->razonsocial;
		   }
		}

        $this->set("cotizaciones", $CotizacionesVentas); 
    }

    public function add() {
	   $this->render("edit");	
	   
       $session = $this->request->session();
	   
	   $this->set("idgrem", $session->read("idgrem"));
	  
	   $idgrem=$session->read("idgrem");
	   $idempr=$session->read("idempr");
	   
	   $idgrem=1;
	   $idempr=1;
	   
	   $conn = ConnectionManager::get('default');

       $gre = $this->CotizacionesVentas->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {		 
		 $session = $this->request->session();

         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $stmt = $conn->execute("SELECT NEXTVAL('cove_seq');");

         $results = $stmt ->fetchAll('assoc');

         $gre->id =  $results[0]["nextval"];
		 
	     $gre = $this->CotizacionesVentas->patchEntity($gre, $this->request->data);

		 $gre->montodescuento=0;
		 
		 //print_r($gre); return;
		 
		 try {
		 $gre->fechacotizacion = $this->to_date($gre->fechacotizacion);
		 }
		 catch(\Exception $e) {
			print_r($e);
		 }
		 
	     if ($this->CotizacionesVentas->save($gre)) {
			$this->graba_detalle($gre->id);
						
            $this->Flash->success(__('Registro ha sido creado.'));
	        return $this->redirect(['action' => 'index']);
	     }

         //$this->set("errors", $gre->errors());
		 
		 foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.'));

	   }
	   else {

       //$gre->idgrem = $session->read("idgrem");
       $gre->idempr = $idempr;
	   //$gre->fechacotizacion=date("d/m/Y");
	   $gre->idescv = 1;
	   $gre->diasvalidez = 0;
	   $gre->totallinea            = 0;
	   $gre->porcentajedescuento = 0;
	   $gre->montodescuento      = 0;
	   $gre->impuestosobligats   = 0;
	   $gre->impuestosespecifs   = 0;
	   $gre->neto=0;
	   $gre->exento=0;
	   $gre->afecto=0;
	   $gre->total               = 0;
	   }
	   
	   $conn = ConnectionManager::get('default');
	   
       $stmt = $conn->execute("SELECT max(numero) numero from cotizaciones_ventas where idempr=$idempr");

       $results = $stmt ->fetchAll('assoc');

	   if (count($results) > 0)
          $gre->numero =  $results[0]["numero"] + 1;
	   else
		  $gre->numero = 1;

	   //print_r($gre);
	   
       $this->set('gre', $gre);
	   
	   $this->set("idgrem", $idgrem);
	   
	   $this->llena_lista('gerencias', 'nombre', $idempr);
       $this->llena_lista('proyectos', 'nombre', $idempr);
       $this->llena_lista('lineas_negocios', 'nombre', $idempr);
       $this->llena_lista('centros_costos', 'nombre', $idempr);
       $this->llena_lista('tareas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);
       $this->llena_lista('estados_cotizaciones_vtas', 'descripcion');
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('paises', 'nombre', false);
       $this->llena_lista('tipos_clientes', 'descripcion', false);
	   
	   $clie = TableRegistry::get('Clientes'); 
	   
	   $r = $clie->find("all")->where(['idgrem' => $idgrem]);
	   
	   //print_r($r);
	   
	   $lista=[];
	   $lista[""] = "Seleccione";
	   foreach($r as $s) {
		  if ($s->razonsocial=="")
             $razonsocial = $s->apellidopaterno ." ".
                        $s->apellidomaterno ." ".
                        $s->primernombre ." ".
                        $s->segundonombre;
          else
             $razonsocial = $s->razonsocial;			  

 	     $lista[$s->identificador1.$s->identificador2."|".$s->id] = $razonsocial;
		 
	   }   
	   
	   $this->set("clientes", $lista);
	   

       $grid = $this->setGrid();
	   
	   $this->set("grilla", $grid->show());
	   
	   $this->set("nRow", $grid->nRow + 1);
	   
	   $this->render("edit");
    }
	
	function setGrid($rows=array()) {
	   $grid = new miGrilla($rows);
	   
	   $grid->addCol(["name" => "producto"            , "caption" => "Producto",    "size" => 8,  "onblur" => "ob_producto"]);
	   $grid->addCol(["name" => "idprod"              , "gadget" => "hidden"]);
	   $grid->addCol(["name" => "estaexento"          , "gadget" => "hidden"]);
	   $grid->addCol(["name" => "maxdescto"           , "gadget" => "hidden"]);
	   $grid->addCol(["name" => "iva"                 , "gadget" => "hidden"]);
	   $grid->addCol(["name" => "ila"                 , "gadget" => "hidden"]);
	   $grid->addCol(["name" => "iaba"                , "gadget" => "hidden"]);
	   
	   $grid->addCol(["name" => "desproducto"         , "caption" => "Descripción", "size" => 30, "readonly" => true]);
	   $grid->addCol(["name" => "idunmp"              , "caption" => "U.Med.",      "size" => 5,  "readonly" => true]);
	   $grid->addCol(["name" => "preciounitario"      , "caption" => "P.Unit.",     "size" => 10, "readonly" => true, "type" => "N"]);
	   $grid->addCol(["name" => "cantidad"            , "caption" => "Cant",        "size" => 8,  "type" => "N", "onblur" => "ob_cantidad"]);
	   
	   $grid->addCol(["name" => "porcentajedescuento", "caption" => "%Descto1",     "size" => 5, "type" => "N", "onblur" => "ob_porcentajedescuento"]);
	   $grid->addCol(["name" => "montodescuento"     , "caption" => "Mto.Desc.1",   "size" => 9, "type" => "N", "readonly" => true]);
	   $grid->addCol(["name" => "exento"              , "caption" => "Exento",       "size" => 10, "type" => "N", "readonly" => true]);
	   $grid->addCol(["name" => "afecto"              , "caption" => "Afecto",       "size" => 10, "type" => "N", "readonly" => true]);
	   $grid->addCol(["name" => "impuestosobligats"   , "caption" => "Impuestos",    "size" => 10, "type" => "N", "readonly" => true]);
	   $grid->addCol(["name" => "impuestosespecifs"   , "caption" => "I.Específico",    "size" => 10, "type" => "N", "readonly" => true]);
	   $grid->addCol(["name" => "totallinea"          , "caption" => "Sub.Total",    "size" => 10, "readonly" => true, "type" => "N"]); 

	   return $grid;
	}
	
	public function to_date($s) {
	   if (strlen($s)==0) return;

	   $agno = substr($s, 6, 4);
	   $mes  = substr($s, 3, 2);
	   $dia  = substr($s, 0, 2);
	   
	   return date('Y-m-d H:i:s', strtotime($agno."-".$mes."-".$dia));
	}

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->CotizacionesVentas->get($id);
	   
	      
	   $conn = ConnectionManager::get('default');
	  
	   $idgrem=$session->read("idgrem");
	   $idempr=$session->read("idempr");
	   
	   $idgrem=1;
	   $idempr=1;

       $this->set("errors", []); 

	   if ($this->request->is('post') || $this->request->is('put')) {		 
	     //echo "Voy a grabar<br>"; return;
		 
		 $session = $this->request->session();

         $this->request->data["idusuamodifregistro"] = $session->read("idusua");

         $this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');
	 
	      $gre = $this->CotizacionesVentas->patchEntity($gre, $this->request->data);
		  
		 if ($gre->idescv == 1)
			$gre->idescv = 2;
		 else if ($gre->idescv == 2)
            $gre->idescv = 3;
		
		 //print_r($gre); return;
		 
		 try {
		 $gre->fechacotizacion = $this->to_date($gre->fechacotizacion);
		 }
		 catch(\Exception $e) {
			print_r($e);
		 }
		 
		 //$gre->impuestosobligats=0;
         
	     if ($this->CotizacionesVentas->save($gre)) {	
			$stmt = $conn->execute("delete from detalles_cotizs_vtas where idcove=$id");
			
            $this->graba_detalle($gre->id);
			
            $this->Flash->success(__('Registro ha sido creado.'));
	        return $this->redirect(['action' => 'index']);
	     }

         //$this->set("errors", $gre->errors());
		 
		 foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       //$gre->idgrem = $session->read("idgrem");
       $gre->idempr = $idempr;
	   	   
	   $conn = ConnectionManager::get('default');

	   $this->set("idgrem", $idgrem);
	   
	   $Clientes = TableRegistry::get('Clientes');
	   
	   $cc = $Clientes->get($gre->idclie);
	   
	   $gre->rutclie = $cc->identificador1.$cc->identificador2;
	   
	   if ($cc->razonsocial!="")
		  $gre->razclie = $cc->razonsocial;
	   else
		  $gre->razclie = $cc->apellidopaterno.' '.
	                      $cc->apellidomaterno.' '.
						  $cc->primernombre .' '.
						  $cc->segundonombre;
	   
	   $this->set('gre', $gre);
	   
	   $this->llena_lista('gerencias', 'nombre', $idempr);
       $this->llena_lista('proyectos', 'nombre', $idempr);
       $this->llena_lista('lineas_negocios', 'nombre', $idempr);
       $this->llena_lista('centros_costos', 'nombre', $idempr);
       $this->llena_lista('tareas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);
       $this->llena_lista('estados_cotizaciones_vtas', 'descripcion');
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('paises', 'nombre', false);
       $this->llena_lista('tipos_clientes', 'descripcion', false);
	   
	   $det = TableRegistry::get('DetallesCotizsVtas'); 
	   
	   $arr = $det->find("all")->where(["idcove" => $gre->id])->order("id");

	   $this->set("detalle", $arr);
	   
	   $sql = "select a.*, round(a.cantidad*a.preciounitario-a.montodescuento, 0) precio, b.descripcioncorta idunmp,c.familia,c.sub_familia, c.familia, c.sub_familia, c.producto, c.nombre desproducto ".
	          "from detalles_cotizs_vtas a, prodv c, unidades_medidas_productos b ".
	          "where  a.idprod=c.id ".
			  "and    a.idcove= $id ".
			  "and    c.idunmp= b.id ".
			  "order by a.id";
			  
	   //echo $sql."<br/>";
			  
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');

       $this->set("detalle", $results);
	   
	   $grid = $this->setGrid($results);
	   
	   $this->set("grilla", $grid->show());
	   
	   $this->set("nRow", $grid->nRow + 1);

    }
	
	public function graba_detalle($greid) {
		$det = TableRegistry::get('DetallesCotizsVtas'); 
		$n=0;
		$nRow = 50;
			
	    for ($i=0; $i < $nRow; $i++) {
		   $cantidad = isset($_REQUEST["cantidad".$i])?$_REQUEST["cantidad".$i]:"";
           $totallinea = isset($_REQUEST["totallinea".$i])?$_REQUEST["totallinea".$i]:"";;			   
		   
		   if ($cantidad!="" && $totallinea!="") {
			   $n++;
			   
			   $gre2 = $det->newEntity();
			   
			   $preciounitario       = $_REQUEST["preciounitario".$i];
			   
			   $porcentajedescuento  = $_REQUEST["porcentajedescuento".$i];			   
			   $montodescuento       = $_REQUEST["montodescuento".$i];
			   $porcentajedescuento2  = $_REQUEST["porcentajedescuento2".$i];			   
			   $montodescuento2       = $_REQUEST["montodescuento2".$i];
			   
			   $afecto               = $_REQUEST["afecto".$i];
			   $exento               = $_REQUEST["exento".$i];
			   $montodescuento       = $_REQUEST["montodescuento".$i];
			   $impuestosobligats    = $_REQUEST["impuestosobligats".$i];
			   $impuestosespecifs    = $_REQUEST["impuestosoespecifs".$i];
			   $totallinea           = $_REQUEST["totallinea".$i];
			   
			   
		     
               $gre2->correlativo         = $n;
			   $gre2->idcove              = $greid;
               $gre2->idprod              = $_REQUEST["idprod".$i];
               $gre2->cantidad            = $cantidad;
               $gre2->preciounitario       = ($preciounitario=="")?0:$preciounitario;
			   
               $gre2->porcentajedescuento = ($porcentajedescuento=="")?0:$porcentajedescuento;
			   $gre2->montodescuento      = ($montodescuento=="")?0:$montodescuento;
			   
			   $gre2->porcentajedescuento2 = ($porcentajedescuento2=="")?0:$porcentajedescuento2;
			   $gre2->montodescuento2      = ($montodescuento2=="")?0:$montodescuento2;
				  			   
			   $gre2->afecto               = ($afecto=="")?0:$afecto;
               $gre2->exento               = ($exento=="")?0:$exento;
				  
               $gre2->impuestosobligats     = ($impuestosobligats=="")?0:$impuestosobligats;
			   $gre2->impuestosespecifs     = ($impuestosespecifs=="")?0:$impuestosespecifs;
               $gre2->totallinea           = ($totallinea=="")?0:$totallinea;
			   
			   $det->save($gre2);
		   }   
		}		
	}

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->CotizacionesVentas->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);
    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->CotizacionesVentas->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->CotizacionesVentas->save($registro);

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
       header('Content-Disposition: attachment; filename=cotizaciones_ventas.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Número')
                                           ->setCellValue('B1', 'Descripción cotizado')
                                           ->setCellValue('C1', 'Gerencia')
                                           ->setCellValue('D1', 'Proyecto')
                                           ->setCellValue('E1', 'Línea de negocios')
                                           ->setCellValue('F1', 'Centro de Costo')
                                           ->setCellValue('G1', 'Tarea')
                                           ->setCellValue('H1', 'Sub.Total')
                                           ->setCellValue('I1', '%Descto.')
                                           ->setCellValue('J1', 'Mto.Descto.')
                                           ->setCellValue('K1', 'Valor Imptos.')
                                           ->setCellValue('L1', 'Total')
                                           ->setCellValue('M1', 'Días Validez')
                                           ->setCellValue('N1', 'Estado')
                                           ;

       $rows = $this->CotizacionesVentas->find('all')->where(['idempr' => $session->read('idempr')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->numero)
                                              ->setCellValue("B$n", $r->descripcioncotizacion)
                                              ->setCellValue("C$n", $r->idgere)
                                              ->setCellValue("D$n", $r->idproy)
                                              ->setCellValue("E$n", $r->idline)
                                              ->setCellValue("F$n", $r->idceco)
                                              ->setCellValue("G$n", $r->idtare)
                                              ->setCellValue("H$n", $r->totallinea)
                                              ->setCellValue("I$n", $r->porcentajedescuento)
                                              ->setCellValue("J$n", $r->montodescuento)
                                              ->setCellValue("K$n", $r->impuestosobligats)
                                              ->setCellValue("L$n", $r->total)
                                              ->setCellValue("M$n", $r->diasvalidez)
                                              ->setCellValue("N$n", $r->idescv)
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

	public function chkRutclie($idgrem, $rut, $dv) {
	   $this->render("excel");
	   
	   $Clientes = TableRegistry::get('Clientes');
	   
	   $a = $Clientes->find("all")->where(["idgrem" => $idgrem, "identificador1" => $rut, "identificador2" => $dv]);
	   
	   $n=0;
	   $razonsocial="";
	   $nombre     ="";
	   $idclie     ="";
	   foreach($a as $x) {
	      $razonsocial = $x->razonsocial;
		  $nombre      = $x->apellidopaterno." ".$x->apellidomaterno.", ".$x->primernombre." ".$x->segundonombre;
		  $idclie      = $x->id;
	      $n++;
		  break;
	   } 
		   	   
	   $b->cuenta = $n;
	   $b->idclie = $idclie;
	   if ($razonsocial=="")
		  $b->razclie=$nombre;
	   else
		  $b->razclie=$razonsocial;
	   
	   echo json_encode($b);   
	}
	
	public function chkIdprod($idempr, $producto="") {
       $this->render("excel");
	   
	   $conn = ConnectionManager::get('default');

	   if ($producto=="") {
		   $b->cuenta = 0;
	       $b->idunmp ="";
	       $b->preciounitario=$preciounitario;
	  	   
	       echo json_encode($b);    
		  return;
	   }
         		   

	   $prod      = TableRegistry::get('Prodv');
	   
	     
	   $familia     = substr($producto, 0, 2);
	   $sub_familia = substr($producto, 2, 2);
	   $producto    = substr($producto, 4, 4);
	   
	   //echo $familia."-".$sub_familia."-".$producto."<br/>";
	   
	   $r = $prod->find('all')->where(["idempr" => $idempr, "familia" => $familia, "sub_familia" => $sub_familia, "producto" => $producto]);

	   //print_r($r);
	   
       $id=-1;
       foreach($r as $d)
          $id = $d["id"];	   
	   
	   $Productos = TableRegistry::get('Productos');
	   $um        = TableRegistry::get('UnidadesMedidasProductos');
	   $tprod     = TableRegistry::get('TiposProductos');
	   
	   $a = $Productos->find("all")->where(["id" => $id]);
	   
	   $id="";
	   $n=0;
	   $idunmp="";
	   $preciounitario="";
	   $desprod="";
	   $estaexento="S";
	   $iva=0;
	   $ila=0;
	   $iaba=0;
	   
	   foreach($a as $x) {
		  $id = $x->id; 
	      $idunmp = $x->idunmp;
		  
		  $r = $um->get($idunmp);
		  
		  $idunmp = $r->descripcioncorta;
		  $desprod=$x->nombre;
		  
		  //echo "Tipo de producto: ".$x->idtipr."<br/>";
		  
		  $s = $tprod->get($x->idtipr);
		  
		  //echo $s->estaexento."<br/>";
		  
		  $estaexento = $s->estaexento;
		  $idtipr = $x->idtipr;
		  
		  $sql = "select a.*
                  from   impuestos a,
                  tipos_productos_impuestos b
                  where  a.id=b.idimpu
				  and    a.idpais=1
                  and    b.idtipr=$idtipr";

		  $stmt = $conn->execute($sql);
	      $results = $stmt ->fetchAll('assoc');
		  
		  //print_r($results);		  
		  foreach($results as $r) {
			 //print_r($r);
			 
			 switch($r["descripcioncorta"]) {
				case "IVA" : $iva  = $r["valor"]; break;
				case "ILA" : $ila  = $r["valor"]; break;
				case "IABA": $iaba = $r["valor"]; break;
			 }
		  }
	   
	      $n++;
		  break;
	   } 
	   	   	   
       $b = new MiObjeto();
	   $b->id = $id;
	   $b->cuenta = $n;
	   $b->idunmp = $idunmp;
	   $b->preciounitario=0;
	   $b->desprod=$desprod;
	   $b->estaexento=$estaexento;
	   $b->iva=$iva;
	   $b->ila=$ila;
	   $b->iaba=$iaba;
	   $b->maxdescto = 0;
	   
	   $sql = "select a.preciounitario
               from   detalles_listas_precios a
                     ,listas_precios b
               where a.idlipr=b.id
               and  b.idempr=$idempr
               and  b.idesre=1
			   and  a.idprod=$id
       ";
	   
	   if ($id!="") {
		  //echo $sql."<br/>";
		  
	      $conn = ConnectionManager::get('default');
          
          $stmt = $conn->execute($sql);
          
          $results = $stmt ->fetchAll('assoc');
	      
	      foreach($results as $r)
	         $b->preciounitario = $r["preciounitario"];
	   }
	   
	   if ($id!="") {
		  $productos = TableRegistry::get('Productos'); 
		  $s = $productos->get($id);
		  
		  $idsfpr = $s->idsfpr;
		  
		  $subfamilias = TableRegistry::get('SubFamiliasProductos');
		  
		  $s = $subfamilias->get($idsfpr);
		  
		  $idfapr = $s->idfapr;
		  
		  $descuentos = TableRegistry::get('Descuentos');
		  
		  $rows = $descuentos->find("all")->where(["idprod" => $id]);
		  
		  $maxdescto=0;
		  foreach($rows as $r) {
			 $maxdescto = $r->porcentajedescuento;
		  }
		  
		  if ($maxdescto==0) {
			 $rows = $descuentos->find("all")->where(["idsfpr" => $idsfpr]);
			 
			 foreach($rows as $r) {
			    $maxdescto = $r->porcentajedescuento;
		     }
			 
			 if ($maxdescto==0) {
				$rows = $descuentos->find("all")->where(["idfapr" => $idfapr]);
			 
			    foreach($rows as $r) {
			       $maxdescto = $r->porcentajedescuento;
		        }
			 }
		  }
		  
		  $b->maxdescto=$maxdescto;
	   }
	   	  	   
	   echo json_encode($b);   
	}
}

class MiObjeto {
}

class miGrilla extends \Grid {
   public function preShowField($name, $r, $rows) {
	  if ($name=="producto") {
		 $familia = $rows["familia"];
		 $sub_familia = $rows["sub_familia"];
		 $producto = $rows["producto"];
		 
		 $r->props["value"]= $familia.$sub_familia.$producto;
      }		  
	  return $r;
   }
}