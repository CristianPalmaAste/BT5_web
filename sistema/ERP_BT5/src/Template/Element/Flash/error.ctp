<?php
if (!isset($params['escape']) || $params['escape'] !== false) {
    $message = h($message);
}
?>

<div class="alert alert-fixed alert-danger alert-dismissible" role="alert">
   <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true"><i class="pe-7s-close"></i></span><span class="sr-only">Close</span></button>
   <div class="alert__icon pull-left">
      <i class="pe-7s-close-circle"></i>
   </div>
   <p class="alert__text"> Error: <?= $message ?></p>
</div>

<!--
<div class="message error" onclick="this.classList.add('hidden');">
   <?php /* $message */ ?>
</div>
-->
