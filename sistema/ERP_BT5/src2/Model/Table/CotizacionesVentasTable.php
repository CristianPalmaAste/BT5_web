<?php
namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;
use Cake\Network\Session;

class CotizacionesVentasTable extends Table
{
    public $_seq='cove_seq';

    public function initialize(array $config)
    {
       
    }

    public function validationDefault(Validator $validator)
    {
        $validator
        ->requirePresence("idempr")
        ->notEmpty("idempr", "'idempr': debe ingresar un valor en este campo.")
        //->requirePresence("numero")
        //->notEmpty("numero", "'Número': debe ingresar un valor en este campo.")
        //->requirePresence("idclie")
        //->notEmpty("idclie", "'idclie': debe ingresar un valor en este campo.")
        //->requirePresence("descripcioncotizacion")
        //->notEmpty("descripcioncotizacion", "'Descripción cotizado': debe ingresar un valor en este campo.")
		//->requirePresence("fechacotizacion")
        //->notEmpty("fechacotizacion", "Debe ingresar un valor en 'Fecha'.")
	    //->add('fechcotizacion', 'validDate', [
        //        'rule' => 'isValidDate',
        //        'message' => __('Fecha inválida, debe venir en formato DD/MM/AAAA.'),
        //        'provider' => 'table',
        //    ])
        //->requirePresence("porcentajedescuento")
        //->notEmpty("porcentajedescuento", "'%Descto.': debe ingresar un valor en este campo.")
        //->requirePresence("montodescuento")
        //->notEmpty("montodescuento", "'Mto.Descto.': debe ingresar un valor en este campo.")
        //->requirePresence("impuestos")
        //->notEmpty("impuestos", "'Valor Imptos.': debe ingresar un valor en este campo.")
        //->requirePresence("total")
        //->notEmpty("total", "'Total': debe ingresar un valor en este campo.")
        //->requirePresence("diasvalidez")
        //->notEmpty("diasvalidez", "'Días Validez': debe ingresar un valor en este campo.")
        //->requirePresence("idescv")
        //->notEmpty("idescv", "'Estado': debe ingresar un valor en este campo.")
        ;

        return $validator;
    }
	
	public function isValidDate($date, array $context)
    {
		$date = str_replace('-', '/', $date);
		$date = str_replace('.', '/', $date);
		
        if(preg_match("/^(\d{1,2})\/(\d{1,2})\/(\d{2,4})$/", $date, $matches))
        {
          if(checkdate($matches[2], $matches[1], $matches[3]))
          {
             return true; 
          }
        }
		else 
		   return false;
    }

    public function buildRules(RulesChecker $rules) {
        $rules->add($rules->isUnique(['id'], 'Rut ya ha sido usado.'));
        $rules->add($rules->isUnique(['idempr','numero'], 'Rut ya ha sido usado.'));

        return $rules;
    }

    public function beforeSave($event, $entity, $options){              
       $session = new Session();                                          
       $idusua = $session->read('idusua');                               
	   
	   	if (!isset($entity->exento)    || $entity->exento=="") $entity->exento = 0;
		if (!isset($entity->afecto)    || $entity->afecto=="") $entity->afecto = 0;
		if (!isset($entity->impuestos) || $entity->impuestos=="") $entity->impuestos = 0;
		
		//print_r($entity);
		 
       if( $entity->isNew() ){                                            
          $query = "SELECT nextval('".$this->_seq."') id";
          $id = $this->connection()->execute($query)->fetchAll('assoc');
          $entity->id = $id[0]['id'];                                    
          $entity->idusuacrearegistro = $idusua;                         
          $entity->fechacrearegistro = date('ymd His');                   
          return $entity;                                                 
       }else{                                                              
          $entity->idusuamodifregistro = $idusua;                        
          $entity->fechamodifregistro = date('ymd His');
          return $entity;
       }
    }
}
