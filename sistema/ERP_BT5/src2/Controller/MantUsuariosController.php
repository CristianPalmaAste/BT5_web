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


class MantUsuariosController extends AppController
{
   public function index()
   {
      $Usuav = TableRegistry::get('Usuav');
   

      $gre = $Usuav->newEntity();

      if ($this->request->is('post')) {
         $gre = $Usuav->patchEntity($gre, $this->request->data);
      }

	  $session = $this->request->session();
      $idgrem = $session->read("idgrem");
	  
	  $cond=["idgrem" => $idgrem];
	  
      $this->set("gre", $gre);

      if ($gre->id!=null)
         $cond["id"] = $gre->id;

      if ($gre->username!=null)
         $cond["username like"] = $gre->username."%";

      if ($gre->password!=null)
         $cond["password like"] = $gre->password."%";

      if ($gre->idpers!=null)
         $cond["idpers"] = $gre->idpers;

      if ($gre->idesre!=null)
         $cond["idesre"] = $gre->idesre;
	  
      $Usuarios = $this->paginate($Usuav->find('all')->where($cond));

      $this->set("registros", $Usuarios);
   }

   public function add() {
      $this->render("edit");

      $session = $this->request->session();
      $idgrem = $session->read("idgrem");
      $idempr = $session->read("idempr");

      $this->Usuarios = TableRegistry::get('Usuarios');

      $gre = $this->Usuarios->newEntity();

      $this->set("errors", []);

	   if ($this->request->is('post')) {

         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('usua_seq');");

         $results = $stmt ->fetchAll('assoc');

         $this->request->data["id"] = $results[0]["nextval"];

	     $gre = $this->Usuarios->patchEntity($gre, $this->request->data);
         $gre->id = $results[0]["nextval"];
         $gre->idgrem = $idgrem;

		 try {
			 $conn->begin();
			 if ($this->Usuarios->save($gre)) {
	         
			 	$tbl = TableRegistry::get('UsuariosPerfiles');
			 	
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
		 
         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));
	   }

      $gre->idgrem=$idgrem;
      $gre->idesre=1;

      $this->set('gre', $gre);
	  
	  //echo $idgrem."<hr/>";

      $personas  = TableRegistry::get('persv');
      $arr = $personas->find('all')->where(['idgrem' => $idgrem])->order(["apellidopaterno", "apellidomaterno", "primernombre", "segundonombre"]);

	  //debug($arr);
	  
      $lista=[];
      $lista[]="Seleccione persona";
      foreach($arr as $r)
         $lista[$r->id] = $r->primernombre." ".$r->segundonombre." ".$r->apellidopaterno." ".$r->apellidomaterno;

      $this->set("personas", $lista);

      $estados  = TableRegistry::get('EstadosRegistros');
      $arr2 = $estados->find('all')->order("descripcion");

      $lista2=[];
      $lista2[]="Seleccione";
      foreach($arr2 as $rr)
         $lista2[$rr->id] = $rr->descripcion;

      $this->set("estados", $lista2);
	  
	  $grid = $this->setGrid();
	   
	  $this->set("grilla", $grid->show());
	  $this->set("extrajs", $grid->genGridJs());
	   
	  $this->set("nRow", $grid->nRow + 1);
	   
	  //$this->set("lProductos", "");
	   
      $this->render("edit");
   }

