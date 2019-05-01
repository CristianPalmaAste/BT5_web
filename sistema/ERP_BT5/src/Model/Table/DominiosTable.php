<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;

class DominiosTable extends Table
{
    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("id")
        ->notEmpty("id", "'Id': debe ingresar un valor en este campo.")
        ->requirePresence("descripcion")
        ->notEmpty("descripcion", "'Descripción': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['descripcion'], 'Esta descripción ya ha sido usada.'));

        return $rules;
    }
}
