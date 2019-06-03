<?php
namespace App\Controller;

use App\Controller\AppController;
use Cake\ORM\TableRegistry;
use Cake\Chronos\Chronos;


/**
 * DocumentosLegales Controller
 *
 * @property \App\Model\Table\DocumentosLegalesTable $DocumentosLegales
 *
 * @method \App\Model\Entity\DocumentosLegale[] paginate($object = null, array $settings = [])
 */
class DocumentosLegalesController extends AppController{
   public function initialize(){
      parent::initialize();
      $this->loadModel('TiposDocumentosLegales');
      $this->loadModel('EstadosDocumentosLegales');
      $this->loadModel('Dolev');
   }

   /**
   * Index method
   *
   * @return \Cake\Http\Response|void
   */
   public function index($idtidl=null){
      $buscar = false;
      if(count($this->request->data)){
         if( $this->request->data['search'] != '' && $this->request->data['searchBy'] != '' ){
            $buscar = true;
            $searchBy = 'f_limpia(upper('.$this->request->data['searchBy'].')) like';
            $search = "%".strtoupper( $this->translateAccents($this->request->data['search'] ) )."%";
         }
      }

      $searchOptions = array(
         'notaria'               => 'Notaría',
         'foja'                  => 'Foja',
         'responsable'           => 'Responsable',
         'nombreoriginal'        => 'Nombre Original',
         'fecha'                 => 'Fecha',
         'tipodocumentolegal'    => 'Tipo documento',
         'estadodocumentolegal'  => 'Estado documento',
         'fechaaviso'            => 'Fecha Aviso'
      );
      $session = $this->request->session();
      $idempr = $session->read("idempr");
      $idgrem = $session->read("idgrem");
      $basePath = '/media_holdings/'.$idgrem.'/';

      if(isset($this->request->query['sort']) ){
         $order = ['order'=>[$this->request->query['sort'] => $this->request->query['direction']]];
      }else{
         $order = ['order'=>['id'=>'desc']];
      }

      if( $idtidl != null ){
         $where = (['idempr'=>$idempr,'idtidl'=>$idtidl]);
      }else{
         $where = (['idempr'=>$idempr]);
      }

      if( $buscar ){
         $where = array_merge( $where, [$searchBy => $search]);
      }
	  
	  //$where["idusuaborraregistro is"] = null;

      $documentosLegales = $this->paginate($this->Dolev->find('all',$order)->where($where));

      $this->set(compact('searchOptions'));
      $this->set(compact('basePath'));
      $this->set(compact('documentosLegales'));
      $this->set('_serialize', ['documentosLegales']);
   }

   /**
   * View method
   *
   * @param string|null $id Documentos Legale id.
   * @return \Cake\Http\Response|void
   * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
   */
   public function view($id = null){
      $session = $this->request->session();
      $idempr = $session->read("idempr");
      $idgrem = $session->read("idgrem");
      $basePath = '/media_holdings/'.$idgrem.'/';

      $documento = $this->DocumentosLegales->get($id, ['contain' => ['EmpresasD','TiDoLeD','EsDoLeD']])->toArray();
      $this->set(compact('basePath'));
      $this->set('documento', $documento);
      $this->set('_serialize', ['documento']);
   }

