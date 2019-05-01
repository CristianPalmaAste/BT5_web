<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;

class ValoresDominiosTable extends Table
{
    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("id")
        ->notEmpty("id", "'id': debe ingresar un valor en este campo.")
        ->requirePresence("iddomi")
        ->notEmpty("iddomi", "'iddomi': debe ingresar un valor en este campo.")
        ->requirePresence("descripcion")
        ->notEmpty("descripcion", "'descripcion': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['iddomi','descripcion'], 'Rut ya ha sido usado.'));

        return $rules;
    }
}
