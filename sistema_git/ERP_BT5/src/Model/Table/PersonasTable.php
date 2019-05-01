<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

use Cake\Network\Session;
use Cake\ORM\Rule\IsUnique;

class PersonasTable extends Table{
   public function initialize(array $config){
   }

   public function validationDefault(Validator $validator){
      $validator
      ->requirePresence("id")
      ->notEmpty("id", "Debe ingresar un valor en este campo.")
      ->requirePresence("idgrem")
      ->notEmpty("idgrem", "Debe ingresar un valor en este campo.")
      ->requirePresence("identificador1")
      ->notEmpty("identificador1", "Debe ingresar un valor en este campo.")
      ->requirePresence("identificador2")
      ->notEmpty("identificador2", "Debe ingresar un valor en este campo.")
      ->requirePresence("primernombre")
      ->notEmpty("primernombre", "Debe ingresar un valor en este campo.")
      ->requirePresence("segundonombre")
      ->notEmpty("segundonombre", "Debe ingresar un valor en este campo.")
      ->requirePresence("apellidopaterno")
      ->notEmpty("apellidopaterno", "Debe ingresar un valor en este campo.")
      ->requirePresence("apellidomaterno")
      ->notEmpty("apellidomaterno", "Debe ingresar un valor en este campo.")
      ->requirePresence("email")
      ->notEmpty("email", "Debe ingresar un valor en este campo.")
      ->requirePresence("fechanac")
      ->notEmpty("fechanac", "Debe ingresar un valor en este campo.")
      ->requirePresence("idesci")
      ->notEmpty("idesci", "Debe ingresar un valor en este campo.")
      ->requirePresence("idsexo")
      ->notEmpty("idsexo", "Debe ingresar un valor en este campo.")
      ->requirePresence("idpais")
      ->notEmpty("idpais", "Debe ingresar un valor en este campo.")
      ;

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
