<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;

class GruposEmpresarialesTable extends Table
{
    public function initialize(array $config)
    {
        $this->addBehavior('Timestamp');
    }

    public function validationDefault(Validator $validator)
    {
        $validator->requirePresence(["nombre", "alias", "icono", "idpais", "idesge"])
                  ->notEmpty(["nombre", "alias", "icono", "idpais", "idesge"], 'Debe ingresar un valor en este campo.');

        return $validator;
    }

    public function obtGruposEmpresariales() 
    {
       $a = $this->find('all')->order('nombre')->toArray();
       $b = [];

       $b[""] = "Seleccione";
       foreach($a as $aa) 
         $b[$aa["id"]] = $aa["nombre"];

       return $b;
    }

    public function buildRules(RulesChecker $rules)
    {
        $rules->add($rules->isUnique(['nombre'], 'Nombre ya ha sido usado.'));
        $rules->add($rules->isUnique(['alias'],  'Alias ya ha sido usado.'));

        return $rules;
    }

}
