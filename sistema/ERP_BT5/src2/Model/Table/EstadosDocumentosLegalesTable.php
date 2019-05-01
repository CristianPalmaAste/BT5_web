<?php
namespace App\Model\Table;

use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;

use Cake\ORM\Rule\IsUnique;
use Cake\Network\Session;


class EstadosDocumentosLegalesTable extends Table{
   public function initialize(array $config){
      $this->setTable('estados_documentos_legales');
      $this->setDisplayField('descripcion');
      $this->setPrimaryKey('id');
      $this->setSequence('esdl_seq');

      $this->belongsTo(
         'GruposEmpresariales',[
            'className' => 'GruposEmpresariales',
            'foreignKey' => 'idgrem',
            'joinType' => 'INNER'
         ]
      );

   }

   public function validationDefault(Validator $validator){
      $validator
         ->integer('id')
         ->allowEmpty('id', 'create');

      $validator
         ->requirePresence('descripcion', 'create')
         ->notEmpty('descripcion');

      $validator
         ->integer('idgrem')
         ->notEmpty('idgrem');

      return $validator;
   }

   public function buildRules(RulesChecker $rules){
      $rules->add($rules->isUnique(['descripcion','idgrem'],[
         'errorField' => 'descripcion',
         'message'   => 'Descripcion ya ha sido usada en este Grupo Empresarial.'
      ]));
      return $rules;
   }

   public function beforeSave($event, $entity, $options){
      $session = new Session();
      $idusua = $session->read('idusua');

      if( $entity->isNew() ){
         $query = "SELECT nextval('".$this->_seq."') id";
         $id = $this->connection()->execute($query)->fetchAll('assoc');
         $entity->id = $id[0]['id'];
         $entity->idusuacrearegistro = $idusua;
         $entity->fechacrearegistro = date('dmy His');
         return $entity;
      }else{
         $entity->idusuamodifregistro = $idusua;
         $entity->fechamodifregistro = date('dmy His');
         return $entity;
      }
   }

}
