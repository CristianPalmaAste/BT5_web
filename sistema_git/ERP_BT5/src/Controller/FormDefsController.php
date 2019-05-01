<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class FormDefsController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idgrem = $session->read("idgrem");

        $gre = $this->FormDefs->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->FormDefs->patchEntity($gre, $this->request->data);
        }             

        $cond = [];

           if ($gre->id!=null)
      $cond["id"] = $gre->id;
   if ($gre->caption!=null)
      $cond["caption like"] = $gre->caption."%";
   if ($gre->table_name!=null)
      $cond["table_name like"] = $gre->table_name."%";
   if ($gre->ins_allowed!=null)
      $cond["ins_allowed like"] = $gre->ins_allowed."%";
   if ($gre->upd_allowed!=null)
      $cond["upd_allowed like"] = $gre->upd_allowed."%";
   if ($gre->del_allowed!=null)
      $cond["del_allowed like"] = $gre->del_allowed."%";

 
        $FormDefs = $this->paginate($this->FormDefs->find('all')->where($cond));

        $this->set("registros", $FormDefs); 
    }

   

    public function edit($id=null) {
       $gre = $this->FormDefs->get($id);

       $tbl = TableRegistry::get('FieldDefs');

       $this->set("errors", []);

	   if ($this->request->is(['post', 'put'])) {
          $session = $this->request->session();

          $this->request->data["idusuamodifregistro"] = $session->read("idusua");
          
          $this->request->data["fechamodifregistro"] = date('Y-m-d H:i:s');

	      $this->FormDefs->patchEntity($gre, $this->request->data);

	      if ($this->FormDefs->save($gre)) {  
             $nrows = $_REQUEST["nrows"];

             for ($i=0; $i < $nrows; $i++) {
                $idh = $_REQUEST["id$i"];
          
                $hh = $tbl->get($idh);

                $hh->forder    = $_REQUEST["forder$i"]; 
                $hh->caption   = $_REQUEST["caption$i"];
                $hh->gadget    = $_REQUEST["gadget$i"];
                $hh->size      = $_REQUEST["size$i"];
                $hh->maxlength = $_REQUEST["maxlength$i"];
                $hh->rows      = $_REQUEST["rows$i"];
                $hh->cols      = $_REQUEST["cols$i"];
                $hh->req       = $_REQUEST["req$i"];
                $hh->selvalues = $_REQUEST["selvalues$i"];
                $hh->readonly  = $_REQUEST["readonly$i"]; 
                $hh->default   = $_REQUEST["default$i"]; 

                $tbl->save($hh);
             }

	         $this->Flash->success(__('Registro ha sido actualizado.'));
	         return $this->redirect(['action' => 'index']);
	      }

          $this->set("errors", $gre->errors());
	      $this->Flash->error(__('No se puede modificar el registro.'));

	   }

	   $this->set('gre', $gre);

       

       $rows = $tbl->find('all')->where("form_id=$id")->order("forder");

       $this->set("rows", $rows);

       $this->viewBuilder()->layout('custom2');
    }

    public function newFld($id) {
       $tbl = TableRegistry::get('FieldDefs');

       $gre = $tbl->newEntity();

       $this->set("errors", []); 

	   if ($this->request->is('post')) {
         $session = $this->request->session();

         $this->request->data["idusuacrearegistro"] = $session->read("idusua");

         $this->request->data["fechacrearegistro"] = date('Y-m-d H:i:s');

         $conn = ConnectionManager::get('default');

         $stmt = $conn->execute("SELECT NEXTVAL('');");

         $results = $stmt ->fetchAll('assoc');

         $this->request->data["id"] = $results[0]["nextval"];

         //print_r($this->request->data); return;

	     $gre = $this->FormDefs->patchEntity($gre, $this->request->data);

	     if ($this->FormDefs->save($gre)) {
	          $this->Flash->success(__('Registro ha sido creado.'));
	          return $this->redirect(['action' => 'index']);
	     }

         $this->set("errors", $gre->errors());

	     $this->Flash->error(__('No se puede crear registro.'));

	   }

       $gre->form_id    = $id;
       $gre->name       = "NONAME"; 
       $gre->type       = "character";
       $gre->len        = 10;
       $gre->decim      =  0;
       $gre->pk         = "N";
       $gre->req        = "N";
       $gre->caption    ="NOCAPTION";
       $gre->gadget     = "input";
       $gre->size       = 10;
       $gre->maxlength  = 10;
       $gre->rows       =  5;
       $gre->cols       = 50;
       $gre->selvalues  = "";
       $gre->sqlvalues  = "";
       $gre->visible    = "Y";
       $gre->readonly   = "N";
       $gre->default    = "";
       $gre->fld_type   = "X"; 
       $gre->fld_offset = -1;

       $this->set('gre', $gre);

       $this->viewBuilder()->layout('custom2');
       $this->render("edit_fld");
    }

    public function view($id=null) {
       $gre = $this->FormDefs->get($id);
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

       $registro = $this->FormDefs->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->FormDefs->save($registro);

       return $this->redirect(['action' => 'index']);

    }

    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=datos.csv');

       // create a file pointer connected to the output stream
       $output = fopen('php://output', 'w');


       $egrem = TableRegistry::get('EstadosGrem');
       $pais  = TableRegistry::get('Paises');
       
       $paises = $pais->obtPaises();

       $egrem  = $egrem->obtEstadosGrem();

       // output the column headings
       fputcsv($output, array('Nombre', 'Alias', 'Icono', 'País', 'Estado'));


       $rows = $this->FormDefs->find('all'); 

       foreach($rows as $row) {
          $r['nombre'] = $row->nombre;
          $r['alias']  = $row->alias;
          $r['icono']  = $row->icono;
          $r['pais']   = $paises[$row->idpais];
          $r['estado'] = $egrem[$row->idesge];
          fputcsv($output, $r);
       }

       $this->viewBuilder()->layout('custom');
    }

    
}
