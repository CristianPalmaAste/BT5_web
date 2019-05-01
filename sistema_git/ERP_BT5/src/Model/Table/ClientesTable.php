<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;

class ClientesTable extends Table
{
    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("id")
        ->notEmpty("id", "'id': debe ingresar un valor en este campo.")
        ->requirePresence("idgrem")
        ->notEmpty("idgrem", "'idgrem': debe ingresar un valor en este campo.")
        ->requirePresence("identificador1")
        ->notEmpty("identificador1", "'Rut': debe ingresar un valor en este campo.")
        ->requirePresence("identificador2")
        ->notEmpty("identificador2", "'Dv': debe ingresar un valor en este campo.")
        ->requirePresence("idticl")
        ->notEmpty("idticl", "'Tipo ': debe ingresar un valor en este campo.")
        ->requirePresence("razonsocial")
        ->notEmpty("razonsocial", "'Razón social': debe ingresar un valor en este campo.")
        ->requirePresence("nombrefantasia")
        ->notEmpty("nombrefantasia", "'Nombre fantasía': debe ingresar un valor en este campo.")
        ->requirePresence("primernombre")
        ->notEmpty("primernombre", "'Primer nombre': debe ingresar un valor en este campo.")
        ->requirePresence("segundonombre")
        ->notEmpty("segundonombre", "'Segundo nombre': debe ingresar un valor en este campo.")
        ->requirePresence("apellidopaterno")
        ->notEmpty("apellidopaterno", "'Apellido paterno': debe ingresar un valor en este campo.")
        ->requirePresence("apellidomaterno")
        ->notEmpty("apellidomaterno", "'Apellido materno': debe ingresar un valor en este campo.")
        ->requirePresence("idpais")
        ->notEmpty("idpais", "'País': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['idgrem','identificador1'], 'Rut ya ha sido usado.'));

        return $rules;
    }
}
