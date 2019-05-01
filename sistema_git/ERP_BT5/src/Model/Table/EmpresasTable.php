<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;

class EmpresasTable extends Table
{
    public function initialize(array $config)
    {
      parent::initialize($config);

      $this->setTable('empresas');
      $this->setDisplayField('id');
      $this->setPrimaryKey('id');

      $this->hasMany(
         'DocumentosLegalesE',[
            'className' => 'DocumentosLegales',
            'foreignKey' => 'idempr',
            'joinType' => 'INNER'
         ]
      );
      }

    public function validationDefault(Validator $validator)
    {
        $validator->requirePresence(["idgrem", "idpais", "idrubr", "identificador1", "identificador2",
                                     "razonsocial", "nombrefantasia", "icono"])
                  ->notEmpty(["idgrem", "idpais", "idrubr", "identificador1", "identificador2",
                                     "razonsocial", "nombrefantasia", "icono"], 'Debe ingresar un valor en este campo.')
                  ->add('identificador1', 'numeric', ['rule' => 'numeric', 'message' => 'Rut debe ser numérico.'])
                 ;

        return $validator;
    }

    public function obtEmpresas($idgrem) {
       $a = $this->find('all')->where("idgrem=$idgrem")->order('razonsocial')->toArray();
       $b = [];

       $b[""] = "Seleccione";

       foreach($a as $aa)
         $b[$aa["id"]] = $aa["razonsocial"];

       return $b;
    }

    public function buildRules(RulesChecker $rules)
    {
        $rules->add($rules->isUnique(['identificador1'],           'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['idgrem', 'razonsocial'],    'Razón social ya ha sido usado.'));
        $rules->add($rules->isUnique(['idgrem', 'nombrefantasia'], 'Nombre de fantasia ya ha sido usado.'));

        return $rules;
    }
}
