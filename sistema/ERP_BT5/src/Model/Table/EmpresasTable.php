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
        $validator
		->requirePresence("idgrem") 
		->notEmpty("idgrem", 'Debe ingresar el Grupo Empresarial.')
		->requirePresence("idpais") 
		->notEmpty("idpais", 'Debe ingresar el País.')
		->requirePresence("idrubr") 
		->notEmpty("idrubr", 'Debe ingresar el Rubro.')
		->requirePresence("identificador1") 
		->notEmpty("identificador1", 'Debe ingresar el Rut.')
		->requirePresence("identificador2")
		->notEmpty("identificador2", 'Debe ingresar el Dígito Verificador.')
        ->requirePresence("razonsocial") 
		->notEmpty("razonsocial", 'Debe ingresar la Razón Social.')
		->requirePresence("nombrefantasia") 
		->notEmpty("nombrefantasia", 'Debe ingresar el Nombre de Fantasía.')
		//->requirePresence("icono")
        //->notEmpty("icono", 'Debe ingresar el Ícono.')          
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
        $rules->add($rules->isUnique(['identificador1'],           'Rut ya ha sido usado en Empresa.'));
        $rules->add($rules->isUnique(['idgrem', 'razonsocial'],    'Razón social ya ha sido usado en Empresa.'));
        $rules->add($rules->isUnique(['idgrem', 'nombrefantasia'], 'Nombre de fantasia ya ha sido usado en Empresa.'));

        return $rules;
    }
}
