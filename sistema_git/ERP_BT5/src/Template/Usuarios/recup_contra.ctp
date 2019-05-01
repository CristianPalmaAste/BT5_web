<div>
   <div class="col-md-4  col-md-offset-4">
      <article class="widget widget__login">
         <header class="widget__header">
            <div class="widget__title">
               <i class="pe-7s-help1"></i>Recuperar Contrase&ntilde;a</h1>
            </div>
         </header>
         <div class="widget__content">
            <?=$this->form->create("Usuarios");?>
            <label class="stacked-label" for="username"><i class="pe-7f-user"></i></label>
            <?=$this->form->text('username', array(
               'class'        => 'stacked-input upper',
               'size'         => 12,
               'maxlength'    => 50,
               "placeholder"  => "Escriba su nombre de usuario o correo de sistema",
               "id"           => "username",
               "required"     => "required"
            ));?>

            <button type="submit">Recuperar contrase&ntilde;a</button>
            <button type="button" onclick="window.history.back();">Cancelar</button>
            <?=$this->form->end();?>
         </div>
      </article>
   </div>
</div>
