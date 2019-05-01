<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class ClientesController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->Clientes->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->Clientes->patchEntity($gre, $this->request->data);
        }             

        
        $cond = [];
         $cond['idgrem']=$session->read('idgrem');
         $cond['idusuacrearegistro is']=null;

       

        if ($gre->id!=null) $cond["id"] = $gre->id;
if ($gre->idgrem!=null) $cond["idgrem"] = $gre->idgrem;
if ($gre->identificador1!=null) $cond["identificador1 like"] = $gre->identificador1."%";
if ($gre->identificador2!=null) $cond["identificador2 like"] = $gre->identificador2."%";
if ($gre->idticl!=null) $cond["idticl"] = $gre->idticl;
if ($gre->razonsocial!=null) $cond["razonsocial like"] = $gre->razonsocial."%";
if ($gre->nombrefantasia!=null) $cond["nombrefantasia like"] = $gre->nombrefantasia."%";
if ($gre->primernombre!=null) $cond["primernombre like"] = $gre->primernombre."%";
if ($gre->segundonombre!=null) $cond["segundonombre like"] = $gre->segundonombre."%";
if ($gre->apellidopaterno!=null) $cond["apellidopaterno like"] = $gre->apellidopaterno."%";
if ($gre->apellidomaterno!=null) $cond["apellidomaterno like"] = $gre->apellidomaterno."%";
if ($gre->idpais!=null) $cond["idpais"] = $gre->idpais;

 
        $Clientes = $this->paginate($this->Clientes->find('all')->where($cond));

        $this->set("registros", $Clientes); 
    }

    public function add() {
       $this->render("edit");

       $session = $this->request->session();

       $gre = $this->Clientes->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
         
         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('clie_seq');");

         $results = $stmt ->fetchAll('assoc');

	     $gre = $this->Clientes->patchEntity($gre, $this->request->data);
         $gre->id = $results[0]["nextval"];

	     if ($this->Clientes->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       $idgrem = $session->read("idgrem");
       //$idempr = $session->read("idempr");

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
       $gre = $this->Clientes->get($id);

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {


          $this->request->data["idusuamodifregistro"] = $session->read("idusua");
          
          $this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');

	      $this->Clientes->patchEntity($gre, $this->request->data);

	      if ($this->Clientes->save($gre)) {  
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

       $gre = $this->Clientes->get($id);
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

       $registro = $this->Clientes->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->Clientes->save($registro);

       return $this->redirect(['action' => 'index']);

    }

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=clientes.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

       //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Rut')
->setCellValue('B1', 'Dv')
->setCellValue('C1', 'Tipo ')
->setCellValue('D1', 'Razón social')
->setCellValue('E1', 'Nombre fantasía')
->setCellValue('F1', 'Primer nombre')
->setCellValue('G1', 'Segundo nombre')
->setCellValue('H1', 'Apellido paterno')
->setCellValue('I1', 'Apellido materno')
->setCellValue('J1', 'País')
;

       $rows = $this->Clientes->find('all')->where(['idgrem' => $session->read('idgrem')]); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->identificador1)
->setCellValue("B$n", $r->identificador2)
->setCellValue("C$n", $r->idticl)
->setCellValue("D$n", $r->razonsocial)
->setCellValue("E$n", $r->nombrefantasia)
->setCellValue("F$n", $r->primernombre)
->setCellValue("G$n", $r->segundonombre)
->setCellValue("H$n", $r->apellidopaterno)
->setCellValue("I$n", $r->apellidomaterno)
->setCellValue("J$n", $r->idpais)
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
