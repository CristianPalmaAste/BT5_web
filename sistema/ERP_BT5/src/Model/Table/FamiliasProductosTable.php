<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class FamiliasProductosTable extends Table
{
    public $_seq='fapr_seq';

    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("idempr")
        ->notEmpty("idempr", "'idempr': debe ingresar un valor en este campo.")
        ->requirePresence("cod_familia")
        ->notEmpty("cod_familia", "'Código': debe ingresar un valor en este campo.")
        ->requirePresence("descripcion")
        ->notEmpty("descripcion", "'Descripción': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'ID ya ha sido usado.'));
        $rules->add($rules->isUnique(['idempr','cod_familia'], 'Código ya ha sido usado.'));
        $rules->add($rules->isUnique(['idempr','descripcion'], 'Descripción ya ha sido usada.'));

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
