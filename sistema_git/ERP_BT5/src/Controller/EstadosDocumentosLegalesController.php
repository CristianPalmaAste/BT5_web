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

      if( $this->request->query['sort'] ){

      }

      $estadosDocumentosLegales = $this->paginate($this->EstadosDocumentosLegales->findByIdgrem($idgrem));

      $this->set(compact('idgrem'));
      $this->set(compact('estadosDocumentosLegales'));
      $this->set('_serialize', ['estadosDocumentosLegales']);
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
      $this->request->allowMethod(['post', 'delete']);
      $estadosDocumentosLegale = $this->EstadosDocumentosLegales->get($id);
      if ($this->EstadosDocumentosLegales->delete($estadosDocumentosLegale)) {
         $this->Flash->success(__('El estado de documento legal ha sido eliminado.'));
      } else {
         $this->Flash->error(__('El estado de documento legal no ha sido eliminado.'));
      }

      return $this->redirect(['action' => 'index']);
   }
}
