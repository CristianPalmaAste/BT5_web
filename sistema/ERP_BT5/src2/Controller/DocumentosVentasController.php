<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class DocumentosVentasController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");
		
		$idgrem = 1;

        $gre = $this->DocumentosVentas->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->DocumentosVentas->patchEntity($gre, $this->request->data);
        }   

        $this->set("gre", $gre);
        
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
        $cond['idempr']=$session->read('idempr');
		
		$cond['idempr']=1;

        if ($gre->id!=null) $cond["id"] = $gre->id;
        if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
        if ($gre->numero!=null) $cond["numero"] = $gre->numero;
        if ($gre->idclie!=null) $cond["idclie"] = $gre->idclie;
        if ($gre->descripciondoctoventa!=null) $cond["descripciondoctoventa like"] = $gre->descripciondoctoventa."%";
        if ($gre->idgere!=null) $cond["idgere"] = $gre->idgere;
        if ($gre->idproy!=null) $cond["idproy"] = $gre->idproy;
        if ($gre->idline!=null) $cond["idline"] = $gre->idline;
        if ($gre->idceco!=null) $cond["idceco"] = $gre->idceco;
        if ($gre->idtare!=null) $cond["idtare"] = $gre->idtare;
        //if ($gre->totallinea!=null) $cond["totallinea"] = $gre->totallinea;
        //if ($gre->porcentajedescuento!=null) $cond["porcentajedescuento"] = $gre->porcentajedescuento;
        //if ($gre->montodescuento!=null) $cond["montodescuento"] = $gre->montodescuento;
        //if ($gre->impuestos!=null) $cond["impuestos"] = $gre->impuestos;
        //if ($gre->total!=null) $cond["total"] = $gre->total;
        //if ($gre->diasvalidez!=null) $cond["diasvalidez"] = $gre->diasvalidez;
        //if ($gre->idesve!=null) $cond["idesve"] = $gre->idesve;

		//print_r($cond);
		
		$est = TableRegistry::get('EstadosVentas'); 
		
		$clie = TableRegistry::get('Clientes'); 
 
        $DocumentosVentas = $this->paginate($this->DocumentosVentas->find('all')->where($cond));
		
		foreach($DocumentosVentas as $c) {
		   $e = $est->get($c->idesve);

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
		   
		   //print_r($c);
			
		   
		}

        $this->set("cotizaciones", $DocumentosVentas); 
    }

    public function add() {
       $session = $this->request->session();
	   
	   $this->set("idgrem", $session->read("idgrem"));
	  
	   $idgrem=$session->read("idgrem");
	   $idempr=$session->read("idempr");
	   
	   $idgrem=1;
	   $idempr=1;

       $gre = $this->DocumentosVentas->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {		 
		 $session = $this->request->session();

         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('dove_seq');");

         $results = $stmt ->fetchAll('assoc');

         $gre->id =  $results[0]["nextval"];
		 $gre->afecto=0;
		 $gre->exento=0;
		 $gre->impuestos=0;
		 
	      $gre = $this->DocumentosVentas->patchEntity($gre, $this->request->data);

		 //print_r($gre); return;
		 $gre->fechacotizacion = $this->to_date($gre->fechacotizacion);
		 
	     if ($this->DocumentosVentas->save($gre)) {
			$det = TableRegistry::get('DetallesDoctosVtas'); 
			$n=0;
			$nRow = 50;
			
			//echo "nRow: ".$nRow."<br/>";
			
		    for ($i=0; $i < $nRow; $i++) {
			   $cantidad = isset($_REQUEST["cantidad".$i])?$_REQUEST["cantidad".$i]:"";
               $totallinea = isset($_REQUEST["totallinea".$i])?$_REQUEST["totallinea".$i]:"";;			   
			   
			   if ($cantidad!="" && $totallinea!="") {
				   $n++;
				   
				   $gre2 = $det->newEntity();
				   
				   $preciounitario      = $_REQUEST["valorunitario".$i];
				   $porcentajedescuento = $_REQUEST["porcentajedescuento".$i];
				   $montodescuento      = $_REQUEST["montodescuento".$i];
				   $impuestos           = $_REQUEST["impuestos".$i];
				   $totallinea            = $_REQUEST["totallinea".$i];
				   
				   
			     
                   $gre2->correlativo         = $n;
				   $gre2->iddove              = $gre->id;
                   $gre2->idprod              = $_REQUEST["idprod".$i];
                   $gre2->cantidad            = $cantidad;
                   $gre2->preciounitario      = ($preciounitario=="")?0:$preciounitario;
                   $gre2->porcentajedescuento = ($porcentajedescuento=="")?0:$porcentajedescuento;
                   $gre2->montodescuento      = ($montodescuento=="")?0:$montodescuento;
                   $gre2->impuestos           = ($impuestos=="")?0:$impuestos;
                   $gre2->totallinea            = ($totallinea=="")?0:$totallinea;
				   $gre2->afecto = 0;
				   $gre2->exento = 0;
				   $det->save($gre2);
			   }   
			   
			}
			
			//return;
			
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
	   $gre->fechacotizacion=date("d/m/Y");
	   $gre->idesve = 1;
	   $gre->idtidv = 1;
	   $gre->diasvalidez = 0;
	   $gre->totallinea            = 0;
	   $gre->porcentajedescuento = 0;
	   $gre->montodescuento      = 0;
	   $gre->impuestos      = 0;
	   $gre->total               = 0;
	   $gre->afecto =0;
	   $gre->exento =0;
	   
	   $conn = ConnectionManager::get('default');
	   
       $stmt = $conn->execute("SELECT max(numero) numero from documentos_ventas where idempr=$idempr");

       $results = $stmt ->fetchAll('assoc');

	   if (count($results) > 0)
          $gre->numero =  $results[0]["numero"] + 1;
	   else
		  $gre->numero = 1;

       $this->set('gre', $gre);
	   
	   $this->set("idgrem", $idgrem);
	   
	   $this->llena_lista('gerencias', 'nombre', $idempr);
       $this->llena_lista('proyectos', 'nombre', $idempr);
       $this->llena_lista('lineas_negocios', 'nombre', $idempr);
       $this->llena_lista('centros_costos', 'nombre', $idempr);
       $this->llena_lista('tareas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);
       $this->llena_lista('estados_ventas', 'descripcion');
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('tipos_doctos_ventas', 'descripcioncorta');

   //$this->viewBuilder()->layout('custom2');
    }

    public function edit($id=null) {
       $session = $this->request->session();
       $gre = $this->DocumentosVentas->get($id);
	   
	      
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
	 
	      $gre = $this->DocumentosVentas->patchEntity($gre, $this->request->data);
		  
		 if ($gre->idesve == 1)
			$gre->idesve = 2;
		 else if ($gre->idesve == 2)
            $gre->idesve = 3;
		
		 $gre->afecto=0;
		 $gre->exento=0;
		 $gre->impuestos=0;
		
		 //print_r($gre); return;
		 $gre->fechacotizacion = $this->to_date($gre->fechacotizacion);
	     if ($this->DocumentosVentas->save($gre)) {
			$det = TableRegistry::get('DetallesDoctosVtas'); 
			$n=0;
			$nRow = 50;
			
			$stmt = $conn->execute("delete from detalles_doctos_vtas where iddove=$id");
			
			//echo "nRow: ".$nRow."<br/>";
			
		    for ($i=0; $i < $nRow; $i++) {
			   $cantidad = isset($_REQUEST["cantidad".$i])?$_REQUEST["cantidad".$i]:"";
               $totallinea = isset($_REQUEST["totallinea".$i])?$_REQUEST["totallinea".$i]:"";;			   
			   
			   if ($cantidad!="" && $totallinea!="") {
				   $n++;
				   
				   $gre2 = $det->newEntity();
				   
				   $preciounitario      = $_REQUEST["valorunitario".$i];
				   $porcentajedescuento = $_REQUEST["porcentajedescuento".$i];
				   $montodescuento      = $_REQUEST["montodescuento".$i];
				   $impuestos           = $_REQUEST["impuestos".$i];
				   $totallinea            = $_REQUEST["totallinea".$i];
				   
				   
			     
                   $gre2->correlativo         = $n;
				   $gre2->iddove              = $gre->id;
                   $gre2->idprod              = $_REQUEST["idprod".$i];
                   $gre2->cantidad            = $cantidad;
                   $gre2->preciounitario      = ($preciounitario=="")?0:$preciounitario;
                   $gre2->porcentajedescuento = ($porcentajedescuento=="")?0:$porcentajedescuento;
                   $gre2->montodescuento      = ($montodescuento=="")?0:$montodescuento;
                   $gre2->impuestos           = ($impuestos=="")?0:$impuestos;
                   $gre2->totallinea            = ($totallinea=="")?0:$totallinea;
				   $gre2->afecto = 0;
				   $gre2->exento = 0;
				   $det->save($gre2);
			   }   
			}
			
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
       $this->llena_lista('estados_ventas', 'descripcion');
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('tipos_doctos_ventas', 'descripcioncorta');
	   
	  	   
	   $sql = "select a.*, round(a.cantidad*a.preciounitario-a.montodescuento, 0) precio, b.descripcioncorta idunmp ".
	          "from detalles_doctos_vtas a, productos c, unidades_medidas_productos b ".
	          "where  a.idprod=c.id ".
			  "and    a.iddove= $id ".
			  "and    c.idunmp= b.id ".
			  "order by a.id";
			  
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');

       $this->set("detalle", $results);
	   
	   if ($gre->idnove!="") {
	      $cot = TableRegistry::get('NotasVentas'); 
	      
	      $nn = $cot->get($gre->idnove);
	      
	      $this->set("num_cotiz", $nn->numero);
	   }

    }

    public function view($id=null) {
       $session = $this->request->session();

       $gre = $this->DocumentosVentas->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);
    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->DocumentosVentas->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->DocumentosVentas->save($registro);

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

       $rows = $this->DocumentosVentas->find('all')->where(['idempr' => $session->read('idempr')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->numero)
                                              ->setCellValue("B$n", $r->descripciondoctoventa)
                                              ->setCellValue("C$n", $r->idgere)
                                              ->setCellValue("D$n", $r->idproy)
                                              ->setCellValue("E$n", $r->idline)
                                              ->setCellValue("F$n", $r->idceco)
                                              ->setCellValue("G$n", $r->idtare)
                                              ->setCellValue("H$n", $r->totallinea)
                                              ->setCellValue("I$n", $r->porcentajedescuento)
                                              ->setCellValue("J$n", $r->montodescuento)
                                              ->setCellValue("K$n", $r->impuestos)
                                              ->setCellValue("L$n", $r->total)
                                              ->setCellValue("M$n", $r->diasvalidez)
                                              ->setCellValue("N$n", $r->idesve)
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
	
	public function chkIdprod($id) {
       $this->render("excel");
		   
	   if ($id=="") {
		   $b->cuenta = 0;
	       $b->idunmp ="";
	       $b->valorunitario=$valorunitario;
	  	   
	       echo json_encode($b);    
		  return;
	   }
         		   

	   
	   $Productos = TableRegistry::get('Productos');
	   $um        = TableRegistry::get('UnidadesMedidasProductos');
	   
	   $a = $Productos->find("all")->where(["id" => $id]);
	   
	   $n=0;
	   $idunmp="";
	   $valorunitario="";
	   foreach($a as $x) {
	      $idunmp = $x->idunmp;
		  
		  $r = $um->get($idunmp);
		  
		  $idunmp = $r->descripcioncorta;
		  $valorunitario = $x->valorunitario;
	      $n++;
		  break;
	   } 
		   	   
	   $b->cuenta = $n;
	   $b->idunmp = $idunmp;
	   $b->valorunitario=$valorunitario;
	  	   
	   echo json_encode($b);   
	}
	
	public function to_date($s) {
	   if (strlen($s)==0) return;

	   $agno = substr($s, 6, 4);
	   $mes  = substr($s, 3, 2);
	   $dia  = substr($s, 0, 2);
	   
	   return date('Y-m-d H:i:s', strtotime($agno."-".$mes."-".$dia));
	}
    
}
