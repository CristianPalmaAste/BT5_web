<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class CierresPeriodosContablesController extends AppController
 {
    public function index()
    {    
       $session = $this->request->session();      
       $conn = ConnectionManager::get('default');          
       $empresa = $session->read("empresa");   
	   $this->set('empresa', $empresa); 		   
       $idgrem = $session->read("idgrem");  		
       $idempr = $session->read("idempr");  		
	   IF ($idgrem == ''){
	      $this->Flash->error(__('Usted fue desconectado del sistema vuelva a ingresar'));
	   }else{
          $sql = "select mes || '-' || anno periodo_abierto
                  from   peco
                  where  idempr = ".$idempr."
                  and    idespc = 1";
		  $stmt = $conn->execute($sql);		
          $results = $stmt->fetchAll('assoc'); 
          $this->set('periodo_abierto', $results[0]['periodo_abierto']); 	
          $sql = "select razonsocial,id
			   	  from   empresas
				  where  id = ".$idempr." ";        
		  $stmt = $conn->execute($sql);		
		  $results = $stmt->fetchAll('assoc'); 
		  $this->set('empresa_pa', $results[0]['razonsocial']); 	
		
		  if ($this->request->is('post')) {
		     if($this->request['data']['mes'] == 0 && $this->request['data']['anno'] == '' ){
			    $this->Flash->error(__('Debe Ingresar el mes y el año para realizar el cierre del periodo contable')); 
			 }elseif($this->request['data']['mes'] == 0 && $this->request['data']['anno'] != ''){
				$this->Flash->error(__('Debe Ingresar el mes para realizar el cierre del periodo contable')); 
			 }elseif ($this->request['data']['mes'] != 0 && $this->request['data']['anno'] == ''){
				$this->Flash->error(__('Debe Ingresar el año para realizar el cierre del periodo contable'));
			 }elseif(strlen($this->request['data']['anno']) != 4){
				$this->Flash->error(__('Debe Ingresar el año de 4 digitos'));
			 }elseif ($this->request['data']['anno'] < 2000 || $this->request['data']['anno'] > 3000){
				$this->Flash->error(__('Debe Ingresar un año entre el 2000 y 3000.'));
			 }else{			
			    $sql = "select f_cerrar_peco  (". $results[0]['id'].",".$this->request['data']['mes'].",".$this->request['data']['anno'].",".$session->read("idusua").");";						 
				$stmt = $conn->execute($sql);		
				$results = $stmt->fetchAll('assoc'); 
				//print_a($results);
				$mensaje_va = substr($results[0]['f_cerrar_peco'],0,1);		
				$mensaje_fu = $results[0]['f_cerrar_peco'];			
				$mensaje = substr($results[0]['f_cerrar_peco'],2,strlen($mensaje_fu));
				if($results[0]['f_cerrar_peco'] == ''){
				   $this->Flash->error(__('Error al realizar el cierre del periodo contable'));
				}elseif($mensaje_va == 'N') {
				   $this->Flash->error(__($mensaje));
				}else{
					$this->Flash->success(__($mensaje));
				}	
			 }
		  }
	   }	
    }       
}
