<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;
 
class CuentasContablesTable extends Table
{ 
	public $_seq='cuco_seq';
    public function initialize(array $config)
    {
    
    }

    /**
     * Default validation rules.
     *
     * @param \Cake\Validation\Validator $validator Validator instance.
     * @return \Cake\Validation\Validator
     */
    public function validationDefault(Validator $validator)
    {
        $validator
            ->decimal('id')
            ->allowEmpty('id', 'create');

        $validator
            ->decimal('idgrem')
            ->requirePresence('idgrem', 'create')
            ->notEmpty('idgrem');

        $validator
            ->requirePresence('segmento1', 'create')
            ->notEmpty('segmento1');

        $validator
            ->allowEmpty('segmento2');

        $validator
            ->allowEmpty('segmento3');

        $validator
            ->allowEmpty('segmento4');

        $validator
            ->allowEmpty('segmento5');

        $validator
            ->allowEmpty('segmento6');

        $validator
            ->allowEmpty('segmento7');

        $validator
            ->allowEmpty('segmento8');

        $validator
            ->requirePresence('descripcion', 'create')
            ->notEmpty('descripcion');

       $validator
            ->decimal('idusuamodifregistro')
            ->allowEmpty('idusuamodifregistro');

        $validator
            ->dateTime('fechamodifregistro')
            ->allowEmpty('fechamodifregistro');

        $validator
            ->decimal('idusuaborraregistro')
            ->allowEmpty('idusuaborraregistro');

        $validator
            ->dateTime('fechaborraregistro')
            ->allowEmpty('fechaborraregistro');
        $validator
            ->requirePresence('idticc', 'create')
            ->notEmpty('idticc');
        return $validator;
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
