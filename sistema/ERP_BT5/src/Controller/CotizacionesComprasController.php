<?php

namespace App\Controller;

require_once(APP . 'Vendor' . DS . 'grid' . DS. 'grid.php');

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;
use Cake\Log\Log;


class CotizacionesComprasController extends AppController
{
	
	
	
    public function index()
    {
		
		//return $this->redirect(['action' => 'sinpermiso']);   
		
        $session = $this->request->session();
        $idgrem  = $session->read("idgrem");
		$idempr  = $session->read("idempr");
		$idusua  = $session->read("idusua");
		
		$idperf = $session->read("idperf");
		
		$gre = $this->CotizacionesCompras->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->CotizacionesCompras->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
				
	    //$cond["idusuacrearegistro"]=$idusua;
 	    //$cond["idesoc IN"]=[1, 3];

		
		$oc = TableRegistry::get('OrdenesCompras'); 
		$req = TableRegistry::get('Requisiciones'); 

		
        $CotizacionesCompras = $this->paginate($this->CotizacionesCompras->find('all')->where($cond));
		
		foreach($CotizacionesCompras as $c) {
		   $c->requisicion="";
		   $c->orden_compra="";
		   
		   if ($c->idrequ!="")
		   try {
			 $r = $req->get($c->idrequ);
			 
			 $c->requisicion = $r->correlativo;
		   }
		   catch(\Exception $ex) {
			  echo $ex->printStackTrace();
		   }
		   
		   if ($c->idorco!="")
		   try {
			 $r = $oc->get($c->idorco);
			 
			 $c->orden_compra = $r->correlativo;
		   }
		   catch(\Exception $ex) {
			  echo $ex->printStackTrace();
		   }
		}

        $this->set("registros", $CotizacionesCompras); 
		
       $this->llena_lista('gerencias', 'nombre', $idempr);
       $this->llena_lista('proyectos', 'nombre', $idempr);
       $this->llena_lista('lineas_negocios', 'nombre', $idempr);
       $this->llena_lista('centros_costos', 'nombre', $idempr);
       $this->llena_lista('tareas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);
       $this->llena_lista('estados_notas_vtas', 'descripcion');
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('bodegas', 'nombre', $idempr);	

       $this->llena_lista('estados_ordenes_compras', 'descripcion');	 	 
	   
	   $this->getProveedores();
    }

    public function addCotRq($idRq) {
	   $this->render("edit");
       $session = $this->request->session();
	   $idempr = $session->read("idempr");
	   $idgrem = $session->read("idgrem");
	   
	   $re = TableRegistry::get('Requisiciones'); 
	   
	   $conn = ConnectionManager::get('default');

       $gre = $this->CotizacionesCompras->newEntity();
	   
	   $r = $re->get($idRq);
	   
	   //print_r($r);
	   
	   $gre->idrequ = $idRq;
	   $gre->requisicion_no  = $r->correlativo;
	   
	   $gre->nombreoriginal="LA CUCARACHA";
	   $gre->nombresistema ="LA CUCARACHA";

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

	     $gre = $this->CotizacionesCompras->patchEntity($gre, $this->request->data);
		 
		 $sql = "select max(correlativo) correlativo from ordenes_compras where idempr=$idempr";
              
	     $stmt = $conn->execute($sql);

         $r = $stmt ->fetchAll('assoc');
		 
		 if (count($r)==0)
			$gre->correlativo = 1;
	     else
			$gre->correlativo = $r[0]["correlativo"] + 1;

	     try {
			 $conn->begin();
    	     if ($this->CotizacionesCompras->save($gre)) {	
                Log::write("debug", debug($gre));
				
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

         foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.')); 

		 $this->getProveedores();
	   }

	   $this->llena_lista('gerencias', 'nombre', $idempr);
       $this->llena_lista('proyectos', 'nombre', $idempr);
       $this->llena_lista('lineas_negocios', 'nombre', $idempr);
       $this->llena_lista('centros_costos', 'nombre', $idempr);
       $this->llena_lista('tareas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);
       $this->llena_lista('estados_notas_vtas', 'descripcion');
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('bodegas', 'nombre', $idempr);	
       $this->llena_lista('estados_ordenes_compras', 'descripcion');		   
	   
       //$gre->idgrem = $session->read("idgrem");
       $gre->idempr = $session->read("idempr");
	   
	   $gre->fecha = $gre->fechacrearegistro;

	   $gre->idesoc=1;
       $this->set('gre', $gre);
	   
	  
	   
	   	   $sql = "select *, '' producto, '' desproducto, '' desservicio, '' preciounitario from detalles_requisiciones where idrequ=$idRq order by correlativo";

	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   for($i=0; $i < count($results); $i++) {	
          //print_r($results[$i]); echo "<br/>";
		  
	      if (!isset($results[$i]["producto"]   )) $results[$i]["producto"]   ="";
	      if (!isset($results[$i]["idprod"]     )) $results[$i]["idprod"]     ="";
          if (!isset($results[$i]["desproducto"])) $results[$i]["desproducto"]="";
          if (!isset($results[$i]["idunmp"]     )) $results[$i]["idunmp"]     ="";
          if (!isset($results[$i]["idserv"]     )) $results[$i]["idserv"]     ="";
          if (!isset($results[$i]["desservicio"])) $results[$i]["desservicio"]="";
          if (!isset($results[$i]["idunms"]     )) $results[$i]["idunms"]     ="";
          if (!isset($results[$i]["otroinsumo"] )) $results[$i]["otroinsumo"] ="";
          if (!isset($results[$i]["cantidad"]   )) $results[$i]["cantidad"]   ="";
		  
		  $producto     = isset($results[$i]["producto"])   ?$results[$i]["producto"]:"";
	      $idprod       = isset($results[$i]["idprod"])     ?$results[$i]["idprod"]:"";
          $desproducto  = isset($results[$i]["desproducto"])?$results[$i]["desproducto"]:"";
          $idunmp       = isset($results[$i]["idunmp"])     ?$results[$i]["idunmp"]:"";
          $idserv       = isset($results[$i]["idserv"])     ?$results[$i]["idserv"]     :"";
          $desservicio  = isset($results[$i]["desservicio"])?$results[$i]["desservicio"]:"";
          $idunms       = isset($results[$i]["idunms"])     ?$results[$i]["idunms"]     :"";
          $otroinsumo   = isset($results[$i]["otroinsumo"]) ?$results[$i]["otroinsumo"] :"";
          $cantidad     = isset($results[$i]["cantidad"])   ?$results[$i]["cantidad"]:"";
	   
		  if ($idprod!="") {
			 $sql = "select * from prodv where id=$idprod";
			 
			 $stmt = $conn->execute($sql);

             $r = $stmt ->fetchAll('assoc');
			 
			 $results[$i]["producto"]    = $r[0]["familia"].$r[0]["sub_familia"].$r[0]["producto"];
			 $results[$i]["idunmp"]      = $r[0]["alias_unidad_de_medida"];
			 $results[$i]["desproducto"] = $r[0]["nombre"];
			 
		  }
		  else if ($idserv!="") {
			 $sql = "select * from servv where id=$idserv";
			 
			 $stmt = $conn->execute($sql);

             $r = $stmt ->fetchAll('assoc');
			 
			 $results[$i]["idserv"]      = $idserv;
			 $results[$i]["desservicio"] = $r[0]["nombre"];
			 $results[$i]["idunms"]      = $r[0]["alias_unidad_medida_servicio"];			 
		  }

	   }
	   
	   
	   $this->set("rows", $results);
	   
	      

       $this->set("errors", []); 

	   $sql = "select apellidopaterno||' '||primernombre razon, u.id idusua
               from   personas p, usuarios u
               where  idgrem=$idgrem
               and    p.id=idpers
               order by apellidopaterno, primernombre
              ";
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   $l[""] = "";
	   foreach($results as $r)
	      $l[$r["idusua"]] = $r["razon"];
		  
	   $this->set("usuarios", $l);
	   
	   $this->getProveedores();
	   
	   $this->render("edit");
    }
	
	public function addCotOc($idOc) {
	   $this->render("edit");
       $session = $this->request->session();
	   $idempr = $session->read("idempr");
	   $idgrem = $session->read("idgrem");
	   
	   $oc = TableRegistry::get('OrdenesCompras'); 
	   
	   $conn = ConnectionManager::get('default');

       $gre = $this->CotizacionesCompras->newEntity();
	   
	   $r = $oc->get($idOc);
	   
	   //print_r($r);
	   
	   $gre->idorco = $idOc;
	   $gre->oc_no  = $r->correlativo;
	   
	   $gre->nombreoriginal="LA CUCARACHA";
	   $gre->nombresistema ="LA CUCARACHA";

       $this->set("errors", []); 

	   if ($this->request->is('post')) {

	     $gre = $this->CotizacionesCompras->patchEntity($gre, $this->request->data);
		 
		 $sql = "select max(correlativo) correlativo from ordenes_compras where idempr=$idempr";
              
	     $stmt = $conn->execute($sql);

         $r = $stmt ->fetchAll('assoc');
		 
		 if (count($r)==0)
			$gre->correlativo = 1;
	     else
			$gre->correlativo = $r[0]["correlativo"] + 1;

	     try {
			 $conn->begin();
    	     if ($this->CotizacionesCompras->save($gre)) {	
                Log::write("debug", debug($gre));
				
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

         foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));

	     $this->Flash->error(__('No se puede crear registro.')); 

		 $this->getProveedores();
	   }

	   $this->llena_lista('gerencias', 'nombre', $idempr);
       $this->llena_lista('proyectos', 'nombre', $idempr);
       $this->llena_lista('lineas_negocios', 'nombre', $idempr);
       $this->llena_lista('centros_costos', 'nombre', $idempr);
       $this->llena_lista('tareas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);
       $this->llena_lista('estados_notas_vtas', 'descripcion');
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('bodegas', 'nombre', $idempr);	
       $this->llena_lista('estados_ordenes_compras', 'descripcion');		   
	   
       //$gre->idgrem = $session->read("idgrem");
       $gre->idempr = $session->read("idempr");
	   
	   $gre->fecha = $gre->fechacrearegistro;

	   $gre->idesoc=1;
       $this->set('gre', $gre);
	   
	  
	   
	   	   $sql = "select *, '' producto, '' desproducto, '' desservicio, '' preciounitario from detalles_ordenes_compras where idorco=$idOc order by correlativo";

	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   for($i=0; $i < count($results); $i++) {	
          //print_r($results[$i]); echo "<br/>";
		  
	      if (!isset($results[$i]["producto"]   )) $results[$i]["producto"]   ="";
	      if (!isset($results[$i]["idprod"]     )) $results[$i]["idprod"]     ="";
          if (!isset($results[$i]["desproducto"])) $results[$i]["desproducto"]="";
          if (!isset($results[$i]["idunmp"]     )) $results[$i]["idunmp"]     ="";
          if (!isset($results[$i]["idserv"]     )) $results[$i]["idserv"]     ="";
          if (!isset($results[$i]["desservicio"])) $results[$i]["desservicio"]="";
          if (!isset($results[$i]["idunms"]     )) $results[$i]["idunms"]     ="";
          if (!isset($results[$i]["otroinsumo"] )) $results[$i]["otroinsumo"] ="";
          if (!isset($results[$i]["cantidad"]   )) $results[$i]["cantidad"]   ="";
		  
		  $producto     = isset($results[$i]["producto"])   ?$results[$i]["producto"]:"";
	      $idprod       = isset($results[$i]["idprod"])     ?$results[$i]["idprod"]:"";
          $desproducto  = isset($results[$i]["desproducto"])?$results[$i]["desproducto"]:"";
          $idunmp       = isset($results[$i]["idunmp"])     ?$results[$i]["idunmp"]:"";
          $idserv       = isset($results[$i]["idserv"])     ?$results[$i]["idserv"]     :"";
          $desservicio  = isset($results[$i]["desservicio"])?$results[$i]["desservicio"]:"";
          $idunms       = isset($results[$i]["idunms"])     ?$results[$i]["idunms"]     :"";
          $otroinsumo   = isset($results[$i]["otroinsumo"]) ?$results[$i]["otroinsumo"] :"";
          $cantidad     = isset($results[$i]["cantidad"])   ?$results[$i]["cantidad"]:"";
	   
		  if ($idprod!="") {
			 $sql = "select * from prodv where id=$idprod";
			 
			 $stmt = $conn->execute($sql);

             $r = $stmt ->fetchAll('assoc');
			 
			 $results[$i]["producto"]    = $r[0]["familia"].$r[0]["sub_familia"].$r[0]["producto"];
			 $results[$i]["idunmp"]      = $r[0]["alias_unidad_de_medida"];
			 $results[$i]["desproducto"] = $r[0]["nombre"];
			 
		  }
		  else if ($idserv!="") {
			 $sql = "select * from servv where id=$idserv";
			 
			 $stmt = $conn->execute($sql);

             $r = $stmt ->fetchAll('assoc');
			 
			 $results[$i]["idserv"]      = $idserv;
			 $results[$i]["desservicio"] = $r[0]["nombre"];
			 $results[$i]["idunms"]      = $r[0]["alias_unidad_medida_servicio"];			 
		  }

	   }
	   
	   
	   $this->set("rows", $results);
	   
	      

       $this->set("errors", []); 

	   $sql = "select apellidopaterno||' '||primernombre razon, u.id idusua
               from   personas p, usuarios u
               where  idgrem=$idgrem
               and    p.id=idpers
               order by apellidopaterno, primernombre
              ";
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   $l[""] = "";
	   foreach($results as $r)
	      $l[$r["idusua"]] = $r["razon"];
		  
	   $this->set("usuarios", $l);
	   
	   $this->getProveedores();
	   
	   $this->render("edit");
    }


    public function edit($id=null) {
	   $session = $this->request->session();
	   $idempr = $session->read("idempr");
	   $idgrem = $session->read("idgrem");	
	   
	   $conn = ConnectionManager::get('default');
	   
       $gre = $this->CotizacionesCompras->get($id);
	   
	   $oc = TableRegistry::get('OrdenesCompras'); 
	   
	   if ($gre->idorco!=null) {
          $r = $oc->get($gre->idorco);
	      $gre->oc_no  = $r->correlativo;
	   }
	   
	   
	   
	   //if ($gre->idesoc!=1) // || $gre->idesoc!=3)
	   //	  return $this->redirect(['action' => "view", $id]);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->CotizacionesCompras->patchEntity($gre, $this->request->data);

		  try {
			 $conn->begin();
    	     if ($this->CotizacionesCompras->save($gre)) {	
    			$stmt = $conn->execute("delete from detalles_cotizaciones_compras where idcoco=$id");
    			
                $this->graba_detalle($gre->id);
				   			   
    			$conn->commit();
    			
                $this->Flash->success(__('Registro ha sido creado.'));
    	        return $this->redirect(['action' => 'index']);
    	     }else {
			 	$this->set("errors", $gre->errors());
			 	throw new \Exception(__('No se puede modificar el registro.'));
			 }
		 }
		 catch(\Exception $ex) {
			echo $ex;
			$conn->rollback();
		 }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->llena_lista('gerencias', 'nombre', $idempr);
       $this->llena_lista('proyectos', 'nombre', $idempr);
       $this->llena_lista('lineas_negocios', 'nombre', $idempr);
       $this->llena_lista('centros_costos', 'nombre', $idempr);
       $this->llena_lista('tareas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);
       $this->llena_lista('estados_notas_vtas', 'descripcion');
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('bodegas', 'nombre', $idempr);		
       $this->llena_lista('estados_ordenes_compras', 'descripcion');	 	   
	   
	   //Para add solo 1=crear, 2=cerrar
       //$this->estadosCotizacionesCompras([1, 3]); 	 

	   
       //$gre->idgrem = $session->read("idgrem");
       $gre->idempr = $session->read("idempr");

	   $gre->fecha = $gre->fechacrearegistro;
	   
       $this->set('gre', $gre);
	   
	   $sql = "select apellidopaterno||' '||primernombre razon, u.id idusua
               from   personas p, usuarios u
               where  idgrem=$idgrem
               and    p.id=idpers
               order by apellidopaterno, primernombre
              ";
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   $l[""] = "";
	   foreach($results as $r)
	      $l[$r["idusua"]] = $r["razon"];
		  
	   $this->set("usuarios", $l);

	   $sql = "select *, '' producto, '' desproducto, '' desservicio from detalles_cotizaciones_compras where idcoco=$id order by id";

	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   //print_r($results);
	   
	   for($i=0; $i < count($results); $i++) {	
          //print_r($results[$i]); echo "<br/>";
		  
	      if (!isset($results[$i]["producto"]   )) $results[$i]["producto"]   ="";
	      if (!isset($results[$i]["idprod"]     )) $results[$i]["idprod"]     ="";
          if (!isset($results[$i]["desproducto"])) $results[$i]["desproducto"]="";
          if (!isset($results[$i]["idunmp"]     )) $results[$i]["idunmp"]     ="";
          if (!isset($results[$i]["idserv"]     )) $results[$i]["idserv"]     ="";
          if (!isset($results[$i]["desservicio"])) $results[$i]["desservicio"]="";
          if (!isset($results[$i]["idunms"]     )) $results[$i]["idunms"]     ="";
          if (!isset($results[$i]["otroinsumo"] )) $results[$i]["otroinsumo"] ="";
          if (!isset($results[$i]["cantidad"]   )) $results[$i]["cantidad"]   ="";
		  
		  $producto     = isset($results[$i]["producto"])   ?$results[$i]["producto"]:"";
	      $idprod       = isset($results[$i]["idprod"])     ?$results[$i]["idprod"]:"";
          $desproducto  = isset($results[$i]["desproducto"])?$results[$i]["desproducto"]:"";
          $idunmp       = isset($results[$i]["idunmp"])     ?$results[$i]["idunmp"]:"";
          $idserv       = isset($results[$i]["idserv"])     ?$results[$i]["idserv"]     :"";
          $desservicio  = isset($results[$i]["desservicio"])?$results[$i]["desservicio"]:"";
          $idunms       = isset($results[$i]["idunms"])     ?$results[$i]["idunms"]     :"";
          $otroinsumo   = isset($results[$i]["otroinsumo"]) ?$results[$i]["otroinsumo"] :"";
          $cantidad     = isset($results[$i]["cantidad"])   ?$results[$i]["cantidad"]:"";
	   
		  if ($idprod!="") {
			 $sql = "select * from prodv where id=$idprod";
			 
			 $stmt = $conn->execute($sql);

             $r = $stmt ->fetchAll('assoc');
			 
			 $results[$i]["producto"]    = $r[0]["familia"].$r[0]["sub_familia"].$r[0]["producto"];
			 $results[$i]["idunmp"]      = $r[0]["alias_unidad_de_medida"];
			 $results[$i]["desproducto"] = $r[0]["nombre"];
			 
		  }
		  else if ($idserv!="") {
			 $sql = "select * from servv where id=$idserv";
			 
			 $stmt = $conn->execute($sql);

             $r = $stmt ->fetchAll('assoc');
			 
			 $results[$i]["idserv"]      = $idserv;
			 $results[$i]["desservicio"] = $r[0]["nombre"];
			 $results[$i]["idunms"]      = $r[0]["alias_unidad_medida_servicio"];			 
		  }

	   }
	   
	   
	   
	   $this->set("rows", $results);
	   	   
	   $this->listaProductos($idempr);
	   
       $this->set("errors", []); 

	   $sql = "select apellidopaterno||' '||primernombre razon, u.id idusua
               from   personas p, usuarios u
               where  idgrem=$idgrem
               and    p.id=idpers
               order by apellidopaterno, primernombre
              ";
	   //echo $sql."<hr/>";		  
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   $l[""] = "";
	   foreach($results as $r)
	      $l[$r["idusua"]] = $r["razon"];
		  
	   $this->set("usuarios", $l);
	   
	   $this->getProveedores();
	   
	   if ($gre->idrequ!="") {
	      $req = TableRegistry::get('Requisiciones'); 
	   
	      $d = $req->get($gre->idrequ);
		  
		  $gre->requisicion_no=$d->correlativo;
	   }
	   else
		  $gre->requisicion_no="";
	   
	   $this->render("edit");
    }

    public function view($id=null) {
 	   $session = $this->request->session();
	   $idempr = $session->read("idempr");
	   $idgrem = $session->read("idgrem");	
	   
	   $conn = ConnectionManager::get('default');
	   
       $gre = $this->CotizacionesCompras->get($id);
	   
	   $oc = TableRegistry::get('OrdenesCompras'); 
	   $re = TableRegistry::get('Requisiciones'); 
	   
	   if ($gre->idorco!=null) {
          $r = $oc->get($gre->idorco);
	      $gre->oc_no  = $r->correlativo;
	   }
	   
	   if ($gre->idrequ!=null) {
          $r = $re->get($gre->idrequ);
	      $gre->requisicion_no  = $r->correlativo;
	   }
	   
	   
	   
	   //if ($gre->idesoc!=1) // || $gre->idesoc!=3)
	   //	  return $this->redirect(['action' => "view", $id]);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
	      $this->CotizacionesCompras->patchEntity($gre, $this->request->data);

		  try {
			 $conn->begin();
    	     if ($this->CotizacionesCompras->save($gre)) {	
    			$stmt = $conn->execute("delete from detalles_cotizaciones_compras where idcoco=$id");
    			
                $this->graba_detalle($gre->id);
				   			   
    			$conn->commit();
    			
                $this->Flash->success(__('Registro ha sido creado.'));
    	        return $this->redirect(['action' => 'index']);
    	     }else {
			 	$this->set("errors", $gre->errors());
			 	throw new \Exception(__('No se puede modificar el registro.'));
			 }
		 }
		 catch(\Exception $ex) {
			echo $ex;
			$conn->rollback();
		 }

          foreach($gre->errors() as $key => $arr)
            foreach($arr as $k => $v)
               $this->Flash->error(__($v));
			   
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->llena_lista('gerencias', 'nombre', $idempr);
       $this->llena_lista('proyectos', 'nombre', $idempr);
       $this->llena_lista('lineas_negocios', 'nombre', $idempr);
       $this->llena_lista('centros_costos', 'nombre', $idempr);
       $this->llena_lista('tareas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);
       $this->llena_lista('estados_notas_vtas', 'descripcion');
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('bodegas', 'nombre', $idempr);		
       $this->llena_lista('estados_ordenes_compras', 'descripcion');	 	   
	   
	   //Para add solo 1=crear, 2=cerrar
       //$this->estadosCotizacionesCompras([1, 3]); 	 

	   
       //$gre->idgrem = $session->read("idgrem");
       $gre->idempr = $session->read("idempr");

	   $gre->fecha = $gre->fechacrearegistro;
	   
       $this->set('gre', $gre);
	   
	   $sql = "select apellidopaterno||' '||primernombre razon, u.id idusua
               from   personas p, usuarios u
               where  idgrem=$idgrem
               and    p.id=idpers
               order by apellidopaterno, primernombre
              ";
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   $l[""] = "";
	   foreach($results as $r)
	      $l[$r["idusua"]] = $r["razon"];
		  
	   $this->set("usuarios", $l);

	   $sql = "select *, '' producto, '' desproducto, '' desservicio from detalles_cotizaciones_compras where idcoco=$id order by id";

	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   //print_r($results);
	   
	   for($i=0; $i < count($results); $i++) {	
          //print_r($results[$i]); echo "<br/>";
		  
	      if (!isset($results[$i]["producto"]   )) $results[$i]["producto"]   ="";
	      if (!isset($results[$i]["idprod"]     )) $results[$i]["idprod"]     ="";
          if (!isset($results[$i]["desproducto"])) $results[$i]["desproducto"]="";
          if (!isset($results[$i]["idunmp"]     )) $results[$i]["idunmp"]     ="";
          if (!isset($results[$i]["idserv"]     )) $results[$i]["idserv"]     ="";
          if (!isset($results[$i]["desservicio"])) $results[$i]["desservicio"]="";
          if (!isset($results[$i]["idunms"]     )) $results[$i]["idunms"]     ="";
          if (!isset($results[$i]["otroinsumo"] )) $results[$i]["otroinsumo"] ="";
          if (!isset($results[$i]["cantidad"]   )) $results[$i]["cantidad"]   ="";
		  
		  $producto     = isset($results[$i]["producto"])   ?$results[$i]["producto"]:"";
	      $idprod       = isset($results[$i]["idprod"])     ?$results[$i]["idprod"]:"";
          $desproducto  = isset($results[$i]["desproducto"])?$results[$i]["desproducto"]:"";
          $idunmp       = isset($results[$i]["idunmp"])     ?$results[$i]["idunmp"]:"";
          $idserv       = isset($results[$i]["idserv"])     ?$results[$i]["idserv"]     :"";
          $desservicio  = isset($results[$i]["desservicio"])?$results[$i]["desservicio"]:"";
          $idunms       = isset($results[$i]["idunms"])     ?$results[$i]["idunms"]     :"";
          $otroinsumo   = isset($results[$i]["otroinsumo"]) ?$results[$i]["otroinsumo"] :"";
          $cantidad     = isset($results[$i]["cantidad"])   ?$results[$i]["cantidad"]:"";
	   
		  if ($idprod!="") {
			 $sql = "select * from prodv where id=$idprod";
			 
			 $stmt = $conn->execute($sql);

             $r = $stmt ->fetchAll('assoc');
			 
			 $results[$i]["producto"]    = $r[0]["familia"].$r[0]["sub_familia"].$r[0]["producto"];
			 $results[$i]["idunmp"]      = $r[0]["alias_unidad_de_medida"];
			 $results[$i]["desproducto"] = $r[0]["nombre"];
			 
		  }
		  else if ($idserv!="") {
			 $sql = "select * from servv where id=$idserv";
			 
			 $stmt = $conn->execute($sql);

             $r = $stmt ->fetchAll('assoc');
			 
			 $results[$i]["idserv"]      = $idserv;
			 $results[$i]["desservicio"] = $r[0]["nombre"];
			 $results[$i]["idunms"]      = $r[0]["alias_unidad_medida_servicio"];			 
		  }

	   }
	   
	   
	   
	   $this->set("rows", $results);
	   	   
	   $this->listaProductos($idempr);
	   
       $this->set("errors", []); 

	   $sql = "select apellidopaterno||' '||primernombre razon, u.id idusua
               from   personas p, usuarios u
               where  idgrem=$idgrem
               and    p.id=idpers
               order by apellidopaterno, primernombre
              ";
	   //echo $sql."<hr/>";		  
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   $l[""] = "";
	   foreach($results as $r)
	      $l[$r["idusua"]] = $r["razon"];
		  
	   $this->set("usuarios", $l);
	   
	   $this->getProveedores();
	   
	   if ($gre->idrequ!="") {
	      $req = TableRegistry::get('Requisiciones'); 
	   
	      $d = $req->get($gre->idrequ);
		  
		  $gre->requisicion_no=$d->correlativo;
	   }
	   else
		  $gre->requisicion_no="";
    }
	
	public function getProveedores() {
 	   $session = $this->request->session();
	   $idgrem = $session->read("idgrem");	

	   $conn = ConnectionManager::get('default');

	   $sql = "select (case 
	                      when idtipp=1 then apellidopaterno||' '||
						                     coalesce(apellidomaterno, '-')||' '||
											 primernombre||' '||
											 coalesce(segundonombre, '-') 
						  else razonsocial end
					  ) razon, 
					  id 
               from proveedores
			   where idgrem=$idgrem
               order by apellidopaterno, apellidomaterno, primernombre, segundonombre
              ";
	   //echo $sql."<hr/>";		  
	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   $l[""] = "";
	   foreach($results as $r)
	      $l[$r["id"]] = $r["razon"];
		  
	   $this->set("proveedores", $l);
	   
	   //print_r($l);
    }
    
    public function cerrar($id)
    {
       $session = $this->request->session();

       $registro = $this->CotizacionesCompras->get($id);

       //$registro->idusuaborraregistro = $session->read("idusua");
       //$registro->fechaborraregistro  = date('Y-m-d H:i:s');	

	   $registro->idesoc = 2; //Marcada como cerrada
       $this->CotizacionesCompras->save($registro);

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
		
	function listaProductos($idempr) {   
	   $conn = ConnectionManager::get('default');
	   
	   //$idempr=1; $idbode=1;
       
	   $sql = "	select a.id
	                 , c.cod_familia||b.cod_sub_familia||a.correlativoflia producto
					 , a.nombre desprod, 					 
					 a.idempr
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
	   foreach($results as $r) {
		  if ($salida!="") $salida .= "@@@";
		  
	      $salida .= $r["producto"]."#".$r["id"]."&&&".$r["desprod"];
	   }

	   $this->set("lProductos", $salida);
	   
	   //Servicios
	   $sql = "	select * from servicios 
                where fechaborraregistro is null
			    order by nombre 
				";
	   
       $stmt = $conn->execute($sql);
          
       $results = $stmt ->fetchAll('assoc');
	   
	   //echo $sql."<hr/>";
	   
	   $salida="";
	   foreach($results as $r) {
		  if ($salida!="") $salida .= "@@@";
		  
	      $salida .= $r["id"]."&&&".$r["nombre"];
	   }
	
	   //echo $salida."<br/>";
	   $this->set("lServicios", $salida);	   
	}
	
	public function graba_detalle($greid) {
		$det = TableRegistry::get('DetallesCotizacionesCompras'); 
		$n=0;
		
		$nRows = $_REQUEST["nRows"];
			
	    for($i=0; $i < $nRows; $i++) {
		
		   $idprod         = $_REQUEST["idprod"       .$i];	
		   $idserv         = $_REQUEST["idserv"       .$i];
		   $otroinsumo     = $_REQUEST["otroinsumo"   .$i];
		   $cantidad       = $_REQUEST["cantidad"     .$i];
		   $preciounitario = $_REQUEST["preciounitario".$i];
		 	
		   $n++;
		   
		   $gre2 = $det->newEntity();
		   
           $gre2->correlativo    = $n;
		   $gre2->idcoco         = $greid;
           $gre2->cantidad       = $cantidad;
		   $gre2->preciounitario = $preciounitario;
		   $gre2->otroinsumo     = $otroinsumo==""?null:$otroinsumo;
		   $gre2->idprod         = $idprod;
		   $gre2->idserv         = $idserv;
		   		   
		   //Log::write("debug", debug($gre2));
          		   
		   $det->save($gre2);		     
		}		
	}

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=CotizacionesCompras.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Tipo de Requisición')
->setCellValue('B1', 'Correlativo')
->setCellValue('C1', 'Usuario Solicitante')
->setCellValue('D1', 'Gerencia')
->setCellValue('E1', 'Proyecto')
->setCellValue('F1', 'Línea de Negocios')
->setCellValue('G1', 'Centro de Costo')
->setCellValue('H1', 'Tarea')
->setCellValue('I1', 'Estado Requisición')
;

       $rows = $this->CotizacionesCompras->find('all')->where(['idempr' => $session->read('idempr')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->idtire)
->setCellValue("B$n", $r->correlativo)
->setCellValue("C$n", $r->idusuasolicitareq)
->setCellValue("D$n", $r->idgere)
->setCellValue("E$n", $r->idproy)
->setCellValue("F$n", $r->idline)
->setCellValue("G$n", $r->idceco)
->setCellValue("H$n", $r->idtare)
->setCellValue("I$n", $r->idesoc)
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

    public function chkIdprod($idempr, $producto="") {
       $this->render("excel");
	   
	   $conn = ConnectionManager::get('default');

	   if ($producto=="") {
		   $b->cuenta = 0;
	       $b->idunmp ="";
		   
	       echo json_encode($b);   
		   
 		   return;
	   }
	   
	   
         		   

	   $prod      = TableRegistry::get('Prodv');
	   
	     
	   $familia     = substr($producto, 0, 2);
	   $sub_familia = substr($producto, 2, 2);
	   $producto    = substr($producto, 4, 4);
	   
	   $sql = "select a.id
	           from   prodv a
			   where  a.familia='$familia'
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
		  
		  	   
	      $n++;
		  break;
	   } 
	   	   	   
       $b = new MiObjeto();
	   $b->id = $id;
	   $b->cuenta = $n;
	   $b->idunmp = $idunmp;   
	   
	   	   
	   echo json_encode($b);   
	}
	
	public function chkIdserv($idserv) {
       $this->render("excel");
	   
	   $conn = ConnectionManager::get('default');

	   if ($idserv=="") {
		   $b->cuenta = 0;
	       $b->idunms ="";
		   
	       echo json_encode($b);   
		   
 		   return;
	   }
	   
	   
         		   
	   
	   $sql = "select a.*, b.*
from   servicios a, unidades_medidas_servicios b
where  a.idunms=b.id
and    a.id=$idserv
			  ";	
			  
		//echo $sql."<hr/>";	  
	   
	    $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc');
	   
	   //print_r($results);
		 
	   if (count($results)==0) {
		   $b = new MiObjeto;
		   
		   $b->cuenta = 0;
	       $b->idunms ="";
	  	   
	       echo json_encode($b);    
 		   return;
	   }
	   
	   $b = new MiObjeto;
	   $b->cuenta=1;
	   $b->idunms = $results[0]["descripcioncorta"];

	   
	   	   
	   echo json_encode($b);   
	}
	
	function sinpermiso() {
	}
	
	public function indexRequisiciones() {
		//return $this->redirect(['action' => 'sinpermiso']);   
		
		$this->Requisiciones = TableRegistry::get("Requisiciones");
		
        $session = $this->request->session();
        $idgrem  = $session->read("idgrem");
		$idempr  = $session->read("idempr");
		$idusua  = $session->read("idusua");
		
		$idperf = $session->read("idperf");

		$requv = TableRegistry::get("Requv");
		
        $gre = $this->Requisiciones->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->Requisiciones->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
        $cond['idempr']=$idempr;
		
	   $areq = TableRegistry::get("AutorizadoresRequisiciones");
		
	   $arr = $areq->find("all")->where(["idempr" => $idempr]);
	   
	   $lista = "";
	   $perfiles = [];
	   
	   foreach($arr as $r) {
		  if ($lista!="") $lista .= ", ";
		  
		  $lista .= $r["idperfautorizado"];
		  
		  $perfiles[] = $r["idperfautorizado"];
	   }
	   
	   $usuaperf = TableRegistry::get("UsuariosPerfiles");
	   
	   if (count($perfiles)==0)
		  $perfiles=[-1];
	   
	   $arr = $usuaperf->find("all")->where(["idempr" => $idempr]);
	   
	   $usuarios=[];
	   foreach($arr as $r)
	     $usuarios[] = $r["idusua"];
	   
	    //$cond["idusuacrearegistro IN"]=$usuarios;
 	    //$cond["idereq IN"]=[4, 5, 6];


        if ($gre->id!=null) $cond["id"] = $gre->id;
        if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
        if ($gre->idtire!=null) $cond["idtire"] = $gre->idtire;
        if ($gre->correlativo!=null) $cond["correlativo"] = $gre->correlativo;
        if ($gre->idusuasolicitareq!=null) $cond["idusuasolicitareq"] = $gre->idusuasolicitareq;
        if ($gre->idgere!=null) $cond["idgere"] = $gre->idgere;
        if ($gre->idproy!=null) $cond["idproy"] = $gre->idproy;
        if ($gre->idline!=null) $cond["idline"] = $gre->idline;
        if ($gre->idceco!=null) $cond["idceco"] = $gre->idceco;
        if ($gre->idtare!=null) $cond["idtare"] = $gre->idtare;
        if ($gre->idereq!=null) $cond["idereq"] = 4;

		$cond["idereq in"]=[2];
        //debug($cond);
		
		//$cond=[];
		
        $Requisiciones = $this->paginate($this->Requisiciones->find('all')->where($cond));
		
		//$Requisiciones = $this->paginate($this->Requisiciones->find('all'));

        $this->set("registros", $Requisiciones); 
		
       $this->llena_lista('gerencias', 'nombre', $idempr);
       $this->llena_lista('proyectos', 'nombre', $idempr);
       $this->llena_lista('lineas_negocios', 'nombre', $idempr);
       $this->llena_lista('centros_costos', 'nombre', $idempr);
       $this->llena_lista('tareas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);
       $this->llena_lista('estados_notas_vtas', 'descripcion');
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('bodegas', 'nombre', $idempr);	
       $this->llena_lista('tipos_requisiciones', 'descripcion');	 
       $this->llena_lista('estados_requisiciones', 'descripcion');	 

       $conn = ConnectionManager::get('default');
		
       $sql = "select p.primernombre||' '||p.apellidopaterno||' '||p.apellidomaterno nombre, r.idusuasolicitareq id
               from   personas p
                     ,usuarios u
                     ,requisiciones r
               where p.id=u.idpers
               and   u.id=r.idusuasolicitareq
               and   r.idempr=$idempr
              ";
	   $stmt = $conn->execute($sql);
	   
       $results = $stmt ->fetchAll('assoc');	   
	   
	   $personas=array();
	   foreach($results as $r) {
		  $personas[$r["id"]] = $r["nombre"];
	   }
	   
	   $this->set("personas", $personas);	   
	}
	
	public function indexOrdenes() {
		//return $this->redirect(['action' => 'sinpermiso']);   
		
        $session = $this->request->session();
        $idgrem  = $session->read("idgrem");
		$idempr  = $session->read("idempr");
		$idusua  = $session->read("idusua");
		
		$idperf = $session->read("idperf");
		
		$this->OrdenesCompras = TableRegistry::get("OrdenesCompras");
		$gre = $this->OrdenesCompras->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->OrdenesCompras->patchEntity($gre, $this->request->data);
        }             

        $this->set("gre", $gre);
        
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
        $cond['idempr']=$idempr;
				
	    //$cond["idusuacrearegistro"]=$idusua;
 	    //$cond["idesoc IN"]=[1, 3];

       

        if ($gre->id!=null) $cond["id"] = $gre->id;
        if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
        if ($gre->idtire!=null) $cond["idtire"] = $gre->idtire;
        if ($gre->correlativo!=null) $cond["correlativo"] = $gre->correlativo;
        if ($gre->idusuasolicitareq!=null) $cond["idusuasolicitareq"] = $gre->idusuasolicitareq;
        if ($gre->idgere!=null) $cond["idgere"] = $gre->idgere;
        if ($gre->idproy!=null) $cond["idproy"] = $gre->idproy;
        if ($gre->idline!=null) $cond["idline"] = $gre->idline;
        if ($gre->idceco!=null) $cond["idceco"] = $gre->idceco;
        if ($gre->idtare!=null) $cond["idtare"] = $gre->idtare;
        if ($gre->idesoc!=null) $cond["idesoc"] = $gre->idesoc;

 
        //debug($cond);
		
        $OrdenesCompras = $this->paginate($this->OrdenesCompras->find('all')->where($cond));

        $this->set("registros", $OrdenesCompras); 
		
       $this->llena_lista('gerencias', 'nombre', $idempr);
       $this->llena_lista('proyectos', 'nombre', $idempr);
       $this->llena_lista('lineas_negocios', 'nombre', $idempr);
       $this->llena_lista('centros_costos', 'nombre', $idempr);
       $this->llena_lista('tareas', 'nombre', $idempr);
	   $this->llena_lista('productos', 'nombre', $idempr);
       $this->llena_lista('estados_notas_vtas', 'descripcion');
	   $this->llena_lista('unidades_medidas_productos', 'descripcioncorta');
	   $this->llena_lista('bodegas', 'nombre', $idempr);	

       $this->llena_lista('estados_ordenes_compras', 'descripcion');	 	 
	   
	   $this->getProveedores();		
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