   /**
   * Add method
   *
   * @return \Cake\Http\Response|null Redirects on successful add, renders view otherwise.
   */
   public function add(){
      $session = $this->request->session();
      $idgrem = $session->read("idgrem");
      $idempr = $session->read("idempr");
      $documentosLegale = $this->DocumentosLegales->newEntity();
      $tiposDocumentos = $this->TiposDocumentosLegales->find('list')->where(['or' => [['idgrem' => $idgrem],['idgrem' => null]]])->all()->toArray();
      $estadosDocumentos = $this->EstadosDocumentosLegales->find('list')->where(['or' => [['idgrem' => $idgrem],['idgrem' => null]]])->all()->toArray();

      if ($this->request->is('post')) {
         $basePath = $_SERVER['DOCUMENT_ROOT'].$this->request->webroot."webroot/media_holdings/$idgrem/";
         $documentosLegale = $this->DocumentosLegales->patchEntity($documentosLegale, $this->request->getData());
         $documento = $documentosLegale->fileupload;
         $docInfo = pathinfo( $documento['name'] );
         $documentosLegale->nombresistema = $idgrem.'_'.$idempr.'_'.md5(rand(100,999)).'_'.basename( $documento['tmp_name'] ).'.'.$docInfo['extension'];
         $documentosLegale->nombreoriginal = $documento['name'];

         $errorAviso = false;
         if( $documentosLegale->emailaviso == '' && ! isset( $documentosLegale->fechaaviso ) ){
            $documentosLegale->avisodado = null;
            $documentosLegale->emailaviso = null;
            $documentosLegale->fechaaviso = null;
         }elseif( $documentosLegale->emailaviso == '' && isset( $documentosLegale->fechaaviso ) ){
            $this->Flash->error(__('Si selecciona una fecha de aviso, debe ingresar el correo de aviso.'));
            $errorAviso = true;
         }elseif( $documentosLegale->emailaviso != '' && ! isset( $documentosLegale->fechaaviso ) ){
            $this->Flash->error(__('Si selecciona un correo de aviso, debe ingresar la fecha de aviso.'));
            $errorAviso = true;
         }

         if( strtoupper( $docInfo['extension'] ) == 'PDF' && ! $errorAviso ){
            if( move_uploaded_file($documento['tmp_name'], $basePath.$documentosLegale->nombresistema) ){
               if ($this->DocumentosLegales->save($documentosLegale)){
                  $this->Flash->success(__('El documento fue guardado.'));
                  return $this->redirect(['action' => 'index']);
               }
               if( ! empty( $documentosLegale->errors() ) ){
                  foreach( $documentosLegale->errors() as $field => $error ){
                     $this->Flash->error( __(array_values( $error ) ) );
                  }
               }else{
                  $this->Flash->error(__('El documento no pudo ser guardado. Intente nuevamente.'));
               }
            }
			else {
			   $this->Flash->error(__('No pude subir el documento al servidor.'));
			}
         }else{
            if( ! $errorAviso ){
               $this->Flash->error(__('El documento debe ser PDF.') );
            }
         }
      }

      $this->set('idEmpr',$idempr);
      $this->set(compact('estadosDocumentos'));
      $this->set(compact('tiposDocumentos'));
      $this->set(compact('documentosLegale'));
      $this->set('_serialize', ['documentosLegale']);
    }

   /**
   * Edit method
   *
   * @param string|null $id Documentos Legale id.
   * @return \Cake\Http\Response|null Redirects on successful edit, renders view otherwise.
   * @throws \Cake\Network\Exception\NotFoundException When record not found.
   */
   public function edit($id = null){
      $session = $this->request->session();
      $idgrem = $session->read("idgrem");
      $idempr = $session->read("idempr");

      $documento = $this->DocumentosLegales->get($id, ['contain' => ['EmpresasD','TiDoLeD','EsDoLeD']]);

      $tiposDocumentos   = $this->TiposDocumentosLegales->find('list')->where(['or' => [['idgrem' => $idgrem],['idgrem' => null]]])->all()->toArray();
      $estadosDocumentos = $this->EstadosDocumentosLegales->find('list')->where(['or' => [['idgrem' => $idgrem],['idgrem' => null]]])->all()->toArray();

      if ($this->request->is('post')){
         $documento = $this->DocumentosLegales->patchEntity($documento, $this->request->getData());
         $dirtyFields = $documento->getDirty();

         if( ! empty( $dirtyFields ) ){

            $errorAviso = false;
            if( $documento->emailaviso == '' && ! isset( $documento->fechaaviso ) ){
               $documento->avisodado = null;
               $documento->emailaviso = null;
               $documento->fechaaviso = null;
            }elseif( $documento->emailaviso == '' && isset( $documento->fechaaviso ) ){
               $this->Flash->error(__('Si selecciona una fecha de aviso, debe ingresar el correo de aviso.'));
               $errorAviso = true;
            }elseif( $documento->emailaviso != '' && ! isset( $documento->fechaaviso ) ){
               $this->Flash->error(__('Si selecciona un correo de aviso, debe ingresar la fecha de aviso.'));
               $errorAviso = true;
            }

            $actualizarArchivo = false;
            foreach( $dirtyFields as $column ){
               if( $column == 'fileupload' && $documento->fileupload['name'] != '' ){
                  $documento->nombreoriginal = $documento->fileupload;
                  $actualizarArchivo = true;
               }
            }

            if( ! $errorAviso ){
               if( $actualizarArchivo ){
                  $basePath = $_SERVER['DOCUMENT_ROOT'].$this->request->webroot."webroot/media_holdings/$idgrem/";
                  $archivo = $documento->nombreoriginal;
                  $docInfo = pathinfo( $archivo['name'] );
                  $documento->nombresistema = $idgrem.'_'.$idempr.'_'.md5(rand(100,999)).'_'.basename( $archivo['tmp_name'] ).'.'.$docInfo['extension'];
                  $documento->nombreoriginal = $archivo['name'];
                  if( move_uploaded_file($archivo['tmp_name'], $basePath.$documento->nombresistema) ){
                     if ($this->DocumentosLegales->save($documento)){
                        $this->Flash->success(__('El documento fue guardado.'));
                        return $this->redirect(['action' => 'index']);
                     }
                  }
				  else
				     $this->Flash->error(__('No pude subir el documento al servidor.') );
               }else{
                  if($this->DocumentosLegales->save($documento)){
                     $this->Flash->success(__('El documento fue guardado.'));
                     return $this->redirect(['action' => 'index']);
                  }
               }
            }
            if( ! empty( $documento->errors() ) ){
               foreach( $documento->errors() as $field => $error ){
                  $this->Flash->error( __(array_values( $error ) ) );
               }
            }else{
               $this->Flash->error(__('El documento legal no ha sido actualizado. Trate nuevamente.'));
            }

         }else{
            return $this->redirect(['action' => 'index']);
         }
      }

      $this->set(compact('tiposDocumentos'));
      $this->set(compact('estadosDocumentos'));
      $this->set('documento', $documento);
      $this->set(compact('documento'));
      $this->set('_serialize', ['documento']);
   }

