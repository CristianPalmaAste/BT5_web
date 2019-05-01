<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class ImpuestosTable extends Table
{
    public $_seq='impu_seq';

    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("idpais")
        ->notEmpty("idpais", "'País': debe ingresar un valor en este campo.")
        ->requirePresence("descripcion")
        ->notEmpty("descripcion", "'Descripción': debe ingresar un valor en este campo.")
        ->requirePresence("descripcioncorta")
        ->notEmpty("descripcioncorta", "'Descripcion corta': debe ingresar un valor en este campo.")
        ->requirePresence("obligatorio")
        ->notEmpty("obligatorio", "'Obligatorio': debe ingresar un valor en este campo.")
        ->requirePresence("valor")
        ->notEmpty("valor", "'Valor': debe ingresar un valor en este campo.")
		->numeric("valor", "'Valor': debe ingresar un valor numérico en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['descripcion'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['descripcioncorta'], 'Rut ya ha sido usado.'));

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
