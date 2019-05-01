<?php
namespace App\Model\Entity;

use Cake\ORM\Entity;

/**
 * CotizacionesVenta Entity
 *
 * @property float $id
 * @property float $idempr
 * @property float $numero
 * @property float $idclie
 * @property string $descripcioncotizacion
 * @property float $idgere
 * @property float $idproy
 * @property float $idline
 * @property float $idceco
 * @property float $idtare
 * @property float $exento
 * @property float $afecto
 * @property float $impuestos
 * @property float $porcentajedescuento
 * @property float $montodescuento
 * @property float $total
 * @property float $diasvalidez
 * @property float $idescv
 * @property float $idusuacrearegistro
 * @property \Cake\I18n\FrozenTime $fechacrearegistro
 * @property float $idusuamodifregistro
 * @property \Cake\I18n\FrozenTime $fechamodifregistro
 * @property float $idusuaborraregistro
 * @property \Cake\I18n\FrozenTime $fechaborraregistro
 */
class CotizacionesVenta extends Entity
{

    /**
     * Fields that can be mass assigned using newEntity() or patchEntity().
     *
     * Note that when '*' is set to true, this allows all unspecified fields to
     * be mass assigned. For security purposes, it is advised to set '*' to false
     * (or remove it), and explicitly make individual fields accessible as needed.
     *
     * @var array
     */
    protected $_accessible = [
        '*' => true,
        'id' => false
    ];
}
