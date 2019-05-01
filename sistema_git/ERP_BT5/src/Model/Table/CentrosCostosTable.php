<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class CentrosCostosTable extends Table
{
    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("id")
        ->notEmpty("id", "Debe ingresar un valor en este campo.")
        ->requirePresence("idempr")
        ->notEmpty("idempr", "Debe ingresar un valor en este campo.")
        ->requirePresence("nombre")
        ->notEmpty("nombre", "Debe ingresar un valor en este campo.")
        ;

        return $validator;
    }
}
