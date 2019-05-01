<?php
namespace App\Test\Fixture;

use Cake\TestSuite\Fixture\TestFixture;

/**
 * CotizacionesVentasFixture
 *
 */
class CotizacionesVentasFixture extends TestFixture
{

    /**
     * Fields
     *
     * @var array
     */
    // @codingStandardsIgnoreStart
    public $fields = [
        'id' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => false, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'idempr' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => false, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'numero' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => false, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'idclie' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => false, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'descripcioncotizacion' => ['type' => 'string', 'length' => 1000, 'default' => null, 'null' => false, 'collate' => null, 'comment' => null, 'precision' => null, 'fixed' => null],
        'idgere' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => true, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'idproy' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => true, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'idline' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => true, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'idceco' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => true, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'idtare' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => true, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'exento' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => false, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'afecto' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => false, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'impuestos' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => false, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'porcentajedescuento' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => false, 'comment' => null, 'precision' => 5, 'unsigned' => null],
        'montodescuento' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => false, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'total' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => false, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'diasvalidez' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => false, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'idescv' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => false, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'idusuacrearegistro' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => false, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'fechacrearegistro' => ['type' => 'timestamp', 'length' => null, 'default' => null, 'null' => false, 'comment' => null, 'precision' => null],
        'idusuamodifregistro' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => true, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'fechamodifregistro' => ['type' => 'timestamp', 'length' => null, 'default' => null, 'null' => true, 'comment' => null, 'precision' => null],
        'idusuaborraregistro' => ['type' => 'decimal', 'length' => 20, 'default' => null, 'null' => true, 'comment' => null, 'precision' => null, 'unsigned' => null],
        'fechaborraregistro' => ['type' => 'timestamp', 'length' => null, 'default' => null, 'null' => true, 'comment' => null, 'precision' => null],
        '_constraints' => [
            'primary' => ['type' => 'primary', 'columns' => ['id'], 'length' => []],
            'cove_uk_01' => ['type' => 'unique', 'columns' => ['idempr', 'numero'], 'length' => []],
            'cove_fk1_usua' => ['type' => 'foreign', 'columns' => ['idusuacrearegistro'], 'references' => ['usuarios', 'id'], 'update' => 'noAction', 'delete' => 'noAction', 'length' => []],
            'cove_fk2_usua' => ['type' => 'foreign', 'columns' => ['idusuamodifregistro'], 'references' => ['usuarios', 'id'], 'update' => 'noAction', 'delete' => 'noAction', 'length' => []],
            'cove_fk3_usua' => ['type' => 'foreign', 'columns' => ['idusuaborraregistro'], 'references' => ['usuarios', 'id'], 'update' => 'noAction', 'delete' => 'noAction', 'length' => []],
            'cove_fk_ceco' => ['type' => 'foreign', 'columns' => ['idceco'], 'references' => ['centros_costos', 'id'], 'update' => 'noAction', 'delete' => 'noAction', 'length' => []],
            'cove_fk_clie' => ['type' => 'foreign', 'columns' => ['idclie'], 'references' => ['clientes', 'id'], 'update' => 'noAction', 'delete' => 'noAction', 'length' => []],
            'cove_fk_empr' => ['type' => 'foreign', 'columns' => ['idempr'], 'references' => ['empresas', 'id'], 'update' => 'noAction', 'delete' => 'noAction', 'length' => []],
            'cove_fk_escv' => ['type' => 'foreign', 'columns' => ['idescv'], 'references' => ['estados_cotizaciones_vtas', 'id'], 'update' => 'noAction', 'delete' => 'noAction', 'length' => []],
            'cove_fk_gere' => ['type' => 'foreign', 'columns' => ['idgere'], 'references' => ['gerencias', 'id'], 'update' => 'noAction', 'delete' => 'noAction', 'length' => []],
            'cove_fk_line' => ['type' => 'foreign', 'columns' => ['idline'], 'references' => ['lineas_negocios', 'id'], 'update' => 'noAction', 'delete' => 'noAction', 'length' => []],
            'cove_fk_proy' => ['type' => 'foreign', 'columns' => ['idproy'], 'references' => ['proyectos', 'id'], 'update' => 'noAction', 'delete' => 'noAction', 'length' => []],
            'cove_fk_tare' => ['type' => 'foreign', 'columns' => ['idtare'], 'references' => ['tareas', 'id'], 'update' => 'noAction', 'delete' => 'noAction', 'length' => []],
        ],
    ];
    // @codingStandardsIgnoreEnd

    /**
     * Records
     *
     * @var array
     */
    public $records = [
        [
            'id' => 1.5,
            'idempr' => 1.5,
            'numero' => 1.5,
            'idclie' => 1.5,
            'descripcioncotizacion' => 'Lorem ipsum dolor sit amet',
            'idgere' => 1.5,
            'idproy' => 1.5,
            'idline' => 1.5,
            'idceco' => 1.5,
            'idtare' => 1.5,
            'exento' => 1.5,
            'afecto' => 1.5,
            'impuestos' => 1.5,
            'porcentajedescuento' => 1.5,
            'montodescuento' => 1.5,
            'total' => 1.5,
            'diasvalidez' => 1.5,
            'idescv' => 1.5,
            'idusuacrearegistro' => 1.5,
            'fechacrearegistro' => 1514314630,
            'idusuamodifregistro' => 1.5,
            'fechamodifregistro' => 1514314630,
            'idusuaborraregistro' => 1.5,
            'fechaborraregistro' => 1514314630
        ],
    ];
}
