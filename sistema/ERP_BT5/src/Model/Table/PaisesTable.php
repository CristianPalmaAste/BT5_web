<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class PaisesTable extends Table
{
    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        //$validator->requirePresence('username', 'password');

        return $validator;
    }

    public function obtPaises() 
    {
       $a = $this->find('all')->order('nombre')->toArray();
       $b = [];

       $b[""] = "Seleccione";
       foreach($a as $aa) 
         $b[$aa["id"]] = $aa["nombre"];

       return $b;
    }

    public function obtNacionalidades() 
    {
       $a = $this->find('all')->order('nacionalidad')->toArray();
       $b = [];

       $b[""] = "Seleccione";
       foreach($a as $aa) 
         $b[$aa["id"]] = $aa["nacionalidad"];

       return $b;
    }
}
