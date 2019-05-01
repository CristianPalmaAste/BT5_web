<?php
namespace App\Model\Table;

use Cake\ORM\Query;
use Cake\ORM\Table;

class CovevTable extends Table{

   public function initialize(array $config){
      parent::initialize($config);

      $this->setTable('covev');
      $this->setDisplayField('desc_cotiz');
      $this->setPrimaryKey('id');
   }
}
