<?php
$class = 'message';
if (!empty($params['class'])) {
    $class .= ' ' . $params['class'];
}
if (!isset($params['escape']) || $params['escape'] !== false) {
    $message = h($message);
}
?>

<div class="alert alert-fixed alert-info alert-dismissible" role="alert">
   <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true"><i class="pe-7s-close"></i></span><span class="sr-only">Close</span></button>
   <div class="alert__icon pull-left">
      <i class="pe-7s-info"></i>
   </div>
   <p class="alert__text"><?= $message ?></p>
</div>
<!--
<div class="<?= h($class) ?>" onclick="this.classList.add('hidden');"></div>
-->
