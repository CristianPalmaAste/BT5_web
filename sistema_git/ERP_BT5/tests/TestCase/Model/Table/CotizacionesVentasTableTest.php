<?php
namespace App\Test\TestCase\Model\Table;

use App\Model\Table\CotizacionesVentasTable;
use Cake\ORM\TableRegistry;
use Cake\TestSuite\TestCase;

/**
 * App\Model\Table\CotizacionesVentasTable Test Case
 */
class CotizacionesVentasTableTest extends TestCase
{

    /**
     * Test subject
     *
     * @var \App\Model\Table\CotizacionesVentasTable
     */
    public $CotizacionesVentas;

    /**
     * Fixtures
     *
     * @var array
     */
    public $fixtures = [
        'app.cotizaciones_ventas'
    ];

    /**
     * setUp method
     *
     * @return void
     */
    public function setUp()
    {
        parent::setUp();
        $config = TableRegistry::exists('CotizacionesVentas') ? [] : ['className' => CotizacionesVentasTable::class];
        $this->CotizacionesVentas = TableRegistry::get('CotizacionesVentas', $config);
    }

    /**
     * tearDown method
     *
     * @return void
     */
    public function tearDown()
    {
        unset($this->CotizacionesVentas);

        parent::tearDown();
    }

    /**
     * Test initialize method
     *
     * @return void
     */
    public function testInitialize()
    {
        $this->markTestIncomplete('Not implemented yet.');
    }

    /**
     * Test validationDefault method
     *
     * @return void
     */
    public function testValidationDefault()
    {
        $this->markTestIncomplete('Not implemented yet.');
    }
}
