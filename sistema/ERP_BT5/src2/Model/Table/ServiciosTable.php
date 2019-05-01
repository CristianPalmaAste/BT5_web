<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class ServiciosTable extends Table
{
    public $_seq='serv_seq';

    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("idempr")
        ->notEmpty("idempr", "'idempr': debe ingresar un valor en este campo.")
        ->requirePresence("idtise")
        ->notEmpty("idtise", "'Tipo': debe ingresar un valor en este campo.")
        ->requirePresence("idunms")
        ->notEmpty("idunms", "'Unidad de Medida': debe ingresar un valor en este campo.")
        ->requirePresence("nombre")
        ->notEmpty("nombre", "'Nombre': debe ingresar un valor en este campo.")
        ->requirePresence("preciounitario")
        ->notEmpty("preciounitario", "'Valor Unitarios': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['idempr','nombre'], 'Rut ya ha sido usado.'));

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
