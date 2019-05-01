<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class RubrosTable extends Table
{
    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        //$validator->requirePresence('username', 'password');

        return $validator;
    }

    public function obtRubros($idgrem) 
    {
       $a = $this->find('all')->where(["idgrem" => $idgrem])->order('descripcion')->toArray();
       $b = [];

       $b[""] = "Seleccione";
       foreach($a as $aa) 
         $b[$aa["id"]] = $aa["descripcion"];

       return $b;
    }
}
