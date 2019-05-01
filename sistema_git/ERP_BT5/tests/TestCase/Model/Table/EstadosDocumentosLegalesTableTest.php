<?php
namespace App\Test\TestCase\Model\Table;

use App\Model\Table\EstadosDocumentosLegalesTable;
use Cake\ORM\TableRegistry;
use Cake\TestSuite\TestCase;

/**
 * App\Model\Table\EstadosDocumentosLegalesTable Test Case
 */
class EstadosDocumentosLegalesTableTest extends TestCase
{

    /**
     * Test subject
     *
     * @var \App\Model\Table\EstadosDocumentosLegalesTable
     */
    public $EstadosDocumentosLegales;

    /**
     * Fixtures
     *
     * @var array
     */
    public $fixtures = [
        'app.estados_documentos_legales'
    ];

    /**
     * setUp method
     *
     * @return void
     */
    public function setUp()
    {
        parent::setUp();
        $config = TableRegistry::exists('EstadosDocumentosLegales') ? [] : ['className' => EstadosDocumentosLegalesTable::class];
        $this->EstadosDocumentosLegales = TableRegistry::get('EstadosDocumentosLegales', $config);
    }

    /**
     * tearDown method
     *
     * @return void
     */
    public function tearDown()
    {
        unset($this->EstadosDocumentosLegales);

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
