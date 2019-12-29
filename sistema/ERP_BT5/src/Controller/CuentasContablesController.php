<?php

namespace App\Controller;

use Cake\Core\Configure;
use Cake\Network\Exception\ForbiddenException;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\Datasource\ConnectionManager;


class CuentasContablesController extends AppController
 {
    public function index()
    {
	          $buscar = false;
      if(count($this->request->data)){
         if( $this->request->data['search'] != '' && $this->request->data['searchBy'] != '' ){
            $buscar = true;
            $searchBy = 'f_limpia(upper('.$this->request->data['searchBy'].')) like';
            $search = "%".strtoupper( $this->translateAccents($this->request->data['search'] ) )."%";
         }
      }

      $searchOptions = array(
         'cuenta_desplegable'    => 'Cuenta',
         'tipo_cuenta_contable' => 'Tipo Cuenta',
         'descripcion'           => 'Nombre Cuenta'
      );
      $session = $this->request->session();
      $idgrem = $session->read("idgrem");
      $basePath = '/media_holdings/'.$idgrem.'/';

      
	    
        $session = $this->request->session();         
        $empresa = $session->read("empresa");   
	    $this->set('empresa', $empresa);  
        $separador = TableRegistry::get('Parametros');
		$query1 = $separador->find('all')->where(['idgrem' => $session->read('idgrem'), 'nombrecorto'=>'SEPNIVELES']);		
		foreach ($query1 as $row) {		   
		   $separador=$row->valor;	
		   $this->set("separador", $separador); 	
		}
		
        $cuco = $cucov  = TableRegistry::get('Cucov');
        $gre = $cuco->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $cuco->patchEntity($gre, $this->request->data);
        }                      

        $this->set("gre", $gre);        
          		
        $cond = ["idgrem" => $idgrem];  
        if ($gre->cuenta_desplegable !=null)
        $cond["cuenta_desplegable like"] = $gre->cuenta_desplegable."%";
	    if ($gre->tipo_cuenta_contable !=null)
	    $cond["tipo_cuenta_contable like"] = $gre->tipo_cuenta_contable."%";
	    if ($gre->descripcion!=null)
	    $cond["descripcion like"] = $gre->descripcion."%";
        if ($gre->id!=null) $cond["id"] = $gre->id;            

        if( $buscar ){
           $cond = array_merge( $cond, [$searchBy => $search]);
        }
        //$CuentasContables = $this->paginate($cucov->find('all')->where($cond));
        $cuentas_contables = $this->paginate($cuco->find('all')->where($cond));
        $this->set("registros", $cuentas_contables); 
        
      $this->set(compact('searchOptions'));
      $this->set(compact('basePath'));
    }

    public function add() {	    
       $session = $this->request->session();      
       $conn = ConnectionManager::get('default');          
       $empresa = $session->read("empresa");   
	   $this->set('empresa', $empresa); 		   
        $idgrem = $session->read("idgrem");              
	    
	   $parametro = TableRegistry::get('Parametros');
	   $query = $parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'NROSEGMSCUCO']);
	   foreach ($query as $row) {		   
		 $para_valor=$row->valor;	
		 $this->set("para_valor", $para_valor); 	 
         $largo_parametro = TableRegistry::get('Parametros');
		 $query1 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM1']);		
		 foreach ($query1 as $row) {		   
		    $para1=$row->valor;	
			$this->set("para1", $para1); 	
		}
		$query2 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM2']);		
		 foreach ($query2 as $row) {		   
		    $para2=$row->valor;	
			$this->set("para2", $para2); 
		}
		$query3 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM3']);		
		 foreach ($query3 as $row) {		   
		    $para3=$row->valor;	
			$this->set("para3", $para3); 	
		}
		$query4 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM4']);		
		 foreach ($query4 as $row) {		   
		    $para4=$row->valor;	
			$this->set("para4", $para4); 	
		}
		$query5 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM5']);		
		 foreach ($query5 as $row) {		   
		    $para5=$row->valor;	
			$this->set("para5", $para5); 	
		}
		$query6 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM6']);		
		 foreach ($query6 as $row) {		   
		    $para6=$row->valor;	
			$this->set("para6", $para6); 
		}
		$query7 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM7']);		
		foreach ($query7 as $row){ 
			$para7=$row->valor;	
		    $this->set("para7", $para7); 	
		}
		$query8 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM8']);		
		 foreach ($query8 as $row) {		   
		    $para8=$row->valor;	
			$this->set("para8", $para8); 	
		}
	  }  
		
        $gre = $this->CuentasContables->newEntity();     
		if ($this->request->is('post')) {
			//$segmento2 = "";
			$revision_validacion = 0;
			
					$segmento1 = "and segmento1 = '".$this->request['data']['segmento1']."'";
					$valor_seg1 = $this->request['data']['segmento1'];
					$valor_seg1_punto = $this->request['data']['segmento1'].".";
			    	$query1 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM1']);		
				    foreach ($query1 as $row) {
						if(strlen($this->request->data['segmento1']) <> $row->valor ){	
						   $revision_validacion = 1;
					       $this->Flash->error(__('El largo del segmento1 debe ser de '.$row->valor.' dígitos')); 
						}
						$para1=$row->valor;	
						$this->set("para1", $para1); 
					}  
			    
	      	if (isset($this->request['data']['segmento2'])){ 
	           if ($this->request['data']['segmento2'] == ''){	
		           $segmento2 = "";
		       	   $valor_seg2 = "";
		       	   $valor_seg2_punto = "";	
		           $segmentos = "";             
		           $this->Flash->error(__('Segmento2 campo Obligatorio'));
		           $revision_validacion = 1;
		       }else{
			      $segmento2 = "and segmento2 = '".$this->request['data']['segmento2']."'";
			      $valor_seg2 = $this->request['data']['segmento2'];			      
			      $valor_seg2_punto = $this->request['data']['segmento2'].".";
			      $query2 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM2']);		
				  foreach ($query2 as $row) {
				     if(strlen($this->request->data['segmento2']) <> $row->valor ){	
					    $revision_validacion = 1;
				        $this->Flash->error(__('El largo del segmento2 debe ser de '.$row->valor.' dígitos')); 
					  }
					  $para2=$row->valor;	
					  $this->set("para2", $para2); 
				  }
			   }
			}else{
		       $segmento2 = "";
		       $valor_seg2 = "";
		       $segmentos = "";
		       $valor_seg2_punto = "";
		    } 
		    if (isset($this->request['data']['segmento3'])){
	           if ($this->request['data']['segmento3'] == ''){	
		          $segmento3 = "";
		          $valor_seg3 = "";
		          $valor_seg3_punto = "";	
		          $revision_validacion = 1; 		          
		          $segmentos = "";              
	              $this->Flash->error(__('Segmento3 campo Obligatorio'));
	           }else{		            
			      $segmento3 = "and segmento3 = '".$this->request['data']['segmento3']."'";
			      $valor_seg3 = $this->request['data']['segmento3'];			      
			      $valor_seg3_punto = $this->request['data']['segmento3'].".";
			 	  $query3 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM3']);		
				  foreach ($query3 as $row) {	
				     if(strlen($this->request['data']['segmento3']) <> $row->valor ){	
					    $revision_validacion = 1;
			            $this->Flash->error(__('El largo del segmento3 debe ser de '.$row->valor.' dígitos'));
					 }	   	   
					 $para3=$row->valor;	
					 $this->set("para3", $para3); 	
			      }
			   }
	        }else{
		        $segmento3 = "";		        
		        $segmentos = "";
		        $valor_seg3 = "";
		        $valor_seg3_punto = "";
		    }
	        if (isset($this->request->data['segmento4'])){ 
		       if ($this->request['data']['segmento4'] == ''){	
			      $segmento4 = "";
	              $valor_seg4 = "";
	              $valor_seg4_punto = "";	
	              $revision_validacion = 1;    	              
		          $segmentos = "";          
	              $this->Flash->error(__('Segmento4 campo Obligatorio'));
	           }else{
			      $segmento4 = "and segmento4 = '".$this->request['data']['segmento4']."'";
			      $valor_seg4 = $this->request['data']['segmento4'];			      
			      $valor_seg4_punto = $this->request['data']['segmento4'].".";
			      $query4 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM4']);		
				  foreach ($query4 as $row) {	
				     if(strlen($this->request['data']['segmento4']) <> $row->valor ){	
					    $revision_validacion = 1;
			            $this->Flash->error(__('El largo del segmento4 debe ser de '.$row->valor.' dígitos'));
					 }	   
					 $para4=$row->valor;	
					 $this->set("para4", $para4); 	
				  }
			   }
            }else{
	           $segmento4 = "";	           
		       $segmentos = "";
	           $valor_seg4 = "";
	           $valor_seg4_punto = "";
	        }
            if (isset($this->request->data['segmento5'])){ 		  
	           if ($this->request['data']['segmento5'] == ''){	
		          $segmento5 = "";
		          $valor_seg5 = "";
		          $valor_seg5_punto = "";	
		          $revision_validacion = 1;        
		          $segmentos = "";       
	              $this->Flash->error(__('Segmento5 campo Obligatorio'));
	           }else{           
			      $segmento5 = "and segmento5 = '".$this->request['data']['segmento5']."'";
			      $valor_seg5 = $this->request['data']['segmento5'];			      
			      $valor_seg5_punto = $this->request['data']['segmento5'].".";
				  $query5 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM5']);		
				  foreach ($query5 as $row) {	
				     if(strlen($this->request['data']['segmento5']) <> $row->valor ){	
					    $revision_validacion = 1;
			            $this->Flash->error(__('El largo del segmento5 debe ser de '.$row->valor.' dígitos'));
					 }		   
					 $para5=$row->valor;	
					 $this->set("para5", $para5); 	
				   }
			    }
	         }else{
		        $segmento5 = "";
		        $valor_seg5 = "";
		        $segmentos = "";
		        $valor_seg5_punto = "";
		     }
             if (isset($this->request->data['segmento6'])){
	            if ($this->request['data']['segmento6'] == ''){	
		           $segmento6 = "";
	               $valor_seg6 = "";
	               $valor_seg6_punto = "";	
		           $segmentos = "";               
	               $revision_validacion = 1;
	               $this->Flash->error(__('Segmento6 campo Obligatorio'));
	            }else{		            
			       $segmento6 = "and segmento6 = '".$this->request['data']['segmento6']."'";
			       $valor_seg6 = $this->request['data']['segmento6'];			       
			       $valor_seg6_punto = $this->request['data']['segmento6'].".";
				   $query6 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM6']);		
			  	   foreach ($query6 as $row) {
				   	  if(strlen($this->request['data']['segmento6']) <> $row->valor ){	
					   	 $revision_validacion = 1;
			             $this->Flash->error(__('El largo del segmento6 debe ser de '.$row->valor.' dígitos'));
					  }		   
					  $para6=$row->valor;	
					  $this->set("para6", $para6); 
		           }
                }
             }else{
	            $segmento6 = "";
		        $segmentos = "";
	            $valor_seg6 = "";
	            $valor_seg6_punto = "";
	         }
	         if (isset($this->request->data['segmento7'])){ 
		        if ($this->request['data']['segmento7'] == ''){	
			       $segmento7 = "";
		           $valor_seg7 = "";
		           $valor_seg7_punto = "";	               
		           $revision_validacion = 1;
		           $segmentos = "";
	               $this->Flash->error(__('Segmento7 campo Obligatorio'));
	            }else{
			       $segmento7 = "and segmento7 = '".$this->request['data']['segmento7']."'";
			       $valor_seg7 = $this->request['data']['segmento7'];			       
			       $valor_seg7_punto = $this->request['data']['segmento7'].".";
				   $query7 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM7']);		
			   	   foreach ($query7 as $row){ 
				      if(strlen($this->request['data']['segmento7']) <> $row->valor ){	
					     $revision_validacion = 1;
			             $this->Flash->error(__('El largo del segmento7 debe ser de '.$row->valor.' dígitos'));
				      } 
				  	  $para7=$row->valor;	
					  $this->set("para7", $para7); 	
				   }
			    }
			 }else{
		        $segmento7 = "";
		        $valor_seg7 = "";
		        $segmentos = "";
		        $valor_seg7_punto = "";
		     }
			 if (isset($this->request->data['segmento8'])){ 					 
			    if ($this->request['data']['segmento8'] == ''){		
				   $segmento8 = "";
				   $valor_seg8 = "";
				   $valor_seg8_punto = "";    
		           $segmentos = "";
				   $revision_validacion = 1;           
	               $this->Flash->error(__('Segmento8 campo Obligatorio'));
	            }else{
		           $segmento8 = "and segmento8 = '".$this->request['data']['segmento8']."'";
		           $valor_seg8 = $this->request['data']['segmento8'];		           
			       $valor_seg8_punto = $this->request['data']['segmento1'].".";
				   $query8 = $largo_parametro->find('all')->where(['idgrem' => $session->read('idgrem'),'nombrecorto'=>'LARGOSEGM8']);		
				   foreach ($query8 as $row) {
			          if(strlen($this->request['data']['segmento8']) <> $row->valor ){	
				         $revision_validacion = 1;
			             $this->Flash->error(__('El largo del segmento8 debe ser de '.$row->valor.' dígitos'));
					  }		   
					  $para8=$row->valor;	
					  $this->set("para8", $para8); 	
				   }
			    } 
			 }else{
				 $segmento8 = "";
				 $valor_seg8 = "";
		         $segmentos = "";
				 $valor_seg8_punto = "";
		     }		   
		     if (!empty($this->request->data['idticc'])){
			     $segmentos_puntos = "'".$valor_seg1_punto."".$valor_seg2_punto."".$valor_seg3_punto."".$valor_seg4_punto."".$valor_seg5_punto."".$valor_seg6_punto."".$valor_seg7_punto."".$valor_seg8_punto."'"; 
                 $sql = "select substr(".$segmentos_puntos.",1,
		                                length(".$segmentos_puntos.")-1) as cuenta_desplegable_punto";
		        $stmt = $conn->execute($sql);
				$results = $stmt ->fetchAll('assoc'); 
				$cuenta_desplegable_punto = $results[0]['cuenta_desplegable_punto'];
				//$sql = "select substr('".$this->request->data['idticc']."', 1, position('|' in '".$this->request->data['idticc']."')-1) as idticc";
				//$stmt = $conn->execute($sql);
				//$results = $stmt ->fetchAll('assoc'); 
				$idgrem = $session->read('idgrem');
				$idticc = $this->request->data['idticc'];
				$descripcion = $this->request->data['descripcion'];
		        $sql1 = "select count(*) as segmentos 
		                  from cuentas_contables 
		                 where idgrem =$idgrem
		                 and  cuenta_desplegable = '".$cuenta_desplegable_punto."'
		                 ";                 
			    $stmt1 = $conn->execute($sql1);		
				$results1 = $stmt1->fetchAll('assoc'); 
				if ($results1[0]['segmentos'] != 0){
				   $revision_validacion = 1;
			       $this->Flash->error(__('El Segmento para el tipo de cuenta contable ya fue ingresado, intente nuevamente'));
			    }
	        }
	        if ($valor_seg1 != "" || $valor_seg2 != "" || $valor_seg3 != "" || $valor_seg4 != ""
	            || $valor_seg5 != "" || $valor_seg6 != "" || $valor_seg7 != "" || $valor_seg8 != ""){
			    $sql = "select substr('".$valor_seg1."".$valor_seg2."".$valor_seg3."".$valor_seg4."".$valor_seg5."".$valor_seg6."".$valor_seg7."".$valor_seg8."',
			                                length('".$valor_seg1."".$valor_seg2."".$valor_seg3."".$valor_seg4."".$valor_seg5."".$valor_seg6."".$valor_seg7."".$valor_seg8."')) as ultimo_valor";
		        $stmt = $conn->execute($sql);
				$results = $stmt ->fetchAll('assoc'); 
				$ultimo_valor = $results[0]['ultimo_valor'];
				 if ($ultimo_valor == 0){
		           $this->request->data['imputable'] = 'N';	           
		        }else{
			       $this->request->data['imputable'] = 'S';
			       $valor_segmentos = ($valor_seg1."".$valor_seg2."".$valor_seg3."".$valor_seg4."".$valor_seg5."".$valor_seg6."".$valor_seg7."".$valor_seg8)-1;
				   $valor_segmentos_f = "'".$valor_segmentos."'";
		
				   $sql2 = "select count(*) as existe_segmento 
			                 from cuentas_contables
		                    where concat(concat(concat(concat(concat(concat(segmento1,segmento2),segmento3),segmento4),segmento5),segmento6),segmento7,segmento8) = $valor_segmentos_f
			                  and idgrem =$idgrem	                 
			                 "; 
			                 //and idticc = $idticc/        
				   $stmt2 = $conn->execute($sql2);		
				   $results2 = $stmt2->fetchAll('assoc'); 
				   if ($results2[0]['existe_segmento'] == 0){
					  $revision_validacion = 1;
				      $this->Flash->error(__('No existe cuenta de nivel superior'));
				   }
			    }  
		    
	            $segmentos_puntos = $valor_seg1_punto."".$valor_seg2_punto."".$valor_seg3_punto."".$valor_seg4_punto."".$valor_seg5_punto."".$valor_seg6_punto."".$valor_seg7_punto."".$valor_seg8_punto; 
	            $sql = "select substr('".$segmentos_puntos."',1,
			                                length('".$segmentos_puntos."')-1) as valor_seg_sin_ult_punto";
		        $stmt = $conn->execute($sql);
				$results = $stmt ->fetchAll('assoc'); 
				$valor_seg_sin_ult_punto = $results[0]['valor_seg_sin_ult_punto'];
            }
			if ($revision_validacion == 0){
			    $this->request->data['idgrem'] = $idgrem;
	            $this->request->data['idticc'] = $idticc; 
	            $this->request->data['cuenta_desplegable'] =$valor_seg_sin_ult_punto;
		        $gre = $this->CuentasContables->patchEntity($gre, $this->request->data); 
		        $this->set("errors", []); 
		        if ($this->CuentasContables->save($gre)) {
				   $this->Flash->success(__('Registro ha sido creado.'));
				   return $this->redirect(['action' => 'index']);
				}			
	        $this->set("errors", $gre->errors());	
			
		    $this->Flash->error(__('No se puede crear registro.'));	
	      }
        }

       $this->set('gre', $gre);
	   $this->llena_lista($idticc = "");   
    }
    public function llena_lista( $idticc) {
	    $conn = ConnectionManager::get('default');
	    
       $sql = "select ticc.id, tacc.descripcion ||' '|| ticc.descripcion tipo_cuenta_contable
               from tipos_cuentas_contables ticc
                   ,tipos_asocs_ctas_ctbles tacc
               where ticc.idtacc = tacc.id
			   order by ticc.descripcion
			  ";

	   $stmt = $conn->execute($sql);

       $results = $stmt ->fetchAll('assoc'); 
	   $l=[];
	   $l[""] = "Seleccione opción";	   
	   foreach($results as $r) {
		   $l[$r["id"]] = $r["tipo_cuenta_contable"];		
      }
	  $this->set("tipos_cuentas_contables", $l);
	  
	}
    public function edit($id=null) {
       $session = $this->request->session();
       $cucov  = TableRegistry::get('Cucov');
       $cuentasContable = $this->CuentasContables->get($id);
       $session = $this->request->session();         
       $empresa = $session->read("empresa");   
	   $this->set('empresa', $empresa); 		   
       $idgrem = $session->read("idgrem");  
       $this->set("errors", []);
       $conn = ConnectionManager::get('default'); 
       $revision_validacion = 0;
	   if ($this->request->is(['post', 'put'])) {
	      $this->CuentasContables->patchEntity($cuentasContable, $this->request->data);
          $descripcion = $cuentasContable->descripcion;
          $idticc = $cuentasContable->idticc;
	      $sql1 = "select count(*) as cuenta_existe 
	                 from cuentas_contables 
	                where idgrem =$idgrem
	                  and descripcion = '".$descripcion."'
	                  and idticc = $idticc
	                  and id != $id
	               ";                 
		  $stmt1 = $conn->execute($sql1);		
		  $results1 = $stmt1->fetchAll('assoc'); 
		  if ($results1[0]['cuenta_existe'] != 0){
			 $revision_validacion = 1;
		     $this->Flash->error(__('Este registro ya se encuentra registrado, intente nuevamente'));
		  }
		  
		  if ($revision_validacion == 0){
			  $cuentasContable->idusuamodifregistro = $session->read("idusua");
	          $cuentasContable->fechamodifregistro = date('Y-m-d H:i:s');
		      if ($this->CuentasContables->save($cuentasContable)) {  
		         $this->Flash->success(__('Registro ha sido actualizado.'));
		         return $this->redirect(['action' => 'index']);
		      }
	
	          $this->set("errors", $gre->errors());
		      $this->Flash->error(__('No se puede modificar el registro.'));
          }

	   }

	   $this->set('cuentasContable', $cuentasContable);
	   $idticc =$cuentasContable->idticc;
	   $this->llena_lista($idticc);    
	   
    }

    public function view($id=null) {
       $session = $this->request->session();        
       $empresa = $session->read("empresa");   
	   $this->set('empresa', $empresa);   
      
	   $conn = ConnectionManager::get('default');	   
	   $sql = "select * from cucov where id=$id";	   
	   $stmt = $conn->execute($sql);
       $results = $stmt ->fetchAll('assoc');  
       $this->set('results',$results);  
       
       $separador = TableRegistry::get('Parametros');
	   $query1 = $separador->find('all')->where(['idgrem' => $session->read('idgrem')]);		
	   foreach ($query1 as $row) {		   
	      $separador=$row->valor;	
	      $this->set("separador", $separador); 	
	   }   
    }
    
    public function delete($id)
    {
       $session = $this->request->session();

       $registro = $this->CuentasContables->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

       $this->CuentasContables->save($registro);

       return $this->redirect(['action' => 'index']);

    }
	
    public function excel() {
       header('Content-Type: text/csv; charset=utf-8');
       header('Content-Disposition: attachment; filename=cuentas_contables.xlsx');
      
       $session = $this->request->session();

       require_once(APP . 'Vendor' . DS . 'PHPExcel' . DS . 'Classes' . DS. 'PHPExcel.php');      

       // Crear objeto
       $objPHPExcel = new \PHPExcel();

        //Titulos
       $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', 'Nombre')
                                           ->setCellValue('B1', 'Tipo')
                                           ->setCellValue('C1', 'Descripcion')
                                           ;
   
       $cond = [];       
       $idgrem= $session->read("idgrem"); ;
       
       $cucov  = TableRegistry::get('Cucov');
       $rows = $cucov->find('all')->where("idgrem=$idgrem")->order("cuenta_desplegable asc"); 

       $n=2;
       foreach($rows as $r) {
          $objPHPExcel->setActiveSheetIndex(0)->setCellValue("A$n", $r->Cucov__cuenta_desplegable)
                                              ->setCellValue("B$n", $r->Cucov__descripcion)
                                              ->setCellValue("C$n", $r->Cucov__tipo_cuenta_contable);

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

    
}
