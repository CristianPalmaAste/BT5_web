<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class ProductosTable extends Table
{
    public $_seq='prod_seq';

    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("idempr")
        ->notEmpty("idempr", "'idempr': debe ingresar un valor en este campo.")
        //->requirePresence("idsfpr")
        //->notEmpty("idsfpr", "'Sub.Familia': debe ingresar un valor en este campo.")
        ->requirePresence("idtipr")
        ->notEmpty("idtipr", "'Tipo Producto': debe ingresar un valor en este campo.")
        ->requirePresence("idunmp")
        ->notEmpty("idunmp", "'Unidad Medida': debe ingresar un valor en este campo.")
        ->requirePresence("idorpr")
        ->notEmpty("idorpr", "'Origen Producto': debe ingresar un valor en este campo.")
        ->requirePresence("nombre")
        ->notEmpty("nombre", "'Nombre': debe ingresar un valor en este campo.")
        ->requirePresence("correlativoflia")
        ->notEmpty("correlativoflia", "'Correlativo': debe ingresar un valor en este campo.")
        ->requirePresence("sku")
        ->notEmpty("sku", "'Sku': debe ingresar un valor en este campo.")
        ->requirePresence("ean13")
        ->notEmpty("ean13", "'Ean13': debe ingresar un valor en este campo.")
        ->requirePresence("qr")
        ->notEmpty("qr", "'Qr': debe ingresar un valor en este campo.")
        ->requirePresence("pesounitariokg")
        ->notEmpty("pesounitariokg", "'Peso Unit.Kg': debe ingresar un valor en este campo.")
        ->requirePresence("idesre")
        ->notEmpty("idesre", "'Estado': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['idempr','nombre'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['idempr','idsfpr','correlativoflia'], 'Rut ya ha sido usado.'));

        return $rules;
    }

    public function beforeSave($event, $entity, $options){              
       $session = new Session();                                          
       $idusua = $session->read('idusua');                            
       print_r($entity);
	   
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
