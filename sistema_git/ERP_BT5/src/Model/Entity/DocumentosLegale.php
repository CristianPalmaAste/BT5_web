<?php
namespace App\Model\Entity;

use Cake\ORM\Entity;

/**
 * DocumentosLegale Entity
 *
 * @property int $id
 * @property string $nombreoriginal
 * @property string $nombreSistema
 * @property int $idTiDL
 * @property int $idEsDL
 * @property int $fecha
 * @property string $notaria
 * @property string $foja
 * @property string $responsable
 * @property string $comentario
 * @property int $fechaAviso
 * @property int $idUsua
 * @property string $xfld
 */
class DocumentosLegale extends Entity
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
