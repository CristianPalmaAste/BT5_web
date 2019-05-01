<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;
use Cake\ORM\RulesChecker;
use Cake\Network\Session;
use Cake\ORM\Rule\IsUnique;

class PersonasTable extends Table{
   public $_seq = 'pers_seq';
   
   public function initialize(array $config){
   }

   public function validationDefault(Validator $validator){
      $validator
      ->requirePresence("idgrem")
      ->notEmpty("idgrem", "Debe ingresar un valor en este campo.")
      ->requirePresence("identificador1")
      ->notEmpty("identificador1", "Debe ingresar un valor en este campo.")
      ->requirePresence("identificador2")
      ->notEmpty("identificador2", "Debe ingresar un valor en este campo.")
      ->requirePresence("primernombre")
      ->notEmpty("primernombre", "Debe ingresar un valor en este campo.")
      ->requirePresence("apellidopaterno")
      ->notEmpty("apellidopaterno", "Debe ingresar un valor en este campo.")
      ->requirePresence("apellidomaterno")
      ->notEmpty("apellidomaterno", "Debe ingresar un valor en este campo.")
      ->requirePresence("email")
      ->notEmpty("email", "Debe ingresar un valor en este campo.")
	  ->add('email', 'validEmail', [
                'rule' => 'isValidEmail',
                'message' => __('E-Mail inválido.'),
                'provider' => 'table',
            ])
      ->requirePresence("fechanac")
      ->notEmpty("fechanac", "Debe ingresar un valor en este campo.")
	  ->add('fechanac', 'validDate', [
                'rule' => 'isValidDate',
                'message' => __('Fecha inválida, debe venir en formato DD/MM/AAAA.'),
                'provider' => 'table',
            ])
      ->requirePresence("idesci")
      ->notEmpty("idesci", "Debe ingresar un valor en este campo.")
      ->requirePresence("idsexo")
      ->notEmpty("idsexo", "Debe ingresar un valor en este campo.")
      ->requirePresence("idpais")
      ->notEmpty("idpais", "Debe ingresar un valor en este campo.")
      ;

      return $validator;
    }
	
	public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['idgrem', 'identificador1', 'identificador2'], 'Rut ya ha sido usado.'));
        //$rules->add($rules->isUnique(['idempr','numero'], 'Rut ya ha sido usado.'));

        return $rules;
    }

    public function isValidDate($date, array $context)
    {
		$date = str_replace('-', '/', $date);
		$date = str_replace('.', '/', $date);
		
        if(preg_match("/^(\d{1,2})\/(\d{1,2})\/(\d{2,4})$/", $date, $matches))
        {
          if(checkdate($matches[2], $matches[1], $matches[3]))
          {
             return true; 
          }
        }
		else 
		   return false;
    }
	
	function isValidEmail($str)
    {
       return (false !== strpos($str, "@") && false !== strpos($str, "."));
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
