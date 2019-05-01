<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class DetallesDoctosVtasTable extends Table
{
    public $_seq='dedv_seq';

    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("iddove")
        ->notEmpty("iddove", "'iddove': debe ingresar un valor en este campo.")
        ->requirePresence("correlativo")
        ->notEmpty("correlativo", "'correlativo': debe ingresar un valor en este campo.")
        ->requirePresence("idprod")
        ->notEmpty("idprod", "'idprod': debe ingresar un valor en este campo.")
        ->requirePresence("idserv")
        ->notEmpty("idserv", "'idserv': debe ingresar un valor en este campo.")
        ->requirePresence("cantidad")
        ->notEmpty("cantidad", "'cantidad': debe ingresar un valor en este campo.")
        ->requirePresence("preciounitario")
        ->notEmpty("preciounitario", "'preciounitario': debe ingresar un valor en este campo.")
        ->requirePresence("porcentajedescuento")
        ->notEmpty("porcentajedescuento", "'porcentajedescuento': debe ingresar un valor en este campo.")
        ->requirePresence("montodescuento")
        ->notEmpty("montodescuento", "'montodescuento': debe ingresar un valor en este campo.")
        ->requirePresence("impuestos")
        ->notEmpty("impuestos", "'impuestos': debe ingresar un valor en este campo.")
        ->requirePresence("subtotal")
        ->notEmpty("subtotal", "'subtotal': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['iddove','correlativo'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['iddove','idprod','idserv'], 'Rut ya ha sido usado.'));

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
