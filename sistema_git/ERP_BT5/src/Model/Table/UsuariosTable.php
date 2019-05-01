<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;

class UsuariosTable extends Table{
   public function initialize(array $config){

      $this->hasMany(
         'UsuariosPerfiles',[
            'className' => 'UsuariosPerfiles',
            'foreignKey' => 'idusua',
            'joinType' => 'INNER'
         ]
      );

      $this->belongsTo(
         'UsuarioPersona',[
            'className' => 'Personas',
            'foreignKey' => 'idpers',
            'joinType' => 'INNER'
         ]
      );
   }

   public function validationDefault(Validator $validator){
      $validator->requirePresence('username', 'password', 'idpers', 'idesre');

      return $validator;
   }

   public function buildRules(RulesChecker $rules)
    {
        $rules->add($rules->isUnique(['username'], 'Usuario ya ha sido usado.'));

        return $rules;
    }
}
