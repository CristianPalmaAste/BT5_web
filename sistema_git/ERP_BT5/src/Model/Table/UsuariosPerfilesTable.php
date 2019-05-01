<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class UsuariosPerfilesTable extends Table{
   public function initialize(array $config){
      $this->setTable('usuarios_perfiles');
      $this->setDisplayField('id');
      $this->setPrimaryKey('id');
      $this->setSequence('uspe_seq');

      $this->belongsTo(
         'Usuarios',[
            'className' => 'Usuarios',
            'foreignKey' => 'idusua',
            'joinType' => 'INNER'
         ]
      );

      $this->belongsTo(
         'Perfiles',[
            'className' => 'Perfiles',
            'foreignKey' => 'idperf',
            'joinType' => 'INNER'
         ]
      );

   }

   public function validationDefault(Validator $validator){

      return $validator;
   }
}
