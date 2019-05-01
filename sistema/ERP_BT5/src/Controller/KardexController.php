<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class KardexController extends AppController
{
    public function index()
    {
        $session = $this->request->session();
        $idempr  = $session->read("idempr");

		$producto  = TableRegistry::get('Productos');
		
        $gre = $producto->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $producto->patchEntity($gre, $this->request->data);
        }             
		
		
		$this->set("gre", $gre);
		$cond["idusuaborraregistro is"] = null;

       

 
        //$Kardex = $this->paginate($this->Kardex->find('all')->where($cond));

        //$this->set("registros", $Kardex); 
    }
}	

