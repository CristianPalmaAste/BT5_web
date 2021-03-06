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
        $validator
		->requirePresence("nombre") 
		->notEmpty("nombre", 'Debe ingresar el campo "Nombre".')
		->requirePresence("alias") 
		->notEmpty("alias",  'Debe ingresar el campo "Alias".')
		//->requirePresence("icono") 
		//->notEmpty("icono",  'Debe ingresar el campo "Ícono".')
		->requirePresence("idpais") 
		->notEmpty("idpais", 'Debe ingresar el campo "País".')
		->requirePresence("idesge")
        ->notEmpty("idesge", 'Debe ingresar el campo "Estado".');

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
