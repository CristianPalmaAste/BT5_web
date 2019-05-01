<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class ParametrosTable extends Table
{
    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("id")
        ->notEmpty("id", "¡Debe ingresar un valor en este campo 'id'!.")
        ->requirePresence("idgrem")
        ->notEmpty("idgrem", "¡Debe ingresar un valor en este campo 'idgrem'!.")
        ->requirePresence("nombrecorto")
        ->notEmpty("nombrecorto", "¡Debe ingresar un valor en este campo 'Nombre corto'!.")
        ->requirePresence("nombrelargo")
        ->notEmpty("nombrelargo", "¡Debe ingresar un valor en este campo 'Nombre largo'!.")
        ->requirePresence("descripcion")
        ->notEmpty("descripcion", "¡Debe ingresar un valor en este campo 'Descripcion'!.")
        ->requirePresence("valor")
        ->notEmpty("valor", "¡Debe ingresar un valor en este campo 'Valor'!.")
        ;

        return $validator;
    }
}
