<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class DescuentosTable extends Table
{
    public $_seq='desu_seq';

    public function initialize(array $config)
    {
		$this->belongsTo('Familia', [
                'className' => 'FamiliasProductos'
            ])
            ->setForeignKey('idfapr');
			
		$this->belongsTo('SubFam', [
                'className' => 'SubFamiliasProductos'
            ])
            ->setForeignKey('idsfpr');	
			
		$this->belongsTo('Producto', [
                'className' => 'Productos'
            ])
            ->setForeignKey('idprod');	
				
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("idfapr")
        ->notEmpty("idfapr", "'Familia': debe ingresar un valor en este campo.")
        ->notEmpty("porcentajedescuento", "'%Descuento': debe ingresar un valor en este campo.")
        ->requirePresence("idesre")
        ->notEmpty("idesre", "'Estado': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Id ya ha sido usado.'));
        $rules->add($rules->isUnique(['id', 'idfapr','idsfpr','idprod'], '¡Estos valores ya han sido usados!.'));

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
