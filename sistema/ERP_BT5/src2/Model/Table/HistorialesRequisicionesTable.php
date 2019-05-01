<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class HistorialesRequisicionesTable extends Table
{
    public $_seq='hire_seq';

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
        $rules->add($rules->isUnique(['id'], 'Rut ya ha sido usado.'));

        return $rules;
    }

    public function beforeSave($event, $entity, $options){              
       $session = new Session();                                          
       $idusua = $session->read('idusua');                               
       if( $entity->isNew() ){                                            
          $query = "SELECT nextval('".$this->_seq."') id";
          $id = $this->connection()->execute($query)->fetchAll('assoc');
		  
		  
          $entity->id = $id[0]['id'];                                    
		  
		  $entity->idusuacambiaestado = $idusua;
          $entity->fechacrearegistro  = date('ymd His');;                   
          return $entity;                                                 
       }else{                                                              
          $entity->idusuacambiaestado = $idusua;
          $entity->fechacrearegistro  = date('ymd His');;   
          return $entity;
       }
    }
}
