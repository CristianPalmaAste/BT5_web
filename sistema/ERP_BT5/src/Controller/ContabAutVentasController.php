<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class ContabAutVentasController extends AppController
 {
    public function index()
    {
       $session = $this->request->session();
       $conn = ConnectionManager::get('default');
       $empresa = $session->read("empresa");
       $this->set('empresa', $empresa);
       $idgrem = $session->read("idgrem");
       $idempr = $session->read("idempr");
	   
       if ($idgrem == ''){
          $this->Flash->error(__('Usted fue desconectado del sistema vuelva a ingresar'));
       }else{
          $sql = "select razonsocial,id
                  from   empresas
                  where  id = ".$idempr." ";
          $stmt = $conn->execute($sql);
          $results = $stmt->fetchAll('assoc');
          $this->set('empresa_pa', $results[0]['razonsocial']);
          
		  if ($this->request->is('post')) {
			 $fecha = $this->request['data']['fecha'];
			 
		     //echo "Fecha: ".$fecha."<hr/>"; return; 
		
			 //YYYY-MM-DD
			 $fecha2 = str_replace("-", "", $fecha);	 
			 
			 
             //$sql = "select f_contabilizar_ventas  (". $results[0]['id'].",".$this->request['data']['mes'].",".$this->request['data']['anno'].",".$session->read("idusua").");";
                $sql = "select f_contabilizar_ventas  (". $results[0]['id'].","."'N',$fecha2,$fecha2".",".$session->read("idusua").");";
                $stmt = $conn->execute($sql);
                $results = $stmt->fetchAll('assoc');
                //print_a($results);
                $mensaje_va = substr($results[0]['f_contabilizar_ventas'],0,1);
                $mensaje_fu = $results[0]['f_contabilizar_ventas'];
                $mensaje = substr($results[0]['f_contabilizar_ventas'],2,strlen($mensaje_fu));
                if($results[0]['f_contabilizar_ventas'] == ''){
                   $this->Flash->error(__('Error al realizar la contabilización de las ventas'));
                }elseif($mensaje_va == 'N') {
                   $this->Flash->error(__($mensaje));
                }else{
                    $this->Flash->success(__($mensaje));
                }
             }
          }
    }
   
}
