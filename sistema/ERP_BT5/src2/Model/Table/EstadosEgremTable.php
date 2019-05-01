<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class EstadosEgremTable extends Table
{
    public $_seq='';

    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {

        return $rules;
    }

    public function beforeSave($event, $entity, $options){              
       $session = new Session();                                          
       $idusua = $session->read('idusua');                               
       if( $entity->isNew() ){                                            
          $query = "SELECT nextval('".$this->_seq."') id";
          $id = $this->connection()->execute($query)->fetchAll('assoc');
          $entity->id = $id[0]['id'];                                    
          $entity->idusuacrearegistro = $idusua;                         
          $entity->fechacrearegistro = date('ymd His');                   
          return $entity;                                                 
       }else{                                                              
          $entity->idusuamodifregistro = $idusua;                        
          $entity->fechamodifregistro = date('ymd His');
          return $entity;
       }
    }
	
	public function obtEstadosGrem() {
	   $l=[];
	   $l[""]="";
	   
	   $r = $this->find('all')->order('descripcion');
	   foreach($r as $s)
	      $l[$s["id"]] = $s["descripcion"];
		  
	   return $l;
	}
}
