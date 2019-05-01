<?php
namespace App\Test\TestCase\Model\Table;

use App\Model\Table\DocumentosLegalesTable;
use Cake\ORM\TableRegistry;
use Cake\TestSuite\TestCase;

/**
 * App\Model\Table\DocumentosLegalesTable Test Case
 */
class DocumentosLegalesTableTest extends TestCase
{

    /**
     * Test subject
     *
     * @var \App\Model\Table\DocumentosLegalesTable
     */
    public $DocumentosLegales;

    /**
     * Fixtures
     *
     * @var array
     */
    public $fixtures = [
        'app.documentos_legales'
    ];

    /**
     * setUp method
     *
     * @return void
     */
    public function setUp()
    {
        parent::setUp();
        $config = TableRegistry::exists('DocumentosLegales') ? [] : ['className' => DocumentosLegalesTable::class];
        $this->DocumentosLegales = TableRegistry::get('DocumentosLegales', $config);
    }

    /**
     * tearDown method
     *
     * @return void
     */
    public function tearDown()
    {
        unset($this->DocumentosLegales);

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
