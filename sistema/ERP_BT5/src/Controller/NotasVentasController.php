<?php

namespace App\Controller;

require_once(APP . 'Vendor' . DS . 'grid' . DS. 'grid.php');

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class NotasVentasController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");
		$idusua = $session->read("idusua");
		$idperf = $session->read("idperf");
		
		//$idgrem = 1;

        $gre = $this->NotasVentas->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->NotasVentas->patchEntity($gre, $this->request->data);
        }             
        
        $this->set("gre", $gre);
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
		
		if ($idperf!=18) {
		   $cond["idusuacrearegistro"] = $idusua;   //Filtra por usuario dueño del registro
		}
		
        $cond['idempr']=$session->read('idempr');
		$cond["idesnv IN"] = [1,2];
		
		//$cond['idempr']=1;

        if ($gre->id!=null) $cond["id"]         = $gre->id;
        if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
        if ($gre->numero!=null) $cond["numero"] = $gre->numero;
        if ($gre->idclie!=null) $cond["idclie"] = $gre->idclie;
        if ($gre->descripcionnotaventa!=null) $cond["descripcionnotaventa like"] = $gre->descripcionnotaventa."%";
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
        //if ($gre->idesnv!=null) $cond["idesnv"] = $gre->idesnv;

		//print_r($cond);
		
		$est = TableRegistry::get('EstadosNotasVtas'); 
		
		$clie = TableRegistry::get('Clientes'); 
 
        $NotasVentas = $this->paginate($this->NotasVentas->find('all')->where($cond));
		
		foreach($NotasVentas as $c) {
		   $e = $est->get($c->idesnv);

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

        $this->set("cotizaciones", $NotasVentas); 
    }

    public function add() {
	   $this->render("edit");	
	   
       $session = $this->request->session();
	   
	   $this->set("idgrem", $session->read("idgrem"));
	  
	   $idgrem=$session->read("idgrem");
	   $idempr=$session->read("idempr");
	   
	   //$idgrem=1;
	   //$idempr=1;
	   
	   $conn = ConnectionManager::get('default');

       $gre = $this->NotasVentas->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {		 
		 $session = $this->request->session();

         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $stmt = $conn->execute("SELECT NEXTVAL('nove_seq');");

         $results = $stmt ->fetchAll('assoc');

         $gre->id =  $results[0]["nextval"];
		 
		          
		 
	     $gre = $this->NotasVentas->patchEntity($gre, $this->request->data);
		 $gre->montodescuento=0;
		 $gre->totallinea            = $gre->totallinea0;         
	     $gre->porcentajedescuento   = $gre->porcentajedescuento0;  
	     $gre->impuestosobligats     = $gre->impuestosobligats0;  
	     $gre->impuestosespecifs     = $gre->impuestosespecifs0;  
	     $gre->neto                  = 0;               
	     $gre->exento                = $gre->exento0;         
		 $gre->afecto                = $gre->afecto0;   
		 
		 try {
		 $gre->fechanotaventa = $this->to_date($gre->fechanotaventa);
		 }
		 catch(\Exception $e) {
			print_r($e);
		 }
		 
		 
		 $conn->begin();
		 try {
            if ($this->NotasVentas->save($gre)) {
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
			//echo $ex;
			$conn->rollback();
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
	   //$gre->fechanotaventa=date("d/m/Y");
	   $gre->idesnv = 1;
	   $gre->diasvalidez = 0;
	   $gre->totallinea0            = 0;
	   $gre->porcentajedescuento0 = 0;
	   $gre->montodescuento0      = 0;
	   $gre->impuestosobligats0      = 0;
	   $gre->impuestosespecifs0      = 0;
	   $gre->neto0=0;
	   $gre->exento0=0;
	   $gre->afecto0=0;
	   $gre->total               = 0;
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
	   
	   $this->llena_lista('gerencias', 'nombre', $idempr);
       $this->llena_lista('proyectos', 'nombre', $idempr);
       $this->llena_lista('lineas_negocios', 'nombre', $idempr);
       $this->llena_lista('centros_costos', 'nombre', $idempr);
       $this->llena_lista('tareas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);
       //$this->llena_lista('estados_notas_vtas', 'descripcion');
	   $this->set("estados_notas_vtas", ["" => "", "1" => "CREADA"]);
	   
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('bodegas', 'nombre', $idempr);
	   $this->llena_clientes($idgrem);
	   
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
	   
	   $this->render("edit");
    }
	
	function setGrid($rows=array()) {
	   $grid = new miGrilla($rows);
	   
	   $grid->addCol(["name" => "producto"            , "caption" => "Producto",    "size" => 8,  "onblur" => "ob_producto", "required" => true]);
	   $grid->addCol(["name" => "idprod"              , "gadget" => "hidden"]);
	   $grid->addCol(["name" => "estaexento"          , "gadget" => "hidden"]);
	   $grid->addCol(["name" => "maxdescto"           , "gadget" => "hidden"]);
	   $grid->addCol(["name" => "iva"                 , "gadget" => "hidden"]);
	   $grid->addCol(["name" => "ila"                 , "gadget" => "hidden"]);
	   $grid->addCol(["name" => "iaba"                , "gadget" => "hidden"]);
	   
	   $grid->addCol(["name" => "desproducto2", "gadget" => "hidden"]); 
	   $grid->addCol(["name" => "desproducto"         , "caption" => "Descripción", "size" => 30, "readonly" => true, "gadget" => "select", "selvalues" => ["" => "Seleccione producto"] ]);
	   $grid->addCol(["name" => "idunmp"              , "caption" => "U.Med.",      "size" => 5,  "readonly" => true]);
	   $grid->addCol(["name" => "preciounitario"      , "caption" => "P.Unit.",     "size" => 10, "readonly" => true, "type" => "N"]);
	   $grid->addCol(["name" => "cantidad"            , "caption" => "Cant",        "size" => 8,  "type" => "N", "onblur" => "ob_cantidad", "required" => true]);
	   
	   $grid->addCol(["name" => "porcentajedescuento1", "caption" => "%Descto1",     "size" => 5, "type" => "N", "onblur" => "ob_porcentajedescuento1", "required" => true]);
	   $grid->addCol(["name" => "porcentajedescuento2", "caption" => "%Descto2",     "size" => 5, "type" => "N", "onblur" => "ob_porcentajedescuento2", "required" => true]);
	   $grid->addCol(["name" => "montodescuento1"     , "caption" => "Mto.Desc.1",   "size" => 9, "type" => "N", "readonly" => true]);
	   $grid->addCol(["name" => "montodescuento2"     , "caption" => "Mto.Desc.2",   "size" => 9, "type" => "N", "onblur" => "ob_montodescuento2", "required" => true]);
	   $grid->addCol(["name" => "exento"              , "caption" => "Exento",       "size" => 10, "type" => "N", "readonly" => true, "sum" => "exento0,total,totallinea0"]);
	   $grid->addCol(["name" => "afecto"              , "caption" => "Afecto",       "size" => 10, "type" => "N", "readonly" => true, "sum" => "afecto0,total,totallinea0"]);
	   $grid->addCol(["name" => "impuestosobligats"   , "caption" => "Impuestos",    "size" => 10, "type" => "N", "readonly" => true, "sum" => "impuestosobligats0,total"]);
	   $grid->addCol(["name" => "impuestosespecifs"   , "caption" => "I.Específico",    "size" => 10, "type" => "N", "readonly" => true, "sum" => "impuestosespecifs0,total"]);
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
       $gre = $this->NotasVentas->get($id);
	   
	   if ($gre->idesnv > 2) {
		  return $this->redirect(['action' => 'view', $id]); 
	   }
	   
	      
	   $conn = ConnectionManager::get('default');
	  
	   $idgrem=$session->read("idgrem");
	   $idempr=$session->read("idempr");
	   
	   //$idgrem=1;
	   //$idempr=1;

       $this->set("errors", []); 

	   if ($this->request->is('post') || $this->request->is('put')) {		 
	     //echo "Voy a grabar<br>"; return;
		 
		 //print_r($gre); return;
		 
		 $session = $this->request->session();

         $this->request->data["idusuamodifregistro"] = $session->read("idusua");

         $this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');
		 
		 $gre = $this->NotasVentas->patchEntity($gre, $this->request->data);
		 
		 $gre->totallinea            = $_REQUEST["totallinea0"];         
	     $gre->porcentajedescuento   = $_REQUEST["porcentajedescuento0"];
	     $gre->montodescuento        = 0;     
	     $gre->impuestosobligats     = $_REQUEST["impuestosobligats0"];  
	     $gre->impuestosespecifs     = $_REQUEST["impuestosespecifs0"];  
	     $gre->neto                  = 0;               
	     $gre->exento                = $_REQUEST["exento0"];                
         $gre->afecto                = $_REQUEST["afecto0"];         

		//if ($gre->idesnv == 1)
		//	$gre->idesnv = 2;
		//else if ($gre->idesnv == 2)
        //   $gre->idesnv = 3;
		//
		 //print_r($gre); return;
		 
		 try {
		 $gre->fechanotaventa = $this->to_date($gre->fechanotaventa);
		 }
		 catch(\Exception $e) {
			print_r($e);
		 }
		 
		$conn->begin();
		 try {
   	        if ($this->NotasVentas->save($gre)) {	
   			   $stmt = $conn->execute("delete from detalles_notas_vtas where idnove=$id");
   			
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
			//echo $ex;
			$conn->rollback();
		 }

         //$this->set("errors", $gre->errors());
		 
		 foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.'));

	   }
	   
	   $gre->totallinea0            = $gre->totallinea;         
	   $gre->porcentajedescuento0   = $gre->porcentajedescuento;
	   $gre->montodescuento0        = 0;     
	   $gre->impuestosobligats0     = $gre->impuestosobligats;  
	   $gre->impuestosespecifs0     = $gre->impuestosespecifs;  
	   $gre->neto0                  = 0;               
	   $gre->exento0                = $gre->exento;  
       $gre->afecto0                = $gre->afecto; 	   

       //$gre->idgrem = $session->read("idgrem");
       $gre->idempr = $idempr;
	   	   
	   $conn = ConnectionManager::get('default');

	   $this->set("idgrem", $idgrem);
	   
	   $Clientes = TableRegistry::get('Clientes');
	   
	   $cc = $Clientes->get($gre->idclie);
	   
	   $cot = TableRegistry::get("CotizacionesVentas");
	   
	   if ($gre->idcove!="") {
		  $cv = $cot->get($gre->idcove);
	  
		  $this->set("nrocotiz", $cv->numero);
	   }
	   
	   $gre->rutclie = $cc->identificador1.$cc->identificador2;
	   
	   if ($cc->razonsocial!="")
		  $gre->razclie = $cc->razonsocial;
	   else
		  $gre->razclie = $cc->apellidopaterno.' '.
	                      $cc->apellidomaterno.' '.
						  $cc->primernombre .' '.
						  $cc->segundonombre;
						  
						  
	   if ($gre->idcove!="") {
		  $cv = $cot->get($gre->idcove);
	  
		  $gre->nrocotiz = $cv->numero;
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
	   $this->llena_lista('estados_notas_vtas', 'descripcion');
	   $this->llena_clientes($idgrem);
	   
	   
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
	   
	   $det = TableRegistry::get('DetallesCotizsVtas'); 
	   
	   $arr = $det->find("all")->where(["idnove" => $gre->id])->order("id");

	   $this->set("detalle", $arr);
	   
	   $sql = "select a.*, round(a.cantidad*a.preciounitario-a.montodescuento1, 0) precio, 
	                  b.descripcioncorta idunmp,
					  c.familia,c.sub_familia, c.familia, c.sub_familia, c.producto, 
					  c.familia||c.sub_familia||c.producto||'#'||c.id desproducto,
					  c.nombre desproducto2 
	          from detalles_notas_vtas a, prodv c, unidades_medidas_productos b 
	          where  a.idprod=c.id 
			  and    a.idnove= $id 
			  and    c.idunmp= b.id 
			  order by a.id";
			  
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');

       $this->set("detalle", $results);
	   
	   $grid = $this->setGrid($results);
	   
	   $this->set("grilla", $grid->show());
	   
	   $this->set("extrajs", $grid->genGridJs());
	   
	   $this->set("nRow", $grid->nRow + 1);	   
	   
	   $this->listaProductos($idempr, $gre->idbode);
	   
	   $cot = TableRegistry::get("CotizacionesVentas");
	   
	   
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
		$det = TableRegistry::get('DetallesNotasVtas'); 
		$n=0;
		$nRow = 50;
		
		$allRows = $_REQUEST["allRows"];
		
		$filas = explode("@@@", $allRows);
		
			
	    foreach($filas as $data) {
           $e = explode("|", $data);
           
           $producto             = $e[0];             
           $idprod               = $e[1];
           $estaexento           = "N";
           $maxdescto            = 0;
           $iva                  = 0;
           $ila                  = 0;
           $iaba                 = 0;
           $desproducto2         = $e[7];
		   $desproducto          = $e[8];
           $idunmp               = $e[9];
           $preciounitario       = $e[10];
           $cantidad             = $e[11];
           $porcentajedescuento1 = $e[12];
           $porcentajedescuento2 = $e[13];
           $montodescuento1      = $e[14];
           $montodescuento2      = $e[15];
           $exento               = $e[16];
           $afecto               = $e[17];
           $impuestosobligats    = $e[18];
           $impuestosespecifs    = $e[19];
           $totallinea           = $e[20];
		   			
           $n++;
			   
           $gre2 = $det->newEntity();
                       
           $gre2->correlativo          = $n;
           $gre2->idnove               = $greid;
           $gre2->idprod               = $idprod;
           $gre2->cantidad             = $cantidad;
           $gre2->preciounitario       = ($preciounitario=="")?0:$preciounitario;
           
           $gre2->porcentajedescuento1 = ($porcentajedescuento1=="")?0:$porcentajedescuento1;
           $gre2->montodescuento1      = ($montodescuento1=="")?0:$montodescuento1;
           
           $gre2->porcentajedescuento2 = ($porcentajedescuento2=="")?0:$porcentajedescuento2;
           $gre2->montodescuento2      = ($montodescuento2=="")?0:$montodescuento2;
           			   
           $gre2->afecto               = ($afecto=="")?0:$afecto;
           $gre2->exento               = ($exento=="")?0:$exento;
           
           $gre2->impuestosobligats    = ($impuestosobligats=="")?0:$impuestosobligats;
           $gre2->impuestosespecifs    = ($impuestosespecifs=="")?0:$impuestosespecifs;
           $gre2->totallinea           = ($totallinea=="")?0:$totallinea;
           
           $det->save($gre2);		      
		}		
	}

    public function view($id=null) {
       $session = $this->request->session();
	   $idempr  = $session->read("idempr");
	   $idgrem  = $session->read("idgrem");
	   
	   $this->set("idgrem", $idgrem);

       $gre = $this->NotasVentas->get($id);
       $this->set("errors", []); 

	   $clientes = TableRegistry::get('Clientes');
	   
	   $c = $clientes->get($gre->idclie);
	   
	   $gre->rutclie = $c->identificador1.$c->identificador2;
	   
	   $gre->rut = $c->identificador1;
	   $gre->dv  = $c->identificador2;
	   
	   if ($c->razonsocial=="") {
		  $gre->razclie=$c->apellidopaterno . " ".
		                $c->apellidomaterno . " ".
						$c->primernombre . " ".
						$c->segundonombre;
	   }
	   else {
		  $gre->razclie=$c->razonsocial;
	   }
	   
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
	   $this->llena_lista('bodegas', 'nombre', $idempr);
	   $this->llena_lista('estados_notas_vtas', 'descripcion');
	   
	   
	   $sql = "select u.id, pers.apellidopaterno,pers.apellidomaterno,pers.primernombre,pers.segundonombre
               from   usuarios u, usuarios_perfiles p, personas pers
               where u.id=p.idusua
               and   p.idperf=20
               and   p.idempr=$idempr
               and   pers.id=u.idpers
			   order by pers.apellidopaterno, pers.apellidomaterno, pers.primernombre, pers.segundonombre
			  ";
			  
	   $conn = ConnectionManager::get('default');

	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
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
	   
	   $det = TableRegistry::get('DetallesCotizsVtas'); 
	   
	   $arr = $det->find("all")->where(["idcove" => $gre->id])->order("id");

	   $this->set("detalle", $arr);
	   
	   $sql = "select a.*, round(a.cantidad*a.preciounitario-a.montodescuento1, 0) precio, b.descripcioncorta idunmp,c.familia,c.sub_familia, c.familia, c.sub_familia, c.producto, c.nombre desproducto ".
	          "from detalles_notas_vtas a, prodv c, unidades_medidas_productos b ".
	          "where  a.idprod=c.id ".
			  "and    a.idnove= $gre->id ".
			  "and    c.idunmp= b.id ".
			  "order by a.id";
			  
	   $stmt = $conn->execute($sql);
			  
	   //echo $sql."<br/>";
			  
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');

       $this->set("detalle", $results);
	   
	   $grid = $this->setGrid($results);
	   $grid->readonly=true;
	   
	   $this->set("grilla", $grid->show());
	   $this->set("extrajs", $grid->genGridJs());
	   
	   $this->set("nRow", $grid->nRow + 1);
	   
	   //print_r($results);
	   
	   $suma=0;
	   foreach($results as $r)
	      $suma += $r["totallinea"];
		  
	   	  
		  
	   $gre->totallinea = $suma;
	   
       
	   
	   $cot = TableRegistry::get("CotizacionesVentas");
	   
	   if ($gre->idcove!="") {
		  $cv = $cot->get($gre->idcove);
	  
		  $gre->nrocotiz = $cv->numero;
	   }
	   
	   $this->set('gre', $gre);
    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->NotasVentas->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->NotasVentas->save($registro);

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

       $rows = $this->NotasVentas->find('all')->where(['idempr' => $session->read('idempr')]); 

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