<?php

namespace App\Controller;

require_once(APP . 'Vendor' . DS . 'grid' . DS. 'grid.php');

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class AsientosContablesController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idempr = $session->read("idempr");
		$idusua = $session->read("idusua");
		$idperf = $session->read("idperf");
		
		$gre = $this->AsientosContables->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->AsientosContables->patchEntity($gre, $this->request->data);
        }             
        
        $this->set("gre", $gre);
        $cond = [];
        //$cond["idusuaborraregistro is"] = null;
		$cond["idesac"] = 1;
        $cond["idempr"]=$idempr;
		
		//print_r($cond);
		
		//$cond['idempr']=1;

        //if ($gre->id!=null) $cond["id"]         = $gre->id;
        //if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
        //if ($gre->numero!=null) $cond["numero"] = $gre->numero;
        //if ($gre->idclie!=null) $cond["idclie"] = $gre->idclie;
        //if ($gre->descripcionnotaventa!=null) $cond["descripcionnotaventa like"] = $gre->descripcionnotaventa."%";
        //if ($gre->idgere!=null) $cond["idgere"] = $gre->idgere;
        //if ($gre->idproy!=null) $cond["idproy"] = $gre->idproy;
        //if ($gre->idline!=null) $cond["idline"] = $gre->idline;
        //if ($gre->idceco!=null) $cond["idceco"] = $gre->idceco;
        //if ($gre->idtare!=null) $cond["idtare"] = $gre->idtare;
        //if ($gre->totallinea!=null) $cond["totallinea"] = $gre->totallinea;
        //if ($gre->porcentajedescuento!=null) $cond["porcentajedescuento"] = $gre->porcentajedescuento;
        //if ($gre->montodescuento!=null) $cond["montodescuento"] = $gre->montodescuento;
        //if ($gre->impuestosobligats!=null) $cond["impuestosobligats"] = $gre->impuestosobligats;
        //if ($gre->total!=null) $cond["total"] = $gre->total;
        //if ($gre->diasvalidez!=null) $cond["diasvalidez"] = $gre->diasvalidez;
        //if ($gre->idesnv!=null) $cond["idesnv"] = $gre->idesnv;

 
        $asco  = TableRegistry::get('Ascov');
 
        $AsientosContables = $this->paginate($asco->find('all')->where($cond));
		
		$this->set("registros", $AsientosContables); 
		
		$this->llena_lista('tipos_asientos_contables', 'descripcion');
	   
	    $this->llena_lista('estados_asientos_contables', 'descripcion');
		
		
    }

	public function getParam($nombrecorto) {
	   $session = $this->request->session();
	   
	   $idgrem = $session->read("idgrem");
	   
	   $conn = ConnectionManager::get('default');
	   	   
       $stmt = $conn->execute("select valor from parametros where idgrem=$idgrem and nombrecorto='$nombrecorto'");

       $results = $stmt ->fetchAll('assoc');
	   
	   //echo "nombrecorto: $nombrecorto</br>";
	   //print_r($results);
	   
	   return $results[0]["valor"];
	}
	
	public function setParams() {
	   $this->set("SEPNIVELES", $this->getParam("SEPNIVELES"));
	   $this->set("FORMATOCTAS", $this->getParam("FORMATOCTAS"));
	   
	   for ($i=1; $i <= 8; $i++)
	      $this->set("LARGOSEGM".$i, $this->getParam("LARGOSEGM".$i));
	}
	
    public function add() {
	   $this->render("edit");	
	   
       $session = $this->request->session();
	   
	   $idgrem = $session->read("idgrem");
	   $idusua = $session->read('idusua');    
	   
	   $this->set("idgrem", $idgrem);
	  
	   $idgrem=$session->read("idgrem");
	   $idempr=$session->read("idempr");
	   
	   //$idgrem=1;
	   //$idempr=1;
	   
	   $conn = ConnectionManager::get('default');

       $gre = $this->AsientosContables->newEntity();

       $this->set("errors", []); 
	   
	   $this->setParams();	   

	   if ($this->request->is('post')) {		 
		 $session = $this->request->session();

         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');
		 
		 $periodo = TableRegistry::get('periodos_contables'); 
		 
		 $arr = $periodo->find("all")->where(["idempr"=>$idempr, "idespc"=>1]);
		 		 		 
		 foreach($arr as $r)
		    $gre->idpeco = $r["id"]; 
		 
		 //echo "Periodo contable: ".$gre->idpeco."<br/>";
		 
		 //return;

         $stmt = $conn->execute("SELECT NEXTVAL('asco_seq');");

         $results = $stmt ->fetchAll('assoc');
		 
		 $sql= "SELECT max(numero_asiento) maximo 
		        from asientos_contables a,
                     periodos_contables b 
                where a.idpeco=$gre->idpeco
                and   b.idempr=$idempr
                and   b.anno=2019";

		 
		 $stmt = $conn->execute($sql);

         $results2 = $stmt ->fetchAll('assoc');
		 
		 if (count($results2) > 0)
			$numero_asiento = $results2[0]["maximo"] + 1;
		 else
			$numero_asiento = 1;

	     $gre = $this->AsientosContables->patchEntity($gre, $this->request->data);
		 		 
		 $conn->begin();
		 try {
			$gre->id =  $results[0]["nextval"];
			$gre->numero_asiento=$numero_asiento;
			$gre->idusuacreaasiento=$idusua;
			$gre->idesac=1;
			
			//debug($gre);
			
            if ($this->AsientosContables->save($gre)) {
				echo "Voy a grabar el detalle!<br/>";
        		$this->graba_detalle($gre->id);
        					
        		$conn->commit();
        		
                $this->Flash->success(__('Registro ha sido creado.'));
        		
                return $this->redirect(['action' => 'index']);
       	    }else {
			 	$this->set("errors", $gre->errors());
				echo "No pude grabar detalle!<br/>";
			 	throw new \Exception(__('No se puede crear el registro.'));
			 }
	     }
		 catch(\Exception $ex) {
			echo $ex;
			$conn->rollback();
		 }
		 
		 
         //$this->set("errors", $gre->errors());
		 
		 foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.'));

	   }
	   else {
          $gre->reversible="N";
		  $gre->idtiac=1;
		  $gre->fecha_asiento=date("Y-m-d");
		  $gre->idesac=1;
       
	   }
	   
	   $conn = ConnectionManager::get('default');
	   
       $stmt = $conn->execute("SELECT max(numero) numero from notas_ventas where idempr=$idempr");

       $results = $stmt ->fetchAll('assoc');

	   if (count($results) > 0)
          $gre->numero =  $results[0]["numero"] + 1;
	   else
		  $gre->numero = 1;

	   //print_r($gre);
	   
       $this->set('gre', $gre);
	   
	   $this->set("idgrem", $idgrem);
	   
	 
	   
	   $sql = "select u.id, pers.apellidopaterno,pers.apellidomaterno,pers.primernombre,pers.segundonombre
               from   usuarios u, usuarios_perfiles p, personas pers
               where u.id=p.idusua
               and   p.idperf=20
               and   p.idempr=$idempr
               and   pers.id=u.idpers
			   order by pers.apellidopaterno, pers.apellidomaterno, pers.primernombre, pers.segundonombre
			  ";

	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   $lista=[];
	   $lista[""]="";
	   foreach($results as $r) 
	      $lista[$r["id"]] = $r["apellidopaterno"]." ".
		                     $r["apellidomaterno"]." ".
                             $r["primernombre"]." ".
                             $r["segundonombre"];		

       $this->set("vendedores", $lista);
	   
	   $clie = TableRegistry::get('Clientes'); 
	   
	   $r = $clie->find("all")->where(['idgrem' => $idgrem]);
	   
	   //print_r($r);
	   
	   $sql = "select u.id, pers.apellidopaterno,pers.apellidomaterno,pers.primernombre,pers.segundonombre
               from   usuarios u, usuarios_perfiles p, personas pers
               where u.id=p.idusua
               and   p.idperf=20
               and   p.idempr=$idempr
               and   pers.id=u.idpers
			   order by pers.apellidopaterno, pers.apellidomaterno, pers.primernombre, pers.segundonombre
			  ";

	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
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
	   
	   $this->set("extrajs", $grid->genGridJs());
	   
	   $this->set("nRow", $grid->nRow + 1);
	   
	   $this->set("lProductos", "");
	   	   
	   $this->llena_lista('tipos_asientos_contables', 'descripcion');
	   
	   $this->llena_lista('estados_asientos_contables', 'descripcion');
	   
	   $reversibles = [""=>"", "S" => "Sí", "N" => "No"];
	   
	   $this->set("reversibles", $reversibles);
	   
	   $this->set("sdebcmp", 0);
	   $this->set("shabcmp", 0);
	   
       $this->render("edit");
    }
	
	function setGrid($rows=array()) {
	   $grid = new miGrilla($rows);
	   
	   $grid->addCol(["name" => "cuenta"            , "caption" => "Cuenta",    "size" => 15, "maxlength" => 15, "required" => true, "btn" => "myBtn"]);
	   //$grid->addCol(["name" => "myBtn"            , "caption" => "..",   "gadget" => "button", "size" => 1, "onblur" => "ob_cuenta"]);
	   $grid->addCol(["name" => "idcuco"              , "gadget" => "hidden"]);
	   
	   $grid->addCol(["name" => "glosadet"            , "caption" => "Glosa/Detalle", "size" => 35, "maxlength" => 35, "required" => true]);
	   
	   $grid->addCol(["name" => "debcmp"            , "caption" => "Debe", "size" => 12, "maxlength" => 12, "required" => true, "type" => "N", "sum" => "sdebcmp"]);
	   $grid->addCol(["name" => "habcmp"           , "caption" => "Haber","size" => 12, "maxlength" => 12, "required" => true, "type" => "N",  "sum" => "shabcmp"]);
	   
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
       $gre = $this->AsientosContables->get($id);
	   
	   if ($gre->idesnv > 2) {
		  return $this->redirect(['action' => 'view', $id]); 
	   }
	   
	      
	   $conn = ConnectionManager::get('default');
	  
	   $idgrem=$session->read("idgrem");
	   $idempr=$session->read("idempr");
	   $idusua = $session->read('idusua');    
	   
	   $this->set("idgrem", $idgrem);
	   
	   //$idgrem=1;
	   //$idempr=1;

       $this->set("errors", []); 
	   $this->setParams();	 

	   if ($this->request->is('post') || $this->request->is('put')) {		 
	     //echo "Voy a grabar<br>"; return;
		 
		 //print_r($gre); return;
		 
		 $session = $this->request->session();

         $this->request->data["idusuamodifregistro"] = $session->read("idusua");

         $this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');
		 
		 $gre = $this->AsientosContables->patchEntity($gre, $this->request->data);
		 
		$conn->begin();
		 try {
   	        if ($this->AsientosContables->save($gre)) {	
   			   $stmt = $conn->execute("delete from detalles_asientos_contables where idasco=$id");
   			
               $this->graba_detalle($gre->id);
   			
   			   $conn->commit();
   			
               $this->Flash->success(__('Registro ha sido creado.'));
   	           return $this->redirect(['action' => 'index']);
   	        }else {
			 	$this->set("errors", $gre->errors());
			 	throw new \Exception(__('No se puede crear el registro.'));
			 }
		 }
		 catch(\Exception $ex) {
			echo $ex;
			$conn->rollback();
		 }

         //$this->set("errors", $gre->errors());
		 
		 foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.'));

	   }
	   else
		  $gre = $this->AsientosContables->get($id);
	   	   
	   $conn = ConnectionManager::get('default');			  
						  
	   
	   $this->set('gre', $gre);
	   
	   $f = explode("/", $gre->fecha_asiento);
	   
	   $gre->fecha_asiento = "20".$f[2]."-".$f[0]."-".$f[1];
	   

	   
	   
	   $sql = "select a.idcuco, b.cuenta_desplegable cuenta, a.glosadet, 
	                  (case when a.idtiec=1 then monto else 0 end) debcmp, 
					  (case when a.idtiec=2 then monto else 0 end) habcmp 
			   from detalles_asientos_contables a, cuentas_contables b
               where  a.idasco=$id
			   and    a.idcuco=b.id
               order by a.numero_linea
			  ";
			  
	   //echo $sql."<BR/>";	  

	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   $sdebcmp=0; $shabcmp=0;
	   foreach($results as $r) {	  
		  $sdebcmp += $r["debcmp"];
		  $shabcmp += $r["habcmp"];
	   }
	   
	   $this->set("sdebcmp", $sdebcmp);
	   $this->set("shabcmp", $shabcmp);


	   $grid = $this->setGrid($results);
       $this->set("grilla", $grid->show());
	   
	   $this->set("extrajs", $grid->genGridJs());
	   
	   $this->set("nRow", $grid->nRow + 1);
	   
	   $this->set("lProductos", "");
	   	   
	   $this->llena_lista('tipos_asientos_contables', 'descripcion');
	   
	   $this->llena_lista('estados_asientos_contables', 'descripcion');
	   
	   $reversibles = [""=>"", "S" => "Sí", "N" => "No"];
	   
	   $this->set("reversibles", $reversibles);
    }
	
	function llena_clientes($idgrem) {
	   $conn = ConnectionManager::get('default');
	   
       $stmt = $conn->execute("SELECT * FROM (
	                           SELECT razonsocial razon, id, identificador1, identificador2 
	                           from   clientes 
							   where  idgrem=$idgrem and razonsocial is not null
	                           UNION
							   SELECT coalesce(apellidopaterno, '') || ' ' ||
							          coalesce(apellidomaterno, '') || ' ' ||
									  coalesce(primernombre   , '')  || ' ' ||
									  coalesce(segundonombre  , '') razon
									 ,id
									 ,identificador1
									 , identificador2 
	                           from   clientes 
							   where  idgrem=$idgrem and razonsocial is null
							   ) a order by razon
	                          ");

       $results = $stmt ->fetchAll('assoc'); 
	   $l=[];
	   $l[""] = "";
	   foreach($results as $r) {
		  $rut = number_format($r["identificador1"], 0, ",", ".")."-".$r["identificador2"];
		  
		  $idclie = $r["id"];
		 		 
		  $l[$rut."|".$idclie] = $r["razon"];
	   }
	   
	   //print_r($l);
	   
	   $this->set("clientes", $l);	   
	}
	
	public function graba_detalle($greid) {
       	
		$det = TableRegistry::get('DetallesAsientosContables'); 
		$n=0;
		$nRow = 50;
		
		$allRows = $_REQUEST["allRows"];
		
		$filas = explode("@@@", $allRows);
		
			
	    foreach($filas as $data) {
           $e = explode("|", $data);
           
		   $cuenta   = $e[0];
		   //$myBtn    = $e[1];
		   $idcuco   = $e[1];
		   $glosadet = $e[2];
		   $debcmp   = $e[3];
		   $habcmp   = $e[4];

		   			
           $n++;
			   
           $gre2 = $det->newEntity();
		   
		   $gre2->idasco	   =  $greid;	
           $gre2->numero_linea =  $n;
           $gre2->idcuco	   =  $idcuco;	
		   $gre2->glosadet     =  $glosadet;
           $gre2->idtiec	   =  ($debcmp > 0)?1:2;
           $gre2->monto	       =  ($debcmp > 0)?$debcmp:$habcmp;	
           
		   debug($gre2);
		   
           $det->save($gre2);		      
		}		
	}

    public function view($id=null) {
       $session = $this->request->session();
	   $idempr  = $session->read("idempr");
	   $idgrem  = $session->read("idgrem");
	   $this->setParams();	
	   
	   $conn = ConnectionManager::get('default');		
	   
	   $this->set("idgrem", $idgrem);

       $gre = $this->AsientosContables->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);
	   
	   $f = explode("/", $gre->fecha_asiento);
	   
	   $gre->fecha_asiento = "20".$f[2]."-".$f[0]."-".$f[1];
	   

	   
	   
	   $sql = "select a.idcuco, b.cuenta_desplegable cuenta, a.glosadet, 
	                  (case when a.idtiec=1 then monto else 0 end) debcmp, 
					  (case when a.idtiec=2 then monto else 0 end) habcmp 
			   from detalles_asientos_contables a, cuentas_contables b
               where  a.idasco=$id
			   and    a.idcuco=b.id
               order by a.numero_linea
			  ";
			  
	   //echo $sql."<BR/>";	  

	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   $sdebcmp=0; $shabcmp=0;
	   foreach($results as $r) {	  
		  $sdebcmp += $r["debcmp"];
		  $shabcmp += $r["habcmp"];
	   }
	   
	   $this->set("sdebcmp", $sdebcmp);
	   $this->set("shabcmp", $shabcmp);


	   $grid = $this->setGrid($results);
	   $grid->readonly=true;
	   
       $this->set("grilla", $grid->show());
	   
	   $this->set("extrajs", $grid->genGridJs());
	   
	   $this->set("nRow", $grid->nRow + 1);
	   
	   $this->set("lProductos", "");
	   	   
	   $this->llena_lista('tipos_asientos_contables', 'descripcion');
	   
	   $this->llena_lista('estados_asientos_contables', 'descripcion');
	   
	   $reversibles = [""=>"", "S" => "Sí", "N" => "No"];
	   
	   $this->set("reversibles", $reversibles);
    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->AsientosContables->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->AsientosContables->save($registro);

       return $this->redirect(['action' => 'index']);

    }
	
	public function cerrar($id) {
	   $this->render("excel");	
	   
	   $conn = ConnectionManager::get('default');

       $sql = "update notas_ventas set idesnv=2 where id=$id";

       $stmt = $conn->execute($sql);
	   
	   return $this->redirect(['action' => 'index']);
	}
	
	public function emitir($id) {
	   $this->render("excel");	
	   
	   $conn = ConnectionManager::get('default');

       $sql = "update notas_ventas set idesnv=3 where id=$id";

       $stmt = $conn->execute($sql);
	   
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
       header('Content-Disposition: attachment; filename=notas_ventas.xlsx');
      
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

       $rows = $this->AsientosContables->find('all')->where(['idempr' => $session->read('idempr')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->numero)
                                              ->setCellValue("B$n", $r->descripcionnotaventa)
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
                                              ->setCellValue("N$n", $r->idesnv)
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
		   	   
	   $b = new MiObjeto;
	   
	   $b->cuenta = $n;
	   $b->idclie = $idclie;
	   if ($razonsocial=="")
		  $b->razclie=$nombre;
	   else
		  $b->razclie=$razonsocial;
	   
	   echo json_encode($b);   
	}
	
	public function chkIdprod($idempr, $producto="", $idbode="") {
       $this->render("excel");
	   
	   $idempr=1;
	   $idbode=1;
	   
	   $conn = ConnectionManager::get('default');

	   if ($producto=="") {
		   $b->cuenta = 0;
	       $b->idunmp ="";
	       $b->preciounitario=0;
	  	   
	       echo json_encode($b);    
		  return;
	   }
         		   

	   $prod      = TableRegistry::get('Prodv');
	   
	     
	   $familia     = substr($producto, 0, 2);
	   $sub_familia = substr($producto, 2, 2);
	   $producto    = substr($producto, 4, 4);
	   
	   $sql = "select a.id
	           from   prodv a, bodegas_productos b
			   where  a.id=b.idprod
			   and    b.idbode=$idbode
			   and    a.familia='$familia'
			   and    a.sub_familia='$sub_familia'
			   and    a.producto='$producto'
			   and    a.idempr=$idempr
			  ";	
			  
		//echo $sql."<hr/>";	  
	   
	    $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   //print_r($results);
		 
	   if (count($results)==0) {
		   $b = new MiObjeto;
		   
		  $b->cuenta = 0;
	       $b->idunmp ="";
	       $b->preciounitario=0;
	  	   
	       echo json_encode($b);    
		  return;
	   }
	   
       $id=-1;
       foreach($results as $d)
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
		  
		  $sql = "select a.*, l.preciounitario
                  from   impuestos a,
                  tipos_productos_impuestos b, detalles_listas_precios l
                  where  a.id=b.idimpu
				  and    a.id=l.idprod
				  and    a.idpais=1
                  and    b.idtipr=$idtipr";

		  
		  $stmt = $conn->execute($sql);
	      $results = $stmt ->fetchAll('assoc');
		  		  
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
	
	function listaProductos($idempr, $idbode) {   
	   $conn = ConnectionManager::get('default');
	   
	   //$idempr=1; $idbode=1;
       
	   $sql = "	select a.id
	                 , c.cod_familia||b.cod_sub_familia||a.correlativoflia producto
					 , a.nombre desprod, 
					 d.idbode, 
					 a.idempr
                from   productos a,
                       sub_familias_productos b,
                       familias_productos c,
                       bodegas_productos d
                where  b.idfapr=c.id
				and    a.idempr=$idempr
                and    a.idsfpr=b.id
                and    a.id=d.idprod
				and    d.idbode=$idbode
                and    a.fechaborraregistro is null";
	   
       $stmt = $conn->execute($sql);
          
       $results = $stmt ->fetchAll('assoc');
	   
	   //echo $sql."<hr/>";
	   
	   $salida="";
	   
	   foreach($results as $r) {
		  if ($salida!="") $salida .= "@@@";
		  
	      $salida .= $r["producto"]."#".$r["id"]."&&&".$r["desprod"];
	   }
	
	   //echo $salida."<br/>";
	   $this->set("lProductos", $salida);
	}
	
	public function buscaCuenta($idgrem, $cuenta) {
	   $this->render("excel");
	   
	   $cuentas = TableRegistry::get('Cuentas_Contables');
	   
	   $a = $cuentas->find("all")->where(["idgrem" => $idgrem, "cuenta_desplegable" => $cuenta, "imputable" => "S"]);
	   
	   $n=0;
	   $descripcion="";
	   $idcuco="";
	   foreach($a as $x) {
		  $n++;
          $descripcion=$x->descripcion;		  
		  $idcuco     = $x->id;
		  break;
	   } 
		   	   
	   $b = new MiObjeto;
	   
	   $b->cuenta = $n;
	   $b->descripcion=$descripcion;
	   $b->idcuco = $idcuco;
	   
	   echo json_encode($b);   
	}
	
    public function busqCuentas($idgrem, $sTexto=null) {
	   $this->render("excel");
	   
	   $cuentas = TableRegistry::get('Cuentas_Contables');
	   
	   if ($sTexto!="")
	      $a = $cuentas->find("all")->where(["idgrem" => $idgrem, "descripcion LIKE" => $sTexto.'%', "imputable" => "S"]);
	   else
		  $a = $cuentas->find("all")->where(["idgrem" => $idgrem, "imputable" => "S"]);
	   
	   $n=0;
	   $descripcion="";
	   $idcuco="";
	   $cuentas=[];
	   $lista="";
	   foreach($a as $x) {
		  $n++;
		  
		  if ($lista!="") $lista .= "@@";
		  
		  $lista .= $x->cuenta_desplegable."|".$x->descripcion;
	   } 
		   	   
	   $b = new MiObjeto;
	   
	   $b->cuenta = $n;
	   $b->cuentas=$lista;
	   
	   echo json_encode($b);   
	}
	
}

class MiObjeto {
}

class miGrilla extends \Grid {
   public function preShowField($name, $r, $rows=[]) {
	  if ($name=="producto" && isset($rows["familia"])) {
		 $familia = $rows["familia"];
		 $sub_familia = $rows["sub_familia"];
		 $producto = $rows["producto"];
		 
		 $r->props["value"]= $familia.$sub_familia.$producto;
      }		  
	  return $r;
   }
}