    /**
     * Delete method
     *
     * @param string|null $id Documentos Legale id.
     * @return \Cake\Http\Response|null Redirects to index.
     * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
     */
    public function delete($id = null)
    {
       //$this->request->allowMethod(['post', 'delete']);
     		
	   $session = $this->request->session();

       $registro = $this->DocumentosLegales->get($id);

       $registro->idusuaborraregistro = $session->read("idusua");
       $registro->fechaborraregistro  = date('Y-m-d H:i:s');	
	   
	   //print_r($registro); 

	   try {
          $this->DocumentosLegales->save($registro);
	      $this->Flash->success(__('Documento Legal ha sido eliminado.'));
	   }
	   catch(\Exception $e) {
		  echo $e;
		  $this->Flash->success(__('Documento Legal no ha podido ser eliminado.'));
		  
		  //echo $e;
	   }

       return $this->redirect(['action' => 'index']);
    }

   public function estadisticas(){
      $session = $this->request->session();
      $idempr = $session->read("idempr");
      $idgrem = $session->read("idgrem");

      $tiposDocumentos  = TableRegistry::get('TiposDocumentosLegales');
      $documentos       = TableRegistry::get('DocumentosLegales');

      $lista = $tiposDocumentos->find('all',['fields'=>['id','color','descripcioncorta']])->where(['idgrem' => $idgrem])->toArray();
      foreach( $lista as $tido ){
         $listaTD[$tido['id']]['descripcion'] = $tido['descripcioncorta'];
         $listaTD[$tido['id']]['color'] = $tido['color'];
      }

      $query = $documentos->find();
      $res = $query->select(['total_documentos' => $query->func()->count('id'),'idtidl'])->group(['idtidl']);

      $statsHtml = '';
      $jsonStats = array();
      $totalDocs = 0;
      foreach ($res as $info){
         if( isset( $listaTD[$info['idtidl']]['descripcion'] ) ){
            $totalDocs += $info['total_documentos'];
            $jsonStats[] = array($listaTD[$info['idtidl']]['descripcion'],$info['total_documentos']);
            $statsHtml .= "
            var dp = {};
            dp[chart.titleField] = \"".$listaTD[$info['idtidl']]['descripcion']."\";
            dp[chart.valueField] = ".$info['total_documentos'].";
            dp[chart.urlField] = \"".$this->request->webroot."DocumentosLegales/index/".$info['idtidl']."\";
            dp[chart.colorField] = \"".$listaTD[$info['idtidl']]['color']."\";
            chart.dataProvider.push(dp)
            ";
         }
      }
      foreach( $jsonStats as $i => $info ){
         $jsonStats[$i][] = number_format(($info[1] / $totalDocs) * 100,1) .'%' ;
      }

      $jsonStats = json_encode($jsonStats);
      $this->set(compact('jsonStats'));
      $this->set(compact('statsHtml'));
	  $mensaje="";
      $this->set('mensaje',$mensaje);
   }
}