   public function edit($id=null) {
      $session = $this->request->session();
      $idgrem = $session->read("idgrem");
      $idempr = $session->read("idempr");
	  
	  $conn = ConnectionManager::get('default');

      $this->Usuarios = TableRegistry::get('Usuarios');

      $gre = $this->Usuarios->get($id);

      $this->set("errors", []);

      if ($this->request->is(['post', 'put'])) {
         $this->request->data["idusuamodifregistro"] = $session->read("idusua");

         $this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');

	     $this->Usuarios->patchEntity($gre, $this->request->data);

		 try {
			 $conn->begin();
    		 if ($this->Usuarios->save($gre)) {
                
    
    			//echo "delete from usuarios_perfiles where idusua=$id<br/>";
    
                $stmt = $conn->execute("delete from usuarios_perfiles where idusua=$id");
                 
    			$this->graba_detalle($id);
    			
    			$conn->commit();
    			
    	        $this->Flash->success(__('Registro ha sido actualizado.'));
    	        return $this->redirect(['action' => 'index']);
    	      }else {
                 $this->set("errors", $gre->errors());
    	         throw new \Exception(__('No se puede modificar el registro.'));
    		  }
		  }
		 catch(\Exception $ex) {
			//echo $ex;
			$conn->rollback();
		 }
      }

	   $this->set('gre', $gre);

      $personas  = TableRegistry::get('usuav');
      $arr = $personas->find('all')->where(['idgrem' => $idgrem, "estado_registro" => "ACTIVO"])->order("nombre_persona");

      $lista=[];
      $lista[]="Seleccione persona";
      foreach($arr as $r)
         $lista[$r->id] = $r->nombre_persona;

      $this->set("personas", $lista);

      $estados  = TableRegistry::get('EstadosRegistros');
      $arr = $estados->find('all')->order("descripcion");

      $lista=[];
      foreach($arr as $r){
           $lista[$r->id] = $r->descripcion;
      }

      $this->set("estados", $lista);
	  
	  $sql  = "select e.id empresa, p.id perfil, u.idempr, u.idperf 
	           from usuarios_perfiles u
			       ,empresas e
				   ,perfiles p
			   where u.idempr=e.id
			   and   u.idperf=p.id
			   and   u.idusua=$id
			   order by e.razonsocial, p.descripcion
	          ";
			  
	  $stmt = $conn->execute($sql);

      $arr = $stmt ->fetchAll('assoc');
	  
	  //print_r($arr);
	  
	  $grid = $this->setGrid($arr);
	   
	  $this->set("grilla", $grid->show());
	  $this->set("extrajs", $grid->genGridJs());
	   
	  $this->set("nRow", $grid->nRow + 1);
   }
   
   function setGrid($rows=array()) {
	   $session = $this->request->session();
	   $idgrem  = $session->read("idgrem");
	   
	   $grid = new miGrilla($rows);
	   
	   $emp = TableRegistry::get('Empresas');
	   $per = TableRegistry::get('Perfiles');
	   
	   $r = $emp->find('all')->where(['idgrem' => $idgrem])->order('razonsocial');
	   
	   $empresas[""] = "";
	   foreach($r as $s) {
		  $empresas[$s["id"]] = $s["razonsocial"];
	   }
	   
	   $r = $per->find('all')->where(['id not in' => [1, 2]])->order('descripcion');
	   
	   $perfiles[""] = "";
	   foreach($r as $s) {
		  $perfiles[$s["id"]] = $s["descripcion"];
	   }
	      
	   $grid->addCol(["name" => "empresa"        , "caption" => "Empresa", "gadget" => "select", "selvalues" => $empresas, "required" => true ]);
	   $grid->addCol(["name" => "perfil"         , "caption" => "Perfil",  "gadget" => "select", "selvalues" => $perfiles, "required" => true ]);
	   $grid->addCol(["name" => "idempr"         , "gadget"  => "hidden" ]);
	   $grid->addCol(["name" => "idperf"         , "gadget"  => "hidden" ]);
	   
	   return $grid;
	}
	
	function graba_detalle($id) {		
	   $session = $this->request->session();
	   $idgrem  = $session->read("idgrem");
	   
	   $conn = ConnectionManager::get('default');
	   
	   $allRows=$_REQUEST["allRows"];
	   
	   $l = explode("@@@", $allRows);
	   
	   $tbl = TableRegistry::get('UsuariosPerfiles');
	   
	   foreach($l as $ll) {
		  $e = explode("|", $ll);
		  
          $gg = $tbl->newEntity();

          $stmt = $conn->execute("SELECT NEXTVAL('uspe_seq')");

          $results = $stmt ->fetchAll('assoc');

          $gg->id     = $results[0]["nextval"];
          $gg->idusua = $id;
          $gg->idperf = $e[3];
          $gg->idesre = 1;
		  $idempr = $e[2];

          if ($gg->idperf==1) {
             $gg->idgrem = null;
             $gg->idempr = null;
          }else if ($gg->idperf==2) {
             $gg->idgrem = $idgrem;
             $gg->idempr = null;
          }else{
             $gg->idgrem = null;
             $gg->idempr = $idempr;
          }

          $gg->idusuacrearegistro = $session->read("idusua");
          $gg->fechacrearegistro  = date('Y-m-d H:i:s');

          $tbl->save($gg);
		  
		  
	   }
	}

