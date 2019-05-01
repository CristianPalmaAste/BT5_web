<?php
namespace App\Controller;

use App\Controller\AppController;

/**
 * CotizacionesVentas Controller
 *
 * @property \App\Model\Table\CotizacionesVentasTable $CotizacionesVentas
 *
 * @method \App\Model\Entity\CotizacionesVenta[] paginate($object = null, array $settings = [])
 */
class CotizacionesVentasController extends AppController
{
    public function initialize(){
        parent::initialize();
        $this->loadModel('Covev');
     }
  
    /**
     * Index method
     *
     * @return \Cake\Http\Response|void
     */
    public function index()
    {
        $buscar = false;
        if(count($this->request->data)){
           if( $this->request->data['search'] != '' && $this->request->data['searchBy'] != '' ){
              $buscar = true;
              $searchBy = 'f_limpia(upper('.$this->request->data['searchBy'].')) like';
              $search = "%".strtoupper( $this->translateAccents($this->request->data['search'] ) )."%";
           }
        }
  
        $searchOptions = array(
           'numero_cotiz'      => 'Número Cotización',
           'empresa'           => 'Empresa',
           'cliente'           => 'Cliente',
        );

        $session = $this->request->session();
        $idempr = $session->read("idempr");
        $idgrem = $session->read("idgrem");
        
        if( $this->request->query['sort'] ){
           $order = ['order'=>[$this->request->query['sort'] => $this->request->query['direction']]];
        }else{
           $order = ['order'=>['id'=>'desc']];
        }
  
        if( $buscar ){
           $where = array_merge( array(), [$searchBy => $search]);
        }
  
        $cotizaciones = $this->paginate($this->Covev->find('all',$order)->where($where));
     
        $this->set(compact('searchOptions'));
        $this->set(compact('cotizaciones'));
        $this->set('_serialize', ['cotizaciones']);
    }

    /**
     * View method
     *
     * @param string|null $id Cotizaciones Venta id.
     * @return \Cake\Http\Response|void
     * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
     */
    public function view($id = null)
    {
        $cotizacionesVenta = $this->CotizacionesVentas->get($id, [
            'contain' => []
        ]);

        $this->set('cotizacionesVenta', $cotizacionesVenta);
        $this->set('_serialize', ['cotizacionesVenta']);
    }

    /**
     * Add method
     *
     * @return \Cake\Http\Response|null Redirects on successful add, renders view otherwise.
     */
    public function add()
    {
        $cotizacionesVenta = $this->CotizacionesVentas->newEntity();
        if ($this->request->is('post')) {
            $cotizacionesVenta = $this->CotizacionesVentas->patchEntity($cotizacionesVenta, $this->request->getData());
            if ($this->CotizacionesVentas->save($cotizacionesVenta)) {
                $this->Flash->success(__('The cotizaciones venta has been saved.'));

                return $this->redirect(['action' => 'index']);
            }
            $this->Flash->error(__('The cotizaciones venta could not be saved. Please, try again.'));
        }
        $this->set(compact('cotizacionesVenta'));
        $this->set('_serialize', ['cotizacionesVenta']);
    }

    /**
     * Edit method
     *
     * @param string|null $id Cotizaciones Venta id.
     * @return \Cake\Http\Response|null Redirects on successful edit, renders view otherwise.
     * @throws \Cake\Network\Exception\NotFoundException When record not found.
     */
    public function edit($id = null)
    {
        $cotizacionesVenta = $this->CotizacionesVentas->get($id, [
            'contain' => []
        ]);
        if ($this->request->is(['patch', 'post', 'put'])) {
            $cotizacionesVenta = $this->CotizacionesVentas->patchEntity($cotizacionesVenta, $this->request->getData());
            if ($this->CotizacionesVentas->save($cotizacionesVenta)) {
                $this->Flash->success(__('The cotizaciones venta has been saved.'));

                return $this->redirect(['action' => 'index']);
            }
            $this->Flash->error(__('The cotizaciones venta could not be saved. Please, try again.'));
        }
        $this->set(compact('cotizacionesVenta'));
        $this->set('_serialize', ['cotizacionesVenta']);
    }

    /**
     * Delete method
     *
     * @param string|null $id Cotizaciones Venta id.
     * @return \Cake\Http\Response|null Redirects to index.
     * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
     */
    public function delete($id = null)
    {
        $this->request->allowMethod(['post', 'delete']);
        $cotizacionesVenta = $this->CotizacionesVentas->get($id);
        if ($this->CotizacionesVentas->delete($cotizacionesVenta)) {
            $this->Flash->success(__('The cotizaciones venta has been deleted.'));
        } else {
            $this->Flash->error(__('The cotizaciones venta could not be deleted. Please, try again.'));
        }

        return $this->redirect(['action' => 'index']);
    }
}
