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
class TiposDocumentosLegalesController extends AppController{

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

      $tiposDocumentosLegales = $this->paginate($this->TiposDocumentosLegales->findByIdgrem($idgrem));

      $this->set(compact('idgrem'));
      $this->set(compact('tiposDocumentosLegales'));
      $this->set('_serialize', ['tiposDocumentosLegales']);
    }

   /**
   * View method
   *
   * @param string|null $id Tipos Documentos Legale id.
   * @return \Cake\Http\Response|void
   * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
   */
   public function view($id = null){
      $tiposDocumentosLegale = $this->TiposDocumentosLegales->get($id);
      $this->set('tiposDocumentosLegale', $tiposDocumentosLegale);
      $this->set('_serialize', ['tiposDocumentosLegale']);
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

      $tiposDocumentosLegale = $this->TiposDocumentosLegales->newEntity();
      if ($this->request->is('post')) {
         $tiposDocumentosLegale = $this->TiposDocumentosLegales->patchEntity($tiposDocumentosLegale, $this->request->getData());
         if ($this->TiposDocumentosLegales->save($tiposDocumentosLegale)) {
               $this->Flash->success(__('El tipo de documento legal ha sido creado.'));
               return $this->redirect(['action' => 'index']);
         }

         if( ! empty( $tiposDocumentosLegale->errors() ) ){
            foreach( $tiposDocumentosLegale->errors() as $field => $error ){
               $this->Flash->error( __(array_values( $error ) ) );
            }
         }else{
            $this->Flash->error(__('El tipo de documento legal no ha sido creado. Trate nuevamente.'));
         }
      }

      $colores = array("#808080","#FF0000","#800000","#FFFF00","#808000","#00FF00","#008000","#00FFFF","#008080","#0000FF","#000080","#FF00FF","#800080");
      $colores = '"'.implode('","',$colores).'"';

      $this->set(compact('colores'));
      $this->set('idusua',$idusua);
      $this->set('idgrem',$idgrem);
      $this->set(compact('tiposDocumentosLegale'));
      $this->set('_serialize', ['tiposDocumentosLegale']);
   }

    /**
     * Edit method
     *
     * @param string|null $id Tipos Documentos Legale id.
     * @return \Cake\Http\Response|null Redirects on successful edit, renders view otherwise.
     * @throws \Cake\Network\Exception\NotFoundException When record not found.
     */
   public function edit($id = null){
      $colores = array("#808080","#FF0000","#800000","#FFFF00","#808000","#00FF00","#008000","#00FFFF","#008080","#0000FF","#000080","#FF00FF","#800080");
      $tiposDocumentosLegale = $this->TiposDocumentosLegales->get($id, ['contain' => ['GruposEmpresariales']]);
      $selectedIndex = array_search($tiposDocumentosLegale->color,$colores);
      $colores = '"'.implode('","',$colores).'"';

      if ($this->request->is(['patch', 'post', 'put'])) {
         $tiposDocumentosLegale = $this->TiposDocumentosLegales->patchEntity($tiposDocumentosLegale, $this->request->getData());
         if ($this->TiposDocumentosLegales->save($tiposDocumentosLegale)) {
               $this->Flash->success(__('El tipo de documento legal ha sido guardado.'));
               return $this->redirect(['action' => 'index']);
         }
         if( ! empty( $tiposDocumentosLegale->errors() ) ){
            foreach( $tiposDocumentosLegale->errors() as $field => $error ){
               $this->Flash->error( __(array_values( $error ) ) );
            }
         }else{
            $this->Flash->error(__('El tipo de documento legal no ha sido guardado. Trate nuevamente.'));
         }

      }
      $this->set(compact('colores'));
      $this->set(compact('selectedIndex'));
      $this->set(compact('tiposDocumentosLegale'));
      $this->set('_serialize', ['tiposDocumentosLegale']);
   }

    /**
     * Delete method
     *
     * @param string|null $id Tipos Documentos Legale id.
     * @return \Cake\Http\Response|null Redirects to index.
     * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
     */
    public function delete($id = null)
    {
        $this->request->allowMethod(['post', 'delete']);
        $tiposDocumentosLegale = $this->TiposDocumentosLegales->get($id);
        if ($this->TiposDocumentosLegales->delete($tiposDocumentosLegale)) {
            $this->Flash->success(__('The tipos documentos legale has been deleted.'));
        } else {
            $this->Flash->error(__('The tipos documentos legale could not be deleted. Please, try again.'));
        }

        return $this->redirect(['action' => 'index']);
    }
}
