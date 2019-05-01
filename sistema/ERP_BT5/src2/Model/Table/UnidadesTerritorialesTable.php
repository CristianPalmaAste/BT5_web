<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class UnidadesTerritorialesTable extends Table
{
    public $_seq='';

    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("idpais")
        ->notEmpty("idpais", "'País': debe ingresar un valor en este campo.")
        ->requirePresence("nombre")
        ->notEmpty("nombre", "'Nombre': debe ingresar un valor en este campo.")
        ->requirePresence("profundidad")
        ->notEmpty("profundidad", "'Profundidad': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['idpais','iduntepadre','nombre'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['iduntepadre','orden'], 'Rut ya ha sido usado.'));

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
}
