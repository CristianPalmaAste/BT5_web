<?php
namespace App\Model\Table;

use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;

/**
 * CotizacionesVentas Model
 *
 * @method \App\Model\Entity\CotizacionesVenta get($primaryKey, $options = [])
 * @method \App\Model\Entity\CotizacionesVenta newEntity($data = null, array $options = [])
 * @method \App\Model\Entity\CotizacionesVenta[] newEntities(array $data, array $options = [])
 * @method \App\Model\Entity\CotizacionesVenta|bool save(\Cake\Datasource\EntityInterface $entity, $options = [])
 * @method \App\Model\Entity\CotizacionesVenta patchEntity(\Cake\Datasource\EntityInterface $entity, array $data, array $options = [])
 * @method \App\Model\Entity\CotizacionesVenta[] patchEntities($entities, array $data, array $options = [])
 * @method \App\Model\Entity\CotizacionesVenta findOrCreate($search, callable $callback = null, $options = [])
 */
class CotizacionesVentasTable extends Table
{

    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
    public function initialize(array $config)
    {
        parent::initialize($config);

        $this->setTable('cotizaciones_ventas');
        $this->setDisplayField('id');
        $this->setPrimaryKey('id');
    }

    /**
     * Default validation rules.
     *
     * @param \Cake\Validation\Validator $validator Validator instance.
     * @return \Cake\Validation\Validator
     */
    public function validationDefault(Validator $validator)
    {
        $validator
            ->decimal('id')
            ->allowEmpty('id', 'create');

        $validator
            ->decimal('idempr')
            ->requirePresence('idempr', 'create')
            ->notEmpty('idempr');

        $validator
            ->decimal('numero')
            ->requirePresence('numero', 'create')
            ->notEmpty('numero');

        $validator
            ->decimal('idclie')
            ->requirePresence('idclie', 'create')
            ->notEmpty('idclie');

        $validator
            ->requirePresence('descripcioncotizacion', 'create')
            ->notEmpty('descripcioncotizacion');

        $validator
            ->decimal('idgere')
            ->allowEmpty('idgere');

        $validator
            ->decimal('idproy')
            ->allowEmpty('idproy');

        $validator
            ->decimal('idline')
            ->allowEmpty('idline');

        $validator
            ->decimal('idceco')
            ->allowEmpty('idceco');

        $validator
            ->decimal('idtare')
            ->allowEmpty('idtare');

        $validator
            ->decimal('exento')
            ->requirePresence('exento', 'create')
            ->notEmpty('exento');

        $validator
            ->decimal('afecto')
            ->requirePresence('afecto', 'create')
            ->notEmpty('afecto');

        $validator
            ->decimal('impuestos')
            ->requirePresence('impuestos', 'create')
            ->notEmpty('impuestos');

        $validator
            ->decimal('porcentajedescuento')
            ->requirePresence('porcentajedescuento', 'create')
            ->notEmpty('porcentajedescuento');

        $validator
            ->decimal('montodescuento')
            ->requirePresence('montodescuento', 'create')
            ->notEmpty('montodescuento');

        $validator
            ->decimal('total')
            ->requirePresence('total', 'create')
            ->notEmpty('total');

        $validator
            ->decimal('diasvalidez')
            ->requirePresence('diasvalidez', 'create')
            ->notEmpty('diasvalidez');

        $validator
            ->decimal('idescv')
            ->requirePresence('idescv', 'create')
            ->notEmpty('idescv');

        $validator
            ->decimal('idusuacrearegistro')
            ->requirePresence('idusuacrearegistro', 'create')
            ->notEmpty('idusuacrearegistro');

        $validator
            ->dateTime('fechacrearegistro')
            ->requirePresence('fechacrearegistro', 'create')
            ->notEmpty('fechacrearegistro');

        $validator
            ->decimal('idusuamodifregistro')
            ->allowEmpty('idusuamodifregistro');

        $validator
            ->dateTime('fechamodifregistro')
            ->allowEmpty('fechamodifregistro');

        $validator
            ->decimal('idusuaborraregistro')
            ->allowEmpty('idusuaborraregistro');

        $validator
            ->dateTime('fechaborraregistro')
            ->allowEmpty('fechaborraregistro');

        return $validator;
    }
}
