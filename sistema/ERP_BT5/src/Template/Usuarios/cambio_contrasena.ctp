<div>
   <div class="col-md-8  col-md-offset-2">
      <article class="widget widget__login">
         <header class="widget__header">
            <div class="widget__title">
              <i class="pe-7s-lock"></i><h3>Cambio de Contraseña</h3>
            </div>
         </header>
         <div class="widget__content">
            <?=$this->form->create("Usuarios", ["id" => "frm"]);?>
            <label class="stacked-label"  data-toggle="tooltip" title="Usuario" for="username"><i class="pe-7f-user"></i></label>
            <?=$this->form->text('username', array(
               'class'        => 'stacked-input upper',
               'size'         => 12,
               'maxlength'    => 50,
               "placeholder"  => "Usuario",
               "id"           => "username",
			   "name"         => "username",
               "required"     => "required",
			   "readonly"     => "true",
			   "value"        => $Usuarios->username
            ));?>
            <label class="stacked-label"  data-toggle="tooltip" title="Contraseña Actual" for="password"><i class="pe-7f-lock"></i></label>
            <?=$this->form->text('password', array(
               'class'        => 'stacked-input upper',
               'id'           => 'password',
               'type'         => 'password',
               'size'         => 12,
               'placeholder'  => 'Contraseña*',
               'maxlength'    => 12,
               "required"     => "required"
            ));?>
            <label class="stacked-label"  data-toggle="tooltip" title="Nueva Contraseña" for="password2"><i class="pe-7f-lock"></i></label>
            <?=$this->form->text('password2', array(
               'class'        => 'stacked-input upper',
               'id'           => 'password2',
               'type'         => 'password',
               'size'         => 12,
               'placeholder'  => 'Nueva Contraseña*',
               'maxlength'    => 12,
               "required"     => "required"
            ));?>
            <label class="stacked-label"  data-toggle="tooltip" title="Repita Nueva Contraseña" for="password3"><i class="pe-7f-lock"></i></label>
            <?=$this->form->text('password3', array(
               'class'        => 'stacked-input upper',
               'id'           => 'password3',
               'type'         => 'password',
               'size'         => 12,
               'placeholder'  => 'Re-ingrese Nueva Contraseña*',
               'maxlength'    => 12,
               "required"     => "required"
            ));?>

            <button type="submit">Grabar cambio</button>

            <div class="footer"><br/><br/><br/></div>

            <?=$this->form->end();?>
            <script language="javascript">
               document.getElementById("frm").onsubmit=function() {
                  p2 = document.getElementById("password2");
                  p3 = document.getElementById("password3");

                  if (p2.value!=p3.value) {
                     alert("Nueva contraseña y re-ingreso no coinciden!");
                     return false;
                  }
               }
            </script>
         </div>
      </article>
   </div>
</div>

