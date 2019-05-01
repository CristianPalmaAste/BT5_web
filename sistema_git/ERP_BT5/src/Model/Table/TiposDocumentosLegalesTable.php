<?php
namespace App\Model\Table;

use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;

use Cake\ORM\Rule\IsUnique;
use Cake\Network\Session;

/**
 * TiposDocumentosLegales Model
 *
 * @method \App\Model\Entity\TiposDocumentosLegale get($primaryKey, $options = [])
 * @method \App\Model\Entity\TiposDocumentosLegale newEntity($data = null, array $options = [])
 * @method \App\Model\Entity\TiposDocumentosLegale[] newEntities(array $data, array $options = [])
 * @method \App\Model\Entity\TiposDocumentosLegale|bool save(\Cake\Datasource\EntityInterface $entity, $options = [])
 * @method \App\Model\Entity\TiposDocumentosLegale patchEntity(\Cake\Datasource\EntityInterface $entity, array $data, array $options = [])
 * @method \App\Model\Entity\TiposDocumentosLegale[] patchEntities($entities, array $data, array $options = [])
 * @method \App\Model\Entity\TiposDocumentosLegale findOrCreate($search, callable $callback = null, $options = [])
 */
class TiposDocumentosLegalesTable extends Table{

   /**
   * Initialize method
   *
   * @param array $config The configuration for the Table.
   * @return void
   */
   public function initialize(array $config){
      parent::initialize($config);

      $this->setTable('tipos_documentos_legales');
      $this->setDisplayField('descripcion');
      $this->setPrimaryKey('id');
      $this->setSequence('tidl_seq');

      $this->hasMany(
         'DocumentosLegalesT',[
            'className' => 'DocumentosLegales',
            'foreignKey' => 'idtidl',
            'joinType' => 'INNER'
         ]
      );

      $this->belongsTo(
         'GruposEmpresariales',[
            'className' => 'GruposEmpresariales',
            'foreignKey' => 'idgrem',
            'joinType' => 'INNER'
         ]
      );

      $this->addBehavior('Timestamp', [
         'events' => [
             'Model.beforeSave' => [
                 'fechacrearegistro' => 'new'
             ]
         ]
     ]);

   }

    /**
     * Default validation rules.
     *
     * @param \Cake\Validation\Validator $validator Validator instance.
     * @return \Cake\Validation\Validator
     */
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
      $rules->add($rules->isUnique(['color','idgrem'],[
         'errorField' => 'id',
         'message'   => 'Color ya ha sido usado en este Grupo Empresarial.'
      ]));
      $rules->add($rules->isUnique(['descripcion','idgrem'],[
         'errorField' => 'descripcion',
         'message'   => 'Descripcion ya ha sido usada en este Grupo Empresarial.'
      ]));
      $rules->add($rules->isUnique(['descripcioncorta','idgrem'],[
         'errorField' => 'descripcioncorta',
         'message'   => 'Descripcion corta ya ha sido usada en este Grupo Empresarial.'
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
