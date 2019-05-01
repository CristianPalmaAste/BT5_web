<?php
namespace App\Test\TestCase\Model\Table;

use App\Model\Table\TiposDocumentosLegalesTable;
use Cake\ORM\TableRegistry;
use Cake\TestSuite\TestCase;

/**
 * App\Model\Table\TiposDocumentosLegalesTable Test Case
 */
class TiposDocumentosLegalesTableTest extends TestCase
{

    /**
     * Test subject
     *
     * @var \App\Model\Table\TiposDocumentosLegalesTable
     */
    public $TiposDocumentosLegales;

    /**
     * Fixtures
     *
     * @var array
     */
    public $fixtures = [
        'app.tipos_documentos_legales'
    ];

    /**
     * setUp method
     *
     * @return void
     */
    public function setUp()
    {
        parent::setUp();
        $config = TableRegistry::exists('TiposDocumentosLegales') ? [] : ['className' => TiposDocumentosLegalesTable::class];
        $this->TiposDocumentosLegales = TableRegistry::get('TiposDocumentosLegales', $config);
    }

    /**
     * tearDown method
     *
     * @return void
     */
    public function tearDown()
    {
        unset($this->TiposDocumentosLegales);

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
