<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class ProveedoresTable extends Table
{
    public $_seq='prov_seq';

    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("idgrem")
        ->notEmpty("idgrem", "'idgrem': debe ingresar un valor en este campo.")
        ->requirePresence("idpais")
        ->notEmpty("idpais", "'País': debe ingresar un valor en este campo.")
        ->requirePresence("identificador1")
        ->notEmpty("identificador1", "'Rut': debe ingresar un valor en este campo.")
        ->requirePresence("identificador2")
        ->notEmpty("identificador2", "'Dv': debe ingresar un valor en este campo.")
        ->requirePresence("idtipp")
        ->notEmpty("idtipp", "'Tipo Proveedor': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['idgrem','identificador1'], 'Rut ya ha sido usado.'));

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
