<?php
namespace App\Model\Table;

use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;

use Cake\Network\Session;
use Cake\ORM\Rule\IsUnique;
use Cake\Chronos\Chronos;

/**
 * DocumentosLegales Model
 *
 * @method \App\Model\Entity\DocumentosLegale get($primaryKey, $options = [])
 * @method \App\Model\Entity\DocumentosLegale newEntity($data = null, array $options = [])
 * @method \App\Model\Entity\DocumentosLegale[] newEntities(array $data, array $options = [])
 * @method \App\Model\Entity\DocumentosLegale|bool save(\Cake\Datasource\EntityInterface $entity, $options = [])
 * @method \App\Model\Entity\DocumentosLegale patchEntity(\Cake\Datasource\EntityInterface $entity, array $data, array $options = [])
 * @method \App\Model\Entity\DocumentosLegale[] patchEntities($entities, array $data, array $options = [])
 * @method \App\Model\Entity\DocumentosLegale findOrCreate($search, callable $callback = null, $options = [])
 */
class DocumentosLegalesTable extends Table{
   /**
   * Initialize method
   *
   * @param array $config The configuration for the Table.
   * @return void
   */
   public function initialize(array $config){
      parent::initialize($config);

      $this->setTable('documentos_legales');
      $this->setDisplayField('nombreoriginal');
      $this->setPrimaryKey('id');
      $this->setSequence('dole_seq');

      $this->belongsTo(
         'EmpresasD',[
            'className' => 'Empresas',
            'foreignKey' => 'idempr',
            'joinType' => 'INNER'
         ]
      );

      $this->belongsTo(
         'TiDoLeD',[
            'className' => 'TiposDocumentosLegales',
            'foreignKey' => 'idtidl',
            'joinType' => 'INNER'
         ]
      );

      $this->belongsTo(
         'EsDoLeD',[
            'className' => 'EstadosDocumentosLegales',
            'foreignKey' => 'idesdl',
            'joinType' => 'INNER'
         ]
      );
   }

   /**
   * Default validation rules.
   *
   * @param \Cake\Validation\Validator $validator Validator instance.
   * @return \Cake\Validation\Validator
   */

   public function validationDefault(Validator $validator){
      $validator
         ->allowEmpty('id', 'create');

      $validator
         ->requirePresence('nombreoriginal', 'create')
         ->notEmpty('nombreoriginal');

      $validator
         ->requirePresence('nombresistema', 'create')
         ->notEmpty('nombresistema');

      $validator
         ->integer('idtidl')
         ->requirePresence('idtidl', 'create')
         ->notEmpty('idtidl');

      $validator
         ->integer('idempr')
         ->requirePresence('idempr', 'create')
         ->notEmpty('idempr');

      $validator
         ->integer('idesdl')
         ->requirePresence('idesdl', 'create')
         ->notEmpty('idesdl');

      $validator
         ->date('fecha')
         ->requirePresence('fecha', 'create')
         ->notEmpty('fecha');

      $validator
         ->allowEmpty('notaria');

      $validator
         ->allowEmpty('foja');

      $validator
         ->requirePresence('responsable', 'create')
         ->notEmpty('responsable');

      $validator
         ->requirePresence('comentario', 'create')
         ->notEmpty('comentario');

      $validator
         ->date('fechaaviso')
         ->allowEmpty('fechaaviso');

      $validator
         ->email('emailaviso')
         ->allowEmpty('emailaviso');

      $validator
         ->allowEmpty('xfld');

      return $validator;
   }

   public function buildRules(RulesChecker $rules){
      $rules->add(new \Cake\ORM\Rule\IsUnique(['idempr','nombreoriginal']),
         [
            'errorField'   => 'nombreOriginal',
            'message'      => 'Ya existe un documento con ese nombre.'
         ]
      );

	  /*
      $rules->add(function($entity,$options){
            $fecha = Chronos::createFromFormat('d-m-Y',$entity->fecha);
            return ! $fecha->isFuture();
         },[
            'errorField'   => 'fecha',
            'message'      => 'La fecha del documento no puede estar en el futuro.'
         ]
      );

      $rules->addCreate(function($entity,$options){
         if( $entity->fechaaviso ){
            $fechaAviso = Chronos::createFromFormat('d-m-Y',$entity->fechaaviso);
            return $fechaAviso->isFuture();
         }else return true;
         },[
            'errorField'   => 'fechaaviso',
            'message'      => 'La fecha de aviso no puede estar en el pasado.'
         ]
      );

      $rules->addUpdate(function($entity,$options){
         if( $entity->fechaaviso && $entity->avisodado == 'N' ){
            $fechaAviso = Chronos::createFromFormat('d-m-Y',$entity->fechaaviso);
            return $fechaAviso->isFuture();
         }else return true;
         },[
            'errorField'   => 'fechaaviso',
            'message'      => 'La fecha de aviso no puede estar en el pasado.'
         ]
      );
	  */

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
         $entity->fechacrearegistro = date('ymd His');
         return $entity;
      }else{
         $entity->idusuamodifregistro = $idusua;
         $entity->fechamodifregistro = date('ymd His');
         return $entity;
      }
   }
}