   public function view($id=null) {
	  $session = $this->request->session();
	  $idgrem  = $session->read("idgrem");
	   
	  $conn = ConnectionManager::get('default');
	  
	  $this->Usuarios = TableRegistry::get('Usuarios');
	  $gre = $this->Usuarios->get($id);
	  
	  $this->set("gre", $gre);
	  
	  $sql  = "select e.razonsocial empresa, p.descripcion perfil, u.idempr, u.idperf 
	           from usuarios_perfiles u
			       ,empresas e
				   ,perfiles p
			   where u.idempr=e.id
			   and   u.idperf=p.id
			   and   u.idusua=$id
			   order by e.razonsocial, p.descripcion
	          ";
			  
	  $stmt = $conn->execute($sql);

      $arr = $stmt ->fetchAll('assoc');
	  
	  //print_r($arr);
	  
	  $grid = $this->setGrid($arr);
	  $grid->readonly=true;
	  
	  $this->set("grilla", $grid->show());
	  $this->set("extrajs", $grid->genGridJs());
	   
	  $this->set("nRow", $grid->nRow + 1);
	  
	  $personas  = TableRegistry::get('Personas');
      $arr = $personas->find('all')->where(['idgrem' => $idgrem])->order(["apellidopaterno","apellidomaterno","primernombre","segundonombre"]);

      $lista=[];
      foreach($arr as $r){
         $lista[$r->id] = $r->apellidopaterno." ".$r->apellidomaterno." ".$r->primernombre." ".$r->segundonombre;
      }

      $this->set("personas", $lista);

      $estados  = TableRegistry::get('EstadosRegistros');
      $arr = $estados->find('all')->order("descripcion");

      $lista=[];
      foreach($arr as $r){
           $lista[$r->id] = $r->descripcion;
      }

      $this->set("estados", $lista);
      
    }

    public function delete($id){
       $session = $this->request->session();
	   
	   $usua= TableRegistry::get('Usuarios');

       $registro = $usua->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');
	    	   
	   try {
         if ($usua->save($registro)) {
             $this->Flash->success(__('Usuario ha sido eleminado.'));
         } else {
             $this->Flash->error(__('No se ha podido eliminar al usuario.'));
         }
	  }
	  catch(\Exception $ex) {
		  $this->Flash->error(__('No se ha podido eliminar al usuario.')); 
	  }

       return $this->redirect(['action' => 'index']);
    }

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=usuarios.xlsx');

       $session = $this->request->session();
	   $idempr  = $session->read("idempr");

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Holding')
                                           ->setCellValue('B1', 'Rut')
                                           ->setCellValue('C1', 'Dv')
                                           ->setCellValue('D1', 'Primer Nombre')
                                           ->setCellValue('E1', 'Segundo Nombre')
                                           ->setCellValue('F1', 'Apellido Paterno')
                                           ->setCellValue('G1', 'Apellido Materno')
                                           ->setCellValue('H1', 'E-Mail')
                                           ->setCellValue('I1', 'Fec/Nacimiento')
                                           ->setCellValue('J1', 'Estado Civil')
                                           ->setCellValue('K1', 'Sexo')
                                           ->setCellValue('L1', 'Nacionalidad')
;

       $usuap = TableRegistry::get('UsuariosPerfiles');

	   $r = $usuap->find("all")->where(["idempr" => $idempr]);

	   $lista =[];
	   foreach($r as $s)
		   $lista[] = $s["idusua"];

       $tbl  = TableRegistry::get('Persv');

       $rows = $tbl->find('all'); //->where(['idempr' => $idempr]);

       $n=2;
       foreach($rows as $r) {
		  if (in_array($r->id, $lista)) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->holding)
                                              ->setCellValue("B$n", $r->rut)
                                              ->setCellValue("C$n", $r->dv)
                                              ->setCellValue("D$n", $r->primernombre)
                                              ->setCellValue("E$n", $r->segundonombre)
                                              ->setCellValue("F$n", $r->apellidopaterno)
                                              ->setCellValue("G$n", $r->apellidomaterno)
                                              ->setCellValue("H$n", $r->email)
                                              ->setCellValue("I$n", $r->fechanac)
                                              ->setCellValue("J$n", $r->estadocivil)
                                              ->setCellValue("K$n", $r->sexo)
                                              ->setCellValue("L$n", $r->nacionalidad)
;

             $n++;
		  }
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