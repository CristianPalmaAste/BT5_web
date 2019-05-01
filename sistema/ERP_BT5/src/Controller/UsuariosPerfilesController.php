<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class UsuariosPerfilesController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->UsuariosPerfiles->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->UsuariosPerfiles->patchEntity($gre, $this->request->data);
        }             
		
        $this->set("gre", $gre);
        
        $cond = [];
        $cond["idusuaborraregistro is"] = null;
        $cond['idempr']=$session->read('idempr');
		$cond['fechaborraregistro is'] = null;

        
        $cond = [];
        $cond['idgrem']=$session->read('idgrem');
        $cond['idempr']=$session->read('idempr');
        $cond['idusuacrearegistro is']=null;

       

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idusua!=null) $cond["idusua"] = $gre->idusua;
if ($gre->idperf!=null) $cond["idperf"] = $gre->idperf;
if ($gre->idgrem!=null) $cond["idgrem"] = $gre->idgrem;
if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
if ($gre->idesre!=null) $cond["idesre"] = $gre->idesre;

 
        $UsuariosPerfiles = $this->paginate($this->UsuariosPerfiles->find('all')->where($cond));

        $this->set("registros", $UsuariosPerfiles); 
    }

    public function add() {
       $this->render("edit");

       $session = $this->request->session();

       $gre = $this->UsuariosPerfiles->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
         
         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('uspe_seq');");

         $results = $stmt ->fetchAll('assoc');

	     $gre = $this->UsuariosPerfiles->patchEntity($gre, $this->request->data);
         $gre->id = $results[0]["nextval"];

	     if ($this->UsuariosPerfiles->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       $idgrem = $session->read("idgrem");
       $idempr = $session->read("idempr");

       $this->set('gre', $gre);

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
       $gre = $this->UsuariosPerfiles->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {


          $this->request->data["idusuamodifregistro"] = $session->read("idusua");
          
          $this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');

	      $this->UsuariosPerfiles->patchEntity($gre, $this->request->data);

	      if ($this->UsuariosPerfiles->save($gre)) {  
	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          $this->set("errors", $gre->errors());
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);

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

       $gre = $this->UsuariosPerfiles->get($id);
       $this->set("errors", []); 

	   $this->set('gre', $gre);

       /*
       $egrem = TableRegistry::get('EstadosGrem');
       $pais  = TableRegistry::get('Paises');
       
       $this->set("paises", $pais->obtPaises());

       $this->set("egrem", $egrem->obtEstadosGrem());
       */

    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->UsuariosPerfiles->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->UsuariosPerfiles->save($registro);

       return $this->redirect(['action' => 'index']);

    }

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=usuarios_perfiles.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'id')
->setCellValue('B1', 'idusua')
->setCellValue('C1', 'idperf')
->setCellValue('D1', 'idgrem')
->setCellValue('E1', 'idempr')
->setCellValue('F1', 'idesre')
;

       $rows = $this->UsuariosPerfiles->find('all')->where(['idgrem' => $session->read('idgrem')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->id)
->setCellValue("B$n", $r->idusua)
->setCellValue("C$n", $r->idperf)
->setCellValue("D$n", $r->idgrem)
->setCellValue("E$n", $r->idempr)
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

    
}
