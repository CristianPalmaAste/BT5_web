<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class SubFamiliasProductosTable extends Table
{
    public $_seq='sfpr_seq';

    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("idfapr")
        ->notEmpty("idfapr", "'Familia': debe ingresar un valor en este campo.")
        ->requirePresence("cod_sub_familia")
        ->notEmpty("cod_sub_familia", "'Código': debe ingresar un valor en este campo.")
        ->requirePresence("descripcion")
        ->notEmpty("descripcion", "'Descripción': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'ID ya ha sido usado.'));
        $rules->add($rules->isUnique(['idfapr','cod_sub_familia'], 'Código ya ha sido usado.'));
        $rules->add($rules->isUnique(['idfapr','descripcion'], 'Descripción ya ha sido usada.'));

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
    public function obtSubFamilias() {
           $l=[];
           $l[""]="";

           $r = $this->find('all')->order('descripcion')->toArray();
           foreach($r as $s)
              $l[$s["id"]] = $s["descripcion"];
           return $l;
    }

}
