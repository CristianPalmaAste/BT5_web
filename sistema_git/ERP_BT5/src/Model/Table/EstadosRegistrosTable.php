<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class EstadosRegistrosTable extends Table
{
    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("id")
        ->notEmpty("id", "¡Debe ingresar un valor en este campo 'Id'!.")
        ->requirePresence("descripcion")
        ->notEmpty("descripcion", "¡Debe ingresar un valor en este campo 'Descripción'!.")
        ;

        return $validator;
    }
}
