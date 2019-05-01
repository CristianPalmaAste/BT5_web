<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class PerfilesProgramasTable extends Table
{
    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        //$validator->requirePresence('username', 'password');

        return $validator;
    }
}
