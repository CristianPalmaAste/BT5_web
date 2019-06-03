<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;
use Cake\Log\Log;

class RequisicionesTable extends Table
{
    public $_seq='requ_seq';

    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("idtire")
        ->notEmpty("idtire", "'Tipo de Requisición': debe ingresar un valor en este campo.")
        ->requirePresence("idusuasolicitareq")
        ->notEmpty("idusuasolicitareq", "'Usuario Solicitante': debe ingresar un valor en este campo.")
        ->requirePresence("idereq")
        ->notEmpty("idereq", "'Estado Requisición': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Id ya ha sido usado.'));
        $rules->add($rules->isUnique(['idempr','correlativo'], 'Correlativo ya ha sido usado.'));

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
          //Log::write("debug", debug($entity));		  
          return $entity;                                                 
       }else{                                                              
          $entity->idusuamodifregistro = $idusua;                        
          $entity->fechamodifregistro = date('ymd His');
		  //Log::write("debug", debug($entity));		  
          return $entity;
       }
    }
}
