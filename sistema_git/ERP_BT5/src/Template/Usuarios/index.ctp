<div>
   <div class="col-md-4  col-md-offset-4">
      <article class="widget widget__login">
         <header class="widget__header">
            <div class="widget__title">
               <div class="main-logo"><img src="img/bt5_logo_small.png"></div>
            </div>
         </header>
         <div class="widget__content">
            <?=$this->form->create("Usuarios");?>
            <label class="stacked-label" for="username"><i class="pe-7f-user"></i></label>
            <?=$this->form->text('username', array(
               'class'        => 'stacked-input upper',
               'size'         => 12,
               'maxlength'    => 50,
               "placeholder"  => "Usuario",
               "id"           => "username",
               "required"     => "required"
            ));?>
            <label class="stacked-label" for="password"><i class="pe-7f-lock"></i></label>
            <?=$this->form->text('password', array(
               'class'        => 'stacked-input upper',
               'id'           => 'password',
               'type'         => 'password',
               'size'         => 12,
               'placeholder'  => 'Contraseña',
               'maxlength'    => 12,
               "required"     => "required"
            ));?>

            <button type="submit">Entrar</button>

            <div class="footer"><br/><br/><br/></div>
            <footer class="widget__header">
               <div class="widget__title">
                  <div class="main-logo">
                     <i class="pe-7s-help1"></i>
                     <?= $this->Html->link('¿Olvidó su Contraseña?', "/usuarios/recupContra",array('class'=>'stacked-input','style'=>'color:#FFFFFF;')) ?>
                  </div>
               </div>
            </footer>

            <?=$this->form->end();?>
         </div>
      </article>
   </div>
</div>

