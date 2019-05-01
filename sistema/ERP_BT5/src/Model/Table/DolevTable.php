<?php
namespace App\Model\Table;

use Cake\ORM\Query;
use Cake\ORM\Table;

class DolevTable extends Table{

   public function initialize(array $config){
      parent::initialize($config);

      $this->setTable('dolev');
      $this->setDisplayField('nombreoriginal');
      $this->setPrimaryKey('id');
   }
}
