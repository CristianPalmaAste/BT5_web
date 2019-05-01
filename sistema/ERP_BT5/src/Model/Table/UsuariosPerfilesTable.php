<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;

class UsuariosPerfilesTable extends Table
{
    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("id")
        ->notEmpty("id", "'id': debe ingresar un valor en este campo.")
        ->requirePresence("idusua")
        ->notEmpty("idusua", "'idusua': debe ingresar un valor en este campo.")
        ->requirePresence("idperf")
        ->notEmpty("idperf", "'idperf': debe ingresar un valor en este campo.")
        ->requirePresence("idgrem")
        ->notEmpty("idgrem", "'idgrem': debe ingresar un valor en este campo.")
        ->requirePresence("idempr")
        ->notEmpty("idempr", "'idempr': debe ingresar un valor en este campo.")
        ->requirePresence("idesre")
        ->notEmpty("idesre", "'idesre': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['idusua','idperf','idgrem'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['idusua','idperf','idempr'], 'Rut ya ha sido usado.'));

        return $rules;
    }
}
