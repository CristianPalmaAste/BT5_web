<?php
namespace App\Model\Entity;

use Cake\ORM\Entity;

class Usuario extends Entity{


   protected $_accessible = [
      '*' => true,
      'id' => false
   ];
}
