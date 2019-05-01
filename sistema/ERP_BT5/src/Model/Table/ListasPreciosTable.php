<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class ListasPreciosTable extends Table
{
    public $_seq='lipr_seq';

    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("idempr")
        ->notEmpty("idempr", "'idempr': debe ingresar un valor en este campo.")
        ->requirePresence("correlativo")
        ->notEmpty("correlativo", "'Correlativo': debe ingresar un valor en este campo.")
        ->requirePresence("fechainicio")
        ->notEmpty("fechainicio", "'Fecha Inicio': debe ingresar un valor en este campo.")
        ->requirePresence("observaciones")
        ->notEmpty("observaciones", "'Observaciones': debe ingresar un valor en este campo.")
        ->requirePresence("idesre")
        ->notEmpty("idesre", "'Estado': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        //$rules->add($rules->isUnique(['idempr','idesre'], 'Solo puede haber un estado activo.'));
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
          return $entity;                                                 
       }else{                                                              
          $entity->idusuamodifregistro = $idusua;                        
          $entity->fechamodifregistro = date('ymd His');
          return $entity;
       }
    }
}
