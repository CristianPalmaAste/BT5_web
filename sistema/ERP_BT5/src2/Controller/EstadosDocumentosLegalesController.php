<?php
namespace App\Controller;

use App\Controller\AppController;

/**
 * TiposDocumentosLegales Controller
 *
 * @property \App\Model\Table\TiposDocumentosLegalesTable $TiposDocumentosLegales
 *
 * @method \App\Model\Entity\TiposDocumentosLegale[] paginate($object = null, array $settings = [])
 */
class EstadosDocumentosLegalesController extends AppController{

   /**
   * Index method
   *
   * @return \Cake\Http\Response|void
   */
   public function index(){
 	  $session = $this->request->session();
      $idgrem = $session->read("idgrem");

        $gre = $this->EstadosDocumentosLegales->newEntity();
        
        if ($this->request->is('post')) {
           $gre = $this->EstadosDocumentosLegales->patchEntity($gre, $this->request->data);
        }             
		
		$this->set("gre", $gre);
		$cond["idusuaborraregistro is"] = null;

       
        $cond['idgrem']=$idgrem;

       

        //if ($gre->id!=null) $cond["id"] = $gre->id;
        //if ($gre->idempr!=null) $cond["idempr"] = $gre->idempr;
        //if ($gre->nombrecorto!=null) $cond["nombrecorto like"] = $gre->nombrecorto."%";
        //if ($gre->nombrelargo!=null) $cond["nombrelargo like"] = $gre->nombrelargo."%";
        //if ($gre->descripcion!=null) $cond["descripcion like"] = $gre->descripcion."%";
        //if ($gre->valor!=null) $cond["valor like"] = $gre->valor."%";

 
        $EstadosDocumentosLegales = $this->paginate($this->EstadosDocumentosLegales->find('all')->where($cond));

        $this->set("estadosDocumentosLegales", $EstadosDocumentosLegales); 
	  
    }

   /**
   * View method
   *
   * @param string|null $id Tipos Documentos Legale id.
   * @return \Cake\Http\Response|void
   * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
   */
   public function view($id = null){
      $estadosDocumentosLegale = $this->EstadosDocumentosLegales->get($id);
      $this->set('estadosDocumentosLegale', $estadosDocumentosLegale);
      $this->set('_serialize', ['estadosDocumentosLegale']);
    }

   /**
   * Add method
   *
   * @return \Cake\Http\Response|null Redirects on successful add, renders view otherwise.
   */
   public function add(){
      $session = $this->request->session();
      $idgrem = $session->read("idgrem");
      $idusua = $session->read("idusua");

      $estadosDocumentosLegale = $this->EstadosDocumentosLegales->newEntity();
      if ($this->request->is('post')) {
         $estadosDocumentosLegale = $this->EstadosDocumentosLegales->patchEntity($estadosDocumentosLegale, $this->request->getData());
         if ($this->EstadosDocumentosLegales->save($estadosDocumentosLegale)) {
               $this->Flash->success(__('El estado de documento legal ha sido creado.'));
               return $this->redirect(['action' => 'index']);
         }

         if( ! empty( $estadosDocumentosLegale->errors() ) ){
            foreach( $estadosDocumentosLegale->errors() as $field => $error ){
               $this->Flash->error( __(array_values( $error ) ) );
            }
         }else{
            $this->Flash->error(__('El estado de documento legal no ha sido creado. Trate nuevamente.'));
         }
      }

      $this->set('idusua',$idusua);
      $this->set('idgrem',$idgrem);
      $this->set(compact('estadosDocumentosLegale'));
      $this->set('_serialize', ['estadosDocumentosLegale']);
   }

    /**
     * Edit method
     *
     * @param string|null $id Tipos Documentos Legale id.
     * @return \Cake\Http\Response|null Redirects on successful edit, renders view otherwise.
     * @throws \Cake\Network\Exception\NotFoundException When record not found.
     */
   public function edit($id = null){
      $estadosDocumentosLegale = $this->EstadosDocumentosLegales->get($id, ['contain' => ['GruposEmpresariales']]);

      if ($this->request->is(['patch', 'post', 'put'])) {
         $estadosDocumentosLegale = $this->EstadosDocumentosLegales->patchEntity($estadosDocumentosLegale, $this->request->getData());
         if ($this->EstadosDocumentosLegales->save($estadosDocumentosLegale)) {
               $this->Flash->success(__('El estado de documento legal ha sido guardado.'));
               return $this->redirect(['action' => 'index']);
         }
         if( ! empty( $estadosDocumentosLegale->errors() ) ){
            foreach( $estadosDocumentosLegale->errors() as $field => $error ){
               $this->Flash->error( __(array_values( $error ) ) );
            }
         }else{
            $this->Flash->error(__('El estado de documento legal no ha sido guardado. Trate nuevamente.'));
         }

      }
      $this->set(compact('estadosDocumentosLegale'));
      $this->set('_serialize', ['estadosDocumentosLegale']);
   }

    /**
     * Delete method
     *
     * @param string|null $id Tipos Documentos Legale id.
     * @return \Cake\Http\Response|null Redirects to index.
     * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
     */
   public function delete($id = null){
      //$this->request->allowMethod(['post', 'delete']);
	  
	  $session = $this->request->session();
      $registro = $this->EstadosDocumentosLegales->get($id);
	  
	  $registro->idusuaborraregistro = $session->read("idusua");
      $registro->fechaborraregistro  = date('Y-m-d H:i:s');	

	   try {
          $this->EstadosDocumentosLegales->save($registro);
		  
		  $this->Flash->success(__('Estado documento legal ha sido eliminado.'));
	   }
       catch(\Exception $e) {
		  $this->Flash->success(__('Estado documento legal no ha podido ser eliminado.'));
       }		   

      return $this->redirect(['action' => 'index']);
   }
}
