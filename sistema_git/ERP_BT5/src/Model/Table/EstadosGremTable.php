<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class EstadosGremTable extends Table
{
    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("id")
        ->notEmpty("id", "¡Debe ingresar un valor en este campo 'id'!.")
        ->requirePresence("descripcion")
        ->notEmpty("descripcion", "¡Debe ingresar un valor en este campo 'descripcion'!.")
        ;

        return $validator;
    }
}
