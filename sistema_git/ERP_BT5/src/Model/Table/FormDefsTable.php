<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class FormDefsTable extends Table
{
    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("id")
        ->notEmpty("id", "Debe ingresar un valor en este campo.")
        ->requirePresence("caption")
        ->notEmpty("caption", "Debe ingresar un valor en este campo.")
        ->requirePresence("table_name")
        ->notEmpty("table_name", "Debe ingresar un valor en este campo.")
        ->requirePresence("ins_allowed")
        ->notEmpty("ins_allowed", "Debe ingresar un valor en este campo.")
        ->requirePresence("upd_allowed")
        ->notEmpty("upd_allowed", "Debe ingresar un valor en este campo.")
        ->requirePresence("del_allowed")
        ->notEmpty("del_allowed", "Debe ingresar un valor en este campo.")
        ;

        return $validator;
    }
}
