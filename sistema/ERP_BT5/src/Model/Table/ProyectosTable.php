<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;

class ProyectosTable extends Table
{
    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("id")
        ->notEmpty("id", "'ID': debe ingresar un valor en este campo.")
        ->requirePresence("idempr")
        ->notEmpty("idempr", "'Empresa': debe ingresar un valor en este campo.")
        ->requirePresence("nombre")
        ->notEmpty("nombre", "'Nombre': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['idempr','nombre'], 'Rut ya ha sido usado.'));

        return $rules;
    }
}
