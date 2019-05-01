<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class NotasVentasTable extends Table
{
    public $_seq='nove_seq';

    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("idempr")
        ->notEmpty("idempr", "'idempr': debe ingresar un valor en este campo.")
        ->requirePresence("numero")
        ->notEmpty("numero", "'numero': debe ingresar un valor en este campo.")
        ->requirePresence("idclie")
        ->notEmpty("idclie", "'idclie': debe ingresar un valor en este campo.")
        ->requirePresence("descripcionnotaventa")
        ->notEmpty("descripcionnotaventa", "'descripcionnotaventa': debe ingresar un valor en este campo.")
        //->requirePresence("porcentajedescuento")
        //->notEmpty("porcentajedescuento", "'porcentajedescuento': debe ingresar un valor en este campo.")
        //->requirePresence("montodescuento")
        //->notEmpty("montodescuento", "'montodescuento': debe ingresar un valor en este campo.")
        //->requirePresence("impuestos")
        //->notEmpty("impuestos", "'impuestos': debe ingresar un valor en este campo.")
        //->requirePresence("total")
        //->notEmpty("total", "'total': debe ingresar un valor en este campo.")
        ->requirePresence("idesnv")
        ->notEmpty("idesnv", "'idesnv': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['idempr','numero'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['idempr','idcove'], 'Rut ya ha sido usado.'));

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
