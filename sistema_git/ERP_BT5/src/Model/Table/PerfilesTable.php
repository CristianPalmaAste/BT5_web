<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class PerfilesTable extends Table{
   public function initialize(array $config){
      $this->hasMany(
         'UsuariosPerfiles',[
            'className' => 'UsuariosPerfiles',
            'foreignKey' => 'idperf',
            'joinType' => 'INNER'
         ]
      );

   }

   public function validationDefault(Validator $validator){
      return $validator;
   }

   public function obtPerfiles() {
      $a = $this->find('all')->order('descripcion')->toArray();
      $b = [];

      $b[""] = "Seleccione";

      foreach($a as $aa){
         $b[$aa["id"]] = $aa["descripcion"];
      }

      return $b;
   }
}
